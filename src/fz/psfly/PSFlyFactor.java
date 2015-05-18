package fz.psfly;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2008/11/12
 */
public class PSFlyFactor
{      
	ArrayList factorMAL = new ArrayList();
	ArrayList factorSAL = new ArrayList();
	ArrayList factorAL = new ArrayList();

    public static void main(String[] args)
    {
        ArrayList factorMAL = new ArrayList();
        ArrayList factorSAL = new ArrayList();
        ArrayList factorAL = new ArrayList();

        PSFlyFactor psf = new PSFlyFactor();
        psf.getFactorMList();
        factorMAL = psf.getFactorMAL();
        psf.getFactorSList();
        factorSAL = psf.getFactorSAL();
        psf.getFactorList("Y");
        factorAL = psf.getFactorAL();
        System.out.println(factorMAL.size());
        System.out.println(factorSAL.size());
        System.out.println(factorAL.size());

    }
   
    public void getFactorMList() 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();      

    		sql = " SELECT * FROM egtpsff where psfm_itemno = 'A' order by factor_no"; 
    		
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			   PSFlyFactorObj obj = new PSFlyFactorObj();
			   obj.setFactor_no(rs.getString("factor_no"));
			   obj.setFactor_desc(rs.getString("factor_desc"));			   
			   factorMAL.add(obj);
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
    
    public void getFactorMList(String psfm_itemno) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();      

    		sql = " SELECT * FROM egtpsff where psfm_itemno = '"+psfm_itemno+"' order by factor_no"; 
    		
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			   PSFlyFactorObj obj = new PSFlyFactorObj();
			   obj.setFactor_no(rs.getString("factor_no"));
			   obj.setFactor_desc(rs.getString("factor_desc"));			   
			   factorMAL.add(obj);
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
    
    public void getFactorSList() 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();      

    		sql = " SELECT * FROM egtpsfs where flag = 'Y' and psfm_itemno = 'A' order by kin, factor_sub_no "; 
    		
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			   PSFlyFactorObj obj = new PSFlyFactorObj();			   
			   obj.setFactor_sub_no(rs.getString("factor_sub_no"));
			   obj.setFactor_sub_desc(rs.getString("factor_sub_desc"));
			   obj.setFlag(rs.getString("flag"));
			   obj.setKin(rs.getString("kin"));
			   factorSAL.add(obj);
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
    
    public void getFactorSList(String psfm_itemno) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();      

    		sql = " SELECT * FROM egtpsfs where flag = 'Y' and psfm_itemno = '"+psfm_itemno+"' order by kin, factor_sub_no "; 
    		
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			   PSFlyFactorObj obj = new PSFlyFactorObj();			   
			   obj.setFactor_sub_no(rs.getString("factor_sub_no"));
			   obj.setFactor_sub_desc(rs.getString("factor_sub_desc"));
			   obj.setFlag(rs.getString("flag"));
			   obj.setKin(rs.getString("kin"));
			   factorSAL.add(obj);
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
    
    public void getFactorList(String flag) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            if("".equals(flag))
            {
    			sql = " SELECT ff.*, fs.* FROM egtpsff ff, egtpsfs fs " +
    				  " WHERE factor_no = kin and ff.psfm_itemno = 'A' and fs.psfm_itemno = 'A' " +
    				  " order by kin, factor_sub_no ";    
            }
            else
            {
    			sql = " SELECT ff.*, fs.* FROM egtpsff ff, egtpsfs fs " +
    				  " WHERE factor_no = kin  AND fs.flag = '"+flag+"' " +
    				  " and ff.psfm_itemno = 'A' and fs.psfm_itemno = 'A' " +
    				  " order by kin, factor_sub_no ";               
            }
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			   PSFlyFactorObj obj = new PSFlyFactorObj();
			   obj.setFactor_no(rs.getString("factor_no"));
			   obj.setFactor_desc(rs.getString("factor_desc"));
			   obj.setFactor_sub_no(rs.getString("factor_sub_no"));
			   obj.setFactor_sub_desc(rs.getString("factor_sub_desc"));
			   obj.setFlag(rs.getString("flag"));
			   obj.setKin(rs.getString("kin"));
			   obj.setPsfm_itemno("A");
			   factorAL.add(obj);
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
    
    public void getFactorList(String flag, String psfm_itemno) 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            if("".equals(flag))
            {
    			sql = " SELECT ff.*, fs.* FROM egtpsff ff, egtpsfs fs " +
    				  " WHERE factor_no = kin and ff.psfm_itemno = '"+psfm_itemno+"' and fs.psfm_itemno = '"+psfm_itemno+"' " +
    				  " order by kin, factor_sub_no "; 
            }
            else
            {
    			sql = " SELECT ff.*, fs.* FROM egtpsff ff, egtpsfs fs " +
    				  " WHERE factor_no = kin  AND fs.flag = '"+flag+"' " +
    				  " and ff.psfm_itemno = '"+psfm_itemno+"' and fs.psfm_itemno = '"+psfm_itemno+"' " +
    				  " order by kin, factor_sub_no ";    			
            }
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			   PSFlyFactorObj obj = new PSFlyFactorObj();
			   obj.setFactor_no(rs.getString("factor_no"));
			   obj.setFactor_desc(rs.getString("factor_desc"));
			   obj.setFactor_sub_no(rs.getString("factor_sub_no"));
			   obj.setFactor_sub_desc(rs.getString("factor_sub_desc"));
			   obj.setFlag(rs.getString("flag"));
			   obj.setKin(rs.getString("kin"));
			   obj.setPsfm_itemno(rs.getString("psfm_itemno"));
			   factorAL.add(obj);
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
    
    public ArrayList getFactorAL()
    {
        return factorAL;
    }
    
    public ArrayList getFactorMAL()
    {
        return factorMAL;
    }
    
    public ArrayList getFactorSAL()
    {
        return factorSAL;
    }
}
