cmake_minimum_required(VERSION 3.21)
project(dominance VERSION 0.1)

set(CMAKE_CXX_STANDARD 11)

set(SFML_DIR "deps/x86_64-linux-gnu/SFML-2.6.1/lib/cmake/SFML")
find_package(SFML COMPONENTS graphics window system REQUIRED)

add_executable(Dominance src/Dominance.cpp)

target_link_libraries(Dominance PRIVATE sfml-graphics sfml-window sfml-system)

