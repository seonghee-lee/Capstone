/***************************************************************
Program : mode_publisher
File : mode_publisher.cpp
Function : Publisher
Description : 사용자 선택 모드 전달
Author : SAP Possible
Environment : Ubuntu 16.04 / ROS kinetic
Revisions : 1.0.0 21/08/01 First release
***************************************************************/

#include "ros/ros.h"// ROS 기본 헤더 파일
#include "sap_mode_one/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)

//함수 선언
char choose();

int main(int argc, char **argv) // 노드 메인 함수
{
	ros::init(argc, argv, "mode_publisher"); // 노드명 초기화
	ros::NodeHandle n;// ROS 시스템과 통신을 위한 노드 핸들 선언
	ros::Publisher mode_pub= n.advertise<sap_mode_one::mode_msg>("mode_msg", 100);
	// 루프주기를 설정한다. "10" 이라는것은 10Hz를말하는것으로 0.1초간격으로 반복된다
	ros::Rate loop_rate(10);
	// mode_msg메시지파일형식으로 msg라는 메시지를선언
	sap_mode_one::mode_msg msg;
	
	// 메시지에 사용될 변수 선언
	int count = 0;
	char choice='q';
	
	do{
		choice=choose();
		int n = choice - '0'; // int형으로 형변환
		msg.data=n; // choice라는 변수값을 msg의 하위 data 메시지에 담는다
		if(choice=='1'){ //Mode 1 실행
			mode_pub.publish(msg);// 메시지를발행한다
		}
		else if(choice=='2'){ // Mode 2 실행
			mode_pub.publish(msg); // 메시지를발행한다
		}
		else if(choice=='3'){ // Mode 3 실행
			mode_pub.publish(msg); // 메시지를발행한다 
		}
		else if(choice=='4'){ // Mode 4 실행
			mode_pub.publish(msg); // 메시지를발행한다
		}
		else if(choice=='5'){ // Mode 5 실행
			mode_pub.publish(msg); // 메시지를발행한다
		}
		else if(choice=='0'){ // 정지
			mode_pub.publish(msg); // 메시지를발행한다
		}
	}while(choice !='q'); // 종료
	
	return 0;
}

//사용자가 모드를 선택하는 함수이다.
char choose(){
	char choice='q';
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|원하는 모드를 선택하세요."<<std::endl;
	std::cout<<"| Mode 1: 사용자 설정 스팟 이동 모드 "<<std::endl;
	std::cout<<"| Mode 2: 전체스팟 데이터 측정 모드 "<<std::endl;
	std::cout<<"| Mode 3: 최고 미세먼지 구역 이동 모드 "<<std::endl;
	std::cout<<"| Mode 4: 미세먼지 수치에 따른 자율주행 모드 "<<std::endl;
	std::cout<<"| Mode 5: 순차적 자율주행 모드 "<<std::endl;
	std::cout<<"|'0': 정지"<<std::endl;
	std::cout<<"|'q': 종료 "<<std::endl;
	std::cout<<"|-------------------------------|"<<std::endl;
	std::cout<<"|WHICH MODE?"<<std::endl;
	std::cin>>choice;
	
	return choice;
}
