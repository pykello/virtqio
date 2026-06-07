import io
import json
import tempfile
import unittest
from pathlib import Path

import generate_project as gp


class WriteSheetTests(unittest.TestCase):
    def test_progress_reporter_formats_sheet_timing(self) -> None:
        ticks = iter([10.0, 12.25])
        stream = io.StringIO()
        reporter = gp.ProgressReporter(
            "demo",
            stream=stream,
            clock=lambda: next(ticks),
        )

        with reporter.span("extract", "PDF/OCR extraction", sheet=3):
            pass

        output = stream.getvalue()
        self.assertIn("[demo] sheet 03 extract start: PDF/OCR extraction", output)
        self.assertIn("[demo] sheet 03 extract done in 2.25s: PDF/OCR extraction", output)
        self.assertEqual(len(reporter.events), 2)
        self.assertEqual(reporter.events[1].duration_s, 2.25)

    def test_progress_reporter_writes_event_log(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            event_log = Path(tmp) / "events.jsonl"
            reporter = gp.ProgressReporter(
                "demo",
                enabled=False,
                event_log_path=event_log,
            )

            reporter.event("cache", "hit", "1 item", sheet=1)

            entries = [
                json.loads(line)
                for line in event_log.read_text().splitlines()
            ]
            self.assertEqual(entries[0]["project_id"], "demo")
            self.assertEqual(entries[0]["sheet"], 1)
            self.assertEqual(entries[0]["phase"], "cache")
            self.assertEqual(entries[0]["status"], "hit")

    def test_progress_metadata_writes_run_and_sheet_summaries(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            cache_dir = Path(tmp) / ".learning-cache" / "demo"
            source_pdf = Path(__file__)
            sheet = gp.Sheet(
                number=1,
                pdf=str(source_pdf),
                title="Sheet 1",
                section="Section",
                extracted_markdown="",
                items=[
                    gp.LearningItem(
                        kind="exercise",
                        number="1",
                        title="Exercise 1",
                        section="Section",
                        statement="Show $a = b$.",
                    )
                ],
            )
            events = [
                gp.ProgressEvent(
                    project_id="demo",
                    phase="cache-check",
                    status="done",
                    sheet=1,
                    duration_s=0.125,
                ),
            ]
            issues = [
                gp.ValidationIssue(
                    "warning",
                    str(Path(tmp) / "sheet-01.md"),
                    "sample warning",
                )
            ]

            paths = gp.write_progress_metadata(
                cache_dir,
                {"id": "demo", "title": "Demo"},
                "run-1",
                [{"sheet": 1, "pdf": str(source_pdf)}],
                [sheet],
                events,
                issues,
                options={"fast": True},
            )

            run_summary = json.loads(paths["run_summary"].read_text())
            stage = json.loads((cache_dir / "stages" / "sheet-01.json").read_text())
            self.assertEqual(run_summary["sheet_count"], 1)
            self.assertEqual(run_summary["validation"]["warnings"], 1)
            self.assertEqual(stage["item_count"], 1)
            self.assertEqual(stage["tracking_item_count"], 1)
            self.assertEqual(stage["source_signature"]["sheet"], 1)
            self.assertEqual(stage["phases"]["cache-check"]["duration_s"], 0.125)
            self.assertEqual(stage["validation"]["warnings"], 1)

    def test_auto_refinement_skips_clean_sheet(self) -> None:
        sheet = gp.Sheet(
            number=1,
            pdf="",
            title="Sheet 1",
            section="Section",
            extracted_markdown="",
            items=[
                gp.LearningItem(
                    kind="exercise",
                    number="1",
                    title="Exercise 1",
                    section="Section",
                    statement="Show $a = b$.",
                )
            ],
        )
        progress = gp.ProgressReporter("demo", enabled=False)

        selected = gp.select_sheets_for_refinement(
            {"id": "demo"},
            [sheet],
            "auto",
            progress=progress,
        )

        self.assertEqual(selected, [])
        self.assertEqual(progress.events[-1].status, "skip")

    def test_auto_refinement_queues_artifact_sheet(self) -> None:
        sheet = gp.Sheet(
            number=1,
            pdf="",
            title="Sheet 1",
            section="Section",
            extracted_markdown="",
            items=[
                gp.LearningItem(
                    kind="exercise",
                    number="1",
                    title="Exercise 1",
                    section="Section",
                    statement="Show that � b hold.",
                )
            ],
        )
        progress = gp.ProgressReporter("demo", enabled=False)

        selected = gp.select_sheets_for_refinement(
            {"id": "demo"},
            [sheet],
            "auto",
            progress=progress,
        )

        self.assertEqual([sheet.number for sheet in selected], [1])
        self.assertEqual(progress.events[-1].status, "queued")
        self.assertIn("replacement character", progress.events[-1].message)

    def test_refinement_policy_always_and_never_override_auto(self) -> None:
        sheet = gp.Sheet(
            number=1,
            pdf="",
            title="Sheet 1",
            section="Section",
            extracted_markdown="",
            items=[
                gp.LearningItem(
                    kind="exercise",
                    number="1",
                    title="Exercise 1",
                    section="Section",
                    statement="Show $a = b$.",
                )
            ],
        )

        self.assertEqual(
            gp.select_sheets_for_refinement({"id": "demo"}, [sheet], "always"),
            [sheet],
        )
        self.assertEqual(
            gp.select_sheets_for_refinement({"id": "demo"}, [sheet], "never"),
            [],
        )

    def test_chapter_problem_sections_split_overlapping_numbers(self) -> None:
        markdown = "\n".join(
            [
                "Review Questions",
                "39",
                "Review Questions",
                "1.1. True or false: A problem is ill-conditioned.",
                "1.2. Explain conditioning.",
                "",
                "Exercises",
                "41",
                "(continued review page header)",
                "",
                "Exercises",
                "1.1. Compute an error.",
                "(a) Absolute error.",
                "(b) Relative error.",
                "1.2. Let x = 1.23456 and y =",
                "1.23579.",
                "(a) How many significant digits does y - x contain?",
                "",
                "42 Chapter 1: Scientific Computing",
                "1.3. Header text should not leak into this item.",
                "",
                "Computer Problems",
                "44",
                "Computer Problems",
                "1.1. Write a program.",
            ]
        )

        items = gp.split_chapter_problem_section_items(markdown, 1)

        self.assertEqual(
            [(item.kind, item.number, item.section) for item in items],
            [
                ("review_question", "1.1", "Review Questions"),
                ("review_question", "1.2", "Review Questions"),
                ("exercise", "1.1", "Exercises"),
                ("exercise", "1.2", "Exercises"),
                ("exercise", "1.3", "Exercises"),
                ("computer_problem", "1.1", "Computer Problems"),
            ],
        )
        self.assertIn("(a) Absolute error.", items[2].statement)
        self.assertIn("1.23579", items[3].statement)
        self.assertNotIn("Chapter 1", items[4].statement)
        self.assertEqual(
            [
                gp.learning_item_output_id("demo", 1, item)
                for item in items
            ],
            [
                "demo-sheet-01-review_question-1.1",
                "demo-sheet-01-review_question-1.2",
                "demo-sheet-01-exercise-1.1",
                "demo-sheet-01-exercise-1.2",
                "demo-sheet-01-exercise-1.3",
                "demo-sheet-01-computer_problem-1.1",
            ],
        )

    def test_chapter_problem_section_uses_configured_title_as_section(self) -> None:
        source = {"title": "Chapter 1: Scientific Computing"}

        section = gp.default_sheet_section(
            source,
            "1.1. True or false: A problem is ill-conditioned.",
            1,
            "chapter_problem_sections",
        )

        self.assertEqual(section, "Chapter 1: Scientific Computing")

    def test_text_cleanup_removes_scientific_computing_headers(self) -> None:
        text = "\n".join(
            [
                "Estimate the relative error in evaluating",
                "42",
                "Chapter 1: Scientific Computing",
                "sin(x).",
                "Computer Problems",
                "101",
                "to solve the resulting system.",
                "Exercises",
                "41",
                "1.1. Compute an error.",
            ]
        )

        cleaned = gp.clean_extracted_text(text)

        self.assertNotIn("Chapter 1", cleaned)
        self.assertNotIn("Computer Problems 101", cleaned)
        self.assertIn("to solve the resulting system.", cleaned)
        self.assertIn("Exercises", cleaned)
        self.assertIn("1.1. Compute an error.", cleaned)

    def test_output_cleanup_removes_scientific_computing_headers(self) -> None:
        lines = [
            "42 Chapter 1: Scientific Computing",
            "Exercises 41",
            "Exercises",
            "Computer Problems 101 to solve the resulting system.",
            "Actual problem statement.",
        ]

        cleaned = gp.normalize_statement_for_output("\n".join(lines))

        self.assertNotIn("Chapter 1", cleaned)
        self.assertNotIn("Exercises 41", cleaned)
        self.assertNotIn("\nExercises\n", f"\n{cleaned}\n")
        self.assertNotIn("Computer Problems 101", cleaned)
        self.assertIn("to solve the resulting system.", cleaned)
        self.assertIn("Actual problem statement.", cleaned)

    def test_math_cleanup_preserves_words_and_matrix_names(self) -> None:
        statement = "Let C = A + iB and say, s and t. Is C nonsingular?"

        enhanced = gp.enhance_math_line(statement)
        output = gp.normalize_statement_for_output("$x = 0.1, a_nd 1.0$ and $i_s x$")

        self.assertNotIn("bb{C}", enhanced)
        self.assertNotIn("a_nd", output)
        self.assertNotIn("i_s", output)
        self.assertIn("and", output)
        self.assertIn("is", output)

    def test_split_item_into_parts_handles_chapter_numbered_first_part(self) -> None:
        item = gp.LearningItem(
            kind="review_question",
            number="1.24",
            title="Review Question 1.24",
            section="Review Questions",
            statement="\n".join(
                [
                    "1.24. (a) Explain forward error.",
                    " - (b) Explain backward error.",
                ]
            ),
        )

        preamble, parts = gp.split_item_into_parts(item)

        self.assertEqual(preamble, "")
        self.assertEqual([part.marker for part in parts], ["a", "b"])
        self.assertEqual(parts[0].statement, "Explain forward error.")
        self.assertEqual(parts[1].statement, "Explain backward error.")

    def test_normalize_sheet_ir_sorts_and_cleans_parts(self) -> None:
        sheet = gp.Sheet(
            number=1,
            pdf="",
            title=" Sheet 1 ",
            section=" Section ",
            extracted_markdown="",
            items=[
                gp.LearningItem(
                    kind="Exercise",
                    number=" 4 ",
                    title="",
                    section=" Section ",
                    statement="",
                    preamble=" Shared preamble. ",
                    parts=[
                        gp.LearningPart(
                            marker="(b)",
                            title="",
                            statement="(b) Second part.",
                        ),
                        gp.LearningPart(
                            marker="a",
                            title="",
                            statement="First part.",
                        ),
                    ],
                )
            ],
        )

        normalized = gp.normalize_sheet_ir(sheet)
        item = normalized.items[0]

        self.assertEqual(normalized.title, "Sheet 1")
        self.assertEqual(normalized.section, "Section")
        self.assertEqual(item.kind, "exercise")
        self.assertEqual(item.number, "4")
        self.assertEqual(item.title, "Exercise 4")
        self.assertEqual(item.preamble, "Shared preamble.")
        self.assertEqual([part.marker for part in item.parts], ["a", "b"])
        self.assertEqual(item.parts[1].title, "Exercise 4(b)")
        self.assertEqual(item.parts[1].statement, "Second part.")
        self.assertEqual(
            gp.learning_item_output_ids("demo", 1, item),
            [
                "demo-sheet-01-exercise-4-a",
                "demo-sheet-01-exercise-4-b",
            ],
        )

    def test_validate_sheet_ir_reports_duplicate_generated_ids(self) -> None:
        sheet = gp.Sheet(
            number=1,
            pdf="",
            title="Sheet 1",
            section="Section",
            extracted_markdown="",
            items=[
                gp.LearningItem(
                    kind="exercise",
                    number="1",
                    title="Exercise 1",
                    section="Section",
                    statement="First statement.",
                ),
                gp.LearningItem(
                    kind="exercise",
                    number="1",
                    title="Exercise 1",
                    section="Section",
                    statement="Duplicate statement.",
                ),
            ],
        )

        issues = gp.validate_sheet_ir({"id": "demo"}, sheet)

        self.assertTrue(any(issue.severity == "error" for issue in issues))
        self.assertTrue(any("duplicate generated item id" in issue.message for issue in issues))

    def test_validate_generated_sheet_markdown_warns_on_artifacts(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "sheet-01.md"
            path.write_text(
                "\n".join(
                    [
                        "# Sheet 1",
                        "",
                        ':::learning-item type=exercise id="demo-sheet-01-exercise-1" section="Section" status=todo title="1"',
                        "$a_nd b$",
                        ":::",
                        "",
                        ":::proof[Solution]",
                        "Write the solution here, then change the tracked item status to done.",
                        ":::",
                        "",
                    ]
                )
            )
            sheet = gp.Sheet(
                number=1,
                pdf="",
                title="Sheet 1",
                section="Section",
                extracted_markdown="",
                items=[
                    gp.LearningItem(
                        kind="exercise",
                        number="1",
                        title="Exercise 1",
                        section="Section",
                        statement="$a_nd b$",
                    )
                ],
            )

            issues = gp.validate_generated_sheet_markdown({"id": "demo"}, sheet, path)

            self.assertFalse(any(issue.severity == "error" for issue in issues))
            self.assertTrue(any("OCR split" in issue.message for issue in issues))

    def test_write_sheet_preserves_existing_solution_and_status(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            sheets_dir = Path(tmp)
            existing_path = sheets_dir / "sheet-01.md"
            existing_path.write_text(
                "\n".join(
                    [
                        "# Sheet 1",
                        "",
                        ':::learning-item type=exercise id="demo-sheet-01-exercise-1" section="Old" status=done title="1"',
                        "Old statement.",
                        ":::",
                        "",
                        ":::proof[Solution]",
                        "My handwritten proof.",
                        ":::",
                        "",
                    ]
                )
            )
            sheet = gp.Sheet(
                number=1,
                pdf="",
                title="Sheet 1",
                section="Section",
                extracted_markdown="",
                items=[
                    gp.LearningItem(
                        kind="exercise",
                        number="1",
                        title="Exercise 1",
                        section="Section",
                        statement="New statement.",
                    )
                ],
            )

            gp.write_sheet({"id": "demo"}, sheets_dir, sheet)

            output = existing_path.read_text()
            self.assertIn('status=done title="1"', output)
            self.assertIn("New statement.", output)
            self.assertIn("My handwritten proof.", output)
            self.assertNotIn("Write the solution here", output)

    def test_write_sheet_preserves_orphaned_local_work(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            sheets_dir = Path(tmp)
            existing_path = sheets_dir / "sheet-01.md"
            existing_path.write_text(
                "\n".join(
                    [
                        "# Sheet 1",
                        "",
                        ':::learning-item type=exercise id="demo-sheet-01-exercise-9" section="Old" status=partial title="9"',
                        "Old orphaned statement.",
                        ":::",
                        "",
                        ":::proof[Solution]",
                        "A partial proof worth keeping.",
                        ":::",
                        "",
                        ':::learning-item type=exercise id="demo-sheet-01-exercise-10" section="Old" status=todo title="10"',
                        "Old placeholder statement.",
                        ":::",
                        "",
                        ":::proof[Solution]",
                        "Write the solution here, then change the tracked item status to done.",
                        ":::",
                        "",
                    ]
                )
            )
            sheet = gp.Sheet(
                number=1,
                pdf="",
                title="Sheet 1",
                section="Section",
                extracted_markdown="",
                items=[
                    gp.LearningItem(
                        kind="exercise",
                        number="1",
                        title="Exercise 1",
                        section="Section",
                        statement="New statement.",
                    )
                ],
            )

            gp.write_sheet({"id": "demo"}, sheets_dir, sheet)

            output = existing_path.read_text()
            self.assertIn("## Orphaned Local Work", output)
            self.assertIn('id="demo-sheet-01-exercise-9"', output)
            self.assertIn("A partial proof worth keeping.", output)
            self.assertNotIn('id="demo-sheet-01-exercise-10"', output)


if __name__ == "__main__":
    unittest.main()
