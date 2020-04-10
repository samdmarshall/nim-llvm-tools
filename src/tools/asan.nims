
when defined(EnableLLVMCompiler):
  when defined(EnableASAN):
    echo "Enabling ASAN..."
  else:
    echo "Skipping ASAN..."
else:
  echo ""