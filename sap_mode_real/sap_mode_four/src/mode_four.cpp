#include <iostream>
#include <ros/ros.h>
#include "std_msgs/String.h"
#include <mysql/mysql.h>
#include <string>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include "sap_mode_four/Msg.h"
#include "sap_mode_four/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)
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

bool compare(const SpotInfo &p1, const SpotInfo &p2){
  if(p1.dust_data>p2.dust_data)
    return true;
  else if(p1.dust_data==p2.dust_data)
    //sorted by the sequence of array value order
    return p1.init_order<p2.init_order;
  else {
    return false;
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
  void modeMsgCallback(const sap_mode_four::mode_msg::ConstPtr& m_msg);
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
// 입력메시지로는sap_mode_four패키지의mode_msg메시지를받도록되어있다
void Mode::modeMsgCallback(const sap_mode_four::mode_msg::ConstPtr &m_msg) {
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
  //void airPurify(SpotInfo* arr_p);
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
  current->x_cordinate = -1.2496;
  current->y_cordinate = -3.395;
  current++;

  current->init_order=1;
  current->x_cordinate = -0.8941;
  current->y_cordinate = -0.5606;
  current++;

  current->init_order=2;
  current->x_cordinate = 0.0365;
  current->y_cordinate = -1.8533;
  current++;

  current->init_order=3;
  current->x_cordinate = 0.3837;
  current->y_cordinate = -0.0119;

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
      cout<<"spot["<<arr_p->init_order<<"] Air quality: VERRY GOOD :D "<<endl;
      arr_p->status=0;
    }
    else if(arr_p->dust_data<=80){
      cout<<"spot["<<arr_p->init_order<<"]Air quality: GOOD :) "<<endl;
      arr_p->status=1;
    }
    else if(arr_p->dust_data<=150){
      cout<<"spot["<<arr_p->init_order<<"]Air quality: BAD :( "<<endl;
      arr_p->status=2;
    }
    else if(arr_p->dust_data>151){
      cout<<"spot["<<arr_p->init_order<<"]Air quality: VERY BAD!!! "<<endl;
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
  void msgCallback(const sap_mode_four::Msg::ConstPtr& msg);
  int getMsg();
};
//Constructor
Subscriber::Subscriber(ros::NodeHandle nh):n(nh){
  sub = n.subscribe("pmsdata", 10, &Subscriber::msgCallback, this);
}
//Destructor
Subscriber::~Subscriber(){}

void Subscriber::msgCallback(const sap_mode_four::Msg::ConstPtr &msg) {
  cout<<"Received data: "<< msg->pmsdata<<endl;
  current_data=msg->pmsdata;
}

int Subscriber::getMsg(){
  return current_data;
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "node");
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

    if(mode_data==4){
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
          ros::Duration(10).sleep();

          for(int j=0;j<15;j++){
            ros::spinOnce();
            current_data=subscriber.getMsg();
            ROS_INFO("current_data : %d", current_data);
            arr[j]=current_data;
            usleep(1000000);
          }

          for(int j=0;j<15;j++){
            sum=sum+arr[j];
          }

          avg=sum/15;
          current_p->dust_data=avg;
	  navigation.inputStatus(current_p);
          ROS_INFO("AVG: %d",current_p->dust_data);


          //////////////////////////////////////db insert/////////////////////////////

          std::string query="INSERT INTO test_table (spot, pmsdata, date) VALUES ('"+to_string(i)+"', '"+to_string(avg)+"', NOW());";

          mysql_query(connection,query.c_str());

          ////////////////////////////////////////////////////////////////////////////

          sum=0;

        }
        else
          ROS_INFO("Hard Luck!");
      }
      //navigation.inputStatus(p);
      sort(p,p+4,compare);

      // /////////////sorting check/////////////////////////////
      current_p=p;
      for(int i=0;i<4;i++,current_p++){
        cout<<"----sorting print----"<<endl;
	cout<<"spot["<<current_p->init_order<<"]"<<endl;
        cout<<"x: "<<current_p->x_cordinate<<endl;
        cout<<"y: "<<current_p->y_cordinate<<endl;
        cout<<"dust: "<<current_p->dust_data<<endl;
        cout<<"---------------------"<<endl;
      }
      // ///////////////////////////////////////////////////////

      x=p->x_cordinate;
      y=p->y_cordinate;

      cout << "go to x :" << x << ", y :" << y << endl;
      cout<<"to the highest data : "<<p->dust_data<<endl;
      goalReached = navigation.moveToGoal(x, y);

      if (goalReached) {
        ROS_INFO("Congratulations!");
        ROS_INFO("~Purifying~");
        while(time<31){
          if(p->status==0)
            break;
          else{
            ros::spinOnce();
            p->dust_data=subscriber.getMsg();
            navigation.inputStatus(p);
          }
          ros::Duration(1).sleep();
      	  cout << time << "초" << endl;
          time++;
        }
	time=0;
      }
      else
        ROS_INFO("Hard Luck!");
    }
  }

  return 0;
}
