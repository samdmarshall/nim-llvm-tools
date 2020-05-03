# Package

version       = "0.1.0"
author        = "Samantha Demi"
description   = "testing out backend specification with llvm config files"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["testconfig"]
backend       = "c"

# Dependencies

requires "nim >= 1.2.0"
requires "llvmtools"
