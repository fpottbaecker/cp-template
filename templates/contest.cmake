if(NOT PROJECT_NAME)
	cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
	project(%CONTEST_PREFIX%-%CONTEST_NAME%)
	include(${CMAKE_CURRENT_LIST_DIR}/../../common.cmake)
endif()

enable_testing()
include(contents.cmake)
