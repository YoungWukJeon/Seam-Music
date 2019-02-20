<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page errorPage="making.html" %>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	MusicDatabase md = new MusicDatabase();
	MemberDatabase mbd = new MemberDatabase();
	NationDatabase nd = new NationDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	ArtistDatabase atd = new ArtistDatabase();
	PreferenceDatabase pd = new PreferenceDatabase();
	PlayListDatabase pld = new PlayListDatabase();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd");
	Date today = new Date();
	
	ArrayList<HashMap<String, Object>> albumList = ad.getAlbumList("", "", 9);
	ArrayList<HashMap<String, Object>> djList = pld.getPlayList("false", "true", null);
	
	for( int i = 0; i < albumList.size(); i++ )
	{
		HashMap<String, Object> tempMap = albumList.get(i);
		
		// albumList.get(i).put("nation_name", nd.getName((String) tempMap.get("nation_no")));
		
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
		
		albumList.get(i).put("artist_name", artist_name);
	}
	
	for( int i = 0; i < djList.size(); i++ )
	{
		djList.get(i).put("likeCount", pd.getLikeCount("playlist", (String) djList.get(i).get("playlist_no"), null));
		djList.get(i).put("nickname", mbd.getNickname((String) djList.get(i).get("id"), null));
	
		String djRegistDate = sdf.format(djList.get(i).get("date"));
	}
	
	Collections.sort(djList, new MapComparator("likeCount"));
	Collections.reverse(djList);
	
	// ArrayList<HashMap<String, Object>> musicList = md.getMusicList("", "");

	/*
	for( int i = 0; i < musicList.size(); i++ )
	{
		HashMap<String, Object> tempMap = musicList.get(i);
		
		musicList.get(i).put("nation_name", nd.getName((String) tempMap.get("nation_no")));
		musicList.get(i).put("album_name", ad.getName((String) tempMap.get("album_no"))); */
		
		/***********************************가수************************************/
		/*String artists = (String) tempMap.get("artist_no");
		String artist_name = "";
		
		if( artists.contains(",") )
		{
			
			for( int j = 0; j < artists.split(",").length; j++ )
				artist_name += atd.getName(artists.split(",")[j]) + ",";
			artist_name = artist_name.substring(0, artist_name.length() - 1);
		}
		else
			artist_name = atd.getName(artists);
		
		musicList.get(i).put("artist_name", artist_name); */
		/***********************************작곡가************************************/
		/*String swriters = (String) tempMap.get("song_writer");
		String song_writer_name = "";
		
		if( swriters.contains(",") )
		{
			for( int j = 0; j < swriters.split(",").length; j++ )
				song_writer_name += atd.getName(swriters.split(",")[j]) + ",";
			song_writer_name = song_writer_name.substring(0, song_writer_name.length() - 1);
		}
		else
			song_writer_name = atd.getName(swriters);
		
		musicList.get(i).put("song_writer_name", song_writer_name);*/
		
		/***********************************작사가************************************/
		/*String lwriters = (String) tempMap.get("lyric_writer");
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
	}*/
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/rangeSlider.css" rel="stylesheet">
	<link href="css/MainContent.css" rel="stylesheet">
	
	<script src="js/jquery.js"></script>
	<script src="js/rangeSlider.js"></script>
	<script src="js/MainContent.js"></script>
	
	
	<!-- <script src="https://cdn.jsdelivr.net/jquery/1.11.3/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/jquery.roundslider/1.3/roundslider.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/jquery.roundslider/1.3/roundslider.min.js"></script> -->
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false" style="white-space:nowrap;">
	<div id="main_album">
        <div class="content_name" id="album_tag">
            <span><b>NEW MUSIC</b></span>
        </div>
		<div id="album_tag_sub">
			<!-- <span><b>국내</b></span>
			<span id="sub2"><b>해외</b></span> -->
		</div>
        <div class='content_background' id="album_imagebackground">
			<div id="bottom_circle">
				<img src="image/bottom_circle.png">
			</div>
            <div id="album_imagebox">
                <div class="album_image" id="album01">
                    <img src="">
                </div>
                <div class="album_image" id="album02">
                    <img src="">
                </div>
                <div class="album_image" id="album03">
                    <img src="">
                </div>
                <div class="album_image" id="album04">
                    <img src="">
                </div>
                <div class="album_image" id="album05">
                    <img src="">
                </div>
                <div class="album_image" id="album06">
                    <img src="">
                </div>
                <div class="album_image" id="album07">
                    <img src="">
                </div>
                <div class="album_image" id="album08">
                    <img src="">
                </div>
                <div class="album_image" id="album09">
                    <img src="">
                </div>
            </div>
            <div id="album_inform">
	            <img src="image/default_image.png">
	                <span><br>앨범아트 위에 마우스를 올려주세요
	            <br>상세정보가 나타납니다.</span>
            </div>
            <div id="album_more">
                <span>더 보기</span>
            </div>
        </div>
    </div>

    <!-- <div id="main_channel">
        <div class="content_name" id="channel_tag">
            <b><span>Hot 채널</span></b>
        </div>
        <div class='content_background' id="channel_imagebox">
            <div class="channel_image" id="channel01">
            </div>
            <div class="channel_image" id="channel02">
            </div>
            <div class="channel_image" id="channel03">
            </div>
            <div class="channel_image" id="channel04">
            </div>
        </div>
    </div> -->

    <div id="main_seamdj">
        <div class="content_name" id="seamdj_tag">
            <b><span>인기 DJ</span></b>
        </div>
        <div class='content_background' id="seamdj_imagebox">
            
            <%
            for( int i = 0; i < djList.size(); i++ )
            {
            	if( i > 3 )
            		break;
            %>
            
            <div class="seamdj_image" id="seamdj0<%=(i + 1)%>" data-no="<%=djList.get(i).get("playlist_no")%>">
                <div class="seamdj_cover">
                	<img src="<%=djList.get(i).get("image")%>">
                </div>
                <div class="seamdj_info">
                    <div class="seamdj_info_image">
                    	<img src="<%=mbd.getMemberPartInfo(((String) djList.get(i).get("id")), "profile_image")%>">
                    </div>
                    <div class="seamdj_info_id">
                        <span><%=djList.get(i).get("nickname")%></span>
                    </div>
                    <div class="seamdj_info_title">
                        <span><%=djList.get(i).get("title")%></span>
                    </div>
                </div>
            </div>
            <%
            }
            %>
            
        </div>
    </div>
</body>

<script>

	var album_no = new Array();
	var nation_no = new Array();
	var name2 = new Array();
	var artist_no = new Array();
	var release_date = new Array();
	var release_com = new Array();
	var agency = new Array();
	var albumart = new Array();
	var artist_name = new Array();
	
	<%
	for( int i = 0; i < albumList.size(); i++ )
	{
	%>
		album_no[<%=i%>] = '<%=albumList.get(i).get("album_no")%>';
		nation_no[<%=i%>] = '<%=albumList.get(i).get("nation_no")%>';
		name2[<%=i%>] = "<%=albumList.get(i).get("name")%>";
		artist_no[<%=i%>] = '<%=albumList.get(i).get("artist_no")%>';
		release_date[<%=i%>] = '<%=albumList.get(i).get("release_date")%>';
		release_com[<%=i%>] = "<%=albumList.get(i).get("release_date")%>";
		agency[<%=i%>] = "<%=albumList.get(i).get("agency")%>";
		albumart[<%=i%>] = '<%=albumList.get(i).get("albumart")%>';
		artist_name[<%=i%>] = '<%=albumList.get(i).get("artist_name")%>';
	<%
	}
	%>
	
	init();

	<%-- var music_no = new Array();
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
		lyrics[<%=i%>] = '<%=musicList.get(i).get("lyrics")%>';
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
	
	init(); --%>
	
</script>

</html>	