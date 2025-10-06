---
title: Django Application
summary: PROJECT_SUMMARY
  - PERSON_1
  - PERSON_2
date: DATE
some_url: PROJECT_GITHUB_URL
copyright: Copyright 2025, PROJECT_OWNER
contact: PROJECT_CONTACT
license: This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
---

# Coding Standard

## General approach

- Use github for revision control, issue tracking and management. And use the
  the recommended workflow whenever possible.
- Adherence to regression/unit testing wherever possible (make test) with a
  minimum code coverage of 80%.
- Develop in the spirit of XP/Agile, i.e. frequent releases, continuous
  integration and iterative development. The main branch should always be
  assumed to represent a working demo with all tests passing.
- If a method or function is longer than a single screen, it is probably a
  candidate for refactoring into smaller methods / functions. Writing smaller
  methods makes your code easier to read and to test.
- If you use a few lines of code in more than one place, refactor them into
  their own function.

## Platform support

Currently the following platforms should be supported:

- OSX - latest release
- Linux - Ubuntu current LTS
- Windows

## Compliance

- In the case of Python, it follows PEP8, enforced automatically using Ruff on
  check or on save file.
- The Ruff configuration applies standard PEP8 conventions, with a line length
  of 100 characters and an indentation width of 4 spaces.
- Some docstring formatting checks (e.g. D200–D415) and whitespace checks (e.g.
  E203) have been disabled for better compatibility with modern formatting
  tools.

## Python documentation guide

- Docstrings should follow the Google Python Style Guide convention.

```python
def sum(x: int, y: int) -> int:
    """Returns the sum of two numbers.

    Args:
        x (int): First number.
        y (int): Second number.

    Returns:
        int: The sum of the two numbers.
    """
    return x + y

```

- Each public function, class, and module should include a descriptive
  docstring that explains its purpose, arguments, and return values.
- Missing docstring warnings are ignored for migration and settings files.

## Code quality and linting

- Code must pass a Ruff linting validation. You can test this using the
  command:

```bash
ruff check .
```

- In specific cases, you may temporarily disable a linting rule for a line or
  block using the # noqa comment, for example:

```python
# noqa: F401
```

This should be used sparingly and only when necessary (e.g., intentional unused
imports in __init__.py).