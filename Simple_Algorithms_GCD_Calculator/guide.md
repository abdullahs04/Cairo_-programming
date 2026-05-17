# Simple Algorithms: GCD Calculator in Cairo

This guide explains the concept of GCD, the Euclidean algorithm, and how the Cairo implementation works.

## 1) Topic Overview

GCD (Greatest Common Divisor) of two integers is the largest positive integer that divides both numbers without remainder.

Examples:
- GCD(48, 18) = 6
- GCD(54, 24) = 6
- GCD(7, 3) = 1

GCD is useful in:
- fraction simplification,
- number theory,
- cryptography,
- modular arithmetic.

## 2) Euclidean Algorithm (Core Idea)

Instead of checking every divisor, Euclidean algorithm uses this rule:

If `a = b*q + r`, then `gcd(a, b) = gcd(b, r)`.

So we repeatedly do:
1. Compute remainder `r = a % b`
2. Replace `a` with `b`
3. Replace `b` with `r`
4. Stop when `b == 0`
5. Final `a` is the GCD

This makes the algorithm very efficient.

## 3) Cairo Concepts Used

- `fn` for function definitions
- `mut` for mutable variables
- `loop` + `if` + `break` for iteration and termination
- `%` modulus operator to compute remainder
- `println!` for output
- `#[executable]` attribute so Scarb can run `main`

## 4) Program Structure

File used for execution: `src/lib.cairo`

- `gcd(a, b) -> u64`:
  - takes two unsigned 64-bit integers,
  - runs Euclidean algorithm,
  - returns greatest common divisor.

- `main()`:
  - defines two sample numbers,
  - calls `gcd`,
  - prints inputs and output.

## 5) Dry Run Example

Inputs: `a = 48`, `b = 18`

- Step 1: `48 % 18 = 12` -> now `a = 18`, `b = 12`
- Step 2: `18 % 12 = 6` -> now `a = 12`, `b = 6`
- Step 3: `12 % 6 = 0` -> now `a = 6`, `b = 0`
- Stop (`b == 0`) -> GCD is `6`

## 6) Time Complexity

Euclidean algorithm runs in `O(log(min(a, b)))`, which is much faster than brute-force divisor checking.

## 7) Edge Cases

- `gcd(a, 0) = a`
- `gcd(0, b) = b`
- `gcd(0, 0)` is mathematically undefined; this program returns `0` in that case because loop ends immediately.

## 8) Sample Output

For input values 48 and 18:

```text
First number: 48
Second number: 18
GCD(48, 18) = 6
```

## 9) How to Run with Scarb

From this folder:

```bash
scarb execute
```

## 10) What I Learned

- How to design and implement Euclidean algorithm in Cairo.
- How to use mutable state in Cairo loops.
- How to structure executable Cairo programs for Scarb.
- Why algorithmic choice matters for performance and readability.
