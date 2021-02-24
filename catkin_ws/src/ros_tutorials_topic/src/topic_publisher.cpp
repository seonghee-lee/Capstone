#include "ros/ros.h"	//ros 기본 헤더파일
#include "ros_tutorials_topic/MsgTutorial.h"	//MsgTutorial 메시지 파일 헤더(빌드 후 자동 생성됨)

int main(int argc, char **argv){	//노드 메인 함수
	ros::init(argc, argv, "topic_publisher");	//노드명 초기화
	ros::NodeHandle nh;	//ROS 시스템과 통신을 위한 노드 핸들 선언
	//퍼블리셔 선언, ros_tutorials_topic 패키지의 MsgTutorial 메시지 파일을 이용한
	//퍼블리셔 ros_tutorial_pub를 작성한다. 토픽명은 "ros_tutorial_msg" 이며,
	//퍼블리셔 큐(queue) 사이즈를 100개로 설정한다는 것이다.
	ros::Publisher ros_tutorial_pub = nh.advertise<ros_tutorials_topic::MsgTutorial>("ros_tutorial_msg", 100);

	//루프 주기를 설정한다. "10" 이라는 것은 10Hz를 말하는 것으로 0.1초 간격으로 반복된다.
	ros::Rate loop_rate(10);

	//MsgTutorial 메시지 파일 형식으로 msg라는 메시지를 선언
	ros_tutorials_topic::MsgTutorial msg;

	//메시지에 사용될 변수 선언
	int count=0;

	while(ros::ok()){
	  //	msg.stamp=ros::Time::now();
		msg.pmsdata=count;

		//	ROS_INFO("send msg= %d", msg.stamp.sec);
		//	ROS_INFO("send msg= %d", msg.stamp.nsec);
		ROS_INFO("send msg= %d", msg.pmsdata);

		ros_tutorial_pub.publish(msg);	//메시지를 발행한다.
		loop_rate.sleep(); 	//위에서 정한 루프 주기에 따라 슬립에 들어간다.
		
		++count;
	}
	
	return 0;
}

