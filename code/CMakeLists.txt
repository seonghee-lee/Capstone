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
)

################################################################################
# Setup for python modules and scripts
################################################################################

################################################################################
# Declare ROS messages, services and actions
################################################################################

################################################################################
# Declare ROS dynamic reconfigure parameters
################################################################################

################################################################################
# Declare catkin specific configuration to be passed to dependent projects
################################################################################
catkin_package(
  CATKIN_DEPENDS roscpp std_msgs
)

################################################################################
# Build
################################################################################
include_directories(
  ${catkin_INCLUDE_DIRS}
)
add_executable(test_navigation_node scripts/test_navigation.cpp)
target_link_libraries(test_navigation_node ${catkin_LIBRARIES})
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
