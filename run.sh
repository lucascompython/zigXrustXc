#!/bin/bash

echo "Running C"

cd c
clang main.c -O3 -ffast-math -flto -static -march=native -s -o c
size=$(du -h c)
echo "Size of C executable: $size"
time ./c $1

echo "Running Rust"

cd ../rust
RUSTFLAGS="-C target-feature=+crt-static -C link-arg=-lgcc -Ctarget-cpu=native" cargo build --release
size=$(du -h ./target/release/rust)
echo "Size of Rust executable: $size"
time ./target/release/rust $1

echo "Running Zig"
cd ../zig
zig build -Doptimize=ReleaseFast
size=$(du -h ./zig-out/bin/zig)
echo "Size of Zig executable: $size"
time ./zig-out/bin/zig $1
