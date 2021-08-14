<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
   <head>
      <title>Fine Dust Level By Date</title>
      <script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
      <script src = "https://code.highcharts.com/highcharts.js"></script>  
      
      <!-- google fonts -->
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
      
       <!-- Site Icons -->
      <link rel="shortcut icon" href="image/sap_logo.png"/>

      <%@ include file = "./header.jsp" %>
      
   
   </head>
   
   <body>
      <div id = "container" style = "width: 1000px; height: 600px; margin: 0 auto"></div>
       <p class="chart-desc" style = "font-family: 'Noto Sans KR', sans-serif; text-align: center; ">
       2021년 1월 24일 SPOT 0의 미세먼지 농도가 가장 높습니다. 
       </p>
      <script language = "JavaScript">
         $(document).ready(function() {  
            var chart = {
               type: 'spline'      
            }; 
            var title = {
               text: 'Fine Dust Level By Date'   
            };
            var subtitle = {
               text: 'DATE RANGE: 2020-08-09 ~ 2021-03-25 '
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
                     // Define the data points. All series have a dummy year
                     // of 1970/71 in order to be compared on the same x axis.
                     // Note that in JavaScript, months start at 0 for January,
                     // 1 for February etc.
                  data: [
                     [Date.UTC(1970,  9, 9), 152 ],
                     [Date.UTC(1970, 9, 14), 57 ],
                     [Date.UTC(1970, 10, 1), 72 ],
                     [Date.UTC(1970, 10, 28), 143 ],
                     [Date.UTC(1970, 11,  1), 270 ],
                     [Date.UTC(1970, 11,  12), 110 ],
                     [Date.UTC(1971, 0, 1), 520 ],
                     [Date.UTC(1971, 0, 24), 1290],
                     [Date.UTC(1971,  1,  1), 820],
                     [Date.UTC(1971,  1,  7), 780],
                     [Date.UTC(1971,  1, 23), 980],
                     [Date.UTC(1971,  2, 8), 801],
                     [Date.UTC(1971,  2, 14), 780],
                     [Date.UTC(1971,  2, 24), 592], 
                     [Date.UTC(1971,  3, 4), 276],
                     [Date.UTC(1971,  3, 18), 341 ],
                     [Date.UTC(1971,  3, 24), 211 ],
                     [Date.UTC(1971,  4,  16), 625],
                     [Date.UTC(1971,  4, 25), 234]
                  ]
               }, 
               {
                  name: 'SPOT 1',
                  data: [
                     [Date.UTC(1970,  9, 9), 117  ],
                     [Date.UTC(1970,  9, 14), 200 ],
                     [Date.UTC(1970, 10,  1), 342],
                     [Date.UTC(1970, 10,  28), 247],
                     [Date.UTC(1970, 11, 1), 420],
                     [Date.UTC(1970, 11, 12), 255],
                     [Date.UTC(1971, 0, 1), 138],
                     [Date.UTC(1971,  0,  24), 177],
                     [Date.UTC(1971,  1, 1), 160],
                     [Date.UTC(1971,  1, 7), 138],
                     [Date.UTC(1971,  1,  23), 248],
                     [Date.UTC(1971,  2, 8), 315 ],
                     [Date.UTC(1971,  2, 14), 189],
                     [Date.UTC(1971,  2, 24), 290 ],
                     [Date.UTC(1971,  3,  4), 194],
                     [Date.UTC(1971,  3,  18), 491],
                     [Date.UTC(1971,  3, 24), 175],
                     [Date.UTC(1971,  4, 16), 316 ],
                     [Date.UTC(1971,  4, 25), 206 ]
                     
                  ]
               }, 
               {
                  name: 'SPOT 2',
                  data: [
                     [Date.UTC(1970,  9,  9), 117   ],
                     [Date.UTC(1970,  9, 14), 215],
                     [Date.UTC(1970, 10, 1), 325],
                     [Date.UTC(1970, 10, 28), 135],
                     [Date.UTC(1970, 11, 1), 255],
                     [Date.UTC(1970, 11, 12), 346],
                     [Date.UTC(1971,  0,  1), 590],
                     [Date.UTC(1971,  0, 24), 358],
                     [Date.UTC(1971,  1,  1), 629],
                     [Date.UTC(1971,  1,  7), 652],
                     [Date.UTC(1971,  1, 23), 770],
                     [Date.UTC(1971,  2,  8), 577],
                     [Date.UTC(1971,  2, 14), 790],
                     [Date.UTC(1971,  2, 24), 860],
                     [Date.UTC(1971,  3,  4), 638 ],
                     [Date.UTC(1971,  3, 18), 940],
                     [Date.UTC(1971,  3, 24), 293 ],
                     [Date.UTC(1971,  4, 16), 390],
                     [Date.UTC(1971,  4, 25), 117   ]
                  ]
               },
               {
                   name: 'SPOT 3',
                   data: [
                      [Date.UTC(1970,  9,  9), 128],
                      [Date.UTC(1970,  9, 14), 250],
                      [Date.UTC(1970, 10, 1), 555],
                      [Date.UTC(1970, 10, 28), 420],
                      [Date.UTC(1970, 11, 1), 782],
                      [Date.UTC(1970, 11, 12), 642],
                      [Date.UTC(1971,  0,  1), 496],
                      [Date.UTC(1971,  0, 24), 825],
                      [Date.UTC(1971,  1,  1), 526],
                      [Date.UTC(1971,  1,  7), 421],
                      [Date.UTC(1971,  1, 23), 246],
                      [Date.UTC(1971,  2,  8), 532],
                      [Date.UTC(1971,  2, 14), 647],
                      [Date.UTC(1971,  2, 24), 382],
                      [Date.UTC(1971,  3,  4), 334],
                      [Date.UTC(1971,  3, 18), 941],
                      [Date.UTC(1971,  3, 24), 498],
                      [Date.UTC(1971,  4, 16), 723],
                      [Date.UTC(1971,  4, 25), 453   ]
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
      </script>
   </body>
   
</html>
