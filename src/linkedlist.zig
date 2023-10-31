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

        fn init(alloc: std.mem.Allocator) Self {
            return .{
                .head = null,
                .tail = null,
                .size = 0,
                .allocator = alloc,
            };
        }

        fn createNode(self: *Self, value: T) !?*Node {
            var node = try self.allocator.create(Node);
            errdefer self.allocator.destroy(node);
            node.next = null;
            node.prev = null;
            node.data = value;
            return node;
        }

        fn pushFront(self: *Self, value: T) !void {
            var node = try createNode(self, value) orelse return;
            if (self.head == null) {
                self.head = node;
                self.tail = node;
                self.size += 1;
                return;
            }
            self.head.?.next = node;
            node.prev = self.head;
            self.head = node;
            self.size += 1;
        }

        pub fn reverse(self: *Self) void {
            if (self.size < 1) {
                std.log.info("Empty list", .{});
                return;
            }
            var current = self.head;
            while (current) |curr| : (current = curr.next) {
                var tmp = curr.next;
                curr.next = curr.prev;
                curr.prev = tmp;
            }
            var tmpt = self.tail;
            self.tail = self.head;
            self.head = tmpt;
            return;
        }

        pub fn del(curr: *Node, allocator: std.mem.Allocator) ?T {
            if (curr.prev) |a| {
                if (curr.next) |b| {
                    b.prev = a;
                    a.next = b;
                }
            }
            defer allocator.destroy(curr);
            return curr.data;
        }

        pub fn deleteByIndex(self: *Self, index: usize) ?T {
            if (index == 0) {
                if (self.tail) |tail| {
                    self.tail = tail.next;
                    self.size -= 1;
                    defer self.allocator.destroy(tail);
                    return tail.data;
                }
            }
            if (index == self.size - 1) {
                if (self.head) |head| {
                    self.head = head.prev;
                    self.size -= 1;
                    defer self.allocator.destroy(head);
                    return head.data;
                }
            }
            if (index < @divFloor(self.size, 2)) {
                var current = self.tail;
                var con: usize = 0;
                while (current) |curr| : (current = curr.next) {
                    if (con == index) {
                        var check = del(curr, self.allocator);

                        if (check) |c| {
                            self.size -= 1;
                            return c;
                        }
                    }
                    con += 1;
                }
            } else if (index < self.size) {
                var current = self.head;
                var con: usize = self.size - 1;
                while (current) |curr| : (current = curr.prev) {
                    if (con == index) {
                        var check = del(curr, self.allocator);
                        if (check) |c| {
                            self.size -= 1;
                            return c;
                        }
                    }
                    con -= 1;
                }
            }
            std.log.info("Out of bounds", .{});
            return null;
        }

        // TODO Hacer una revisión general de la implementación de esta función.
        pub fn deleteByName(self: *Self, data: T) void {
            var curr = self.head;
            while (curr) |node| : (curr = node.prev) {
                if (node.data == data and node != self.head and node != self.tail) {
                    _ = del(node, self.allocator);
                    return;
                }
            }
            if (self.head != null and self.head.?.data == data) {
                if (self.head) |head| {
                    self.head = head.prev;
                    self.size -= 1;
                    self.head.?.next = null;
                    self.allocator.destroy(head);
                    return;
                }
            }
            if (self.tail != null and self.tail.?.data == data) {
                if (self.tail) |tail| {
                    self.tail = tail.next;
                    self.size -= 1;
                    self.allocator.destroy(tail);
                    return;
                }
            }
        }

        // TODO implementar quicksort
        pub fn quickSort() void {}

        // TODO implementar binary search para la busqueda
        pub fn binarySearch() void {}

        pub fn find(self: *Self, value: T) ?T {
            var current = self.head;

            while (current != null) {
                if (current.?.data == value) {
                    return value;
                }
                current = current.?.prev;
            }
            return null;
        }

        pub fn print(self: *Self) void {
            var curr = self.tail;
            while (curr) |node| : (curr = node.next) {
                std.log.info("-> {d}", .{node.data});
            }
        }
    };
}

const prueba = LinkedList(i32);

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();
    defer arena.deinit();
    var a = prueba.init(allocator);

    for (0..10) |i| {
        try a.pushFront(@intCast(i));
    }

    for (0..10) |i| {
        std.log.info("{} -> {?}", .{ i, a.deleteByIndex(5) });
    }
}

test "pushing some items" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const constructor = LinkedList(i32);
    var list = constructor.init(allocator);
    for (0..10) |i| {
        try list.pushFront(@intCast(i));
    }
    list.print();
}

test "delete by index" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const constructor = LinkedList(i32);
    var a = constructor.init(allocator);

    for (0..10) |i| {
        try a.pushFront(@intCast(i));
    }

    std.log.info("-> {?}", .{a.deleteByIndex(0)});
}

test "Reverse list" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();
    defer arena.deinit();
    var a = prueba.init(allocator);
    for (0..10) |i| {
        try a.pushFront(@intCast(i));
    }
    a.reverse();
}

test "Delete element by name" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();
    //defer arena.deinit();
    var a = prueba.init(allocator);

    for (0..10) |i| {
        try a.pushFront(@intCast(i));
    }

    for (0..10) |i| {
        std.log.info("{} -> {?}", .{ i, a.deleteByIndex(5) });
    }
}
