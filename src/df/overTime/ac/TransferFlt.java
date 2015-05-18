package df.overTime.ac;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2007/11/2
 */
public class TransferFlt
{

    public static void main(String[] args)
    {
        TransferFlt flt = new TransferFlt();
        flt.getTransferFlt();
        System.out.println(flt.getObjAL().size());
        System.out.println("done");        
    }
    
    private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;	
	private String sql = null;
	ArrayList objAL = new ArrayList();
	
	public String getTransferFlt()
    {           
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
			
			// get next year data
			//****************************************************************************
			sql = " SELECT sector, upduser, To_Char(upddt,'yyyy/mm/dd') upddt " +
				  " FROM dfttrns ORDER BY sector ";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    TransferFltObj obj = new TransferFltObj();
			    obj.setSector(rs.getString("sector"));
			    obj.setUpduser(rs.getString("upduser"));
			    obj.setUpddt(rs.getString("upddt"));
			    objAL.add(obj);
			}
			return "Y";
        }
        catch (Exception e)
        {                              
                System.out.println(e.toString());
                return "TransferFlt error : "+e.toString();
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
