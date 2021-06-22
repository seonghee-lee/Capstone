<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String pwcheck = request.getParameter("pwcheck");

	String user_name = request.getParameter("user_name");
	
	String gender = request.getParameter("gender");
	
	String birthyy = request.getParameter("birthyy");
	String birthmm = request.getParameter("birthmm");
	String birthdd = request.getParameter("birthdd");
	String birth = birthyy + "년" + birthmm + "월" + birthdd + "일";
	
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameter("mail2");
	String mail = mail1 +"@" +mail2;
	
	String pn_1 = request.getParameter("pn_1");
	String pn_2 = request.getParameter("pn_2");
	String pn_3 = request.getParameter("pn_3");
	String pn = pn_1 + "-" + pn_2 + "-" + pn_3;
	
%>

<sql:setDataSource var="dataSource"
	url= "jdbc:mysql://ip/dbname? suseUnicode=true&characterEncoding=UTF-8" 
	driver= "com.mysql.jdbc.Driver" user="username" password="password" />

<sql:update dataSource="${dataSource}" var="resultSet">
   INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)
   <sql:param value="<%=user_id%>" />
	<sql:param value="<%=user_pw%>" />
	<sql:param value="<%=user_name%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=birth%>" />
	<sql:param value="<%=mail%>" />
	<sql:param value="<%=pn%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:redirect url="resultSignUp.jsp?msg=1" />
</c:if>

