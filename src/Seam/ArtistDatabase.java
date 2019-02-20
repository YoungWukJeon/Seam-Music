package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class ArtistDatabase extends CustomDatabase
{
	String []columnList = {"", "artist_no", "nation_no", "name", "group_name", "debut_year", "profile_image", "job", "gender", "agency", "position"};
	
	public ArrayList<HashMap<String, Object>> getArtistList(String filterValue, int count)
	{
		connectSQL();
		
		String query = "select * from artist where replace(name, ' ', '') like '%' ? '%'";
		
		if( count > 0 )
			query += " limit ?";
		
		filterValue = (filterValue != null)? filterValue.replaceAll(" ", ""): "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, filterValue);
			
			if( count > 0 )
				pstmt.setInt(2, count);
			
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
	
	public ArrayList<HashMap<String, Object>> getArtistList(String filter, String filter_content)
	{
		connectSQL();
		
		String query = "select * from artist where replace(artist_no, ' ', '') like '%' ? '%'";
		
		if( filter.equals("all") )
			query = "select * from artist where replace(name, ' ', '') like '%' ? '%' or replace(nation_no, ' ', '') like '%' ? '%'";
		else if( filter.equals("name") )
			query = "select * from artist where replace(name, ' ', '') like '%' ? '%'";
		else if( filter.equals("nation") )
			query = "select * from artist where replace(nation_no, ' ', '') like '%' ? '%'";
		
		filter_content = filter_content.replaceAll(" ", "");
		
		try 
		{
			pstmt = con.prepareStatement(query);
			
			if( filter.equals("all") )
			{
				pstmt.setString(1, filter_content);
				pstmt.setString(2, filter_content);
			}
			else
				pstmt.setString(1, filter_content);
			
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
	
	public HashMap<String, Object> getArtistInfo(String artist_no)
	{
		connectSQL();
		
		String query = "select * from artist where artist_no=?";
		
		map = new HashMap<String, Object> ();
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, artist_no);
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
	
	public ArrayList<HashMap<String, Object>> getGroupMemberInfo(String artist_no)
	{
		connectSQL();
		
		String query = "select * from artist where group_name like '%' ? '%'";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, artist_no);
			rs = pstmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>> ();

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
	
	public String getName(String artist_no)
	{
		connectSQL();
		
		if( artist_no.equals("외국인작곡가들") )
			return artist_no;
		
		String query = "select name from artist where artist_no=?";
		String name = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, artist_no);
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
	
	public String getEnabledArtistNo()
	{
		connectSQL();
		
		String query = "select max(artist_no) from artist";
		String artist_no = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			artist_no = rs.getString(1);
			
			if( artist_no == null )
				artist_no = "000001";
			else
			{
				int temp_no = Integer.parseInt(artist_no) + 1;
				artist_no = String.format("%06d", temp_no);
			}

			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return artist_no;
	}
	
	public void addArtist(String artist_no, String nation_no, String name, String group_name, String debut_date, String profile_image, String job, String gender, String agency, String position)
	{
		connectSQL();
		
		String query = "insert into artist values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, artist_no);
			pstmt.setString(2, nation_no);
			pstmt.setString(3, name);
			pstmt.setString(4, group_name);
			pstmt.setString(5, debut_date);
			pstmt.setString(6, profile_image);
			pstmt.setString(7, job);
			pstmt.setString(8, gender);
			pstmt.setString(9, agency);
			pstmt.setString(10, position);
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