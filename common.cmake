
# TODO: Mess with the preprocessor to achieve single source of truth
# include_directories(include)

set(CMAKE_CXX_STANDARD 17)
set(SCRIPT_ROOT ${CMAKE_CURRENT_LIST_DIR}/scripts)

if (CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options(-Wall -Wextra -Wshadow -Wfloat-equal -Wconversion)
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_compile_options(
                -fsanitize=address,undefined
                -fno-omit-frame-pointer
                -fno-sanitize-recover=all
        )
        add_link_options(
                -fsanitize=address,undefined
                -fno-omit-frame-pointer)
    endif()
endif()

macro(add_sample_tests TASK_NAME)
    add_test(NAME ${TASK_NAME}/build
            COMMAND ${CMAKE_COMMAND} --build ${CMAKE_CURRENT_BINARY_DIR} --target ${TASK_NAME})
    set_tests_properties(${TASK_NAME}/build PROPERTIES FIXTURES_SETUP ${TASK_NAME})
    file(GLOB SAMPLES RELATIVE ${CMAKE_CURRENT_LIST_DIR}/samples samples/*.in)
    foreach(SAMPLE_FILE IN LISTS SAMPLES)
        string(REPLACE .in "" SAMPLE ${SAMPLE_FILE})
        add_test(NAME ${TASK_NAME}/sample-${SAMPLE} COMMAND
                ${SCRIPT_ROOT}/test/perform_test.sh ${CMAKE_CURRENT_BINARY_DIR}/${TASK_NAME} ${CMAKE_CURRENT_LIST_DIR}/samples ${SAMPLE})
        set_tests_properties(${TASK_NAME}/sample-${SAMPLE} PROPERTIES
                TIMEOUT 5
                FIXTURES_REQUIRED ${TASK_NAME})
    endforeach()
endmacro()
