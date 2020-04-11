
# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):
  when defined(EnableUBSAN):
    echo "Enabling UBSAN..."
    switch("passC", "-fsanitize=undefined")
    switch("passL", "-lclang_rt.ubsan")