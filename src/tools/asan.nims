
# ==========
# Main Entry
# ==========

echo "Enabling ASAN..."
switch("passC", "-fsanitize=address")
switch("passL", "-lclang_rt.asan")