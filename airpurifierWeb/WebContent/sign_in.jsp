<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<script type="text/javascript">
	function checkSignIn() {
		var id = document.userInfo.user_id.value
		if (!document.userInfo.user_id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		
		if (!document.userInfo.user_pw.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
	}
	
	
</script>
<title>Sign In</title>
<!-- google font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<!-- Site Icons -->
<link rel="shortcut icon" href="image/icon/favicon.ico"/>


 <style>
		html,body,div, video {margin:0;padding:0;}
		body {padding:0px, 0px, 0px, 0px; margin:0px, 0px, 0px, 0px; overflow:hidden; background-color:#000;} .container {}
		video{opacity: 0.5}
		.text {position: absolute; width: 100%; top: 50%; left: 50%; transform: translate(-50%,-50%); background-color:rgba(255, 255, 255, 0.6);;}
		.text p{font-family: 'Noto Sans KR', sans-serif; text-align: center; font-size: 48px; color: #ffffff;}
		.input_signin p{font-family: 'Noto Sans KR', sans-serif;}
		.sign_button a{font-family: 'Noto Sans KR', sans-serif; text-decoration:none; font-size: 22px; color: #ffffff; display: inline-block; width: 110px; line-height: 60px; }
		.sign_button button{font-family: 'Noto Sans KR', sans-serif; text-decoration:none; font-size: 22px; color: #ffffff; display: inline-block; width: 110px; line-height: 60px; background-color:#C0C0C0; border: none; }
	
</style>

</head>
<body>
	<!-- The video -->
	<video width = "100%" height = auto autoplay muted loop id="Video">
    <source src="video/homevideo.mp4" type="video/mp4">
    </video>
   <div class = 'container'>
    <%
    	String error = request.getParameter("error");
		if (error != null) {
			out.println("<div class='alert alert-danger'>");
			out.println("아이디와 비밀번호를 확인해 주세요");
			out.println("</div>");
		}
	%>
    <div class="text" style ="text-align: center;">
     <form class="signin_form" action = "processSignIn.jsp" name ="userInfo" method = "post" onsubmit="return checkSignIn()">
     <br>
     <p style="line-height: 1;">SIGN IN </p>
		<div class="input_signin">
			<p style="font-size:30px;"> &nbsp;&nbsp;&nbsp;ID&nbsp;
			<input type="text" name="user_id" placeholder="아이디 입력" style="height: 45px;width: 200px; font-size: 15px;">
			<br/>
			PW
			<input type="password" name="user_pw" placeholder="비밀번호 입력" style="height: 45px;width: 200px; font-size: 15px;">
			</p>
		</div>
		
     	<div class = "sign_button" style="text-align: center">
      	<p><a href="main_page.jsp" style="background-color:#4CAF50;" class = "home_btn">HOME</a>
		<button class = "sign_up_btn">Sign_In</button></p>
     	</div>
     	
     </form>
    </div>
   </div>
   
</body>
</html>