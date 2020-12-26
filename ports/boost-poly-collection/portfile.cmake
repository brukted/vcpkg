# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/poly_collection
    REF boost-1.75.0
    SHA512 b647e6256d566117dc35ec3452c849aadbcc06a71b70426d7b41e63e2e369e0c3373628f7a33e2b16eefd86efb128cd03ee7b49473f1d83da775ae2cd1043709
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
