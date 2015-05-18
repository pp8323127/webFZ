package eg.off;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2007/4/24
 */
public class ALPeriod
{

    public static void main(String[] args)
    {
        ALPeriod oys = new ALPeriod();      
        oys.getALPeriod("635867");
        ArrayList objAL = oys.getObjAL();
        for(int i=0; i<objAL.size(); i++)
        {
            ALPeriodObj obj = (ALPeriodObj) objAL.get(i);
            System.out.println(obj.getEff_dt()+" ~ "+obj.getExp_dt());
        } 
    }
    
	
	private String sql = null;
	private ArrayList objAL = new ArrayList();
	
	public String getALPeriod(String empno) 
    {   
	    Driver dbDriver = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			stmt = conn.createStatement();	
			
//			sql = " SELECT empno, sern, offtype, offquota, useddays, To_Char(eff_dt,'yyyy/mm/dd') eff_dt, " +
//				  " To_Char(exp_dt,'yyyy/mm/dd') exp_dt " +
//				  " FROM egtoffq WHERE empno = '"+empno+"'" +
//				  " AND ( trunc(SYSDATE,'dd') BETWEEN eff_dt and exp_dt OR eff_dt > trunc(SYSDATE,'dd') " +
//				  " OR exp_dt>=Trunc(SYSDATE,'yyyy')) " +
//				  " and offtype in ('0','16','8') ";
			
			sql = "SELECT empno, sern, offtype, offquota, useddays, To_Char(eff_dt,'yyyy/mm/dd') eff_dt, " +
				"	To_Char(exp_dt,'yyyy/mm/dd') exp_dt ,origdays" +
				"   FROM egtoffq WHERE empno = '"+empno+"'" +
				"   AND ( trunc(SYSDATE,'dd') BETWEEN eff_dt and exp_dt OR eff_dt > trunc(SYSDATE,'dd') " +
				"   OR exp_dt>=Trunc(SYSDATE,'yyyy')) " +
				"   and offtype in ('0','16','8') order by offtype, eff_dt, exp_dt";


//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
			    ALPeriodObj obj = new ALPeriodObj();
			    obj.setEmpno(rs.getString("empno"));
			    obj.setSern(rs.getString("sern"));
			    obj.setOfftype(rs.getString("offtype"));			    
			    obj.setOffquota(rs.getString("offquota"));
			    obj.setUseddays(rs.getString("useddays"));
			    obj.setEff_dt(rs.getString("eff_dt"));
			    obj.setExp_dt(rs.getString("exp_dt"));
//			    obj.setNewuser(rs.getString("newuser"));
//			    obj.setNewdate(rs.getString("newdate"));
//			    obj.setUpduser(rs.getString("upduser"));
//			    obj.setUpddate(rs.getString("upddate"));
//			    obj.setMemo(rs.getString("memo"));
			    obj.setOrigdays(rs.getString("origdays"));
//			    obj.setOverdays(rs.getString("overdays"));
//			    obj.setDeduct_tmst(rs.getString("deduct_tmst"));
			    objAL.add(obj);
			}	
			return "Y";
        }
        catch (Exception e)
        {               
               System.out.println(e.toString());
               return e.toString();
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
	
}
