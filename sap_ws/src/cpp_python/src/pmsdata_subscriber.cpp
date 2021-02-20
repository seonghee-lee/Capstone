#include "ros/ros.h"
#include "cpp_python/TopicMsg.h"

void msgCallback(const cpp_python::TopicMsg::ConstPtr& msg){
  ROS_INFO("Recieved data : %d ", msg->pmsdata);
}

int main(int argc, char **argv){
  ros::init(argc, argv, "pmsdata_subscriber");
  ros::NodeHandle nh;
  ros::Subscriber sub=nh.subscribe("pmsdata", 10, msgCallback);

  ros::spin();
  
  return 0;
}
