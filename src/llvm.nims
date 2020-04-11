mode = ScriptMode.Verbose

# =======
# Imports
# =======

import os
import strutils


const
  LibraryName_AddressSanitizer = "clang_rt.asan"
  LibraryName_ThreadSanitizer = "clang_rt.tsan"
  LibraryName_MemorySanitizer = "clang_rt.msan"
  LibraryName_UndefinedBehaviorSanitizer = "clang_rt.ubsan"

# =========
# Functions
# =========

proc normalizeLibraryName(name: string): seq[string] =
  result = name
  if name.startsWith("lib"):
    result.removePrefix("lib")

proc findLibrary(path: string, libname: string): string =
  let starting_directory = normalizedPath(path
  let library_name = normalizeLibraryName(libname)
  
  let is_valid_directory_path = existsDir(starting_directory)
  assert is_valid_directory_path, msg = ""

  for kind, path in walkDir(starting_directory):

    case kind
    of pcDir:
      discard
    of pcLinkToDir:
      discard
    else:



# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):

  let path_clang = findExe(bin="clang")
  let exe_clang = extractFilename(path_clang)
  

  
  let paths_library_asan = findLibrary(LibraryName_AddressSanitizer, "")
  let paths_library_tsan = findLibrary(LibraryName_ThreadSanitizer, "")
  let paths_library_msan = findLibrary(LibraryName_MemorySanitizer, "")
  let paths_library_ubsan = findLibrary(LibraryName_UndefinedBehaviorSanitizer, "")

  # =================
  # Address Sanitizer
  # =================
  when defined(EnableASAN):
    echo "Enabling ASAN..."
    switch("passC", "-fsanitize=address")
    switch("passL", "-lclang_rt.asan")

  # ================
  # Thread Sanitizer
  # ================
  when defined(EnableTSAN):
    echo "Enabling TSAN..."
    switch("passC", "-fsanitize=thread")
    switch("passL", "-lclang_rt.tsan")

  # ================
  # Memory Sanitizer
  # ================
  when defined(EnableMSAN):
    echo "Enabling MSAN..."
    switch("passC", "-fsanitize=memory")
    

  # ============================
  # Undefined Behavior Sanitizer
  # ============================
  when defined(EnableUBSAN):
    echo "Enabling UBSAN..."
    switch("passC", "-fsanitize=undefined")
    switch("passL", "-lclang_rt.ubsan")
