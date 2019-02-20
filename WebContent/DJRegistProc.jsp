<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("id");

	PlayListDatabase pld = new PlayListDatabase();
	PlayMusicListDatabase pmd = new PlayMusicListDatabase();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss.SS");
	Date today = new Date();
	
	ServletContext context = getServletContext();
	String saveFolder="image/dj/";
	String realFolder = context.getRealPath(saveFolder);
	String encType = "utf-8";
	int sizeLimit = 1000 * 1024 * 1024;
	String default_img = "default_dj.jpg";
	
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, policy);
	
	String title = multi.getParameter("title");
	String tag = multi.getParameter("tag");
	String genre = multi.getParameter("genre");
	String playlist = multi.getParameter("playlist");
	String intro = multi.getParameter("intro");
	
	String playlist_no = pld.getEnabledPlayListNo();
	String []musicNoList = pmd.getMusicNoList(playlist);
	String input_img = saveFolder + playlist_no;
	
	if( genre.equals("no_select") )
		genre = null;
	
	if( tag != null && tag.equals("") )
		tag = null;
	
	Enumeration files = multi.getFileNames();
	
	if( files.hasMoreElements() )
	{
		String filename = (String) files.nextElement();
		String str= multi.getOriginalFileName(filename);
		
		if( filename.equals("image") )
		{
			if( str != null )
			{
				String newName = playlist_no + str.substring(str.lastIndexOf("."));
				File oldFile = new File(realFolder + "/" + str);
				File newFile = new File(realFolder + "/" + newName);
				oldFile.renameTo(newFile);
				input_img += str.substring(str.lastIndexOf("."));
			}
			else
			{
				try
				{
					FileInputStream fis = new FileInputStream(realFolder + "/" + default_img);
					FileOutputStream fos = new FileOutputStream(realFolder + "/" + playlist_no + ".jpg");
					
				   	int data = 0;
				   	
				   	while((data=fis.read())!=-1) {
				    	fos.write(data);
				   	}
				   	fis.close();
				  	fos.close();
				  	input_img += ".jpg";
				} 
				catch (IOException e)
				{
					e.printStackTrace();
				}
			}
		}
	}
	
	pld.addPlayList(playlist_no, id, genre, tag, sdf.format(today), title, intro, "false", "true", input_img);
	pmd.addPlayMusicList(playlist_no, musicNoList);
	
	out.println("<script>alert('Seam DJ 신청이 완료되었습니다.'); parent.registHide('success');</script>");
	out.flush();
%>

<!-- <head>
	<script src="js/jquery.js"></script>
</head>

<body></body>

<script>
	$(document).ready(function() {
		
	});
</script> -->