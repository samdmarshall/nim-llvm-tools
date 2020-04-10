
when defined(EnableLLVMCompiler):
  when defined(EnableTSAN):
    echo "Enabling TSAN..."
  else:
    echo "Skipping TSAN..."
else:
  echo ""