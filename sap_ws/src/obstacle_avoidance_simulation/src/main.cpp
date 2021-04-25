#include "obstacle_avoidance/obstacle_avoidance.h"

int main(int argc, char* argv[]) {
  /// Initialize the ROS node
  ros::init(argc, argv, "obstacle_avoidance");
  /// Create object for obstacle avoidance class
  ObstacleAvoidance obstacleAvoidance;
  /// Start the robot to show obstacle avoidance behavior
  obstacleAvoidance.startBot();
  return 0;
}
