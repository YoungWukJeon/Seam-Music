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
	
	String artist_no = ad.getEnabledArtistNo();	
	
	ServletContext context = getServletContext();
	String saveFolder="image/artist/";
	String realFolder = context.getRealPath(saveFolder);
	String encType = "utf-8";
	int sizeLimit = 1000 * 1024 * 1024;
	String default_img = "default_artist.png";
	String input_img = saveFolder + artist_no;
	
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, policy);
	
	String nation_no = nd.getNationNo(multi.getParameter("nation"));
	String name = multi.getParameter("name");
	String group_name = multi.getParameter("group_name");
	String debut_date = multi.getParameter("debut_date");
	String job = multi.getParameter("job");
	String gender = multi.getParameter("gender");
	String agency = multi.getParameter("agency");
	String position = multi.getParameter("position");
	
	if( group_name == null ) group_name = "";
	if( position == null ) group_name = "";
	
	Enumeration files = multi.getFileNames();
	
	if( files.hasMoreElements() )
	{
		String filename = (String) files.nextElement();
		String str= multi.getOriginalFileName(filename);
		
		if( filename.equals("profile_image") )
		{
			if( str != null )
			{
				String newName = artist_no + str.substring(str.lastIndexOf("."));
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
					FileOutputStream fos = new FileOutputStream(realFolder + "/" + artist_no + ".png");
					
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
	}
	
	ad.addArtist(artist_no, nation_no, name, group_name, debut_date, input_img, job, gender, agency, position);

	// response.sendRedirect("Admin_Artist.jsp?filter=" + filter + "&filter_content=" + filter_content);
	
	response.sendRedirect("Admin_Artist_Add.jsp?filter=" + filter + "&filter_content=" + filter_content);
	
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


	