package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class AlbumDatabase extends CustomDatabase
{
	String []columnList = {"", "album_no", "nation_no", "name", "artist_no", "release_date", "release_com", "agency", "albumart", "intro"};
	
	public ArrayList<HashMap<String, Object>> getAlbumList(String filterValue, int count)
	{
		connectSQL();
		
		String query = "select * from album where replace(name, ' ', '') like '%' ? '%'";
		
		if( count > 0 )
			query += " limit ?";
		
		filterValue = (filterValue != null)? filterValue.replaceAll(" ", ""): "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, filterValue);
			
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
	
	public ArrayList<HashMap<String, Object>> getAlbumList(String filter, String filter_content, int count)
	{
		connectSQL();
		
		//String query = "select * from album where replace(album_no, ' ', '') like '%' ? '%'";
		
		String query = (count > 0)? "select * from album limit 0, ?":  "select * from album";
		
		/*if( filter.equals("all") )
			query = "select * from album where replace(name, ' ', '') like '%' ? '%' or replace(nation_no, ' ', '') like '%' ? '%'";
		else if( filter.equals("name") )
			query = "select * from album where replace(name, ' ', '') like '%' ? '%'";
		else if( filter.equals("nation") )
			query = "select * from album where replace(nation_no, ' ', '') like '%' ? '%'";*/
		
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
	
	public ArrayList<HashMap<String, Object>> getArtistAlbumList(String artist_no)
	{
		connectSQL();
		
		String query = "select * from album where artist_no like '%' ? '%'";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, artist_no);
			
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
	
	public HashMap<String, Object> getAlbumInfo(String album_no)
	{
		connectSQL();
		
		String query = "select * from album where album_no=?";
		
		map = new HashMap<String, Object> ();
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, album_no);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			for( int i = 1; i < columnList.length; i++ )
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
		
		String query = "insert into album values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
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
			pstmt.setString(9, null);
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