package Seam;

import java.util.*;
import java.sql.Timestamp;
import java.text.*;

public class MapComparator implements Comparator<HashMap<String, Object>>
{
    private final String key;

    public MapComparator(String key)
    {
        this.key = key;
    }

	@Override
	public int compare(HashMap<String, Object> first, HashMap<String, Object> second)
	{
		// TODO: Null checking, both for maps and values
		
		String firstValue = "";
		String secondValue = "";
		
		if (first.get(key) instanceof Integer)
		{
			firstValue = Integer.toString((int) (first.get(key)));
			secondValue = Integer.toString((int) (second.get(key)));
		}
		else if( first.get(key) instanceof Timestamp )
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss.SS");
			firstValue = sdf.format(first.get(key));
			secondValue = sdf.format(second.get(key));
		}
		else
		{
	        firstValue = (String) first.get(key);
	        secondValue = (String) second.get(key);
		}
		
        return firstValue.compareTo(secondValue);
	}
}
