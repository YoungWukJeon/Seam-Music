<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");
	String artist_no = request.getParameter("artist_no");
	
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	MusicDatabase md = new MusicDatabase();
	PreferenceDatabase pd = new PreferenceDatabase();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	HashMap<String, Object> map = atd.getArtistInfo(artist_no);
	ArrayList<HashMap<String, Object>> musicList = md.getArtistMusicList(artist_no);
	ArrayList<HashMap<String, Object>> albumList = ad.getArtistAlbumList(artist_no);
	ArrayList<HashMap<String, Object>> groupMemberList = null;
	
	map.put("likeCount", pd.getLikeCount("artist", artist_no, null));
	
	boolean userPreference = (pd.getLikeCount("artist", artist_no, id) > 0)? true: false;
	
	if( ((String) map.get("group_name")).equals("") && ((String) map.get("position")).equals("-") )	// 그룹일 경우
		groupMemberList = atd.getGroupMemberInfo(artist_no);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/ArtistDetail.css" rel="stylesheet">

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/ArtistDetail.js"></script>
	
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="information">
        <span id="information_span"><b>아티스트 정보</b></span>
        <div id="information_box">
            <img id='information_img' src="<%=map.get("profile_image")%>" />
            <div id="information_detail">
                <span id="information_title"><%=map.get("name")%><span>&nbsp;&nbsp;&nbsp;<%=map.get("job")%></span></span>
                <span class="detail_span">
		               데뷔년도 <br>
		               그룹명 <br>
		               소속사 <br>
		               멤버 <br>
					성별 <br>
		        </span>
		        
                <span class="detail_database">
	                <%=map.get("debut_year") %>년<br>
	                <%
	                if( !((String) map.get("group_name")).equals("") )
	                {
						String group = (String) map.get("group_name");
	                	
	                	if( group.contains(",") )
                		{
                			for( int j = 0; j < group.split(",").length; j++ )
                			{
           				%>
           				<span class="move_artist" data-no="<%=group.split(",")[j]%>"><%=atd.getName(group.split(",")[j])%></span>
                		<%
                				if( j < group.split(",").length - 1 )
                					out.println(", ");
                			}
                		}
                		else
                		{
                		%>
                		<span class="move_artist" data-no="<%=group%>"><%=atd.getName(group)%></span>
                	<%
                		}
	                }
	                %>
	                <br>
	                <%=map.get("agency") %><br>
	                <%
	                if( groupMemberList != null )
	                {
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
	                }
	                %>
	                <br>
	                <%=map.get("gender")%><br>
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
    
    <div id="list">
        <div id="list_title">
            <div id="list_title_1" class="list_title">
                <span><b>곡</b></span>
            </div>
            <div id="list_title_2" class="list_title">
                <span><b>앨범</b></span>
            </div>
        </div>
        
        <div id="musicList">
	        <div id="musicList_header">
	            &nbsp;참여곡 (<%=musicList.size()%>)
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
	                    					out.println(", ");
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
        
        <div id="album_table_back">
            <div id="album_title">
                <span id="album_title_1" >참여앨범</span>
                <span>
                    (전체 <span id="album_title_count"><%=albumList.size()%></span>개)
                </span>
            </div>
            <div id="album_table">
             <%
            for( int i = 0 ; i < albumList.size(); i++ )
            {
            	albumList.get(i).put("musiclist_num", md.getAlbumMusicListCount((String) albumList.get(i).get("album_no")));
            %>
                <div class="album_info">
                    <img data-no="<%=albumList.get(i).get("album_no")%>" class="move_album" src="<%=albumList.get(i).get("albumart")%>">
                    <span class="album_info_release album_info_detail"><%=albumList.get(i).get("release_date")%></span>
                    <span data-no="<%=albumList.get(i).get("album_no")%>" class="move_album album_info_title album_info_detail"><%=albumList.get(i).get("name")%></span>
                    <span class="album_info_artist album_info_detail">
                    	<%
                    		String artists = (String) albumList.get(i).get("artist_no");
                    		
                    		if( artists.contains(",") )
                    		{
                    			for( int j = 0; j < artists.split(",").length; j++ )
                    			{
               				%>
               				<span class="move_artist" data-no="<%=artists.split(",")[j]%>"><%=atd.getName(artists.split(",")[j])%></span>
                    		<%
                    				if( j < artists.split(",").length - 1 )
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
                   	</span>
                    <span class="album_info_count album_info_detail">총 <%= albumList.get(i).get("musiclist_num")%>곡</span>
                    <span class="album_info_releasecom album_info_detail"><%=albumList.get(i).get("release_com")%></span>
                </div>
            <%
            }
            %>
            </div>
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
		item_no = '<%=artist_no%>';
		id = '<%=id%>';

		if( <%=userPreference%> )
			processType = "delete";
		else
			processType = "add";
	});
</script>

</html>	