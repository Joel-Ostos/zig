const std = @import("std");

pub fn swap(a: *i32, b: *i32) void {
    var tmp: i32 = a.*;
    a.* = b.*;
    b.* = tmp;
}

pub fn max_heapify(arr: []i32, N: usize, i: usize) void {
    var a: usize = (2 * i) + 1;
    var b: usize = (2 * i) + 2;
    var largest: usize = i;
    std.log.info("i = {} a = {} b = {}", .{ arr[i], a, b });
    if (a < N and arr[a] > arr[largest]) largest = a;
    if (b < N and arr[b] > arr[largest]) largest = b;
    if (largest != i) {
        swap(&arr[i], &arr[largest]);
        max_heapify(arr, N, largest);
    }
}

pub fn heap_sort(array: []i32) void {
    var pivot = @divFloor(array.len, 2);
    while (pivot >= 0) : (pivot -= 1) {
        max_heapify(array, array.len, pivot);
        if (pivot == 0) {
            break;
        }
    }

    var a: usize = array.len - 1;
    while (a >= 0) : (a -= 1) {
        swap(&array[0], &array[a]);
        max_heapify(array, a, 0);
        if (a == 0) {
            break;
        }
    }
}

pub fn main() void {
    var array = [_]i32{ 7, 6, 5, 4, 3, 2, 1 };
    heap_sort(&array);
    for (array) |i| {
        std.log.info("{}", .{i});
    }
}
