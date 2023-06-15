vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO GrammarSoft/cg3
	REF 7b7c0b48236c845ee61e1b0e195e251cf615a940
	SHA512 30e137f933e8a48a1a09d847115bd689ef15ec886b4e82e720c5e68b60b5f1e0ff38c37e607fe5c4f84d3735c55ab54b656e9c3adc3f478f50b6172d8b88ae67
	HEAD_REF main
	PATCHES
		"workaround-lnk1000.patch"
)

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_install_cmake()

vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/cg3" RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/cg3)
file(GLOB exes RELATIVE ${CURRENT_PACKAGES_DIR}/bin/ ${CURRENT_PACKAGES_DIR}/bin/*.exe)
foreach(exe ${exes})
	file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/${exe})
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/${exe} ${CURRENT_PACKAGES_DIR}/tools/cg3/${exe})
endforeach()
