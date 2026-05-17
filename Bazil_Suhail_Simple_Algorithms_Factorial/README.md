# Simple Algorithms: Factorial in Cairo

This repository contains a simple recursive implementation of the Factorial algorithm written in [Cairo](https://www.cairo-lang.org/).

## Project Structure

This project uses the standard **Scarb** package manager structure:

- `Scarb.toml`: The package manifest containing configuration and dependencies.
- `src/lib.cairo`: The main source code file which includes:
  - The recursive `factorial` function.
  - A `main` function demonstrating usage.
  - A comprehensive native testing module with assertions.

## Usage

If you have [Scarb](https://docs.swmansion.com/scarb/) installed, you can interact with the project natively:

### Running Tests

Execute the native testing module (located in `src/lib.cairo`):

```bash
scarb test
```

### Running the Code

To execute the `main` function:

```bash
scarb cairo-run
```

## Author

**Bazil Suhail**
Roll No: Bscs22072
Section: B
