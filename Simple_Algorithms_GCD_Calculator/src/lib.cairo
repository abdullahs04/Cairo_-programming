// Assignment: Simple Algorithms - GCD Calculator
// Student: Mian Muhammad Mannan
// Program: Calculates the Greatest Common Divisor (GCD) of two numbers
// using the Euclidean algorithm and prints the result.

// Euclidean algorithm:
// Keep replacing (a, b) with (b, a % b) until b becomes 0.
// The remaining value in a is the GCD.
fn gcd(mut a: u64, mut b: u64) -> u64 {
    loop {
        if b == 0 {
            break;
        }

        let remainder = a % b;
        a = b;
        b = remainder;
    };

    a
}

#[executable]
fn main() {
    // You can change these inputs to test other values.
    let first_number: u64 = 48;
    let second_number: u64 = 18;

    let result = gcd(first_number, second_number);

    println!("First number: {}", first_number);
    println!("Second number: {}", second_number);
    println!("GCD({}, {}) = {}", first_number, second_number, result);
}
