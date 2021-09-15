<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>



<%@ include file="dbconn.jsp"%>

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
            type: 'column',
            backgroundColor : '#f2f0f1'
        },
        colors : [ '#33C2CD', '#768089'],
        title: {
            text: '[현재 구역 별 미세먼지 수치]'
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
        	name : '현재 미세먼지 수치',
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

