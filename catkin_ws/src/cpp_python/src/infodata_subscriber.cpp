#include "ros/ros.h"
#include "std_msgs/Int32.h"
#include "cpp_python/Msg.h"

void msgCallback(const cpp_python::Msg::ConstPtr& msg)
{
   ROS_INFO("Recieved: [%d]", msg->pmsdata);
}

int main(int argc, char **argv){

   ros::init(argc, argv, "infodata_subscriber_node");
   ros::NodeHandle n;
   ros::Subscriber sub = n.subscribe("/infodata", 10, msgCallback);

   ros::spin();

   return 0;
}
