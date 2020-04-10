
# =======
# Imports
# =======

import os

# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):

  let cc_path = findExe(bin="clang")
  let cpp_path = findExe(bin="clang++")

  let cc = extractFilename(cc_path)
  let cpp = extractFilename(cpp_path)

  let command = getCommand()
  case command
  of "c":
    switch("cc", cc)
  of "cpp":
    switch("cc", cpp)
  of "js":
    assert false, msg = "The LLVM compiler is not supported when targeting Javascript!"
  else:
    switch("cc", cc)

  let library_path = gorge(cc_path & " --print-resource-dir")
  echo library_path

  