<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("utf-8");

	String filter = request.getParameter("filter");
	String filter_content = request.getParameter("filter_content");
	
	MusicDatabase md = new MusicDatabase();
	
	if( filter == null ) filter = "";
	if( filter_content == null ) filter_content = "";

	ArrayList<HashMap<String, Object>> musicList = md.getMusicList(filter, filter_content);
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>관리자 페이지</title>
	
	<link rel="stylesheet" href="css/Admin_Music.css" >
	
	<script src="js/jquery.js"></script>
	<script src="js/Admin_Music.js"></script>
</head>

<body style="white-space: nowrap;" ondragstart="return false;">
	<form action="Admin_Music.jsp">
		<select name="filter">
			<option value="all" selected>전체</option>
			<option value="title">제목</option>
			<option value="artist">가수</option>
			<option value="lyrics">가사</option>
		</select>
		<input type="text" name="filter_content" required>
		<input type="submit" value="검색">
		<input type="button" value="추가" onclick="javascript:location.href='Admin_Music_Add.jsp?filter<%=filter%>=&filter_content=<%=filter_content%>;'">
		<input type="button" value="삭제" onclick="deleteMusic">
	</form>
	
	<hr>
	<%=musicList.size()%> 건<br>

	<%
	if( musicList.size() > 0 )
	{
	%>
	<form>
		<table border=3px>
			<tr>
				<td><center><input type="checkbox" value="all" id="check_all"></center></td>
				<td>수정</td>
				<td>삭제</td>
				<td>음악번호</td>
				<td>앨범아트</td>
				<td>제목</td>
				<td>가수</td>
				<td>작곡</td>
				<td>작사</td>
				<td>앨범</td>
				<td>가사유무</td>
				<td>장르</td>
				<td>발매일</td>
				<td>트랙번호</td>
				<td>태그</td>
				<td>재생시간</td>
				<td>타이틀여부</td>
				<td>19금여부</td>
			</tr>
			<%
			for( int i = 0; i < musicList.size(); i++ )
			{
				String imageURL = (String)musicList.get(i).get("albumart");
			%>
				<tr>
					<td><center><input type="checkbox" value="<%=musicList.get(i).get("music_no")%>" class="check_each"></center></td>
					<td><center><input type="button" value="수정"></center></td>
					<td><center><input type="button" value="삭제"></center></td>
					<td><%=musicList.get(i).get("music_no")%></td>
					<td><center><img src="<%=imageURL%>" width="50px" height="50px"></center></td>
					<td><%=musicList.get(i).get("name")%></td>
					<td><%=musicList.get(i).get("artist_no")%></td>
					<td><%=musicList.get(i).get("song_writer")%></td>
					<td><%=musicList.get(i).get("lyric_writer")%></td>
					<td><%=musicList.get(i).get("album_no")%></td>
					<td><center><%=musicList.get(i).get("lyrics")==null?'X':'O'%></center></td>
					<td><%=musicList.get(i).get("genre")%></td>
					<td><%=musicList.get(i).get("release_date")%></td>
					<td><%=musicList.get(i).get("track")%></td>
					<td><%=musicList.get(i).get("tag")%></td>
					<td><%=musicList.get(i).get("time")%></td>
					<td><center><%=((String)musicList.get(i).get("isTitle")).equals("true")?'O':'X'%></center></td>
					<td><center><%=((String)musicList.get(i).get("isAdult")).equals("true")?'O':'X'%></center></td>
				</tr>
			<%
			}
			%>
		</table>
	</form>
	<%
	}
	%>
</body>
</html>