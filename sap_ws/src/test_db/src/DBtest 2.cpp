#include <iostream>
#include <ros/ros.h>
#include "std_msgs/String.h"
#include <mysql/mysql.h>
#include <string>


MYSQL *connection = NULL;
MYSQL_RES *result = NULL;
MYSQL_ROW row;

using namespace std;

int main(int argc, char *argv[]) {
	int spot=6;
	int pmsdata=100;
	//string s_spot=to_string(spot);
	//string s_pmsdata=to_string(pmsdata);

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

	std::string query="INSERT INTO test_table (spot, pmsdata, date) VALUES ('"+to_string(spot)+"', '"+to_string(pmsdata)+"', NOW());";
	//mysql_query(connection, "INSERT INTO test_table (spot, pmsdata, date) VALUES ("+s_spot+", "+s_pmsdata+", NOW());");
        mysql_query(connection,query.c_str());

}


