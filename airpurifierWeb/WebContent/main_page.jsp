<!-- main_page.jsp -->
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>

    <!-- Basic -->
    <meta charset="utf-8">
    
    <!-- Site Meta -->
    <title>SAP web</title>
    
	
    <!-- Site Icons -->
	<link rel="shortcut icon" href="image/icon/favicon.ico"/>

	<!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
    
    <style>
		html,body,div, video {margin:0;padding:0;}
		body {padding:0px, 0px, 0px, 0px; margin:0px, 0px, 0px, 0px; overflow:hidden; background-color:#000;} .container {}
		video{opacity: 0.5}
		.text {position: absolute;width: 100%;top: 50%; left: 50%; transform: translate(-50%,-50%);}
		.text p{font-family: 'Noto Sans KR', sans-serif; text-align: center; font-size: 48px; color: #ffffff;}
		.text .sign_button{}
		.sign_button a{font-family: 'Noto Sans KR', sans-serif; text-decoration:none; font-size: 22px; color: #ffffff; display: inline-block; width: 110px; line-height: 60px; }
	
	
	</style>

</head> 

<body>
   <!-- The video -->
   <video width = "100%" height = auto autoplay muted loop id="Video">
   <source src="video/homevideo.mp4" type="video/mp4">
   </video>
   <div class = 'container'>
    <div class="text">
     <p style="line-height: 0.4;">SMART </p>
     <p style="line-height: 0.4;">Autonomous</p>
     <p style="line-height: 0.4;"> Moving</p>
     <p style="line-height: 0.4;">Air purifier</p>
      <div class = "sign_button" style="text-align: center;">
       <p><a href="sign_in.jsp" style="background-color:#4CAF50" class = "sign_in_btn">Sign In</a>
       <a href="sign_up.jsp" style="background-color:#C0C0C0;" class = "sign_up_btn">Sign Up</a></p>
      </div>
    </div>
 
   </div>
</body>
</html>