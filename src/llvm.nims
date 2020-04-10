mode = ScriptMode.Verbose

# =======
# Imports
# =======

import sequtils
import strutils

# =====
# Types
# =====

type
  Xclang*  = distinct string
  Xlinker* = distinct string  

# ================
# Global Variables
# ================



# =========
# Functions
# =========

proc `$`(col: seq[Xclang|Xlinker]): string =
  result = col.join(" ")

proc `-Xclang`*(flags: seq[string]): seq[Xclang]=
  for flag in flags:
    let tokens = toSeq(tokenize(flag))

proc `-Xlinker`*(flags: seq[string]): seq[Xlinker]=
  for flag in flags:
    let tokens = toSeq(tokenize(flag))


# ==========
# Main Entry
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