
#include <ros/ros.h>
#include "std_msgs/String.h"
#include <mysql/mysql.h>


MYSQL *connection = NULL;
MYSQL_RES *result = NULL;
MYSQL_ROW row;

int main(int argc, char *argv[]) {
	connection = mysql_init(connection);
	mysql_real_connect(connection, NULL, "id", "pw", "testdb", 0, NULL, 0);
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
	mysql_query(connection, "INSERT INTO test_table (spot, pmsdata, date) VALUES ( 4, 55, NOW());");
}
