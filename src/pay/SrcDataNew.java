package pay;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2006/11/29
 */
public class SrcDataNew
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


    public static void main(String[] args)
    {
        SrcDataNew s = new SrcDataNew();
        s.setSrc("2007","08");
        System.out.println(s.getObjAL().size());
    }
    
    public void setSrc(String yyyy, String mm)
    {
        try 
        {
//          User connection pool         
          cn.setDFUserCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          con = dbDriver.connect(cn.getConnURL(), null);
          
          //直接連線
//          cn.setORP3DFUser();
//          java.lang.Class.forName(cn.getDriver());
//          con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                  cn.getConnPW());
          stmt = con.createStatement();

            sql = " SELECT empno, LPAD(to_char(Sum(payment)*100),14,'0') s_pay FROM dftmilp " +
            	  " WHERE paymm = To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm')  " +
            	  " GROUP BY empno, payment" ;
            
            System.out.println(sql);
            sqlstr = sql;
            rs = stmt.executeQuery(sql);
             
            while (rs.next()) 
            {
                SrcObj obj = new SrcObj();
                obj.setEmpno(rs.getString("empno"));
                obj.setAmount(rs.getString("s_pay"));
                objAL.add(obj);
            }       
            rs.close();
            
            sql = "  SELECT empno, payment pay, duty, To_Char(s_dutydt,'yyyy/mm/dd') str_dt " +
            	  "  FROM dftmilp WHERE paymm = To_Char(Last_Day(To_Date('"+yyyy+mm+"01','yyyymmdd'))+1,'yyyymm') " +
            	  "  order BY duty, empno " ;
      
		      System.out.println(sql);
		      sqlstr = sql;
		      rs = stmt.executeQuery(sql);
		       
		      while (rs.next()) 
		      {
		          SrcObj obj = new SrcObj();
		          obj.setEmpno(rs.getString("empno"));
		          obj.setAmount(rs.getString("pay"));
		          obj.setDuty(rs.getString("duty"));
		          obj.setDutydate(rs.getString("str_dt"));
		          objAL2.add(obj);
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
    
    public ArrayList getObjAL()
    {
        return objAL;
    }  
    
    public ArrayList getObjAL2()
    {
        return objAL2;
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
