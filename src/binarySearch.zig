const std = @import("std");

fn binary_search(arr: *const [8]i32, target: *i32) i32 {
    var L: i32 = 0;
    var R: i32 = arr.len - 1;
    var middle: i32 = arr.len / 2;
    std.log.info("{}", .{target.*});

    while (L <= R) {
        if (target.* > arr[@intCast(middle)]) {
            L = middle + 1;
            middle = @divFloor(R, middle) + middle;
        } else if (target.* < arr[@intCast(middle)]) {
            R = middle - 1;
            middle = @divFloor(middle - L, 2);
        } else {
            return middle;
        }
    }
    return -1;
}

pub fn main() !void {
    const arr = [_]i32{ 1, 2, 3, 5, 10, 20, 21, 25 };
    var target: i32 = 2;
    var a = binary_search(&arr, &target);
    if (a != -1) {
        std.log.info("Valor {} encontrado en posicion {}", .{ target, a + 1 });
        return;
    }
    std.log.info("No encontrado :C", .{});
}
