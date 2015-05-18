package pay;

import java.io.*;
import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2006/11/29
 */
public class AutoMailMealPay
{
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = null;
    String sqlstr = "";
    String returnstr = "";
    ConnDB cn = new ConnDB();
    Driver dbDriver = null;
    ArrayList objAL = new ArrayList();
    ArrayList objAL2 = new ArrayList();
    
    private String filename = "";
	private String path 	= "C:\\CIITemp\\";
	StringBuffer str = new StringBuffer();
	FileWriter fw =  null;

    public static void main(String[] args)
    {
        AutoMailMealPay s = new AutoMailMealPay();
        s.setSrc("2007","07");
        s.getAutoMailFile();
        System.out.println("Done");
    }
    
    public void setSrc(String yyyy, String mm)
    {     
        try 
        {
            fw = new FileWriter(path+yyyy+mm+"meal.csv",false);
            
//          User connection pool to AOCIPROD           
//          cn.setAOCIPRODCP();
//          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//          con = dbDriver.connect(cn.getConnURL(), null);
          
          //直接連線 AOCIPROD
          cn.setAOCIPROD();
          java.lang.Class.forName(cn.getDriver());
          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
                  cn.getConnPW());
          stmt = con.createStatement();
           
            sql = " SELECT empno, duty, trim(pay) pay, str_dt FROM ( select r.staff_num empno, dps.duty_cd duty, " +
            	  " To_Char(dps.str_dt_tm_gmt,'yyyy/mm/dd') str_dt, To_Char(dps.end_dt_tm_gmt,'yyyy/mm/dd') end_dt," +
            	  " to_char(dps.str_dt_tm_gmt,'hh24:mi') str_tm, to_char(dps.end_dt_tm_gmt,'hh24:mi') end_tm, " +
            	  " c.preferred_name cname, to_number(c.seniority_code) sern, " +
            	  " CASE WHEN ( To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') " +
            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') ) " +
            	  " AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '05:00' " +
            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '08:00' AND dps.duty_cd in ('S1','SB') THEN '50'  " +
            	  " WHEN ( To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') " +
            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 05:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 08:00' , 'yyyymmdd hh24:mi') ) " +
            	  " AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '05:00' " +
            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '08:00' AND dps.duty_cd not in ('S1','SB') THEN '100'  " +
            	  " WHEN (To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 12:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 13:00' , 'yyyymmdd hh24:mi') " +
            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 12:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 13:00' , 'yyyymmdd hh24:mi') ) " +
            	  " AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '12:00' " +
            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '13:00'  " +
            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi')||'-'||to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '08:00-12:00' THEN '100' " +
            	  " WHEN (To_Date('"+yyyy+mm+"01 '||to_char(dps.str_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 18:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 19:00' , 'yyyymmdd hh24:mi') " +
            	  " or To_Date('"+yyyy+mm+"01 '||to_char(dps.end_dt_tm_gmt,'hh24:mi'), 'yyyymmdd hh24:mi') " +
            	  " BETWEEN  To_Date('"+yyyy+mm+"01 18:00', 'yyyymmdd hh24:mi') " +
            	  " AND To_Date('"+yyyy+mm+"01 19:00' , 'yyyymmdd hh24:mi')) AND to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '18:00' " +
            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi') <> '19:00' " +
            	  " AND to_char(dps.str_dt_tm_gmt,'hh24:mi')||'-'||to_char(dps.end_dt_tm_gmt,'hh24:mi') <> '13:00-18:00' THEN '100' " +
            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '05:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '08:00' AND dps.duty_cd in ('S1','SB') THEN '50' " +
            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '05:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '08:00' AND dps.duty_cd not in ('S1','SB') THEN '100' " +
            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '12:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '13:00' THEN '100' " +
            	  " WHEN to_char(dps.str_dt_tm_gmt,'hh24:mi') <= '18:00' AND to_char(dps.end_dt_tm_gmt,'hh24:mi') >= '19:00' THEN '100' " +
            	  " ELSE '0' END pay from duty_prd_seg_v dps,roster_v r,crew_v c " +
		      	  " where r.series_num = dps.series_num AND  r.staff_num = c.staff_num " +
		      	  " AND dps.str_dt_tm_gmt between to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
		      	  " AND to_date(To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd')),'yyyymmdd')||' 2359','yyyymmdd hh24mi') " +
		      	  " AND dps.fd_ind='N' AND r.delete_ind='N' AND  r.sched_nm <> 'DUMMY' " +
		      	  " and c.section_number in ('1','2','3','4','96','98') AND SubStr(dps.duty_cd,1,1)='S' and length(dps.duty_cd) = 2 " +
		      	  " order by dps.str_dt_tm_gmt, r.staff_num ) WHERE pay > 0 order BY empno " ;
      
//		      System.out.println(sql);
		      sqlstr = sql;
		      rs = stmt.executeQuery(sql);		  
		      
		      SrcObj emptyobj1 = new SrcObj();
		      objAL2.add(emptyobj1);
		      while (rs.next()) 
		      {
		          SrcObj obj = new SrcObj();
		          obj.setEmpno(rs.getString("empno"));
		          obj.setAmount(rs.getString("pay"));
		          obj.setDuty(rs.getString("duty"));
		          obj.setDutydate(rs.getString("str_dt"));
		          objAL2.add(obj);
		      }   
		      SrcObj emptyobj = new SrcObj();
		      objAL2.add(emptyobj);
		      System.out.println(objAL2.size());
            
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
    
    public void getAutoMailFile()
    {
        int total = 0;
        int count = 0;
        int maxlength = 0;
        int templen =0;
        BankData b = new BankData();  
        try
        {           
	        for(int i=1; i<objAL2.size()-1; i++)
	        {
//	            System.out.println(i);
	            templen ++;
	            SrcObj obj0 = (SrcObj) objAL2.get(i-1);
	            SrcObj obj1 = (SrcObj) objAL2.get(i);
	            SrcObj obj2 = (SrcObj) objAL2.get(i+1);
	            BankDataObj obj = b.getBankDataObj(obj1.getEmpno()) ;
	            
	            if(!obj1.getEmpno().equals(obj0.getEmpno()))
	            {
	                count = 0;
	                str.append(obj1.getEmpno().trim()+","+obj.getName().trim()+",");
	            }
	            str.append(obj1.getDuty()+"("+obj1.getDutydate()+")     $"+obj1.getAmount()+",");
	            count = count + Integer.parseInt(obj1.getAmount());
	            if(!obj1.getEmpno().equals(obj2.getEmpno()))
	            {
	                if(templen>maxlength)
	                {
	                    maxlength = templen;
	                }
	                templen =0;
	                str.append("Total : $"+count);
	                str.append("\r\n");
	                total = total + count;
	            }
	        }
	        System.out.println(maxlength);
//	        System.out.println(str.toString());
	        System.out.println(total);
	        fw.write("EMPNO : ,NAME : ,>,>,>,>,>\r\n");
	        fw.write(str.toString());
	        fw.flush();	   
	        fw.close();
    	}
        catch(Exception e)
    	{
            System.out.print(e.toString());
    	}
        finally
        {
    	
        }
    
    
    
    }
}
