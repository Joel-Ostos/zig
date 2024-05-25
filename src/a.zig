const std = @import("std");

const tipo = enum {
    uno,
    dos,
};

const prueba = union(enum) {
    a: el_1,
    b: el_2,
    pub fn init(xd: tipo) prueba {
        return switch (xd) {
            .uno => .{ .a = el_1.init() },
            .dos => .{ .b = el_2.init() },
        };
    }

    pub fn greet(self: prueba) void {
        switch (self) {
            .a => |v| std.debug.print("{s}", .{v.name}),
            .b => |v| std.debug.print("{s}", .{v.name}),
        }
    }
};

const el_1 = struct {
    name: []const u8,
    email: []const u8,

    pub fn init() el_1 {
        return .{ .name = "joel", .email = "joel@gmail.com" };
    }
};

const el_2 = struct {
    name: []const u8,
    age: i32,
    pub fn init() el_2 {
        return .{ .name = "Hitler", .age = 20 };
    }
};

pub fn main() void {
    var primero: prueba = prueba{ .a = el_1.init() };
    var seg: prueba = prueba.init(tipo.dos);
    //var xd_2: tipos = tipos{ .a = s_1{ .name = "kaj", .email = "akjack" } };
    std.debug.print("{s} {s}", .{ primero.a.name, seg.b.name });
    primero.greet();
    seg.greet();
}
