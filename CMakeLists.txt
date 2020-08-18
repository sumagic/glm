cmake_minimum_required(VERSION 3.16.3)

project(glm)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

set(GLM_SRC_LIST ${CMAKE_SOURCE_DIR}/src/main.cc)

add_executable(glm ${GLM_SRC_LIST})
target_link_libraries(glm -lglog -lgflags)
