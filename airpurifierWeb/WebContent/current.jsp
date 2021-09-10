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

<%!

String[] pmsdata = new String[4];
String[] date = new String[4];
String[] avg = new String[4];%>
	
<%
request.setCharacterEncoding("utf-8");

ResultSet[] r = new ResultSet[4];
Statement[] s = new Statement[4];


try {
	
	for(int i=0;i<4;i++){
		String sql = "SELECT pmsdata,date FROM test_table where spot=" + i + " ORDER BY id DESC LIMIT 1";
		s[i] = conn.createStatement();
		r[i] = s[i].executeQuery(sql);
		
		while(r[i].next()){
			pmsdata[i] = r[i].getString("pmsdata");
			date[i] = r[i].getString("date");
			date[i] = date[i].substring(0, 19);
		}
	}
	
	for(int i=0;i<4;i++){
		String sql = "SELECT round(AVG(pmsdata),1) from test_table where spot="+ i;
		s[i] = conn.createStatement();
		r[i] = s[i].executeQuery(sql);
		
		while(r[i].next()){
			avg[i] = r[i].getString("round(AVG(pmsdata),1)");
		}
	}
	


} catch (SQLException ex) {
	out.println("SQLException: " + ex.getMessage());

} finally {

	if (r[0] != null)
		r[0].close();
	if (s[0] != null)
		s[0].close();
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
                <td><%=pmsdata[0]%></td>
                <td><%=date[0]%></td>
            
                
            </tr>
            <tr>
                <th>SPOT 1</th>
                <td><%=pmsdata[1]%></td>
                <td><%=date[1]%></td>
                
            </tr>
            <tr>
                <th>SPOT 2</th>
                <td><%=pmsdata[2]%></td>
                <td><%=date[2]%></td>
                
            </tr>
            <tr>
                <th>SPOT 3</th>
                <td><%=pmsdata[3]%></td>
                <td><%=date[3]%></td>
                
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
			data : [<%=Float.parseFloat(pmsdata[0])%>,
				<%=Float.parseFloat(pmsdata[1])%>,
				<%=Float.parseFloat(pmsdata[2])%>,
				<%=Float.parseFloat(pmsdata[3])%>]
        }, {
        	name : '평균',
			data : [<%=Float.parseFloat(avg[0])%>,
				<%=Float.parseFloat(avg[1])%>,
				<%=Float.parseFloat(avg[2])%>,
				<%=Float.parseFloat(avg[3])%>]
        }]

    });

</script>

</body>


</html>

