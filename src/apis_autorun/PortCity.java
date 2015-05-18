package apis_autorun;

import java.sql.*;
import java.util.*;

/**
 * @author CS71 Created on  2010/5/31
 */
public class PortCity
{

    ArrayList objAL = new ArrayList();
    public static void main(String[] args)
    {
        PortCity pc = new PortCity();
        pc.getPortCityData();
        PortCityObj obj = pc.getPortCityObj("XIY");
        System.out.println(obj.getScity()+"/"+obj.getLcity()+"/"+obj.getCtry()+"/"+obj.getUsflag());
        	
//        String str = "Hsiu-Hua Yu.Yu (B) ?";
//        System.out.println(str);
//        System.out.println(str.replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?."));
    }
    
    public void getPortCityData()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = "";
        
       try
       {
//         set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
//	        cn.setORT1FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement(); 
	    	
	    	sql = " SELECT  Nvl(scity,' ') scity, Nvl(lcity,' ') lcity, Nvl(ctry,' ') ctry , " +
	    		  " (CASE WHEN (ctry IN ('USA','CANADA','PALAU') OR t.scity='ROR') THEN 'Y' ELSE NULL END) usflag " +
	    		  " FROM fztcity t ";

//System.out.println(sql);	    	
 			rs = stmt.executeQuery(sql);
		  	while (rs.next())
		  	{
		  	    PortCityObj obj = new  PortCityObj();
		  	    obj.setScity(rs.getString("scity"));
		  	    obj.setLcity(rs.getString("lcity"));
		  	    obj.setCtry(rs.getString("ctry"));
		  	    obj.setUsflag(rs.getString("usflag"));
		  	    objAL.add(obj);		  	    
		  	}	    	
       }
		catch (Exception e)
		{
		    System.out.println(e.toString());
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		} 		
   }
    
    public PortCityObj getPortCityObj(String station) 
    {
	    for(int i=0; i<objAL.size(); i++)
	    {
	        PortCityObj obj = (PortCityObj) objAL.get(i);
	        if(station.equals(obj.getScity()))
	        {
	            return obj;
	        }
	    }
        return null;
    }   
}
