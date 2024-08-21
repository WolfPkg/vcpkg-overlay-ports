vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO apertium/lttoolbox
	REF b248842a216a470f8bb47d31f5ec7c746d6935e1
	SHA512 728d77975f67e1dc6186b41ca6b15a666f471e04997cf2d48df8fcea411c8048812c1c0d0137629cc98fb60e7b35f648c461602d24ed17462c0ec44433267e8f
	HEAD_REF main
	PATCHES
		undo-stoi.patch
)

vcpkg_find_acquire_program(PYTHON3)
set(VCPKG_PYTHON_EXECUTABLE "${PYTHON3}")

vcpkg_configure_cmake(
	SOURCE_PATH ${SOURCE_PATH}
	OPTIONS -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_pkgconfig()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/lttoolbox RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/lttoolbox)
file(GLOB exes RELATIVE ${CURRENT_PACKAGES_DIR}/bin/ ${CURRENT_PACKAGES_DIR}/bin/*.exe)
foreach(exe ${exes})
	file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/${exe})
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/${exe} ${CURRENT_PACKAGES_DIR}/tools/lttoolbox/${exe})
endforeach()
