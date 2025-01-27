version     = "0.0.1"
author      = "carrexxii"
description = "Nuklear bindings and wrapper for Nim"
license     = "Apache2.0"

requires "nim >= 2.0.0"

#[ -------------------------------------------------------------------- ]#

import std/strformat

const NuklearTag = "4.12.3"

task restore, "Fetch and build Nuklear":
    exec &"git submodule update --init --remote --merge --recursive -j 8"
    with_dir "lib/nuklear":
        exec &"git checkout {NuklearTag}"
        exec &"""make nuke;
                 cp nuklear.h ../../nuklear.h"""
