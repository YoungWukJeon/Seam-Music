<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page errorPage="making.html"%> --%>
<%@ page import="java.util.*"%>
<%@ page import="Seam.*"%>

<%
	request.setCharacterEncoding("utf-8");
	
	String command = request.getParameter("command");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String result = null;

	MemberDatabase mbd = new MemberDatabase();
	
	if( command != null )
	{
		String nickname = mbd.getNickname(id, passwd);
		
		if( !nickname.equals("") )
		{
			session.setAttribute("id", id);
			session.setAttribute("nickname", nickname);
			// response.sendRedirect("LoginForm.jsp?result=success");
			result = "success";
		}
		else
		{
			out.println("<script>");
			out.println("alert('로그인 실패')");
			out.println("history.back()");
			out.println("</script>");
			out.flush();
		}
	}
	else
	{
		session.invalidate();
		// response.sendRedirect("LoginForm.jsp?result=success");
		result = "success";
	}
%>

<script>
	if( <%=result != null%> )
		parent.refreshPage();
</script>

