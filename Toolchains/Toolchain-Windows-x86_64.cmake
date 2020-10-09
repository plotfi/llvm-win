set(LLVM_NATIVE_TOOLCHAIN "/usr")
set(UCRTVersion 10.0.16299.0)
set(VCToolsVersion 14.11.25503)
set(WinSDKRoot "/share/WinSDK")
set(LLVM_MONOREPO_CHECKOUT "/root/llvm-project")
set(APPLE_SWIFT_CHECKOUT "/root/swift")

set(UniversalCRTSdkDir "${WinSDKRoot}/Windows/10/SDK")
set(VCToolsInstallDir "${WinSDKRoot}/Windows/10/MSVC/${VCToolsVersion}")

foreach(var UCRTVersion VCToolsVersion UniversalCRTSdkDir VCToolsInstallDir)
  set(ENV{${var}} "${${var}}")
endforeach()

set(MSVC_BASE "${VCToolsInstallDir}")
set(WINSDK_BASE "${UniversalCRTSdkDir}")
set(WINSDK_VER "${UCRTVersion}")

configure_file("/root/WindowsSDKVFSOverlay.yaml.in"
  "${CMAKE_CURRENT_BINARY_DIR}/windows-sdk-vfs-overlay.yaml"
  @ONLY)

set(MSVC_INCLUDE "${MSVC_BASE}/include")
set(MSVC_LIB "${MSVC_BASE}/lib")
set(WINSDK_INCLUDE "${WINSDK_BASE}/Include/${WINSDK_VER}")
set(WINSDK_LIB "${WINSDK_BASE}/Lib/${WINSDK_VER}")
set(COMPILE_FLAGS "-D_CRT_SECURE_NO_WARNINGS --target=${target} -fms-compatibility-version=19.11 -imsvc ${MSVC_INCLUDE} -imsvc ${WINSDK_INCLUDE}/ucrt -imsvc ${WINSDK_INCLUDE}/shared -imsvc ${WINSDK_INCLUDE}/um -imsvc ${WINSDK_INCLUDE}/winrt -Xclang -ivfsoverlay -Xclang ${CMAKE_CURRENT_BINARY_DIR}/windows-sdk-vfs-overlay.yaml")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /Zc:twoPhase ${COMPILE_FLAG}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zc:twoPhase ${COMPILE_FLAG}" CACHE STRING "" FORCE)

include("${LLVM_MONOREPO_CHECKOUT}/llvm/cmake/platforms/WinMsvc.cmake")
