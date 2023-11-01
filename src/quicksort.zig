const std = @import("std");

fn swap(a: *i32, b: *i32) void {
    var tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

pub fn sort(A: []i32, lo: usize, hi: usize) void {
    if (lo < hi) {
        var p = partition(A, lo, hi);
        sort(A, lo, @min(p, p -% 1));
        sort(A, p + 1, hi);
    }
}

pub fn partition(A: []i32, lo: usize, hi: usize) usize {
    var pivot = A[hi];
    var i = lo;
    var j = lo;
    while (j < hi) : (j += 1) {
        if (A[j] < pivot) {
            swap(&A[i], &A[j]);
            i = i + 1;
        }
    }
    swap(&A[i], &A[hi]);
    return i;
}
pub fn main() !void {
    var arreglo = [_]i32{ 2, 3, 1, 4, 7, 1 };
    sort(&arreglo, 0, arreglo.len - 1);
    for (arreglo) |i| {
        std.log.info("{}", .{i});
    }
}
