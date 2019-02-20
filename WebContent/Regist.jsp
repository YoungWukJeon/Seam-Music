<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html"%> --%>
<%@ page import="java.util.*"%>
<%@ page import="Seam.*"%>


<%
	request.setCharacterEncoding("utf-8");
	
	String complete_page = request.getParameter("complete_page");
	
	if( complete_page == null )
		complete_page = "false";
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>

	<link href="css/Regist.css" rel="stylesheet">

	<script src="js/jquery.js"></script>
    <script src="js/Regist.js"></script>

</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
    <center>
        <form method=post action="RegistProc.jsp?requestType=submit" id="regist_form" enctype="multipart/form-data">
            <!-- <div id="logo">
                <img src="image/logo2.png">
            </div>

            <div id="regist_title">
                회원가입
            </div> -->

            <div id="step">
                <div class="selected_step" style="left: 0;">
                    <span>I. 본인인증 및 약관</span>
                </div>
                <div class="non_selected_step" style="left: 350px;">
                    <span>II</span>
                </div>
                <div class="non_selected_step" style="left: 400px;">
                    <span>III</span>
                </div>
                <div class="non_selected_step" style="left: 450px;">
                    <span>IV</span>
                </div>
            </div>

            <div id="content">
                <div class="content_body">
                    <div id="cert">
                        <div id="cert_method">
                            <a href="javascript:void(0)" class="selected_method">
                                <span>휴대폰 인증 가입</span>
                            </a>
                            <a href="javascript:void(0)" class="non_selected_method">
                                <span>이메일 인증 가입</span>
                            </a>
                        </div>

                        <p>입력한 휴대폰 번호로 인증 후 회원가입 됩니다.</p>

                        <div id="cert_name">
                            <div class="column_name">이름</div>
                            <div id="name_input">
                                <input type=text class="cancel_input" placeholder="이름을 입력해주세요.">
                                <a href="javascript:void(0)" class="cancel_btn">
                                    <img src="image/regist_close_btn.png">
                                </a>
                            </div>
                        </div>

                        <div id="cert_phone">
                            <div class="column_name">휴대폰번호</div>
                            <div id="phone_input">
                                <input type=text minlength="5" maxlength="11" class="num_input cancel_input" placeholder="'-'를 제외하고 숫자만 입력해주세요.">
                                <a href="javascript:void(0)" class="cancel_btn">
                                    <img src="image/regist_close_btn.png">
                                </a>
                            </div>
                        </div>

                        <div id="cert_email">
                            <div class="column_name">이메일</div>
                            <div id="email_input">
                                <input type=text maxlength=30 class="cancel_input" placeholder="이메일 입력란">
                                <a href="javascript:void(0)" class="cancel_btn">
                                    <img src="image/regist_close_btn.png">
                                </a>
                                <select>
                                    <option value="">@선택</option>
                                    <option value="naver.com">@naver.com</option>
                                    <option value="gmail.com">@gmail.com</option>
                                    <option value="nate.com">@nate.com</option>
                                    <option value="daum.net">@daum.net</option>
                                </select>
                            </div>
                        </div>

                        <div id="cert_number">
                            <div class="column_name">인증번호</div>
                            <div id="number_input">
                                <input type=text maxlength=6 class="cancel_input" placeholder="인증번호 6자리 입력">
                                <a href="javascript:void(0)" class="cancel_btn">
                                    <img src="image/regist_close_btn.png">
                                </a>
                            </div>
                            <a href="javascript:void(0)">
                                <div>인증번호<br>요청</div>
                               
                            </a>
                        </div>
                    </div>

                    <div id="rules">
                        <div id="all_agree">
                            <label>
                                <input type="checkbox">전체동의<span>&nbsp;(선택사항 포함)</span>
                            </label>
                        </div>

                        <div id="agree">
                            <div class="rule">
                                <label>
                                    <input type="checkbox">이용약관<span class="essential_rule">&nbsp;(필수)</span>
                                </label>

                                <div class="open_btn" style="left: 150px;">
                                    <img src="image/regist_open_btn.png">
                                </div>

                                <div class="terms" style="right: 5px;">
                                    <span>전문보기</span>
                                    <img src="image/regist_detail_btn.png">
                                </div>

                                <div class="rule_content" style="display:none;">
                                    <div>
                                        <strong>1. 이용신청의 승낙 및 제한(약관 제7조, 제8조)</strong>
                                        <li> - 가입신청 양식을 정확히 기재하고, 회사가 정한 인증절차를 완료한 고객에 한하여 서비스 이용신청 승낙.</li>
                                        <li> - 회사가 정한 사유에 의해 이용신청에 대한 거절 또는 승낙 유보 등 가입을 제한하거나 사안의 경중에 따라 손해배상 청구 가능</li>
                                        <li> - 회원의 자격 및 나이에 따라 서비스 이용 일부 제한 가능.</li>
                                        <strong>2. 서비스 이용(약관 제13조, 제15조, 제17조)</strong>
                                        <li> - 회사는 상당한 이유가 있는 경우 운영상, 기술상 필요에 따라 서비스 변경가능, 이 경우 변경될 서비스의 내용 및 제공일자를 정한 방법으로 회원에게 통지 후 서비스의 전부 또는 일부를 일시적으로 제한하거나 중지 가능.</li>
                                        <li> - 회원이 게시하거나 전달하는 서비스의 내용물이 회사가 정한 게시물 제한 사유에 해당한다고 판단되는 경우 사전통지 없이 게시물 삭제 가능하며, 이에 대해 회사는 어떠한 책임도 지지 않음.</li>
                                        <li> - 회원이 게시한 게시물의 저작권은 회원이 소유, 회사는 서비스 내에 게시물을 게시할 수 있는 권리를 가지며, 회원의 동의 없이 게시물을 다른 목적으로 사용할 수 없음.</li>
                                        <strong>3. 계약해지 및 이용제한(약관 제25조)</strong>
                                        <li> - 서비스 이용계약을 해지하고자 할 경우 본인이 서비스 사이트상 또는 전화 등 회사가 제공하는 방법으로 해지신청을 해야 함. 회사는 회원의 유료서비스 청약철회, 환불, 계약의 해지와 관련 회사의 “멜론 유료서비스약관”에 그 절차 및 제반 사항을 안내함.</li>
                                        <li> - 회원이 계약을 해지할 경우 개인정보처리방침에 따라 회사가 회원정보를 보유하는 경우를 제외하고, 회원의 모든 개인정보 및 데이터는 삭제됨.</li>
                                    </div>
                                </div>
                            </div>

                            <div class="rule">
                                <label>
                                    <input type="checkbox">유료서비스약관<span class="essential_rule">&nbsp;(필수)</span>
                                </label>

                                <div class="open_btn" style="left: 200px;">
                                    <img src="image/regist_open_btn.png">
                                </div>

                                <div class="terms" style="right: 5px;">
                                    <span>전문보기</span>
                                    <img src="image/regist_detail_btn.png">
                                </div>

                                <div class="rule_content" style="display:none;">
                                    <div>
                                        <strong>1. 회원의 유료서비스 예약 변경, 즉시 변경 등(약관 제16조)</strong>
                                        <li> - 구매/가입한 이용권 회사가 정하는 이용권에 한하여 회원이 변경 신청을 할 경우, 구매/가입 1개월 후 예약변경 또는 즉시변경 가능.</li>
                                        <li> - 예약변경의 경우, 변경 요청한 달의 이용기간이 만료되는 날까지 기존이용권 이용이 가능하며, 이용기간 만료일 익일부터 변경 요청 이용권으로 변경 적용. 즉시변경의 경우, 변경 신청 시 회사가 접수 완료 후 3일 이내 기존이용권의 이용을 중단하고 신청한 이용권으로 변경.</li>
                                        <li> - 모든 이용권의 예약변경 및 무제한다운로드 이용권의 즉시변경의 경우, 환불 불가.</li>
                                        <li> - 이용권의의 즉시변경의 경우(변경 전 이용권이 다운로드 전용이용권/복합이용권인 경우, 변경 전 이용권이 음악감상 전용이용권인 경우), 회원의 즉시변경 신청 적용일 현재 변경 전 이용권에 잔여 금액이 있을 경우, 차액만큼 회원에게 반환하거나 추가결제 가능.</li>
                                        <li> - 기간만료형 다운로드 전용이용권/복합이용권을 이용 중인 회원이 타 이용권으로 즉시변경 신청한 경우, 회사의 변경 처리일부터 기존 이용 중인 이용권의 요청 당월 다운로드 가능 잔여 곡 수는 즉시 소멸, 회사는 이 사실을 회원에게 변경신청 절차 중에 고지하고 변경신청 계속 여부를 확인해야 함.</li>
                                        <strong>2. 청약 철회 및 서비스 이용계약의 해제ㆍ해지(약관 제17조)</strong>
                                        <li> - 유료회원은 해당 유료서비스 또는 이용권을 전혀 사용하지 아니하였을 경우에 한하여 결제일로부터 7일 이내에 결제 취소(청약 철회) 요청 가능.</li>
                                        <li> - 단, 유료회원은 해당 유료서비스 또는 이용권의 내용이 표시ㆍ광고 내용과 다르거나 계약 내용과 다르게 이행된 경우에는 해당 콘텐츠를 공급받은 날로부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날로부터 30일 이내에 청약철회 가능.</li>
                                        <strong>3. 유료서비스의 정지, 중단(약관 제19조)</strong>
                                        <li> - 회사는 이용자에 대한 서비스 개선 목적으로 하는 설비 점검 및 보수 시 멜론캐쉬 및 유료서비스의 전부 또는 일부의 제공을 제한, 중지, 중단 가능. 이 경우 사전에 회원에게 공지해야 하며, 불가피한 경우에는 경위와 원인이 확인된 즉시 사후에 공지할 수 있음.</li>
                                        <li> - 회사의 귀책사유로 서비스의 제공이 중단됨으로 인하여 회원이 입은 손해에 대하여 콘텐츠이용자보호지침에서 정하는 바에 따라 배상.</li>
                                        <li> - 다만, 천재지변 등 불가항력으로 인한 경우 아래 이용중지 또는 장애발생 시간에 산입하지 아니함.</li>
                                        <li> - 또한, 회사가 정한 항목을 적용함에 있어 사전고지는 서비스 중지, 장애시점을 기준으로 24시간 이전에 고지된 것에 한함.</li>
                                    </div>
                                </div>
                            </div>

                            <div class="rule">
                                <label>
                                    <input type="checkbox">개인정보 수집 및 이용<span class="essential_rule">&nbsp;(필수)</span>
                                </label>

                                <div class="open_btn" style="left: 250px;">
                                    <img src="image/regist_open_btn.png">
                                </div>

                                <div class="terms" style="right: 5px;">
                                    <span>전문보기</span>
                                    <img src="image/regist_detail_btn.png">
                                </div>

                                <div class="rule_content" style="display:none;">
                                    <div>

                                    </div>
                                </div>
                            </div>

                            <div class="rule">
                                <label>
                                    <input type="checkbox">이벤트, 서비스안내 수신<span class="optionative_rule">&nbsp;(선택)</span>
                                </label>

                                <div class="open_btn" style="left: 260px;">
                                    <img src="image/regist_open_btn.png">
                                </div>

                                <div class="rule_content" style="display:none;">
                                    <div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="essential_info" class="content_body" style="display: none;">
                    <div id="regist_id">
                        <div class="column_name">아이디</div>
                        <div id="id_input">
                            <input type=text name="regist_id" maxlength=20 minlength=5 class="cancel_input" placeholder="아이디를 입력해주세요.">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                        </div>
                        <a href="javascript:void(0)">
                            <div id="id_checker">중복확인</div>
                        </a>
                    </div>

                    <div id="regist_passwd">
                        <div class="column_name">비밀번호</div>
                        <div id="passwd_input">
                            <input type=password name="regist_passwd" maxlength=20 minlength=5 class="cancel_input" placeholder="비밀번호를 입력해주세요.">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>

                            <div id="passwd_view">보기</div>
                        </div>
                    </div>

                    <div id="regist_passwd_conf">
                        <div class="column_name">&nbsp;</div>
                        <div id="passwd_conf_input">
                            <input type=password maxlength=20 minlength=5 class="cancel_input" placeholder="비밀번호를 입력해주세요.">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>

                            <div id="passwd_conf_view">보기</div>
                        </div>
                    </div>

                    <div id="regist_name">
                        <div class="column_name">이름</div>
                        <div id="regist_name_input">
                            <input type=text name="regist_name" readonly>
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                        </div>
                    </div>

                    <div id="regist_nickname">
                        <div class="column_name">닉네임</div>
                        <div id="nickname_input">
                            <input type=text name="regist_nickname" class="cancel_input" minlength="2" maxlength="10" placeholder="닉네임을 입력해주세요.">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                        </div>
                        <a href="javascript:void(0)">
                            <div id="nickname_checker">중복확인</div>
                        </a>
                    </div>

                    <div id="regist_phone">
                        <div class="column_name">휴대폰번호</div>
                        <div id="regist_phone_input">
                            <input type=text name="regist_phone" maxlength="11" minlength="11" placeholder="'-'를 제외하고 숫자만 입력해주세요." class="num_input">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                        </div>
                    </div>

                    <div id="regist_email">
                        <div class="column_name">이메일</div>
                        <div id="regist_email_input">
                            <input type=text name="regist_email1" maxlength="30" placeholder="이메일 입력란">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                            <select name="regist_email2">
                                <option value="">@선택</option>
                                <option value="naver.com">@naver.com</option>
                                <option value="gmail.com">@gmail.com</option>
                                <option value="nate.com">@nate.com</option>
                                <option value="daum.net">@daum.net</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div id="sub_info" class="content_body" style="display: none;">
                    <div id="regist_birth">
                        <div class="column_name">생년월일</div>

                        <div id="year_input" class="birth_input">
                            <input type=text name="regist_year" maxlength="4" class="num_input" placeholder="OOOO">
                            <span>년</span>
                        </div>

                        <div id="month_input" class="birth_input">
                            <input type=text name="regist_month" maxlength="2" class="num_input" placeholder="OO">
                            <span>월</span>
                        </div>

                        <div id="day_input" class="birth_input">
                            <input type=text name="regist_day" maxlength="2" class="num_input" placeholder="OOO">
                            <span>일</span>
                        </div>
                    </div>

                    <div id="regist_gender">
                        <div class="column_name">성별</div>
                        <div id="gender_input">

                            <label style="left: 10px">
                                <input type=radio value=x name="regist_gender" checked>
                                <span>생략</span>
                            </label>

                            <label style="left: 120px">
                                <input type=radio value=m name="regist_gender">
                                <span>남성</span>
                            </label>

                            <label style="left: 230px">
                                <input type=radio value=w name="regist_gender">
                                <span>여성</span>
                            </label>
                        </div>
                    </div>

                    <div id="regist_job">
                        <div class="column_name">직업</div>
                        <div id="job_input">
                            <input type=text name="regist_job" class="cancel_input" placeholder="현재 직업을 적어주세요.">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                        </div>
                    </div>

                    <div id="regist_hometown">
                        <div class="column_name">지역</div>
                        <div id="hometown_input">
                            <input type=text name="regist_hometown" class="cancel_input" maxlength="15" placeholder="현재 살고 있는 OO도 OO시를 입력">
                            <a href="javascript:void(0)" class="cancel_btn">
                                <img src="image/regist_close_btn.png">
                            </a>
                        </div>
                    </div>

                    <div id="regist_profile">
                        <div class="column_name">프로필사진</div>
                        <div id="profile_input">

                            <div class="filebox">
                                <input class="upload-name" value="사진을 넣어주세요" disabled="disabled">
                                <label>
                                    <input type="file" name="regist_profile" class="upload-hidden" accept="image/jpeg, image/png, image/gif" onchange="loadFile(this);">
                                    업로드
                                </label>
                            </div>

                            <div id="preview_image">
                                <img src="image/white_background.png">
                            </div>
                        </div>

                    </div>
                </div>

                <div id="complete" class="content_body" style="display: none;">
                    <div id="complete_head">
                        가입을<br> 축하합니다.
                    </div>
                    <div id="complete_body">
                        Seam Music의<br> 회원이 되셨습니다.
                    </div>
                </div>

                <div id="step_changer">
                    <div>
                        <span>이전 단계</span>
                    </div>
                    <div>
                        <span>다음 단계</span>
                    </div>
                    <div>
                        <span>완료</span>
                    </div>
                </div>
            </div>
        </form>
    </center>
</body>

<script>
	$(window).load(function() {
	    $("#step_changer div").eq(0).hide();
	    $("#step_changer div").eq(2).hide();
	
	    if( <%=complete_page.equals("true")%> )
	    {
        	regist_step = 3;
        	$("#step_changer div").eq(2).trigger('click');
	    }
	});
</script>

</html>