const std = @import("std");
const queue = @import("queue.zig");

const Queue = queue.Queue(pair);
const R = [_]isize{ 1, -1, 0, 0 };
const P = [_]isize{ 0, 0, 1, -1 };

const pair = struct {
    first: isize,
    second: isize,
};

var parents: [5][8]pair = undefined;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const map = [5][8]u8{
        [_]u8{ '#', '#', '.', '.', '.', '.', '.', '.' },
        [_]u8{ '#', '.', 'A', '#', '.', '.', '.', '.' },
        [_]u8{ '#', '.', '#', '#', '.', '#', 'B', '#' },
        [_]u8{ '#', '.', '.', '.', '.', '.', '#', '#' },
        [_]u8{ '#', '#', '#', '#', '#', '#', '#', '#' },
    };
    var string: []u8 = "afka";

    std.log.info("Tipo de arreglo: {}", .{@TypeOf(string)});
    var A: pair = pair{ .first = 0, .second = 0 };
    var B: pair = pair{ .first = 0, .second = 0 };

    for (map, 0..) |submap, a| {
        for (submap, 0..) |_, b| {
            if (map[a][b] == 'A') {
                A.first = @intCast(a);
                A.second = @intCast(b);
            }
            if (map[a][b] == 'B') {
                B.first = @intCast(a);
                B.second = @intCast(b);
            }
            parents[a][b].first = -1;
            parents[a][b].second = -1;
        }
    }

    parents[@intCast(A.first)][@intCast(A.second)].first = -2;
    parents[@intCast(A.first)][@intCast(A.second)].second = -2;

    var Q = Queue.init(allocator);
    _ = try Q.push(A);

    while (Q.size > 0) {
        var nx = try Q.pop() orelse return;
        for (0..4) |i| {
            var new: pair = pair{ .first = nx.first + R[i], .second = nx.second + P[i] };
            if (new.first > 4 or new.second > 7 or new.first < 0 or new.second < 0 or map[@intCast(new.first)][@intCast(new.second)] == '#') continue;
            if (parents[@intCast(new.first)][@intCast(new.second)].first == -1) {
                _ = try Q.push(new);
                parents[@intCast(new.first)][@intCast(new.second)].first = nx.first;
                parents[@intCast(new.first)][@intCast(new.second)].second = nx.second;
            }
        }
    }

    if (B.first != -1 and B.second != -1) {
        while (B.first != A.first or B.second != A.second) {
            B = parents[@intCast(B.first)][@intCast(B.second)];
            std.log.info("{} {}", .{ B.first, B.second });
        }
    } else {
        std.log.info("No hay un camino para B", .{});
    }
}
