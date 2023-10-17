const std = @import("std");

const hash = std.AutoHashMap(i32,i32);
pub fn main() !void{
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var mihash = hash.init(allocator);
    try mihash.put(1,10);
    try mihash.put(2,20);
    try mihash.put(3,30);
    try mihash.put(4,40);
    var mi_iterador = mihash.iterator();
    while (mi_iterador.next()) |t|{
        std.log.info("Antes {} ", .{t.key_ptr.*});
    }
    var mi_iterador2 = mihash.keyIterator();
    while (mi_iterador2.next()) |t|{
        std.log.info("a {} ", .{t.*});
    }
    var arreglo = [_]i32{1,2,3,4,5};
    for (arreglo) |a|{
        std.log.info("{}", .{a});
    }
}
