<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String tab_no = request.getParameter("tab_no");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy'.'MM'.'dd E'요일' HH:mm");
	Date today = new Date();
	
	// MusicDatabase md = new MusicDatabase();
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	PlayHistoryDatabase phd = new PlayHistoryDatabase();
	
	ArrayList<ArrayList<HashMap<String, Object>>> chartList = new ArrayList<ArrayList<HashMap<String, Object>>> ();
	ArrayList<Integer> top1Order = new ArrayList<Integer> ();
	ArrayList<Integer> top2Order = new ArrayList<Integer> ();
	ArrayList<Integer> top3Order = new ArrayList<Integer> ();
	
	for( int i = 0; i < 24; i++ )
	{
		long beforeHour = System.currentTimeMillis() - (i + 1) * 3600000;
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss.SS");
		String tempDate = sdf2.format(beforeHour);
		
		ArrayList<HashMap<String, Object>> tempList = phd.getPlayHistory(tempDate);
		// System.out.println(tempList.size());
		
		if( i == 0 )		// 가장 최근시간의 정보만 가져옴
		{
			for( int j = 0; j < tempList.size(); j++ )
			{
				// HashMap<String, Object> tempMap = md.getMusicInfo((String) tempList.get(j).get("music_no"));
				
				String artists = (String) tempList.get(j).get("artist_no");
				String album_no = (String) tempList.get(j).get("album_no");
				
				String artist_name = "";
				
				if( artists.contains(",") )
				{
					for( int k = 0; k < artists.split(",").length; k++ )
						artist_name += atd.getName(artists.split(",")[k]) + ",";
					artist_name = artist_name.substring(0, artist_name.length() - 1);
				}
				else
					artist_name = atd.getName(artists);
				
				tempList.get(j).put("artist_name", artist_name);
				tempList.get(j).put("album_name", ad.getName(album_no));
			}
		}
		chartList.add(tempList);
	}
	
	for( int i = 0; i < chartList.size(); i++ )
	{
		for( int j = 0; j < chartList.get(i).size(); j++ )
		{
			if( chartList.get(0).get(0).get("music_no").equals(chartList.get(i).get(j).get("music_no")) )
				top1Order.add(j);
			if( chartList.get(0).get(1).get("music_no").equals(chartList.get(i).get(j).get("music_no")) )
				top2Order.add(j);
			if( chartList.get(0).get(2).get("music_no").equals(chartList.get(i).get(j).get("music_no")) )
				top3Order.add(j);
		}
		
		if( top1Order.size() < i + 1 )
			top1Order.add(-1);
		if( top2Order.size() < i + 1)
			top2Order.add(-1);
		if( top3Order.size() < i + 1 )
			top3Order.add(-1);
	}
	
	int sumRate = Integer.parseInt((String)chartList.get(0).get(0).get("play_count")) + Integer.parseInt((String)chartList.get(0).get(1).get("play_count")) + Integer.parseInt((String)chartList.get(0).get(2).get("play_count"));
	int top1Rate = Math.round(Float.parseFloat((String)chartList.get(0).get(0).get("play_count")) / sumRate * 100);
	int top2Rate = Math.round(Float.parseFloat((String)chartList.get(0).get(1).get("play_count")) / sumRate * 100);
	int top3Rate = Math.round(Float.parseFloat((String)chartList.get(0).get(2).get("play_count")) / sumRate * 100);
	
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
		Seam TOP 100
	</div>
	
	<div id="graph_header">
		<div id="tab_menu_list">
			<div class="tab_menu">
				<span>실시간</span>
			</div>
			<div class="tab_menu">
				<span>주간</span>
			</div>
			<div class="tab_menu">
				<span>월간</span>
			</div>
		</div>
		
		<div id="current_date">
			<%=sdf.format(today)%>
		</div>
		
		<div id="chart_refresh">
			새로고침
		</div>
	</div>
	
	<%
	if( tab_no == null )
	{
	%>
	<div id="chart_area">
		<div id="graph_area">
			<div id="graph-wrapper">
				<div class="graph-info">
					<div id="graph-info-title">
						실시간 점유율
					</div>
					
					<a href="javascript:void(0)" class="firstClass category">1위 &nbsp;<%=top1Rate%>%</a>
			        <a href="javascript:void(0)" class="secondClass category">2위 &nbsp;<%=top2Rate%>%</a>
			        <a href="javascript:void(0)" class="thirdClass category">3위 &nbsp;<%=top3Rate%>%</a>
				</div>
		
				<div class="graph-container">
					<div id="graph-lines"></div>
			    </div>
			</div>
		</div>
		
		<div id="music_info_area">
			<img src="">
			
			<div id="music_gray_background"></div>
			
			<div id="music_info_detail">
				<div id="music_info_top">
					<div id="rank_num"></div>
					
					<div id="rank_music_info">
						<div id="rank_music_albumart">
							<img src="">
						</div>
						
						<div id="rank_music_content">
							<div id="rank_music_title"></div>
							<div id="rank_music_artist"></div>
							<div id="rank_music_play_count"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>

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
			for( int i = 0; i < chartList.get(0).size() / 2; i++ )
			{
				int top = 35 + (i * 65);
			%>
			
			<div id="<%=chartList.get(0).get(i).get("music_no")%>" class="chart_content_list" style="top: <%=top%>px;">
				<div class="chart_select"><input type="checkbox" class="box1_checkbox" value="<%=chartList.get(0).get(i).get("music_no")%>"></div>
				<div class="chart_order"><%=i + 1 %></div>
				<div class="chart_music">
					<img src="<%=chartList.get(0).get(i).get("albumart")%>">
					<span><%=chartList.get(0).get(i).get("music_name")%></span>
				</div>
				<div class="chart_artist"><%=chartList.get(0).get(i).get("artist_name")%></div>
				<div class="chart_album"><%=chartList.get(0).get(i).get("album_name")%></div>
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
				for( int i = chartList.get(0).size() / 2; i < chartList.get(0).size(); i++ )
				{
					int top = 35 + ((i - (chartList.get(0).size() / 2)) * 65);
			%>
				
				<div id="<%=chartList.get(0).get(i).get("music_no")%>" class="chart_content_list" style="top: <%=top%>px;">
					<div class="chart_select"><input type="checkbox" class="box2_checkbox" value="<%=chartList.get(0).get(i).get("music_no")%>"></div>
					<div class="chart_order"><%=i + 1 %></div>
					<div class="chart_music">
						<img src="<%=chartList.get(0).get(i).get("albumart")%>">
						<span><%=chartList.get(0).get(i).get("music_name")%></span>
					</div>
					<div class="chart_artist"><%=chartList.get(0).get(i).get("artist_name")%></div>
					<div class="chart_album"><%=chartList.get(0).get(i).get("album_name")%></div>
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

	<%
	if( tab_no != null )
	{
		int tab_num = Integer.parseInt(tab_no);
	%>
		changeTab(<%=tab_num%>);
		// 주간, 월간 일경우에 처리
	<%
	}
	else
	{
	%>
		changeTab(0);
	<%
	}
	%>
	
	var music_no = new Array();
	var music_name = new Array();
	var play_time = new Array();
	var duration = new Array();
	var play_count = new Array();
	var albumart = new Array();
	var artist_name = new Array();
	var album_name = new Array();
	
	var top1Order = new Array();
	var top2Order = new Array();
	var top3Order = new Array();
	
	<%
	for( int i = 0; i < chartList.get(0).size(); i++ )
	{
	%>
		music_no[<%=i%>] = '<%=chartList.get(0).get(i).get("music_no")%>';
		music_name[<%=i%>] = "<%=chartList.get(0).get(i).get("music_name")%>";
		duration[<%=i%>] = <%=chartList.get(0).get(i).get("duration")%>;
		play_count[<%=i%>] = <%=chartList.get(0).get(i).get("play_count")%>;
		albumart[<%=i%>] = '<%=chartList.get(0).get(i).get("albumart")%>';
		artist_name[<%=i%>] = "<%=chartList.get(0).get(i).get("artist_name")%>";
		album_name[<%=i%>] = "<%=chartList.get(0).get(i).get("album_name")%>";
	<%
	}
	for( int i = 0; i < top1Order.size(); i++ )
	{
	%>
	top1Order[<%=i%>] = new Array();
	top1Order[<%=i%>][0] = <%=top1Order.get(i)%>;
	top1Order[<%=i%>][1] = "<%=chartList.get(i).get(top1Order.get(i)).get("music_no")%>";
	top1Order[<%=i%>][2] = "<%=chartList.get(i).get(top1Order.get(i)).get("music_name")%>";
	top1Order[<%=i%>][3] = <%=chartList.get(i).get(top1Order.get(i)).get("play_count")%>;
	
	top2Order[<%=i%>] = new Array();
	top2Order[<%=i%>][0] = <%=top2Order.get(i)%>;
	top2Order[<%=i%>][1] = "<%=chartList.get(i).get(top2Order.get(i)).get("music_no")%>";
	top2Order[<%=i%>][2] = "<%=chartList.get(i).get(top2Order.get(i)).get("music_name")%>";
	top2Order[<%=i%>][3] = <%=chartList.get(i).get(top2Order.get(i)).get("play_count")%>;
	
	top3Order[<%=i%>] = new Array();
	top3Order[<%=i%>][0] = <%=top3Order.get(i)%>;
	top3Order[<%=i%>][1] = "<%=chartList.get(i).get(top3Order.get(i)).get("music_no")%>";
	top3Order[<%=i%>][2] = "<%=chartList.get(i).get(top3Order.get(i)).get("music_name")%>";
	top3Order[<%=i%>][3] = <%=chartList.get(i).get(top3Order.get(i)).get("play_count")%>;
	<%
	}
	%>
	
	$(window).load(function() {
		
		$(".category").eq(currentClickTop3Index).trigger('click');
		$("#chart_content").css("height", <%=chartList.get(0).size() / 2 + 1%> * 70 + "px");
		
		if( <%=tab_no != null%> )
		{
			$("#chart_button").css("top", "140px");
			$("#chart_content").css("top", "200px");
		}
		
		var top3Change = setInterval(function() {
			
			currentClickTop3Index++;
			
			if( currentClickTop3Index >= 3 )
				currentClickTop3Index = 0;
			
			$(".category").eq(currentClickTop3Index).trigger('click');
			
			
		}, 3000);
		
	});
	
	
	
	
</script>

</html>