package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class PlayListDatabase extends CustomDatabase
{
	String []columnList = {"", "playlist_no", "id", "genre", "tag", "date", "title", "content", "isRadio", "isShared", "image"};
	
	public ArrayList<HashMap<String, Object>> getPlayList(String isRadio, String isShared, String filterValue, int count)
	{
		connectSQL();
		
		String query = "select * from playlist where isRadio=? and isShared=? and replace(title, ' ', '') like '%' ? '%'";
		
		if( count > 0 )
			query += " limit ?";
		
		filterValue = (filterValue != null)? filterValue.replaceAll(" ", ""): "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, isRadio);
			pstmt.setString(2, isShared);
			pstmt.setString(3, filterValue);
			
			if( count > 0 )
				pstmt.setInt(4, count);
			
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
	
	public ArrayList<HashMap<String, Object>> getPlayList(String isRadio, String isShared, String id)
	{
		connectSQL();
		
		String query = (id == null)? "select * from playlist where isRadio=? and isShared=?": "select * from playlist where isRadio=? and isShared=? and id=?";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, isRadio);
			pstmt.setString(2, isShared);
			
			if( id != null )
				pstmt.setString(3, id);
			
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
	
	public ArrayList<HashMap<String, Object>> getMusicIncludeDJList(String isRadio, String isShared, String id, String type, String item_no)
	{
		connectSQL();
		
		String query = "select * from playlist where isRadio=? and isShared=? and playlist_no in(select playlist_no from playmusiclist where music_no in(select music_no from music where " + type +"_no=?))";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, isRadio);
			pstmt.setString(2, isShared);
			pstmt.setString(3, item_no);
			
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
	
	public HashMap<String, Object> getPlayListInfo(String playlist_no)
	{
		connectSQL();
		
		String query = "select * from playlist where playlist_no=?";
		
		map = new HashMap<String, Object> ();
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			for (int i = 1; i < columnList.length; i++)
				map.put(columnList[i], rs.getObject(i));
			
//			if( album_no == null )
//				album_no = "0000000001";
//			else
//			{
//				int temp_no = Integer.parseInt(album_no) + 1;
//				album_no = String.format("%010d", temp_no);
//			}

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
	
	public String getEnabledPlayListNo()
	{
		connectSQL();
		
		String query = "select max(playlist_no) from playlist";
		int playlist_no = 1;
		
		try
		{
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				playlist_no = Integer.parseInt(rs.getString(1)) + 1;
		
			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return String.format("%015d", playlist_no);
	}
	
	public void addPlayList(String playlist_no, String id, String genre, String tag, String date, String title, String content, String isRadio, String isShared, String image)
	{
		connectSQL();
		
		String query = "insert into playlist values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			pstmt.setString(2, id);
			pstmt.setString(3, genre);
			pstmt.setString(4, tag);
			pstmt.setString(5, date);
			pstmt.setString(6, title);
			pstmt.setString(7, content);
			pstmt.setString(8, isRadio);
			pstmt.setString(9, isShared);
			pstmt.setString(10, image);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}