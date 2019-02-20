<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String music_no = request.getParameter("music_no");

	NationDatabase nd = new NationDatabase();
	MusicDatabase md = new MusicDatabase();
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	
	HashMap<String, Object> map = md.getMusicInfo(music_no);
	

	map.put("nation_name", nd.getName((String) map.get("nation_no")));
	map.put("album_name", ad.getName((String) map.get("album_no")));
	
	/***********************************가수************************************/
	String artists = (String) map.get("artist_no");
	String artist_name = "";
	
	if( artists.contains(",") )
	{
		for( int j = 0; j < artists.split(",").length; j++ )
			artist_name += atd.getName(artists.split(",")[j]) + ",";
		artist_name = artist_name.substring(0, artist_name.length() - 1);
	}
	else
		artist_name = atd.getName(artists);
	
	map.put("artist_name", artist_name);
	/***********************************작곡가************************************/
	String swriters = (String) map.get("song_writer");
	String song_writer_name = "";
	
	if( swriters.contains(",") )
	{
		for( int j = 0; j < swriters.split(",").length; j++ )
			song_writer_name += atd.getName(swriters.split(",")[j]) + ",";
		song_writer_name = song_writer_name.substring(0, song_writer_name.length() - 1);
	}
	else
		song_writer_name = atd.getName(swriters);
	
	map.put("song_writer_name", song_writer_name);
	
	/***********************************작사가************************************/
	String lwriters = (String) map.get("lyric_writer");
	String lyric_writer_name = "";
	
	if( lwriters.contains(",") )
	{
		for( int j = 0; j < lwriters.split(",").length; j++ )
			lyric_writer_name += atd.getName(lwriters.split(",")[j]) + ",";
		lyric_writer_name = lyric_writer_name.substring(0, lyric_writer_name.length() - 1);
	}
	else
		lyric_writer_name = atd.getName(lwriters);
	
	map.put("lyric_writer_name", lyric_writer_name);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<style>
		::-webkit-scrollbar {
    		width: 0px;  /* remove scrollbar space */
    		background: transparent;  /* optional: just make scrollbar invisible */
		}
		
		#music_info {
			width: 100%;
			height: 100px;
			background-color: rgb(222, 224, 234);
		}
		
		#album_art {
			display: inline-block;
			position: absolute;
			width: 90px;
			height: 90px;
			left: 12px;
			top: 12px;
		}
		
		#album_art img {
			width: 100%;
			height: 100%;
		}
		
		#music_content {
			display: inline-block;
			position: absolute;
			width: calc(100% - 90px);
			height: 80px;
			left: 110px;
			top: 10px;
		}
		
		#music_title {
			width: 90%;
			height: 30px;
			font-size: 20px;
			font-weight: bold;
			text-overflow: ellipsis;
			overflow: hidden;
			white-space:nowrap;
		}
		
		#music_main_content {
			width: 88%;
			height: 25px;
			margin-left: 2%;
			font-size: 15px;
			text-overflow: ellipsis;
			overflow: hidden;
			white-space:nowrap;
		}
		
		#music_sub_content {
			width: 88%;
			height: 25px;
			margin-left: 2%;
			font-size: 12px;
		}
	
		
		ul {
			/* width: 100%;
			height: auto;
			border: solid 2px rgb(251, 59, 64); */
			padding: 0 0 0 10px;
		} 
		
		li {
			width: 100%;
			height: 20px;
			list-style: none;
		}
	</style>

    <script src="js/jquery.js"></script>

</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	
	<div id="music_info">
		<div id="album_art">
			<img src="<%=map.get("albumart")%>">
		</div>
		
		<div id="music_content">
			<div id="music_title"><%=map.get("name")%></div>
			
			<div id="music_main_content">
				<%=map.get("artist_name")%>&nbsp;<b style="color: rgb(180, 180, 180);">|</b>&nbsp;<%=map.get("album_name")%>
			</div>
			
			<div id="music_sub_content">
				<div id="lyric_writer">작사 : <%=map.get("lyric_writer_name")%></div>
				<div id="song_writer">작곡 : <%=map.get("song_writer_name")%></div>
			</div>
		</div>
	</div>

	<%-- <ul>
		<%
			if( !map.get("lyrics").equals("") )
				out.println(map.get("lyrics"));
			else
				out.println("<li>가사 없음</li>");
		%>
	</ul> --%>
	
	<%
			if( !map.get("lyrics").equals("") )
			{
				String lyricsLine[] = ((String) (map.get("lyrics"))).split("\n");
				
				for( int i = 0; i < lyricsLine.length; i++ )
					out.println("<li>" + lyricsLine[i] + "</li>");
				
				out.flush();
			}
			else
				out.println("<li>가사 없음</li>");
		%>
</body>

<script>

	
</script>

</html>