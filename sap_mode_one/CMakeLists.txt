################################################################################
# Set minimum required version of cmake, project name and compile options
################################################################################
cmake_minimum_required(VERSION 2.8.3)
project(sap_mode_one)

################################################################################
# Find catkin packages and libraries for catkin and system dependencies
################################################################################
#새로 추가
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  actionlib
  actionlib_msgs
  nav_msgs
  message_generation
  move_base_msgs
)

################################################################################
# Setup for python modules and scripts
################################################################################

################################################################################
# Declare ROS messages, services and actions
################################################################################
#add_action_files(
#  DIRECTORY action
#)

#add_message_files(FILES 파일명.msg)
add_message_files(FILES Msg.msg)

generate_messages(
  DEPENDENCIES
    std_msgs
    actionlib_msgs
    move_base_msgs
)
################################################################################
# Declare ROS dynamic reconfigure parameters
################################################################################

################################################################################
# Declare catkin specific configuration to be passed to dependent projects
################################################################################
catkin_package(
  CATKIN_DEPENDS 
    roscpp
    std_msgs
    actionlib
    actionlib_msgs
    nav_msgs
    move_base_msgs
)

################################################################################
# Build
################################################################################
include_directories(
  ${catkin_INCLUDE_DIRS}
)
##test_navigation 노드에 대한 빌드 옵
#add_executable(mode1_node src/mode_one.pp)

#target_link_libraries(
#  mode1_node 
#  ${catkin_LIBRARIES}
#)

#add_dependencies(
#  mode1_node 
#  ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS}
#)

#set_target_properties(mode1_node PROPERTIES LINKER_LANGUAGE CXX)
##실험 노드에 대한 빌드 옵션
add_executable(node src/mode_one.cpp)

target_link_libraries(
  node
  ${catkin_LIBRARIES}
)

add_dependencies(
  node
  ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS}
)



################################################################################
# Install
################################################################################
install(DIRECTORY launch maps param rviz
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)


################################################################################
# Test
################################################################################
