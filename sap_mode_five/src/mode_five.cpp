#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include "sap_mode_five/Msg.h"
#include <unistd.h>
#include <algorithm>

using namespace std;

struct SpotInfo {
        double x_cordinate;
        double y_cordinate;
        int status;
        int dust_data;
        int init_order;
};

int delay(SpotInfo* arr_p){
    if(arr_p->status==0)    return 0;
    else if(arr_p->status==1)   return 180;
    else if(arr_p->status==2)   return 420;
    else if(arr_p->status==3)   return 600;
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
        SpotInfo spot[4];
        SpotInfo *p, *current_p;
        Navigation navigation;
        Subscriber subscriber(nh);

        p = spot;
        current_p = spot;

        navigation.setSpot(p, current_p);


        for (int i = 0; i<4; i++,current_p++) {
            x = current_p->x_cordinate;
            y = current_p->y_cordinate;
            cout << "go to x :" << x << ", y :" << y << endl;
            goalReached = navigation.moveToGoal(x, y);

            if (goalReached) {
                ROS_INFO("Congratulations!");
                ros::Duration(10).sleep(); //10 second

                for(int j=0;j<15;j++){
                    ros::spinOnce();
                    current_data=subscriber.getMsg();
                    ROS_INFO("current_data : %d", current_data);
                    arr[j]=current_data;
                    usleep(1000000); //1 second
                }

                for(int j=0;j<15;j++){
                 sum=sum+arr[j];
                }

                avg=sum/15;
                current_p->dust_data=avg;
                ROS_INFO("AVG: %d",current_p->dust_data);
                sum=0;

                navigation.inputStatus(current_p);

                ROS_INFO("~Purifying~");
                ros::Duration(delay(current_p)).sleep();

                
            }
            else
                ROS_INFO("Hard Luck!");
        }

        ros::Rate rate(5);
        ros::spin();
        return 0;
}
