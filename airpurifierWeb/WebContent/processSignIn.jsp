<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
%>

<sql:setDataSource var="dataSource"
	url= "jdbc:mysql://ip/dbname? suseUnicode=true&characterEncoding=UTF-8" 
	driver= "com.mysql.jdbc.Driver" user="username" password="password" />

<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM user WHERE user_id=? and user_pw=?  
   <sql:param value="<%=user_id%>" />
	<sql:param value="<%=user_pw%>" />
</sql:query>

<c:forEach var="row" items="${resultSet.rows}">
	<%
		session.setAttribute("sessionId", user_id);
	%>
	<c:redirect url="resultSignIn.jsp?msg=2" />
</c:forEach>

<c:redirect url="sign_in.jsp?error=1" />
