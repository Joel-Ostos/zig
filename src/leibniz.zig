const std = @import("std");
const math = std.math;
const num = 4;
const div = 100_000_000_000 / num;

const hilo = struct {
    inicio: usize,
    final: usize,
    resultado: f64,
};

pub fn init(i: usize) hilo {
    return hilo{
        .inicio = i,
        .final = i + 1,
        .resultado = 0,
    };
}

fn leibniz(data: *hilo) void {
    var inicio = data.inicio * div;
    var final = (data.final * div) - 1;
    var signo = math.pow(f64, -1, @as(f64, @floatFromInt(@as(i64, @intCast(inicio)))));
    var resultado: f64 = 0;
    for (inicio..final) |i| {
        resultado += signo / ((2 * @as(f64, @floatFromInt(@as(i64, @intCast(i))))) + 1);
        signo *= -1;
    }
    data.resultado = resultado;
}

pub fn main() !void {
    var data: [num]hilo = undefined;
    var hilos: [num]std.Thread = undefined;
    var resultado: f64 = 0;

    for (&data, 0..) |*i, b| {
        var thread = init(b);
        i.* = thread;
        hilos[b] = try std.Thread.spawn(.{}, leibniz, .{i});
    }
    for (data, 0..) |th, i| {
        hilos[i].join();
        resultado += th.resultado;
    }

    std.log.info("Resultado  {}", .{resultado * 4});
}
