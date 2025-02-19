const std = @import("std");
const zigr2p_build = @import("zigr2p");
const PluginCtx = zigr2p_build.interfaces.Plugin.Ctx;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const zigr2p_dep = b.dependency("zigr2p", .{
        .target = target,
        .optimize = optimize,
        .name = @as([]const u8, "zigr2ptst"),
        .ctx = PluginCtx.both,
    });
    const zigr2p = zigr2p_dep.artifact("zigr2ptst");
    const lib = b.addSharedLibrary(.{ .name = "zigr2ptst", .root_source_file = b.path("src/root.zig"), .target = target, .optimize = optimize, .version = .{ .major = 1, .minor = 0, .patch = 0 } });
    lib.root_module.addImport("zigr2p", zigr2p.root_module);
    b.installArtifact(lib);
}
