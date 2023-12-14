cmake_minimum_required(VERSION 3.21)
project(dominance VERSION 0.1)

set(CMAKE_CXX_STANDARD 14)

set(SFML_DIR "deps/SFML-2.6.1/lib/cmake/SFML")
find_package(SFML COMPONENTS graphics window system REQUIRED)
add_subdirectory(deps/googletest)
add_executable(Dominance src/Dominance.cpp)

target_link_libraries(Dominance PRIVATE gtest gtest_main sfml-graphics sfml-window sfml-system)

