package credit;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2008/5/19
 */
public class SkjPickList
{

    public static void main(String[] args)
    {
        SkjPickList spl = new SkjPickList();
//        spl.getSkjPickList("ALL","641666");
          System.out.println(spl.getPick_Handle_List_newyear_CMPR().size());
          System.out.println(spl.getPick_Handle_List_newyear_FS().size());       
//        spl.getSkjPickList("N","635856");
//        spl.getSkjPickList2("Y","H","200810");
//        spl.getSkjPickList2("Y","A","200810");
//        String v = "happy";
//        v.replaceAll("p","O");
    }
    
	private String sql = "";
	private ArrayList objAL = new ArrayList();
	
//	used_ind --> Y or N or ALL
	public String getSkjPickList(String valid_ind, String empno) 
	{	
	    Connection conn = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;	
		
		try 
		{
			// connection Pool
//		    ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();  
//            stmt = conn.createStatement();
            
		    ConnDB cn = new ConnDB();		   
//		    User connection pool  ********
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
			
//			cn.setORP3FZUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();

            if(empno == null | "".equals(empno))
            {
                if("Y".equals(valid_ind))
				{
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
	                	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
	                	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
	                	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
	                	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
	                	  " FROM egtpick pick, egtcbas cbas " +
	                	  " WHERE Trim(cbas.empn) = pick.empno and valid_ind = 'Y' order by sno desc ";			
				}
	            else if("N".equals(valid_ind))
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station,To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno and valid_ind = 'N' order by sno desc ";					
	            }
	            else//ALL
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno order by sno desc ";				
	            }
            }
            else
            {
	            if("Y".equals(valid_ind))
				{
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
	                	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
	                	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
	                	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
	                	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
	                	  " FROM egtpick pick, egtcbas cbas " +
	                	  " WHERE Trim(cbas.empn) = pick.empno and empno ='"+empno+"' and valid_ind = 'Y' order by sno desc ";			
				}
	            else if("N".equals(valid_ind))
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno and empno ='"+empno+"' and valid_ind = 'N' order by sno desc ";					
	            }
	            else//ALL
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno and empno ='"+empno+"' order by sno desc ";				
	            }
            }
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    SkjPickObj obj = new SkjPickObj();
			    obj.setSno(rs.getInt("sno"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setCname(rs.getString("cname"));
			    obj.setEname(rs.getString("ename"));
			    obj.setBase(rs.getString("station"));
			    obj.setNew_tmst(rs.getString("new_tmst"));
			    obj.setReason(rs.getString("reason"));
			    obj.setValid_ind(rs.getString("valid_ind"));
			    obj.setSdate(rs.getString("sdate"));
			    obj.setEdate(rs.getString("edate"));
			    obj.setComments(rs.getString("comments"));
			    obj.setEd_user(rs.getString("ed_user"));
			    obj.setEd_tmst(rs.getString("ed_tmst"));
			    obj.setEf_user(rs.getString("ef_user"));
			    obj.setEf_tmst(rs.getString("ef_tmst"));
			    obj.setCredit3(rs.getString("credit3"));
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
	
//	used_ind --> Y or N or ALL, status --> H handled  A --> apply
	public String getSkjPickList2(String valid_ind, String status, String yyyymm) 
	{	
	    Connection conn = null;
		Statement stmt = null;
		Driver dbDriver = null;
		ResultSet rs = null;	
		
		
		try 
		{
			// connection Pool
//		    ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();  
//            stmt = conn.createStatement();
            
		    ConnDB cn = new ConnDB();		   
//		    User connection pool  ********
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
			
//			cn.setORP3FZUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//            stmt = conn.createStatement();

            if("H".equals(status) )
            {
                if("Y".equals(valid_ind))
				{
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
	                	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
	                	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
	                	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
	                	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
	                	  " FROM egtpick pick, egtcbas cbas " +
	                	  " WHERE Trim(cbas.empn) = pick.empno and valid_ind = 'Y' and ed_user is not null " +
	                	  " and trunc(ed_tmst,'mm') = to_date('"+yyyymm+"01','yyyymmdd') order by ed_tmst desc, empno , sno ";			
				}
	            else if("N".equals(valid_ind))
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno and valid_ind = 'N' and ed_user is not null " +
			          	  " and trunc(ed_tmst,'mm') = to_date('"+yyyymm+"01','yyyymmdd') order by ed_tmst desc, empno , sno ";	
	            }
	            else//ALL
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno and ed_user is not null " +
			          	  " and trunc(ed_tmst,'mm') = to_date('"+yyyymm+"01','yyyymmdd') order by ed_tmst desc, empno , sno ";
	            }
            }
            else//if("A".equals(status) )
            {
	            if("Y".equals(valid_ind))
				{
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
	                	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
	                	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
	                	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
	                	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
	                	  " FROM egtpick pick, egtcbas cbas " +
	                	  " WHERE Trim(cbas.empn) = pick.empno and valid_ind = 'Y' " +
	                	  " and trunc(new_tmst,'mm') = to_date('"+yyyymm+"01','yyyymmdd') order by ed_tmst desc, empno , sno ";			
				}
	            else if("N".equals(valid_ind))
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno and valid_ind = 'N' " +
			          	  " and trunc(new_tmst,'mm') = to_date('"+yyyymm+"01','yyyymmdd') order by ed_tmst desc, empno , sno ";
				
	            }
	            else//ALL
	            {
	                sql = " SELECT sno, empno, sern, cname, ename, station, To_Char(new_tmst,'yyyy/mm/dd hh24:mi') new_tmst, " +
			          	  " Decode(reason,'1','全勤選班','2','積點選班','3','其它選班') reason, valid_ind, credit3, " +
			          	  " To_Char(sdate,'yyyy/mm/dd') sdate, To_Char(edate,'yyyy/mm/dd') edate, " +
			          	  " pick.comments comments, ed_user, To_Char(ed_tmst,'yyyy/mm/dd hh24:mi') ed_tmst, ef_user, " +
			          	  " To_Char(ef_tmst,'yyyy/mm/dd hh24:mi') ef_tmst " +
			          	  " FROM egtpick pick, egtcbas cbas " +
			          	  " WHERE Trim(cbas.empn) = pick.empno " +
			          	  " and trunc(new_tmst,'mm') = to_date('"+yyyymm+"01','yyyymmdd') order by ed_tmst desc, empno , sno ";				
	            }
            }
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next())
			{
			    SkjPickObj obj = new SkjPickObj();
			    obj.setSno(rs.getInt("sno"));
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setCname(rs.getString("cname"));
			    obj.setEname(rs.getString("ename"));
			    obj.setBase(rs.getString("station"));
			    obj.setNew_tmst(rs.getString("new_tmst"));
			    obj.setReason(rs.getString("reason"));
			    obj.setValid_ind(rs.getString("valid_ind"));
			    obj.setSdate(rs.getString("sdate"));
			    obj.setEdate(rs.getString("edate"));
			    obj.setComments(rs.getString("comments"));
			    obj.setEd_user(rs.getString("ed_user"));
			    obj.setEd_tmst(rs.getString("ed_tmst"));
			    obj.setEf_user(rs.getString("ef_user"));
			    obj.setEf_tmst(rs.getString("ef_tmst"));
			    obj.setCredit3(rs.getString("credit3"));
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

//選班掛號取得號碼
	   public String getPick_Num(String sno) 
	    {   
	        Connection conn = null;
	        Statement stmt = null;
	        Driver dbDriver = null;
	        ResultSet rs = null;    
	        String return_num ="";
	        
	        
	        try 
	        {
//	            ConnDB cn = new ConnDB();          
//	          User connection pool  ********
//	            cn.setORP3FZUserCP();
//	            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//	            conn = dbDriver.connect(cn.getConnURL(), null);
//	            stmt = conn.createStatement();
	            
//	          cn.setORP3FZUser();
//	          java.lang.Class.forName(cn.getDriver());
//	          conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	            stmt = conn.createStatement();

	            ConnectionHelper ch = new ConnectionHelper();
	            conn = ch.getConnection();
	            stmt = conn.createStatement();

	            sql = " SELECT Max(bid_num) bid_num FROM egtpick_bid WHERE pick_sno ='"+sno+"' " +
	            	  " AND work_date = (CASE WHEN SYSDATE >= Trunc(sysdate)+18/24 THEN Trunc(sysdate)+1 ELSE Trunc(sysdate) END) ";        
//	          System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	            
	            if (rs.next())
	            {
	                return_num = rs.getString("bid_num"); 
	            }	            
	        } 
	        catch (Exception e) 
	        {
	            return_num = e.toString();
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
	        
	        return return_num;
	    }
	   
	 //選班掛號取得號碼
       public String getPick_Num_newyear(String sno) 
        {   
            Connection conn = null;
            Statement stmt = null;
            Driver dbDriver = null;
            ResultSet rs = null;    
            String return_num ="";
            
            
            try 
            {
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();
                stmt = conn.createStatement();

                sql = " SELECT Max(bid_num) bid_num FROM egtpick_bid_newyear WHERE pick_sno ='"+sno+"'";        
//            System.out.println(sql);
                rs = stmt.executeQuery(sql);
                
                if (rs.next())
                {
                    return_num = rs.getString("bid_num"); 
                }               
            } 
            catch (Exception e) 
            {
                return_num = e.toString();
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
            
            return return_num;
        }
       
	   
	   public ArrayList getPick_Handle_List() 
       {   
           Connection conn = null;
           Statement stmt = null;
           Driver dbDriver = null;
           ResultSet rs = null;    
           String return_num ="";
           ArrayList bidAL = new ArrayList();           
           
           try 
           {
               ConnectionHelper ch = new ConnectionHelper();
               conn = ch.getConnection();
               stmt = conn.createStatement();

               sql = "  SELECT bid.sno sno, pick_sno , bid.empno empno, cb.sern sern, cb.cname cname, " +
               		 "  bid_num, to_char(bid_time,'yyyy/mm/dd') bidtime, to_char(work_date,'yyyy/mm/dd') work_date, " +
               		 "  to_char(handle_date,'yyyy/mm/dd hh24:mi') handle_date " +
               		 "  FROM egtpick_bid bid , egtcbas cb, egtpick pick  " +
               		 "  WHERE work_date = Trunc(sysdate)  AND bid.empno = Trim(cb.empn)  " +
               		 "  AND bid.pick_sno = pick.sno " +
               		 "  ORDER BY handle_date desc, sno ";        
//           System.out.println(sql);
               rs = stmt.executeQuery(sql);
               
               while (rs.next())
               {
                   SkjPickBidObj obj = new SkjPickBidObj();
                   obj.setSno(rs.getString("sno"));
                   obj.setPick_sno(rs.getString("pick_sno"));
                   obj.setEmpno(rs.getString("empno"));
                   obj.setSern(rs.getString("sern"));
                   obj.setCname(rs.getString("cname"));
                   obj.setBid_num(rs.getString("bid_num"));
                   obj.setBid_time(rs.getString("bidtime"));
                   obj.setWork_date(rs.getString("work_date"));
                   obj.setHandle_date(rs.getString("handle_date"));
                   bidAL.add(obj);
               }               
           } 
           catch (Exception e) 
           {
               return_num = e.toString();
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
           
           return bidAL;
       }
	   
	   public ArrayList getPick_Handle_List_newyear_CMPR() 
       {   
           Connection conn = null;
           Statement stmt = null;
           Driver dbDriver = null;
           ResultSet rs = null;    
           String return_num ="";
           ArrayList bidAL = new ArrayList();           
           
           try 
           {
               ConnectionHelper ch = new ConnectionHelper();
               conn = ch.getConnection();
               stmt = conn.createStatement();

               sql = " SELECT bid.sno sno, pick_sno , bid.empno empno, cb.sern sern, cb.cname cname, " +
               		 " CASE WHEN cb.jobno >30 AND cb.jobno <=80 THEN 'CM' ELSE 'PR' END Rank, bid_num, to_char(bid_time,'yyyy/mm/dd') bidtime, " +
               		 " to_char(work_date,'yyyy/mm/dd') work_date, loc, to_char(handle_date,'yyyy/mm/dd hh24:mi') handle_date " +
               		 " FROM egtpick_bid_newyear bid , egtcbas cb, egtpick pick WHERE bid.empno = Trim(cb.empn)  AND jobno <= 95  " +
               		 " AND bid.pick_sno = pick.sno ORDER BY handle_date desc, bid_num, sno ";        
//           System.out.println(sql);
               rs = stmt.executeQuery(sql);
               
               while (rs.next())
               {
                   SkjPickBidObj obj = new SkjPickBidObj();
                   obj.setSno(rs.getString("sno"));
                   obj.setPick_sno(rs.getString("pick_sno"));
                   obj.setEmpno(rs.getString("empno"));
                   obj.setSern(rs.getString("sern"));
                   obj.setCname(rs.getString("cname"));
                   obj.setBid_num(rs.getString("bid_num"));
                   obj.setBid_time(rs.getString("bidtime"));
                   obj.setWork_date(rs.getString("work_date"));
                   obj.setRank(rs.getString("rank"));
                   obj.setLoc(rs.getString("loc"));
                   obj.setHandle_date(rs.getString("handle_date"));
                   bidAL.add(obj);
               }               
           } 
           catch (Exception e) 
           {
               return_num = e.toString();
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
           
           return bidAL;
       }
	   
       public ArrayList getPick_Handle_List_newyear_FS() 
       {   
           Connection conn = null;
           Statement stmt = null;
           Driver dbDriver = null;
           ResultSet rs = null;    
           String return_num ="";
           ArrayList bidAL = new ArrayList();           
           
           try 
           {
               ConnectionHelper ch = new ConnectionHelper();
               conn = ch.getConnection();
               stmt = conn.createStatement();

               sql = " SELECT bid.sno sno, pick_sno , bid.empno empno, cb.sern sern, cb.cname cname, " +
                     " 'FS' Rank, bid_num, to_char(bid_time,'yyyy/mm/dd') bidtime, " +
                     " to_char(work_date,'yyyy/mm/dd') work_date, loc, to_char(handle_date,'yyyy/mm/dd hh24:mi') handle_date " +
                     " FROM egtpick_bid_newyear bid , egtcbas cb, egtpick pick WHERE bid.empno = Trim(cb.empn)  AND jobno > 95  " +
                     " AND bid.pick_sno = pick.sno ORDER BY handle_date desc, bid_num, sno ";        
//           System.out.println(sql);
               rs = stmt.executeQuery(sql);
               
               while (rs.next())
               {
                   SkjPickBidObj obj = new SkjPickBidObj();
                   obj.setSno(rs.getString("sno"));
                   obj.setPick_sno(rs.getString("pick_sno"));
                   obj.setEmpno(rs.getString("empno"));
                   obj.setSern(rs.getString("sern"));
                   obj.setCname(rs.getString("cname"));
                   obj.setBid_num(rs.getString("bid_num"));
                   obj.setBid_time(rs.getString("bidtime"));
                   obj.setWork_date(rs.getString("work_date"));
                   obj.setRank(rs.getString("rank"));
                   obj.setLoc(rs.getString("loc"));
                   obj.setHandle_date(rs.getString("handle_date"));
                   bidAL.add(obj);
               }               
           } 
           catch (Exception e) 
           {
               return_num = e.toString();
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
           
           return bidAL;
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
