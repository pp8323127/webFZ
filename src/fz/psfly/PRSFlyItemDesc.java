package fz.psfly;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71
 * @version 1.0 2008/07/29
 * 
 * Copyright: Copyright (c) 2008
 */
public class PRSFlyItemDesc 
{
	 public static void main(String[] args) 
	 {
	     PRSFlyItemDesc prid = new PRSFlyItemDesc();
	     prid.getBankItemData();
	     System.out.println(prid.getBankItemDesc("3"));
	     prid.getFactorData();
	     System.out.println(prid.getFactorDesc(null));
	     prid.getFactorSubData();
	     System.out.println(prid.getFactorSubDesc(null,null));
	     System.out.println("Done");
	 }

	private String fdate;// format: yyyy/mm/dd
	private String fltno;
	private String sect;
	private String purserEmpno;	
	private boolean haspsfly = false;
	ArrayList bankItemdescAL = new ArrayList();
	ArrayList factordescAL = new ArrayList();
	ArrayList factorsubdescAL = new ArrayList();

	/**
	 * @param fdate
	 *            日期
	 * @param fltno
	 *            班號
	 * @param sect
	 *            航段
	 * @param purserEmpno
	 *            座艙長員工號	 
	 */
	
	
	public void getBankItemData() 
	{ 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		bankItemdescAL.clear();

		try 
		{
//            ConnDB cn = new ConnDB();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " SELECT * FROM egtpsfi where qtype = 'S' and kin = 'A' ";
			rs = stmt.executeQuery(sql);
//			System.out.println(sql);
			while(rs.next())
			{
			    PRSFlyFactorObj obj = new PRSFlyFactorObj();
			    obj.setItemno(rs.getString("itemno"));
			    obj.setItemdesc(rs.getString("itemdesc"));			   
			    bankItemdescAL.add(obj);
			}	
//			System.out.println("1  "+bankItemdescAL.size());
		} 
		catch (SQLException e) 
		{
		    System.out.println(e.toString());
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
		} 
		finally 
		{
		    if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
		}
	}
	
	public void getBankItemData(String psfm_itemno) 
	{ 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		bankItemdescAL.clear();

		try 
		{
//            ConnDB cn = new ConnDB();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " SELECT * FROM egtpsfi where qtype = 'S' and kin = '"+psfm_itemno+"' ";
			rs = stmt.executeQuery(sql);
//			System.out.println(sql);
			while(rs.next())
			{
			    PRSFlyFactorObj obj = new PRSFlyFactorObj();
			    obj.setItemno(rs.getString("itemno"));
			    obj.setItemdesc(rs.getString("itemdesc"));			   
			    bankItemdescAL.add(obj);
			}	
//			System.out.println("1  "+bankItemdescAL.size());
		} 
		catch (SQLException e) 
		{
		    System.out.println(e.toString());
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
		} 
		finally 
		{
		    if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			}
		}
	}
	
	public String getBankItemDesc(String itemno)
	{
//	    System.out.println("2 "+bankItemdescAL.size());
	   if(itemno != null && !"".equals(itemno))
	   {
		   for(int i =0; i< bankItemdescAL.size(); i++) 
		   {
		       PRSFlyFactorObj obj = (PRSFlyFactorObj) bankItemdescAL.get(i);
	//	       System.out.println(obj.getItemno());
		       if(itemno.equals(obj.getItemno()))
		       {
		           return obj.getItemdesc();
		       }
		   }	
	   }	   
	   return "";
	}
	
	public void getFactorData() 
	{ 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		factordescAL.clear();

		try 
		{
//            ConnDB cn = new ConnDB();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " SELECT * FROM egtpsff ";
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PSFlyFactorObj obj = new PSFlyFactorObj();
			    obj.setFactor_no(rs.getString("factor_no"));
			    obj.setFactor_desc(rs.getString("factor_desc"));			   
			    factordescAL.add(obj);
			}					
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
		} 
		finally 
		{
		    if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}
	}
	
	public void getFactorData(String psfm_itemno) 
	{ 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		factordescAL.clear();

		try 
		{
//            ConnDB cn = new ConnDB();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " SELECT * FROM egtpsff  WHERE psfm_itemno = '"+psfm_itemno+"'";
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
			    PSFlyFactorObj obj = new PSFlyFactorObj();
			    obj.setFactor_no(rs.getString("factor_no"));
			    obj.setFactor_desc(rs.getString("factor_desc"));			   
			    factordescAL.add(obj);
			}					
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
		} 
		finally 
		{
		    if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}
	}
	
	public String getFactorDesc(String factorno)
	{
	   if(factorno != null && !"".equals(factorno))
	   {
		   for(int i =0; i< factordescAL.size(); i++) 
		   {
		       PSFlyFactorObj obj = (PSFlyFactorObj) factordescAL.get(i);
		       if(factorno.equals(obj.getFactor_no()))
		       {
		           return obj.getFactor_desc();
		       }
		   }
	   }
	   return "";
	}
	
	public void getFactorSubData() 
	{ 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		factorsubdescAL.clear();

		try 
		{
//            ConnDB cn = new ConnDB();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " SELECT * FROM egtpsfs ";
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
			    PSFlyFactorObj obj = new PSFlyFactorObj();
			    obj.setFactor_no(rs.getString("kin"));
			    obj.setFactor_sub_no(rs.getString("factor_sub_no"));		
			    obj.setFactor_sub_desc(rs.getString("factor_sub_desc"));			   
			    factorsubdescAL.add(obj);
			}					
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
		} 
		finally 
		{
		    if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}
	}
	
	public void getFactorSubData(String psfm_itemno) 
	{ 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		factorsubdescAL.clear();

		try 
		{
//            ConnDB cn = new ConnDB();
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " SELECT * FROM egtpsfs WHERE psfm_itemno = '"+psfm_itemno+"'"; 
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
			    PSFlyFactorObj obj = new PSFlyFactorObj();
			    obj.setFactor_no(rs.getString("kin"));
			    obj.setFactor_sub_no(rs.getString("factor_sub_no"));		
			    obj.setFactor_sub_desc(rs.getString("factor_sub_desc"));			   
			    factorsubdescAL.add(obj);
			}					
		} 
		catch (Exception e) 
		{
		    System.out.println(e.toString());
		} 
		finally 
		{
		    if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}
	}
	
	public String getFactorSubDesc(String factorno, String factorsubno)
	{
	    if(factorno != null && !"".equals(factorno))
		{
		   for(int i =0; i< factorsubdescAL.size(); i++) 
		   {
		       PSFlyFactorObj obj = (PSFlyFactorObj) factorsubdescAL.get(i);
		       if(factorno.equals(obj.getFactor_no()) && factorsubno.equals(obj.getFactor_sub_no()))
		       {
		           return obj.getFactor_sub_desc();
		       }
		   }	
	   }
	   return "";
	}
}
