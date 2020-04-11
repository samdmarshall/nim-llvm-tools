
# ==========
# Main Entry
# ==========

when defined(EnableLLVMCompiler):
  when defined(EnableMSAN):
    echo "Enabling MSAN..."
    switch("passC", "-fsanitize=memory")
    