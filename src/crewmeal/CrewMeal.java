package crewmeal;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/4/26
 */
public class CrewMeal
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private String sql = "";     
    private Driver dbDriver = null;

    private ArrayList empnoAL;
    private ArrayList mealAL;
    
    public static void main(String[] args)
    {
        CrewMeal c = new CrewMeal();
        System.out.println(c.getMealType("811181"));
        System.out.println(c.getMealType("635856"));
        System.out.println(c.getMealType("123456"));
        System.out.println(c.getMealType("637675"));
    }
    
    public CrewMeal()
    {
        try 
        {
            ConnDB cn = new ConnDB();            
//            cn.setAOCIPROD();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                    cn.getConnPW());            
            
    		cn.setAOCIPRODCP();
    		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    		conn = dbDriver.connect(cn.getConnURL(), null);
            
            stmt = conn.createStatement();

            sql = " SELECT staff_num, meal_type FROM acdba.crew_special_meals_t where " +
            	  " eff_fm_dt <= SYSDATE AND (eff_to_dt >= Trunc(SYSDATE,'dd')  " +
            	  " OR eff_to_dt IS NULL) order by eff_fm_dt desc" ;

            rs = stmt.executeQuery(sql);

            empnoAL= new ArrayList();
            mealAL= new ArrayList();
                    
            while (rs.next()) 
            {
                empnoAL.add(rs.getString("staff_num"));
                mealAL.add(rs.getString("meal_type"));               
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
    }// end of public CrewMeal()
    
    public String getMealType(String empno) 
    {
        int idx = 0;
        String mealtype = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            mealtype = (String) mealAL.get(idx);
        }
        return mealtype;
    }   

}
