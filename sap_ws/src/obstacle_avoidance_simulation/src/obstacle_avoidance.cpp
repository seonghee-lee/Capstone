#include "obstacle_avoidance/obstacle_avoidance.h"

ObstacleAvoidance::ObstacleAvoidance() {
  ROS_INFO_STREAM("Setting up the robot config for obstacle avoidance...");
  /// Initialize previous with the current value of velocities
  prevLinearVelocity = linearVelocity;
  prevAnguarVelocity = anguarVelocity;
  /// Initialize obstacle detected value with false
  obstacleDetected = false;
  /// Publish the velocities to the robot on the navigation topic
  publishVelocity = nh.advertise<geometry_msgs::Twist>\
               ("/cmd_vel_mux/input/navi", 1000);
  /// Subscribe for data from the laser sensor on the scan topic
  subscibeSensor = nh.subscribe<sensor_msgs::LaserScan>("/scan", 500, \
              &ObstacleAvoidance::sensorCallback, this);
  ROS_INFO_STREAM("Set up complete");
}

ObstacleAvoidance::~ObstacleAvoidance() {
  /// Reset the robot
  resetBot();
}

bool ObstacleAvoidance::checkObstacle() {
  /// Check if obstacle is ahead
  if (getObstacleDetected()) {
    ROS_WARN_STREAM("Obstacle ahead!");
    return true;
  }

  return false;
}

void ObstacleAvoidance::startBot() {
  // Set the publishing rate
  ros::Rate loop_rate(rate);
  while (ros::ok()) {
    if (checkObstacle()) {
      /// Start turning the robot to avoid obstacles
      velocities.linear.x = 0.0;
      velocities.angular.z = anguarVelocity;
      /// Check if velocities have changed
      checkVelocityChanged();
    } else {
        /// Start moving the robot once obstacle is avoided
        velocities.angular.z = 0.0;
        velocities.linear.x = linearVelocity;
        /// Check if velocities have changed
        checkVelocityChanged();
    }

    /// Publish the velocities
    publishVelocity.publish(velocities);
    //. Handle callback
    ros::spinOnce();
    /// Make the system sleep to maintain loop rate
    loop_rate.sleep();
  }
}

void ObstacleAvoidance::sensorCallback(const sensor_msgs::LaserScan::ConstPtr& \
                                       sensorData) {
  /// Read sensor data to get obstacle distances with respect to the robot
  for (const float &range : sensorData->ranges) {
    if (range < distanceThreshold) {
      setObstacleDetected(true);
      return;
    }
  }

  setObstacleDetected(false);
}

void ObstacleAvoidance::resetBot() {
  ROS_INFO_STREAM("Resetting the robot config...");
  /// Reset linear velocities of the both robot
  velocities.linear.x = 0.0;
  velocities.linear.y = 0.0;
  velocities.linear.z = 0.0;
  /// Reset angular velocities of the both robot
  velocities.angular.x = 0.0;
  velocities.angular.y = 0.0;
  velocities.angular.z = 0.0;
  /// Publish the reset velocities
  publishVelocity.publish(velocities);
  ROS_INFO_STREAM("Reset complete");
}

bool ObstacleAvoidance::checkVelocityChanged() {
  /// Linear and angular change simultaneously
  /// Check if both the velocities have changed
  if (velocities.linear.x != prevLinearVelocity and \
      velocities.angular.z != prevAnguarVelocity) {
    ROS_DEBUG_STREAM("Velocity of the robot changed");
    /// Update previous velocities
    velocities.linear.x = prevLinearVelocity;
    velocities.angular.z = prevAnguarVelocity;
    return true;
  }

  return false;
}
