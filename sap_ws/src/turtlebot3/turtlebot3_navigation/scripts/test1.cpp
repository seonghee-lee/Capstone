#include <iostream>
#include <ros/ros.h>
#include "turtlebot3_navigation/Msgfile.h"

using namespace std;

char menu();


int main(int argc, char** argv){
  ros::init(argc, argv, "test_node"); //initiate nodes' name
  ros::NodeHandle nh; //declare node handler as nh

  ros::Publisher main = nh.advertise<turtlebot3_navigation::Msgfile>("topic",100);
  //publisher declare, name : main
  //publisher pkg : turtlebot3_navigation
  //message file name : Msgfile
  //topic name : topic
  //publisher queue size : 100

  turtlebot3_navigation::Msgfile msg; //declare message as msg / file form : Msgfile

  char choice='q';
  do{
      choice=menu();
      if(choice=='1'){  //send message : '1'
        msg.menu=1;
        ROS_INFO("send msg = %d",msg.menu);
        main.publish(msg);
      }
      else if(choice =='2'){
        msg.menu=2;
        ROS_INFO("send msg = %d",msg.menu);
        main.publish(msg);
      }
  }while (choice != 'q');
  return 0;
}

/** main menu **/
char menu(){
  char choice='q';
  cout<<"************ SMART AUTONOMOUS AIR PURIFIER POSSIBLE ************"<<endl;
  cout<<"----------------------------------------------------------------"<<endl;
  cout<<"-------------------------- SELECT MENU -------------------------"<<endl;
  cout<<"----------------------------------------------------------------"<<endl;
  cout<<"1"<<endl;
  cout<<"2"<<endl;
  //cout<<"3"<<endl;
  //cout<<"4"<<endl;
  cout<<"q"<<endl;
  cout<<"----------------------------------------------------------------"<<endl;
  cout<<"Input Choice >>";
  cin>>choice;

  return choice;
}


