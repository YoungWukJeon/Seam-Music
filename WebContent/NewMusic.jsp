<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy'.'MM'.'dd E'요일' HH:mm");
	Date today = new Date();
	
	MusicDatabase md = new MusicDatabase();
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	PlayHistoryDatabase phd = new PlayHistoryDatabase();
	
	ArrayList<HashMap<String, Object>> musicList = md.getNewMusicList();
	
	for( int i = 0; i < musicList.size(); i++ )
	{
		String artists = (String) musicList.get(i).get("artist_no");
		String album_no = (String) musicList.get(i).get("album_no");
		
		String artist_name = "";
		
		if( artists.contains(",") )
		{
			for( int k = 0; k < artists.split(",").length; k++ )
				artist_name += atd.getName(artists.split(",")[k]) + ",";
			artist_name = artist_name.substring(0, artist_name.length() - 1);
		}
		else
			artist_name = atd.getName(artists);
		
		musicList.get(i).put("artist_name", artist_name);
		musicList.get(i).put("album_name", ad.getName(album_no));
	}
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Chart.css" rel="stylesheet">
    
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.flot.min.js"></script>
    <script src="js/Chart.js"></script>

</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

	<div id="chart_title">
		Seam 최신 TOP 100
	</div>
	
	<div id="graph_header">
		<div id="current_date">
			<%=sdf.format(today)%>
		</div>
		
		<div id="chart_refresh">
			새로고침
		</div>
	</div>
	
	<div id="chart_button">
		<a href="javascript:void(0)" id="all_select"><font>전체선택</font></a>
		<a href="javascript:void(0)" id="select_listen"><font>선택듣기</font></a>
		<a href="javascript:void(0)" id="select_add"><font>선택담기</font></a>
	</div>
	
	<div id="chart_content">
		<div id="chart_content_title">
			<div id="chart_order">순위</div>
			<div id="chart_music">곡제목</div>
			<div id="chart_artist">아티스트</div>
			<div id="chart_album">앨범</div>
			<div id="chart_listen">듣기</div>
			<div id="chart_add">담기</div>
			<div id="chart_lyrics">가사</div>
		</div>
		
		<div id="chart_box1">
			<%
			for( int i = 0; i < musicList.size() / 2; i++ )
			{
				int top = 35 + (i * 65);
			%>
			
			<div id="<%=musicList.get(i).get("music_no")%>" class="chart_content_list" style="top: <%=top%>px;">
				<div class="chart_select"><input type="checkbox" class="box1_checkbox" value="<%=musicList.get(i).get("music_no")%>"></div>
				<div class="chart_order"><%=i + 1 %></div>
				<div class="chart_music">
					<img src="<%=musicList.get(i).get("albumart")%>">
					<span><%=musicList.get(i).get("name")%></span>
				</div>
				<div class="chart_artist"><%=musicList.get(i).get("artist_name")%></div>
				<div class="chart_album"><%=musicList.get(i).get("album_name")%></div>
				<div class="chart_listen"><img src="image/listen_icon.png"></div>
				<div class="chart_lyrics"><img src="image/lyrics_icon.png"></div>
				<div class="chart_add"><img src="image/add_icon.png"></div>
			</div>
			<%
			}
			%>
			
		</div>
	
		<div id="chart_box2" style="display: none;">
			<%
				for( int i = musicList.size() / 2; i < musicList.size(); i++ )
				{
					int top = 35 + ((i - (musicList.size() / 2)) * 65);
			%>
				
				<div id="<%=musicList.get(i).get("music_no")%>" class="chart_content_list" style="top: <%=top%>px;">
					<div class="chart_select"><input type="checkbox" class="box2_checkbox" value="<%=musicList.get(i).get("music_no")%>"></div>
					<div class="chart_order"><%=i + 1 %></div>
					<div class="chart_music">
						<img src="<%=musicList.get(i).get("albumart")%>">
						<span><%=musicList.get(i).get("name")%></span>
					</div>
					<div class="chart_artist"><%=musicList.get(i).get("artist_name")%></div>
					<div class="chart_album"><%=musicList.get(i).get("album_name")%></div>
					<div class="chart_listen"><img src="image/listen_icon.png"></div>
					<div class="chart_lyrics"><img src="image/lyrics_icon.png"></div>
					<div class="chart_add"><img src="image/add_icon.png"></div>
				</div>
				<%
				}
				%>
		</div>
		
		<div id="page_navi">
			<span id="page_navi_1" class="page_navi_area current_list">1 - 5</span>
			<span id="splitter">|</span>
			<span id="page_navi_2" class="page_navi_area">6 - 10</span>
		</div>
	</div>
	
	
	
	<!-- Large modal -->
    <button class="btn btn-primary" data-toggle="modal" data-target="#lyrics_modal" style="display: none;">Login modal</button>
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
		
		$("#chart_content").css("height", <%=musicList.size() / 2 + 1%> * 70 + "px");
		
		$("#chart_button").css("top", "140px");
		$("#chart_content").css("top", "200px");
		
		
	});
	
</script>

</html>