# Performance of Zig vs Rust vs C

## Things to know

My Rust binary is still pretty small compared to normal Rust binaries, check the [Cargo.toml](./rust/Cargo.toml#L11) file for more info.

But it could be much smaller, see this [repo](https://github.com/johnthagen/min-sized-rust).

All binaries are statically linked, striped and optimized for **speed**.
- C -> 716Kb
- Rust -> 1.2MB
- Zig -> 16Kb!!!

C and Rust appear to link to `libc` while Zig doesn't, maybe thats why it's so much smaller.

Results on AMD 9950X:

![image](https://github.com/user-attachments/assets/a1df40aa-0914-49bb-8e2f-3acea41e3e57)


## How to run
```bash
./run.sh
```
