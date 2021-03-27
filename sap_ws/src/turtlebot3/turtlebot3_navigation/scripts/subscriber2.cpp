#include "ros/ros.h" // ROS 기본 헤더파일
#include "turtlebot3_navigation/Msgfile.h" // Msgfile 메시지 파일 헤더 (빌드 후 자동 생성됨)

void msgCallback(const ros_tutorials_topic::MsgTutorial::ConstPtr& msg)
{
	extern char choice=msg->menu;
        ROS_INFO("recieve msg = %d", msg->menu); // menu 메시지를 표시한다
        
}

int main(int argc, char **argv) //노드 메인 함수
{
	ros::init(argc, argv, "topic_subscriber"); //노드명 초기화
	ros::NodeHandle nh; //ROS 시스템과 통신을 위한 노드 핸들 선언

	// 서브스크라이버 선언, ros_tutorials_topic 패키지의 MsgTutorial 메시지 파일을 이용한
	// 서브스크라이버 ros_tutorial_sub 를 작성한다. 토픽명은 "ros_tutorial_msg" 이며,
	// 서브스크라이버 큐(queue) 사이즈를 100개로 설정한다는 것이다
	ros::Subscriber ros_tutorial_sub = nh.subscribe("ros_tutorial_msg", 100, msgCallback);

	
        
        if(choice=='2'){
            ROS_INFO("MENU1 실행", msg->menu);
            // 콜백함수 호출을 위한 함수로써, 메시지가 수신되기를 대기,
            // 수신되었을 경우 콜백함수를 실행한다
            ros::spin();
        }
        else{
            // 콜백함수 호출을 위한 함수로써, 메시지가 수신되기를 대기,
            // 수신되었을 경우 콜백함수를 실행한다
            ros::spin();
        }

	return 0;
}
