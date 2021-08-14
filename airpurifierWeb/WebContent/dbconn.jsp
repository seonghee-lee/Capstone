<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
</head>
<body>
<%
  Connection conn=null;

	 String dbUrl = "jdbc:mysql://localhost:3306/test";
     String dbId = "dbID";
     String dbPass = "dbPassword";
	
	 Class.forName("com.mysql.jdbc.Driver");
	 conn = DriverManager.getConnection(dbUrl,dbId ,dbPass );

  
%>
</body>
</html>
