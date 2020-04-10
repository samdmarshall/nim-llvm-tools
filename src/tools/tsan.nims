
# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):
  when defined(EnableTSAN):
    echo "Enabling TSAN..."
    switch("passC", "-fsanitize=thread")
    switch("passL", "-lclang_rt.tsan")