package credit;

import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2012/05/29
 */
public class CrewPickSKj
{

    public static void main(String[] args)
    {
        CrewPickSKj cps = new CrewPickSKj();  
        cps.setPickSkjRange();
        cps.getGDayQuota("TPE");
//        System.out.println(cps.getObjAL().size());
    }
    
	private String sql = "";
	private ArrayList objAL = new ArrayList();
	private ArrayList skjobjAL = new ArrayList();
	private String range_s = "";//可選班開始日
	private String range_e = "";//可選班結束日	
	
	//判斷可選班的區間
	public void setPickSkjRange()
	{	    
	    Connection conn = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;	
		String pubdate = "";//最近公佈班表的年/月/日
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT yyyy, mm FROM fztspub WHERE pubdate = (SELECT Max(pubdate) FROM fztspub WHERE pubdate <= sysdate ) ";          
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			if (rs.next())
			{
			    pubdate = rs.getString("yyyy")+"/"+rs.getString("mm");
			}
			rs.close();
			
			sql = " SELECT offday FROM egtalco";  
			rs = stmt.executeQuery(sql);			
			if (rs.next())
			{
			    pubdate = pubdate + "/"+rs.getString("offday");
			}
			rs.close();
			
			boolean pick2month = false;
			sql = " SELECT CASE WHEN To_Date('"+pubdate+" 23:59','yyyy/mm/dd hh24:mi') >= SYSDATE " +
				  " THEN  2 ELSE 1  END  pm FROM dual";  
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			if (rs.next())
			{
			    if(rs.getInt("pm") >=2)
			    {
			        pick2month = true;
			    }
			}
			rs.close();
			
			SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");			
	        GregorianCalendar s_cal = new GregorianCalendar();//range_s
	        GregorianCalendar e_cal = new GregorianCalendar();//range_e    
//	        System.out.println("myday "+myday);
	        //**************************************
	        
	        if(pick2month == true)
	        {
	            s_cal.set(Calendar.YEAR,Integer.parseInt(pubdate.substring(0,4)));
	            s_cal.set(Calendar.MONTH,Integer.parseInt(pubdate.substring(5,7))-1);
	            s_cal.set(Calendar.DATE, 1);
		        
		        s_cal.add(Calendar.MONTH, 1);
		        range_s = f.format(s_cal.getTime());		        
	        }
	        else
	        {
	            s_cal.set(Calendar.YEAR,Integer.parseInt(pubdate.substring(0,4)));
	            s_cal.set(Calendar.MONTH,Integer.parseInt(pubdate.substring(5,7))-1);       
		        s_cal.set(Calendar.DATE, 10);
		        
		        s_cal.add(Calendar.MONTH, 2);
		        range_s = f.format(s_cal.getTime());	        
	        }
	        
	        e_cal.set(Calendar.YEAR,Integer.parseInt(pubdate.substring(0,4)));
            e_cal.set(Calendar.MONTH,Integer.parseInt(pubdate.substring(5,7))-1);
            e_cal.set(Calendar.DATE, 1);	        
	        e_cal.add(Calendar.MONTH, 3);		   
	        e_cal.add(Calendar.DATE, -1);  
	        range_e = f.format(e_cal.getTime());
	        
//	        System.out.println("s_range "+range_s);    
//	        System.out.println("e_range "+range_e);    
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}		

	}
	
	public void getGDayQuota(String station)
	{	    
	    Connection conn = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT seq, to_char(fltd,'yyyy/mm/dd') fltd, weekday, pr, ff, fy, fc, my " +
            	  " FROM fztgday WHERE gdate BETWEEN To_Date('"+range_s+"','yyyy/mm/dd')  " +
            	  " AND To_Date('"+range_e+"','yyyy/mm/dd') and station = '"+station+"' ORDER BY gdate asc ";          
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			while (rs.next())
			{
			    EPickSkjObj obj = new EPickSkjObj();
			    obj.setSeq(rs.getString("seq"));
			    obj.setFltd(rs.getString("fltd"));
			    obj.setWeekday(rs.getString("weekday"));
			    obj.setPr(rs.getString("pr"));
			    obj.setFf(rs.getString("ff"));
			    obj.setFy(rs.getString("fy"));
			    obj.setFc(rs.getString("fc"));
			    obj.setMy(rs.getString("my"));
			    obj.setPr_used("0");
			    obj.setFf_used("0");
			    obj.setFy_used("0");
			    obj.setFc_used("0");
			    obj.setMy_used("0");
			    objAL.add(obj);
			}
			
			//已請過的日期及總數
			sql = " SELECT gdate, qual, Count(*) c FROM (  SELECT gdate1 gdate, qual FROM fztpday  " +
				  " WHERE  gdate1 BETWEEN To_Date('"+range_s+"','yyyy/mm/dd')  " +
            	  " AND To_Date('"+range_e+"','yyyy/mm/dd') and station = '"+station+"' " +
            	  " AND (ed_check IS NULL OR ed_check='Y') " +
            	  " UNION SELECT gdate2 gdate, qual FROM fztpday  WHERE  gdate2 BETWEEN To_Date('"+range_s+"','yyyy/mm/dd')  " +
            	  " AND To_Date('"+range_e+"','yyyy/mm/dd') and station = '"+station+"' " +
            	  " AND (ed_check IS NULL OR ed_check='Y')) GROUP BY gdate, qual ";		
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			while (rs.next())
			{
			    for(int i =0; i< objAL.size(); i++)
			    {
			        EPickSkjObj obj = (EPickSkjObj) objAL.get(i);
			        
			        if(rs.getString("gdate").equals(obj.getFltd()))
			        {
			            if("PR".equals(rs.getString("qual")))
			            {
			                obj.setPr_used(rs.getString("c"));
			            }
			            
			            if("FF".equals(rs.getString("qual")))
			            {
			                obj.setFf_used(rs.getString("c"));
			            }
			            
			            if("FY".equals(rs.getString("qual")))
			            {
			                obj.setFy_used(rs.getString("c"));
			            }
			            
			            if("FC".equals(rs.getString("qual")))
			            {
			                obj.setFc_used(rs.getString("c"));
			            }
			            
			            if("MY".equals(rs.getString("qual")))
			            {
			                obj.setMy_used(rs.getString("c"));
			            }
			        }			    
			    }
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}			
			if (conn != null)
				try {
					conn.close();
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
