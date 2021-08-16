<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<style>
#container {
	height: 700px;
}

.highcharts-figure, .highcharts-data-table table {
	min-width: 320px;
	max-width: 700px;
	margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}

.highcharts-data-table caption {
	padding: 1em 0;
	font-size: 1.2em;
	color: #555;
}

.highcharts-data-table th {
	font-weight: 600;
	padding: 0.5em;
}

.highcharts-data-table td, .highcharts-data-table th,
	.highcharts-data-table caption {
	padding: 0.5em;
}

.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even)
	{
	background: #f8f8f8;
}

.highcharts-data-table tr:hover {
	background: #f1f7ff;
}

body {
	background-color: #000000;
}
</style>


<%@ include file="dbconn.jsp"%>
<%@ include file="./header.jsp"%>

<%!String spot0;
	String spot1;
	String spot2;
	String spot3;

	String pmsdata0;
	String pmsdata1;
	String pmsdata2;
	String pmsdata3;%>

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
	String sql = "select pmsdata, count(*) as w_cnt0 from test_table where spot = 0 and pmsdata > 100";
	stmt1 = conn.createStatement();
	rs1 = stmt1.executeQuery(sql);

	while (rs1.next()) {

		pmsdata0 = rs1.getString("w_cnt0");

	}

	//2 번째 쿼리문 
	String sql2 = "select pmsdata, count(*) as w_cnt1 from test_table where spot = 1 and pmsdata > 100";
	stmt2 = conn.createStatement();
	rs2 = stmt2.executeQuery(sql2);

	while (rs2.next()) {

		pmsdata1 = rs2.getString("w_cnt1");

	}

	//3 번째 쿼리문 
	String sql3 = "select pmsdata, count(*) as w_cnt2 from test_table where spot = 2 and pmsdata > 100";
	stmt3 = conn.createStatement();
	rs3 = stmt3.executeQuery(sql3);

	while (rs3.next()) {

		pmsdata2 = rs3.getString("w_cnt2");

	}

	//4 번째 쿼리문 
	String sql4 = "select pmsdata, count(*) as w_cnt3 from test_table where spot = 3 and pmsdata > 100";
	stmt4 = conn.createStatement();
	rs4 = stmt4.executeQuery(sql4);

	while (rs4.next()) {

		pmsdata3 = rs4.getString("w_cnt3");

	}

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
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>

	<figure class="highcharts-figure">
		<div id="container"></div>
		<p class="highcharts-description"></p>




		<script type="text/javascript">
			//theme 색깔 적용
			if (!Highcharts.theme) {
				Highcharts.setOptions({
					chart : {
						backgroundColor : 'white'
					},
					colors : [ '#F62366', '#9DFF02', '#0CCDD6', '#EE82EE' ],
					title : {
						style : {
							color : 'gray'
						}
					},
					tooltip : {
						style : {
							color : 'silver'
						}
					}
				});
			}
			// 차트 그리기 시작

			Highcharts.chart('container',{
				chart : { type : 'pie'},
				title : { text : ' [ 미세먼지 수치 현황 ] '},
				tooltip : { headerFormat : '',
							pointFormat : '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' + '<b>{point.y}</b>회'},
				series : [ {
							minPointSize : 10,
							innerSize : '20%',
							name : 'spots',
							data : [ {
										name : 'SPOT 0',
										y :<%=Float.parseFloat(pmsdata0)%>
									  }, 
									  
										
									{
										name : 'SPOT 1',
										y :<%=Float.parseFloat(pmsdata1)%>
									  },
									  
										
									{
										name : 'SPOT 2',
										y :<%=Float.parseFloat(pmsdata2)%>
									  },
									
									{
										name : 'SPOT 3',
										y :<%=Float.parseFloat(pmsdata3)%>
									  } ]
				
							} ]
					});
		</script>
	</figure>

</body>

</html>