
set(CONTEST_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# find samples
file(GLOB TASK_SAMPLES RELATIVE ${CONTEST_DIR} samples-*.zip)

# extract samples
foreach(TASK_SAMPLE IN LISTS TASK_SAMPLES)
    string(REPLACE samples- "" TASK_NAME ${TASK_SAMPLE})
    string(REPLACE .zip "" TASK_NAME ${TASK_NAME})
    message("Loaded task ${TASK_NAME}.")
    include(${CMAKE_CURRENT_LIST_DIR}/add_task.cmake)
    execute_process(COMMAND ${CMAKE_COMMAND} -E tar x ${CONTEST_DIR}/${TASK_SAMPLE}
            WORKING_DIRECTORY ${CONTEST_DIR}/${TASK_NAME}/samples)
    file(REMOVE ${CONTEST_DIR}/${TASK_SAMPLE})
endforeach()
