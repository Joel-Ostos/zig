const std = @import("std");

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
}
