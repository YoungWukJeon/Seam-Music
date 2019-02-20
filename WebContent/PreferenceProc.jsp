<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String kind = request.getParameter("kind");
	String item_no = request.getParameter("item_no");
	String id = request.getParameter("id");
	String processType = request.getParameter("processType");

	PreferenceDatabase pd = new PreferenceDatabase();
	
	if( processType.equals("add") )
		pd.addLike(kind, item_no, id);
	else if( processType.equals("delete") )
		pd.deleteLike(kind, item_no, id);
	
	out.println(pd.getLikeCount(kind, item_no, null));
%>