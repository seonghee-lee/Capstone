################################################################################
# Set minimum required version of cmake, project name and compile options
################################################################################
cmake_minimum_required(VERSION 2.8.3)
project(navi_test)

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



add_message_files(
   FILES
   #Msg.msg
   TopicMsg.msg
#   Message2.msg
 )

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
  LIBRARIES cpp_python
  CATKIN_DEPENDS 
    roscpp
    std_msgs
    actionlib
    actionlib_msgs
    nav_msgs
    move_base_msgs
    message_generation
)

################################################################################
# Build
################################################################################
include_directories(
  ${catkin_INCLUDE_DIRS}
)
##test_navigation 노드에 대한 빌드 옵
add_executable(navi_test_node scripts/Navi.cpp)

target_link_libraries(
  navi_test_node 
  ${catkin_LIBRARIES}
)

add_dependencies(
  navi_test_node 
  ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS}
)

#set_target_properties(map_navigation_node PROPERTIES LINKER_LANGUAGE CXX)




################################################################################
# Install
################################################################################
install(DIRECTORY launch maps param rviz
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)


################################################################################
# Test
################################################################################
