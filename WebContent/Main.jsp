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
	
	String id = (String) session.getAttribute("id");
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
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/rangeSlider.css" rel="stylesheet">
	<link href="css/Main.css" rel="stylesheet">
	
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/rangeSlider.js"></script>
	<script src="js/arrayList.js"></script>
	<script src="js/Main.js"></script>
	
	<!-- <script src="https://cdn.jsdelivr.net/jquery/1.11.3/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/jquery.roundslider/1.3/roundslider.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/jquery.roundslider/1.3/roundslider.min.js"></script> -->
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id='background_image'>
		<img src="" />
    </div>
	<!-- ----------------------------------------- *header ---------------------------------------- -->
    <header>
        <div id="mode">
            <div id="mode_buttonspace">
                <div class="onoff" id="modebox">
                    <b><span id="onoff_on">OFF</span>
                    <span id="onoff_off">ON</span></b>
                </div>
                <div class="onoff" id="modebutton"></div>
            </div>
            <span id="modetext"><b>PLAYER</b></span>
        </div>
        <!-- 추가~ -->
        <div class='radio_on' id="mode_none">
        </div>
        <!-- ~추가 -->

        <div id="logo">
        	<a href="javascript:void(0);" onclick="$('article iframe').attr('src', 'MainContent.jsp');">
            	<img src="image/logo.png"/>
           	</a>
        </div>

        <div id="search">
            <input class="logo_reset" type="text" placeholder="인기 키워드 '볼빨간 사춘기'">
            <input type="image" src="image/search_icon.svg">
        </div>
    </header>
    
    <!-- ------------------------------------------ *nav ------------------------------------------ -->

    <nav>
        <iframe src="LoginForm.jsp" id="login_form"></iframe>

        <div id="menu_box">
        	
            <div class="menu" id="menu_chart" onclick="$('article iframe').attr('src', 'Chart.jsp');">
                <div class="menu_icon">
                    <img src="image/menu_chart.svg">
                </div>
                <div class="menu_name">
                    CHART
                </div>
            </div>
           
            <div class="menu" id="menu_latest"  onclick="$('article iframe').attr('src', 'NewMusic.jsp');">
                <div class="menu_icon">
                    <img src="image/menu_latest.svg">
                </div>
                <div class="menu_name">
                    NEW MUSIC
                </div>
                <div class="bottom_line"></div>
            </div>

            <div class="menu" id="menu_seamdj"  onclick="$('article iframe').attr('src', 'DJ.jsp');">
                <div class="menu_icon">
                    <img src="image/menu_seamdj.svg">
                </div>
                <div class="menu_name">
                    &nbsp;SEAM DJ
                </div>
                <div class="bottom_line"></div>
            </div>

            <div class="menu" id="menu_radio" >
                <div class="menu_icon">
                    <img src="image/menu_radio.svg">
                </div>
                <div class="menu_name">
                    RADIO
                </div>
                <div class="bottom_line"></div>
            </div>

            <div class="menu" id="menu_mypage"> <!-- onclick="$('article iframe').attr('src', 'making.html');" -->
                <div class="menu_icon">
                    <img src="image/menu_mypage.svg">
                </div>
                <div class="menu_name">
                    &nbsp;MY PAGE
                </div>
                <div class="bottom_line"></div>
            </div>
        </div>

        <div id="menu_payment">
            <B><a id="menu_buy" target="search_iframe">
                이용권 구매&nbsp;
            </a>
            <a id="menu_l">&nbsp;|&nbsp;</a>
            <a id="menu_pay" target="search_iframe">
                &nbsp;정기 결제
            </a></B>
        </div>
    </nav>
    
    <!-- ------------------------------------------ *join ----------------------------------------- -->
    <form>
	    <div id="join">
	        <div id="join_box">
	            <div id="necessaryElement">
	                <div class="elementName">
	                    <span>필수입력사항</span>
	                </div>
	                <div class="elementText">
	                    <span class="elementText_name">이름</span>
	                    <span class="elementText_name">아이디</span>
	                    <span class="elementText_name">비밀번호</span>
	                    <span class="elementText_name">비밀번호 확인</span>
	                    <span class="elementText_name">닉네임</span>
	                    <span class="elementText_name">휴대폰 번호</span>
	                    <span class="elementText_name">이메일</span>
	                </div>
	                <div class="elementInput">
	                    <input type="text" required=""/>
	                    <input type="text" required=""/>
	                    <input type="password" required=""/>
	                    <input type="password" required=""/>
	                    <input type="text" required=""/>
	                    <input type="tel" required=""/>
	                    <input type="tel" required=""/> 
	                    <input type="tel" required=""/>
	                    <input type="email" required=""/>
	                    <input type="email" required=""/>
	                    <span>-</span>
	                    <span>-</span>
	                    <span>@</span>
	                </div>
	            </div>
	            <div id="selectiveElement">
	                <div class="elementName">
	                    <span>선택입력사항</span>
	                </div>
	                <div class="elementText">
	                    <span class="elementText_name">성별</span>
	                    <span class="elementText_name">생일</span>
	                    <span class="elementText_name">직업</span>
	                    <span class="elementText_name">주소</span>
	                    <span class="elementText_name">상세주소</span>
	                </div>
	                <div class="elementInput">
	                    <input type="radio"/>
	                    <input type="radio"/>
	                    <input type="number"/>
	                    <input type="month"/>
	                    <input type="date"/>
	                    <input type="text"/>
	                    <input type="text"/>
	                </div>
	            </div>
	            <input type="submit" value="회원가입완료">
	        </div>
	    </div>
    </form>
    
    <!-- ---------------------------------------- *article ---------------------------------------- -->

    <article>
        <iframe src="<%=mainPageName%>" name="search_iframe"></iframe>
    </article>
    
     <!-- ----------------------------------------- *aside ----------------------------------------- -->

    <aside id="web_listmenu">
        <div id="list_header"><span><b>현재재생목록</b></span></div>
        <div id="song_list"></div>
        <div id="list_footer">
            <div id="total_time"></div>
            <div id="sub_buttons">
                <div class="list_sub_button"><a href="http://www.naver.com">담기</a></div>
                <div class="list_sub_button"><a href="http://www.naver.com">삭제</a></div>
            </div>
        </div>
    </aside>
    
    <!-- ----------------------------------------- *footer ---------------------------------------- -->

    <footer>
        <div id="song_albumart">
            <img src="">
        </div>

        <div id="footer_buttonbox2">
            <div class="song_icon" id="song_pre">
                <img src="image/pre_icon.png">
            </div>

            <div class="song_icon" id="song_current">
                <img src="image/play_icon.png">
            </div>

            <div class="song_icon" id="song_next">
                <img src="image/next_icon.png">
            </div>
        </div>
        
        <div id="song_info">
            <span class="slash">&nbsp;<br></span>
            <span class="info_singer"></span>
        </div>

		<span class='song_time' id="song_current_time"></span>&nbsp

        <div id="song_progress">
            <input id="song_progress_bar" type="range" data-rangeSlider>
        </div>
        
        <span class='song_time' id="song_total_time"></span>

        <div id="footer_buttonbox">
            <div class="song_icon" id="song_volume">
                <img src="image/volume_icon.png">
            </div>
            <div class="song_icon" id="song_loop">
                <img src="image/loop_all.png">
            </div>
            <div class="song_icon" id="song_lyrics">
                <img src="image/lyrics.png">
            </div>
        </div>

        <div class="song_icon" id="song_menu">
            <div class="listmenu">
                <img src="image/song_menu.png">
            </div>
        </div>

        <div class="playbox_side2" id="playbox_pre2">
            <div class="playbox2_album">
                <img src="">
            </div>
            <div class="playbox2_music">
                <span><b></b></span>
            </div>
            <div class="playbox2_singer">
                <span><b></b></span>
            </div>
        </div>

        <div class="playbox_side2" id="playbox_next2">
            <div class="playbox2_album">
                <img src="">
            </div>
            <div class="playbox2_music">
                <span><b></b></span>
            </div>
            <div class="playbox2_singer">
                <span><b></b></span>
            </div>
        </div>

        <div class="playbox_side1" id="playbox_pre1">
            <div class="playbox1_album">
                <img src="">
            </div>
            <div class="playbox1_music">
                <span><b></b></span>
            </div>
            <div class="playbox1_singer">
                <span><b></b></span>
            </div>
        </div>

        <div class="playbox_side1" id="playbox_next1">
            <div class="playbox1_album">
                <img src="">
            </div>
            <div class="playbox1_music">
                <span><b></b></span>
            </div>
            <div class="playbox1_singer">
                <span><b></b></span>
            </div>
        </div>

        <div class="playbox" id="playbox_current">
            <div class="playbox_album">
                <img src="">
            </div>
            <div class="playbox_music">
                <span><b></b></span>
            </div>
            <div class="playbox_singer">
                <span><b></b></span>
            </div>
        </div>

        <!-- 추가~ -->
        <div class='radio_on' id="play_radio">
            Radio 기능이 실행 중입니다.
        </div>
        <!-- ~추가 -->
    </footer>

    <div id="volumeset">
            <input id="volume_progress_bar" type="range">
            <div id="volume_fill"></div>
    </div>

    <div id='lyrics_box'>
        <div id="lyrics_albumart">
            <img src="" />            
        </div>
        <div id="lyrics_info">
            <span id="lyrics_music"></span><br>
            <span id="lyrics_singer"></span>
        </div>
        <div id='lyrics'>

        </div>
    </div>

    <!-- ---------------------------------- mobile ---------------------------------- -->

    <header class="mobile">
        <div id="m_top">
            <img class="m_btnmenu" src="image/nav_menu_open.png">
            <a class="m_btnlogo" href="MainContent.jsp" target="search_iframe">
                <img src="image/logo.png">
            </a>
            <input type="image" class="m_btnsearch" src="image/search_icon.png">
            <div id="m_searchbox">
                <input class="input" type="text" placeholder="검색">
            </div>
        </div>
    </header>
    <div id="song_player">
        <div id="playbox_logo">
            <img src="image/logo.png" >
        </div>
        <div class="playbox_album">
                <img src="">
        </div>
        <div class="m_lyrics_box">
            <span>
                그림 같은 집이 뭐 별거겠어요<br>
                어느 곳이든 그대가 있다면 그게 그림이죠<br><br>

                빛나는 하루가 뭐 별거겠어요<br>
                어떤 하루던 그대 함께라면 뭐가 필요하죠<br><br>

                나 그대가 있지만 힘든 세상이 아니라<br>
                힘든 세상 이지만 곁에 그대가 있음을 깨닫고<br> 
                또 감사해요 또 기도해요<br>
                내 곁에서 변치 않고 영원하길 기도 드리죠<br><br>

                무려 우리 함께 눈뜨는 아침과<br>
                매일 그댈 만나 돌아오는 집 앞<br>
                나 만의 그대, 나의 그대, 내겐 사치라는걸<br><br>

                과분한 입맞춤에 취해 잠이 드는 일<br>
                그래 사치, 그댄 사치, 내겐 사치<br><br>

                행복이란 말이 뭐 별거겠어요<br>
                그저 그대의 잠꼬대 마저 날<br>
                기쁘게 하는데<br><br>

                사랑이란 말이 뭐 별거겠어요<br>
                그저 이렇게 보고만 있어도<br>
                입에서 맴돌죠<br><br>

                나 그대가 있지만 거친 세상이 아니라<br>
                거친 세상 이지만 내겐 그대가 있음을 깨닫고<br> 
                또 다짐하죠 또 약속하죠<br>
                그대 곁에 변치않고 영원하길 약속할게요<br><br>

                무려 우리 함께 눈뜨는 아침과<br>
                매일 그댈 만나 돌아오는 집 앞<br>
                나 만의 그대, 나의 그대, 내겐 사치 라는걸<br><br>

                과분한 입맞춤에 취해 잠이 드는 일<br>
                그래 사치, 그댄 사치, 내겐 사치<br><br>

                내가 상상하고 꿈꾸던 사람 그대<br>
                정말 사랑하고 있다고 나 말 할 수 있어서<br>
                믿을 수 없어, 정말 믿을 수 없어<br>
                내가 어떻게 내가 감히 사랑할 수 있는지 말야<br><br> 

                무려 우리 함께 잠드는 이 밤과<br>
                매일 나를 위해 차려진 이 식탁<br>
                나 만의 그대, 나의 그대, 내겐 사치 라는걸<br><br>

                과분한 입맞춤에 취해 잠이 드는 일<br>
                그래 사치, 그댄 사치, 내겐 사치<br>
            </span>
            <div id="m_lyrics_close">
                <img src="image/cancel.png">
            </div>
        </div>
        <div class="playbox" id="m_playbox">
            <div class="playbox_music">
                <span></span>
            </div>
            <div class="playbox_singer">
                <span></span>
            </div>
        </div>

        <div class="playbox_tag" id="tag_like">
            <span>♡2,584</span>
        </div>
        <div class="playbox_tag" id="tag_lyrics">
            <span>가사</span>
        </div>

        <div id="song_playerclose">
            <img src="image/cancel.png">
        </div>
    </div>
    
    <audio>
        <source id="audio_main">
    </audio>

    
    <!-- Large modal -->
    <button class="btn btn-primary" data-toggle="modal" data-target="#regist_modal" style="display: none;">Login modal</button>
       <!-- Modal -->
    <div id="regist_modal" class="modal fade" role="dialog">

        <div id="regist_dialog" class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Seam Music 회원가입</h4>
                </div>

                <div class="modal-body">
					<iframe src="Regist.jsp" id="regist_iframe"></iframe>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>

        <!-- *********************** 추가~ *********************** -->
        <div id="radio_dialog" class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Seam Radio</h4>
                </div>

                <div class="modal-body">
					<iframe src="Radio.jsp" id="radio_iframe"></iframe>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
        <!-- *********************** ~추가 *********************** -->
        
        <div id="pay_dialog" class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Seam 결제하기</h4>
                </div>

                <div class="modal-body">
                    <iframe src="" id="pay_iframe"></iframe>
                </div>

                <div class="modal-footer">
                	<button type="button" id="pay_btn" class="btn btn-default">결제하기</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
   	</div>
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	<!-- Large modal -->
    <!-- <button id="pay_button" class="btn btn-primary" data-toggle="modal" data-target="#pay_modal" style="display: none;">pay modal</button> -->
    <!-- Modal -->
    <!-- <div id="pay_modal" class="modal fade" role="dialog"> -->
        
    <!-- </div> -->
    
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
	
	function refreshPage() {
		// window.location.reload(true);	// 서버에서 강제로 페이지를 다시가져옴
		
		var main_page = 0;
		
		if( $("article iframe").attr("src") == 'MainContent.jsp' )
			main_page = 0;
		else if( $("article iframe").attr("src") == 'Chart.jsp' )
			main_page = 1;
		else if( $("article iframe").attr("src") == 'NewMusic.jsp' )		// lately
			main_page = 2;
		else if( $("article iframe").attr("src") == 'DJ.jsp' )
			main_page = 3;
		else if( $("article iframe").attr("src") == 'Radio.jsp' )
			main_page = 4;
		else if( $("article iframe").attr("src") == 'MyPage.jsp' )		// myPage
			main_page = 0;
			
		location.replace("Main.jsp?main_page=" + main_page);
	}
	
	$(document).ready(function() {
		$("#menu_mypage").click(function() {
			<%
			if( id != null )
			{
			%>
				$('article iframe').attr('src', 'MyPage.jsp');
			<%
			}
			else
				out.println("alert('로그인을 해주세요'); $('#login_form')[0].contentWindow.$('.logo_reset').eq(0).focus();");
			%>
		});
		
		$("#menu_payment b a").click(function() {
			<%
			if( id != null )
			{
			%>
				$("#pay_iframe").attr("src", "Pay.jsp");
				$('#pay_dialog').show();
		        $('#regist_dialog').hide();
		        $('#radio_dialog').hide();
		        registShow();
			<%
			}
			else
				out.println("alert('로그인을 해주세요'); $('#login_form')[0].contentWindow.$('.logo_reset').eq(0).focus();");
			%>
		});
	});
	
</script>

</html>	