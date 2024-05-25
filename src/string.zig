const std = @import("std");
pub const pr = struct {
    name: []const u8,
};
pub fn main() void {
    var arr: [10]u8 = undefined;
    //arr[0] = [1]u8{'j'};
    arr[0] = 'h';
    arr[1] = '0';
    arr[2] = 'l';
    var arr_2: *[3]u8 = arr[0..3];
    std.debug.print("Type arr[0] -> {}\n", .{@TypeOf(arr[0])});
    std.debug.print("Type arr_2[0]-> {}\n", .{@TypeOf(arr_2[0])});
    for (arr_2) |i| {
        std.debug.print("Type -> {}\n", .{@TypeOf(i)});
        //i.* = 'a';
    }
    //arr_2[0] = 'g';
    //arr = "kjaakjckwajakjcackjawmnca,allc";
    std.debug.print("{s} {s} {}", .{ arr, arr_2, @TypeOf(arr[0..3]) });
    var pa = pr{ .name = "kaja" };
    std.debug.print("\n{s}", .{pa.name});

    var p = "kaj kjackl lkjal clkwafl";
    var splits = std.mem.splitAny(u8, p, " ");
    //var a = splits.first();
    //std.debug.print("\nType of a -> {}\n", .{@TypeOf(a)});

    //while (splits.next()) |chunk| {
    //    std.debug.print("{s} {}\n", .{ chunk, @TypeOf(splits.next()) });
    //}
    //if (splits.next()) |e| {
    //    for (e) |d| {
    //        std.debug.print("\nElement -> {c}", .{d});
    //    }
    //}
    for (splits.next().?) |e| {
        std.debug.print("\nElement -> {c}", .{e});
        //if (splits.next() == null) {
        //    break;
        //}
    }
}
