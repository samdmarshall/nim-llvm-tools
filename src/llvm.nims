mode = ScriptMode.Verbose

# =======
# Imports
# =======

import os
import sequtils
import strutils
import parseutils


type
  Library = object
    name: string
    path: string


const
  LibraryName_AddressSanitizer = "clang_rt.asan"
  LibraryName_ThreadSanitizer = "clang_rt.tsan"
  LibraryName_MemorySanitizer = "clang_rt.msan"
  LibraryName_UndefinedBehaviorSanitizer = "clang_rt.ubsan"

# =========
# Functions
# =========

proc normalizeLibraryName(name: string): string =
  result = name
  result.removePrefix("lib")

proc findLibrary(path: string, libname: string): seq[Library] =
  let starting_directory = normalizedPath(path)
  let library_name = normalizeLibraryName(libname)

  let is_valid_directory_path = system.existsDir(starting_directory)
  assert is_valid_directory_path, msg = ""

  for kind, name in walkDir(starting_directory, relative=true):
    #echo "$kind : $name" % ["kind", $kind, "name", name]
    let path_current = starting_directory/name
    case kind
    of pcDir, pcLinkToDir:
      let found_libraries = findLibrary(path_current, library_name)
      result = concat(result, found_libraries)
    else:
      let has_found_match = name.contains(library_name)
      if has_found_match:
        let lib = Library(name: normalizeLibraryName(name), path: starting_directory)
        result.add(lib)


# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):

  let path_clang = findExe(bin="clang")
  let exe_clang = extractFilename(path_clang)

  let path_libraries = gorge("$command --print-resource-dir" % ["command", path_clang])

  # =================
  # Address Sanitizer
  # =================
  when defined(EnableASAN):
    echo "Enabling ASAN..."

    let results_library_asan = findLibrary(path_libraries, LibraryName_AddressSanitizer)

    when not defined(LibraryIndex):
      if len(results_library_asan) > 1:
        echo "Located more than one library with a matching name, please select from the following options:\n"
        var index = 1
        for lib in results_library_asan:
          echo "$index) $name ($path)" % ["index", $index, "name", lib.name, "path", lib.path]
          inc(index)

    switch("passC", "-fsanitize=address")
    when defined(LibraryIndex):
      let library_index = parseInt(LibraryIndex)
      let chosen_library = results_library_asan[library_index]
      switch("passL", "-L$path" % ["path", chosen_library.path])
      switch("passL", "-l$name" % ["name", chosen_library.name])
    else:
      switch("passL", "-l$name" % ["name", LibraryName_AddressSanitizer.toDll()])

  # ================
  # Thread Sanitizer
  # ================
  when defined(EnableTSAN):
    echo "Enabling TSAN..."

    let results_library_tsan = findLibrary(path_libraries, LibraryName_ThreadSanitizer)

    switch("passC", "-fsanitize=thread")
    when defined(LibraryIndex):
      let library_index = parseInt(LibraryIndex) - 1
      let chosen_library = results_library_tsan[library_index]
      switch("passL", "-L$path" % ["path", chosen_library.path])
      switch("passL", "-l$name" % ["name", chosen_library.name])
    else:
      switch("passL", "-l$name" % ["name", LibraryName_ThreadSanitizer.toDll()])
  # ================
  # Memory Sanitizer
  # ================
  when defined(EnableMSAN):
    echo "Enabling MSAN..."

    let results_library_msan = findLibrary(path_libraries, LibraryName_MemorySanitizer)

    switch("passC", "-fsanitize=memory")
    when defined(LibraryIndex):
      let library_index = parseInt(LibraryIndex) - 1
      let chosen_library = results_library_msan[library_index]
      switch("passL", "-L$path" % ["path", chosen_library.path])
      switch("passL", "-l$name" % ["name", chosen_library.name])
    else:
      switch("passL", "-l$name" % ["name", LibraryName_MemorySanitizer.toDll()])

  # ============================
  # Undefined Behavior Sanitizer
  # ============================
  when defined(EnableUBSAN):
    echo "Enabling UBSAN..."

    let paths_library_ubsan = findLibrary(path_libraries, LibraryName_UndefinedBehaviorSanitizer)

    switch("passC", "-fsanitize=undefined")
    when defined(LibraryIndex):
      let library_index = parseInt(LibraryIndex) - 1
      let chosen_library = results_library_ubsan[library_index]
      switch("passL", "-L$path" % ["path", chosen_library.path])
      switch("passL", "-l$name" % ["name", chosen_library.name])
    else:
      switch("passL", "-l$name" % ["name", LibraryName_UndefinedBehaviorSanitizer.toDll()])
