const std = @import("std");
const math = std.math;

const div = 250000 / 4;

const hilo = struct {
    inicio: usize,
    final: usize,
    resultado: f64,
};

pub fn init(i: usize) hilo {
    return hilo{
        .inicio = i,
        .final = i+1,
        .resultado = 0,
    };
}

fn leibniz(data: *hilo) void{
    var inicio = data.inicio*div; 
    var final = (data.final*div)-1;
    var signo = math.pow(f64,-1,@as(f64,@floatFromInt(@as(i32,@intCast(inicio)))));
    var resultado: f64 = 0;
    for (inicio..final) |i|{
        resultado += signo / ((2*@as(f64, @floatFromInt(@as(i32,@intCast(i))))) + 1);
        signo *= -1;
    }
    data.resultado = resultado;
}

pub fn main() !void {
    var data = [4]hilo{undefined,undefined, undefined, undefined};
    var hilos: [4]std.Thread = undefined;
    var resultado: f64 = 0;

    for (0..4) |i|{
        var thread = init(i);
        data[i] = thread;
    }

    for (&data, 0..) |*th, i|{
        hilos[i] = try std.Thread.spawn(.{},leibniz, .{th});
        defer hilos[i].join();
    }

    for (data) |th|{
        resultado += th.resultado; 
    }

    std.log.info("Resultado  {}", .{resultado*4});
}
