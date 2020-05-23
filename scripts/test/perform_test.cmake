# Arg: EXECUTABLE_FILE
# Arg: SAMPLE_ROOT
# Arg: SAMPLE

# TODO: This is probably not platform independent
set(DIFF_COMMAND diff -byd -W 80)

set(SAMPLE_INPUT ${SAMPLE_ROOT}/${SAMPLE}.in)
set(SAMPLE_OUTPUT ${SAMPLE_ROOT}/${SAMPLE}.out)
set(RESULT_OUTPUT ${SAMPLE_ROOT}/${SAMPLE}.result)
set(RESULT_DIFF ${SAMPLE_ROOT}/${SAMPLE}.result.diff)
set(RESULT_ERROR ${SAMPLE_ROOT}/${SAMPLE}.result.err)

file(REMOVE ${RESULT_ERROR})
file(REMOVE ${RESULT_OUTPUT})
file(REMOVE ${RESULT_DIFF})

execute_process(COMMAND ${EXECUTABLE_FILE}
        INPUT_FILE ${SAMPLE_INPUT}
        OUTPUT_FILE ${RESULT_OUTPUT}
        ERROR_VARIABLE EXECUTION_ERROR
        RESULT_VARIABLE EXECUTION_RESULT)

if (NOT EXECUTION_RESULT EQUAL "0")
    file(WRITE ${RESULT_ERROR} "EXIT CODE: ${EXECUTION_RESULT}\n\n")
    file(APPEND ${RESULT_ERROR} ${EXECUTION_ERROR})
    message(SEND_ERROR "Run Error")
endif()

execute_process(COMMAND ${DIFF_COMMAND} ${RESULT_OUTPUT} ${SAMPLE_OUTPUT}
        OUTPUT_VARIABLE DIFF_OUTPUT
        RESULT_VARIABLE DIFF_RESULT)

if (NOT DIFF_RESULT EQUAL "0")
    file(WRITE ${RESULT_DIFF}
            "Wrong Answer                            Correct Answer\n"
            "------------------------------------------------------\n")
    file(APPEND ${RESULT_DIFF} ${DIFF_OUTPUT})
    message(SEND_ERROR "")
    string(LENGTH ${DIFF_OUTPUT} DIFF_LENGTH)
    if (DIFF_LENGTH LESS "1000")
        message("Wrong Answer                            Correct Answer")
        message("------------------------------------------------------")
        message(${DIFF_OUTPUT})
    else()
        message("See ${RESULT_DIFF}")
    endif()
endif()
