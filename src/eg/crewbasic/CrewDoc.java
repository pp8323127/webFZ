package eg.crewbasic;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author CS71 Created on  2010/8/5
 */
public class CrewDoc
{
    private ArrayList objAL = new ArrayList();
    private String returnStr = "";   
    private String sql = ""; 
    private String empno = "";
    
    public static void main(String[] args)
    {        
    
        CrewDoc cd = new CrewDoc("634952");
        ArrayList al = new ArrayList();
        
        al = cd.getObjAL();
        for(int i=0; i<al.size(); i++)
        {
            CrewDocObj obj = (CrewDocObj) al.get(i);
            System.out.print(obj.getEmpno());
            System.out.print("  "+obj.getDoc_type());
            System.out.print("  "+obj.getDoc_num());
            System.out.print("  "+obj.getDoc_issue_date());
            System.out.println("  "+obj.getDoc_due_date());
            System.out.println("**************************");
        }
    }
    
    public  CrewDoc (String empno)
    {
        this.empno = empno;
        getEGData();
        getSecondDocData();
        getAirCrewsData();
    }
    
    private void  getEGData ()
    {
        eg.EGInfo egi = new eg.EGInfo(empno);
        eg.EgInfoObj obj = egi.getEGInfoObj(empno); 
        
        //****************************************
        CrewDocObj cdobj = new CrewDocObj();
        cdobj.setEmpno(obj.getEmpn());
        cdobj.setDoc_type("ROC Passport");
        cdobj.setDoc_num(obj.getPassport());
        cdobj.setDoc_issue_date("X");
        cdobj.setDoc_due_date(obj.getPassdate());
        objAL.add(cdobj);
        //****************************************
        if(!"".equals(obj.getVisadate()) && obj.getVisadate() != null)
        {
	        cdobj = new CrewDocObj();
	        cdobj.setEmpno(obj.getEmpn());
	        cdobj.setDoc_type("USA Visa");    
	        cdobj.setDoc_num("X");
	        cdobj.setDoc_issue_date("X");
	        cdobj.setDoc_due_date(obj.getVisadate());
	        objAL.add(cdobj);
        }
        //****************************************        
    }
    
    private void  getAirCrewsData ()
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

            sql = " SELECT staff_num, licence_num, nvl(To_char(str_dt,'yyyy/mm/dd'),'N/A') str_dt, " +
            	  " nvl(To_char(exp_dt,'yyyy/mm/dd'),'N/A') exp_dt FROM fzdb.crew_licence_v " +
            	  " WHERE staff_num = '"+empno+"' AND licence_cd = 'CHN' ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                CrewDocObj cdobj = new CrewDocObj();
                cdobj.setEmpno(rs.getString("staff_num"));
                cdobj.setDoc_type("台胞証");
                cdobj.setDoc_num(rs.getString("licence_num"));
                cdobj.setDoc_issue_date(rs.getString("str_dt"));
                cdobj.setDoc_due_date(rs.getString("exp_dt"));        
                objAL.add(cdobj);       
            }
            rs.close();
            
            sql = " SELECT staff_num, nvl(To_char(issue_dt,'yyyy/mm/dd'),'N/A') issue_dt, " +
            	  " nvl(To_char(exp_dt,'yyyy/mm/dd'),'N/A') exp_dt " +
            	  " FROM fzdb.crew_visa_v WHERE visa_type ='CHN' AND ctry_cd = 'CN' AND staff_num = '"+empno+"'";
      
		//      System.out.println(sql);
		      rs = stmt.executeQuery(sql);
		
		    while (rs.next()) 
		    {
		        CrewDocObj cdobj = new CrewDocObj();
		        cdobj.setEmpno(rs.getString("staff_num"));
		        cdobj.setDoc_type("台胞証內頁加簽");
		        cdobj.setDoc_num("X");
//		        cdobj.setDoc_issue_date(rs.getString("issue_dt"));
		        cdobj.setDoc_issue_date("X");
		        cdobj.setDoc_due_date(rs.getString("exp_dt"));        
		        objAL.add(cdobj);       
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
    }// end of public HRInfo(String empno) 
    
    private void  getSecondDocData ()
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

            sql = " select empno, issue_nation, pass_no, nvl(to_char(issue_date,'yyyy/mm/dd'),'N/A') issue_date, " +
            	  " nvl(to_char(exp_date,'yyyy/mm/dd'),'N/A') exp_date, ename, doc_tp " +
            	  " from egtpass where trim(empno)=trim('"+empno+"') order by issue_nation ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                CrewDocObj cdobj = new CrewDocObj();
                cdobj.setEmpno(rs.getString("empno"));
                String str = rs.getString("issue_nation").trim();
                if("C".equals(rs.getString("doc_tp")))
                {
                    str = str + " Green card";
                }
                else
                {
                    str = str + " Passport ";
                }
                
                cdobj.setDoc_type(str);
                cdobj.setDoc_num(rs.getString("pass_no"));
                cdobj.setDoc_issue_date(rs.getString("issue_date"));
                cdobj.setDoc_due_date(rs.getString("exp_date"));
                cdobj.setDoc_ename(rs.getString("ename"));                
                objAL.add(cdobj);       
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
