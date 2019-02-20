<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");

	String filter = request.getParameter("filter");
	String filterValue = request.getParameter("filterValue");
	String sortType = request.getParameter("sortType");

	MemberDatabase mbd = new MemberDatabase(); 
	PreferenceDatabase pd = new PreferenceDatabase();
	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	ArrayList<HashMap<String, Object>> djList = pld.getPlayList("false", "true", null);
	ArrayList<HashMap<String, Object>> todayDJList = new ArrayList<HashMap<String, Object>> ();
	ArrayList<HashMap<String, Object>> filterDJList = new ArrayList<HashMap<String, Object>> ();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd");
	Date today = new Date();
	
	for( int i = 0; i < djList.size(); i++ )
	{
		djList.get(i).put("likeCount", pd.getLikeCount("playlist", (String) djList.get(i).get("playlist_no"), null));
		djList.get(i).put("nickname", mbd.getNickname((String) djList.get(i).get("id"), null));
		djList.get(i).put("playlist_num", pmd.getPlayListMusicCount((String) djList.get(i).get("playlist_no")));
	
		String djRegistDate = sdf.format(djList.get(i).get("date"));
		
		if( djRegistDate.equals(sdf.format(today)) )
			todayDJList.add(djList.get(i));
		
		if( filter != null && !filter.equals("null") && ((String) djList.get(i).get(filter)).contains(filterValue) )
			filterDJList.add(djList.get(i));
	}
	
	if( filter != null && !filter.equals("null") )
		djList = filterDJList;
	
	if( sortType == null )
		Collections.sort(djList, new MapComparator("date"));
	else
		Collections.sort(djList, new MapComparator("likeCount"));
	
	Collections.reverse(djList);
	Collections.sort(todayDJList, new MapComparator("likeCount"));
	Collections.reverse(todayDJList);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/DJ.css" rel="stylesheet">

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/DJ.js"></script>
	
	
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="center">
        <div id="title">
            <span><b>오늘은 뭘 듣지?</b></span>
            <span id="title_sub"><b>음악 전문가 Seam DJ들의 데일리 추천음악을 감상해보세요.</b></span>
        </div>

        <div id="main_content">
            <div id="dj_search_request">
                <select id="search_select">
                    <option value="title">플레이리스트</option>
                    <option value="nickname">닉네임</option>
                </select>
                <input id="search_text" type="text" placeholder="검색어를 입력해주세요">
                <input id="search_button" type="button" value="검색">
                <input id="dj_request" type="button" value="DJ 신청하기">
            </div>

			<%
			if( todayDJList.size() > 0 )
			{
			%>

			<img src="image/today.png" id="today_img">

            <div id="today_dj">
                <div id="today_dj_content">
                    <div id="today_main_content">
                        <div id="today_main_content_img" data-no="<%=todayDJList.get(0).get("playlist_no")%>">
                            <img src="<%=todayDJList.get(0).get("image")%>">
                        </div>

                        <div id="today_main_content_content">
                            <div id="today_main_list_name" data-no="<%=todayDJList.get(0).get("playlist_no")%>"><%=todayDJList.get(0).get("title")%></div>

                            <div id="today_main_dj_name" class="move_dj" data-no="<%=todayDJList.get(0).get("id")%>"><%=todayDJList.get(0).get("nickname")%></div>
                            <div id="today_main_line"></div>
                            <div id="today_main_theme"><%=todayDJList.get(0).get("tag")%></div>
                            <div id="today_main_music_num">수록곡 : <%=todayDJList.get(0).get("playlist_num")%>곡</div>

                            <div id="today_main_like">♥ 좋아요(<%=todayDJList.get(0).get("likeCount")%>)</div>
                        </div>
                    </div>
                 
                    <div id="today_sub_content">
                    <%
                    if( todayDJList.size() > 1 )
                    {
                    	for( int i = 1; i < todayDJList.size(); i++ )
                    	{
                    		if( i == 3 ) break;
                    %>
                        <div class="today_sub_content" style="top: <%=10 + (i - 1) * 90%>px;">
                            <div class="today_sub_content_img" data-no="<%=todayDJList.get(i).get("playlist_no")%>">
                                <img src="<%=todayDJList.get(i).get("image")%>">
                            </div>

                            <div class="today_sub_content_content">
                                <div class="today_sub_list_name" data-no="<%=todayDJList.get(i).get("playlist_no")%>"><%=todayDJList.get(i).get("title")%></div>
                                <div class="today_sub_theme"><%=todayDJList.get(i).get("tag")%></div>

                                <div>
                                    <div class="today_sub_hot_icon">
                                        <img src="image/hot_icon2.png">
                                    </div>
                                    <div class="today_sub_like">♥ 좋아요(<%=todayDJList.get(i).get("likeCount")%>)</div>
                                </div>
                            </div>
                        </div>

                        <div class="today_sub_line" style="top: <%=95 + (i - 1) * 90%>px;"></div>

                        <!-- <div class="today_sub_content" style="top: 100px;">
                            <div class="today_sub_content_img">
                                <img src="image/rain.jpg">
                            </div>

                            <div class="today_sub_content_content">
                                <div class="today_sub_list_name">영화를 더 완벽하게 만들어 준 해외 OST</div>
                                <div class="today_sub_theme"></div>
                                <div>
                                    <div class="today_sub_hot_icon">
                                        <img src="image/hot_icon1.png">
                                    </div>
                                    <div class="today_sub_like">♥ 좋아요(64)</div>
                                </div>
                            </div>
                        </div>

                        <div class="today_sub_line" style="top: 185px"></div> -->
                    <%
                    	}
                    }
                    %>
                    </div>
                </div>
            <%
			}
			else
			{
            %>
            <div id="no_today_dj">
            	<span>오늘의 Seam DJ 플레이 리스트가 없습니다.</span>
           	</div>
           	
           	<%
			}
           	%>
        </div>

        <div id="dj_list">
            <div id="dj_header">
                <div id="total_count">총 <span><%=djList.size()%></span>개</div>
                <div id="dj_list_filter">
                	<%
                	if( sortType == null )
                	{
                	%>
                    <div id="order_recently" class="selected_order">최신순</div>&nbsp;|
                    <div id="order_like">인기순</div>
                    <%
                	}
                	else
                	{
                    %>
                    <div id="order_recently">최신순</div>&nbsp;|
                    <div id="order_like" class="selected_order">인기순</div>
                    <%
                	}
                    %>
                </div>
            </div>

            <div id="dj_content_list">
            	<%
            	if( djList.size() > 0 )
            	{
            		for( int i = 0; i < djList.size(); i++ )
            		{
            			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd");
            			String djRegistDate = sdf2.format(djList.get(i).get("date"));
            	%>
                <div class="dj_content">
                    <div class="dj_regist_date">
                        <div class="dj_regist_date_day">
                            <%=djRegistDate.substring(8, 10) %>
                        </div>
                        <div class="dj_regist_date_yearnmonth">
                            <%=djRegistDate.substring(0, 7) %>
                        </div>
                    </div>

                    <div class="dj_list_img" data-no="<%=djList.get(i).get("playlist_no")%>">
                        <img src="<%=djList.get(i).get("image")%>">
                    </div>

                    <div class="dj_list_content">
                        <div class="dj_list_name" data-no="<%=djList.get(i).get("playlist_no")%>"><%=djList.get(i).get("title")%></div>
                        <div class="dj_list_dj_name move_dj" data-no="<%=djList.get(i).get("id")%>"><%=djList.get(i).get("nickname")%></div>
                        <div class="dj_list_theme"><%=djList.get(i).get("tag")%></div>
                        <div class="dj_list_music_num">수록곡 : <%=djList.get(i).get("playlist_num")%>곡</div>
                    </div>

                    <div class="dj_list_like">♡ <%=djList.get(i).get("likeCount")%></div>
                </div>
                <%
	                	if( i < djList.size() - 1 )
	                	{
                %>
                	<hr>
                <%
            			}
            		}
            	}
            	else
            	{
                %>
                <div id="no_dj">
                	<span>Seam DJ 플레이 리스트가 없습니다.</span>
               	</div>
                <%
            	}
                %>
            </div>
        </div>
    </div>

    <!-- Large modal -->
    <button class="btn btn-primary" data-toggle="modal" data-target="#regist_modal" style="display: none;">DJ regist modal</button>
    <!-- Modal -->
    <div id="regist_modal" class="modal fade" role="dialog">
        <div id="regist_dialog" class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Seam DJ 신청하기</h4>
                    <div class="constraint">
                        <ul>
                            <li>Seam DJ 신청을 하기 위해 DJ플레이리스트를 아래의 항목에 맞춰 만들어야 합니다.</li>
                        </ul>
                        <ul>
                            <li style="list-style: none;"> - 테마/장르에 맞는 명확한 플레이리스트 제목, 소개글, 수록곡(10곡 이상), 플레이리스트 대표 이미지, </li>
                            <li style="list-style: none;"> &nbsp;&nbsp;마이뮤직의 프로필 이미지 등록 필수</li>
                        </ul>
                    </div>
                </div>

                <div class="modal-body">
                    <iframe src="" id="regist_iframe"></iframe>
                </div>

                <div class="modal-footer">
                    <button type="button" id="dj_regist_btn" class="btn btn-default">DJ신청하기</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    
</body>

<script>
	$(window).load(function() {
		filter = '<%=filter%>';
		filterValue = '<%=filterValue%>';
		sortType = '<%=sortType%>';
		id = '<%=id%>';
	});
	
</script>

</html>	