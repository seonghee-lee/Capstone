<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Calendar" %>

<html>
	<head>
     
		<%@ include file="dbconn.jsp"%>
		<%@ include file = "./header.jsp" %> 

		<!-- google fonts -->
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

        <meta charset="UTF-8" />
        <title>jQuery UI</title>
 
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>

        <style>    
        
            /* Default */
            input[type=text],input[type=password]{font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif}
            *{margin:0;padding:0;font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif}
            body{font-size:12px;color:#555;background:transparent;-webkit-user-select:none;-moz-user-select:none;-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none}
            ol,ul{list-style:none} 
            table{table-layout:fixed;width:100%;border-collapse:collapse;border-spacing:0}
            caption{overflow:hidden;width:0;height:0;font-size:0;line-height:0;text-indent:-999em}
            img,fieldset{border:0}
            legend{height:0;visibility:hidden}
            em,address{font-style:normal}
            img{border:0 none;vertical-align:middle}
            a{color:#555;text-decoration:none}
            input,select{margin:0;padding:0;vertical-align:middle}
            button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
            button::-moz-focus-inner{border:0;padding:0}
            header,footer,aside,nav,section,article{display:block}

            .clearfix{*zoom:1}
            .clearfix:after{content:"";display:block;clear:both;overflow:hidden}

            /* Search */
            .searchBox{border:none}
            .searchBox tbody th{padding:20px 10px 20px 35px;font-size:14px;font-weight:bold;text-align:left;vertical-align:top;border:none;background:#e6e6e6 }
            .searchBox tbody td{padding:12px 10px 12px 25px;border:none;background-color:#efefef}
        
            .searchDate{overflow:hidden;margin-bottom:10px;*zoom:1}
            .searchDate:after{display:block;clear:both;content:''}
            .searchDate li{position:relative;float:left;margin:0 7px 0 0}
            .searchDate li .chkbox2{display:block;text-align:center}
            .searchDate li .chkbox2 input{position:absolute;z-index:-1}
            .searchDate li .chkbox2 label{display:block;width:72px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#a5b0b6}
            .searchDate li .chkbox2.on label{background:#ec6a6a}
        
            .demi{display:inline-block;margin:0 1px;vertical-align:middle}
            .inpType{padding-left:6px;height:24px;line-height:24px;border:1px solid #dbdbdb}
            .btncalendar{display:inline-block;width:22px;height:22px;background:url(images/btn_calendar.gif) center center no-repeat;text-indent:-999em}

			#date_btn{ 
				border: 1px solid gray; 
				background-color: gray; 
				color: white; 
				padding: 5px;
			}
			#time_btn{ 
				border: 1px solid gray; 
				background-color: rgba(0,0,0,0); 
				color: gray; 
				padding: 5px;
			}


        </style>  
        
    	
    	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js" ></script>
		<!-- datepicker 한국어로 -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>	     
		
        <script> 
        

        $(document).ready(function() {
        	

            //datepicker 한국어로 사용하기 위한 언어설정
            $.datepicker.setDefaults($.datepicker.regional['ko']);    

            
            // Datepicker            
            $(".datepicker").datepicker({
                showButtonPanel: true,
                dateFormat: "yy-mm-dd",
                maxDate: 0,
                onClose : function ( selectedDate ) {
                
                    var eleId = $(this).attr("id");
                    var optionName = "";

                    if(eleId.indexOf("StartDate") > 0) {
                        eleId = eleId.replace("StartDate", "EndDate");
                        optionName = "minDate";
                    } else {
                        eleId = eleId.replace("EndDate", "StartDate");
                        optionName = "maxDate";
                    }

                    $("#"+eleId).datepicker( "option", optionName, selectedDate );        
                    $(".searchDate").find(".chkbox2").removeClass("on"); 
                }
            });          
             

            //시작일.
            /*$('#searchStartDate').datepicker("option","onClose", function( selectedDate ) {    
                // 시작일 datepicker가 닫힐때
                // 종료일의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#searchEndDate").datepicker( "option", "minDate", selectedDate );
                $(".searchDate").find(".chkbox2").removeClass("on");
            });
            */

            //종료일.
            /*$('#searchEndDate').datepicker("option","onClose", function( selectedDate ) {    
                // 종료일 datepicker가 닫힐때
                // 시작일의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#searchStartDate").datepicker( "option", "maxDate", selectedDate );
                $(".searchDate").find(".chkbox2").removeClass("on");
            });
            */

            $(".dateclick").dateclick();    // DateClick
            $(".searchDate").schDate();        // searchDate
            

        }); //ready

        // Search Date
        jQuery.fn.schDate = function(){
            var $obj = $(this);
            var $chk = $obj.find("input[type=radio]");
            $chk.click(function(){                
                $('input:not(:checked)').parent(".chkbox2").removeClass("on");
                $('input:checked').parent(".chkbox2").addClass("on");                    
            });
        };

        // DateClick
        jQuery.fn.dateclick = function(){
            var $obj = $(this);
            $obj.click(function(){
                $(this).parent().find("input").focus();
            });
        }    

        
        function setSearchDate(start){

            var num = start.substring(0,1);
            var str = start.substring(1,2);

            var today = new Date();

            //var year = today.getFullYear();
            //var month = today.getMonth() + 1;
            //var day = today.getDate();
            
            var endDate = $.datepicker.formatDate('yy-mm-dd', today);
            $('#searchEndDate').val(endDate);
            
            if(str == 'd'){
                today.setDate(today.getDate() - num);
            }else if (str == 'w'){
                today.setDate(today.getDate() - (num*7));
            }else if (str == 'm'){
                today.setMonth(today.getMonth() - num);
                today.setDate(today.getDate() + 1);
            }

            var startDate = $.datepicker.formatDate('yy-mm-dd', today);
            $('#searchStartDate').val(startDate);
                    
            // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
            $("#searchEndDate").datepicker( "option", "minDate", true );
            
            // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
            $("#searchStartDate").datepicker( "option", "maxDate", true );
            
            $("#searchStartDate").datepicker('disable').removeAttr('disabled');
            $("#searchEndDate").datepicker('disable').removeAttr('disabled');

        }
        
        </script>        
		


    </head>    
    <body> 	    

        <form id="searchform" onsubmit="return false">
          
        <!-- search -->
        <table class="searchBox">
            <caption>조회</caption>
            <colgroup>
                <col width="123px">
                <col width="*">
            </colgroup>
            <tbody>
                <tr>
                    <th>조회기간</th>
                    <td>
                        <ul class="searchDate" >
                            
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType2" onclick="setSearchDate('3d')"/>
                                    <label for="dateType2">3일</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1w')"/>
                                    <label for="dateType3">7일</label>
                                </span>
                            </li>

                            
                        </ul>
                        
                        <div class="clearfix">
                            <!-- 시작일 -->
                            <span class="dset">
                                <input type="text" name="searchStartDate" id="searchStartDate" readonly>
                                <a href="#none" class="btncalendar dateclick">달력</a>
                            </span>
                            <span class="demi">~</span>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <!-- 종료일 -->
                            <span class="dset">
                                <input type="text" name="searchEndDate" id="searchEndDate" disabled>
                                <a href="#none" class="btncalendar dateclick">달력</a>
                            </span>
                        </div>                                     

                    </td>
                </tr>
            <tbody>
        </table>
        </form>
           
<!-- 3일 버튼 -->
        <form id="chartform">
       	<script type="text/javascript">
       		
       		
        	const script_element1 = document.createElement('script');
        	const script_element2 = document.createElement('script');
        	script_element1.setAttribute('src', 'https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js')
        	script_element1.setAttribute('src', 'https://code.highcharts.com/highcharts.js')
        	document.querySelector('head').appendChild(script_element1);
        	document.querySelector('head').appendChild(script_element2);

			
        	$(function(){
  	   			    
		       	$("#dateType2").click(function() {
			       	$("body").append("<div id = \"container\" style = \"width: 1000px; height: 600px; margin: 0 auto\"></div>");

		       		$("body").append("<p class=\"chart-desc\" style = \"font-family: 'Noto Sans KR', sans-serif; text-align: center; \"></p>");
					
		       		var start_date = $("#searchStartDate").val();
		    		var end_date = $("#searchEndDate").val();      
		    		
		    		      
		    	}); 
		       	
		       	$("#dateType3").click(function() {
			       	$("body").append("<div id = \"container\" style = \"width: 1000px; height: 600px; margin: 0 auto\"></div>");

		       		$("body").append("<p class=\"chart-desc\" style = \"font-family: 'Noto Sans KR', sans-serif; text-align: center; \"></p>");
					
		       		var start_date = $("#searchStartDate").val();
		    		var end_date = $("#searchEndDate").val();      
	    		      
		    	}); 

	        })
	        
		</script>

		<%
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			ResultSet rs3 = null;
			ResultSet rs4 = null;
			Statement stmt1 = null;
			Statement stmt2 = null;
			Statement stmt3 = null;
			Statement stmt4 = null;
								
		
			Calendar cal = Calendar.getInstance();
			request.setCharacterEncoding("utf-8");
			
			
			String[] avg0 = new String[8];
			String[] date0 = new String[8];
			String[] utc0 = new String[8];
			String[] avg1 = new String[8];
			String[] date1 = new String[8];
			String[] utc1 = new String[8];
			String[] avg2 = new String[8];
			String[] date2 = new String[8];
			String[] utc2 = new String[8];
			String[] avg3 = new String[8];
			String[] date3 = new String[8];
			String[] utc3 = new String[8];

			

			String Sstart_date = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+(cal.get(Calendar.DATE)-7);					
    		String Send_date = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+(cal.get(Calendar.DATE)+1);
			
//    		String Sstart_date="2021-09-04";
//    		String Send_date="2021-09-11";
								
			try {
					//spot0
					String sql = "SELECT DATE(`date`) as date, avg(pmsdata) as avg0 FROM test_table WHERE spot=0 and date BETWEEN '"+Sstart_date+"' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sql);
				
				
					for(int i=0; rs1.next(); i++){
						date0[i] = rs1.getString(1);
						avg0[i] = rs1.getString(2);
					 	int Month = Integer.parseInt(date0[i].substring(5,7))-1;
					 	String SMonth = Integer.toString(Month);
						String utc = date0[i].substring(0,4)+", "+SMonth+", "+date0[i].substring(8,10);
						utc0[i] = "Date.UTC("+utc+")";
					}	
					
					//spot1
					sql = "SELECT DATE(`date`) as date, avg(pmsdata) as avg1 FROM test_table WHERE spot=1 and date BETWEEN '" +Sstart_date+ "' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
					stmt2 = conn.createStatement();
					rs2 = stmt2.executeQuery(sql);
				
				
					for(int i=0; rs2.next(); i++){
						date1[i] = rs2.getString(1);
						avg1[i] = rs2.getString(2);
					 	int Month = Integer.parseInt(date1[i].substring(5,7))-1;
					 	String SMonth = Integer.toString(Month);
						String utc = date1[i].substring(0,4)+", "+SMonth+", "+date1[i].substring(8,10);
						utc1[i] = "Date.UTC("+utc+")";
					}
					
					//spot2
					sql = "SELECT DATE(`date`) as date, avg(pmsdata) as avg2 FROM test_table WHERE spot=2 and date BETWEEN '" +Sstart_date+ "' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
					stmt3 = conn.createStatement();
					rs3 = stmt3.executeQuery(sql);
				
				
					for(int i=0; rs3.next(); i++){
						date2[i] = rs3.getString(1);
						avg2[i] = rs3.getString(2);
					 	int Month = Integer.parseInt(date2[i].substring(5,7))-1;
					 	String SMonth = Integer.toString(Month);
						String utc = date2[i].substring(0,4)+", "+SMonth+", "+date2[i].substring(8,10);
						utc2[i] = "Date.UTC("+utc+")";
					}
					
					//spot3
					sql = "SELECT DATE(`date`) as date, avg(pmsdata) as avg3 FROM test_table WHERE spot=3 and date BETWEEN '" +Sstart_date+ "' AND '"+Send_date+"' GROUP BY DATE(`date`), spot";
					stmt4 = conn.createStatement();
					rs4 = stmt4.executeQuery(sql);
				
					for(int i=0; rs4.next(); i++){
						date3[i] = rs4.getString(1);
						avg3[i] = rs4.getString(2);
					 	int Month = Integer.parseInt(date3[i].substring(5,7))-1;
					 	String SMonth = Integer.toString(Month);
						String utc = date3[i].substring(0,4)+", "+SMonth+", "+date3[i].substring(8,10);
						utc3[i] = "Date.UTC("+utc+")";
						
						
					}
	
								
				}catch (SQLException ex) {
					out.println("SQLException: " + ex.getMessage());
				} finally {
					
				}
			
		%>
		
		<script type="text/javascript">
	    	$(function(){	 			    
		       	$("#dateType2").click(function() {

		    		var chart = {
		    		   	type: 'spline'
		    		}; 
		    		var title = {
		    		   	text: 'Fine Dust Level By Date'   
		    		};
		    		var subtitle = {
		    			text: ''
		    				
		    		};
		    		var xAxis = {
		    			type: 'datetime',
		    			dateTimeLabelFormats: { // don't display the dummy year
		    				month: '%e. %b',
		    				year: '%Y.'
		    			},
		    			title: {
		    				text: 'Date'
		    			}
		    		};
		    		var yAxis = {
		    			title: {
		    				text: 'Fine Dust Level'
		    			},
		    			min: 0
		    		};
		    		var tooltip = {
		    			headerFormat: '<b>{series.name}</b><br>',
		    			pointFormat: '{point.x:%e. %b}: {point.y:.2f}'
		    		};
		    		var plotOptions = {
		    			spline: {
		    			   	marker: {
		    			  		enabled: true
		    			   	}
		    			}
		    		};
		    		var series = [
		    		 	{
		    			   	name: 'SPOT 0',
		    			    data: [
					    			               	  
			    			    	[<%=utc0[4]%>, <%=Float.parseFloat(avg0[4])%>],
				    			    [<%=utc0[5]%>, <%=Float.parseFloat(avg0[5])%>],
				    			    [<%=utc0[6]%>, <%=Float.parseFloat(avg0[6])%>],
				    			    [<%=utc0[7]%>, <%=Float.parseFloat(avg0[7])%>]
		    			    ]
		    			},
		    		 	{
		    			   	name: 'SPOT 1',
		    			    data: [
					    			               	  
			    			    	[<%=utc1[4]%>, <%=Float.parseFloat(avg1[4])%>],
				    			    [<%=utc1[5]%>, <%=Float.parseFloat(avg1[5])%>],
				    			    [<%=utc1[6]%>, <%=Float.parseFloat(avg1[6])%>],
				    			    [<%=utc1[7]%>, <%=Float.parseFloat(avg1[7])%>]
		    			    ]
		    			},
		    		 	{
		    			   	name: 'SPOT 2',
		    			    data: [
					    			               	  
			    			    	[<%=utc2[4]%>, <%=Float.parseFloat(avg2[4])%>],
				    			    [<%=utc2[5]%>, <%=Float.parseFloat(avg2[5])%>],
				    			    [<%=utc2[6]%>, <%=Float.parseFloat(avg2[6])%>],
				    			    [<%=utc2[7]%>, <%=Float.parseFloat(avg2[7])%>]
		    			    ]
		    			},
		    		 	{
		    			   	name: 'SPOT 3',
		    			    data: [
		    			    	
			    			    	[<%=utc3[4]%>, <%=Float.parseFloat(avg3[4])%>],
				    			    [<%=utc3[5]%>, <%=Float.parseFloat(avg3[5])%>],
				    			    [<%=utc3[6]%>, <%=Float.parseFloat(avg3[6])%>],
				    			    [<%=utc3[7]%>, <%=Float.parseFloat(avg3[7])%>]
		    			    ]
		    			}
		    			
		    		];
		    						            
		    		var json = {};
		    		json.chart = chart;
		    		json.title = title;
		    		json.subtitle = subtitle;
		    		json.tooltip = tooltip;
		    		json.xAxis = xAxis;
		    		json.yAxis = yAxis;  
		    		json.series = series;
		    		json.plotOptions = plotOptions;
		    		
		    		$('#container').highcharts(json);
		    		$('#container').setOptions({
		    			global: {
		    				useUTC: false
		    			}
		    		});
		    		
		    		
		    	}); 

	        
				$("#dateType3").click(function() {

			    	var chart = {
			    		   	type: 'spline'
			    		}; 
			    		var title = {
			    		   	text: 'Fine Dust Level By Date'   
			    		};
			    		var subtitle = {
			    			text: ''
			    				
			    		};
			    		var xAxis = {
			    			type: 'datetime',
			    			dateTimeLabelFormats: { // don't display the dummy year
			    				month: '%e. %b',
			    				year: '%b'
			    			},
			    			title: {
			    				text: 'Date'
			    			}
			    		};
			    		var yAxis = {
			    			title: {
			    				text: 'Fine Dust Level'
			    			},
			    			min: 0
			    		};
			    		var tooltip = {
			    			headerFormat: '<b>{series.name}</b><br>',
			    			pointFormat: '{point.x:%e. %b}: {point.y:.2f}'
			    		};
			    		var plotOptions = {
			    			spline: {
			    			   	marker: {
			    			  		enabled: true
			    			   	}
			    			}
			    		};
			    		var series = [
			    		 	{
			    			   	name: 'SPOT 0',
			    			    data: [
					    			               	  
			    			    		[<%=utc0[0]%>, <%=Float.parseFloat(avg0[0])%>],
					    			    [<%=utc0[1]%>, <%=Float.parseFloat(avg0[1])%>],
					    			    [<%=utc0[2]%>, <%=Float.parseFloat(avg0[2])%>],
					    			    [<%=utc0[3]%>, <%=Float.parseFloat(avg0[3])%>],
					    			    [<%=utc0[4]%>, <%=Float.parseFloat(avg0[4])%>],
					    			    [<%=utc0[5]%>, <%=Float.parseFloat(avg0[5])%>],
					    			    [<%=utc0[6]%>, <%=Float.parseFloat(avg0[6])%>],
					    			    [<%=utc0[7]%>, <%=Float.parseFloat(avg0[7])%>]
			    			    ]
			    			},
			    		 	{
			    			   	name: 'SPOT 1',
			    			    data: [
						    			               	  
				    			    	[<%=utc1[0]%>, <%=Float.parseFloat(avg1[0])%>],
					    			    [<%=utc1[1]%>, <%=Float.parseFloat(avg1[1])%>],
					    			    [<%=utc1[2]%>, <%=Float.parseFloat(avg1[2])%>],
					    			    [<%=utc1[3]%>, <%=Float.parseFloat(avg1[3])%>],
					    			    [<%=utc1[4]%>, <%=Float.parseFloat(avg1[4])%>],
					    			    [<%=utc1[5]%>, <%=Float.parseFloat(avg1[5])%>],
					    			    [<%=utc1[6]%>, <%=Float.parseFloat(avg1[6])%>],
					    			    [<%=utc1[7]%>, <%=Float.parseFloat(avg1[7])%>]
			    			    ]
			    			},
			    		 	{
			    			   	name: 'SPOT 2',
			    			    data: [
						    			               	  
				    			    	[<%=utc2[0]%>, <%=Float.parseFloat(avg2[0])%>],
					    			    [<%=utc2[1]%>, <%=Float.parseFloat(avg2[1])%>],
					    			    [<%=utc2[2]%>, <%=Float.parseFloat(avg2[2])%>],
					    			    [<%=utc2[3]%>, <%=Float.parseFloat(avg2[3])%>],
					    			    [<%=utc2[4]%>, <%=Float.parseFloat(avg2[4])%>],
					    			    [<%=utc2[5]%>, <%=Float.parseFloat(avg2[5])%>],
					    			    [<%=utc2[6]%>, <%=Float.parseFloat(avg2[6])%>],
					    			    [<%=utc2[7]%>, <%=Float.parseFloat(avg2[7])%>]
			    			    ]
			    			},
			    		 	{
			    			   	name: 'SPOT 3',
			    			    data: [
						    			               	  
				    			    	[<%=utc3[0]%>, <%=Float.parseFloat(avg3[0])%>],
					    			    [<%=utc3[1]%>, <%=Float.parseFloat(avg3[1])%>],
					    			    [<%=utc3[2]%>, <%=Float.parseFloat(avg3[2])%>],
					    			    [<%=utc3[3]%>, <%=Float.parseFloat(avg3[3])%>],
					    			    [<%=utc3[4]%>, <%=Float.parseFloat(avg3[4])%>],
					    			    [<%=utc3[5]%>, <%=Float.parseFloat(avg3[5])%>],
					    			    [<%=utc3[6]%>, <%=Float.parseFloat(avg3[6])%>],
					    			    [<%=utc3[7]%>, <%=Float.parseFloat(avg3[7])%>]
			    			    ]
			    			}
			    			
			    		];
			    						            
			    		var json = {};
			    		json.chart = chart;
			    		json.title = title;
			    		json.subtitle = subtitle;
			    		json.tooltip = tooltip;
			    		json.xAxis = xAxis;
			    		json.yAxis = yAxis;  
			    		json.series = series;
			    		json.plotOptions = plotOptions;
			    		$('#container').highcharts(json);
			    		
			    		
			    	}); 
		        })
	        
		</script>

		</form>		
     
	</body>
</html>	
