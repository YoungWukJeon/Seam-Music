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
	<script src="js/dist/id3-minimized.js"></script>
	<script src="js/Admin_Music_Add.js"></script>
</head>

<body style="white-space: nowrap;" ondragstart="return false;">

	<form id="content_form" method=post action="Admin_Music_AddProc.jsp?filter=<%=filter%>&filter_content=<%=filter_content%>" encType="multipart/form-data">
	</form>
	
	<div id="left_side">
		<center>
			<table border="1px">
				<tr>
					<td>칼럼</td>
					<td>내용</td>
				</tr>
				
				<tr>
					<td>음악파일</td>
					<td>
						<iframe name="music_file_upload" id="music_file_upload" src="test.jsp" style="height:50px;"></iframe>
					</td>
				</tr>
				
				<tr>
					<td>국가</td>
					<td>
						<select name="nation" form="content_form">
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
					<td><input type="text" id="title" name="name" form="content_form"></td>
				</tr>
				<tr>
					<td>가수</td>
					<td><input type="text" id="artist" name="artist_no" form="content_form"></td>
				</tr>
				<tr>
					<td>작곡가</td>
					<td><input type="text" id="composer" name="song_writer" form="content_form"></td>
				</tr>
				<tr>
					<td>작사가</td>
					<td><input type="text" id="lyricist" name="lyric_writer" form="content_form"></td>
				</tr>
				<tr>
					<td>앨범</td>
					<td><input type="text" id="album" name="album_no" form="content_form"></td>
				</tr>
				<tr>
					<td>앨범아트</td>
					<td>
						<center><img src="#" width="100px" height="100px" id="album_art"></center>
						<input type="file" id="albumart" name="albumart" accept="image/jpeg, image/png, image/gif" onchange="loadFile2(this)" form="content_form">
					</td>
				</tr>
				<tr>
					<td>가사</td>
					<td><textarea id="lyrics" name="lyrics" rows="10" cols="30" form="content_form"></textarea></td>
				</tr>
				
				<tr>
					<td>장르</td>
					<td><input type="text" id="genre" name="genre" form="content_form"></td>
				</tr>
				
				<tr>
					<td>발매일</td>
					<td><input type="text" id="release_date" name="release_date" form="content_form"></td>
				</tr>
				
				<tr>
					<td>트랙</td>
					<td><input type="text" id="track" name="track" form="content_form"></td>
				</tr>
				
				<tr>
					<td>태그</td>
					<td><input type="text" id="tag" name="tag" form="content_form"></td>
				</tr>
				
				<tr>
					<td>재생시간</td>
					<td><input type="text" id="time" name="time" form="content_form"></td>
				</tr>
				
				<tr>
					<td>타이틀여부</td>
					<td><input type="text" id="isTitle" name="isTitle" form="content_form"></td>
				</tr>
				
				<tr>
					<td>19금여부</td>
					<td><input type="text" id="isAdult" name="isAdult" form="content_form"></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="button" value="전송" form="content_form">
						<input type="reset" value="초기화" form="content_form">
					</td>
				</tr>
			</table>
		</center>
		
	</div>
	
	<div id="right_side">
		<iframe src="Admin_Music.jsp"></iframe>
	</div>
	
	<audio></audio>
	
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
	iframe{
		border: none;
		width: 100%;
		height: 100%;
	}
</style>

</html>