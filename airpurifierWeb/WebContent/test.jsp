<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>로그인</title>
<%@ include file="header.jsp"%>
<!-- google font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

<style>
container {font-family: 'Noto Sans KR', sans-serif;}
</style>

</head>
<body>
	<main role="main">
		<div class="container">
			<div class="row justify-content-center"align="center">
				<div class="col-lg-4">
					<p></p>
					<h1>LOGIN</h1>
					<img src="image/sap_airpurifier.png" width="240" height="200"/>
					<p></p>
					<p></p>
					<%
						String error = request.getParameter("error");
						if (error != null) {
							out.println("<div class='alert alert-danger'>");
							out.println("아이디와 비밀번호를 확인해 주세요");
							out.println("</div>");
						}
					%>
					<form class="form-signin" action="processLoginUser.jsp" method="post">
						<div class="input-group my-2 mb-1">
							<input type="text" name="user_id" class="form-control"
								placeholder="아이디 입력" aria-label="아이디 입력"
								aria-describedby="basic-addon1" required>
						</div>
					
						<div class="input-group my-2 mb-3">
							<input type="password" name="user_pw" class="form-control"
								placeholder="바말번호 입력" aria-label="비밀번호 입력"
								aria-describedby="basic-addon1" required>
						</div>
						
						<div class = "sign_button" style="text-align: center;">
       					<p><a href="./suc_sign_in.jsp" style="background-color:none">회원가입</a>&nbsp;
       					<a href="./main_page.jsp" style="background-color:none;">뒤로가기</a></p>
      					</div>
					</form>
				</div>	
			</div>
			<hr>
		</div>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>