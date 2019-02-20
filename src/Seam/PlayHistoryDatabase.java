package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class PlayHistoryDatabase extends CustomDatabase
{
	String []columnList1 = {"", "music_no", "id", "date", "playtime"};
	String []columnList2 = {"", "music_no", "music_name", "play_time", "duration", "play_count", "albumart", "artist_no", "album_no"};	// join with music table
	
	public void addPlayHistory(String music_no, String id, String date, int playtime)
	{
		connectSQL();
		
		String query = "insert into playhistory values(?, ?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, music_no);
			pstmt.setString(2, id);
			pstmt.setString(3, date);
			pstmt.setInt(4, playtime);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	public ArrayList<HashMap<String, Object>> getPlayHistory(String date)
	{
		connectSQL();
		
		String query = "select playhistory.music_no, music.name, sum(playhistory.playtime), music.time, count(playhistory.music_no), music.albumart, music.artist_no, music.album_no from playhistory left outer join music on playhistory.music_no=music.music_no where playhistory.date<=? group by music_no order by count(playhistory.music_no) desc";
		
		list = new ArrayList<HashMap<String, Object>> ();
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			
			while( rs.next() )
			{
				map = new HashMap<String, Object> ();
				
				for( int i = 1; i < columnList2.length; i++ )
					map.put(columnList2[i], rs.getString(i));
								
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
	
	/*public String getName(String nation_no)
	{
		connectSQL();
		
		String query = "select name from nation where nation_no=?";
		String name = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, nation_no);
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
	
	public String getNationNo(String name)
	{
		connectSQL();
		
		String query = "select nation_no from nation where name=?";
		String nation_no = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			nation_no = rs.getString(1);
			
			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return nation_no;
	}*/
}