const std = @import("std");
const expect = @import("std").testing.expect;

pub fn Stack(comptime T: type) type{
    const node = struct {
        next: ?*@This(),
        prev: ?*@This(),
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

        pub fn create_node(self: *@This(), value: T) !?*node{
            var nnode = try self.alloc.create(node);
            errdefer self.alloc.destroy(nnode);
            nnode.next = null; 
            nnode.prev = null;
            nnode.data = value;

            return nnode;
        }
        
        pub fn push(self: *@This(), value: T) !?void{
            var nnode = try create_node(self, value) orelse return;
            if (self.head == null){
                self.head = nnode;
                self.tail = nnode;
                self.size += 1;
                return;
            }
            var tmp = self.*.tail;
            self.tail = nnode; 
            nnode.prev = tmp;
            tmp.?.next = nnode;
            self.size += 1;
        }

        pub fn pop(self: *@This()) !void{
            var tmp = self.*.tail;
            if (self.size == 1){
                self.alloc.destroy(self.*.tail.?);
                self.alloc.destroy(self.*.head.?);
                self.*.tail = null;
                self.*.head = null;
                self.size -= 1;
                return;
            }
            self.alloc.destroy(self.*.tail.?);
            self.*.tail = tmp.?.prev;
            self.*.tail.?.next = null;
            self.size -= 1;
        }

        pub fn print(self: *@This()) void{
            var current = self.*.head;
            if (current == null){
                std.log.info("El stack está vacío", .{});
                return;
            }
            var i : usize = 0;
            while (current != null) : (i+=1){
                std.log.info("Elemento {} con valor {}", .{i, current.?.*.data});
                current = current.?.next; 
            }
        }
    };
}

pub fn main() !void{
}

test "Push"{
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const construct = Stack(i32);
    var stack = construct.init(allocator);
    _ = try stack.push(80);
    _ = try stack.push(70);
    _ = try stack.push(60);
    _ = try stack.push(50);
    _ = try stack.push(40);
    _ = try stack.push(30);
    _ = try stack.push(20);
    _ = try stack.push(10);
    stack.print();
}

test "Try to print empty stack"{
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const construct = Stack(i32);
    var stack = construct.init(allocator);
    stack.print();
}

test "Try to pop all the elements in the stack (the asertions are the same that in the push test)"{
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const construct = Stack(i32);
    var stack = construct.init(allocator);
    _ = try stack.push(80);
    _ = try stack.push(70);
    _ = try stack.push(60);
    _ = try stack.push(50);
    _ = try stack.push(40);
    _ = try stack.push(30);
    _ = try stack.push(20);
    _ = try stack.push(10);
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    stack.print();
}

test "Try to push elements after pop all the elements in the stack" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const construct = Stack(i32);
    var stack = construct.init(allocator);
    _ = try stack.push(80);
    _ = try stack.push(70);
    _ = try stack.push(60);
    _ = try stack.push(50);
    _ = try stack.push(40);
    _ = try stack.push(30);
    _ = try stack.push(20);
    _ = try stack.push(10);
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    stack.print();
}
