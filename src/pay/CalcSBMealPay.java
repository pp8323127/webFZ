package pay;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/11/29
 */
public class CalcSBMealPay
{
    Connection con = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;   
    ResultSet rs = null;
    String sql = null;
    String sqlstr = "";
    String returnstr = "";
    ConnDB cn = new ConnDB();
    Driver dbDriver = null;
    ArrayList objAL = new ArrayList();
    String yyyy = "";
    String mm = "";
    String empno = "";
    String userid = "";


    public static void main(String[] args)
    {
        CalcSBMealPay s = new CalcSBMealPay("2011","07","","SYS");
//        System.out.println(s.hasSBMealData());
        s.setSrc();
//        s.insSBMealData();
//        System.out.println(s.getObjAL().size());
        System.out.println("Done");
    }
    
    public CalcSBMealPay(String yyyy, String mm, String empno, String userid)
    {
        this.yyyy = yyyy;
        this.mm = mm;
        this.empno = empno;
        this.userid = userid;
    }
    
    public int hasSBMealData()
    {        
        int count=0;
        try 
        {
//          User connection pool        
          cn.setDFUserCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          con = dbDriver.connect(cn.getConnURL(), null);
          
//          cn.setORP3DFUser();
//          java.lang.Class.forName(cn.getDriver());
//          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());    
          stmt = con.createStatement();
                    
          sql = " select count(*) c from dftmilp " +
          		" where paymm = To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') ";
          
//          System.out.println(sql);
          rs = stmt.executeQuery(sql);
          if (rs.next()) 
	      {
              count = rs.getInt("c");
	      }
          return count;
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnstr=e.toString();
            return -1;
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
            return -1;
        }
        finally 
        {            
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( con != null ) try {
                con.close();
            } catch (SQLException e) {}

        }
    }
    
    public void setSrc()
    {
        try 
        {
//          User connection pool to AOCIPROD           
          cn.setAOCIPRODCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          con = dbDriver.connect(cn.getConnURL(), null);
          
          //直接連線 AOCIPROD
//          cn.setAOCIPROD();
//          java.lang.Class.forName(cn.getDriver());
//          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID(),cn.getConnPW());
          stmt = con.createStatement();        
          
//            sql = " SELECT empno, duty, pay, str_dt, end_dt, " +
//            	  " To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') paymm " +
//            	  " FROM ( select r.staff_num empno, dps.duty_cd duty, " +
//            	  " To_Char(dps.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt, To_Char(dps.end_dt_tm_gmt,'yyyy/mm/dd hh24:mi') end_dt," +
//            	  " to_char(dps.str_dt_tm_gmt,'hh24:mi') str_tm, to_char(dps.end_dt_tm_gmt,'hh24:mi') end_tm, " +
//            	  " c.preferred_name cname, to_number(c.seniority_code) sern, " +
//            	  " CASE WHEN ( To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') " +
//            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') ) " +
//            	  " AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '05:00' " +
//            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '08:00' AND dps.duty_cd in ('S1','SB') THEN '50'  " +
//            	  " WHEN ( To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') " +
//            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') ) " +
//            	  " AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '05:00' " +
//            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '08:00' AND dps.duty_cd not in ('S1','SB') THEN '100'  " +
//            	  " WHEN (To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 12:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 13:00' , 'yyyymmdd hh24:mi') " +
//            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 12:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 13:00' , 'yyyymmdd hh24:mi') ) " +
//            	  " AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '12:00' " +
//            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '13:00'  " +
//            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi')||'-'||to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '08:00-12:00' THEN '100' " +
//            	  " WHEN (To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 18:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 19:00' , 'yyyymmdd hh24:mi') " +
//            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
//            	  " BETWEEN  To_Date('"+yyyy+mm+"01 18:00', 'yyyymmdd hh24:mi') " +
//            	  " AND To_Date('"+yyyy+mm+"01 19:00' , 'yyyymmdd hh24:mi')) AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '18:00' " +
//            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '19:00' " +
//            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi')||'-'||to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '13:00-18:00' THEN '100' " +
//            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '05:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '08:00' AND dps.duty_cd in ('S1','SB') THEN '50' " +
//            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '05:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '08:00' AND dps.duty_cd not in ('S1','SB') THEN '100' " +
//            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '12:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '13:00' THEN '100' " +
//            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '18:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '19:00' THEN '100' " +
//            	  " ELSE '0' END pay from duty_prd_seg_v dps,roster_v r,crew_v c " +
//		      	  " where r.series_num = dps.series_num AND  r.staff_num = c.staff_num " +
//		      	  " AND dps.str_dt_tm_gmt between to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
//		      	  " AND to_date(To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd')),'yyyymmdd')||' 2359','yyyymmdd hh24mi') " +       
//		      	  " AND dps.fd_ind='N' AND r.delete_ind='N' AND  r.sched_nm <> 'DUMMY' " +
//		      	  " and c.section_number in ('1','2','3','4','96','98') AND SubStr(dps.duty_cd,1,1)='S' and length(dps.duty_cd) = 2 " +
//		      	  " order by dps.str_dt_tm_gmt, r.staff_num ) WHERE pay > 0 order BY duty, empno " ;
              sql = " SELECT * FROM ( " +
                    " SELECT empno, duty, str_dt, end_dt , cname, sern, paymm, " +
              		" CASE WHEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 05:00','yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 08:00','yyyy/mm/dd hh24:mi')  THEN '50' " +
              		"      WHEN To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 05:00','yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 08:00','yyyy/mm/dd hh24:mi')  THEN '50' " +
              		"      WHEN To_Date('2000/01/01 05:00','yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi')  THEN '50' " +
              		"      WHEN To_Date('2000/01/01 08:00','yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi')  THEN '50' " +
              		"      WHEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 12:00','yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 13:00','yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"      WHEN To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 12:00','yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 13:00','yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"      WHEN To_Date('2000/01/01 12:00','yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"     WHEN To_Date('2000/01/01 13:00','yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"     WHEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 18:00','yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 19:00','yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"     WHEN To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 18:00','yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 19:00','yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"     WHEN To_Date('2000/01/01 18:00','yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi')  THEN '100' " +
              		"     WHEN To_Date('2000/01/01 19:00','yyyy/mm/dd hh24:mi') " +
              		"           BETWEEN To_Date('2000/01/01 '||str_tm,'yyyy/mm/dd hh24:mi') AND To_Date('2000/01/01 '||end_tm,'yyyy/mm/dd hh24:mi')  THEN '100' " +
              		" ELSE '0' END pay " +
              		" FROM ( select r.staff_num empno, dps.duty_cd duty,  To_Char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt, " +
              		"      To_Char(dps.act_end_dt_tm_gmt,'yyyy/mm/dd hh24:mi') end_dt, to_char(dps.act_str_dt_tm_gmt,'hh24:mi') str_tm, " +
              		"      to_char(dps.act_end_dt_tm_gmt,'hh24:mi') end_tm,  c.preferred_name cname, to_number(c.seniority_code) sern, " +
              		"      To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') paymm " +
              		"       from duty_prd_seg_v dps,roster_v r,crew_v c " +
              		"      where r.series_num = dps.series_num AND  r.staff_num = c.staff_num " +
              		"      AND dps.act_str_dt_tm_gmt between to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
              		"      AND to_date(To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd')),'yyyymmdd')||' 2359','yyyymmdd hh24mi') " +
              		"      AND dps.fd_ind='N' AND r.delete_ind='N' AND  r.sched_nm <> 'DUMMY' " +
              		"      and c.section_number in ('1','2','3','4','96','98') AND dps.duty_cd LIKE 'S%' " +
              		"      and length(dps.duty_cd) = 2 ) " +
              		" ) WHERE pay >0 ORDER BY str_dt, duty, empno ";
      
//		      System.out.println(sql);
		      sqlstr = sql;
		      rs = stmt.executeQuery(sql);
		      objAL.clear();
		       
		      while (rs.next()) 
		      {
		          SrcObj obj = new SrcObj();
		          obj.setEmpno(rs.getString("empno"));
		          obj.setAmount(rs.getString("pay"));
		          obj.setDuty(rs.getString("duty"));
		          obj.setS_dutydate(rs.getString("str_dt"));
		          obj.setE_dutydate(rs.getString("end_dt"));
		          obj.setPaymm(rs.getString("paymm"));
		          objAL.add(obj);
		      }       
            
            returnstr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( con != null ) try {
                con.close();
            } catch (SQLException e) {}

        }
    }
    
    public void insSBMealData()
    {
        try 
        {
//          User connection pool        
          cn.setDFUserCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          con = dbDriver.connect(cn.getConnURL(), null);
          
//          cn.setORP3DFUser();
//          java.lang.Class.forName(cn.getDriver());
//          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());          
          con.setAutoCommit(false);	
          
          //delete original data
          sql = " delete dftmilp " +
          		" where paymm = To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') ";          
          pstmt = con.prepareStatement(sql);
          pstmt.executeUpdate();
          pstmt.close();
          //delete original data
                    
          if(objAL.size()>0)
          {
	          sql = " insert into dftmilp (empno, duty, payment, s_dutydt, e_dutydt, paymm, newuser, newdt ) " +
	          		" values (?,?,to_number(?),to_date(?,'yyyy/mm/dd hh24:mi'),to_date(?,'yyyy/mm/dd hh24:mi'),?,?,sysdate)";
	          pstmt = con.prepareStatement(sql);
	          int count =0;
	          for(int i=0; i<objAL.size(); i++)
	          {
	              SrcObj obj = (SrcObj) objAL.get(i);
	              
	              int j = 1;
	              pstmt.setString(j , obj.getEmpno());
	              pstmt.setString(++j , obj.getDuty());
	              pstmt.setString(++j , obj.getAmount());
	              pstmt.setString(++j , obj.getS_dutydate());            
	              pstmt.setString(++j , obj.getE_dutydate());    
	              pstmt.setString(++j , obj.getPaymm());
	              pstmt.setString(++j , userid);              
	              pstmt.addBatch();
	              count++;
	              if (count == 10)
	              {
	                  pstmt.executeBatch();
	                  pstmt.clearBatch();
	                  count = 0;
	              }
	          }  
	          
	          if (count > 0)
	          {
	              pstmt.executeBatch();
	              pstmt.clearBatch();
	          }  

          }	
          con.commit();	
          returnstr = "Y";
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnstr=e.toString();
    		try { con.rollback(); } //if fail rollback
    		catch (SQLException e1) { returnstr=e.toString(); }
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        }
        finally 
        {            
            if ( pstmt != null ) try {
                pstmt.close();
            } catch (SQLException e) {}
            if ( con != null ) try {
                con.close();
            } catch (SQLException e) {}

        }
    }
    
    public void QueryMealPayData()
    {  
        try 
        {
//          User connection pool        
          cn.setDFUserCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          con = dbDriver.connect(cn.getConnURL(), null);
          
//          cn.setORP3DFUser();
//          java.lang.Class.forName(cn.getDriver());
//          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());    
          stmt = con.createStatement();
          
          if(!"".equals(empno) && empno != null)
          {
              sql = " select empno, duty, payment, To_Char(s_dutydt,'yyyy/mm/dd') s_dutydt, paymm from dftmilp " +
        		    " where empno = '"+empno+"' and paymm = To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') " +
        		    " order by duty, empno, s_dutydt ";
          }
          else
          {                    
	          sql = " select empno, duty, payment, To_Char(s_dutydt,'yyyy/mm/dd') s_dutydt, paymm from dftmilp " +
	          		" where paymm = To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') order by duty, empno, s_dutydt ";
          }
	          
//          System.out.println(sql);
          rs = stmt.executeQuery(sql);
          objAL.clear();
          while (rs.next()) 
	      {
              SrcObj obj = new SrcObj();
              obj.setEmpno(rs.getString("empno"));
              obj.setDuty(rs.getString("duty"));
              obj.setAmount(rs.getString("payment"));
              obj.setDutydate(rs.getString("s_dutydt"));
              obj.setPaymm(rs.getString("paymm"));
              objAL.add(obj);              
	      }
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnstr=e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        }
        finally 
        {            
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( con != null ) try {
                con.close();
            } catch (SQLException e) {}

        }
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }   
    
    public String getSQLStr()
    {
        return sqlstr;
    }  
    
    public String getStr()
    {
        return returnstr;
    } 
    
}
