package pay;

import java.io.*;
import java.sql.*;
import java.util.*;

/**
 * @author cs71 Created on  2006/11/30
 */
public class TaxiData
{

    public static void main(String[] args)
    {
        TaxiData t = new TaxiData();
        t.readFile("taxi.csv");      
        ArrayList objAL = new ArrayList();
        objAL = t.getObjAL();
        System.out.println(objAL.size());
    }
    
	private String filename = null;
//	private String path 	= "C:\\FZTemp\\";
	private String path = "/apsource/csap/projfz/webap/FZ/tsa/mealtaxi/File/";
	private String userid 	= "";
	private String mark 	= "";
	private Connection conn = null;
	private Driver dbDriver = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null; 
	private String sql = "";
	private String returnstr = "The file is blank !";
	private String returnstr2 = "he file is blank !";
	private ArrayList objAL = new ArrayList();
	private Hashtable taxiHT = new Hashtable();
	
	public void readFile(String filename)
	{
	    try
	    {
			java.io.File file_in=new java.io.File(path+filename);			
			
			if (file_in.canRead() == true)
			{
				BufferedReader br = new BufferedReader(new FileReader(file_in));
				StringBuffer sb = null;
				String str = null;
				int firstline = 1;

				while ((str = br.readLine()) != null) 
				{
				    //the first line for column name, ignore
				    if (firstline > 1)
				    {
						splitString s = new splitString();
						String[] token = s.doSplit(str,",");    
					
						if(token[0].toString()!= null && !"".equals(token[0].toString()))
						{
							if("".equals((String)taxiHT.get(token[0])) || taxiHT.get(token[0])== null)
							{
							    taxiHT.put(token[0],token[1]);
							}
							else
							{
							    taxiHT.put(token[0], String.valueOf(Integer.parseInt((String)taxiHT.get(token[0]))+Integer.parseInt(token[1])));
							}	
						}
				    }
				    firstline ++;			    
				}
				br.close();

				if (taxiHT.size()> 0) 
	            {
				    Set keyset = taxiHT.keySet();
			        Iterator i = keyset.iterator();
			        while(i.hasNext())
			    	{
			    	    String key = String.valueOf(i.next());
			    	    SrcObj obj = new SrcObj();
		                obj.setEmpno(key);
		                obj.setAmount(taxiHT.get(key).toString());
		                objAL.add(obj);
			    	} 	                
	            } 
				
				returnstr = "Y";
			}
			else
			{
			    returnstr = "Can not read the file!!";
			}
	    }
	    catch (Exception e)
	    {
	    	System.out.print("Read file error : " +e.toString());
	        returnstr = e.toString();
	    }
	    finally
	    {            
	    }	    
	}
	
	 public ArrayList getObjAL()
	 {
	     return objAL;
	 }  	
	    
    public String getStr()
    {
        return returnstr;
    } 
	
	
}
