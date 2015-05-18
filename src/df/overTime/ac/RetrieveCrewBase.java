package df.overTime.ac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2006/2/24
 */
public class RetrieveCrewBase
{
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = null;  
    ArrayList empnoAL = new ArrayList();
    ArrayList baseAL = new ArrayList();

    public static void main(String[] args)
    {
        RetrieveCrewBase cb = new RetrieveCrewBase("2009","12");
//        System.out.println(cb.getBase("635849"));
        
    }   
    
    
    public RetrieveCrewBase(String year, String month)
    {
        try 
        {
            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
//            Class.forName("oracle.jdbc.driver.OracleDriver");
////          conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:orp3","fzw2","xns72fs9kf");
//            conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:orp3","dfdb","df$888");
            stmt = conn.createStatement();

            sql =   " SELECT cbv.staff_num staff_num , Max(base) base FROM crew_base_v cbv, "+
		            " ( SELECT staff_num,  Max(exp_dt) exp_dt FROM crew_base_v "+
		            "   WHERE prim_base = 'Y' AND staff_num <>'8' "+
		            "   AND eff_dt <= To_Date('"+year+month+"01','yyyymmdd') "+
		            "   AND (exp_dt IS NULL OR exp_dt >=  Last_Day(To_Date('"+year+month+"01','yyyymmdd'))) "+
		            "   AND base IN ('TPE','KHH') "+
		            "   GROUP BY staff_num ) cbv2 "+
		            " WHERE cbv.staff_num = cbv2.staff_num AND ( cbv.exp_dt=cbv2.exp_dt  or (cbv.exp_dt IS NULL AND cbv2.exp_dt IS NULL )) "+
		            "   AND cbv.prim_base = 'Y' "+
		            "   GROUP BY cbv.staff_num ";
            
            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            empnoAL= new ArrayList();
            baseAL= new ArrayList();
              
            while (rs.next()) 
            {
                empnoAL.add(rs.getString("staff_num"));
                baseAL.add(rs.getString("base"));                
            }

        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());

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
     
    public String getBase(String empno) 
    {
        int idx = 0;
        String base = "TPE";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            base = (String) baseAL.get(idx);
        }
        return base;
    }   
    
}
