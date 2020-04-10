# Package

version       = "0.1.0"
author        = "Samantha Demi"
description   = "Set of configuration files for interacting with llvm tools"
license       = "BSD-3-Clause"

srcDir        = "src/"
backend       = "js"

installExt    = @["nims"]


# Dependencies

requires "nim >= 1.2.0"

import distros

foreignDep "llvm"

