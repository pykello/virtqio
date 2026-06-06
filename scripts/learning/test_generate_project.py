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
                    statement="Show that a_nd b hold.",
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
        self.assertIn("OCR split", progress.events[-1].message)

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
