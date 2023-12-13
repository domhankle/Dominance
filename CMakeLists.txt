cmake_minimum_required(VERSION 3.21)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/deps" ${CMAKE_MODULE_PATH})

find_package(SFML 2.5 COMPONENTS system window graphics REQUIRED)

project(dominance VERSION 0.1)


add_executable(Dominance src/Dominance.cpp)


