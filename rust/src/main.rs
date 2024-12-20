fn sieve_of_eratosthenes(n: usize) -> usize {
    if n < 2 { return 0; }
    if n == 2 { return 1; }

    let odd_count = (n - 1) >> 1;
    let bytes = (odd_count + 7) >> 3;
    let mut bits = vec![0xFF_u8; bytes];

    let mut i = 0;
    while 2 * i + 3 <= n {
        if (bits[i >> 3] & (1 << (i & 7))) != 0 {
            let prime = 2 * i + 3;
            if prime * prime <= n {
                let mut j = (prime * prime - 3) >> 1;
                while j < odd_count {
                    bits[j >> 3] &= !(1 << (j & 7));
                    j += prime;
                }
            }
        }
        i += 1;
    }

    let mut count = 1;
    let mut pos = 0;
    while pos < odd_count {
        if (bits[pos >> 3] & (1 << (pos & 7))) != 0 {
            count += 1;
        }
        pos += 1;
    }

    count
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args[1].parse::<usize>().unwrap();

    let primes = sieve_of_eratosthenes(n);
    println!("There are {} primes between 2 and {}", primes, n);
}
