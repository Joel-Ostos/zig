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
    if (a < N and arr[a] > arr[largest]) largest = a;
    if (b < N and arr[b] > arr[largest]) largest = b;
    imprimir(arr);
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

pub fn imprimir(array: []i32) void {
    std.log.info("Imprimiendo desde acá", .{});
    for (array) |a| {
        std.log.info("-> {}", .{a});
    }
}

pub fn main() void {
    var array = [_]i32{ 1, 6, 3, 2, 8, 5, 4, 7 };
    heap_sort(&array);
    for (array) |i| {
        std.log.info("{}", .{i});
    }
}
