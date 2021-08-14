<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>

<html>
<head>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

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
<%@ include file="./header.jsp"%>
</head>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class ="chart-desc" style = "font-family: 'Noto Sans KR', sans-serif; text-align: center; ">
    <%= sf.format(nowTime) %>
    <table id="datatable">
        <thead>
            <tr>
                <th></th>
                <th> 미세먼지 수치</th>
            
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>SPOT 1</th>
                <td>520</td>
                
            </tr>
            <tr>
                <th>SPOT 2</th>
                <td>128</td>
                
            </tr>
            <tr>
                <th>SPOT 3</th>
                <td>1270</td>
                
            </tr>
            <tr>
                <th>SPOT 4</th>
                <td>812</td>
                
            </tr>
        </tbody>
    </table>
    
</figure>


<script type="text/javascript">
    Highcharts.chart('container', {
        data: {
            table: 'datatable'
        },
        chart: {
            type: 'column'
        },
        title: {
            text: '현재 구역 별 미세먼지 수치'
        },
        yAxis: {
            allowDecimals: false,
            title: {
                text: '미세먼지 수치 '
            }
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                    this.point.y + ' ' + this.point.name.toLowerCase();
            }
        }
    });
</script>

</html>

