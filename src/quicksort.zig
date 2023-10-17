const std = @import("std");

fn swap(a: *i32, b: *i32) void{
    var tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

fn quickSort(a: []i32, lo: usize, hi: usize) void {
}

pub fn main() !void {
    var arreglo = [_]i32{2,3,1,4,7,1};
    quickSort(&arreglo, 0, arreglo.len-1);
    for (arreglo) |i|{
        std.log.info("{}", .{i});
    }
}
