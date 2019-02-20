<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("utf-8");

	String filter = request.getParameter("filter");
	String filter_content = request.getParameter("filter_content");
	
	if( filter == null ) filter = "";
	if( filter_content == null ) filter_content = "";
	
	/* ServletContext context = getServletContext();
	String realFolder = context.getRealPath("image/albumart"); */
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>관리자 페이지</title>
	
	<link rel="stylesheet" href="css/Admin_Music.css" >
	
	<script src="js/jquery.js"></script>
	<script src="js/Admin_Album_Add.js"></script>
</head>

<body style="white-space: nowrap;" ondragstart="return false;">
	<div id="left_side"><center>
		<form method=post action="Admin_Album_AddProc.jsp?filter=<%=filter%>&filter_content=<%=filter_content%>" encType="multipart/form-data">
			<table border="1px">
				<tr>
					<td>칼럼</td>
					<td>내용</td>
				</tr>
				<tr>	
					<td>국가</td>
					<td>
						<select name="nation">
							<option value="대한민국" selected>대한민국</option>
							<option value="미국">미국</option>
							<option value="영국">영국</option>
							<option value="일본">일본</option>
							<option value="중국">중국</option>
						</select>
					</td>
				</tr>
				<tr>	
					<td>제목</td>
					<td><input type="text" id="name" name="name"></td>
				</tr>
				<tr>	
					<td>가수</td>
					<td><input type="text" id="name" name="artist_no"></td>
				</tr>
				<tr>	
					<td>발매일</td>
					<td><input type="text" id="name" name="release_date"></td>
				</tr>
				<tr>	
					<td>발매사</td>
					<td><input type="text" id="name" name="release_com"></td>
				</tr>
				<tr>	
					<td>기획사</td>
					<td><input type="text" id="name" name="agency"></td>
				</tr>
				<tr>	
					<td>앨범아트</td>
					<td>
						<center><img src="#" width="100px" height="100px" id="albumart"></center>
						<input type="file" accept="image/jpeg, image/png, image/gif" name="albumart" onchange="loadFile(this);">
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="전송">
						<input type="reset" value="초기화">
					</td>
				</tr>
			</table>
		</form></center>
	</div>
	<div id="right_side">
		<iframe src="Admin_Album.jsp"></iframe>
	</div>
</body>

<style>
	#left_side {
		display: inline-block;
		width: 30%;
		height: 500px;
	}
	#right_side {
		display: inline-block;
		float: right;
		width: 60%;
		height: 700px;
	}
	#right_side iframe{
		border: none;
		width: 100%;
		height: 100%;
	}
</style>

</html>