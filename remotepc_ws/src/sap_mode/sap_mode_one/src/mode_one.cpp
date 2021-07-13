/***************************************************************
Program : mode_one
File : mode_one.cpp
Function : Subscriber
Description : 사용자 설정 스팟 이동 모드
Author : SAP Possible
Environment : Ubuntu 16.04 / ROS kinetic
Revisions : 1.0.0 21/08/01 First release
***************************************************************/

#include <ros/ros.h> // ROS 기본헤더파일
#include "sap_mode_one/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>

//함수 선언
bool moveToGoal(double xGoal, double yGoal);
char choose();

//모의 환경에서 사용하는 좌표 정보
double xspot0=-1.2496;
double yspot0=-3.395;
double xspot1=-0.8941;
double yspot1=-0.5606;
double xspot2=0.0365;
double yspot2=-1.8533;
double xspot3=0.3837;
double yspot3=-0.0119;
bool goalReached=false;

class Mode{
private:
    ros::NodeHandle n;
    ros::Subscriber mode_sub;
    int mode_data;
public:
    Mode(ros::NodeHandle n);
    ~Mode();
    void modeMsgCallback(const sap_mode_one::mode_msg::ConstPtr& msg);
    int getMode();
};

//Constructor
Mode::Mode(ros::NodeHandle nh):n(nh){
    mode_sub = n.subscribe("mode_msg", 100, &Mode::modeMsgCallback, this);
}

//Destructor
Mode::~Mode(){}

// 메시지콜백함수로써, 밑에서설정 msg라는 이름의 토픽
// 메시지를 수신하였을때 동작하는 함수이다
// 입력메시지로는 sap_mode_one패키지의 mode_msg메시지를 받도록되어있다
void Mode::modeMsgCallback(const sap_mode_one::mode_msg::ConstPtr &msg) {
        ROS_INFO("Received data: %d", msg->data);
        mode_data=msg->data;
}
int Mode::getMode(){
    return mode_data;
}

int main(int argc, char** argv){ // 노드 메인 함수
	ros::init(argc, argv, "mode1_node");// 노드명 초기화
	ros::NodeHandle nh;// ROS 시스템과 통신을 위한 노드핸들 선언
	int mode_data; // 현재 선택된 모드
	char choice='q'; // 목적지 스팟
	Mode mode(nh);
	
	while(true){
		ros::spinOnce();
		// 사용자로부터 모드 선택을 받는다.
		ros::Duration(1).sleep();
		mode_data= mode.getMode(); // 현재 선택된 모드를 mode_data에 저장
		ROS_INFO("mode= %d", mode_data); // 현재 선택된 모드를 표시한다
		if(mode_data==1){
		    choice=choose();
		    if(choice=='0'){ // 0번 스팟으로 이동
				goalReached=moveToGoal(xspot0,yspot0);
		    }
		    else if(choice=='1'){ // 1번 스팟으로 이동
				goalReached=moveToGoal(xspot1,yspot1);
		    }
		    else if(choice=='2'){ // 2번 스팟으로 이동
				goalReached=moveToGoal(xspot2,yspot2);
		    }
		    else if(choice=='3'){ // 3번 스팟으로 이동
				goalReached=moveToGoal(xspot3,yspot3);
		    }
		    if(choice!='q'){
				if(goalReached){ // 목적지 스팟에 도착했으면 Congratulations! 출력
					ROS_INFO("Congratulations!");
					ros::spinOnce();	
				}
				else{
					ROS_INFO("Hard Luck!");	// 정확한 주행 실패 시 Hard Luck! 출력
				}
			}
		}
	}
	return 0;
}

// 특정 스팟 1개로 주행하는 함수이다.
// 파라미터: 목적지 스팟 좌표
bool moveToGoal(double xGoal, double yGoal){
//define a client for to send goal requests to the move_base server through a SimpleActionClient
	actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> ac("move_base", true);
	//wait for the action server to come up
	while(!ac.waitForServer(ros::Duration(5.0))){
		ROS_INFO("Waiting for the move_base action server to come up");
	}
	move_base_msgs::MoveBaseGoal goal;
	//set up the frame parameters
	goal.target_pose.header.frame_id ="map";
	goal.target_pose.header.stamp = ros::Time::now();
	//목적지로 주행
	goal.target_pose.pose.position.x =  xGoal;
	goal.target_pose.pose.position.y =  yGoal;
	goal.target_pose.pose.position.z =  0.0;
	goal.target_pose.pose.orientation.x =0.0;
	goal.target_pose.pose.orientation.y =0.0;
	goal.target_pose.pose.orientation.z =0.0;
	goal.target_pose.pose.orientation.w =1.0;
	ROS_INFO("Sending goal location ...");
	ac.sendGoal(goal);
	ac.waitForResult();
	if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED){ // 목적지에 성공적으로 도착했을 경우
		ROS_INFO("You have reached the destination");
		return true;
	}
	else{ // 목적지 도착을 실패했을 경우
		ROS_INFO("The robot failed to reach the destination");
		return false;
	}
}

// 사용자가 목적지 스팟을 선택하는 함수이다.
char choose(){
	char choice='q';
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|원하는 스팟을 선택하세요."<<std::endl;
	std::cout<<"|'0': Spot 0 "<<std::endl;
	std::cout<<"|'1': Spot 1 "<<std::endl;
	std::cout<<"|'2': Spot 2 "<<std::endl;
	std::cout<<"|'3': Spot 3 "<<std::endl;
	//std::cout<<"|'q': 종료 "<<std::endl;
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|WHERE TO GO?";
	std::cin>>choice;
	return choice;
}
