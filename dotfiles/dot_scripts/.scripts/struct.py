#!/usr/bin/env python3

import os
import sys
from pathlib import Path


def brace_expand(pattern: str):
    """
    Full recursive brace expansion with cartesian product support.
    Example:
        a/{b,c}/{d,e}.lua
    Produces:
        a/b/d.lua
        a/b/e.lua
        a/c/d.lua
        a/c/e.lua
    """
    if "{" not in pattern:
        return [pattern]

    start = pattern.index("{")
    depth = 0

    for i in range(start, len(pattern)):
        if pattern[i] == "{":
            depth += 1
        elif pattern[i] == "}":
            depth -= 1
            if depth == 0:
                end = i
                break

    prefix = pattern[:start]
    suffix = pattern[end + 1 :]
    body = pattern[start + 1 : end]

    parts = []
    level = 0
    current = ""

    for char in body:
        if char == "," and level == 0:
            parts.append(current)
            current = ""
        else:
            if char == "{":
                level += 1
            elif char == "}":
                level -= 1
            current += char
    parts.append(current)

    results = []
    for part in parts:
        for expanded in brace_expand(suffix):
            results.append(prefix + part + expanded)

    return results


def create_path(path_str: str):
    path = Path(os.path.expanduser(path_str))

    parts = path.parts
    is_file = "." in parts[-1]

    if is_file:
        # Create parent directories
        Path(*parts[:-1]).mkdir(parents=True, exist_ok=True)
        path.touch(exist_ok=True)
    else:
        path.mkdir(parents=True, exist_ok=True)


def main():
    if len(sys.argv) < 2:
        print("Usage: struct <patterns>")
        sys.exit(1)

    for arg in sys.argv[1:]:
        expanded = brace_expand(arg)
        for item in expanded:
            create_path(item)


if __name__ == "__main__":
    main()

