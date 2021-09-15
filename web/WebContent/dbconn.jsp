<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
</head>
<body>
<%
  Connection conn=null;

	 String dbUrl = "mysql 주소";
     String dbId = "id";
     String dbPass = "password";
	
	 Class.forName("com.mysql.jdbc.Driver");
	 conn = DriverManager.getConnection(dbUrl,dbId ,dbPass );

  
%>
</body>
</html>
