#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

int sieve_of_eratosthenes(int n)
{
    bool *is_prime = (bool *)malloc((n + 1) * sizeof(bool));

    for (int i = 2; i <= n; i++)
    {
        is_prime[i] = true;
    }

    for (int i = 2; i <= sqrt(n); i++)
    {
        if (is_prime[i])
        {
            for (int j = i * i; j <= n; j += i)
            {
                is_prime[j] = false;
            }
        }
    }

    int total = 0;
    for (int i = 2; i <= n; i++)
    {
        if (is_prime[i])
        {
            total++;
        }
    }

    free(is_prime);
    return total;
}

int main(int argc, char **argv)
{
    int n = atoi(argv[1]);

    int primes = sieve_of_eratosthenes(n);
    printf("There are %d primes between 2 and %d\n", primes, n);

    return 0;
}