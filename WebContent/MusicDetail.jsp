<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");
	String music_no = request.getParameter("music_no");
	
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	MusicDatabase md = new MusicDatabase();
	MemberDatabase mbd = new MemberDatabase(); 
	PreferenceDatabase pd = new PreferenceDatabase();
	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	HashMap<String, Object> map = md.getMusicInfo(music_no);
	ArrayList<HashMap<String, Object>> musicIncludeDJList = pld.getMusicIncludeDJList("false", "true", null, "music", music_no);
	
	map.put("likeCount", pd.getLikeCount("music", music_no, null));
	map.put("album_name", ad.getName((String) map.get("album_no")));
	
	boolean userPreference = (pd.getLikeCount("music", music_no, id) > 0)? true: false;
	
	for( int i = 0; i < musicIncludeDJList.size(); i++ )
	{
		musicIncludeDJList.get(i).put("likeCount", pd.getLikeCount("playlist", (String) musicIncludeDJList.get(i).get("playlist_no"), null));
		musicIncludeDJList.get(i).put("nickname", mbd.getNickname((String) musicIncludeDJList.get(i).get("id"), null));
		musicIncludeDJList.get(i).put("playlist_num", pmd.getPlayListMusicCount((String) musicIncludeDJList.get(i).get("playlist_no")));
	}
	
	Collections.sort(musicIncludeDJList, new MapComparator("likeCount"));
	Collections.reverse(musicIncludeDJList);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/MusicDetail.css" rel="stylesheet">

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/MusicDetail.js"></script>
	
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="information">
        <span id="information_span"><b>곡 정보</b></span>
        <div id="information_box">
            <img id='information_img' src="<%=map.get("albumart")%>" />
            <div id="information_detail">
                <span id="information_title"><%=map.get("name")%></span>
                <span class="detail_span">
		                아티스트 <br>
		                앨범 <br>
		                발매일 <br>
		                작곡가 <br>
		                작사가 <br>
	        	</span>
                <span class="detail_database">
               		<%
                  		String artists = (String) map.get("artist_no");
                  		
                  		if( artists.contains(",") )
                  		{
                  			for( int i = 0; i < artists.split(",").length; i++ )
                  			{
             				%>
             				<span class="move_artist" data-no="<%=artists.split(",")[i]%>"><%=atd.getName(artists.split(",")[i])%></span>
                  		<%
                  				if( i < artists.split(",").length - 1 )
                  					out.println(", ");
                  			}
                  		}
                  		else
                  		{
                  		%>
                  		<span class="move_artist" data-no="<%=artists%>"><%=atd.getName(artists)%></span>
                  		<%
                  		}
                  		%>
               		<br>
               	 	<span class="move_album" data-no="<%=map.get("album_no")%>"><%=map.get("album_name")%></span><br>
                	<%=map.get("release_date")%><br>
                	<%
                  		String swriters = (String) map.get("song_writer");
                  		
                  		if( swriters.contains(",") )
                  		{
                  			for( int i = 0; i < swriters.split(",").length; i++ )
                  			{
             				%>
             				<span class="move_artist" data-no="<%=swriters.split(",")[i]%>"><%=atd.getName(swriters.split(",")[i])%></span>
                  		<%
                  				if( i < swriters.split(",").length - 1 )
                  					out.println(", ");
                  			}
                  		}
                  		else
                  		{
                  		%>
                  		<span class="move_artist" data-no="<%=swriters%>"><%=atd.getName(swriters)%></span>
                  		<%
                  		}
                  		%>
               		<br>
               		<%
                  		String lwriters = (String) map.get("lyric_writer");
                  		
                  		if( lwriters.contains(",") )
                  		{
                  			for( int i = 0; i < lwriters.split(",").length; i++ )
                  			{
             				%>
             				<span class="move_artist" data-no="<%=lwriters.split(",")[i]%>"><%=atd.getName(lwriters.split(",")[i])%></span>
                  		<%
                  				if( i < lwriters.split(",").length - 1 )
                  					out.println(", ");
                  			}
                  		}
                  		else
                  		{
                  		%>
                  		<span class="move_artist" data-no="<%=lwriters%>"><%=atd.getName(lwriters)%></span>
                  		<%
                  		}
                  		%>
               	</span>
            </div>
            
            <%
            if( id != null && userPreference )
            	// out.println("<input type='button' value='♥ 좋아요 취소 (" + map.get("likeCount") +")'>");
            	out.println("<button class='info_btn' id='like_button'><img src='image/heart.png'>좋아요 취소 (" + map.get("likeCount") + ")</button>");
            else
            	// out.println("<input type='button' value='♡ 좋아요 (" + map.get("likeCount") +")'>");
           	 	out.println("<button class='info_btn' id='like_button'><img src='image/heart_none.png'>좋아요 (" + map.get("likeCount") + ")</button>");
            %>
            <button class='info_btn' id="listen_button"><img src="image/listen_icon.png"> 듣기</button>
        </div>
    </div>
    <div id="lyrics_title">
        
        <div id="lyrics_title_header">&nbsp;가사</div>
        
        <div id="lyrics_box">
	        <ul>
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
			</ul>
        </div>
    </div>
    
    <div id="music_include">
        <div id="music_include_header">&nbsp;해당 곡이 포함된 Seam DJ 플레이리스트 (<%=musicIncludeDJList.size()%>)</div>
        
        <div id="album_introduce_content">
        <%
        if( musicIncludeDJList.size() > 0 )
        {
			for( int i = 0; i < musicIncludeDJList.size(); i++ )
			{
				if( i > 2 )
					break;
        %>
	        <div class="include_dj">
	            <img class="move_playlist" data-no="<%=musicIncludeDJList.get(i).get("playlist_no")%>" src="<%=musicIncludeDJList.get(i).get("image")%>"/>
	            <span id="dj_title" class="move_playlist" data-no="<%=musicIncludeDJList.get(i).get("playlist_no")%>"><%=musicIncludeDJList.get(i).get("title")%></span>
	            <span>
	                <%=musicIncludeDJList.get(i).get("nickname")%><br>
	                총 <%=musicIncludeDJList.get(i).get("playlist_num")%>곡<br>
	                <%=sdf.format(musicIncludeDJList.get(i).get("date"))%><br>
	            </span>
	        </div>
	    <%
			}
        }
        else
        {
      	%>
      		<div id="no_playlist">
           		<span>다른 플레이 리스트가 없습니다.</span>
           	</div>
      	<%
        }
	    %>
	      </div>
    </div>
    
</body>

<script>
	$(window).load(function() {
		item_no = '<%=music_no%>';
		id = '<%=id%>';

		if( <%=userPreference%> )
			processType = "delete";
		else
			processType = "add";
	});
</script>

</html>	