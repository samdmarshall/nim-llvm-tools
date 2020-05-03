
switch "define", "EnableLLVMCompiler"
switch "define", "EnableASAN"
switch "define", "LibraryIndex 4"
#switch "define", "EnableTSAN"
#switch "define", "EnableMSAN"
#switch "define", "EnableUBSAN"


# this works, because the llvmtools path is added via `nimble build`
import "llvm.nims"
