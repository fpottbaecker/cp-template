# ARG: CONTEST_NAME

set(TEMPLATE_DIR ${CMAKE_CURRENT_LIST_DIR}/../templates)
set(CONTEST_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${CONTEST_NAME})

# create directory
file(COPY ${TEMPLATE_DIR}/contest/ DESTINATION ${CONTEST_DIR})

# generate project file
file(READ ${TEMPLATE_DIR}/contest.cmake LISTS_TEMPLATE)
string(REPLACE %CONTEST_NAME% ${CONTEST_NAME} LISTS_TEMPLATE ${LISTS_TEMPLATE})
file(WRITE ${CONTEST_DIR}/CMakeLists.txt ${LISTS_TEMPLATE})

# add task to contest contents
file(APPEND ${CMAKE_CURRENT_SOURCE_DIR}/contents.cmake add_subdirectory(\${CMAKE_CURRENT_LIST_DIR}/${CONTEST_NAME})\n)
