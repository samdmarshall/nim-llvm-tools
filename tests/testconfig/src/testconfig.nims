
switch "define", "EnableASAN"
switch "define", "EnableTSAN"

echo "$nimblePath/"

import "~/Projects/Personal/nim-llvm/src/llvm.nims"

addCompilerFlags @["-Werror"]