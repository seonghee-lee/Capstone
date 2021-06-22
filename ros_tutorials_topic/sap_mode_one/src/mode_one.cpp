#include <ros/ros.h> // ROS 기본헤더파일
#include "sap_mode_one/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
//함수 선언
bool moveToGoal(double xGoal, double yGoal);
char choose();
//모의 환경에서 사용하는 좌표 정보
double xspot0=0.08471;
double yspot0=-0.47712;
double xspot1=0.118257;
double yspot1=0.47154422;
double xspot2=0.45796;
double yspot2=-0.07302;
double xspot3=0.38;
double yspot3=0.80;
bool goalReached=false;

int mode;

// 메시지콜백함수로써, 밑에서설정한ros_tutorial_msg라는이름의토픽
// 메시지를수신하였을때동작하는함수이다
// 입력메시지로는ros_tutorials_topic패키지의MsgTutorial메시지를받도록되어있다
void msgCallback(const ros_tutorials_topic::MsgTutorial::ConstPtr& msg)
{
    ROS_INFO("recievemsg= %d", msg->data); // data 메시지를표시한다
    mode=msg->data;
}

int main(int argc, char** argv){
        ros::init(argc, argv, "mode1_node");// 노드명초기화
        ros::NodeHandle n;// ROS 시스템과통신을위한노드핸들선언

        ros::Subscriber mode_sub= n.subscribe("mode_msg", 100, msgCallback);
        // 콜백함수호출을위한함수로써, 메시지가수신되기를대기,
        // 수신되었을경우콜백함수를실행한다

        ROS_INFO("recievemsg= %d", mode); // mode값 표시한다

        ros::spin();
	//사용자로부터 메뉴를 선택받는다.

	char choice='q';
        if(mode==1){
            do{
                    choice=choose();
                    if(choice=='0'){	//0번 스팟으로 이동
                            goalReached=moveToGoal(xspot0,yspot0);
                    }
                    else if(choice=='1'){	//1번 스팟으로 이동
                            goalReached=moveToGoal(xspot1,yspot1);
                    }
                    else if(choice=='2'){	//2번 스팟으로 이동
                            goalReached=moveToGoal(xspot2,yspot2);
                    }
                    else if(choice=='3'){	//3번 스팟으로 이동
                            goalReached=moveToGoal(xspot3,yspot3);
                    }
                    if(choice!='q'){
                            if(goalReached){
                                    ROS_INFO("Congratulations!");
                                    ros::spinOnce();	//목적지 스팟에 도착하면 Congratulations! 출력
                            }
                            else{
                                    ROS_INFO("Hard Luck!");	//정확한 주행 실패 시 Hard Luck! 출력
                            }
                    }
            }while(choice !='q');
        }
	return 0;
}
//특정 스팟 1개로 주행하는 함수이다.
//파라미터: 목적지 스팟 좌표
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
	if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED){	//목적지에 성공적으로 도착했을 경우
		ROS_INFO("You have reached the destination");
		return true;
	}
	else{
		ROS_INFO("The robot failed to reach the destination");	//목적지 도착을 실패했을 경우
		return false;
	}
}
//사용자가 목적지 스팟을 선택하는 함수이다.
char choose(){
	char choice='q';
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|원하는 스팟을 선택하세요."<<std::endl;
	std::cout<<"|'0': Spot 0 "<<std::endl;
	std::cout<<"|'1': Spot 1 "<<std::endl;
	std::cout<<"|'2': Spot 2 "<<std::endl;
	std::cout<<"|'3': Spot 3 "<<std::endl;
	std::cout<<"|'q': 종료 "<<std::endl;
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|WHERE TO GO?";
	std::cin>>choice;
	return choice;
}
