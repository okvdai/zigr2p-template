const std = @import("std");
const zigr2p = @import("zigr2p");
const binder = zigr2p.binder;
const squirrel = zigr2p.squirrel;
const interfaces = zigr2p.interfaces;
const windows = std.os.windows;

const Declarations = [_]binder.Declaration{
    .{
        .name = "testsqfunc",
        .funcPtr = &testsqfunc,
        .argTypes = "",
        .returnType = squirrel.SQReturnType.Default,
        .returnTypeString = "",
        .ctx = squirrel.Ctx.ui,
    },
};

export fn testsqfunc() squirrel.Result {
    interfaces.sysintf.vtable.Log(interfaces.sysintf, interfaces.cbHandle, interfaces.Sys.LogLevel.INFO, "Testing...");
    return squirrel.Result.null;
}

pub fn DllMain(_: windows.HINSTANCE, reason: windows.DWORD, _: windows.LPVOID) windows.BOOL {
    if (reason == 1) {
        std.debug.print("honkmimishoo", .{});
        for (Declarations) |decl| {
            binder.Declarations.append(decl) catch return windows.FALSE;
        }
    }
    return windows.TRUE;
}
