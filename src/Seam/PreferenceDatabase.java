package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class PreferenceDatabase extends CustomDatabase
{
	String []columnList = {"", "kind", "item_no", "id"};
	
	public int getLikeCount(String kind, String item_no, String id)
	{
		connectSQL();
		
		String query = (id == null)? "select count(*) from preference where kind=? and item_no=?": "select count(*) from preference where kind=? and item_no=? and id=?";
		int count = 0;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, kind);
			pstmt.setString(2, item_no);
			
			if( id != null )
				pstmt.setString(3, id);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
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
	
	public void addLike(String kind, String item_no, String id)
	{
		connectSQL();
		
		String query = "insert into preference values(?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, kind);
			pstmt.setString(2, item_no);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	public void deleteLike(String kind, String item_no, String id)
	{
		connectSQL();
		
		String query = "delete from preference where kind=? and item_no=? and id=?";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, kind);
			pstmt.setString(2, item_no);
			pstmt.setString(3, id);
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