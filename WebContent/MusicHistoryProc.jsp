<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
	Date today = new Date();
	
	String id= (String) session.getAttribute("id");
	String date = sdf.format(today);
	String music_no = request.getParameter("music_no");
	String playTime = request.getParameter("playTime");
	
	PlayHistoryDatabase phd = new PlayHistoryDatabase();
	phd.addPlayHistory(music_no, id, date, Integer.parseInt(playTime));
%>