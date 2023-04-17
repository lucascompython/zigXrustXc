fn sieve_of_eratosthenes(n: usize) -> usize {
    let mut is_prime = vec![true; n + 1];
    let mut total = 0;
    is_prime[0] = false;
    is_prime[1] = false;

    for i in 2..=(n as f64).sqrt() as usize {
        if is_prime[i] {
            for j in ((i * i)..=n).step_by(i) {
                is_prime[j] = false;
            }
        }
    }

    for i in 2..=n {
        if is_prime[i] {
            total += 1;
        }
    }

    total
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args[1].parse::<usize>().unwrap();

    let primes = sieve_of_eratosthenes(n);
    println!("Primes up to {} are: {}", n, primes);
}
