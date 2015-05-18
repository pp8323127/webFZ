package tool;

import java.util.*;

/**
 * @author cs71 Created on  2006/7/5
 */
public class MyHashTable extends Hashtable
{
    	public synchronized Object get(Object arg0) 
    	{
    		Object obj = super.get(arg0);
    		if (obj == null)
    			return "";
    		else
    		    return obj;
    	}
}
