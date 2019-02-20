<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>관리자 페이지</title>
	
	<link href="css/Admin_Main.css" rel="stylesheet">
	
	<script src="js/jquery.js"></script>
	<script src="js/Admin_Main.js"></script>
</head>

<body>
	<header>
		Administrator
	</header>
	
	<nav>
		<div class="menu_title">관리</div>
		<div class="menu">Member
		</div>
		<div class="menu">Music
		</div>
		<div class="menu">Artist
		</div>
		<div class="menu">DJ
		</div>
		<div class="menu">RADIO
		</div>
	</nav>
	
	<article>
		<section>
			<iframe src="Admin_Artist.jsp">
			</iframe>
		</section>
	</article>
</body>
</html>