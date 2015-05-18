package eg.off;

import java.sql.*;
import java.util.*;
import ci.db.*;
import eg.*;

/**
 * @author cs71 Created on  2007/12/14
 */
public class HRALDate
{    
    public static void main(String[] args)
    {
        HRALDate aldt = new HRALDate("TPE");
        aldt.getHrAlDate();
        System.out.println(aldt.getObjAL().size());        
    }
    
    private static Connection conn = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;
    private String sql = null;
    private String empno = "";
    private String base = "";
    private String userid = "";
    private ArrayList objAL = new ArrayList();
    
    public HRALDate (String base)
    {
        this.base = base;
    }
    
    public HRALDate (String empno, String base)
    {
        this.empno = GetEmpno.getEmpno(empno);
        this.base = base;
    }
    
    public void getHrAlDate()
    {
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            //get data from egtaldt
            if("".equals(empno) | empno == null)
            {
	            sql = " select trim(aldt.empno) empno, cbas.cname cname, cbas.ename ename, cbas.sern sern , " +
	            	  " to_char(aldt.aldate,'yyyy/mm/dd') aldate, aldt.upduser upduser, " +
	            	  " to_char(aldt.upddt,'yyyy/mm/dd') upddt from egtaldt aldt, egtcbas cbas " +
	            	  " WHERE aldt.empno = Trim(cbas.empn) and cbas.station = '"+base+"' order by aldt.empno " ;   
            }
            else
            {
	            sql = " select trim(aldt.empno) empno, cbas.cname cname, cbas.ename ename, cbas.sern sern , " +
	            	  " to_char(aldt.aldate,'yyyy/mm/dd') aldate, aldt.upduser upduser, " +
	            	  " to_char(aldt.upddt,'yyyy/mm/dd') upddt from egtaldt aldt, egtcbas cbas " +
	            	  " WHERE aldt.empno = Trim(cbas.empn) and aldt.empno = '"+empno+"' " +
	            	  " and cbas.station = '"+base+"' order by aldt.empno " ;     
            }

//System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                HRALDateObj obj = new HRALDateObj();
                obj.setEmpno(rs.getString("empno"));
                obj.setCname(rs.getString("cname"));
                obj.setEname(rs.getString("ename"));
                obj.setSern(rs.getString("sern"));
                obj.setAldate(rs.getString("aldate"));
                obj.setUpduser(rs.getString("upduser"));
                obj.setUpddate(rs.getString("upddt"));
                objAL.add(obj);
                
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    }
    
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
}
