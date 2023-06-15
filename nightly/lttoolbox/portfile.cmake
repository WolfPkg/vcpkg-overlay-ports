vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO apertium/lttoolbox
	REF 3be1a443773469e2201a8c672abaf563ded7cbce
	SHA512 a1d452e91ef84b6c5cf947acfa2148353da5c3a2ecc2728b803f10c4f825ffb0a42bdbfa086d5ea622fb1e974385fe787aede3dbd00e30b2b268e8b4c753b6e6
	HEAD_REF main
    PATCHES
      "wall-to-w4.patch"
      "no-pthread.patch"
)

vcpkg_find_acquire_program(PYTHON3)
set(VCPKG_PYTHON_EXECUTABLE "${PYTHON3}")

vcpkg_configure_make(
	SOURCE_PATH ${SOURCE_PATH}
	AUTOCONFIG
	OPTIONS
		"CPPFLAGS=\$CPPFLAGS -I${CURRENT_INSTALLED_DIR}/include"
		"CFLAGS=\$CFLAGS -I${CURRENT_INSTALLED_DIR}/include"
		"CXXFLAGS=\$CXXFLAGS -I${CURRENT_INSTALLED_DIR}/include"
)

vcpkg_install_make()

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
