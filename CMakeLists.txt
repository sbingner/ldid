cmake_minimum_required(VERSION 3.13)

set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_STANDARD 11)

project(ldid)

find_package(PkgConfig REQUIRED)
pkg_check_modules(PLIST REQUIRED libplist)
pkg_check_modules(CRYPTO REQUIRED libcrypto)

if(LDID_STATIC)
    if (APPLE)
        set(LDID_LIBS ${PLIST_LIBDIR}/libplist.a ${CRYPTO_LIBDIR}/libcrypto.a ${CRYPTO_STATIC_LIBRARIES} ${PLIST_STATIC_LIBRARIES})
        list(REMOVE_ITEM LDID_LIBS crypto plist)
    else()
        add_link_options(-static ${CRYPTO_STATIC_LDFLAGS_OTHER} ${PLIST_STATIC_LDFLAGS_OTHER})
        set(LDID_LIBS ${PLIST_STATIC_LIBRARIES} ${CRYPTO_STATIC_LIBRARIES})
    endif()
else()
    set(LDID_LIBS ${PLIST_LIBRARIES} ${CRYPTO_LIBRARIES})
endif()

find_package(Git)
if (!Git_FOUND)
    message(FATAL_ERROR "Git not found!")
endif()

execute_process(
    COMMAND "${GIT_EXECUTABLE}" describe --tags --match=v*
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    COMMAND_ERROR_IS_FATAL ANY
    ERROR_QUIET
    RESULT_VARIABLE res
    OUTPUT_VARIABLE LDID_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE)

string(REGEX REPLACE "-([^-]*)-([^-]*)$" "+\\1.\\2" LDID_VERSION ${LDID_VERSION})
string(REGEX REPLACE "^v" "" LDID_VERSION ${LDID_VERSION})
string(REGEX REPLACE "%" "~" LDID_VERSION ${LDID_VERSION})

add_executable(ldid ldid.cpp lookup2.c)

set_property(SOURCE ldid.cpp APPEND
    PROPERTY COMPILE_DEFINITIONS LDID_VERSION=\"${LDID_VERSION}\"
)

target_link_libraries(ldid
    PUBLIC
    ${LDID_LIBS}
)

target_include_directories(ldid
    PUBLIC
    ${PLIST_INCLUDE_DIRS}
    ${CRYPTO_INCLUDE_DIRS}
)

target_link_directories(ldid
    PUBLIC
    ${PLIST_LIBRARY_DIRS}
    ${CRYPTO_LIBRARY_DIRS}
)

install(TARGETS ldid DESTINATION bin)
