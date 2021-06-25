#include <iostream>
#include <ros/ros.h>
#include "std_msgs/String.h"
#include <mysql/mysql.h>
#include <string>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include "sap_mode_five/Msg.h"
#include "sap_mode_five/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)
#include <unistd.h>
#include <algorithm>

MYSQL *connection = NULL;
MYSQL_RES *result = NULL;
MYSQL_ROW row;

using namespace std;
struct SpotInfo {
  double x_cordinate;
  double y_cordinate;
  int status;
  int dust_data;
  int init_order;
};
//딜레이 함수: 미세먼지 기준 상태에 따라 다른 딜레이시간을 리턴한다.
//좋음 – Delay없음 / 보통 – Delay 3분 / 나쁨 – Delay 7분 / 매우 나쁨 – Delay 10분
int delay(SpotInfo* arr_p){
  if(arr_p->status==0){
    cout  << "0초" << endl;
    return 0;
  }
  else if(arr_p->status==1){
    cout  << "180초" << endl;
    return 180;
  }   

  else if(arr_p->status==2){
    cout  << "420초" << endl;
    return 420;
  }     

  else if(arr_p->status==3){
    cout  << "600초" << endl;
    return 600;
  }  

}

class Mode{
private:
  ros::NodeHandle n;
  ros::Subscriber mode_sub;
  int mode_data=0;
public:
  Mode(ros::NodeHandle n);
  ~Mode();
  void modeMsgCallback(const sap_mode_five::mode_msg::ConstPtr& m_msg);
  int getMode();
};
//Constructor
Mode::Mode(ros::NodeHandle nh):n(nh){
  mode_sub = n.subscribe("mode_msg", 10, &Mode::modeMsgCallback, this);
}
//Destructor
Mode::~Mode(){}
// 메시지콜백함수로써, 밑에서설정msg라는이름의토픽
// 메시지를수신하였을때동작하는함수이다
// 입력메시지로는sap_mode_five패키지의mode_msg메시지를받도록되어있다
void Mode::modeMsgCallback(const sap_mode_five::mode_msg::ConstPtr &m_msg) {
  ROS_INFO("Received data: %d", m_msg->data);
  mode_data=m_msg->data;
}
int Mode::getMode(){
  return mode_data;
}

class Navigation{
public:
  Navigation();
  ~Navigation();
  void setSpot(SpotInfo* arr_p, SpotInfo* current);
  bool moveToGoal(double xGoal, double yGoal);
  void inputStatus(SpotInfo* arr_p);
};
//Constructor
Navigation::Navigation(){}
//Destructor
Navigation::~Navigation() {}
void Navigation::setSpot(SpotInfo* arr_p, SpotInfo* current) {
  //initialize spots' status
  for (int i = 0; i<4; i++) {
    //current->status = 0;
    current->dust_data = 0;
    current++;
  }
  current = arr_p;
  //put real cordinates into array
  current->init_order=0;
  current->x_cordinate = -0.1440;
  current->y_cordinate = -0.1525;
  current++;
  current->init_order=1;
  current->x_cordinate = -0.0874;
  current->y_cordinate = -1.3411;
  current++;
  current->init_order=2;
  current->x_cordinate = -0.5373;
  current->y_cordinate = -0.6266;
  current++;
  current->init_order=3;
  current->x_cordinate = -0.4828;
  current->y_cordinate = -1.5649;
  for (int i = 0; i<4; i++) {
    cout << "spot[" << i << "].x_cordinate : " << arr_p->x_cordinate << endl;
    cout << "spot[" << i << "].y_cordinate : " << arr_p->y_cordinate << endl;
    arr_p++;
  }
}
bool Navigation::moveToGoal(double xGoal, double yGoal) {
  actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> ac("move_base", true);
  while (!ac.waitForServer(ros::Duration(5.0))) {
    ROS_INFO("Waiting for the move_base action server to come up");
  }
  move_base_msgs::MoveBaseGoal goal;
  goal.target_pose.header.frame_id = "map";
  goal.target_pose.header.stamp = ros::Time::now();
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
  if (ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED) {
    ROS_INFO("You have reached the destination");
    return true;
  }
  else {
    ROS_INFO("The robot failed to reach the destination");
    return false;
  }
}
void Navigation::inputStatus(SpotInfo *arr_p){
  if(arr_p->dust_data<=30){
    cout<<"Air quality: GREAT :D "<<endl;
    arr_p->status=0;
  }
  else if(arr_p->dust_data<=80){
    cout<<"Air quality: NOT BAD :) "<<endl;
    arr_p->status=1;
  }
  else if(arr_p->dust_data<=150){
    cout<<"Air quality: BAD :( "<<endl;
    arr_p->status=2;
  }
  else if(arr_p->dust_data>151){
    cout<<"Air quality: VERY BAD!!! "<<endl;
    arr_p->status=3;
  }
}
class Subscriber{
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
//Constructor
Subscriber::Subscriber(ros::NodeHandle nh):n(nh){
  sub = n.subscribe("pmsdata", 10, &Subscriber::msgCallback, this);
}
//Destructor
Subscriber::~Subscriber(){}
void Subscriber::msgCallback(const sap_mode_five::Msg::ConstPtr &msg) {
  cout<<"Received data: "<< msg->pmsdata<<endl;
  current_data=msg->pmsdata;
}
int Subscriber::getMsg(){
  return current_data;
}
int main(int argc, char** argv) {
  ros::init(argc, argv, "mode5_node");
  ros::NodeHandle nh;
  double x, y;
  bool goalReached;
  int current_data;
  int loop_time=0;
  int arr[15]; // 미세먼지 수치 값 평균 구하기 위한 배열
  int sum = 0; //미세먼지 수치 값 평균 구하기 위한 합
  int avg; // 미세먼지 수치 평균값
  int time=0;
  int mode_data=0;
  Mode mode(nh);
  SpotInfo spot[4];
  SpotInfo *p, *current_p;
  Navigation navigation;
  Subscriber subscriber(nh);

  while(true){
    ros::spinOnce();
    ros::Duration(1).sleep();

    mode_data=mode.getMode();
    ROS_INFO("mode= %d",mode_data);

    if(mode_data==5){


      p = spot;
      current_p = spot;
      navigation.setSpot(p, current_p);


      /////////////////////dbcheck///////////////////////////////////////////////

      connection = mysql_init(connection);
      mysql_real_connect(connection, NULL, "newhj", "shj4197", "testdb", 0, NULL, 0);
      if(mysql_query(connection, "SELECT * FROM test_table")){
        ROS_INFO("Query Error: %s", mysql_error(connection));
        exit(1);
      }

      else{
        result = mysql_use_result(connection);
        for(int i=0; i < mysql_field_count(connection); ++i){
          std::stringstream ss;
          row = mysql_fetch_row(result);
          if(row <= 0){
            break;
          }
          for(int j=0; j < mysql_num_fields(result); ++j){
            ss << row[j] << " ";
          }
          ROS_INFO("%s", ss.str().c_str());
        }
        mysql_free_result(result);
      }


      ///////////////////////////////////////////////////////////////////////////
      for (int i = 0; i<4; i++,current_p++) {
        x = current_p->x_cordinate;
        y = current_p->y_cordinate;
        cout << "go to x :" << x << ", y :" << y << endl;
        goalReached = navigation.moveToGoal(x, y);
        if (goalReached) {
          ROS_INFO("Congratulations!");
          ros::Duration(10).sleep(); //10 second
          for(int j=0;j<15;j++){	//스팟 내에서 미세먼지 데이터 15개를 배열 arr[]에 저장한다.
            ros::spinOnce();	//버퍼에 있는 미세먼지 데이터를 받아옴
            current_data=subscriber.getMsg();	//가장 최근 데이터를 current_data에 저장
            ROS_INFO("current_data : %d", current_data);
            arr[j]=current_data; //배열에 저장한다.
            usleep(1000000); //1초 delay
          }
          for(int j=0;j<15;j++){
            sum=sum+arr[j];
          }
          avg=sum/15; //배열에 담겨있는 데이터의 평균을 구한다.
          current_p->dust_data=avg; //평균값을 구조체에 해당 스팟의 dust_data에 저장한다.
          ROS_INFO("AVG: %d",current_p->dust_data); //평균값 출력


          //////////////////////////////////////db insert/////////////////////////////

          std::string query="INSERT INTO test_table (spot, pmsdata, date) VALUES ('"+to_string(i)+"', '"+to_string(avg)+"', NOW());";

          mysql_query(connection,query.c_str());

          ////////////////////////////////////////////////////////////////////////////

          sum=0;
          navigation.inputStatus(current_p);
          ROS_INFO("~Purifying~");
          ros::Duration(delay(current_p)).sleep(); //미세먼지 기준 상태에 따라 정한 시간만큼 정화한다.

        }
        else
          ROS_INFO("Hard Luck!");
      }
    }
  }
  return 0;
}
