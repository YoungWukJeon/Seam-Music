<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String decoding = "ISO-8859-1";
	String encoding = "euc-kr";

	String data = new String(request.getParameter("data").getBytes(decoding), encoding);
	
	out.println(data);
%>