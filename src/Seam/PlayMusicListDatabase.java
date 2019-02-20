package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class PlayMusicListDatabase extends CustomDatabase
{
	String []columnList = {"", "playlist_no", "music_no"};
	
	public int getPlayListMusicCount(String playlist_no)
	{
		connectSQL();
		
		String query = "select count(*) from playmusiclist group by playlist_no having playlist_no=?";
		int count = 0;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			
			
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				count = rs.getInt(1);
			
			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return count;
	}
	
	public String[] getMusicNoList(String playlist_no)
	{
		connectSQL();
		
		String query = "select music_no from playmusiclist where playlist_no=?";
		String[] music_no_list = null;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			rs = pstmt.executeQuery();
			
			rs.last();
			int rowCount = rs.getRow();
			rs.beforeFirst();
			
			// ResultSetMetaData rsmd = rs.getMetaData();
			
			music_no_list = new String[rowCount];
			int cnt = 0;
			
			while( rs.next() )
				music_no_list[cnt++] = rs.getString(1);
			
			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return music_no_list;
	}
	
	public String getBest1MusicNo(String playlist_no)
	{
		connectSQL();
		
		String query = "select music_no from playhistory group by music_no having music_no in(select music_no from playmusiclist where playlist_no=?) order by count(*) desc limit 1";
		String music_no = "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				music_no = rs.getString(1);
			
			rs.close();
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return music_no;
	}
	
	public void addPlayMusicList(String playlist_no, String music_no)
	{
		connectSQL();
		
		String query = "insert into playmusiclist values(?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			pstmt.setString(2, music_no);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	public void addPlayMusicList(String playlist_no, String[] music_no)
	{
		connectSQL();
		
		String query = "insert into playmusiclist values";
		
		try 
		{
			for( int i = 0; i < music_no.length; i++ )
			{
				query += "('" + playlist_no + "', '" + music_no[i] +"')";
				
				if( i < music_no.length - 1 )
					query += ", ";
			}
		
			stmt = con.createStatement();
			stmt.executeUpdate(query);
			
			stmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}