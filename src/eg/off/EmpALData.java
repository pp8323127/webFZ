package eg.off;

import java.sql.*;

import ci.db.*;

/**
 * @author cs71 Created on  2007/8/1
 * 計算某一組員有效假日數
 */
public class EmpALData
{
    public static void main(String[] args)
    {
        EmpALData ead = new EmpALData("635867");
        EmpALDataObj obj = ead.getEmpALData();
        System.out.println(obj.getEmpno());
        System.out.println(obj.getBasedate());
        System.out.println("next year "+obj.getNextyear());
        System.out.println(obj.getNextyearstartdate());
        System.out.println(obj.getNextyearenddate());
        System.out.println(obj.getNextdaysused());
        System.out.println("this year "+obj.getThisyear());
        System.out.println(obj.getThisyearstartdate());
        System.out.println(obj.getThisyearenddate());
        System.out.println(obj.getThisdaysused());
        System.out.println("last year "+obj.getLastyear());   
        System.out.println(obj.getLastyearstartdate());
        System.out.println(obj.getLastyearenddate());  
        System.out.println(obj.getLastdaysused());
    }

	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;	
	private String sql = null;
	private EmpALDataObj obj = null;
	
	public EmpALData(String empno)
    {   
        obj = new EmpALDataObj();    
        obj.setEmpno(empno);     
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
			
			// get next year data
			//****************************************************************************
			sql = " SELECT sum(Nvl(offquota,0)) quota, sum(nvl(useddays,0)) useddays, to_char(Min(eff_dt),'yyyy/mm/dd') eff_dt, " +
				  " to_char(Max(exp_dt),'yyyy/mm/dd') exp_dt " +
				  " FROM egtoffq WHERE empno = '"+empno+"' AND offtype = '0' " +
				  " AND trunc(eff_dt,'dd') > trunc(sysdate,'dd') group by empno ";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
			    obj.setNextyear(rs.getInt("quota"));
			    obj.setNextdaysused(rs.getInt("useddays"));
			    obj.setNextyearstartdate(rs.getString("eff_dt"));
			    obj.setNextyearenddate(rs.getString("exp_dt"));
			}
			rs.close();
			
			 //get this & last year data
			//****************************************************************************
			sql = " SELECT nvl(offquota,0) quota, nvl(useddays,0) useddays, to_char(eff_dt,'yyyy/mm/dd') eff_dt, " +
				  " to_char(exp_dt,'yyyy/mm/dd') exp_dt  FROM egtoffq  " +
				  " WHERE empno = '"+empno+"' AND offtype = '0' " +
				  " AND trunc(sysdate,'dd') between trunc(eff_dt,'dd') AND trunc(exp_dt,'dd') " +
				  " ORDER BY eff_dt desc ";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			int num = 1;
			while(rs.next())
			{
			    if(num == 1)
			    {//this year
			        obj.setThisyear(rs.getInt("quota"));
				    obj.setThisdaysused(rs.getInt("useddays"));
				    obj.setThisyearstartdate(rs.getString("eff_dt"));
				    obj.setThisyearenddate(rs.getString("exp_dt"));
			    }
			    
			    if(num == 2)
			    {//last year
			        obj.setLastyear(rs.getInt("quota"));
				    obj.setLastdaysused(rs.getInt("useddays"));
				    obj.setLastyearstartdate(rs.getString("eff_dt"));
				    obj.setLastyearenddate(rs.getString("exp_dt"));
			    }
			    
			    num ++;			    
			}
			rs.close();		
//			
////			get un-deduct al days
//			//****************************************************************************
//			sql = " SELECT count(*) c FROM egtoffs WHERE remark = 'N'  " +
//				  " and (empn = '"+empno+"' OR sern = '"+empno+"') AND offtype = '0' ";
//			
////			System.out.println(sql);
//			rs = stmt.executeQuery(sql);			
//			if(rs.next())
//			{			    
//			     obj.setUndeductdays(rs.getInt("c"));		    
//			}
//			rs.close();		
			
			
//			get basedate
			//****************************************************************************
			sql = " SELECT To_Char(bnftdt,'yyyy/mm/dd') hraldate FROM hrvegemploy WHERE employid = '"+empno+"'";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);			
			if(rs.next())
			{			    
			     obj.setBasedate(rs.getString("hraldate"));		    
			}
			rs.close();		
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
    
    public EmpALDataObj getEmpALData()
    {
        return obj;
    }
    
}
