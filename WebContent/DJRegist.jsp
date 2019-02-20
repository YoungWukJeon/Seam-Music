<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");
	
	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	ArrayList<HashMap<String, Object>> playList = pld.getPlayList("false", "false", id);
	
	for( int i = 0; i < playList.size(); i++ )
		playList.get(i).put("playlist_num", pmd.getPlayListMusicCount((String) playList.get(i).get("playlist_no")));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/DJRegist.css" rel="stylesheet">

    <script src="js/jquery.js"></script>
    <script src="js/DJRegist.js"></script>
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="center">
        <form id="dj_regist_form" method=post action="DJRegistProc.jsp" enctype="multipart/form-data">
            <div id="info">
                <div id="info_header">
                    <span>&nbsp;&nbsp;정보 입력</span>
                    <span id="essential_content" style="font-size: 12px;">
                        <img src="image/check_icon.png">
                        표시 필수입력사항
                    </span>
                </div>

                <div id="info_content">
                    <div id="info_box">
                        <div id="playlist_img">
                            <img src="image/white_background.png">
                        </div>

                        <div id="playlist_content">
                            <div id="playlist_name">
                                <div id="playlist_name_header">
                                    <img src="image/check_icon.png"> 제목
                                </div>
                                <input type=text maxlength="40" name="title" class="text_check" placeholder=" 플레이리스트의 제목을 정해주세요.">
                                <div id="playlist_name_num" class="text_num_checker">
                                    <span>0</span> / 40자
                                </div>
                            </div>
                            <div id="playlist_theme">
                                <div id="playlist_theme_header">
                                    <img src="image/check_icon.png"> 테마/장르
                                </div>

                                <input type=text name="tag" placeholder=" #테마1 #테마2 ...">

                                <select name="genre">
                                    <option value="no_select">no select</option>
                                    <option value="Ballad">Ballad</option>
                                    <option value="R&B Soul">R&B Soul</option>
                                    <option value="POP">POP</option>
                                    <option value="Hip-hop">Hip-hop</option>
                                </select>
                            </div>
                            <div id="playlist_img_upload">
                                <div id="playlist_img_header">대표 이미지</div>
                                <div class="filebox">
                                    <input class="upload-name" value="사진을 넣어주세요" disabled="disabled">
                                    <label>
                                        <input type="file" name="image" class="upload-hidden" accept="image/jpeg, image/png, image/gif" onchange="loadFile(this);">
                                        이미지 등록
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="select">
                <div id="select_header">
                    <span>&nbsp;&nbsp;플레이리스트 선택하기 (<%=playList.size()%>)</span>
                    <div>* 수록곡이 10곡 이상인 항목만 선택가능</div>
                </div>

                <div id="select_playlist_column">
                    <span id="radiobtn_title"></span>
                    <span id="playlist_title">플레이리스트 명</span>
                    <span id="playlist_num">수록곡 수</span>
                </div>

                <div id="select_content">
                    <div id="select_playlist_content">
                    
                    <%
                    for( int i = 0; i < playList.size(); i++ )
                    {
                    	if( (Integer) playList.get(i).get("playlist_num") >= 10 )
                    	{
                    %>
                        <div class="select_playlist_content">
                            <span class="radiobtn">
                                <input type="radio" value="<%=playList.get(i).get("playlist_no")%>" name="playlist">
                            </span>
                            <span class="playlist_name"><%=playList.get(i).get("title")%></span>
                            <span class="playlist_num"><%=playList.get(i).get("playlist_num")%></span>
                        </div>
						<%
                    	}
                    	else
                    	{
						%>
                        <div class="select_playlist_content non_selected_playlist">
                            <span class="radiobtn">
                                <input type="radio" value="000004" name="<%=playList.get(i).get("playlist_no")%>" disabled>
                            </span>
                            <span class="playlist_name"><%=playList.get(i).get("title")%></span>
                            <span class="playlist_num"><%=playList.get(i).get("playlist_num")%></span>
                        </div>
					<%
                    	}
					%>
						<div class="playlist_line"></div>
					<%
                    }
					%>
                        
                    </div>
                </div>
            </div>

            <div id="intro">
                <div id="intro_header">
                    <span>&nbsp;&nbsp;소개글 입력</span>
                </div>

                <div id="intro_content">
                    <div id="intro_main">
                        <textarea maxlength="1000" class="text_check" name="intro"></textarea>
                    </div>
                    <div id="intro_sub">
                        <div id="intro_num" class="text_num_checker">
                            <span>0</span> / 1000자
                        </div>
                    </div>
                </div>
            </div>

            <div id="rule">
                <div id="rule_header">
                    <span>&nbsp;&nbsp;Seam DJ 이용약관 동의</span>
                </div>

                <div id="rule_content">
                    <div id="rule_box">
                        <li>* Seam DJ 신청을 위해서 먼저 약관동의를 해주세요.</li>
                        <br>
                        <strong>제1조 (목적)</strong>
                        <li>이 약관은 회원이 Seam Company(이하 “회사”라 합니다.)에서 제공하는 유무선 인터넷 음악서비스인 Seam 서비스 중 ‘Seam DJ’ 서비스를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항 등 기본적인 사항을 규정함을 목적으로 합니다.</li>
                        <br>
                        <strong>제2조 (서비스의 이용)</strong>
                        <li>1. ‘Seam DJ’는 선곡 리스트와 이를 소개하는 글로 이루어진 플레이리스트(이하 “DJ플레이리스트”이라고 합니다.)를 제작하여 회원간 음악을 추천 및 공유하는 서비스입니다.</li>
                        <li>2. 회원은 회사가 Seam  서비스에 제공하는 특정 절차를 거쳐 “DJ플레이리스트”을 제작할 수 있는 DJ(이하 “DJ”라고 합니다)를 신청할 수 있으며, 회사는 회원이 제출한 신청 정보를 토대로 “DJ”의 승인 여부를 결정합니다.</li>
                        <br>
                        <strong>제3조 (서비스의 제한)</strong>
                        <li>다음에 해당하는 경우 회사는 회원의 DJ권한을 제한하거나, 회원이 제작한 “DJ플레이리스트”를 비공개 혹은 삭제 처리하는 등 서비스 이용을 제한할 수 있습니다.</li>
                        <li>- 욕설, 비속어, 성인용 등의 미풍양속에 위배되는 내용 및 이미지를 게시하는 경우.</li>
                        <li>- Seam 이용약관 및 관계법령에 위반되는 경우.</li>
                        <li>- 주제와 부합하지 않게 “DJ플레이리스트”를 게시한 경우.</li>
                        <li>- 기타 운영자 판단에 의해 서비스 이용 제재가 필요한 경우.</li>
                        <br>
                        <strong>제4조 (게시물의 이용 범위)</strong>
                        <li>1. 회원은 자신이 제작한 “DJ플레이리스트”에 대하여 회사가 서비스를 운영, 전시, 전송 배포 또는 홍보하기 위한 목적으로 사용료 없는 비독점적 사용권을 회사에게 부여합니다. 사용권은 다음과 같고 사용권 부여는 회사가 서비스를 운영하는 동안 유효하며, 회원의 탈퇴 후에도 유효합니다.</li>
                        <li>2. 서비스의 원활한 운영을 위해, 회사에 의해 다음 메뉴에 등록된 “DJ플레이리스트”의 경우 삭제 또는 편집이 불가할 수 있으며, 회원 탈퇴 시에는 서비스가 지속되는 기간 동안 영구 보관됩니다. 이를 원치 않는 회원은 탈퇴 전 직접 삭제하거나, 탈퇴일로부터 15일 이내에 Seam 고객지원센터로 삭제 요청을 할 수 있습니다.</li>
                        <br>
                        <li>- Seam DJ 메뉴 내 ‘오늘은 뭘 듣지’, ‘명예의 전당’, ‘DJ플레이리스트 차트’, ‘DJ매거진’에 등록된 DJ플레이리스트.</li>
                        <br>
                        <strong>제5조 (Seam 이용약관과의 관계)</strong>
                        <li>1. Seam DJ 서비스 이용에 관한 제반 사항은 ‘Seam DJ 이용약관’에서 별도의 언급이 없는 한 ‘Seam 이용약관’을 따릅니다. </li>
                        <li>2. 본 약관과 Seam 이용약관의 내용이 충돌하는 경우, 본 약관의 내용이 우선하며 본 약관에 명시되지 않은 사항에 대해서는 Seam 이용약관에 의하고, Seam 서비스 약관에 규정되지 않은 사항은 관련 법령 및 상관습에 의합니다. 끝.</li>
                    </div>
                    <div id="rule_agree">
                        <label>
                            <input type="checkbox">
                            <span>Seam DJ 이용약관에 동의합니다.</span>
                        </label>

                        <button type=button>전문보기</button>
                    </div>
                </div>
            </div>

            <div id="dj_regist_intro">
                <ul>
                    <li>제작하신 DJ플레이리스트와 Seam 활동 이력을 토대로 심사한 후 일주일 이내로 결과를 알려드릴 예정입니다.</li>
                    <li>승인이 되면 Seam 소식에서 확인하실 수 있습니다.</li>
                </ul>
            </div>
            
            <input type="button" id="submit_btn" style="display: none;">
        </form>
    </div>
    
</body>

<script>

	
</script>

</html>	