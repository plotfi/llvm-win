set(LLVM_BUILTIN_TARGETS x86_64-unknown-windows-msvc CACHE STRING "")
set(LLVM_RUNTIME_TARGETS x86_64-unknown-windows-msvc CACHE STRING "")

# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /Zc:twoPhase -Xclang -fno-split-cold-code" CACHE STRING "" FORCE)
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zc:twoPhase -Xclang -fno-split-cold-code" CACHE STRING "" FORCE)

set(UCRTVersion 10.0.xxxxx.0)
set(VCToolsVersion 14.11.xxxxx)

set(UniversalCRTSdkDir "/mnt/WinSDK/Windows/10/SDK")
set(VCToolsInstallDir "/mnt/WinSDK/Windows/10/MSVC/${VCToolsVersion}")

foreach(var UCRTVersion VCToolsVersion UniversalCRTSdkDir VCToolsInstallDir)
  set(ENV{${var}} "${${var}}")
endforeach()

set(target x86_64-unknown-windows-msvc)
configure_file("${TOOLCHAIN_SOURCE_DIR}/external/swift/utils/WindowsSDKVFSOverlay.yaml.in"
  "${CMAKE_CURRENT_BINARY_DIR}/windows-sdk-vfs-overlay.yaml"
  @ONLY)

set(MSVC_BASE "${VCToolsInstallDir}")
set(WINSDK_BASE "${UniversalCRTSdkDir}")
set(WINSDK_VER "${UCRTVersion}")
set(MSVC_INCLUDE "${MSVC_BASE}/include")
set(MSVC_LIB "${MSVC_BASE}/lib")
set(WINSDK_INCLUDE "${WINSDK_BASE}/Include/${WINSDK_VER}")
set(WINSDK_LIB "${WINSDK_BASE}/Lib/${WINSDK_VER}")
set(COMPILE_FLAGS "-D_CRT_SECURE_NO_WARNINGS --target=${target} -fms-compatibility-version=19.11 -imsvc ${MSVC_INCLUDE} -imsvc ${WINSDK_INCLUDE}/ucrt -imsvc ${WINSDK_INCLUDE}/shared -imsvc ${WINSDK_INCLUDE}/um -imsvc ${WINSDK_INCLUDE}/winrt -Xclang -ivfsoverlay -Xclang ${CMAKE_CURRENT_BINARY_DIR}/windows-sdk-vfs-overlay.yaml")

set(BUILTINS_${target}_CMAKE_SYSTEM_NAME Windows CACHE STRING "")
set(BUILTINS_${target}_CMAKE_SYSTEM_PROCESSOR X86_64 CACHE STRING "")
set(BUILTINS_${target}_CMAKE_SYSROOT "/var/empty" CACHE STRING "")
set(BUILTINS_${target}_MSVC_BASE "${MSVC_BASE}" CACHE STRING "")
set(BUILTINS_${target}_WINSDK_BASE "${WINSDK_BASE}" CACHE STRING "")
set(BUILTINS_${target}_WINSDK_VER "${WINSDK_VER}" CACHE STRING "")
set(BUILTINS_${target}_CMAKE_C_FLAGS "${COMPILE_FLAGS}" CACHE STRING "")

set(BUILTINS_${target}_CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(BUILTINS_${target}_CMAKE_SYSTEM_NAME Windows CACHE STRING "")
set(BUILTINS_${target}_LLVM_ENABLE_PER_TARGET_RUNTIME_DIR NO CACHE BOOL "")

set(RUNTIMES_${target}_CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_SYSTEM_NAME Windows CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_SYSROOT "" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_SHARED_LINKER_FLAGS "-fuse-ld=lld" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_MODULE_LINKER_FLAGS "-fuse-ld=lld" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_EXE_LINKER_FLAGS "-fuse-ld=lld" CACHE STRING "")
set(RUNTIMES_${target}_SANITIZER_CXX_ABI "libc++" CACHE STRING "")
set(RUNTIMES_${target}_LLVM_ENABLE_ASSERTIONS ON CACHE BOOL "")
set(RUNTIMES_${target}_SANITIZER_CXX_ABI_INTREE ON CACHE BOOL "")
# set(RUNTIMES_${target}_CMAKE_C_FLAGS "-Xclang -fno-split-cold-code" CACHE STRING "")
# set(RUNTIMES_${target}_CMAKE_CXX_FLAGS "-Xclang -fno-split-cold-code" CACHE STRING "")
set(RUNTIMES_${target}_COMPILER_RT_SANITIZERS_TO_BUILD "asan;cfi;tsan;ubsan_minimal" CACHE STRING "")
set(RUNTIMES_${target}_LLVM_ENABLE_RUNTIMES "libcxx;compiler-rt" CACHE STRING "")
set(RUNTIMES_${target}_CMAKE_BUILD_WITH_INSTALL_RPATH ON CACHE STRING "")

# NOTE: isystem for xray needs to be added to not break Fuchsia
# set(RUNTIMES_${target}_COMPILER_RT_BUILD_XRAY OFF CACHE BOOL "")

# set(BUILTINS_${target}_CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../toolchains/Toolchain-Windows-x86_64.cmake" CACHE FILEPATH "")
# set(RUNTIMES_${target}_CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../toolchains/Toolchain-Windows-x86_64.cmake" CACHE FILEPATH "")

# Defer the rest to the LLVM Windows cross-compilation toolchain.
include("/root/llvm-project/llvm/cmake/platforms/WinMsvc.cmake")


