const std = @import("std");

fn insertionSort(arr: []i32)  void {
    var i: usize = 1;

    while(i < arr.len){
        var h: usize = 0;
        while(arr[i-h] < arr[i-1-h]){
            var tmp: i32 = arr[i-h];
            arr[i-h] = arr[i-1-h];
            arr[i-1-h] = tmp;
            h+=1;
        }
        i+=1;
    }
}

pub fn main() void {
    var arreglo = [_]i32{1,3,6,5,8,4,7,9,10};
    insertionSort(&arreglo);
    for (arreglo) |a|{
        std.log.info("{}", .{a});
    }
}
