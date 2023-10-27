const std = @import("std");

const R = [4]i32{1,-1,0,0};
const P = [4]i32{0,0,1,-1};

const pair = struct {
    ff : usize,
    ss : usize,
};

pub fn bfs(x: usize, y: usize) void{
    var a = pair{.ff = 0, .ss = 0};
}

pub fn main() void{
    var x: usize = 5;
    var y: usize = 8;
    bfs(x,y);
}
