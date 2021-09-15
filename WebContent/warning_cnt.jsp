<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>



<%@ include file="dbconn.jsp"%>
<%! 
	String w_cnt0;
	String w_cnt1;
	String w_cnt2;
	String w_cnt3;%>

<%
	request.setCharacterEncoding("utf-8");

ResultSet wrs1 = null;
ResultSet wrs2 = null;
ResultSet wrs3 = null;
ResultSet wrs4 = null;

Statement wstmt1 = null;
Statement wstmt2 = null;
Statement wstmt3 = null;
Statement wstmt4 = null;

try {

	//첫 번째 쿼리문 
	String wsql = "select pmsdata, count(*) as w_cnt0 from test_table where spot = 0 and pmsdata > 100";
	wstmt1 = conn.createStatement();
	wrs1 = wstmt1.executeQuery(wsql);

	while (wrs1.next()) {

		w_cnt0 = wrs1.getString("w_cnt0");

	}

	//2 번째 쿼리문 
	String wsql2 = "select pmsdata, count(*) as w_cnt1 from test_table where spot = 1 and pmsdata > 100";
	wstmt2 = conn.createStatement();
	wrs2 = wstmt2.executeQuery(wsql2);

	while (wrs2.next()) {

		w_cnt1 = wrs2.getString("w_cnt1");

	}

	//3 번째 쿼리문 
	String wsql3 = "select pmsdata, count(*) as w_cnt2 from test_table where spot = 2 and pmsdata > 100";
	wstmt3 = conn.createStatement();
	wrs3 = wstmt3.executeQuery(wsql3);

	while (wrs3.next()) {

		w_cnt2 = wrs3.getString("w_cnt2");

	}

	//4 번째 쿼리문 
	String wsql4 = "select pmsdata, count(*) as w_cnt3 from test_table where spot = 3 and pmsdata > 100";
	wstmt4 = conn.createStatement();
	wrs4 = wstmt4.executeQuery(wsql4);

	while (wrs4.next()) {

		w_cnt3 = wrs4.getString("w_cnt3");

	}
} catch (SQLException ex) {
	out.println("SQLException: " + ex.getMessage());

} finally {

	if (wrs1 != null)
		wrs1.close();
	if (wstmt1 != null)
		wstmt1.close();
	if (conn != null)
		conn.close();

}
%>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
	<div id="container2"></div>
	<p class="highcharts-description"></p>
	<div id="container2"></div>
	<p class="highcharts-description"></p>




	<script type="text/javascript">
		//theme 색깔 적용
		if (!Highcharts.theme) {
			Highcharts.setOptions({
				chart : {
					backgroundColor : '#f2f0f1'
				},
				colors : [ '#F62366', '#9DFF02', '#0CCDD6', '#EE82EE' ],
				title : {
					
				},
				tooltip : {
					style : {
						color : 'silver'
					}
				}
			});
		}
		// 차트 그리기 시작

		Highcharts
				.chart(
						'container2',
						{
							chart : {
								type : 'pie'
							},
							title : {
								text : '[ 미세먼지 수치 현황 ]'
							},
							tooltip : {
								headerFormat : '',
								pointFormat : '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>'
										+ '<b>{point.y}</b>회'
							},
							series : [ {
								minPointSize : 10,
								innerSize : '38%',
								name : 'spots',
								data : [ {
										name : 'SPOT 0',
										y :<%=Float.parseFloat(w_cnt0)%>
									  }, 
									  
										
									{
										name : 'SPOT 1',
										y :<%=Float.parseFloat(w_cnt1)%>
									  },
									  
										
									{
										name : 'SPOT 2',
										y :<%=Float.parseFloat(w_cnt2)%>
									  },
									
									{
										name : 'SPOT 3',
										y :<%=Float.parseFloat(w_cnt3)%>
									  } ]
				
							} ]
					});
		</script>
</figure>