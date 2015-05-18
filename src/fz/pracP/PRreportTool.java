package fz.pracP;

import ci.db.*;
import java.sql.*;
import java.util.*;

public class PRreportTool 
{    
    public static void main(String[] args) 
    {
        PRreportTool prt = new PRreportTool();
//	    prt.getCMPDItemdsc("J01");
        prt.getCMPDItemdsc2("J") ;
		ArrayList prt1AL = prt.getObjAL();
		for(int i=0; i<prt1AL.size(); i++)
		{
		    System.out.println(prt1AL.get(i));
		}
        
    }
    
    ArrayList objAL = new ArrayList();    
    String sql = null;        
    
    //get getcmpi item desc
    public String getCMPIItemdsc(String itemno) 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;        
        Driver dbDriver = null;
        objAL.clear();   
        String itemdsc = "";

        try 
        {
            ConnDB cn = new ConnDB();
//            cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = con.createStatement();	
	    	
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL() ,null);            
            stmt = con.createStatement();
	    	
	    	sql = "  select itemdsc from egtcmpi where itemno = '"+itemno+"' and extflag is null order by itemdsc";
		
//          System.out.println(sql);
	    	rs = stmt.executeQuery(sql);            
      
		    while (rs.next()) 
		    {
		        itemdsc = rs.getString("itemdsc");
		    }
		    
		    return itemdsc;
        } 
        catch (Exception e) 
        {            
            return e.toString();
        } 
        finally 
        {
            try {
                if ( rs != null ) rs.close();
            } catch (SQLException e) {}
            try {
                if ( stmt != null ) stmt.close();
            } catch (SQLException e) {}
            try {
                if ( con != null ) con.close();
            } catch (SQLException e) {}
        }
    }
    
    //get getcmpd items desc
    public void getCMPDItemdsc(String itemno) 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;        
        Driver dbDriver = null;
        objAL.clear();   

        try 
        {
            ConnDB cn = new ConnDB();
//            cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = con.createStatement();	
	    	
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL() ,null);            
            stmt = con.createStatement();
	    	
//	    	sql = "  select * from egtcmpd where itemno = '"+itemno+"' and extflag is null order by itemdsc ";
	    	
	    	sql = " SELECT itemdsc FROM ( select itemdsc, 'a' seq from egtcmpd where itemno = '"+itemno+"' " +
	    		  " and extflag is null AND itemdsc NOT LIKE '%其他%' " +
	    		  " UNION select itemdsc, 'b' seq from egtcmpd where itemno = '"+itemno+"' " +
	    		  " and extflag is null AND itemdsc LIKE '%其他%' ) order by seq, itemdsc ";
		
//          System.out.println(sql);
	    	rs = stmt.executeQuery(sql);            
      
		    while (rs.next()) 
		    {
		        objAL.add(rs.getString("itemdsc"));
		    }
        } 
        catch (Exception e) 
        {            
        } 
        finally 
        {
            try {
                if ( rs != null ) rs.close();
            } catch (SQLException e) {}
            try {
                if ( stmt != null ) stmt.close();
            } catch (SQLException e) {}
            try {
                if ( con != null ) con.close();
            } catch (SQLException e) {}
        }
    }
    
//  get getcmpd items desc by egtcmti's item
    public void getCMPDItemdsc2(String kin) 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;        
        Driver dbDriver = null;
        objAL.clear();   

        try 
        {
            ConnDB cn = new ConnDB();
//            cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = con.createStatement();	
	    	
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL() ,null);            
            stmt = con.createStatement();
	    	
	    	sql = " SELECT * FROM ( select itemno,itemdsc, 'pd' lvl, 'a' seq  from egtcmpd " +
	    		  " where itemno like '"+kin+"%' and extflag is null union " +
	    		  " SELECT itemno,itemdsc, 'pi' lvl, 'a' seq FROM egtcmpi " +
	    		  " WHERE itemno LIKE '"+kin+"%' and extflag is null " +
	    		  " AND itemno NOT IN (select itemno from egtcmpd where itemno like '"+kin+"%' and extflag is null) " +
	    		  " AND itemdsc NOT LIKE '%其他%' union SELECT itemno,itemdsc, 'pi' lvl, 'b' seq FROM egtcmpi " +
	    		  " WHERE itemno LIKE '"+kin+"%' and extflag is null AND itemdsc LIKE '%其他%') order by seq, itemno ";
		
//          System.out.println(sql);
	    	rs = stmt.executeQuery(sql);            
      
		    while (rs.next()) 
		    {
		        PRreportToolObj obj = new PRreportToolObj();
		        obj.setPi_itemno(rs.getString("itemno"));
		        obj.setPi_itemdsc(rs.getString("itemdsc"));
		        obj.setLevel(rs.getString("lvl"));
		        objAL.add(obj);
		    }
        } 
        catch (Exception e) 
        {            
        } 
        finally 
        {
            try {
                if ( rs != null ) rs.close();
            } catch (SQLException e) {}
            try {
                if ( stmt != null ) stmt.close();
            } catch (SQLException e) {}
            try {
                if ( con != null ) con.close();
            } catch (SQLException e) {}
        }
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getSQL() 
    {
		return sql;
	}
    
}