vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO mhulden/foma
	REF fe40aceea1797642dd1cf0fa61fd024c7a7f7095
	SHA512 c96c49f24fe88fc6fad382965ccc27d912cb9ec95561abc29e7c7b9398098d88f98b343ea10c2d4b817d84b388edb3441395c7cde85ff18bfb0ed108d7c9d6ac
	HEAD_REF master
    PATCHES
      "not-inline.patch"
)

vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(FLEX)

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}/foma"
    OPTIONS
        -DFLEX_EXECUTABLE=${FLEX}
        -DBISON_EXECUTABLE=${BISON}
)

# Flex doesn't like running in parallel
vcpkg_install_cmake(DISABLE_PARALLEL)

file(INSTALL "${SOURCE_PATH}/foma/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/foma" RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/foma)
file(GLOB exes RELATIVE ${CURRENT_PACKAGES_DIR}/bin/ ${CURRENT_PACKAGES_DIR}/bin/*.exe)
foreach(exe ${exes})
	file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/${exe})
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/${exe} ${CURRENT_PACKAGES_DIR}/tools/foma/${exe})
endforeach()
