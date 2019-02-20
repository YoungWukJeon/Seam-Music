<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html" %> --%>
<%@ page import="java.util.*" %>
<%@page import="java.text.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String) session.getAttribute("id");
	String nickname = (String) session.getAttribute("nickname");

	NationDatabase nd = new NationDatabase();
	MusicDatabase md = new MusicDatabase();
	MemberDatabase mbd = new MemberDatabase();
	ArtistDatabase atd = new ArtistDatabase();
	AlbumDatabase ad = new AlbumDatabase();
	
	HashMap<String, Object> map = mbd.getMemberInfo(nickname);
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>
	
	<link href="css/Pay.css" rel="stylesheet">
	
	<script src="js/jquery.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
	<script src="js/Pay.js"></script>

</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="center">
		<div id="pay_title">결제하기</div>
	    <div id="agree">
	        <div class="title">
	            약관동의
	        </div>
	        <div id="agree_main">
	            <div id="agree_text">
	                이용약관<br>
	                정보수집동의<br>
	                전자금융거래 이용약관
	            </div>
	            <div id="agree_all">
	                전문보기<br>
	                전문보기<br>
	                전문보기
	            </div>
	        </div>
	        <div id="agree_check">
	            <label><input type="checkbox"> 동의합니다.</label>
	        </div>
	    </div>
	    <div id="price">
	        <div class="title">
	            주문내역
	        </div>
	        <div id="price_bill">
	            <div id="price_text">
	                결제금액
	            </div>
	            <div id="price_number">
	                3,000원
	            </div>
	        </div>
	    </div>
	    <div id="pay_way">
	        <div class="title">
	            결제방법
	        </div>
	        <div id="radio_box">
	        <label id="phone"><input class='radio_button' name='pay_check' type="radio" value="phone">휴대폰결제</label>
	        <label id="account"><input class='radio_button' name='pay_check' type="radio" value="back">계좌이체</label><br>
	        <label id="culture"><input class='radio_button' name='pay_check' type="radio" value="culture">문화상품권</label>
	        <label id="card"><input class='radio_button' name='pay_check' type="radio" value="card">카드</label>
	        </div>
	    </div>
    	<input type="button" id="submit_btn" style="display: none;">
	</div>
	
	<form name="pgForm">
        <input type="hidden" name="Amt" value="1000">
        <input type="hidden" name="BuyerName" value="홍길동">
        <input type="hidden" name="OrderName" value="결제테스트">
    </form>
	
</body>

<script>
	var IMP = window.IMP; // 생략가능
	IMP.init('imp76963341'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	function startPay() {
		IMP.request_pay({
	        pg: 'html5_inicis', // version 1.1.0부터 지원.
	        pay_method: 'phone',
	        merchant_uid: 'merchant_' + new Date().getTime(),
	        name: '주문명:결제테스트',
	        amount: 3000,
	        buyer_email: '<%=map.get("email")%>',
	        buyer_name: '<%=map.get("name")%>',
	        buyer_tel: '<%=map.get("phone")%>',
	        buyer_addr: '<%=map.get("hometown")%>',
	        buyer_postcode: '123-456'
	            // m_redirect_url: 'https://www.yourdomain.com/payments/complete'
	    }, function(rsp) {
	        if (rsp.success) {
	            var msg = '결제가 완료되었습니다.';
	            msg += '고유ID : ' + rsp.imp_uid;
	            msg += '상점 거래ID : ' + rsp.merchant_uid;
	            msg += '결제 금액 : ' + rsp.paid_amount;
	            msg += '카드 승인번호 : ' + rsp.apply_num;
	        } else {
	            var msg = '결제에 실패하였습니다.';
	            msg += '에러내용 : ' + rsp.error_msg;
	        }
	        alert(msg);
	        parent.$("#pay_dialog .modal-footer button").eq(1).trigger('click');
	    });
	}

/*
    IMP.request_pay({
        pg: 'jtnet', // version 1.1.0부터 지원.
        pay_method: 'card',
        merchant_uid: 'merchant_' + new Date().getTime(),
        customer_uid: 'tpaytest2m',
        amount: 1300,
        name: '주문명:빌링키 발급을 위한 결제',
        buyer_email: 'iamport@siot.do',
        buyer_name: '구매자이름',
        buyer_tel: '010-1234-5678'
    }, function(rsp) {
        if (rsp.success) {
            var msg = '빌링키 발급이 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
        } else {
            var msg = '빌링키 발급에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
        }

        alert(msg);
    });

    */

    

</script>

</html>