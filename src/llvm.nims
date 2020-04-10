mode = ScriptMode.Verbose

# =========
# Functions
# =========

proc addCompilerFlags*(flags: seq[string]) =
  echo flags

proc addLinkerFlags*(flags: seq[string]) = 
  echo flags


# ==========
# LLVM Tools
# ==========

#[ 
  Uses the flag:
    --define:EnableLLVMCompiler

  This enable the use of the LLVM compiler tools (installed separately) as the 
    compiler instead of whatever the system default is. Since this is the last
    of the config files used, it should override any existing setting. 
]#
include "tools/compiler.nims"


#[
  Uses the flag:
    --define:EnableASAN

  This enables the use of the LLVM Address Sanatizer when building. This should
    only be included as part of Debug builds. Enabling this option requires that
    the 
]#
include "tools/asan.nims"

#[
  Uses the flag:
    --define:EnableTSAN
]#
include "tools/tsan.nims"