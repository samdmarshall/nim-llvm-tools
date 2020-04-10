mode = ScriptMode.Verbose

# =======
# Imports
# =======

include "tools/asan.nims"
include "tools/tsan.nims"

# ==============
# Main Interface
# ==============

#
let cc_path = findExe("clang")
let cpp_path = findExe("clang++")
let lldb_path = findExe("lldb")


echo cc_path
echo cpp_path
echo lldb_path