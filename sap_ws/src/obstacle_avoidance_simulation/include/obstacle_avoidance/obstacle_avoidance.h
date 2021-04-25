#ifndef INCLUDE_OBSTACLE_AVOIDANCE_H_
#define INCLUDE_OBSTACLE_AVOIDANCE_H_

#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Twist.h"

class ObstacleAvoidance {
private:
	/// Define the main access point to communications with the ROS system
	ros::NodeHandle nh;
	/// Define a publisher object with topic name and buffer size of messages
	/// Make sure the listener is subscribed to the same topic name
	ros::Publisher publishVelocity;
	/// Define a subscriber object with topic name and buffer size of messages
	/// Make sure you have subscribed to the correct topic
	ros::Subscriber subscibeSensor;
	/// Initialize linear velocity with 0.2m/s
  const float linearVelocity = 0.2;
  /// Initialize angular velocity with 30degrees/s
  const float anguarVelocity = 0.52;
  /// Initalize safe distance as 1.2m
  const float distanceThreshold = 1.2;
  /// Initialize publishing rate
  const int rate = 2;
	/// Define variable to store if obstacle was detected
	bool obstacleDetected;
  /// Define variables to store previous velocities
  float prevLinearVelocity, prevAnguarVelocity;
	/// Define twist object to publish velocities
	geometry_msgs::Twist velocities;

public:
	/**
	* @brief Constructor for the class
	*/
	ObstacleAvoidance();

	/**
	* @brief Destructor for the class
	*/
	~ObstacleAvoidance();
	
	/**
  * @brief Checks if obstacle is present within safe distance
  * @return boolean obstacle found or not
  */
  bool checkObstacle();

  /**
  * @brief Starts running the bot
  * @return void
  */
  void startBot();

  /**
  * @brief Callback function for subscriber
  * @param msg data from LaserScan node
  * @return void
  */
  void sensorCallback(const sensor_msgs::LaserScan::ConstPtr& msg);

  /**
  * @brief Resets velocities of the bot
  * @return void
  */
  void resetBot();

  /**
  * @brief Checks change in velocites of the bot
  * @return boolean velocity changed or not
  */
  bool checkVelocityChanged();

  /**
  * @brief get obstacle detected
  * @return boolean obstacle detected or not
  */
  bool getObstacleDetected() const {
    return obstacleDetected;
  }

  /**
  * @brief set obstacle detected
  * @param obstacle detected status
  * @return void
  */
  void setObstacleDetected(bool obstacle) {
    obstacleDetected = obstacle;
  }
};

#endif // INCLUDE_OBSTACLE_AVOIDANCE_H_
