const std = @import("std");

pub fn sieve_of_eratosthenes(n: usize, allocator: std.mem.Allocator) !usize {
    if (n < 2) return 0;
    if (n == 2) return 1;

    const odd_count = (n - 1) >> 1;
    const bytes = (odd_count + 7) >> 3;

    var bitmap = try allocator.alignedAlloc(u8, std.mem.Alignment.@"64", bytes);
    defer allocator.free(bitmap);
    @memset(bitmap, 0xFF);

    var i: usize = 0;
    while (2 * i + 3 <= n) : (i += 1) {
        if (bitmap[i >> 3] & (@as(u8, 1) << @intCast(i & 7)) != 0) {
            const prime = 2 * i + 3;
            if (prime * prime <= n) {
                var j = (prime * prime - 3) >> 1;
                while (j < odd_count) : (j += prime) {
                    bitmap[j >> 3] &= ~(@as(u8, 1) << @intCast(j & 7));
                }
            }
        }
    }

    var count: usize = 1;
    var pos: usize = 0;
    while (pos < odd_count) : (pos += 1) {
        if (bitmap[pos >> 3] & (@as(u8, 1) << @intCast(pos & 7)) != 0) {
            count += 1;
        }
    }

    return count;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const args = try std.process.argsAlloc(allocator);

    const first_arg = args[1];

    const n = try std.fmt.parseInt(usize, first_arg, 10);

    const primes = try sieve_of_eratosthenes(n, allocator);

    try stdout.print("There are {d} primes between 2 and {d}\n", .{ primes, n });
}
