const std = @import("std");
const s_1 = struct {
    name: []const u8,
    email: []const u8,
};
const s_2 = struct {
    name: []const u8,
    age: i32,
};
const tipos = union(enum) {
    a: s_1,
    b: s_2,
    pub fn format(
        self: tipos,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        switch (self) {
            .a => |a| try writer.print("name: {s}, age: {s}", .{ a.name, a.email }),
            .b => |b| try writer.print("name: {s}, age: {}", .{ b.name, b.age }),
        }
    }
    pub fn change_name(self: *tipos, new: []const u8) void {
        switch (self.*) {
            .a => |*a| a.name = new,
            .b => |*b| b.name = new,
        }
    }
};

pub fn main() void {
    var xd: tipos = tipos{ .a = s_1{ .name = "kaj", .email = "joelostoscastro@gmail.com" } };
    xd = tipos{ .b = s_2{ .name = "kaj", .age = 20 } };
    std.debug.print("{}\n", .{xd});
    xd.change_name("joel");
    std.debug.print("{}", .{xd});
    var num: i8 = 100;
    for (0..50) |i| {
        num = num +| @as(i8, @intCast(i));
    }
    var arr: [5]i32 = [5]i32{ 1, 2, 3, 4, 5 };
    var right: usize = arr.len - 1;
    var left: usize = 0;
    while (right > left) : ({
        right -= 1;
        left += 1;
    }) {
        var tmp_1: i32 = arr[right];
        var tmp_2: i32 = arr[left];
        arr[right] = tmp_2;
        arr[left] = tmp_1;
    }
    std.debug.print("\nNum = {}", .{num});
    std.debug.print("\nArr = {any}", .{arr});

    var xd_2: tipos = tipos{ .a = s_1{ .name = "kaj", .email = "akjack" } };
    std.debug.print("{any}", .{xd_2.a});
}
