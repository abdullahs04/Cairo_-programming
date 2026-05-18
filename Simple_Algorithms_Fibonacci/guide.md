# Fibonacci - Simple Algorithms

## What I Studied

Fibonacci sequence is a series where each number is the sum of the two numbers before it.

Sequence: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...

Formula:
- fib(0) = 0
- fib(1) = 1
- fib(n) = fib(n-1) + fib(n-2)

## Real Life Applications of Fibonacci

- Nature: flower petals and spiral shells follow fibonacci sequence
- Stock market technical analysis (Fibonacci retracement levels)
- Computer algorithms like dynamic programming
- Image compression techniques
- Architecture and art (Golden Ratio)

## What I Implemented

### 1. Recursive Function
Directly follows the mathematical formula. Simple to understand
but gets slow for large values because it makes too many function calls.

Time Complexity: O(2^n) - each call makes 2 more calls

### 2. Iterative Function
Uses a loop instead of recursion. Much more efficient.

Time Complexity: O(n) - loop runs only once

### 3. Fibonacci Checker
Checks whether a given number exists in the Fibonacci sequence.
It keeps generating fibonacci numbers until it either matches
or exceeds the given number.

## Cairo Concepts Used

- fn keyword for defining functions
- u32 data type for positive integers
- let mut for mutable variables
- loop and break for iteration
- if conditions and return statements
- Tests using #[cfg(test)] module
- assert! macro for test verification

## How to Run

```bash
scarb build     
scarb execute   
scarb test  
```

## What I Learned

I learned that recursion and iteration are not the same in terms
of performance. Recursion uses more memory because of repeated
function calls. Writing loops in Cairo is slightly different from
other languages - the loop block ends with a semicolon. Writing
tests was also helpful to verify that the code is working correctly.
The iterative approach is always better for Fibonacci because it
avoids recalculating the same values repeatedly.