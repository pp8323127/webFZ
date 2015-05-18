package eg.off;

import java.sql.*;
import java.util.*;
import ci.db.*;


/**
 * @author cs71 Created on  2008/1/31
 */
public class DiffALdt
{
    private static Connection conn = null;
    private static Statement stmt = null;
    private static PreparedStatement pstmt = null;
    private static ResultSet rs = null;
    private String sql = null;
    private String empno = "";
    private String base = "";
    private String userid = "";
    private ArrayList objAL = new ArrayList();
    
    public static void main(String[] args)
    {
        DiffALdt daldt = new DiffALdt("");
        daldt.initialHRAL();
//        daldt.getDiffALDate();        
        System.out.println("Done");        
    }
    
    public DiffALdt (String base)
    {
        this.base = base;
    }
    
    public void initialHRAL()
    {
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            
            sql = " SELECT employid, to_char(bnftdt,'yyyy/mm/dd') bnftdt FROM hrvegemploy WHERE employid IN " +
            	  " ( SELECT empno FROM " +
            	  " ( SELECT Trim(cb.empn) empno, al.aldate aldt FROM egtcbas cb, egtaldt al " +
            	  " WHERE Trim(cb.empn) = al.empno (+) AND cb.status = 1  ) WHERE aldt IS null ) " +
            	  " AND bnftdt IS NOT null " ;   
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            objAL.clear();
            while (rs.next())
            {
                HRALDateObj obj = new HRALDateObj();
                obj.setEmpno(rs.getString("employid"));
                obj.setAldate(rs.getString("bnftdt"));
                objAL.add(obj);                
            } 
//            System.out.println("objAL.size() = "+objAL.size());
            
            if(objAL.size()>0)
            {
	            sql = " insert into egtaldt (empno,aldate,upduser,upddt) values (?,to_date(?,'yyyy/mm/dd'),'SYS',sysdate) ";
	            pstmt = conn.prepareStatement(sql);
	            int count =0;                  
	            for(int i=0; i<objAL.size(); i++)
	            {  
	                HRALDateObj obj = (HRALDateObj) objAL.get(i);
	                String str = "select count(*) c from egtaldt where empno = '"+obj.getEmpno()+"'";
	                rs = stmt.executeQuery(str);
	                int c =0;
	                if(rs.next())
	                {
	                    c=rs.getInt("c");
	                }
//	                System.out.println("c = "+c);	                
	                if(c>0)
	                {//already exist-->  update
	                    String tsql = "update egtaldt set aldate = to_date('"+obj.getAldate()+"','yyyy/mm/dd') where empno = '"+obj.getEmpno()+"'";
	                    stmt.executeUpdate(tsql);
	                }
	                else
	                {//insert
			            pstmt.setString(1 , obj.getEmpno());
			            pstmt.setString(2 , obj.getAldate());
			            pstmt.addBatch();
			            count++;
			              
			            if (count == 10)
			            {
		                  pstmt.executeBatch();
		                  pstmt.clearBatch();
		                  count = 0;
			            }
	                }            
	            }  
	            
	            if (count > 0)
	            {
	                pstmt.executeBatch();
	                pstmt.clearBatch();
	            } 
            }
        }
        catch (SQLException e) 
        {
            System.out.println(e.toString());
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
                if (pstmt != null)
                    pstmt.close();
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
    
    public void getDiffALDate()
    {
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            
            sql = "  SELECT trim(eg.empn) empno, eg.sern sern, eg.cname cname, eg.ename ename, " +
            	  " To_Char(hr.bnftdt,'yyyy/mm/dd') hr_aldt, To_Char(al.aldate,'yyyy/mm/dd') eg_aldt " +
            	  " FROM egtcbas eg, egtaldt al, hrvegemploy hr " +
            	  " WHERE Trim(eg.empn) = al.empno (+) and eg.station = '"+base+"' AND Trim(eg.empn) = hr.employid (+) " +
            	  " AND ( al.aldate <> hr.bnftdt OR al.aldate IS NULL OR hr.bnftdt IS NULL) " +
            	  " AND eg.status in ('1','2') ORDER BY empn " ;   
            
            rs = stmt.executeQuery(sql);
            
            objAL.clear();
            while (rs.next())
            {
                HRALDateObj obj = new HRALDateObj();
                obj.setEmpno(rs.getString("empno"));
                obj.setCname(rs.getString("cname"));
                obj.setEname(rs.getString("ename"));
                obj.setSern(rs.getString("sern"));
                obj.setAldate(rs.getString("eg_aldt"));
                obj.setHr_aldate(rs.getString("hr_aldt"));
                objAL.add(obj);                
            }
        }
        catch (SQLException e) 
        {
            System.out.println(e.toString());
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
