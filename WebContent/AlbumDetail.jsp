<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");
	String album_no = request.getParameter("album_no");
	
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	MusicDatabase md = new MusicDatabase();
	MemberDatabase mbd = new MemberDatabase(); 
	PreferenceDatabase pd = new PreferenceDatabase();
	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	HashMap<String, Object> map = ad.getAlbumInfo(album_no);
	ArrayList<HashMap<String, Object>> musicList = md.getAlbumMusicList(album_no);
	ArrayList<HashMap<String, Object>> musicIncludeDJList = pld.getMusicIncludeDJList("false", "true", null, "album", album_no);
	
	map.put("likeCount", pd.getLikeCount("album", album_no, null));
	
	boolean userPreference = (pd.getLikeCount("album", album_no, id) > 0)? true: false;
	
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
    <link href="css/AlbumDetail.css" rel="stylesheet">

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/AlbumDetail.js"></script>
	
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="information">
    	<span id="information_span"><b>앨범 정보</b></span>
        <div id="information_box">
            <img src="<%=map.get("albumart")%>">
            <div id="information_detail">
                <span id="information_title"><%=map.get("name")%></span>
                <span class="detail_span">
		                아티스트 <br>
		                발매일 <br>
		                발매사 <br>
		                기획사 <br>
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
                  					out.println(",");
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
               	 	<%=map.get("release_date")%><br>
                	<%=map.get("release_com")%><br>
                	<%=map.get("agency")%><br>
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
        </div>
    </div>
    
	<div id="musicList">
        <div id="musicList_header">
            &nbsp;수록곡 (<%=musicList.size()%>)
        </div>
        <hr>
        <div id="musicList_btns">
            <a href="javascript:void(0)" id="all_select">
                <font>전체선택</font>
            </a>
            <a href="javascript:void(0)" id="select_listen">
                <font>선택듣기</font>
            </a>
            <a href="javascript:void(0)" id="select_add">
                <font>선택담기</font>
            </a>
        </div>

        <div id="musicList_content">
            <div id="musicList_content_title">
                <div id="musicList_no">NO</div>
                <div id="musicList_music">곡제목</div>
                <div id="musicList_artist">아티스트</div>
                <div id="musicList_album">앨범</div>
                <div id="musicList_listen">듣기</div>
                <div id="musicList_add">담기</div>
                <div id="musicList_lyrics">가사</div>
            </div>

            <div id="musicList_box">
            <%
            for( int i = 0; i < musicList.size(); i++ )
            {
            %>
                <div class="musicList_content_list" data-no="<%=musicList.get(i).get("music_no")%>">
                    <div class="musicList_select"><input type="checkbox" class="box_checkbox"></div>
                    <div class="musicList_no"><%=i + 1%></div>
                    <div class="musicList_music">
                        <img src='<%=musicList.get(i).get("albumart")%>' data-no="<%=musicList.get(i).get("music_no")%>">
                        <span data-no="<%=musicList.get(i).get("music_no")%>"><%=musicList.get(i).get("name")%></span>
                    </div>
                    <div class="musicList_artist" data-no="<%=musicList.get(i).get("music_no")%>">
                    	<%
                    		artists = (String) musicList.get(i).get("artist_no");
                    		album_no = (String) musicList.get(i).get("album_no");
                    		
                    		musicList.get(i).put("album_name", ad.getName(album_no));
                    		
                    		if( artists.contains(",") )
                    		{
                    			for( int j = 0; j < artists.split(",").length; j++ )
                    			{
               				%>
               				<span data-no="<%=artists.split(",")[j]%>"><%=atd.getName(artists.split(",")[j])%></span>
                    		<%
                    				if( j < artists.split(",").length - 1 )
                    					out.println(",");
                    			}
                    		}
                    		else
                    		{
                    		%>
                    		<span data-no="<%=artists%>"><%=atd.getName(artists)%></span>
                    		<%
                    		}
                    		%>
                   	</div>
                    <div class="musicList_album" data-no="<%=musicList.get(i).get("album_no")%>"><%=musicList.get(i).get("album_name")%></div>
                    <div class="musicList_listen"><img src="image/listen_icon.png"></div>
                    <div class="musicList_lyrics"><img src="image/lyrics_icon.png"></div>
                    <div class="musicList_add"><img src="image/add_icon.png"></div>
                </div>
            <%
            }
            %>
        	</div>
        </div>
    </div>

    <div id="album_introduce">
        <div id="album_introduce_header">&nbsp;앨범소개</div>
           
        <div id="introduce">
        	<%
           		if( map.get("intro") == null )
           			out.println("소개 없음");
           		else
           			out.println(((String) map.get("intro")).replaceAll("\n", "<br>"));
          	%>
        </div>
    </div>
    
    <div id="music_include">
        <div id="album_introduce_header">&nbsp;수록곡이 포함된 Seam DJ 플레이리스트 (<%=musicIncludeDJList.size()%>)</div>
        
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
    
    <!-- Large modal -->
    <button class="btn btn-primary" data-toggle="modal" data-target="#lyrics_modal" style="display: none;">Lyrics modal</button>
    <!-- Modal -->
    <div id="lyrics_modal" class="modal fade" role="dialog">
        <div id="lyrics_dialog" class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Seam Music 가사보기</h4>
                </div>

                <div class="modal-body">
                    <iframe src="" id="lyrics_iframe"></iframe>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
</body>

<script>
	$(window).load(function() {
		item_no = '<%=album_no%>';
		id = '<%=id%>';

		if( <%=userPreference%> )
			processType = "delete";
		else
			processType = "add";
	});
</script>

</html>	