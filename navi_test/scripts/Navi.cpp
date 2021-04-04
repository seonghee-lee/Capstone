#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include "navi_test/TopicMsg.h"

class Navi{
private:
   ros::NodeHandle n;
   ros::Subscriber sub;
   bool goalReached=false;

   /** declare the coordinates of interest **/
   double xspot0=0.409321165513;
   double yspot0=0.807000009102;
   double xspot1 = 0.423739669195;
   double yspot1 = 0.0138367868571;
   double xspot2 = 0.0681377527852;
   double yspot2 = 0.468984252043;
   double xspot3 = 0.05678169183;
   double yspot3 = -0.550405495116;
public:
   Navi(ros::NodeHandle n);//생성자
   ~Navi();//소멸자
   void msgCallback(const navi_test::TopicMsg::ConstPtr& msg);
   bool moveToGoal(double xGoal, double yGoal);
   void testValue();
};
Navi::Navi(ros::NodeHandle n) {//생성자
   testValue();
   sub=n.subscribe("pmsdata", 10, &Navi::msgCallback,this);
}
Navi::~Navi(){//소멸

}
void Navi::msgCallback(const navi_test::TopicMsg::ConstPtr& msg){
  ROS_INFO("Recieved data : %d ", msg->pmsdata);
}

bool Navi::moveToGoal(double xGoal, double yGoal){
    //define a client for to send goal requests to the move_base server through a SimpleActionClient
   actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> ac("move_base", true);

   //wait for the action server to come up
   while(!ac.waitForServer(ros::Duration(5.0))){
      ROS_INFO("Waiting for the move_base action server to come up");
   }

   move_base_msgs::MoveBaseGoal goal;

   //set up the frame parameters
   goal.target_pose.header.frame_id = "map";
   goal.target_pose.header.stamp = ros::Time::now();

   /* moving towards the goal*/

   goal.target_pose.pose.position.x =  xGoal;
   goal.target_pose.pose.position.y =  yGoal;
   goal.target_pose.pose.position.z =  0.0;
   goal.target_pose.pose.orientation.x = 0.0;
   goal.target_pose.pose.orientation.y = 0.0;
   goal.target_pose.pose.orientation.z = 0.0;
   goal.target_pose.pose.orientation.w = 1.0;

   ROS_INFO("Sending goal location ...");
   ac.sendGoal(goal);

   ac.waitForResult();

   if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED){
      ROS_INFO("You have reached the destination");
      return true;
   }
   else{
      ROS_INFO("The robot failed to reach the destination");
      return false;
   }
}

void Navi::testValue(){

    goalReached=moveToGoal(xspot0, yspot0);
    ros::Duration(10).sleep(); // sleep for 10 seconds
    if(goalReached) ROS_INFO("Congratulations!");
    else ROS_INFO("Hard Luck!");

    goalReached=moveToGoal(xspot1, yspot1);
    ros::Duration(10).sleep(); // sleep for 10 seconds
    if(goalReached) ROS_INFO("Congratulations!");
    else ROS_INFO("Hard Luck!");

    goalReached=moveToGoal(xspot2, yspot2);
    ros::Duration(10).sleep(); // sleep for 10 seconds
    if(goalReached) ROS_INFO("Congratulations!");
    else ROS_INFO("Hard Luck!");

    goalReached=moveToGoal(xspot3, yspot3);
    ros::Duration(10).sleep(); // sleep for 10 seconds
    if(goalReached) ROS_INFO("Congratulations!");
    else ROS_INFO("Hard Luck!");


}

int main(int argc, char** argv){
   ros::init(argc, argv, "navi_test_node");
   ros::NodeHandle n;
   ros::spinOnce();


   Navi navi(n);

   return 0;
}

