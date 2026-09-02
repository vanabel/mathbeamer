#!/usr/bin/env python3
"""Update version and date strings in ustcmb.dtx without emptying the file."""
from __future__ import annotations

import pathlib
import re
import sys


def main() -> None:
    if len(sys.argv) != 4:
        raise SystemExit("usage: update-dtx-version.py NAME VERSION YYYY/MM/DD")
    name, version, date = sys.argv[1:4]
    path = pathlib.Path(name + ".dtx")
    text = path.read_text(encoding="utf-8")
    if len(text) < 1000:
        raise SystemExit(f"error: {path} is too short, refusing to rewrite")
    text = re.sub(
        r"(\\ProvidesClass\{" + re.escape(name) + r"\}\[)\d{4}/\d{2}/\d{2} v\d+\.\d+\.\d+",
        r"\g<1>" + date + " " + version,
        text,
    )
    text = re.sub(r"版本号: v\d+\.\d+\.\d+", "版本号: " + version, text)
    text = re.sub(
        r"\[\d{4}/\d{2}/\d{2} v\d+\.\d+\.\d+ 中科大数学报告模板类文件\]",
        "[" + date + " " + version + " 中科大数学报告模板类文件]",
        text,
    )
    path.write_text(text, encoding="utf-8")
    if path.stat().st_size < 1000:
        raise SystemExit("error: DTX version rewrite emptied the file")


if __name__ == "__main__":
    main()
