################################################################################
# Set minimum required version of cmake, project name and compile options
################################################################################
cmake_minimum_required(VERSION 2.8.3)
project(turtlebot3_navigation)

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

add_message_files(FILES Msgfile.msg)

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
add_executable(test_navigation_node scripts/test_navigation.cpp)

target_link_libraries(
  test_navigation_node 
  ${catkin_LIBRARIES}
)

add_dependencies(
  test_navigation_node 
  ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS}
)

#set_target_properties(map_navigation_node PROPERTIES LINKER_LANGUAGE CXX)

##여기다가 퍼블리셔 빌드 옵션 추가해주기
add_executable(test_node scripts/test1.cpp)
target_link_libraries(
  test_node
  ${catkin_LIBRARIES}
)
add_dependencies(
  test_node
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
