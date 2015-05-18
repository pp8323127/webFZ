package credit;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2008/5/19
 */
public class CreditList
{

    public static void main(String[] args)
    {
        CreditList cl = new CreditList();
        cl.getNewCreditCrewList("2012/04/30","0020","TPEKIX");
    
        cl.getCreditList("N","635335");
//        cl.getNewCreditList("2010/10/01","2010/10/31","KHH"); 
        System.out.println(cl.getObjAL().size());
    }    
	
	private ArrayList objAL = new ArrayList();
	private	String sql = "";
	private String errorstr ="";
	
//	used_ind --> Y or N or ALL
	public String getCreditList(String used_ind, String empno) 
	{		    
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();

		    ConnDB cn = new ConnDB();		   
//		    User connection pool  ********
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);
//			stmt = conn.createStatement();
			
//			cn.setORP3FZUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();
		    
            if("Y".equals(used_ind))
			{
                sql = " SELECT sno, empno, sern, cname, ename, formno," +
                	  " Decode(reason,'1','銷售高手','2','額外換班單','3','飛時破百','4','其它換班單','5','其它選班單') reason, " +
                	  " crdt.comments comments, To_Char(edate,'yyyy/mm/dd') edate, " +
                	  " Decode(intention,'1','積點選班','2','積單換班','3','全勤選班','4','其它選班') intention, " +
                	  " used_ind, upduser, to_char(upddate,'yyyy/mm/dd') upddate FROM egtcrdt crdt, egtcbas cbas WHERE Trim(cbas.empn) = crdt.empno " +
                	  " AND used_ind = 'Y' and empno ='"+empno+"'";			
			}
            else if("N".equals(used_ind))
            {
                sql = " SELECT sno, empno, sern, cname, ename, formno," +
		          	  " Decode(reason,'1','銷售高手','2','額外換班單','3','飛時破百','4','其它換班單','5','其它選班單') reason, " +
		          	  " crdt.comments comments, To_Char(edate,'yyyy/mm/dd') edate, " +
		          	  " Decode(intention,'1','積點選班','2','積單換班','3','全勤選班','4','其它選班') intention, " +
		          	  " used_ind, upduser, to_char(upddate,'yyyy/mm/dd') upddate FROM egtcrdt crdt, egtcbas cbas WHERE Trim(cbas.empn) = crdt.empno " +
		          	  " AND (used_ind = 'N' and (edate>=trunc(sysdate,'dd') or edate is null))and empno ='"+empno+"'";			         
            }
            else//ALL
            {
                sql = " SELECT sno, empno, sern, cname, ename, formno," +
		          	  " Decode(reason,'1','銷售高手','2','額外換班單','3','飛時破百','4','其它換班單','5','其它選班單') reason, " +
		          	  " crdt.comments comments, To_Char(edate,'yyyy/mm/dd') edate, " +
		          	  " Decode(intention,'1','積點選班','2','積單換班','3','全勤選班','4','其它選班') intention, " +
		          	  " used_ind, upduser, to_char(upddate,'yyyy/mm/dd') upddate FROM egtcrdt crdt, egtcbas cbas WHERE Trim(cbas.empn) = crdt.empno " +
		          	  " and empno ='"+empno+"'";	
            }
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    CreditObj obj = new CreditObj();
			    obj.setSno(rs.getInt("sno"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setCname(rs.getString("cname"));
			    obj.setEname(rs.getString("ename"));
			    obj.setReason(rs.getString("reason"));
			    obj.setComments(rs.getString("comments"));
			    obj.setEdate(rs.getString("edate"));
			    obj.setIntention(rs.getString("intention"));
			    obj.setUsed_ind(rs.getString("used_ind"));
			    obj.setUpduser(rs.getString("upduser"));
			    obj.setUpddate(rs.getString("upddate"));
			    obj.setFormno(rs.getString("formno"));
			    objAL.add(obj);
			}
			
			return "Y";
		} 
		catch (Exception e) 
		{
			return e.toString();
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
	
    //依開立月份查詢
	public String getNewCreditList(String sdate, String edate, String base) 
	{		    
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		
		try 
		{
			// connection Pool
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
		    

            sql = " SELECT sno, empno, sern, cname, ename, groups,formno," +
	          	  " Decode(reason,'1','銷售高手','2','額外換班單','3','飛時破百','4','其它換班單','5','其它選班單') reason, " +
	          	  " crdt.comments comments, To_Char(edate,'yyyy/mm/dd') edate, " +
	          	  " Decode(intention,'1','積點選班','2','積單換班','3','全勤選班','4','其它選班') intention, " +
	          	  " used_ind, upduser, to_char(upddate,'yyyy/mm/dd hh24:mi') upddate, crdt.newuser newuser, " +
	          	  " to_char(crdt.newdate,'yyyy/mm/dd hh24:mi') newdate FROM egtcrdt crdt, egtcbas cbas " +
	          	  " WHERE Trim(cbas.empn) = crdt.empno and crdt.newdate BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
	          	  " AND To_Date('"+edate+" 23:59','yyyy/mm/dd hh24:mi') " +
	          	  " AND cbas.station = '"+base+"'  ORDER BY groups, crdt.empno ";	     
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    CreditObj obj = new CreditObj();
			    obj.setSno(rs.getInt("sno"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setCname(rs.getString("cname"));
			    obj.setEname(rs.getString("ename"));
			    obj.setGroups(rs.getString("groups"));
			    obj.setReason(rs.getString("reason"));
			    obj.setComments(rs.getString("comments"));
			    obj.setEdate(rs.getString("edate"));
			    obj.setIntention(rs.getString("intention"));
			    obj.setUsed_ind(rs.getString("used_ind"));
			    obj.setUpduser(rs.getString("upduser"));
			    obj.setUpddate(rs.getString("upddate"));
			    obj.setFormno(rs.getString("formno"));
			    obj.setNewuser(rs.getString("newuser"));
			    obj.setNewdate(rs.getString("newdate"));
			    objAL.add(obj);
			}
			
			return "Y";
		} 
		catch (Exception e) 
		{
			return e.toString();
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
	
	 //依航班crew list 多筆新增
	public ArrayList getNewCreditCrewList(String fltd, String fltno, String sect) 
	{		    
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
    	       
        try
        {
//            ConnDB cn = new ConnDB();			
//			cn.setORP3EGUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();
            
            
            ConnDB cn = new ConnDB();		   
//		    User connection pool  ********
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
 
            sql = " select To_Char(cflt.fltd,'yyyy/mm/dd') fltd2, cflt.* " +
            	  " FROM egtcflt cflt " +
            	  " WHERE fltd = To_Date('"+fltd+"','yyyy/mm/dd')  AND fltno = '"+fltno+"'" +
            	  " AND sect = '"+sect+"'";
           
//          System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            { 
                CreditObj purobj = new CreditObj();
                purobj.setCname(rs.getString("psrname"));
                purobj.setEmpno(rs.getString("psrempn"));
                purobj.setSern(rs.getString("psrsern"));
                purobj.setGroups("PR");
                
                objAL.add(purobj);                
                
                for(int i=1; i<=20; i++)
                {
                    CreditObj obj = new CreditObj();
                    obj.setCname(rs.getString("crew"+Integer.toString(i)));
                    obj.setGroups(rs.getString("duty"+Integer.toString(i)));
                    obj.setEmpno(rs.getString("empn"+Integer.toString(i)));
                    obj.setSern(rs.getString("sern"+Integer.toString(i)));	                
                    objAL.add(obj);     
                } 
            }   
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }

        return objAL;
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
