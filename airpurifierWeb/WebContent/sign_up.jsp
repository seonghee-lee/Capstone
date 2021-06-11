<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<script type="text/javascript">
	function checkSignUp() {
		var id = document.userInfo.user_id.value
		if (!document.userInfo.user_id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		
		if (!document.userInfo.user_pw.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
			
	    // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
        if(document.userInfo.user_pw.value != document.userInfo.pwcheck.value ){
            alert("비밀번호를 동일하게 입력하세요.");
            return false;
            }
	}
	
	
</script>
<title>Sign Up</title>
<!-- google font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<!-- Site Icons -->
<link rel="shortcut icon" href="image/icon/favicon.ico"/>


 <style>
		html,body,div, video {margin:0;padding:0;}
		body {padding:0px, 0px, 0px, 0px; margin:0px, 0px, 0px, 0px; overflow:hidden; background-color:#000;}
		.container {}
		video{opacity: 0.5}
		.text {position: absolute; width: 100%; top: 50%; left: 50%; transform: translate(-50%,-50%); background-color:rgba(255, 255, 255, 0.6);;}
		.text p{font-family: 'Noto Sans KR', sans-serif; text-align: center; font-size: 48px; color: #ffffff;}
		.input_signup {font-family: 'Noto Sans KR', sans-serif; color: #ffffff;}
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
    <div class="text" style ="text-align: center;">
    	<br>
	    <p style="line-height: 1;">SIGN UP </p>
	     <form class="signup_form" action = "processSignUp.jsp" name ="userInfo" method = "post" onsubmit="return checkSignUp()">
	     	<div class = "input_signup" align="center">
			 <table>
	                <tr>
	                    <td id="title" style="text-align:center;">아이디</td>
	                    <td>
	                        <input type="text" name="user_id" maxlength="50" size = "14">
	                        <input type="button" value="중복확인" style = "color:#C0C0C0; width:87px; vertical-align:top;">    
	                    </td>
	                </tr>
	                        
	                <tr>
	                    <td id="title" style="text-align:center;">비밀번호</td>
	                    <td>
	                        <input type="password" name="user_pw" maxlength="50">
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td id="title" style="text-align:center;">비밀번호 확인</td>
	                    <td>
	                        <input type="password" name="pwcheck" maxlength="50">
	                    </td>
	                </tr>
	                    
	                <tr>
	                    <td id="title" style="text-align:center;">이름</td>
	                    <td>
	                        <input type="text" name="user_name" maxlength="50">
	                    </td>
	                </tr>
	                    
	                <tr>
	                    <td id="title" style="text-align:center;">성별</td>
	                    <td align=center>
	                        <input type="radio" name="gender" value="남자" checked>남자                   
	                        <input type="radio" name="gender" value="여자" checked>여자
	                    </td>
	                </tr>
	                    
	                <tr>
	                    <td id="title" style="text-align:center;">생년월일</td>
	                    <td>
	                        <input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="4" >
	                     	<input type="text" name="birthmm" maxlength="2" placeholder="월" size="4" >
	                        <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" >
	                    </td>
	                </tr>
	                    
	                <tr>
	                    <td id="title" style="text-align:center;">이메일</td>
	                    <td>
	                        <input type="text" name="mail1" maxlength="50" size = "8"> @
	                        <select name="mail2" style="width:155px;font-size:22px; vertical-align:top;">
	                            <option>naver.com</option>
	                            <option>daum.net</option>
	                            <option>gmail.com</option>
	                            <option>nate.com</option>                        
	                        </select>
	                    </td>
	                </tr>
	                    
	                <tr>
	                    <td id="title" style="text-align:center;">휴대전화</td>
	                    <td>
	              
	                        <select name="pn_1" style="width:98px;font-size:22px; vertical-align:top;">
	                            <option>010</option>
	                            <option>011</option>
	                            <option>017</option>
	                        </select> -
	                        <input type="text" name="pn_2" maxlength="4" size="4" > -
	                        <input type="text" name="pn_3" maxlength="4" size="4" >
	                    </td>
	                </tr>
	               
	            </table>	
	        </div>
	       
	        <div class = "sign_button" style="text-align: center">
		    <p><a href="main_page.jsp" style="background-color:#4CAF50;" class = "home_btn">HOME</a>
		    <button class = "sign_up_btn" >Sign_Up</button></p> 
		    </div>
		    
	     </form>
	 </div>
    </div>
       
</body>
</html>