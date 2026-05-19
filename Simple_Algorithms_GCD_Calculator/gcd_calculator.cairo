// Assignment: Simple Algorithms - GCD Calculator
// Student: Mian Muhammad Mannan
// This starter/solution file contains the same implementation as src/lib.cairo.

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
    let first_number: u64 = 48;
    let second_number: u64 = 18;

    let result = gcd(first_number, second_number);

    println!("First number: {}", first_number);
    println!("Second number: {}", second_number);
    println!("GCD({}, {}) = {}", first_number, second_number, result);
}
