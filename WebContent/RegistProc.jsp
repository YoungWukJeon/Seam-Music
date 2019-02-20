<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="Seam.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String requestType = request.getParameter("requestType");
	
	MemberDatabase mbd = new MemberDatabase();
	
	if( requestType.equals("phone_check") )
	{
		String phone = request.getParameter("phone");
		phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
		boolean result = mbd.isExist("phone", phone);
		
		if( !result )
		{
			out.println("success");
			out.flush();
			return;
		}
		else
		{
			out.println("fail");
			out.flush();
			return;
		}
	}	
	else if( requestType.equals("email_check") )
	{
		String email = request.getParameter("email");
		boolean result = mbd.isExist("email", email);
		
		if( !result )
		{
			out.println("success");
			out.flush();
			return;
		}
		else
		{
			out.println("fail");
			out.flush();
			return;
		}
	}
	else if( requestType.equals("cert_mail") )
	{
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		// 입력값 받음
		 
		Properties p = new Properties(); // 정보를 담을 객체
		 
		p.put("mail.smtp.host", "smtp.naver.com"); // 네이버 SMTP
		 
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		// SMTP 서버에 접속하기 위한 정보들
		 
		try
		{
		    Authenticator auth = new SMTPAuthenticator();
		    Session ses = Session.getInstance(p, auth);
		     
		    ses.setDebug(true);
		     
		    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
		    msg.setSubject(subject); // 제목
		     
		    Address fromAddr = new InternetAddress(from);
		    msg.setFrom(fromAddr); // 보내는 사람
		     
		    Address toAddr = new InternetAddress(to);
		    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
		     
		    Transport.send(msg); // 전송
		} 
		catch(Exception e)
		{
		    e.printStackTrace();
		    out.println("fail");
		    out.flush();
		    return;
		}
		 
		out.println("success");
		out.flush();
		return;
	}
	else if( requestType.equals("id_check") )
	{
		String id = request.getParameter("id");
		boolean result = mbd.isExist("id", id);
		
		if( !result )
		{
			out.println("success");
			out.flush();
			return;
		}
		else
		{
			out.println("fail");
			out.flush();
			return;
		}
	}
	else if( requestType.equals("nickname_check") )
	{
		String nickname = request.getParameter("nickname");
		boolean result = mbd.isExist("nickname", nickname);
		
		if( !result )
		{
			out.println("success");
			out.flush();
			return;
		}
		else
		{
			out.println("fail");
			out.flush();
			return;
		}
	}
	else if( requestType.equals("submit") )
	{
		ServletContext context = getServletContext();
		String saveFolder="image/member/";
		String realFolder = context.getRealPath(saveFolder);
		String encType = "utf-8";
		int sizeLimit = 1000 * 1024 * 1024;
		String default_img = "default_member.png";
		
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, policy);
		
		String id = multi.getParameter("regist_id");
		String passwd = multi.getParameter("regist_passwd");
		String name = multi.getParameter("regist_name");
		String nickname = multi.getParameter("regist_nickname");
		String phone = multi.getParameter("regist_phone");
		String email = multi.getParameter("regist_email1") + "@" + multi.getParameter("regist_email2");
		String birth = "";
		
		if( multi.getParameter("regist_year").length() == 4 && multi.getParameter("regist_month").length() > 0 && multi.getParameter("regist_day").length() > 0 )
			birth = String.format("%04d", Integer.parseInt(multi.getParameter("regist_year"))) + String.format("%02d", Integer.parseInt(multi.getParameter("regist_month"))) + String.format("%02d", Integer.parseInt(multi.getParameter("regist_day")));
		String gender = multi.getParameter("regist_gender");
		String job = multi.getParameter("regist_job");
		String hometown = multi.getParameter("regist_hometown");
		
		String input_img = saveFolder + id;
		
		phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
		
		if( gender.equals("x") )
			gender = null;
		else if( gender.equals("m") )
			gender = "남";
		else if( gender.equals("w") )
			gender = "여";
		
		Enumeration files = multi.getFileNames();
		
		if( files.hasMoreElements() )
		{
			String filename = (String) files.nextElement();
			String str= multi.getOriginalFileName(filename);
			
			if( filename.equals("regist_profile") )
			{
				if( str != null )
				{
					String newName = id + str.substring(str.lastIndexOf("."));
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
						FileOutputStream fos = new FileOutputStream(realFolder + "/" + id + ".png");
						
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
		
		mbd.addMember(id, passwd, name, nickname, email, phone, input_img, birth, gender, job, hometown);
		response.sendRedirect("Regist.jsp?complete_page=true");
	}
%>