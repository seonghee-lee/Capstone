<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="sap.controller.*, java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.Calendar" %>


<!DOCTYPE HTML>

<html>
	<head>
		<title>I AM PURI</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css?after" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">

		<!-- Sidebar -->
			<section id="sidebar">
				<div class="inner">
					<nav>
						<ul>
							<li><a href="#intro">Who we are:</a></li>
							<li><a href="#one">Recent Data</a></li>
							<li><a href="#two">Total Data</a></li>
							<li><a href="#three">Warning</a></li>
						</ul>
					</nav>
				</div>
			</section>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Intro -->
					<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div class="inner">
							<h1 style= "color: #000000">I Am PURI</h1>
							<p>보이지 않는 것을 보는 법</p><br>
							<ul class="actions">
								<li><a href="#one" class="button scrolly">시작하기</a></li>
							</ul>
						</div>
					</section>

				<!-- One: recent data -->
					<section id="one" class="wrapper style2 spotlights">
					
					<div class="inner">
					<h2 style= "color: #000000">Recent Data</h2>
					<p style= "color: #7F7F7F">아이엠퓨리가 가장 최근에 수집한 공간별 미세먼지 수치입니다.<br>
					공간 전체 그리고 각 공간의 미세먼지 수치를 확인해보세요.</p>
					<%@ include file="current.jsp" %>
					</div>
					</section>

				<!-- Two -->
					<section id="two" class="wrapper style2 fade-up">
						<div class="inner">
							<h2 style= "color: #000000">Total Data</h2>
							<p style= "color: #7F7F7F">모든 공기의 흐름은 이곳에 있습니다.<br>
							한 주의 아이엠퓨리가 수집한 미세먼지 수치를 확인해보세요.
							</p>
							<jsp:include page = "realdate_chart.jsp"/>
							<!-- <ul class="actions">
								<li><a href="generic.html" class="button">Learn more</a></li>
							</ul> -->
						</div>
					</section>

				<!-- Three -->
					<section id="three" class="wrapper style2 fade-up">
						<div class="inner">
							<h2 style= "color: #000000">Warning</h2>
							<p style= "color: #7F7F7F">어느 곳의 공기가 가장 안 좋을까요?<br>
							아이엠퓨리가 미세먼지 ‘나쁨’ 공간을 기록합니다.</p>
							
							<jsp:include page="warning_cnt.jsp" />
							</div>
								</section>
							
							
						</div>
				

			

		<!-- Footer -->
	
			<footer id="footer" class="wrapper style2-alt">
				<div class="inner">
					<ul class="menu">
						<li>&copy;2021 All Rights Reserved, KPU Computer Engineering Department SSAP®
						</li><li> <a href="https://github.com/seonghee-lee/Capstone">Git Hub</a></li>
					</ul>
				</div>
			</footer>


		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>