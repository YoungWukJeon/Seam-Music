<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("utf-8");

	String filter = request.getParameter("filter");
	String filter_content = request.getParameter("filter_content");
	
	ArtistDatabase md = new ArtistDatabase();
	
	if( filter == null ) filter = "";
	if( filter_content == null ) filter_content = "";

	ArrayList<HashMap<String, Object>> ArtistList = md.getArtistList(filter, filter_content);
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>관리자 페이지</title>
	
	<link rel="stylesheet" href="css/Admin_Artist.css" >
	
	<script src="js/jquery.js"></script>
	<script src="js/Admin_Artist.js"></script>
</head>

<body style="white-space: nowrap;" ondragstart="return false;">
	<form action="Admin_Artist.jsp">
		<select name="filter">
			<option value="all" selected>전체</option>
			<option value="name">이름</option>
			<option value="nation">국가</option>
		</select>
		<input type="text" name="filter_content" required>
		<input type="submit" value="검색">
		<input type="button" value="추가" onclick="javascript:location.href='Admin_Artist_Add.jsp?filter<%=filter%>=&filter_content=<%=filter_content%>;'">
		<input type="button" value="삭제" onclick="deleteArtist">
	</form>
	
	<hr>
	<%=ArtistList.size()%> 건<br>

	<%
	if( ArtistList.size() > 0 )
	{
	%>
	<form>
	<table border=3px>
		<tr>
			<td><center><input type="checkbox" value="all" id="check_all"></center></td>
			<td>수정</td>
			<td>삭제</td>
			<td>아티스트번호</td>
			<td>프로필사진</td>
			<td>이름</td>
			<td>그룹명</td>
			<td>역할</td>
			<td>데뷔년도</td>
			<td>직업</td>
			<td>성별</td>
			<td>소속사</td>
		</tr>
		<%
		for( int i = 0; i < ArtistList.size(); i++ )
		{
			String imageURL = (String)ArtistList.get(i).get("profile_image");
		%>
			<tr>
				<td><center><input type="checkbox" value="<%=ArtistList.get(i).get("Artist_no")%>" class="check_each"></center></td>
				<td><center><input type="button" value="수정"></center></td>
				<td><center><input type="button" value="삭제"></center></td>
				<td><%=ArtistList.get(i).get("artist_no")%></td>
				<td><center><img src="<%=imageURL%>" width="50px" height="50px"></center></td>
				<td><%=ArtistList.get(i).get("name")%></td>
				<td><%=ArtistList.get(i).get("group_name")%></td>
				<td><%=ArtistList.get(i).get("position")%></td>
				<td><%=ArtistList.get(i).get("debut_date")%></td>
				<td><%=ArtistList.get(i).get("job")%></td>
				<td><%=ArtistList.get(i).get("gender")%></td>
				<td><%=ArtistList.get(i).get("agency")%></td>
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