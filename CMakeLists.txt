cmake_minimum_required(VERSION 3.21)
project(dominance VERSION 0.1)

set(CMAKE_CXX_STANDARD 17)
set(SFML_DEPS X11 udev Xrandr Xcursor) 
add_executable(${PROJECT_NAME} src/dominance.cpp)


target_include_directories(${PROJECT_NAME}
                           PUBLIC deps/googletest
                           PUBLIC deps/SFML
                          )

target_link_directories(${PROJECT_NAME}
                        PRIVATE deps/googletest/libs
                        PRIVATE deps/SFML/libs
                       )

target_link_libraries(${PROJECT_NAME}
                      gmock
                      gmock_main
                      gtest
                      gtest_main
                      sfml-graphics
                      sfml-window
                      sfml-system
                      sfml-network
                      sfml-audio
                      ${SFML_DEPS}
                     )
