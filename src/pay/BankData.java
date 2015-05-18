package pay;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/11/29
 */
public class BankData
{

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = null;
    String sqlstr = "";
    String returnstr = "";
    
    Driver dbDriver = null;
    ArrayList empnoAL = new ArrayList();
    ArrayList objAL = new ArrayList();
    
    public static void main(String[] args)
    {
        BankData b = new BankData(); 
        BankDataObj obj = b.getBankDataObj("643027") ;
        System.out.println(obj.getEmpno());
        System.out.println(obj.getName());
        System.out.println(obj.getEname());
        System.out.println(obj.getBanknont());
        System.out.println(obj.getBanknous());  
        
        
    }   
    
    public BankData ()
    {
        ConnDB cn = new ConnDB();
        
        try 
        {
            //User connection pool to ORP3DF
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
//            直接連線 ORP3FZ
//            cn.setORP3DFUser();
//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            con = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());
            stmt = con.createStatement();

            sql = " SELECT trim(empno) empno, nvl(NAME,' ') name, nvl(ename,' ') ename, nvl(box,' ') box, " +
            	  " lpad(Nvl(banknont,'xxxxxx'),6,' ') banknont, " +
            	  " lpad(Nvl(prefixnont,'xxxxx'),5,' ') prefixnont, " +
            	  " lpad(Nvl(banknont_prefix,'xxxxxxxx'),8,' ') banknont_prefix, " +
            	  " lpad(Nvl(banknous,'xxxxxx'),6,' ') banknous, " +
            	  " lpad(Nvl(prefixnous,'xxxxx'),5,' ') prefixnous, " +
            	  " lpad(Nvl(banknous_prefix,'xxxxxxxx'),8,' ') banknous_prefix " +
            	  " FROM dftcrew " ;
            
            sqlstr = sql;
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
             
            while (rs.next()) 
            {
                BankDataObj obj = new BankDataObj();
                obj.setEmpno(rs.getString("empno"));
                obj.setName(rs.getString("name"));
                obj.setEname(rs.getString("ename"));
                obj.setSern(rs.getString("box"));
                obj.setBanknont(rs.getString("banknont"));
                obj.setBanknous(rs.getString("banknous"));
                obj.setPrefixnont(rs.getString("prefixnont"));
                obj.setPrefixnous(rs.getString("prefixnous"));
                obj.setBanknont_prefix(rs.getString("banknont_prefix"));
                obj.setBanknous_prefix(rs.getString("banknous_prefix"));
                objAL.add(obj);
                empnoAL.add(rs.getString("empno"));
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
    
    public String getSQLStr()
    {
        return sqlstr;
    }  
    
    public String getStr()
    {
        return returnstr;
    } 
    
    public BankDataObj getBankDataObj(String empno) 
    {
        int idx = 0;
        BankDataObj obj = null;
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            obj = (BankDataObj) objAL.get(idx);
        }
        else
        {
            obj = new BankDataObj();
            obj.setEmpno(""); 
            obj.setName("") ;
            obj.setEname("") ;
            obj.setBanknont("      ") ;
            obj.setBanknous("      ");
            obj.setPrefixnont("     ");
            obj.setPrefixnous("     ");            
            obj.setBanknont_prefix("        ");
            obj.setBanknous_prefix("        ");
            obj.setSern("") ;
        }
        
        return obj;
    }   
    
}
