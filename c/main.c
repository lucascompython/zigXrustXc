#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

int sieve_of_eratosthenes(int n) {
    if (n < 2) return 0;
    if (n == 2) return 1;

    size_t odd_count = (n - 1) / 2;
    size_t byte_size = (odd_count + 7) / 8;
    uint8_t *bits = malloc(byte_size);
    
    memset(bits, 0xFF, byte_size);

    for (size_t i = 0; 2 * i + 3 <= n; i++) {
        if (bits[i/8] & (1 << (i%8))) {
            size_t prime = 2 * i + 3;
            if (prime * prime <= n) {
                for (size_t j = (prime * prime - 3) / 2; j < odd_count; j += prime) {
                    bits[j/8] &= ~(1 << (j%8));
                }
            }
        }
    }

    int total = 1;
    for (size_t i = 0; i < odd_count; i++) {
        if (bits[i/8] & (1 << (i%8))) total++;
    }

    free(bits);
    return total;
}

int main(int argc, char **argv)
{
    int n = atoi(argv[1]);

    int primes = sieve_of_eratosthenes(n);
    printf("There are %d primes between 2 and %d\n", primes, n);

    return 0;
}