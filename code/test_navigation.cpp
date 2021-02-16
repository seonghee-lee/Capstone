#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>

/** function declarations **/
bool moveToGoal(double xGoal, double yGoal);
char choose();

/** declare the coordinates of interest **/
double xspot0=0.409321165513;
double yspot0=0.807000009102;
double xspot1=0.423739669195;
double yspot1=0.0138367868571;
double xspot2=0.0681377527852;
double yspot2=0.468984252043;
double xspot3=0.05678169183;
double yspot3=-0.550405495116;

bool goalReached=false;

int main(int argc, char** argv){
	ros::init(argc, argv, "test_navigation_node");
	ros::NodeHandle n;
	ros::spinOnce();

	char choice='q';
	do{
		choice=choose();
		if(choice=='0'){
			goalReached=moveToGoal(xspot0,yspot0);
		}
		else if(choice=='1'){
			goalReached=moveToGoal(xspot1,yspot1);
		}
		else if(choice=='2'){
			goalReached=moveToGoal(xspot2,yspot2);
		}
		else if(choice=='3'){
			goalReached=moveToGoal(xspot3,yspot3);
		}
		if(choice!='q'){
			if(goalReached){
				ROS_INFO("Congratulations!");
				ros::spinOnce();
			}
			else{
				ROS_INFO("Hard Luck!");
			}
		}
	}while(choice != 'q');
	return 0;
}

bool moveToGoal(double xGoal, double yGoal){
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

char choose(){
	char choice='q';
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|PRESSE A KEY:"<<std::endl;
	std::cout<<"|'0': Spot 0 "<<std::endl;
	std::cout<<"|'1': Spot 1 "<<std::endl;
	std::cout<<"|'2': Spot 2 "<<std::endl;
	std::cout<<"|'3': Spot 3 "<<std::endl;
	std::cout<<"|'q': Quit "<<std::endl;
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|WHERE TO GO?";
	std::cin>>choice;

	return choice;
}

