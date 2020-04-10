
when defined(EnableLLVMCompiler):
  echo "CC = clang"
  echo "CPP = clang++"

  let cc_path = findExe("clang")
  let cpp_path = findExe("clang++")

  switch("cc", cc_path)
  switch("c++", cpp_path)