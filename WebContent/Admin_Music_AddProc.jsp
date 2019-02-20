<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String filter = request.getParameter("filter");
	String filter_content = request.getParameter("filter_content");
	
	if( filter == null ) filter = "";
	if( filter_content == null ) filter_content = "";
	
	ArtistDatabase ad = new ArtistDatabase();
	NationDatabase nd = new NationDatabase();
	MusicDatabase md = new MusicDatabase();
	
	ServletContext context = getServletContext();
	String saveFolder1="image/albumart/";
	String saveFolder2="audio/";
	String realFolder1 = context.getRealPath(saveFolder1);
	String realFolder2 = context.getRealPath(saveFolder2);
	String encType = "utf-8";
	int sizeLimit = 100 * 1024 * 1024;
	String default_img = "default_albumart.png";
	// String input_img = saveFolder1 + music_no;
	// String input_audio = saveFolder2 + music_no;
	
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest multi = new MultipartRequest(request, realFolder1, sizeLimit, encType, policy);
	
	String nation_no = nd.getNationNo(multi.getParameter("nation"));
	String name = multi.getParameter("name");
	String artist_no = multi.getParameter("artist_no");
	String song_writer = multi.getParameter("song_writer");
	String lyric_writer = multi.getParameter("lyric_writer");
	String album_no = multi.getParameter("album_no");
	String lyrics = multi.getParameter("lyrics");
	String genre = multi.getParameter("genre");
	String release_date = multi.getParameter("release_date");
	String track = multi.getParameter("track");
	String tag = multi.getParameter("tag");
	String time = multi.getParameter("time");
	String isTitle = multi.getParameter("isTitle");
	String isAdult = multi.getParameter("isAdult");
	
	String music_no = md.getEnabledMusicNo(release_date);
	String input_img = saveFolder1 + music_no;
	
	if( track.equals("") ) track = "0";
	if( isTitle.equals("") ) isTitle = "false";
	if( isAdult.equals("") ) isAdult = "false";
	
	Enumeration files = multi.getFileNames();
	
	while( files.hasMoreElements() )
	{
		String filename = (String) files.nextElement();
		String str= multi.getOriginalFileName(filename);
		
		if( filename.equals("albumart") )
		{
			if( str != null )
			{
				String newName = music_no + str.substring(str.lastIndexOf("."));
				File oldFile = new File(realFolder1 + "/" + str);
				File newFile = new File(realFolder1 + "/" + newName);
				oldFile.renameTo(newFile);
				input_img += str.substring(str.lastIndexOf("."));
			}
			else
			{
				try
				{
					FileInputStream fis = new FileInputStream(realFolder1 + "/" + default_img);
					FileOutputStream fos = new FileOutputStream(realFolder1 + "/" + artist_no + ".png");
					
				   	int data = 0;
				   	
				   	while((data=fis.read())!=-1) {
				    	fos.write(data);
				   	}
				   	fis.close();
				  	fos.close();
				  	input_img += ".png";
				} 
				catch (IOException e)
				{
					e.printStackTrace();
				}
			}
		}
		/* else
		{	
			try
			{
				FileInputStream fis = new FileInputStream(realFolder1 + "/" + str);
				FileOutputStream fos = new FileOutputStream(realFolder2 + "/" + music_no + ".mp3");
				
			   	int data = 0;
			   	
			   	while((data=fis.read())!=-1) {
			    	fos.write(data);
			   	}
			   	fis.close();
			  	fos.close();
			  	
			  	File deleteFile = new File(realFolder1 + "/" + str);
			  	deleteFile.delete();
			  	// input_audio += ".mp3";
			} 
			catch (IOException e)
			{
				e.printStackTrace();
			}
		}  */
	}
	
	md.addMusic(music_no, nation_no, name, artist_no, song_writer, lyric_writer, album_no, input_img, lyrics, genre, release_date, track, tag, time, isTitle, isAdult);

	// response.sendRedirect("Admin_Artist.jsp?filter=" + filter + "&filter_content=" + filter_content);
	
	response.sendRedirect("Admin_Music_Add.jsp?filter=" + filter + "&filter_content=" + filter_content);
	
	/* String realFolder="/Users/kimkyeongho/Documents/workspace/kokkok4.0/WebContent/IMAGES/review";//경로
	String renamePath="/Users/kimkyeongho/Documents/workspace/kokkok4.0/WebContent/"; */
	
	/* ReviewDatabase rd=new ReviewDatabase();
	ImageDatabase id=new ImageDatabase();
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
	Date today=new Date();
	
	String nickName=(String)session.getAttribute("userNickname");

	String review_name=multi.getParameter("review_name");
	String default_img="";
	String date=sdf.format(today);
	String content="";
	String term=multi.getParameter("review_date");
	String tag_list=multi.getParameter("tag_list");
	
	int review_cnt=rd.getReviewCount();
	
	String start_day=term.split("~")[0].trim();
	String end_day=term.split("~")[1].trim();
	
	long diffDays=0;
	try {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = formatter.parse(start_day);
        Date endDate = formatter.parse(end_day);
         
        // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
        long diff = endDate.getTime() - beginDate.getTime();
        diffDays = diff / (24 * 60 * 60 * 1000);
 		diffDays++;
        
        System.out.println("날짜차이=" + diffDays);
         
    } catch (ParseException e) {
        e.printStackTrace();
    }
	
	ArrayList<String> content_list=new ArrayList<String>();
	ArrayList<String> area_list=new ArrayList<String>(); */
	
	// Enumeration names = multi.getParameterNames();
	
	/* while( names.hasMoreElements() )
	{
		String name = (String) names.nextElement();
		//System.out.println(name);
		String data = multi.getParameter(name);

		if(name.equals("review_name"))
		{
		}
		else if(name.equals("review_date"))
		{
		}
		else if(name.equals("member_nick"))
		{
		}
		else if(name.equals("tag_list"))
		{
		}
		else
		{
			String kind=name.split("_")[2];
			
			if(kind.equals("areaName"))
			{
				area_list.add(name);
			}
			else
			{
				content_list.add(name);	
			}
			
		}
	} */
	// content_list.sort(String.CASE_INSENSITIVE_ORDER);
	// area_list.sort(String.CASE_INSENSITIVE_ORDER);
	
	/* Collections.sort(content_list);
	Collections.sort(area_list);
	
	JSONArray date_arr=new JSONArray();//일차별 array
	for(int k=0; k<diffDays; k++){
		JSONArray area_arr=new JSONArray();
		for(int i=0; i<area_list.size(); i++){
			if(Integer.parseInt(area_list.get(i).split("_")[0])==k){
				JSONObject itemObj=new JSONObject();
				
				JSONArray content_arr=new JSONArray();
				for(int j=0; j<content_list.size(); j++){
					if(content_list.get(j).split("_")[1].equals(area_list.get(i).split("_")[1])){
						JSONObject obj=new JSONObject();
						if(multi.getParameter(content_list.get(j))!="")
							obj.put(content_list.get(j).split("_")[3],multi.getParameter(content_list.get(j)));
						
						content_arr.add(obj);
					}
				}
				itemObj.put("area", multi.getParameter(area_list.get(i)));
				itemObj.put("review", content_arr);
				area_arr.add(itemObj);
			}
		}
		date_arr.add(k, area_arr);
		System.out.println(area_arr);
	} */
	
	// String review_no=String.format("%010d",(review_cnt+1));
%>