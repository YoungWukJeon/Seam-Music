<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html"%> --%>
<%@ page import="java.util.*"%>
<%@ page import="Seam.*"%>

<%
	request.setCharacterEncoding("utf-8");
	
	String nickname = (String) session.getAttribute("nickname");
	
	MemberDatabase mbd = new MemberDatabase();
	HashMap<String, Object> memberInfo = null;
	
	if( nickname != null )
		memberInfo = mbd.getMemberInfo(nickname);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>세상을 움직이는 단 하나의 뮤직 SEAM♩</title>

	<style>
	#logstate_out {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 160px;
	}
	
	#logstate_out input {
		position: absolute;
		left: 18px;
		width: 150px;
		height: 23px;
		border: solid 1px rgb(200, 200, 200);
		padding-left: 15px;
	}
	
	#logstate_out input[type=text] {
		top: 40px;
		height: 32px;
		font-size: 9pt;
	}
	
	#logstate_out input[type=password] {
		top: 80px;
		height: 32px;
		font-size: 9pt;
	}
	
	#logstate_out input[type=submit] {
		top: 120px;
		background-color: rgb(243, 119, 117);
		width: 167px;
		height: 32px;
		border: 0;
		color: #e0e0e0;
		cursor: pointer;
	}
	
	#idtext {
		position: absolute;
		top: 160px;
		left: 22px;
		font-size: 8pt;
		color: #777777;
	}
	
	#logstate_in {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 200px;
	}
	
	#profile_logout {
		position: absolute;
		left: 130px;
		top: 10px;
		width: 70px;
		height: 20px;
		cursor: pointer;
	}
	
	#profile_logout img {
		position: absolute;
		left: 0;
		top: 0;
		height: 20px;
		width: 20px;
	}
	
	#profile_logout span {
		position: absolute;
		left: 25px;
		top: 0;
		font-size: 8pt;
	}
	
	#profile_image {
		position: absolute;
		left: 50px;
		top: 30px;
		width: 100px;
		height: 100px;
		border-radius: 50%;
	}
	
	#profile_image img {
		width: 100px;
		height: 100px;
		border-radius: 50%;
	}
	
	#profile_nickname {
		position: absolute;
		top: 140px;
		left: 25px;
		width: 150px;
		height: 15px;
		text-align: center;
		font-size: 10pt;
	}
	
	#profile_utilize {
		position: absolute;
		top: 160px;
		left: 25px;
		width: 150px;
		height: 15px;
		text-align: center;
		font-size: 10pt;
	}
	
	#membership {
		position: absolute;
		top: 157px;
		left: 120px;
		font-size: 10pt;
		color: rgb(150, 108, 112);
		cursor: pointer;
	}
	</style>

	<script src="js/jquery.js"></script>

</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

	<%
	if( nickname == null )
	{
	%>
	<div id="logstate_out">
		<form method="post" action="LoginFormProc.jsp?command=login">
			<input class="logo_reset" type="text" name="id" placeholder="User Name" required /> 
			<input class="logo_reset" type="password" name="passwd" placeholder="Password" required />
			<input type="submit" value="로그인" />
			<span id="idtext">아이디가 없으세요?</span> <b><span id="membership">회원가입</span></b>
		</form>
	</div>
	<%
	}
	else
	{
	%>
	<div id="logstate_in">
		<div id="profile_logout"  onclick="javascript:location.replace('LoginFormProc.jsp')">
			<img src="image/logout.png"> <span>logout</span>
		</div>
		<div id="profile_image">
			<img src='<%=memberInfo.get("profile_image")%>'>
		</div>
		<div id="profile_nickname">
			<span><%=nickname%></span>
		</div>
		<div id="profile_utilize">
			<!-- <span>[현재 이용중인 이용권]</span> -->
			<span>[이용권 사용중]</span>
		</div>
	</div>
	<%
	}
	%>
</body>

<script>	
	/* 수정~ */
	$(document).ready(function() {
		$("#membership").click(function() {
			parent.$("#regist_iframe").attr("src", "Regist.jsp");
			parent.$('#regist_dialog').show();
			parent.$('#radio_dialog').hide();
			parent.$('#pay_dialog').hide();
			parent.registShow();
		});
	});
	/* ~수정 */
</script>

</html>