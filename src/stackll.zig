const std = @import("std");
pub fn stack(comptime T: type) type {
    const node = struct {
        next: ?*@This(),
        data: T,
    };

    return struct {
        head: ?*node,
        tail: ?*node,
        size: usize,
        alloc: std.mem.Allocator,
        pub fn init(allocator: std.mem.Allocator) @This() {
            return .{
                .head = null,
                .tail = null,
                .size = 0,
                .alloc = allocator,
            };
        }

        pub fn create_node(self: *@This(), data: T) !?*node {
            var nnode = try self.alloc.create(node);
            errdefer self.alloc.destroy(nnode);
            nnode.data = data;
            nnode.next = self.head;
            return nnode;
        }

        pub fn push(self: *@This(), data: T) !void {
            var nnode = try create_node(self, data);
            self.head = nnode;
            self.size += 1;
        }

        pub fn pop(self: *@This()) !?T {
            if (self.head) |head| {
                self.head = head.next;
                var value = head.data;
                self.alloc.destroy(head);
                self.size -= 1;
                return value;
            }
            std.log.info("Trying to pop an empty stack!", .{});
            return null;
        }
        pub fn print(self: *@This()) void {
            var curr = self.head;
            while (curr) |head| {
                std.log.info("In stack -> {}", .{head.data});
                curr = head.next;
            }
        }
    };
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const constructor = stack(i32);
    var mistack = constructor.init(allocator);
    _ = try mistack.push(10);
    _ = try mistack.push(20);
    _ = try mistack.push(30);
    _ = try mistack.push(40);
    _ = try mistack.push(50);
    _ = try mistack.pop();
    mistack.print();
}
