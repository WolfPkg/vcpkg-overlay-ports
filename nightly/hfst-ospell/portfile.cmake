vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO hfst/hfst-ospell
	REF 9bed46c895a920e6d2050b37341f36c2f840e336
	SHA512 24cdd5ee0e586f21ad17ce26bf011a66b9ac0163f7da7f9863fcbeb4d4fcfe52ec325748fbfebfbe63bc4fae7fc85027429f78b061f42d36d59a70b839561e6c
	HEAD_REF master
)

vcpkg_configure_make(
	SOURCE_PATH ${SOURCE_PATH}
	AUTOCONFIG
	OPTIONS
		--disable-static
		--enable-zhfst
		--without-libxmlpp
		--without-tinyxml2
		"LDFLAGS=\$LDFLAGS -lgetopt"
)

vcpkg_install_make()

vcpkg_fixup_pkgconfig()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/hfst-ospell RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/hfst-ospell)
file(GLOB exes RELATIVE ${CURRENT_PACKAGES_DIR}/bin/ ${CURRENT_PACKAGES_DIR}/bin/*.exe)
foreach(exe ${exes})
	file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/${exe})
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/${exe} ${CURRENT_PACKAGES_DIR}/tools/hfst-ospell/${exe})
endforeach()
