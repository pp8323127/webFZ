package eg.interview;

import java.sql.*;
import java.util.*;
import ci.db.*;
import eg.*;
/**
 * @author CS71 Created on  2011/1/14
 */
public class InterviewData
{   
    private ArrayList objAL = new ArrayList();
    private String returnStr = "";   
    private String sql = "";     

    public static void main(String[] args)
    { 
        InterviewData itv = new InterviewData();
        System.out.println(itv.getInterviewData("635849").size());
        System.out.println(itv.getStr());
    }

    public ArrayList getInterviewData(String empno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;    
        
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	

			sql = " SELECT v.interview_no, v.empno, c.sern, c.cname, c.jobno, c.GROUPS, c.station, " +
				  " To_Char(v.interview_date,'yyyy/mm/dd') interview_date, To_Char(v.fltd,'yyyy/mm/dd') fltd, " +
				  " v.fltno, v.sect, v.main_item,  v.sub_item, m.item_desc, s.subitem_desc,  v.subject, v.crew_desc, " +
				  " v.manager_desc, REPLACE(v.suggestion,',','¡A') suggestion,  v.close_user, " +
				  " To_Char(v.close_date,'yyyy/mm/dd hh24:mi') close_date, v.if_notice,  v.new_user, " +
				  " To_Char(v.new_date,'yyyy/mm/dd hh24:mi') new_date,  v.upd_user, " +
				  " To_Char(v.upd_date,'yyyy/mm/dd hh24:mi') upd_date,  " +
				  " To_Char(v.acknowledge_tmst,'yyyy/mm/dd hh24:mi') acknowledge_tmst " +
				  " FROM egtintv v, egtcbas c , egtitvm m, egtitvs s " +
				  " WHERE v.empno  = '"+empno+"' and v.close_user is not null and v.acknowledge_tmst is null  " +
				  " AND if_notice ='Y' " +
				  " AND v.empno = Trim(c.empn) AND m.item_no = s.item_no  AND v.main_item = m.item_no  " +
				  " AND v.sub_item = s.subitem_no order by v.empno  ";			
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            while (rs.next()) 
            {
                InterviewObj obj = new InterviewObj();    
                obj.setInterview_no(rs.getString("interview_no"));
                obj.setEmpno(rs.getString("empno"));
                obj.setSern(rs.getString("sern"));
                obj.setCname(rs.getString("cname"));
                obj.setJobno(rs.getString("jobno"));
                obj.setGrp(rs.getString("GROUPS"));
                obj.setBase(rs.getString("station"));
                obj.setInterview_date(rs.getString("interview_date"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setMain_item(rs.getString("main_item"));
                obj.setSub_item(rs.getString("sub_item"));
                obj.setMain_item_desc(rs.getString("item_desc"));
                obj.setSub_item_desc(rs.getString("subitem_desc"));
                obj.setSubject(rs.getString("subject"));
                obj.setCrew_desc(rs.getString("crew_desc"));
                obj.setManager_desc(rs.getString("manager_desc"));
                obj.setSuggestion(rs.getString("suggestion"));
                obj.setNew_user(rs.getString("new_user"));
                obj.setNew_date(rs.getString("new_date"));
                obj.setUpd_user(rs.getString("upd_user"));
                obj.setUpd_date(rs.getString("upd_date"));
                obj.setClose_user(rs.getString("close_user"));
                obj.setClose_date(rs.getString("close_date"));
                obj.setIf_notice(rs.getString("if_notice"));
                obj.setAcknowledge_tmst(rs.getString("acknowledge_tmst"));
                obj.setSuggestionAL(getSuggestion(obj.getInterview_no()));
                obj.setAttachAL(getInterviewAttach(obj.getInterview_no()));                 
                objAL.add(obj);
            }
            returnStr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}
        }
        return objAL;
    }
    
    public ArrayList getInterviewAttach(String interview_no)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        ArrayList attachAL = new ArrayList();
       
        
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	
			
		    sql = " SELECT * FROM egtitvf WHERE interview_no = to_number("+interview_no+") ";		
			
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            while (rs.next()) 
            {
                InterviewAttachObj obj = new InterviewAttachObj();
                obj.setInterview_no(rs.getString("interview_no"));
                obj.setSeq(rs.getString("seq"));
                obj.setAttach_name(rs.getString("attach_name"));
                obj.setAttach_desc(rs.getString("attach_desc"));
                attachAL.add(obj);
            }
            returnStr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}
        }
        return attachAL;
    }
    
    public ArrayList getSuggestion(String interview_no)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        ArrayList suggAL = new ArrayList();
       
        
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	
			
		    sql = " SELECT interview_no,handle_user_orig,handle_user,REPLACE(handle_user_comm,',','¡A') handle_user_comm," +
		    	  " assign_user,to_char(assign_date,'yyyy/mm/dd hh24:mi') assign_date, " +
		    	  " to_char(close_date,'yyyy/mm/dd hh24:mi') close_date " +
		    	  " FROM egtsugg WHERE interview_no = to_number("+interview_no+") ";		
			
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);            
            
            while (rs.next()) 
            {
                InterviewSuggestionObj obj = new InterviewSuggestionObj();
                obj.setInterview_no(rs.getString("interview_no"));
                obj.setHandle_user_orig(rs.getString("handle_user_orig"));
                if(obj.getHandle_user_orig() != null)
                {
	                HRInfo hrc = new HRInfo(rs.getString("handle_user_orig"));
	                obj.setHandle_user_orig_name(hrc.getCname(rs.getString("handle_user_orig")));
                }
                obj.setHandle_user(rs.getString("handle_user"));
                if(obj.getHandle_user() != null)
                {
	                HRInfo hrc = new HRInfo(rs.getString("handle_user"));
	                obj.setHandle_user_name(hrc.getCname(rs.getString("handle_user")));
                }
                obj.setHandle_user_comm(rs.getString("handle_user_comm"));
                obj.setAssign_user(rs.getString("assign_user"));     
                if(obj.getAssign_user() != null)
                {
	                HRInfo hrc = new HRInfo(rs.getString("assign_user"));
	                obj.setAssign_user_name(hrc.getCname(rs.getString("assign_user")));
                }
                obj.setAssign_date(rs.getString("assign_date"));
                obj.setClose_date(rs.getString("close_date"));     
                suggAL.add(obj);
            }
            returnStr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}
        }
        return suggAL;
    }
        
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return  returnStr;
    }
    
    public String getSql()
    {
        return sql;
    }
}
