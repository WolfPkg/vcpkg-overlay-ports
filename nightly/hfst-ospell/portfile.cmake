vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO hfst/hfst-ospell
	REF b3a93cdff19ce82227fd048aaeea47ff66b137fa
	SHA512 ecfa45c7f303ed505297cf39369400b35aa6bdd4b58fd19b86b6bb6e8bc658cc04487127021a11013a766cc640e24978a4f8192e8ca915a2a2632b41dc84f2da
	HEAD_REF cmake
)

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH})
vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/hfst-ospell RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/hfst-ospell)
file(GLOB exes RELATIVE ${CURRENT_PACKAGES_DIR}/bin/ ${CURRENT_PACKAGES_DIR}/bin/*.exe)
foreach(exe ${exes})
	file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/${exe})
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/${exe} ${CURRENT_PACKAGES_DIR}/tools/hfst-ospell/${exe})
endforeach()
