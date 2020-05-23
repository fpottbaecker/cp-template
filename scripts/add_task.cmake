# ARG: TASK_NAME

set(TEMPLATE_DIR ${CMAKE_CURRENT_LIST_DIR}/../templates)
set(TASK_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${TASK_NAME})

# create directory
file(COPY ${TEMPLATE_DIR}/task/ DESTINATION ${TASK_DIR})

# copy template
file(COPY ${TEMPLATE_DIR}/template.cpp DESTINATION ${TASK_DIR})
file(RENAME ${TASK_DIR}/template.cpp ${TASK_DIR}/${TASK_NAME}.cpp)
#file(GENERATE OUTPUT ${TASK_DIR}/${TASK_NAME}.cpp INPUT ${TEMPLATE_DIR}/template.cpp)

# generate project file
file(READ ${TEMPLATE_DIR}/task.cmake LISTS_TEMPLATE)
string(REPLACE %TASK_NAME% ${TASK_NAME} LISTS_TEMPLATE ${LISTS_TEMPLATE})
file(WRITE ${TASK_DIR}/CMakeLists.txt ${LISTS_TEMPLATE})

# add task to contest contents
file(APPEND ${CMAKE_CURRENT_SOURCE_DIR}/contents.cmake add_subdirectory(\${CMAKE_CURRENT_LIST_DIR}/${TASK_NAME}) \n)
