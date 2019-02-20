package Seam;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class MusicDatabase extends CustomDatabase
{
	String []columnList = {"", "music_no", "nation_no", "name", "artist_no", "song_writer", "lyric_writer", "album_no", "albumart", "lyrics", "genre", "release_date", "track", "tag", "time", "isTitle", "isAdult"};
	
	public ArrayList<HashMap<String, Object>> getMusicList(String filterValue, int count)
	{
		connectSQL();
		
		String query = "select * from music where replace(name, ' ', '') like '%' ? '%'";
		
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
	
	public ArrayList<HashMap<String, Object>> getLyricsIncludeMusicList(String filterValue, int count)
	{
		connectSQL();
		
		String query = "select * from music where replace(lyrics, ' ', '') like '%' ? '%'";
		
		if( count > 0 )
			query += " limit ?";
		
		filterValue = (filterValue != null)? filterValue.replaceAll(" ", ""): "";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, filterValue);
			
			list = new ArrayList<HashMap<String, Object>> ();
			
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
	
	public ArrayList<HashMap<String, Object>> getMusicList(String filter, String filter_content)
	{
		connectSQL();
		
		String query = "select * from music";
		
		try 
		{
			pstmt = con.prepareStatement(query);
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
	
	public Object getMusicPartInfo(String music_no, String partColumn)
	{
		connectSQL();
		
		String query = "select " + partColumn + " from music where music_no=?";
		Object partInfo = null;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, music_no);
			
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
	
	public ArrayList<HashMap<String, Object>> getMusicList(String playlist_no)
	{
		connectSQL();
		
		String query = "select * from music where music_no in(select music_no from playmusiclist where playlist_no=?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, playlist_no);
			
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
	
	public ArrayList<HashMap<String, Object>> getAlbumMusicList(String album_no)
	{
		connectSQL();
		
		String query = "select * from music where album_no=?";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, album_no);
			
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
	
	public int getAlbumMusicListCount(String album_no)
	{
		connectSQL();
		
		String query = "select count(*) from music where album_no=?";
		int count = 0;
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, album_no);
			
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
	
	public ArrayList<HashMap<String, Object>> getArtistMusicList(String artist_no)
	{
		connectSQL();
		
		String query = "select * from music where artist_no like '%' ? '%' or song_writer like '%' ? '%' or lyric_writer like '%' ? '%'";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, artist_no);
			pstmt.setString(2, artist_no);
			pstmt.setString(3, artist_no);
			
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
	
	public ArrayList<HashMap<String, Object>> getLikeMusicList(String id)
	{
		connectSQL();
		
		String query = "select * from music where music_no in(select item_no from preference where kind='music' and id=?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
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
	
	public HashMap<String, Object> getMusicInfo(String music_no)
	{
		connectSQL();
		
		String query = "select * from music where music_no=?";
		
		map = new HashMap<String, Object>();
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, music_no);
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
	
	public ArrayList<HashMap<String, Object>> getMemberBestGenre(String id)
	{
		connectSQL();
		
		String query = "select music.genre, count(music.genre) from playhistory inner join music on playhistory.music_no=music.music_no where playhistory.id=? group by music.genre order by count(music.genre) desc";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>> ();

			while (rs.next())
			{
				map = new HashMap<String, Object>();

				map.put("genre", rs.getString(1));
				map.put("count", rs.getInt(2));

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
	
	public ArrayList<HashMap<String, Object>> getNewMusicList()
	{
		connectSQL();
		
		String query = "select * from music order by release_date desc limit 0, 10";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			
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
	
	public String getEnabledMusicNo(String date)
	{
		connectSQL();
		
		date = date.substring(0, 6);
		
		String query = "select max(music_no) from music where music_no like ? '%'";
		String music_no = "";
		
		try
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			music_no = rs.getString(1);
			
			if( music_no == null )
				music_no = date + "_0001";
			else
			{
				int temp_no = Integer.parseInt(music_no.substring(7, 11)) + 1;
				music_no = date + "_" + String.format("%04d", temp_no);
			}

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
	
	public void addMusic(String music_no, String nation_no, String name, String artist_no, String song_writer, String lyric_writer, String album_no, String albumart, String lyrics, String genre, String release_date, String track, String tag, String time, String isTitle, String isAdult)
	{
		connectSQL();
		
		String query = "insert into music values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, music_no);
			pstmt.setString(2, nation_no);
			pstmt.setString(3, name);
			pstmt.setString(4, artist_no);
			pstmt.setString(5, song_writer);
			pstmt.setString(6, lyric_writer);
			pstmt.setString(7, album_no);
			pstmt.setString(8, albumart);
			pstmt.setString(9, lyrics);
			pstmt.setString(10, genre);
			pstmt.setString(11, release_date);
			pstmt.setString(12, track);
			pstmt.setString(13, tag);
			pstmt.setString(14, time);
			pstmt.setString(15, isTitle);
			pstmt.setString(16, isAdult);
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	
	
	
	/*public ArrayList<HashMap<String, Object>> getMusicList(String filter, String filter_content)
	{
		connectSQL();
		
		String query = "select * from music where replace(music_no, ' ', '') like '%' ? '%'";
		
		if( filter.equals("all") )
			query = "select * from music where replace(name, ' ', '') like '%' ? '%' or replace(music_no, ' ', '') like '%' ? '%'";
		else if( filter.equals("title") )
			query = "select * from music where replace(name, ' ', '') like '%' ? '%'";
		else if( filter.equals("music") )
			query = "select * from music where replace(music_no, ' ', '') like '%' ? '%'";
		else if( filter.equals("lyrics") )
			query = "select * from music where replace(lyrics, ' ', '') like '%' ? '%'";
		
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
	}*/
}
