import os
import shutil
import subprocess as sp
import sys
from pathlib import Path, PurePosixPath
from tempfile import TemporaryDirectory

sys.path.insert(0, os.path.dirname(__file__))

import common


def test_fix_gtdb_taxonomy():
    with TemporaryDirectory() as tmpdir:
        workdir = Path(tmpdir) / "workdir"
        data_path = PurePosixPath(".tests/unit/fix_gtdb_taxonomy/data")
        expected_path = PurePosixPath(".tests/unit/fix_gtdb_taxonomy/expected")

        # Copy data to the temporary workdir.
        shutil.copytree(data_path, workdir)

        # dbg
        print(
            "data/processed/Lactobacillus_delbrueckii/tables/df_gtdb_meta.csv",
            file=sys.stderr,
        )

        # Run the test job.
        sp.check_output(
            [
                "python",
                "-m",
                "snakemake",
                "data/processed/Lactobacillus_delbrueckii/tables/df_gtdb_meta.csv",
                "-f",
                "-j1",
                "--target-files-omit-workdir-adjustment",
                "--directory",
                workdir,
            ]
        )

        # Check the output byte by byte using cmp.
        # To modify this behavior, you can inherit from common.OutputChecker in here
        # and overwrite the method `compare_files(generated_file, expected_file),
        # also see common.py.
        common.OutputChecker(data_path, expected_path, workdir).check()
