
# NOTE: Set the following vars:
# LLVM_NATIVE_TOOLCHAIN
# UCRTVersion
# VCToolsVersion
# WinSDKRoot
# LVM_MONOREPO_CHECKOUT
# APPLE_SWIFT_CHECKOUT

set(target x86_64-unknown-windows-msvc)
# Builtins:
set(BUILTINS_${target}_CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(BUILTINS_${target}_CMAKE_SYSTEM_NAME Windows CACHE STRING "")
set(BUILTINS_${target}_CMAKE_TOOLCHAIN_FILE "${LLVM_RUNTIMES_REPO}/Toolchains/Toolchain-Windows-x86_64.cmake" CACHE FILEPATH "")
set(BUILTINS_${target}_LLVM_ENABLE_PER_TARGET_RUNTIME_DIR NO CACHE BOOL "")
# Runtimes:
set(RUNTIMES_${target}_CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_SYSTEM_NAME Windows CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_SYSROOT "" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_SHARED_LINKER_FLAGS "-fuse-ld=lld" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_MODULE_LINKER_FLAGS "-fuse-ld=lld" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_EXE_LINKER_FLAGS "-fuse-ld=lld" CACHE STRING "")
set(RUNTIMES_${target}_SANITIZER_CXX_ABI "libc++" CACHE STRING "")
set(RUNTIMES_${target}_LLVM_ENABLE_ASSERTIONS ON CACHE BOOL "")
set(RUNTIMES_${target}_SANITIZER_CXX_ABI_INTREE ON CACHE BOOL "")
set(RUNTIMES_${target}_CMAKE_C_FLAGS "" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_CXX_FLAGS "" CACHE STRING "")
set(RUNTIMES_${target}_COMPILER_RT_SANITIZERS_TO_BUILD "asan;cfi;tsan;ubsan_minimal" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_TOOLCHAIN_FILE "${LLVM_RUNTIMES_REPO}/Toolchains/Toolchain-Windows-x86_64.cmake" CACHE FILEPATH "")
# isystem for xray needs to be added to not break Fuchsia
set(RUNTIMES_${target}_COMPILER_RT_BUILD_XRAY OFF CACHE BOOL "")
set(RUNTIMES_${target}_LLVM_ENABLE_RUNTIMES "libcxx;compiler-rt" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_BUILD_WITH_INSTALL_RPATH ON CACHE STRING "")

