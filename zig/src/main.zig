const std = @import("std");
const httpz = @import("httpz");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const port = 3000;
    var server = try httpz.Server().init(allocator, .{ .port = port });

    var router = server.router();

    router.get("/", getRoot);

    std.debug.print("Listening on port {d}\n", .{port});

    try server.listen();
}

fn getRoot(_: *httpz.Request, res: *httpz.Response) !void {
    res.body = "Hello World!";
}
