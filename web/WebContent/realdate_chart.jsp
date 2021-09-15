<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Calendar" %>
<%@ include file="dbconn.jsp"%>


<%! 
	String[] w_avg0 = new String[8];
	String[] w_avg1 = new String[8];
	String[] w_avg2 = new String[8];
	String[] w_avg3 = new String[8];
	
	String[] date0 = new String[8];
	String[] date1= new String[8];
	String[] date2 = new String[8];
	String[] date3 = new String[8];
	
	String[] utc0 = new String[8];
	String[] utc1 = new String[8];
	String[] utc2 = new String[8];
	String[] utc3 = new String[8];

	
%>

<%
	
Calendar cal = Calendar.getInstance();
request.setCharacterEncoding("utf-8");

ResultSet ars1 = null;
ResultSet ars2 = null;
ResultSet ars3 = null;
ResultSet ars4 = null;

Statement astmt1 = null;
Statement astmt2 = null;
Statement astmt3 = null;
Statement astmt4 = null;

String Sstart_date = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+(cal.get(Calendar.DATE)-7);					
String Send_date = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+(cal.get(Calendar.DATE)+1);

try {

	//첫 번째 쿼리문 
	String asql = "SELECT DATE(`date`) as date, avg(pmsdata) as w_avg0 FROM test_table WHERE spot=0 and date BETWEEN '"+Sstart_date+"' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
	astmt1 = conn.createStatement();
	ars1 = astmt1.executeQuery(asql);

	for(int i=0; ars1.next(); i++){
		date0[i] = ars1.getString(1);
		w_avg0[i] = ars1.getString(2);
	 	int Month = Integer.parseInt(date0[i].substring(5,7))-1;
	 	String SMonth = Integer.toString(Month);
		String utc = date0[i].substring(0,4)+", "+SMonth+", "+date0[i].substring(8,10);
		utc0[i] = "Date.UTC("+utc+")";
	}	

	//2 번째 쿼리문 
	String asql2 = "SELECT DATE(`date`) as date, avg(pmsdata) as w_avg1 FROM test_table WHERE spot=1 and date BETWEEN '"+Sstart_date+"' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
	astmt2 = conn.createStatement();
	ars2 = astmt2.executeQuery(asql2);

	for(int i=0; ars2.next(); i++){
		date1[i] = ars2.getString(1);
		w_avg1[i] = ars2.getString(2);
	 	int Month = Integer.parseInt(date1[i].substring(5,7))-1;
	 	String SMonth = Integer.toString(Month);
		String utc = date1[i].substring(0,4)+", "+SMonth+", "+date1[i].substring(8,10);
		utc1[i] = "Date.UTC("+utc+")";
	}

	//3 번째 쿼리문 
	String asql3 = "SELECT DATE(`date`) as date, avg(pmsdata) as w_avg2 FROM test_table WHERE spot=2 and date BETWEEN '"+Sstart_date+"' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
	astmt3 = conn.createStatement();
	ars3 = astmt3.executeQuery(asql3);

	for(int i=0; ars3.next(); i++){
		date2[i] = ars3.getString(1);
		w_avg2[i] = ars3.getString(2);
	 	int Month = Integer.parseInt(date2[i].substring(5,7))-1;
	 	String SMonth = Integer.toString(Month);
		String utc = date2[i].substring(0,4)+", "+SMonth+", "+date2[i].substring(8,10);
		utc2[i] = "Date.UTC("+utc+")";
	}

	//4 번째 쿼리문 
	String asql4 ="SELECT DATE(`date`) as date, avg(pmsdata) as w_avg3 FROM test_table WHERE spot=3 and date BETWEEN '"+Sstart_date+"' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
	astmt4 = conn.createStatement();
	ars4 = astmt4.executeQuery(asql4);

	for(int i=0; ars4.next(); i++){
		date3[i] = ars4.getString(1);
		w_avg3[i] = ars4.getString(2);
	 	int Month = Integer.parseInt(date3[i].substring(5,7))-1;
	 	String SMonth = Integer.toString(Month);
		String utc = date3[i].substring(0,4)+", "+SMonth+", "+date3[i].substring(8,10);
		utc3[i] = "Date.UTC("+utc+")";
		
		
	}
} catch (SQLException ex) {
	out.println("SQLException: " + ex.getMessage());

} finally {


}
%>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container3"></div>
    <p class="highcharts-description">
        
    </p>
</figure>


	
	<script type = "text/javascript">
	Highcharts.chart('container3', {
		chart: {
			backgroundColor: '#f2f0f1'
		},

	    title: {
	        text: '[일주일 간 미세먼지 평균 수치]'
	    },

	    subtitle: {
	       
	    },

	    yAxis: {
	        title: {
	            text: '㎍/m³'
	        }
	    },

	    xAxis: {
	       accessibility: {
	            rangeDescription: 'Range: Sstart_date to Send_date'   
	          
	        },
	        type: 'datetime'
	      
	    },

	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'middle'
	    },

	    plotOptions: {
	        series: {
	            label: {
	                connectorAllowed: false
	            },
	            pointStart: "Sstart_date"
	        } 
	       
	    },

	    series: [
		 	{
			   	name: 'SPOT 0',
			    data: [
	    			               	  
			    		[<%=utc0[0]%>, <%=Float.parseFloat(w_avg0[0])%>],
	    			    [<%=utc0[1]%>, <%=Float.parseFloat(w_avg0[1])%>],
	    			    [<%=utc0[2]%>, <%=Float.parseFloat(w_avg0[2])%>],
	    			    [<%=utc0[3]%>, <%=Float.parseFloat(w_avg0[3])%>],
	    			    [<%=utc0[4]%>, <%=Float.parseFloat(w_avg0[4])%>],
	    			    [<%=utc0[5]%>, <%=Float.parseFloat(w_avg0[5])%>],
	    			    [<%=utc0[6]%>, <%=Float.parseFloat(w_avg0[6])%>],
	    			    [<%=utc0[7]%>, <%=Float.parseFloat(w_avg0[7])%>]
			    ]
			},
		 	{
			   	name: 'SPOT 1',
			    data: [
		    			               	  
    			    	[<%=utc1[0]%>, <%=Float.parseFloat(w_avg1[0])%>],
	    			    [<%=utc1[1]%>, <%=Float.parseFloat(w_avg1[1])%>],
	    			    [<%=utc1[2]%>, <%=Float.parseFloat(w_avg1[2])%>],
	    			    [<%=utc1[3]%>, <%=Float.parseFloat(w_avg1[3])%>],
	    			    [<%=utc1[4]%>, <%=Float.parseFloat(w_avg1[4])%>],
	    			    [<%=utc1[5]%>, <%=Float.parseFloat(w_avg1[5])%>],
	    			    [<%=utc1[6]%>, <%=Float.parseFloat(w_avg1[6])%>],
	    			    [<%=utc1[7]%>, <%=Float.parseFloat(w_avg1[7])%>]
			    ]
			},
		 	{
			   	name: 'SPOT 2',
			    data: [
		    			               	  
    			    	[<%=utc2[0]%>, <%=Float.parseFloat(w_avg2[0])%>],
	    			    [<%=utc2[1]%>, <%=Float.parseFloat(w_avg2[1])%>],
	    			    [<%=utc2[2]%>, <%=Float.parseFloat(w_avg2[2])%>],
	    			    [<%=utc2[3]%>, <%=Float.parseFloat(w_avg2[3])%>],
	    			    [<%=utc2[4]%>, <%=Float.parseFloat(w_avg2[4])%>],
	    			    [<%=utc2[5]%>, <%=Float.parseFloat(w_avg2[5])%>],
	    			    [<%=utc2[6]%>, <%=Float.parseFloat(w_avg2[6])%>],
	    			    [<%=utc2[7]%>, <%=Float.parseFloat(w_avg2[7])%>]
			    ]
			},
		 	{
			   	name: 'SPOT 3',
			    data: [
		    			               	  
    			    	[<%=utc3[0]%>, <%=Float.parseFloat(w_avg3[0])%>],
	    			    [<%=utc3[1]%>, <%=Float.parseFloat(w_avg3[1])%>],
	    			    [<%=utc3[2]%>, <%=Float.parseFloat(w_avg3[2])%>],
	    			    [<%=utc3[3]%>, <%=Float.parseFloat(w_avg3[3])%>],
	    			    [<%=utc3[4]%>, <%=Float.parseFloat(w_avg3[4])%>],
	    			    [<%=utc3[5]%>, <%=Float.parseFloat(w_avg3[5])%>],
	    			    [<%=utc3[6]%>, <%=Float.parseFloat(w_avg3[6])%>],
	    			    [<%=utc3[7]%>, <%=Float.parseFloat(w_avg3[7])%>]
			    ]
			}
			
		]
	    

	});
   </script>
   
      
	








