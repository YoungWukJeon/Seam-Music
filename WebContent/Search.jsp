<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String filter = request.getParameter("filter");
	String filterValue = request.getParameter("filterValue");
	
	MusicDatabase md = new MusicDatabase();
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	MemberDatabase mbd = new MemberDatabase();
	PreferenceDatabase pd = new PreferenceDatabase();
	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	ArrayList<HashMap<String, Object>> artistList = null;
	ArrayList<HashMap<String, Object>> musicList = null;
	ArrayList<HashMap<String, Object>> albumList = null;
	ArrayList<HashMap<String, Object>> lyricsList = null;
	ArrayList<HashMap<String, Object>> playList = null;
	
	if( filter == null || filter.equals("all") )
	{
		artistList = atd.getArtistList(filterValue, 0);
		musicList = md.getMusicList(filterValue, 0);
		albumList = ad.getAlbumList(filterValue, 0);
		lyricsList = md.getLyricsIncludeMusicList(filterValue, 0);
		playList = pld.getPlayList("false", "true", filterValue, 0);
	}
	else if( filter.equals("artist") )
		artistList = atd.getArtistList(filterValue, 0);
	else if( filter.equals("music") )
		musicList = md.getMusicList(filterValue, 0);
	else if( filter.equals("album") )
		albumList = ad.getAlbumList(filterValue, 0);
	else if( filter.equals("lyrics") )
		lyricsList = md.getLyricsIncludeMusicList(filterValue, 0);
	else if( filter.equals("playlist") )
		playList = pld.getPlayList("false", "true", filterValue, 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Search.css" rel="stylesheet">
    
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/Search.js"></script>

</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

	<div id="search">
		<form method="get" action="Search.jsp">
	        <select id="search_select" name="filter">
	        	<option value="all" selected>전체</option>
	            <option value="artist">아티스트</option>
	            <option value="music">뮤직</op/tion>
	            <option value="album">앨범</option>
	            <option value="lyrics">가사</option>
	            <option value="playlist">Seam DJ</option>
	        </select>
	        
	        <input type="text" name="filterValue" placeholder="검색어를 입력하세요" value=""/>
	        <input type="submit" value="검색">
        </form>
    </div>
    
    <%
    if( filter == null || filter.equals("all") || filter.equals("artist") )
    {
    %>
    
    <div class='search_div' id="search_artist">
        <div class="music_table_title">
            <div class="colorbox"></div>
              아티스트 (<%=artistList.size() %>)
        </div>
        
        <%
        if( artistList.size() > 0 )
        {
        %>
        <div id="artist_box">
        	<div style="clear: both; height: 170px">
	            <div id="artist_first">
	                <img class="move_artist" src="<%=artistList.get(0).get("profile_image")%>" data-no="<%=artistList.get(0).get("artist_no")%>">
	                <div id="artist_first_box">
	                    <div id="artist_first_name"  class="move_artist" data-no="<%=artistList.get(0).get("artist_no")%>"><%=artistList.get(0).get("name")%><span>(<%=artistList.get(0).get("job")%>)</span></div>
	                    
	                    <div id="artist_first_info">
	                        <div>활동유형 :<span><%=(((String) artistList.get(0).get("group_name")).equals("") && ((String) artistList.get(0).get("position")).equals("-"))?"그룹":"솔로"%></span></div>
	                        <div>데뷔년도 : <span><%=artistList.get(0).get("debut_year")%></span></div>
	                        <%
	                        if( ((String) artistList.get(0).get("group_name")).equals("") && ((String) artistList.get(0).get("position")).equals("-") )	 // 그룹
	                        {
	                        	ArrayList<HashMap<String, Object>>groupMemberList = atd.getGroupMemberInfo((String) artistList.get(0).get("artist_no"));
	                        	
	                        %>
	                        <div id=artist_first_member>멤버 : 
	                        <%
	                        	for( int i = 0; i < groupMemberList.size(); i++ )
	                   			{
	               				%>
	               				<span class="move_artist" data-no="<%=groupMemberList.get(i).get("artist_no")%>">
	               					<%=atd.getName((String) groupMemberList.get(i).get("artist_no"))%>
	               					<%
	               						if( !((String) groupMemberList.get(i).get("position")).equals("") )
	               							out.println("(" + groupMemberList.get(i).get("position") + ")");
	               					%>
	               				</span>
	                    		<%
	                   				if( i < groupMemberList.size() - 1 )
	                   					out.println(", ");
	                    		}
	                        %>
	                        </div>
	                        <%
	                        }
	                        %>
	                        <div>소속사 : <span><%=artistList.get(0).get("agency")%></span></div>  
	                    </div>
	                </div>
	            </div>
	            <div id="other_artist">
	            	<%
	            	for( int i = 1; i < artistList.size(); i++ )
	            	{
	            		if( i > 3 )
	            			break;
	            	%>
	                <div class="other_artist">
	                    <img class="move_artist" src="<%=artistList.get(i).get("profile_image")%>" data-no="<%=artistList.get(i).get("artist_no")%>">
	                    <span class="move_artist" data-no="<%=artistList.get(i).get("artist_no")%>"><%=artistList.get(i).get("name")%></span>
	                </div>
	                <%
	            	}
	                %>
	            </div>
            </div>
            <%
            if( filter != null && filter.equals("artist") && artistList.size() > 4 )
            {
            %>
            <div id="other_artist2">
            <%
            	for( int i = 4; i < artistList.size(); i++ )
            	{
       		%>
       			<div class="other_artist">
                    <img class="move_artist" src="<%=artistList.get(i).get("profile_image")%>" data-no="<%=artistList.get(i).get("artist_no")%>">
                    <span class="move_artist" data-no="<%=artistList.get(i).get("artist_no")%>"><%=artistList.get(i).get("name")%></span>
                </div>
       		<%
            	}
            %>
            </div>
            <%
            }
            %>
        </div>
    <% 
    if( filter == null || filter.equals("all") )
    {
    %>	
    <div  id="more_artist" class="more">더보기</div>
    <%
    }
        }
        else
        {
   	%>
   	<div class="no_search_result">
    	<span>검색결과가 없습니다.</span>
    </div>
    <hr>
   	<%
        }
        %>
    </div>
        <%
    }
    %>
    
    <div style="clear: both; margin-bottom: 30px;"></div>
    
    <%
    if( filter == null || filter.equals("all") || filter.equals("music") )
    {
    %>
    <div id="musicList">
        <div id="musicList_header">
            &nbsp;곡 (<%=musicList.size()%>)
        </div>
        <hr>
        
        <%
        if( musicList.size() > 0 )
        {
        %>
        
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
            	if( (filter == null || filter.equals("all")) && i > 3 )
        			break;
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
                    		String artists = (String) musicList.get(i).get("artist_no");
                    		String album_no = (String) musicList.get(i).get("album_no");
                    		
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
		    <% 
		    if( filter == null || filter.equals("all") )
		    {
		    %>
    <div id="more_music" class="more">더보기</div>
		    <%
		    }
    	}
	    else
	    {
	    	%>
	       	<div class="no_search_result">
	        	<span>검색결과가 없습니다.</span>
	        </div>
	        <hr>
   	<%
	    }
    %>
    </div>
    <%
    }
    %>
    <div style="clear: both; margin-bottom: 30px;"></div>
    
    
    <%
    if( filter == null || filter.equals("all") || filter.equals("album") )
    {
    %>
    <div class='search_div' id="search_album">
        <div class="music_table_title">
            <div class="colorbox"></div>앨범 (<%=albumList.size()%>)
        </div>
        
        <div id="album_table">
        <%
        if( albumList.size() > 0 )
        {
        	for( int i = 0; i < albumList.size(); i++ )
        	{
        		if( (filter == null || filter.equals("all")) && i > 1 )
        			break;
        %>
            <div class="album_info">
                <img class='move_album' src="<%=albumList.get(i).get("albumart")%>" data-no="<%=albumList.get(i).get("album_no")%>">
                <span id="album_info_title"  class="album_info_detail move_album" data-no="<%=albumList.get(i).get("album_no")%>"><%=albumList.get(i).get("name")%></span>
                <span id="album_info_artist"  class="album_info_detail">
                	<%
                   		String artists = (String) albumList.get(i).get("artist_no");
                   		
                   		if( artists.contains(",") )
                   		{
                   			for( int j = 0; j < artists.split(",").length; j++ )
                   			{
              				%>
              				<span data-no="<%=artists.split(",")[j]%>" class="move_artist"><%=atd.getName(artists.split(",")[j])%></span>
                   		<%
                   				if( j < artists.split(",").length - 1 )
                   					out.println(", ");
                   			}
                   		}
                   		else
                   		{
                   		%>
                   		<span data-no="<%=artists%>" class="move_artist"><%=atd.getName(artists)%></span>
                   		<%
                   		}
               		%>
                </span>
                <span id="album_info_count"  class="album_info_detail">
                    총 <span id="album_music_count"><%=md.getAlbumMusicListCount((String) albumList.get(i).get("album_no")) %></span>곡
                </span>
                <span id="album_info_release" class="album_info_detail"><%=sdf.format(albumList.get(i).get("release_date"))%></span>
            </div>
       	<%
        	}
		    if( filter == null || filter.equals("all") )
		    {
		%>
		 </div>
	    <div id="more_album" class="more">더보기</div>
		<%
		    }
	    }
        else
        {
	    %>
	    <div class="no_search_result">
        	<span>검색결과가 없습니다.</span>
        </div>
        <hr>
        <%
        }
       	%>
  	</div>
   	<%
    }
    %>
   <div style="clear: both; margin-bottom: 30px;"></div>
    
    <%
    if( filter == null || filter.equals("all") || filter.equals("lyrics") )
    {
    %>
    <div class='search_div' id="search_lyrics">
        <div class="music_table_title">
            <div class="colorbox"></div>가사 (<%=lyricsList.size()%>)
        </div>
        
        <div id="lyrics_table">
        <%
        if( lyricsList.size() > 0 )
        {
        	for( int i = 0; i < lyricsList.size(); i++ )
        	{
        		if( (filter == null || filter.equals("all")) && i > 1 )
        			break;
        %>
            <div class="lyrics_box">
                <div class="lyrics_title move_music" data-no="<%=lyricsList.get(i).get("music_no")%>"><%=lyricsList.get(i).get("name")%></div>
                <div class="lyrics"><%=lyricsList.get(i).get("lyrics")%></div>
                <div class="lyrics_artist">
                	<%
                   		String artists = (String) lyricsList.get(i).get("artist_no");
                   		
                   		if( artists.contains(",") )
                   		{
                   			for( int j = 0; j < artists.split(",").length; j++ )
                   			{
              				%>
              				<span data-no="<%=artists.split(",")[j]%>" class="move_artist"><%=atd.getName(artists.split(",")[j])%></span>
                   		<%
                   				if( j < artists.split(",").length - 1 )
                   					out.println(", ");
                   			}
                   		}
                   		else
                   		{
                   		%>
                   		<span data-no="<%=artists%>" class="move_artist"><%=atd.getName(artists)%></span>
                   		<%
                   		}
               		%>
                </div>
            </div>
    	<%
    		if( i < lyricsList.size() )
    			out.println("<hr style='width: 900px; left: 50px'>");
    	
        	}
		    if( filter == null || filter.equals("all") )
		    {
		%>
	    <div id="more_lyrics" class="more" >더보기</div>
		<%
		    }
		}
	    else
	    {
	    %>
	    <div class="no_search_result">
	    	<span>검색결과가 없습니다.</span>
	    </div>
	    <hr>
	    <%
	    }
	   	%>
	</div>
	<%
	}
	%>
	</div>
    <div style="clear: both; margin-bottom: 30px;"></div>
    
    
    <%
    if( filter == null || filter.equals("all") || filter.equals("playlist") )
    {
    %>
    <div class='search_div' id="search_DJ">
        <div class="music_table_title">
            <div class="colorbox"></div>Seam DJ 플레이리스트 (<%=playList.size() %>)
        </div>
        
        <%
        if( playList.size() > 0 )
        {
        	for( int i = 0; i < playList.size(); i++ )
        	{
        		if( (filter == null || filter.equals("all")) && i > 1 )
        			break;
        		
        		playList.get(i).put("bestMusicNo", pmd.getBest1MusicNo((String) playList.get(i).get("playlist_no")));
        		
        		if( ((String) playList.get(i).get("bestMusicNo")).equals("") )
        			playList.get(i).put("bestMusicName", "곡이 없습니다.");
        		else
        			playList.get(i).put("bestMusicName", md.getMusicPartInfo((String) playList.get(i).get("bestMusicNo"), "name"));
        %>
        
        <div class="dj_box">
            <img class='dj_cover move_playlist' src="<%=playList.get(i).get("image")%>" data-no="<%=playList.get(i).get("playlist_no")%>">
            <div class="dj_info">
                <div id="dj_title" class="move_playlist" data-no="<%=playList.get(i).get("playlist_no")%>"><%=playList.get(i).get("title")%></div>
                <div id="dj_id" class='move_member' data-no="<%=playList.get(i).get("id")%>"><%=playList.get(i).get("id")%></div>
                <div id="dj_date"><%=sdf.format(playList.get(i).get("date"))%></div>
                <div id="dj_count">총 <span><%=pmd.getPlayListMusicCount((String) playList.get(i).get("playlist_no")) %></span>곡</div>
                <div id="dj_genre"><%=playList.get(i).get("genre") %></div>
            </div>
            <div class="dj_music_box">
                <div class="dj_music">
                    <img class='dj_music_img click' src='image/play_mini_icon.png'/>
                    <div class='dj_music_title move_music' data-no="<%=playList.get(i).get("bestMusicNo")%>"><%=playList.get(i).get("bestMusicName")%></div>
                    <div class='dj_music_artist'>
                    	<%
                    	if( !((String) playList.get(i).get("bestMusicNo")).equals("") )
                    	{
	                   		String artists = (String) md.getMusicPartInfo((String) playList.get(i).get("bestMusicNo"), "artist_no");
	                   		
	                   		if( artists.contains(",") )
	                   		{
	                   			for( int j = 0; j < artists.split(",").length; j++ )
	                   			{
	              				%>
              				<span class="move_artist" data-no="<%=artists.split(",")[j]%>" ><%=atd.getName(artists.split(",")[j])%></span>
                   		<%
	                   				if( j < artists.split(",").length - 1 )
	                   					out.println(", ");
	                   			}
	                   		}
	                   		else
	                   		{
                   		%>
                   		<span data-no="<%=artists%>" class="move_artist"><%=atd.getName(artists)%></span>
                   		<%
	                   		}
                   		}
               		%>
                    </div>
                </div>
            </div>
        </div>
    <%
        	}
    	    if( filter == null || filter.equals("all") )
		    {
		%>
		<div style="clear: both; margin-bottom: 10px;"></div>
	    <div id="more_playlist" class="more">더보기</div>
		<%
		    }
		}
	    else
	    {
	    %>
	    <div class="no_search_result">
	    	<span>검색결과가 없습니다.</span>
	    </div>
	    <hr>
	    <%
	    }
	   	%>
	</div>
	<%
	}
	%>
    <div style="clear: both; margin-bottom: 30px;"></div>
    
    
    
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
		<%
		if( filter != null )
			out.println("$('#search select').prop('value', '" + filter + "');");
			
		
		if( filterValue != null && !filterValue.equals("") )
			out.println("$('#search input').eq(0).attr('value', '" + filterValue + "');");
		
		%>
	});
	
	filterValue = '<%=(filterValue != null)? filterValue: ""%>';
	
</script>

</html>