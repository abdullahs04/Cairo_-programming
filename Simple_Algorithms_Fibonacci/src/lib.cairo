// fibonacci assignment
// simple algorithms - finding nth fibonacci number
// by arshad ali

fn fib_recursive(n: u32) -> u32 {
    if n == 0 {
        return 0;
    }
    if n == 1 {
        return 1;
    }
    fib_recursive(n - 1) + fib_recursive(n - 2)
}

fn fib_iterative(n: u32) -> u32 {
    if n == 0 {
        return 0;
    }
    if n == 1 {
        return 1;
    }
    let mut a: u32 = 0;
    let mut b: u32 = 1;
    let mut count: u32 = 2;
    loop {
        if count > n {
            break;
        }
        let temp = a + b;
        a = b;
        b = temp;
        count += 1;
    };
    b
}

fn check_fib(num: u32) -> bool {
    if num == 0 || num == 1 {
        return true;
    }
    let mut x: u32 = 0;
    let mut y: u32 = 1;
    loop {
        if y >= num {
            break;
        }
        let next = x + y;
        x = y;
        y = next;
    };
    y == num
}

#[executable]
fn main() {
    println!("Fibonacci using recursive method:");
    let mut i: u32 = 0;
    loop {
        if i == 10 {
            break;
        }
        println!("fib({}) = {}", i, fib_recursive(i));
        i += 1;
    };

    println!("");
    println!("Fibonacci using iterative method:");
    let mut j: u32 = 0;
    loop {
        if j == 10 {
            break;
        }
        println!("fib({}) = {}", j, fib_iterative(j));
        j += 1;
    };

    println!("");
    println!("Checking numbers:");
    println!("5 is fibonacci: {}", check_fib(5));
    println!("7 is fibonacci: {}", check_fib(7));
    println!("13 is fibonacci: {}", check_fib(13));
    println!("20 is fibonacci: {}", check_fib(20));
}

#[cfg(test)]
mod tests {
    use super::fib_recursive;
    use super::fib_iterative;
    use super::check_fib;

    #[test]
    fn test_base_cases() {
        assert!(fib_recursive(0) == 0);
        assert!(fib_recursive(1) == 1);
    }

    #[test]
    fn test_recursive() {
        assert!(fib_recursive(6) == 8);
        assert!(fib_recursive(9) == 34);
    }

    #[test]
    fn test_iterative() {
        assert!(fib_iterative(6) == 8);
        assert!(fib_iterative(10) == 55);
    }

    #[test]
    fn test_both_same() {
        assert!(fib_recursive(7) == fib_iterative(7));
    }

    #[test]
    fn test_checker() {
        assert!(check_fib(13));
        assert!(!check_fib(20));
    }
}