// ===============================================
// Name: Bazil Suhail
// Roll No: Bscs22072
// Section: B
// ===============================================

// The recursive factorial function returning a u32
fn factorial(n: u32) -> u32 {
    if n == 0 {
        1
    } else {
        n * factorial(n - 1)
    }
}

fn main() -> u32 {
    // Calculate the factorial
    let result = factorial(7);
    
    // Returning 'result' without a semicolon so the compiler prints it
    result

    // Print the result directly to the terminal
    // println!("The factorial of 5 is: {}", result);
}

// fn main() -> u32 {
//     let mut i: u32 = 0;
//     let mut last_calculated_value: u32 = 0;

//     // The loop runs from 0 to 6
//     while i < 7 {
//         last_calculated_value = factorial(i);
//         i += 1;
//     };

//     // Return just the final single number so the compiler prints it directly
//     last_calculated_value
// }

// #[cfg(test)]
// mod tests {
//     use super::factorial;

//     #[test]
//     fn test_factorial_zero() {
//         assert(factorial(0) == 1, 'Factorial of 0 should be 1');
//     }

//     #[test]
//     fn test_factorial_five() {
//         assert(factorial(5) == 120, 'Factorial of 5 should be 120');
//     }

//     #[test]
//     fn test_factorial_six() {
//         assert(factorial(6) == 720, 'Factorial of 6 should be 720');
//     }
// }
