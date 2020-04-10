
# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):
  when defined(EnableASAN):
    echo "Enabling ASAN..."
    switch("passC", "-fsanitize=address")
    switch("passL", "-lclang_rt.asan")