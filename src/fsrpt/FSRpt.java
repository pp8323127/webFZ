package fsrpt;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author CS71 Created on  2010/7/29
 */
public class FSRpt
{
    private String sql = "";
    ArrayList objAL = new ArrayList();
    public static void main(String[] args)
    {
        FSRpt fsr = new FSRpt();
        fsr.getFSRptList("631451");
        System.out.println(fsr.getObjAL().size());        
    }
    
    public void getFSRptList(String empno)
    {    
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
    	
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	
			
			sql = " SELECT seq, rpt_subject, rpt_desc, potential_consequence, reply_request," +
				  " To_Char(event_date,'yyyy/mm/dd') event_date, carrier, fltno, sect, actype, acno, new_user, " +
				  " cname, sern, To_Char(new_date,'yyyy/mm/dd hh24:mi') new_date, " +
				  " To_Char(sent_date,'yyyy/mm/dd hh24:mi') sent_date, chg_user, " +
				  " To_Char(chg_date,'yyyy/mm/dd hh24:mi') chg_date, close_user, " +
				  " To_Char(close_date,'yyyy/mm/dd hh24:mi') close_date " +
				  " FROM egtfsrpt fs, egtcbas cb WHERE fs.new_user = Trim(cb.empn) AND new_user = '"+empno+"'";
			
//			System.out.println(sql);			
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{ 
			    FSRptObj obj = new FSRptObj();
			    obj.setSeq(rs.getString("seq"));
			    obj.setRpt_subject(rs.getString("rpt_subject"));
			    obj.setRpt_desc(rs.getString("rpt_desc"));
			    obj.setPotential_consequence(rs.getString("potential_consequence"));
			    obj.setReply_request(rs.getString("reply_request"));
			    obj.setEvent_date(rs.getString("event_date"));
			    obj.setCarrier(rs.getString("carrier"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setSect(rs.getString("sect"));
			    obj.setActype(rs.getString("actype"));
			    obj.setAcno(rs.getString("acno"));
			    obj.setNew_user(rs.getString("new_user"));
			    obj.setNew_user_name(rs.getString("cname"));
			    obj.setNew_user_sern(rs.getString("sern"));
			    obj.setNew_date(rs.getString("new_date"));
			    obj.setSent_date(rs.getString("sent_date"));
			    obj.setChg_user(rs.getString("chg_user"));			    
			    obj.setChg_date(rs.getString("chg_date"));
			    obj.setClose_user(rs.getString("close_user"));
			    obj.setClose_date(rs.getString("close_date"));
			    objAL.add(obj);
			}
        }
        catch (Exception e)
        {
                System.out.println(e.toString());	
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
    }  
    
    public void getFSSubjectItem()
    {    
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
    	
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();				
			
			sql = " SELECT seq, rpt_subject FROM egtfssubj order by seq";
			
//			System.out.println(sql);			
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{ 
			    FSSubjectItemObj obj = new FSSubjectItemObj();
			    obj.setSeq(rs.getString("seq"));
			    obj.setSubject(rs.getString("rpt_subject"));			    
			    objAL.add(obj);
			}
        }
        catch (Exception e)
        {
                System.out.println(e.toString());	
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
    } 
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getSql()
    {
        return sql;
    }
    
}
