// subscribe pms_data to save in db
// 2021-04-01
// DBtest.cpp => class화


#include "ros/ros.h"
#include "cpp_python/TopicMsg.h"
#include "std_msgs/String.h"
#include <mysql/mysql.h>

MYSQL *connection = NULL;
MYSQL_RES *result = NULL;
MYSQL_ROW row;

class Dbcon {
private:
    ros::NodeHandle nh; // ros 시스템과 통신을 위한 노드 핸들 선언
    ros::Subscriber sub;
    
public:
    Dbcon(ros::NodeHandle nh); // 생성자
    ~Dbcon(); // 소멸자
    void msgCallback(const cpp_python::TopicMsg::ConstPtr& msg)
    void dataToDb();
}

Dbcon::Dbcon(ros::NodeHandle nh) {
    dataToDb();
    sub = = nh.subscribe("pmsdata", 10, &Dbcon::msgCallback,this); // topic: pmsdata, queue_size:10
}

Dbcon::Dbcon(){
    // 소멸
}

void Dbcon::msgCallback(const cpp_python::TopicMsg::ConstPtr& msg){
  ROS_INFO("Recieved data : %d ", msg->pmsdata);
}

void Dbcon::dataToDb() {
    // connect to db
    connection = mysql_init(connection);
    mysql_real_connect(connection, "ip", "yunjihui", "yooni2418", "testdb", 0, NULL, 0);
    
    
    if(mysql_query(connection, "SELECT * FROM test_table")){
          ROS_INFO("Query Error: %s", mysql_error(connection));
        exit(1);
    }

    
    else{
        result = mysql_use_result(connection);
        
        
        for(int i=0; i < mysql_field_count(connection); ++i)
        {
            std::stringstream ss;
            row = mysql_fetch_row(result);
            
            
            if(row <= 0){
                break;
            }
            for(int j=0; j < mysql_num_fields(result); ++j)
            {
                ss << row[j] << " ";
            }
            ROS_INFO("%s", ss.str().c_str());
        }
        mysql_free_result(result);
    }
    ros::spin();
    
    
    // spot은 어떻게 알지?: 사용자의 입력키를 받아오기
    // spot =
    
    // pmsdata = msg->pmsdata;
    
    // test: data 값 우선 0으로 통일
    //mysql_query(connection, "INSERT INTO test_table VALUES" "('%d','%d',%s)",spot, pmsdata, NOW());
    mysql_query(connection, "INSERT INTO test_table VALUES (spot, pmsdata, date) = (1,55,NOW());
}

int main(int argc, char *argv[]) {
    
    // 노드명 초기화
    ros::init(argc, argv, "pmsdata_subscriber");
    ros::NodeHandle nh;
    ros::spinOnce();
   
    Dbcon dbcon(nh);
    
    return 0;
    
}
