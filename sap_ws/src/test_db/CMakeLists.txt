################################################################################
# Set minimum required version of cmake, project name and compile options
################################################################################

cmake_minimum_required(VERSION 3.0.2)
project(test_db)

################################################################################
# Set minimum required version of cmake, project name and compile options
################################################################################

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake-modules)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)

find_package(MySqlClient REQUIRED)



################################################
## Declare ROS messages, services and actions ##
################################################

## Generate added messages and services with any dependencies listed here

################################################
## Declare ROS dynamic reconfigure parameters ##
################################################

################################################################################
# Declare catkin specific configuration to be passed to dependent projects
################################################################################
catkin_package(
  CATKIN_DEPENDS
    roscpp
    rospy
    std_msgs
)

###########
## Build ##
###########


include_directories(
  ${catkin_INCLUDE_DIRS}
  ${MYSQL_INCLUDE_DIRS}
)

add_executable(test_db_node src/DBtest.cpp)


target_link_libraries(test_db_node
   ${catkin_LIBRARIES}
   ${MYSQL_LIBRARIES}
)



#############
## Install ##
#############




