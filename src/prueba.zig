const std = @import("std");

pub fn construct() type {
    return struct {
        num: i32,

        const self = @This();
        pub fn print_n(s: *self) void {
            std.debug.print("{} ", .{s.num});
        }
    };
}
pub fn foo(f: i32) construct() {
    return .{
        .num = f,
    };
}
pub fn main() void {
    var b = foo(2);
    b.print_n();
    //std.debug.print("{}", .{b.num});
}
