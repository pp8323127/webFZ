package eg.pickup;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author CS71 Created on  2010/7/29
 */
public class CrewPickup
{
    private String sql = "";
    ArrayList objAL = new ArrayList();
    public static void main(String[] args)
    {
        CrewPickup cpk = new CrewPickup();
        cpk.getPickupData("635863","201002");
        System.out.println(cpk.getObjAL().size());        
    }
    
    public void getPickupData(String empno, String yyyymm)
    {    
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
    	
        try
        {
//            EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUser(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());    
	    	
	    	EGConnDB cn = new EGConnDB();          
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
	    	
            stmt = conn.createStatement();  
			
			sql = " SELECT pk.empno empno, cb.sern sern, cb.cname cname, phone1, phone2, phone3, phone4, phone5, " +
				  " pk.pk_yyyymm, pk.pk_status, pk.pk_place, REPLACE(memo,',','¡A') memo, pk.newuser newuser, " +
				  " To_Char(pk.newdate,'yyyy/mm/dd hh24:mi') newdate, pk.chguser chguser, " +
				  " To_Char(pk.chgdate,'yyyy/mm/dd hh24:mi') chgdate, " +
				  " To_Char(pk.activedate,'yyyy/mm/dd') activedate " +
				  " FROM egtpkcg pk, egtcbas cb WHERE pk.empno = Trim(cb.empn) ";
				  
		    if(!"".equals(empno) && empno != null)
			{
			    sql = sql + " and pk.empno = '"+empno+"' ";
			}	  
		    
			if(!"".equals(yyyymm) && yyyymm != null)
			{
			    sql = sql + " and pk.pk_yyyymm > = '"+yyyymm+"' ";
			}			
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{ 
			    CrewPickupObj obj = new CrewPickupObj();
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setCname(rs.getString("cname"));
			    obj.setPhone1(rs.getString("phone1"));
			    obj.setPhone2(rs.getString("phone2"));
			    obj.setPhone3(rs.getString("phone3"));
			    obj.setPhone4(rs.getString("phone4"));
			    obj.setPhone5(rs.getString("phone5"));
			    obj.setPk_yyyymm(rs.getString("pk_yyyymm"));
			    obj.setPk_status(rs.getString("pk_status"));
			    obj.setPk_place(rs.getString("pk_place"));
			    obj.setMemo(rs.getString("memo"));
			    obj.setNewuser(rs.getString("newuser"));
			    obj.setNewdate(rs.getString("newdate"));
			    obj.setChguser(rs.getString("chguser"));
			    obj.setChgdate(rs.getString("chgdate"));
			    obj.setActivedate(rs.getString("activedate"));
			    objAL.add(obj);
			}
        }
        catch (Exception e)
        {
                System.out.println(e.toString());	
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
    }  
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getSql()
    {
        return sql;
    }
    
}
