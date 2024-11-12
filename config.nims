import std/[os, strformat]

const
    src_dir = "./src"
    lib_dir = "./lib"
    deps: seq[tuple[src, dst, tag: string; cmds: seq[string]]] = @[
        (src  : "https://github.com/Immediate-Mode-UI/Nuklear/",
         dst  : lib_dir / "nuklear",
         tag  : "",
         cmds : @["cp nuklear.h ../../nuklear.h"]),
    ]

var cmd_count = 0
proc run(cmd: string) =
    if defined `dry-run`:
        echo &"[{cmd_count}] {cmd}"
        inc cmd_count
    else:
        exec cmd

task restore, "Restore":
    run "git submodule update --init --remote --merge -j 8"
    for dep in deps:
        with_dir dep.dst:
            run &"git checkout {dep.tag}"
            for cmd in dep.cmds:
                run cmd

