if(!PROJECT_NAME)
	cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
	project(%REPO_NAME%-%CONTEST_NAME%)

	set(CMAKE_CXX_STANDARD 17)
	include_directories(${CMAKE_CURRENT_LIST_DIR}/../../include)
endif()

include(contents.cmake)
