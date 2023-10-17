const std = @import("std");
const expect = @import("std").testing.expect;

fn LinkedList(comptime T: type) type {
    const Node = struct {
        const Self = @This();
        next: ?*Self,
        prev: ?*Self,
        data: T,
    };

    return struct {
        const Self = @This();
        head: ?*Node,
        tail: ?*Node,
        size: usize,
        allocator: std.mem.Allocator,

        fn init(alloc: std.mem.Allocator) @This() {
            return .{
                .head = null,
                .tail = null,
                .size = 0,
                .allocator = alloc,
            };
        }

        fn createNode(alloc: std.mem.Allocator, value: T) !?*Node {
            var node = try alloc.create(Node);
            errdefer alloc.destroy(node);
            node.next = null;
            node.prev = null;
            node.data = value;
            return node;
        }

        fn pushFront(self: *Self, value: T) !?void {
            var node = try createNode(self.allocator, value) orelse return;
            if (self.head == null) {
                self.head = node;
                self.tail = node;
                self.size += 1;
                return;
            }
            var tmp = self.*.head;
            self.head = node;
            node.prev = tmp;
            self.size += 1;
        }

        // TODO implementar función para eliminar algún elemento por su indice o por su valor
        pub fn delete() void{
        }
        
        // TODO implementar quicksort 
        pub fn quickSort() void {
        }

        // TODO implementar binary search para la busqueda
        pub fn find() void {
        }

        pub fn reverse() void {
        }

        pub fn print(self: *Self) void {
            var curr = self.head;
            std.log.info("Linked list of type {}", .{T});
            while (curr) |node| {
                std.log.info("-> {d}", .{node.data});
                curr = node.prev;
            }
        }
    };
}

const prueba = LinkedList(i32);

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var a = prueba.init(allocator);

    for (0..10) |i| {
        try a.pushFront(@intCast(i)) orelse return;
    }
    a.print();
}

test "test" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const a = LinkedList(i32);
    var b =  a.init(allocator);
    try expect(LinkedList(i32) == @TypeOf(b));
    //try expect(LinkedList(f32) == @TypeOf(b));
}