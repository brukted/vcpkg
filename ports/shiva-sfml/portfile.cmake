include(vcpkg_common_functions)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Milerius/shiva
        REF 0.9
        SHA512 3086a77377d6cc80eeea78c70f9caab09211e5950720c78c06785002ac80824a75738c7d7b08b69ac3ddc8ca291abd6cf7632ceb6b5783ce2fe79b699ae8a84b
        HEAD_REF master
	)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
          -DSHIVA_BUILD_TESTS=OFF -DSHIVA_USE_SFML_AS_RENDERER=ON -DSHIVA_INSTALL_PLUGINS=ON -DSHIVA_BUILD_EXAMPLES=ON
          
)

vcpkg_install_cmake()


if (VCPKG_CMAKE_SYSTEM_NAME)
  file(GLOB PLUGINS_RELEASE ${SOURCE_PATH}/bin/Release/systems/*)
  file(GLOB PLUGINS_DEBUG ${SOURCE_PATH}/bin/Debug/systems/*)
else()
  file(GLOB PLUGINS_RELEASE ${SOURCE_PATH}/bin/Release/systems/*.dll)
  file(GLOB PLUGINS_DEBUG ${SOURCE_PATH}/bin/Debug/systems/*.dll)
endif()

message(STATUS "PLUGINS_RELEASE -> ${PLUGINS_RELEASE}")
message(STATUS "PLUGINS_DEBUG -> ${PLUGINS_DEBUG}")
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/shiva-sfml)


if (VCPKG_CMAKE_SYSTEM_NAME)
  set(SUFFIX_BINARY lib)
else()
  set(VCPKG_POLICY_DLLS_WITHOUT_LIBS enabled)
  set(SUFFIX_BINARY bin)
endif()

##! Pre removing
if (VCPKG_CMAKE_SYSTEM_NAME)
	file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/lib)
endif()

##! Include
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/include)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/include/shiva-sfml)

##! Release
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY})
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY}/shiva)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY}/shiva/plugins)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml/Release)

##! Debug
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY})
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY}/shiva)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY}/shiva/plugins)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml/Debug)

##! Copy Plugins
file(COPY ${PLUGINS_RELEASE} DESTINATION ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml/Release)
file(COPY ${PLUGINS_DEBUG} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml/Debug)

if (NOT VCPKG_CMAKE_SYSTEM_NAME)
	find_file(LUADLL lua.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(FMTDLL fmt.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(FLACDLL FLAC.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(FREETYPEDLL freetype.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(LIBBZ2DLL libbz2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(LIBPNG16DLL libpng16.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(OGGDLL ogg.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(OPENAL32DLL OpenAL32.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(SFMLAUDIO2DLL sfml-audio-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(SFMLGRAPHICS2DLL sfml-graphics-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(SFMLSYSTEM2DLL sfml-system-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(SFMLWINDOW2DLL sfml-window-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(VORBISDLL vorbis.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(VORBISENCDLL vorbisenc.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(VORBISFILEDLL vorbisfile.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	find_file(ZLIB1DLL zlib1.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)
	set(DEPENDANCIES_RELEASE_DLL
		${LUADLL}
		${FMTDLL}
		${FLACDLL}
		${FREETYPEDLL}
		${LIBBZ2DLL}
		${LIBPNG16DLL}
		${OGGDLL}
		${OPENAL32DLL}
		${SFMLAUDIO2DLL}
		${SFMLGRAPHICS2DLL}
		${SFMLSYSTEM2DLL}
		${SFMLWINDOW2DLL}
		${VORBISDLL}
		${VORBISENCDLL}
		${VORBISFILEDLL}
		${ZLIB1DLL})
		
	find_file(LUADLL_D lua.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(FMTDLL_D fmtd.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(FLACDLL_D FLAC.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(FREETYPEDLL_D freetyped.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(LIBBZ2DLL_D libbz2d.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(LIBPNG16DLL_D libpng16d.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(OGGDLL_D ogg.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(OPENAL32DLL_D OpenAL32.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(SFMLAUDIO2DLL_D sfml-audio-d-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(SFMLGRAPHICS2DLL_D sfml-graphics-d-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(SFMLSYSTEM2DLL_D sfml-system-d-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(SFMLWINDOW2DLL_D sfml-window-d-2.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(VORBISDLL_D vorbis.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(VORBISENCDLL_D vorbisenc.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(VORBISFILEDLL_D vorbisfile.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	find_file(ZLIB1DLL_D zlibd1.dll PATHS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
	set(DEPENDANCIES_DEBUG_DLL
		${LUADLL_D}
		${FMTDLL_D}
		${FLACDLL_D}
		${FREETYPEDLL_D}
		${LIBBZ2DLL_D}
		${LIBPNG16DLL_D}
		${OGGDLL_D}
		${OPENAL32DLL}
		${SFMLAUDIO2DLL_D}
		${SFMLGRAPHICS2DLL_D}
		${SFMLSYSTEM2DLL_D}
		${SFMLWINDOW2DLL_D}
		${VORBISDLL_D}
		${VORBISENCDLL_D}
		${VORBISFILEDLL_D}
		${ZLIB1DLL_D}
		)
	
	file(COPY ${DEPENDANCIES_RELEASE_DLL} DESTINATION ${CURRENT_PACKAGES_DIR}/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml/Release)
    file(COPY ${DEPENDANCIES_DEBUG_DLL} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/${SUFFIX_BINARY}/shiva/plugins/shiva-sfml/Debug)
endif()

file(WRITE ${CURRENT_PACKAGES_DIR}/include/shiva-sfml/empty.h "")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/shiva-sfml/copyright "")
