<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");
	
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	MemberDatabase mbd = new MemberDatabase();
	MusicDatabase md = new MusicDatabase();
	PreferenceDatabase pd = new PreferenceDatabase();
	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	String nickname = (String) mbd.getMemberPartInfo(id, "nickname");
	
	HashMap<String, Object> map = mbd.getMemberInfo(nickname);
	
	if( ((String) map.get("birth")) == null || ((String) map.get("birth")).equals("") )
		map.put("birth", "");
	else
		map.put("birth", ((String) map.get("birth")).substring(0, 4) + "." + ((String) map.get("birth")).substring(4, 6) + "." + ((String) map.get("birth")).substring(6, 8));
		
	
	
	
	ArrayList<HashMap<String, Object>> playList = pld.getPlayList("false", "true", id);
	ArrayList <HashMap<String, Object>> musicList = md.getLikeMusicList(id);
	ArrayList <HashMap<String, Object>> genreList = md.getMemberBestGenre(id);
	
	
	for( int i = 0; i < playList.size(); i++ )
	{
		playList.get(i).put("bestMusicNo", pmd.getBest1MusicNo((String) playList.get(i).get("playlist_no")));
		
		if( ((String) playList.get(i).get("bestMusicNo")).equals("") )
			playList.get(i).put("bestMusicName", "곡이 없습니다.");
		else
			playList.get(i).put("bestMusicName", md.getMusicPartInfo((String) playList.get(i).get("bestMusicNo"), "name"));
		
		playList.get(i).put("likeCount", pd.getLikeCount("playlist", (String) playList.get(i).get("playlist_no"), null));
		playList.get(i).put("nickname", mbd.getNickname((String) map.get("id"), null));
		playList.get(i).put("playlist_num", pmd.getPlayListMusicCount((String) playList.get(i).get("playlist_no")));
	
	}
	
	int sum = 0;
	
	for( int i = 0; i < genreList.size(); i++ )
		sum += (Integer) genreList.get(i).get("count");
	
	Collections.sort(playList, new MapComparator("likeCount"));
	Collections.reverse(playList);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/jqbar.css" rel="stylesheet">
    <link href="css/MyPage.css" rel="stylesheet">

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jqbar.js"></script>
    <script src="js/MemberDetail.js"></script>
	
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
    <div id="center">

        <div id="header">
            <span><%=nickname%></span> 님의 정보
        </div>

        <hr>

        <div id="user_info">
            <div id="profile_image">
                <img src="<%=map.get("profile_image")%>">
            </div>

            <div id="info_content1">
                <div id="info_id"><%=id%></div>
                <div id="info_name"><%=map.get("name")%></div>
                <div id="info_gender"><%=map.get("gender")%></div>
                <div id="info_birth"><%=map.get("birth")%></div>
                <div id="info_phone"><%=map.get("phone")%></div>
                <div id="info_email"><%=map.get("email")%></div>
            </div>

            <div id="info_content2">
                <div id="info_job"><%=map.get("job")%></div>
                <div id="info_hometown"><%=map.get("hometown")%></div>
                <div id="info_interest"><br><%=map.get("interest")%></div>
                <div id="info_intro"><%=map.get("intro")==null? "인사말 없음": map.get("intro")%></div>
            </div>
        </div>

        <div id="dna">
            <div id="dna_header">&nbsp;
                <span><%=nickname%></span> 님의 음악 성향
                <div>(주로 들은 장르)</div>
            </div>

            <div style="height: 10px"></div>
            <hr>

            <div id="dna_content">
	        	<%
	        	if( sum > 0 )
	        	{
	        	%>
	        	<div class="bars MT30"></div>
	        	<%
	        	}
	        	else
	        	{
	       		%>
	       		<div id="none_dj_dna">자료가 충분하지 않습니다.</div>
	       		<%
	        	}
	        	 %>
            </div>
            
            <hr>
        </div>

        <div id="another_playList">
			<div id="another_playList_header">
        	&nbsp;<span data-no="<%=map.get("id")%>"><%=map.get("nickname") %></span>
        	님의 Seam DJ 플레이리스트(<%=playList.size()%>)
       	</div>
        
        <hr>
        <div id="another_playList_content">
        <% 
        if( playList.size() > 0 )
        {
        	for( int i = 0; i < playList.size(); i++ )
        	{
       	%>
            <div class="best_playlist">
                <div class="another_playList_img" data-no="<%=playList.get(i).get("playlist_no")%>">
                    <img src="<%=playList.get(i).get("image")%>">
                </div>

                <div class="another_playList_content">
                    <div class="another_playList_title" data-no="<%=playList.get(i).get("playlist_no")%>">
                    <%=playList.get(i).get("title")%>
                    </div>

                    <div class="another_playList_detail">
                        <%=playList.get(i).get("nickname")%> | 총 <%=playList.get(i).get("playlist_num")%>곡
                    </div>

                    <div class="another_playList_like">♥ <%=playList.get(i).get("likeCount")%></div>

                    <div class="another_playList_top1_music" data-no="<%=playList.get(i).get("bestMusicNo")%>">
                        <span><img src="image/play_mini_icon.png"></span>&nbsp;<%=playList.get(i).get("bestMusicName")%>
                        <div>(가장 인기 많은곡)</div>
                    </div>
                </div>
            </div>
            <%
        	}
    	}
        else
        {
       	%>
        	<div id="no_playlist">
        		<span>플레이 리스트가 없습니다.</span>
        	</div>
      	<%
        }
        %>
        </div>
        <hr>
        </div>

        <div id="musicList">
	        <div id="musicList_header">
	            &nbsp;<span data-no="<%=id%>"><%=nickname%></span> 님이 좋아요 한 곡 (<%=musicList.size()%>)
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
		
		<%
		if( sum > 0 )
		{
		%>
		$(".MT30").append("<div id='bar-1' class='dna_bar'></div><div id='bar-2' class='dna_bar'></div><div id='bar-3' class='dna_bar'></div>");
		$('#bar-1').jqbar({ label: '<%=genreList.get(0).get("genre")%>', value: <%=Math.round((Integer)(genreList.get(0).get("count")) / (double)sum * 100)%>, barColor: '#D64747' , barLength: '800', animationSpeed: '8000'});
		
		<%
			if( genreList.size() > 1 )
				out.println("$('#bar-2').jqbar({ label: '" + genreList.get(1).get("genre") + "', value: " + Math.round((Integer)(genreList.get(1).get("count")) / (double)sum * 100) + ", barColor: '#44cc66', barLength: '800', animationSpeed: '8000'});");
			
			if( genreList.size() > 2 )
				out.println("$('#bar-3').jqbar({ label: '" + genreList.get(2).get("genre") + "', value: " + Math.round((Integer)(genreList.get(2).get("count")) / (double)sum * 100) + ", barColor: '#3a89c9', barLength: '800', animationSpeed: '8000'});");
		}
		%>
		
		<%
		if( playList.size() > 0 )
		{
		%>
		$("#another_playList_content").css("height", <%=Math.round(playList.size() / 2.0) * 150%> + "px");
		<%
		}
		%>
	});
</script>

</html>	