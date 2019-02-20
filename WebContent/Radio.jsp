<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page errorPage="making.html" %>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	MusicDatabase md = new MusicDatabase();
	NationDatabase nd = new NationDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	ArtistDatabase atd = new ArtistDatabase();

	ArrayList<HashMap<String, Object>> musicList = md.getMusicList("", "");
	
	String nickname = (String) session.getAttribute("nickname");
	String main_page = request.getParameter("main_page");
	String mainPageName = "MainContent.jsp";
	
	if( main_page != null )
	{
		if( main_page.equals("1") )
			mainPageName = "Chart.jsp";
		else if( main_page.equals("2") )
			mainPageName = "making.htm";		// lately
		else if( main_page.equals("3") )
			mainPageName = "DJ.jsp";
		else if( main_page.equals("4") )
			mainPageName = "Radio.jsp";
		else if( main_page.equals("5") )
			mainPageName = "making.htm";		// mypage
	}
	
	if(session.getAttribute("nickname")==null) nickname="";
	
	if(!nickname.equals("")) {
		
	}
		
	for( int i = 0; i < musicList.size(); i++ )
	{
		HashMap<String, Object> tempMap = musicList.get(i);
		
		musicList.get(i).put("nation_name", nd.getName((String) tempMap.get("nation_no")));
		musicList.get(i).put("album_name", ad.getName((String) tempMap.get("album_no")));
		
		/***********************************가수************************************/
		String artists = (String) tempMap.get("artist_no");
		String artist_name = "";
		
		if( artists.contains(",") )
		{
			
			for( int j = 0; j < artists.split(",").length; j++ )
				artist_name += atd.getName(artists.split(",")[j]) + ",";
			artist_name = artist_name.substring(0, artist_name.length() - 1);
		}
		else
			artist_name = atd.getName(artists);
		
		musicList.get(i).put("artist_name", artist_name);
		/***********************************작곡가************************************/
		String swriters = (String) tempMap.get("song_writer");
		String song_writer_name = "";
		
		if( swriters.contains(",") )
		{
			for( int j = 0; j < swriters.split(",").length; j++ )
				song_writer_name += atd.getName(swriters.split(",")[j]) + ",";
			song_writer_name = song_writer_name.substring(0, song_writer_name.length() - 1);
		}
		else
			song_writer_name = atd.getName(swriters);
		
		musicList.get(i).put("song_writer_name", song_writer_name);
		
		/***********************************작사가************************************/
		String lwriters = (String) tempMap.get("lyric_writer");
		String lyric_writer_name = "";
		
		if( lwriters.contains(",") )
		{
			for( int j = 0; j < lwriters.split(",").length; j++ )
				lyric_writer_name += atd.getName(lwriters.split(",")[j]) + ",";
			lyric_writer_name = lyric_writer_name.substring(0, lyric_writer_name.length() - 1);
		}
		else
			lyric_writer_name = atd.getName(lwriters);
		
		musicList.get(i).put("lyric_writer_name", lyric_writer_name);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<link href="css/Radio.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/jquery.roundslider/1.3/roundslider.min.css" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/jquery.roundslider/1.3/roundslider.min.js"></script>

    <script src="js/jquery.js"></script>
    <script src="js/Radio.js"></script>
</head>
<body>
    <div id="left">
        <img id='left_img' src="" />
		<div id="appearance7"></div>
        <div id="current_info"></div>
        <div id="button_box">
            <div id="img_position">
                <img id='play_btn' src="image/play_icon.png" />
                <img id='next_btn' src="image/next_icon.png" />
				<div id='empty'>
					<span id="song_current_time"></span> / 
					<span id="song_total_time"></span>
				</div>
                <img id='volume_btn' src="image/volume_icon.png" />
                <input id="volume_progress_bar" type="range">
            </div>
        </div>
    </div>
    <div id="right">
		<div id="genre_btn">
			<button class="genre">발라드</button>
			<button class="genre">트로트</button>
			<button class="genre">POP</button>
			<button class="genre">ROCK</button>
		</div>
        <span id="right_name">플레이리스트</span>
        <div class='playlist' id="playlist">
			<div class="list_block"><span>이전 곡을 선택 할 수 없습니다.</span></div>
		</div>
		<div class='playlist' id="playlist_trot">
			<div class="list_block"><span>이전 곡을 선택 할 수 없습니다.</span></div>
		</div>
		<div class='playlist' id="playlist_pop">
			<div class="list_block"><span>이전 곡을 선택 할 수 없습니다.</span></div>
		</div>
		<div class='playlist' id="playlist_rock">
			<div class="list_block"><span>이전 곡을 선택 할 수 없습니다.</span></div>
		</div>
    </div>

    <audio>
        <source id="audio_radio">
    </audio>
</body>
<script>
	var music_no = new Array();
	var nation_no = new Array();
	var name2 = new Array();
	var artist_no = new Array();
	var song_writer = new Array();
	var lyric_writer = new Array();
	var album_no = new Array();
	var albumart = new Array();
	var lyrics = new Array();
	var genre = new Array();
	var release_date = new Array();
	var track = new Array();
	var tag = new Array();
	var time = new Array();
	var isTitle = new Array();
	var isAdult = new Array();
	var nation_name = new Array();
	var album_name = new Array();
	var artist_name = new Array();
	var song_writer_name = new Array();
	var lyric_writer_name = new Array();

    var logstate = '<%= nickname %>';

	<%
	for( int i = 0; i < musicList.size(); i++ )
	{
	%>
		music_no[<%=i%>] = '<%=musicList.get(i).get("music_no")%>';
		nation_no[<%=i%>] = '<%=musicList.get(i).get("nation_no")%>';
		name2[<%=i%>] = "<%=musicList.get(i).get("name")%>";
		artist_no[<%=i%>] = '<%=musicList.get(i).get("artist_no")%>';
		song_writer[<%=i%>] = '<%=musicList.get(i).get("song_writer")%>';
		lyric_writer[<%=i%>] = '<%=musicList.get(i).get("lyric_writer")%>';
		album_no[<%=i%>] = '<%=musicList.get(i).get("album_no")%>';
		albumart[<%=i%>] = '<%=musicList.get(i).get("albumart")%>';
		lyrics[<%=i%>] = '<%=(((String) (musicList.get(i).get("lyrics"))).replaceAll("\n", "<br>")).replaceAll("'", "\"")%>';
		genre[<%=i%>] = '<%=musicList.get(i).get("genre")%>';
		release_date[<%=i%>] = '<%=musicList.get(i).get("release_date")%>';
		track[<%=i%>] = '<%=musicList.get(i).get("track")%>';
		tag[<%=i%>] = '<%=musicList.get(i).get("tag")%>';
		time[<%=i%>] = '<%=musicList.get(i).get("time")%>';
		isTitle[<%=i%>] = '<%=musicList.get(i).get("isTitle")%>';
		isAdult[<%=i%>] = '<%=musicList.get(i).get("isAdult")%>';
		nation_name[<%=i%>] = '<%=musicList.get(i).get("nation_name")%>';
		album_name[<%=i%>] = "<%=musicList.get(i).get("album_name")%>";
		artist_name[<%=i%>] = '<%=musicList.get(i).get("artist_name")%>';
		song_writer_name[<%=i%>] = '<%=musicList.get(i).get("song_writer_name")%>';
		lyric_writer_name[<%=i%>] = '<%=musicList.get(i).get("lyric_writer_name")%>';
	<%
	}
	%>

	init();
</script>
</html>