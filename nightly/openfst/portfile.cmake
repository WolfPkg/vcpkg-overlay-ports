set(VERSION 1.7.9)

vcpkg_download_distfile(ARCHIVE
	URLS "https://www.openfst.org/twiki/pub/FST/FstDownload/openfst-${VERSION}.tar.gz"
	FILENAME "openfst-${VERSION}.tar.gz"
	SHA512 7be9734c9c8e83e674fb5ef8dc0db568387b3c1213bd7c3bd91028343505b5450ac6aa10b6986a6bb2ef1f76768569a660822101b5c393449da86552aea3d41c
)

vcpkg_extract_source_archive(SOURCE_PATH
	ARCHIVE "${ARCHIVE}"
)

vcpkg_configure_make(
	SOURCE_PATH ${SOURCE_PATH}
	AUTOCONFIG
	OPTIONS
		"CPPFLAGS=\$CPPFLAGS -DNOMINMAX"
		"CXXFLAGS=\$CXXFLAGS -std:c++17 -W4"
		"LDFLAGS=\$LDFLAGS -Wl,-no-undefined"
)

vcpkg_install_make()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/openfst)
file(GLOB exes RELATIVE ${CURRENT_PACKAGES_DIR}/bin/ ${CURRENT_PACKAGES_DIR}/bin/*.exe)
foreach(exe ${exes})
	file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/${exe})
	file(RENAME ${CURRENT_PACKAGES_DIR}/bin/${exe} ${CURRENT_PACKAGES_DIR}/tools/openfst/${exe})
endforeach()
