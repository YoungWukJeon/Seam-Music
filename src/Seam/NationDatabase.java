package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class NationDatabase extends CustomDatabase
{
	String []columnList = {"", "nation_no", "name"};
	
	public String getName(String nation_no)
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
	}
}