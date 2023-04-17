# Performance of Zig vs Rust vs C

## Things to know

My CPU is a Amd Ryzen 9 7950x, so results may vary *a lot* on other CPUs.  
My Rust binary is still pretty small compared to normal Rust binaries, check the [Cargo.toml](./rust/Cargo.toml#L11) file for more info.  
The C and Rust binaries are dynamically linked, and the Zig binary is statically linked.

## C (clang v15.0.7)

Build

```bash
clang -Ofast -lm main.c -o sieve
```

Result

```bash
time ./sieve 100000000
# 0.33s, 96MB MAX RAM, 16k binary size
```

## Zig (v0.10.1)

Build

```bash
zig build -Drelease-fast
```

Result

```bash
time ./zig-cache/bin/zig 100000000
# 0.44s, 143MB MAX RAM, 25k binary size
```

## Rust (v1.68.2)

Build

```bash
cargo build --release
```

Result

```bash
time ./target/release/rust 100000000
# 0.47s, 96MB MAX RAM, 293k binary size
```
