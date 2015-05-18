package eg;

import java.sql.*;
import java.util.Calendar;

import ci.db.*;

/**
 * @author cs71 Created on  2007/9/6
 * cs80 2012/12/11 改職稱
 */ 
public class GetJobType
{	
    public static void main(String[] args)
    {
        System.out.println(GetJobType.getEmpJobType("633020")); 
    	boolean newName = false;
        Calendar calendar = Calendar.getInstance();
        String thisY = Integer.toString(calendar.get(Calendar.YEAR));
        if(Integer.parseInt(thisY) > 2012){
        	newName=true;
        }
        System.out.println(newName);
        
    }
    
    public static String getEmpJobType(String empno) 
    {              
        int jobno = 999;
	    String sex = "";
	    String base = "";
	    String spcode = "";
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		String sql = null;
		String jobtype = "";
		String returnstr = "";
		//2013/1/1改職稱PR->CM,ZC->PR
		boolean newName = false;
        Calendar calendar = Calendar.getInstance();
        String thisY = Integer.toString(calendar.get(Calendar.YEAR));
        if(Integer.parseInt(thisY) > 2012){
        	newName=true;
        }
		
        try
        {
//            EGConnDB cn = new EGConnDB();
////            cn.setORP3EGUserCP(); 
////	    	java.lang.Class.forName(cn.getDriver());
////	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());  
//	    	
//	    	cn.setORP3EGUser();    
////          cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//            stmt = conn.createStatement();	
            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
			
			sql = " SELECT nvl(jobno,120) jobno, sex, station, Nvl(specialcode,'-') specialcode FROM egtcbas " +
				  " WHERE empn = '"+empno+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
			    jobno = rs.getInt("jobno");
			    sex = rs.getString("sex");
			    base = rs.getString("station");
			    spcode = rs.getString("specialcode");
			}			
			
			if(jobno <= 80 && "TPE".equals(base))
			{	
				if(newName){
					return "TPE CM";//客艙經理
				} else{
				    return "TPE PUR";   
				}				
			}
			else if ("TPE".equals(base) && "J".equals(spcode))
			{
			    return "TPE TYO";
			}
			else if ("TPE".equals(base) && "K".equals(spcode))
			{
			    return "TPE KOR";
			} 
			else if ("TPE".equals(base) && "I".equals(spcode))
			{
			    return "TPE ITY";
			}
			else if (jobno == 95 && "TPE".equals(base))
			{
				if(newName){
					return "TPE PR";//事務長
				}else{
				    return "TPE ZC";
				} 
			}
			else if ((jobno == 90 || jobno == 110) && "TPE".equals(base))
			{
			    return "TPE FA";
			}
			else if ((jobno == 100 || jobno == 120) && "TPE".equals(base))
			{
			    return "TPE FS";
			}    
			else if(jobno <= 80 && "KHH".equals(base))
			{
				if(newName){
					return "KHH CM"; 
				}else{
				    return "KHH PUR";
				}  
			} 
			else if ((jobno == 110 || jobno == 120 || jobno == 95) && "KHH".equals(base))
			{
			    return "KHH CREW";
			}
			else
			{
			    return "";
			}
        }
        catch (Exception e)
        {               
               System.out.println(e.toString());
               returnstr = e.toString();
               return e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
   } 
}
