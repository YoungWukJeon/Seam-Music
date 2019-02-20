<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Seam.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("utf-8");

%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>관리자 페이지</title>
	
	<script src="js/jquery.js"></script>
</head>

<body style="white-space: nowrap;" ondragstart="return false;">

	<form id="music_form" method=post action="Admin_Music_FileUpload.jsp?" encType="multipart/form-data" onsubmit="uploadFile()">
		<input type="file" name="music "id="music" accept="audio/mp3" required onchange="loadFile(this)">
	</form>
</body>

<style>

</style>

<script>

function loadFile(input)
{
	parent.loadFile(input);
}

function uploadFile() 
{
	// parent.formSubmit();
}

$(document).ready(function() {
	$("#music").change(function(e){
	    var file = e.currentTarget.files[0];

	    parent.addAudioFile(file);
	    
	});
});

</script>

</html>