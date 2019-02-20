package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class MemberDatabase extends CustomDatabase
{
	String []columnList = {"", "id", "passwd", "name", "nickname", "email", "phone", "profile_image", "birth", "gender", "job", "hometown", "interest", "intro"};
	
	public String getNickname(String id, String passwd)
	{
		connectSQL();
		
		String query = (passwd == null)? "select nickname from member where id=?": "select nickname from member where id=? and passwd=?";
		String nickname = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			if( passwd != null )
				pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				nickname = rs.getString(1);

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return nickname;
	}
	
	public Object getMemberPartInfo(String id, String partColumn)
	{
		connectSQL();
		
		String query = "select " + partColumn + " from member where id=?";
		Object partInfo = null;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				partInfo = rs.getObject(1);

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return partInfo;
	}
	
	public HashMap<String, Object> getMemberInfo(String nickname)
	{
		connectSQL();
		
		String query = "select * from member where nickname=?";
		
		map = new HashMap<String, Object>();
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();

			rs.next();
			
			for (int i = 1; i < columnList.length; i++)
				map.put(columnList[i], rs.getObject(i));

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		return map;
	}
	
	public boolean isExist(String type, String value)
	{
		connectSQL();
		
		String query = "select count(" + type + ") from member where " + type + "=?";
		boolean result = false;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, value);
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				result = rs.getInt(1)>0? true: false;

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return result;
	}
	
	public void addMember(String id, String passwd, String name, String nickname, String email, String phone, String profile_image, String birth, String gender, String job, String hometown)
	{
		connectSQL();
		
		String query = "insert into member values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.setString(3, name);
			pstmt.setString(4, nickname);
			pstmt.setString(5, email);
			pstmt.setString(6, phone);
			pstmt.setString(7, profile_image);
			pstmt.setString(8, birth);
			pstmt.setString(9, gender);
			pstmt.setString(10, job);
			pstmt.setString(11, hometown);
			pstmt.setString(12, "");
			pstmt.setString(13, "");
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	/*public ArrayList<HashMap<String, Object>> getAlbumList(String filter, String filter_content, int count)
	{
		connectSQL();
		
		//String query = "select * from album where replace(album_no, ' ', '') like '%' ? '%'";
		
		String query = (count > 0)? "select * from album limit 0, ?":  "select * from album";
		
		if( filter.equals("all") )
			query = "select * from album where replace(name, ' ', '') like '%' ? '%' or replace(nation_no, ' ', '') like '%' ? '%'";
		else if( filter.equals("name") )
			query = "select * from album where replace(name, ' ', '') like '%' ? '%'";
		else if( filter.equals("nation") )
			query = "select * from album where replace(nation_no, ' ', '') like '%' ? '%'";
		
		// filter_content = filter_content.replaceAll(" ", "");
		
		try 
		{
			pstmt = con.prepareStatement(query);
			
			if( count > 0 )
				pstmt.setInt(1, count);
			
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				map = new HashMap<String, Object>();

				for (int i = 1; i < columnList.length; i++)
					map.put(columnList[i], rs.getObject(i));

				list.add(map);
			}

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return list;
	}
	
	public String getName(String album_no)
	{
		connectSQL();
		
		String query = "select name from album where album_no=?";
		String name = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, album_no);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			name = rs.getString(1);

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return name;
	}
	
	public String getEnabledAlbumNo()
	{
		connectSQL();
		
		String query = "select max(album_no) from album";
		String album_no = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			album_no = rs.getString(1);
			
			if( album_no == null )
				album_no = "0000000001";
			else
			{
				int temp_no = Integer.parseInt(album_no) + 1;
				album_no = String.format("%010d", temp_no);
			}

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return album_no;
	}
	
	public void addAlbum(String album_no, String nation_no, String name, String artist_no, String release_date, String release_com, String agency, String albumart)
	{
		connectSQL();
		
		String query = "insert into album values(?, ?, ?, ?, ?, ?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, album_no);
			pstmt.setString(2, nation_no);
			pstmt.setString(3, name);
			pstmt.setString(4, artist_no);
			pstmt.setString(5, release_date);
			pstmt.setString(6, release_com);
			pstmt.setString(7, agency);
			pstmt.setString(8, albumart);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}*/
}