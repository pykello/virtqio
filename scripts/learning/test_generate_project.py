import tempfile
import unittest
from pathlib import Path

import generate_project as gp


class WriteSheetTests(unittest.TestCase):
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
