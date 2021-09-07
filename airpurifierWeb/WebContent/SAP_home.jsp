<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>SAP_HOME</title>
<!-- Site Icons -->
<link rel="shortcut icon" href="image/sap_logo.png"/>
<%@ include file="header.jsp"%>
<!-- google font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<style>
.bd-sidebar {
  position: sticky;
  top: 4rem;
  z-index: 1000;
  height: calc(100vh - 4rem);
  background: #eee;
  border-right: 1px solid rgba(0,0,0,.1);
  overflow-y: auto;
  min-width: 160px;
  max-width: 400px;
}
.bd-sidebar .nav {
  display: block;

  
}
.bd-sidebar .nav>li>a {
  font-family: 'Noto Sans KR', sans-serif;
  display: block;
  padding: .25rem 1.5rem;
  font-size: 90%;
  
 }
 
 main {
  font-family: 'Noto Sans KR', sans-serif; color: #ffffff;
 }

</style>

</head>

<div class="container-fluid">
  <div class="row flex-nowrap">
    <div class="col-3 bd-sidebar">
      <div class="nav">
       <img class ="card-img-top" src = "image/sap_airpurifier.png" alt="Card image" style="width:100%">
       <div class = "card-body" style = "text-align: center">	
        <h5 class = "card-title">사용자님, 안녕하세요:) </h5>
        <p class ="card-text">7월 경고횟수: N회 </p>
        <a href ="#" class="btn btn-light">회원 정보 수정</a>
       </div>
      </div>
      <br>
    </div>

   
    <main class="col-9 py-md-3 pl-md-5 bd-content" role="main">
     <div style = "padding:10px;"></div>
     <table style ="margin-left: auto; margin-right: auto;">
      <tbody>
      <!-- row 1 -->
       <tr>
        <td>
        <!-- column 1 -->
         <a href="#" class="list-group-item list-group-item-action text-left">
          <table>
          <tbody>
           <tr>
            <td rowspan="2" align = "left" height = "200"><img src="image/sap_logo.png" width = "100" alt = ""></td>
            <td><h5>[SAP 소개]</h5></td>
           </tr>
          </tbody>
          </table>
         </a>
        </td>
        <!-- column 2 -->
        <td>
		 <a href="./current.jsp" class="list-group-item list-group-item-action text-left">
		  <table>
		   <tbody>
		    <tr>
			 <td rowspan="2" align = "left"  height = "200"><img src="image/map_b.png" width = "100" alt = "" ></td>
			 <td><h5>[현재 미세먼지 수치]</h5></td>
		    </tr>
		   </tbody>
		  </table>
		 </a>
		</td>
       </tr>
       
       <!-- row 2 -->
       <!-- column 1 -->
       <tr>
	    <div style = "padding:30px;"></div>
		 <td>
		  <a href="./by_date.jsp" class="list-group-item list-group-item-action text-left">
		  <table>
		   <tbody>
			<tr>
			 <td rowspan="2" align = "left" height = "200"><img src="image/calendar_b.png" width = "100" alt = ""></td>
			 <td><h5>[날짜별 미세먼지 통계]</h5></td>
			</tr>
		   </tbody>
	      </table>
		 </a>
		</td>
		
		<!-- column 2 -->
        <td>
         <a href="./highest_area.jsp" class="list-group-item list-group-item-action text-left">
		 <table>
		  <tbody>
		   <tr>
		    <td rowspan="2" align = "left" height = "200"><img src="image/graph_b.png" width = "100"alt = ""></td>
			<td><h5>[최고 미세먼지 구역]</h5></td>
		   </tr>
		  </tbody>
		 </table>
		</a>
	   </td>
	  </tr> 
     </tbody>
    </table>
   </main>
     
      
 </div>    
</div>
</html>
