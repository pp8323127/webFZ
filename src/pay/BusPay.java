package pay;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/11/29
 */
public class BusPay
{
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;   
    ResultSet rs = null;
    String sql = null;
    String sqlstr = "";
    String returnstr = "";
    ConnDB cn = new ConnDB();
    Driver dbDriver = null;
    ArrayList objAL = new ArrayList();
    String empno = "";
    String userid = "";


    public static void main(String[] args)
    {
        BusPay s = new BusPay("");
//        System.out.println(s.hasSBMealData());
        System.out.println(s.getObjAL().size());
        System.out.println("Done");
    }
    
    public BusPay()
    {       
        this.empno = null;
    }
    
    public BusPay(String empno)
    {       
        this.empno = empno;
    }
    
    public void BusPayList()
    {        
        int count=0;
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            if(empno == null)
            {
                sql = " SELECT busp.empno empno, crew.name cname, crew.box sern, payment," +
                	  " To_Char(effdt,'yyyy/mm/dd') effdt, To_Char(expdt,'yyyy/mm/dd') expdt, " +
                	  " busp.newuser newuser, To_Char(busp.newdate,'yyyy/mm/dd')  newdate " +
                	  " FROM dftbusp busp, dftcrew crew WHERE busp.empno = crew.empno (+) order by busp.empno ";
            }
            else
            {
                sql = " SELECT busp.empno empno, crew.name cname, crew.box sern, payment," +
		          	  " To_Char(effdt,'yyyy/mm/dd') effdt, To_Char(expdt,'yyyy/mm/dd') expdt, " +
		        	  " busp.newuser newuser, To_Char(busp.newdate,'yyyy/mm/dd')  newdate " +
		        	  " FROM dftbusp busp, dftcrew crew WHERE busp.empno = crew.empno (+) " +
		        	  " and busp.empno = '"+empno+"' order by busp.empno ";            
            }
            
//          System.out.println(sql);
            rs = stmt.executeQuery(sql);
            while (rs.next()) 
            {
                BusPayObj obj = new BusPayObj();
			    obj.setEmpno(rs.getString("empno"));
			    obj.setCname(rs.getString("cname"));
			    obj.setSern(rs.getString("sern"));
			    obj.setPayment(rs.getString("payment"));
			    obj.setEffdt(rs.getString("effdt"));
			    obj.setExpdt(rs.getString("expdt"));
			    obj.setNewuser(rs.getString("newuser"));
			    obj.setNewdate(rs.getString("newdate"));
			    objAL.add(obj);  
            }
            returnstr = "Y";
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
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }   
    
    public String getSQLStr()
    {
        return sql;
    }  
    
    public String getStr()
    {
        return returnstr;
    } 
    
}
