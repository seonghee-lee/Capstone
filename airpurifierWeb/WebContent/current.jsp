<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>


<html>
<head>

<!-- google font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<style>
 table {font-family: 'Noto Sans KR';}
 #container {
    height: 400px;
}

.highcharts-figure, .highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
}
#datatable {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #EBEBEB;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}
#datatable caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
#datatable th {
	font-weight: 600;
    padding: 0.5em;
}
#datatable td, #datatable th, #datatable caption {
    padding: 0.5em;
}
#datatable thead tr, #datatable tr:nth-child(even) {
    background: #f8f8f8;
}
#datatable tr:hover {
    background: #f1f7ff;
}

 
</style>

<title>current level</title>
<%@ include file="dbconn.jsp"%>
<%@ include file="./header.jsp"%>

<%!String spot0;
	String spot1;
	String spot2;
	String spot3;

	String pmsdata0;
	String pmsdata1;
	String pmsdata2;
	String pmsdata3;
	float average;
	
	String date0;
	String date1;
	String date2;
	String date3;%>
	
<%
request.setCharacterEncoding("utf-8");

ResultSet rs1 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;

Statement stmt1 = null;
Statement stmt2 = null;
Statement stmt3 = null;
Statement stmt4 = null;

try {

	//첫 번째 쿼리문 
	String sql = "SELECT pmsdata,date FROM test_table where spot=1 ORDER BY id DESC LIMIT 1";
	stmt1 = conn.createStatement();
	rs1 = stmt1.executeQuery(sql);

	while (rs1.next()) {

		pmsdata0 = rs1.getString("pmsdata");
		date0 = rs1.getString("date");
		date0 = date0.substring(0, 19);

	}

	//2 번째 쿼리문 
	String sql2 = "SELECT pmsdata,date FROM test_table where spot=2 ORDER BY id DESC LIMIT 1";
	stmt2 = conn.createStatement();
	rs2 = stmt2.executeQuery(sql2);

	while (rs2.next()) {

		pmsdata1 = rs2.getString("pmsdata");
		date1 = rs2.getString("date");
		date1 = date1.substring(0, 19);
	}

	//3 번째 쿼리문 
	String sql3 = "SELECT pmsdata,date FROM test_table where spot=3 ORDER BY id DESC LIMIT 1";
	stmt3 = conn.createStatement();
	rs3 = stmt3.executeQuery(sql3);

	while (rs3.next()) {

		pmsdata2 = rs3.getString("pmsdata");
		date2 = rs3.getString("date");
		date2 = date2.substring(0, 19);

	}

	//4 번째 쿼리문 
	String sql4 = "SELECT pmsdata,date FROM test_table where spot=4 ORDER BY id DESC LIMIT 1";
	stmt4 = conn.createStatement();
	rs4 = stmt4.executeQuery(sql4);

	while (rs4.next()) {

		pmsdata3 = rs4.getString("pmsdata");
		date3 = rs4.getString("date");
		date3 = date3.substring(0, 19);

	}
	
	average = (Integer.parseInt(pmsdata0)+Integer.parseInt(pmsdata1)+Integer.parseInt(pmsdata2)+Integer.parseInt(pmsdata3))/4;

} catch (SQLException ex) {
	out.println("SQLException: " + ex.getMessage());

} finally {

	if (rs1 != null)
		rs1.close();
	if (stmt1 != null)
		stmt1.close();
	if (conn != null)
		conn.close();

}
%>

</head>

<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class ="chart-desc" style = "font-family: 'Noto Sans KR', sans-serif; text-align: center; ">

    <table id="datatable">
        <thead>
            <tr>
                <th></th>
                <th> 미세먼지 수치</th>
                <th> 측정시간</th>
            
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>SPOT 0</th>
                <td><%=pmsdata0%></td>
                <td><%=date0%></td>
                
            </tr>
            <tr>
                <th>SPOT 1</th>
                <td><%=pmsdata1%></td>
                <td><%=date1%></td>
                
            </tr>
            <tr>
                <th>SPOT 2</th>
                <td><%=pmsdata2%></td>
                <td><%=date2%></td>
                
            </tr>
            <tr>
                <th>SPOT 3</th>
                <td><%=pmsdata3%></td>
                <td><%=date3%></td>
                
            </tr>
        </tbody>
    </table>
    
</figure>


<script type="text/javascript">
    Highcharts.chart('container', {
        chart: {
            type: 'column'
        },
        title: {
            text: '현재 구역 별 미세먼지 수치'
        },
        xAxis: {
            categories: ['SPOT 0','SPOT 1','SPOT 2','SPOT 3']
        },
        yAxis: {
        	allowDecimals: false,
            title: {
                text: ' ㎍/m³ '
            }
        },
        plotOptions: {
            series: {
                allowPointSelect: true
            }
        },
        series : [ {
        	name : '미세먼지 수치',
			data : [<%=Float.parseFloat(pmsdata0)%>,
					<%=Float.parseFloat(pmsdata1)%>,
					<%=Float.parseFloat(pmsdata2)%>,
					<%=Float.parseFloat(pmsdata3)%>]
        }, {
        	name : '평균',
			data : [<%=average%>,
					<%=average%>,
					<%=average%>,
					<%=average%>]
        }]

    });

</script>

</body>


</html>