/***************************************************************
Program : mode_five
File : mode_five.cpp
Function : Subscriber
Description : 순차적 자율주행 모드
Author : SAP Possible
Environment : Ubuntu 16.04 / ROS kinetic
Revisions : 1.0.0 21/08/01 First release
***************************************************************/

#include <iostream>
#include <ros/ros.h>  // ROS 기본헤더파일
#include <mysql/mysql.h>
#include <string>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include <unistd.h>
#include <algorithm>
#include "std_msgs/String.h"
#include "sap_mode_five/Msg.h" // Msg메시지파일헤더(빌드후자동생성됨)
#include "sap_mode_five/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)
using namespace std;

MYSQL *connection = NULL;
MYSQL_RES *result = NULL;
MYSQL_ROW row;

// 스팟별 정보를 담을 구조체
struct SpotInfo {
	double x_cordinate; // x좌표
	double y_cordinate; // y좌표
	int status; // 스팟의 미세먼지 상태
	int dust_data; // 스팟의 미세먼지 수치
	int init_order;
};

// 딜레이 함수: 미세먼지 기준 상태에 따라 다른 딜레이시간을 리턴한다
// 좋음 – Delay없음 / 보통 – Delay 3분 / 나쁨 – Delay 7분 / 매우 나쁨 – Delay 10분
int delay(SpotInfo* arr_p) {
	if (arr_p->status == 0) {
		cout << "0초" << endl;
		return 0;
	}
	else if (arr_p->status == 1) {
		cout << "10초" << endl;
		return 10;
	}

	else if (arr_p->status == 2) {
		cout << " 15초" << endl;
		return 15;
	}

	else if (arr_p->status == 3) {
		cout << "20초" << endl;
		return 20;
	}

}

// 사용자 선택 모드를 Subscribe하기 위한 클래스
class Mode {
private:
  ros::NodeHandle n;
	ros::Subscriber mode_sub;
	int mode_data = 0;
public:
	Mode(ros::NodeHandle n);
	~Mode();
	void modeMsgCallback(const sap_mode_five::mode_msg::ConstPtr& m_msg);
	int getMode();
};

// Constructor
Mode::Mode(ros::NodeHandle nh) :n(nh) {
	mode_sub = n.subscribe("mode_msg", 10, &Mode::modeMsgCallback, this);
}

// Destructor
Mode::~Mode() {}

// 메시지콜백함수로써, 밑에서설정 msg라는 이름의 토픽
// 메시지를 수신하였을때 동작하는 함수이다
// 입력메시지로는 sap_mode_five패키지의 mode_msg메시지를 받도록 되어있다
void Mode::modeMsgCallback(const sap_mode_five::mode_msg::ConstPtr &m_msg) {
	ROS_INFO("Received data: %d", m_msg->data);
	mode_data = m_msg->data;
}

// 현재 선택된 모드를 반환하는 함수이다
int Mode::getMode() {
	return mode_data;
}

// 자율 주행을 위한 클래스
class Navigation {
public:
	Navigation();
	~Navigation();
	void setSpot(SpotInfo* arr_p, SpotInfo* current);
	bool moveToGoal(double xGoal, double yGoal);
	void inputStatus(SpotInfo* arr_p);
};

// Constructor
Navigation::Navigation() {}

// Destructor
Navigation::~Navigation() {}

// 모의 환경에서 사용하는 좌표 정보를 설정하는 함수이다
void Navigation::setSpot(SpotInfo* arr_p, SpotInfo* current) {
	//스팟의 상태와 미세먼지 수치를 0으로 초기화한다
	for (int i = 0; i < 4; i++) {
		//current->status = 0;
		current->dust_data = 0;
		current++;
	}
	current = arr_p;

	// x,y의 실좌표를 설정한다
	current->init_order = 0;
	current->x_cordinate = -1.2496;
	current->y_cordinate = -3.395;
	current++;

	current->init_order = 1;
	current->x_cordinate = -0.8941;
	current->y_cordinate = -0.5606;
	current++;

	current->init_order = 2;
	current->x_cordinate = 0.0365;
	current->y_cordinate = -1.8533;
	current++;

	current->init_order = 3;
	current->x_cordinate = 0.3837;
	current->y_cordinate = -0.0119;
  
  //모든 좌표의 상태를 출력한다
	for (int i = 0; i < 4; i++) {
		cout << "spot[" << i << "].x_cordinate : " << arr_p->x_cordinate << endl;
		cout << "spot[" << i << "].y_cordinate : " << arr_p->y_cordinate << endl;
		arr_p++;
	}
}
// 특정 스팟 1개로 주행하는 함수이다
// 파라미터: 목적지 스팟 좌표
bool Navigation::moveToGoal(double xGoal, double yGoal) {
	// define a client for to send goal requests to the move_base server through a SimpleActionClient
	actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> ac("move_base", true);
	// wait for the action server to come up
	while (!ac.waitForServer(ros::Duration(5.0))) {
		ROS_INFO("Waiting for the move_base action server to come up");
	}
	move_base_msgs::MoveBaseGoal goal;
	// set up the frame parameters
	goal.target_pose.header.frame_id = "map";
	goal.target_pose.header.stamp = ros::Time::now();
	// 목적지로 주행
	goal.target_pose.pose.position.x = xGoal;
	goal.target_pose.pose.position.y = yGoal;
	goal.target_pose.pose.position.z = 0.0;
	goal.target_pose.pose.orientation.x = 0.0;
	goal.target_pose.pose.orientation.y = 0.0;
	goal.target_pose.pose.orientation.z = 0.0;
	goal.target_pose.pose.orientation.w = 1.0;
	ROS_INFO("Sending goal location ...");
	cout << goal.target_pose.pose.position.x << endl;
	cout << goal.target_pose.pose.position.y << endl;
	cout << xGoal << "," << yGoal << endl;
	ac.sendGoal(goal);
	ac.waitForResult();
	if (ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED) { // 목적지에 성공적으로 도착했을 경우
		ROS_INFO("You have reached the destination");
		return true;
	}
	else { // 목적지 도착을 실패했을 경우
		ROS_INFO("The robot failed to reach the destination");
		return false;
	}
}

// 미세먼지 상태를 설정하는 함수이다
void Navigation::inputStatus(SpotInfo *arr_p) {
	if (arr_p->dust_data <= 30) {
		cout << "spot[" << arr_p->init_order << "] Air quality: VERRY GOOD :D " << endl;
		arr_p->status = 0;
	}
	else if (arr_p->dust_data <= 80) {
		cout << "spot[" << arr_p->init_order << "]Air quality: GOOD :) " << endl;
		arr_p->status = 1;
	}
	else if (arr_p->dust_data <= 150) {
		cout << "spot[" << arr_p->init_order << "]Air quality: BAD :( " << endl;
		arr_p->status = 2;
	}
	else if (arr_p->dust_data > 151) {
		cout << "spot[" << arr_p->init_order << "]Air quality: VERY BAD!!! " << endl;
		arr_p->status = 3;
	}
}

// 미세먼지 데이터를 Subscribe하기 위한 클래스
class Subscriber {
private:
	ros::NodeHandle n;
	ros::Subscriber sub;
	int current_data;
public:
	Subscriber(ros::NodeHandle n);
	~Subscriber();
	void msgCallback(const sap_mode_five::Msg::ConstPtr& msg);
	int getMsg();
};

// Constructor
Subscriber::Subscriber(ros::NodeHandle nh) :n(nh) {
	sub = n.subscribe("pmsdata", 10, &Subscriber::msgCallback, this);
}

// Destructor
Subscriber::~Subscriber() {}

// 메시지콜백함수로써, 밑에서설정 msg라는 이름의 토픽
// 메시지를 수신하였을때 동작하는 함수이다
// 입력메시지로는 sap_mode_five패키지의 Msg메시지를 받도록 되어있다
void Subscriber::msgCallback(const sap_mode_five::Msg::ConstPtr &msg) { // 라즈베리파이로부터 미세먼지 데이터를 받는다
	cout << "Received data: " << msg->pmsdata << endl; // 미세먼지 수치를 출력
	current_data = msg->pmsdata; // current_data 변수에 현재 미세먼지 데이터를 저장한다
}

// 현재 미세먼지 데이터를 반환하는 함수이다
int Subscriber::getMsg() {
	return current_data;
}

int main(int argc, char** argv) {  // 노드 메인 함수
	ros::init(argc, argv, "mode5_node"); // 노드명 선언
	ros::NodeHandle nh; // ROS 시스템과 통신을 위한 노드핸들 선언
	double x, y;  // 스팟의 좌표
	bool goalReached; // 목적지 도착 성공여부
	int current_data; // 현재 미세먼지 데이터
	int mode_data = 0; // 현재 선택된 모드
	int loop_time = 0;
	int arr[15]; // 미세먼지 수치 값 평균 구하기 위한 배열
	int sum = 0; // 미세먼지 수치 값 평균 구하기 위한 합
	int avg; // 미세먼지 수치 평균값
	int time = 0;
	SpotInfo spot[4]; // 스팟 정보를 담는 배열
	SpotInfo *p, *current_p;
	Mode mode(nh);
	Navigation navigation;
	Subscriber subscriber(nh);

	while (true) {
		ros::spinOnce();
		// 사용자로부터 모드 선택을 받는다
		ros::Duration(1).sleep();
    
		mode_data = mode.getMode(); // 현재 선택된 모드를 mode_data에 저장
		ROS_INFO("mode= %d", mode_data); // 현재 선택된 모드를 표시한다

		if (mode_data == 5) {
			p = spot;
			current_p = spot;
			navigation.setSpot(p, current_p); // 스팟을 설정(초기화)한다
      
      ////////////////////////////////////database////////////////////////////////////
			connection = mysql_init(connection);
			mysql_real_connect(connection, NULL, "newhj", "shj4197", "testdb", 0, NULL, 0);
			if (mysql_query(connection, "SELECT * FROM test_table")) {
				ROS_INFO("Query Error: %s", mysql_error(connection));
				exit(1);
			}

			else {
				result = mysql_use_result(connection);
				for (int i = 0; i < mysql_field_count(connection); ++i) {
					std::stringstream ss;
					row = mysql_fetch_row(result);
					if (row <= 0) {
						break;
					}
					for (int j = 0; j < mysql_num_fields(result); ++j) {
						ss << row[j] << " ";
					}
					ROS_INFO("%s", ss.str().c_str());
				}
				mysql_free_result(result);
			}
      ////////////////////////////////////////////////////////////////////////////////
      
			for (int i = 0; i < 4; i++, current_p++) { // 설정된 모든 스팟을 주행한다
				x = current_p->x_cordinate;
				y = current_p->y_cordinate;
				cout << "go to x :" << x << ", y :" << y << endl;
				goalReached = navigation.moveToGoal(x, y);
				if (goalReached) {
					ROS_INFO("Congratulations!"); // 목적지에 성공적으로 도착했을 경우
					//ros::Duration(10).sleep(); // 안정적인 수치 반영을 위해서 10초동안 duration을 갖는다
					for (int j = 0; j < 15; j++) {	//스팟 내에서 미세먼지 데이터 15개를 배열 arr[]에 저장한다
						ros::spinOnce();	// 버퍼에 있는 미세먼지 데이터를 받smsek
						current_data = subscriber.getMsg();	// 제일 최근 미세먼지 데이터를 current_data 변수에 넣는다
						ROS_INFO("current_data : %d", current_data); // 현재 미세먼지 데이터를 출력한다
						arr[j] = current_data; // 배열에 저장한다.
						usleep(1000000); // 1초 delay
					}
					for (int j = 0; j < 15; j++) {
						sum = sum + arr[j];
					}
					avg = sum / 15; // 배열에 담겨있는 데이터의 평균을 구한다
					current_p->dust_data = avg; // 평균값을 구조체에 해당 스팟의 dust_data에 저장한다
					ROS_INFO("AVG: %d", current_p->dust_data); // 평균값 출력
					/////////////////////////////////database insert////////////////////////////////
					std::string query = "INSERT INTO test_table (spot, pmsdata, date) VALUES ('" + to_string(i) + "', '" + to_string(avg) + "', NOW());";
					mysql_query(connection, query.c_str());
					////////////////////////////////////////////////////////////////////////////////
          
					sum = 0; // 미세먼지 수치 값 합 초기화
          
					navigation.inputStatus(current_p); // 구조체에 해당 스팟의 상태를 저장한다
					ROS_INFO("~Purifying~");
					ros::Duration(delay(current_p)).sleep(); //미세먼지 기준 상태에 따라 정한 시간만큼 정화한다

				}
				else{ // 도착 실패했을 경우
				  ROS_INFO("Hard Luck!");
			  }
			}
		}
	}
  
	return 0;
}
