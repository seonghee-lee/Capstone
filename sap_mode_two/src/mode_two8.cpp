#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include "sap_mode_two/Msg.h"
#include <cassert>
using namespace std;

struct SpotInfo {
        double x_cordinate;
        double y_cordinate;
        int status;
        int dust_data;
};

class Mode_two {
private:
        ros::NodeHandle n;
        ros::Subscriber sub;
        bool goalReached;
        int current_data;


public:
        Mode_two(ros::NodeHandle n);
        ~Mode_two();
        void msgCallback(const sap_mode_two::Msg::ConstPtr& msg);
        void setSpot(SpotInfo* arr_p, SpotInfo* current);
        bool moveToGoal(double xGoal, double yGoal);
        void testValue(SpotInfo* arr_p);
        SpotInfo spot[5];
        SpotInfo *p, *current_p;
};

//Constructor
Mode_two::Mode_two(ros::NodeHandle nh) :n(nh) {
        p = spot;
        current_p = spot;
        setSpot(p, current_p);
	testValue(p);

	//Subscriber
        sub = n.subscribe("pmsdata", 10, &Mode_two::msgCallback, this);
}
//Destructor
Mode_two::~Mode_two() {}


void Mode_two::msgCallback(const sap_mode_two::Msg::ConstPtr &msg) {
        cout<<"current data: "<< msg->pmsdata<<endl;
	p->status=1;
	p->dust_data=msg->pmsdata;
	p++;
}

void Mode_two::setSpot(SpotInfo* arr_p, SpotInfo* current) {
        //initialize spots' status
        for (int i = 0; i<5; i++) {
                current->status = 0;
                current->dust_data = 0;
                current++;
        }
	current = arr_p;

        //put real cordinates into array
        current->x_cordinate = -0.1440;
        current->y_cordinate = -0.1525;
        current++;
        current->x_cordinate = -0.0874;
        current->y_cordinate = -1.3411;
        current++;
        current->x_cordinate = -0.5373;
        current->y_cordinate = -0.6266;
        current++;
        current->x_cordinate = -0.4828;
        current->y_cordinate = -1.5649;
	current++;
	current->x_cordinate=3000;
	current->y_cordinate=3000;

        for (int i = 0; i<4; i++) {
                cout << "spot[" << i << "].x_cordinate : " << arr_p->x_cordinate << endl;
                cout << "spot[" << i << "].y_cordinate : " << arr_p->y_cordinate << endl;
                arr_p++;
        }
}

bool Mode_two::moveToGoal(double xGoal, double yGoal) {
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

void Mode_two::testValue(SpotInfo* arr_p) {
        goalReached = false;
        double x, y;
	ros::Rate r(10);

	while(ros::ok()){
	  if(arr_p->x_cordinate==3000)
	    //we have to save spotinfo data into db before shutting down
	    assert(false);

	  x = arr_p->x_cordinate;
          y = arr_p->y_cordinate;
          cout << "go to x :" << x << ", y :" << y << endl;
          goalReached = moveToGoal(x, y);
          ros::Duration(5).sleep();

          if (goalReached) {
             ROS_INFO("Congratulations!");
	     ros::spinOnce(); //calling msgcallback function
	     r.sleep();
	     
	     //checking the  data
	     cout<<"status: "<<arr_p->status<<endl;
	     cout<<"dust_data: "<<arr_p->dust_data<<endl;
          }

          else
             ROS_INFO("Hard Luck!");
	  
	  arr_p++;
	}
}

int main(int argc, char** argv) {
        ros::init(argc, argv, "node");
        ros::NodeHandle nh;
        Mode_two Mode_two(nh);
        return 0;
}
