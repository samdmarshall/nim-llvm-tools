
# =======
# Imports
# =======

import os
import strutils

# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):

  let path_llvmconfig = findExe(bin="llvm-config")
  let has_llvm_installed = (path_llvmconfig != "")

  let path_clang = findExe(bin="clang")
  let exe_clang = extractFilename(path_clang)
  let version_clang = gorge("$command --version" % ["command", exe_clang])
  echo version_clang

  let path_clangpp = findExe(bin="clang++")
  let exe_clangpp = extractFilename(path_clangpp)
  let version_clangpp = gorge("$command --version" % ["command", exe_clangpp])
  echo version_clangpp

  let library_path = gorge(exe_clang & " --print-resource-dir")

  let command = getCommand()
  case command
  of "c":
    switch("cc", exe_clang)
  of "cpp":
    switch("cc", exe_clangpp)
  of "js":
    assert false, msg = "The LLVM compiler is not supported when targeting Javascript!"
  else:
    switch("cc", exe_clang)


  