#include "ros/ros.h" // ROS 기본헤더파일
#include "sap_mode_one/mode_msg.h" // mode_msg메시지파일헤더(빌드후자동생성됨)

int mode;

// 메시지콜백함수로써, 밑에서설정한ros_tutorial_msg라는이름의토픽
// 메시지를수신하였을때동작하는함수이다
// 입력메시지로는ros_tutorials_topic패키지의MsgTutorial메시지를받도록되어있다
void msgCallback(const ros_tutorials_topic::MsgTutorial::ConstPtr& msg)
{
    ROS_INFO("recievemsg= %d", msg->data); // data 메시지를표시한다
    mode=msg->data;
}


int main(int argc, char **argv)// 노드메인함수
{
    ros::init(argc, argv, "mode1_node");// 노드명초기화
    ros::NodeHandle n; // ROS 시스템과통신을위한노드핸들선언
    // 서브스크라이버선언, ros_tutorials_topic패키지의Msg을Tutorial메시지파일을이용한
    // 서브스크라이버ros_tutorial_sub를작성한다. 토픽명은"ros_tutorial_msg" 이며,
    // 서브스크라이버큐(queue) 사이즈를100개로설정한다는것이다
    ros::Subscriber mode_sub= nh.subscribe("mode_msg", 100, msgCallback);
    // 콜백함수호출을위한함수로써, 메시지가수신되기를대기,
    // 수신되었을경우콜백함수를실행한다

    ROS_INFO("recievemsg= %d", mode); // mode값 표시한다

    ros::spin();

    return 0;
}
