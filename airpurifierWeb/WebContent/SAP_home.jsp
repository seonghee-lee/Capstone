<!-- main_page.jsp -->
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>    
    <!-- Site Meta -->
    <title>SAP web</title>
    
	
    <!-- Site Icons -->
	<link rel="shortcut icon" href="image/icon/favicon.ico"/>

	<!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="css/content.css">
    
    <style>
    
	</style>

</head>
<body>
 <jsp:include page = "header.jsp" flush="false"></jsp:include>
 <div class ="column">
 
 <!-- side -->
  <div class ="side">
   <div class="card" style ="width:400px; height: 800px; border:none;">
   <p></p><p></p><p></p><p></p>
    <img class ="card-img-top" src = "image/sap_airpurifier.png" alt="Card image" style="width:100%">
    <div class = "card-body" style = "text-align: center">
    <h4 class = "card-title"> user name </h4>
     <p class ="card-text"> air purifier: ddd </p>
     <a href ="#" class="btn btn-light">회원 정보 수정</a>
    </div>
   </div>
  </div>
  
  <!---middle---->
  <div class = "middle">
  </div>
 </div>
 
 
</body>
</html>