
macro(create_task TASK_NAME)
    add_executable(${TASK_NAME} ${CMAKE_CURRENT_LIST_DIR}/${TASK_NAME}.cpp)
    add_sample_tests(${TASK_NAME})
endmacro()

macro(add_sample_tests TASK_NAME)
    add_test(NAME ${TASK_NAME}/build
            COMMAND ${CMAKE_COMMAND} --build ${CMAKE_CURRENT_BINARY_DIR} --target ${TASK_NAME})
    set_tests_properties(${TASK_NAME}/build PROPERTIES FIXTURES_SETUP ${TASK_NAME}) # Provide Fixture TASK_NAME

    file(GLOB SAMPLES RELATIVE ${CMAKE_CURRENT_LIST_DIR}/samples samples/*.in)
    foreach(SAMPLE_FILE IN LISTS SAMPLES)
        string(REPLACE .in "" SAMPLE ${SAMPLE_FILE})

        if (UNIX)
            add_test(NAME ${TASK_NAME}/sample-${SAMPLE} COMMAND
                    ${SCRIPT_ROOT}/test/perform_test.sh $<TARGET_FILE:${TASK_NAME}> ${CMAKE_CURRENT_LIST_DIR}/samples ${SAMPLE})
        else()
            add_test(NAME ${TASK_NAME}/sample-${SAMPLE}
                    COMMAND ${CMAKE_COMMAND}
                    -D EXECUTABLE_FILE=$<TARGET_FILE:${TASK_NAME}>
                    -D SAMPLE_ROOT=${CMAKE_CURRENT_LIST_DIR}/samples
                    -D SAMPLE=${SAMPLE}
                    -P ${SCRIPT_ROOT}/test/perform_test.cmake)
        endif ()
        set_tests_properties(${TASK_NAME}/sample-${SAMPLE} PROPERTIES
                TIMEOUT 5
                FIXTURES_REQUIRED ${TASK_NAME}) # Require successful build of TASK_NAME
    endforeach()
endmacro()
