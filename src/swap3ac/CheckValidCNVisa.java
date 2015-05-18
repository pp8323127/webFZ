package swap3ac;

import java.sql.*;
import java.util.*;

import ci.db.*;
/**
 * AirCrewsタΑ <br>
 * CalcSwapHrs 璸衡传痁计传畉肂单
 * 
 * @author cs71
 * @version 1.0 2012/01/16
 * 
 * Copyright: Copyright (c) 2012
 */
public class CheckValidCNVisa 
{
	// public static void main(String[] args) {
	// CalcSwapHrs c = new CalcSwapHrs();
	// System.out.println(c.getTotalMin(null));
	// }

	private ArrayList aSkjAL;
	private ArrayList rSkjAL;
	private CrewInfoObj aCrewObj;
	private CrewInfoObj rCrewObj;
	private String returnstr = "";
	/**
	 * @param aSkjAL ビ叫痁
	 * @param rSkjAL 砆传痁
	 */
	
	public void setCrewSkj(ArrayList aSkjAL, ArrayList rSkjAL) 
	{
		this.aSkjAL = aSkjAL;
		this.rSkjAL = rSkjAL;
	}

	public void setCrewInfo(CrewInfoObj aCrewObj, CrewInfoObj rCrewObj) 
	{
		this.aCrewObj = aCrewObj;
		this.rCrewObj = rCrewObj;
	}
	
	public boolean job(CrewInfoObj aCrewObj, CrewInfoObj rCrewObj,ArrayList aSkjAL, ArrayList rSkjAL, String[] aSwapSkjIdx,
			String[] rSwapSkjIdx) 
	{
		if (aSwapSkjIdx == null && rSwapSkjIdx == null) 
		{
			return false;
		} 
		else 
		{
			setCrewSkj(aSkjAL, rSkjAL);
			setCrewInfo(aCrewObj, rCrewObj);
			return getValidCNVisa(aSwapSkjIdx, rSwapSkjIdx);
		}
	}

	/**
	 * @param aSkj
	 *            ビ叫传痁(index)
	 * @param rSkj
	 *            砆传传痁(index) 
	 */
	public boolean getValidCNVisa(String[] aSwapSkjIdx, String[] rSwapSkjIdx) 
	{
	    Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;	
		Driver dbDriver = null;
		int count = 0;
		String sql = "";
		boolean ifCNVisaPass = true;
	    StringBuffer aSectSB = new StringBuffer();
	    StringBuffer rSectSB = new StringBuffer();	    
	    
	    try 
		{
			ConnDB cn = new ConnDB();		    
//		    User connection pool  ********			
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
			
			// 钡硈絬
//			cn.setAOCIPRODFZUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//          stmt = conn.createStatement();			
	    
		    if(aSkjAL != null && aSwapSkjIdx != null)
		    {//ビ叫ビ叫传痁の砆传Visa expired date
				String[] aSwapSect = new String[aSwapSkjIdx.length];
				for (int i = 0; i < aSwapSect.length; i++) 
				{
					CrewSkjObj obj = (CrewSkjObj) aSkjAL.get(Integer.parseInt(aSwapSkjIdx[i]));					
					sql = " select CASE WHEN (t2.sum_cn >0 AND nvl(expiry_dts,to_date('2099','yyyy')) " +
						  " < To_Date('"+obj.getFdate()+"','yyyy/mm/dd')) THEN 1 ELSE 0 END valid " +
						  " from crew_qualifications_v t1, " +
						  " (select Sum(Decode(region_cd,'CN',1,0)) sum_cn from port_v " +
						  " where arp_cd in ('"+obj.getDpt()+"','"+obj.getArv()+"') ) t2 " +
						  " where staff_num = '"+rCrewObj.getEmpno()+"' and qual_cd='CHN' ";
					returnstr = returnstr + " ** " +sql+"  "; 
					rs = stmt.executeQuery(sql);
					
					if (rs.next())
					{
					    int ifpass = rs.getInt("valid");
					    if(ifpass>0)//1 means Got CN FLT and CN Visa expired
					    {
					        ifCNVisaPass = false;
					        break;
					    }
					}		
					else
					{//crew_qualifications_v is null
					    sql = " select Sum(Decode(region_cd,'CN',1,0)) sum_cn from port_v " +
							  " where arp_cd in ('"+obj.getDpt()+"','"+obj.getArv()+"') ";
					    rs.close();
					    rs = stmt.executeQuery(sql);
					    if (rs.next())
						{
						    int ifcnflt = rs.getInt("sum_cn");
						    if(ifcnflt>0)//1 means is CN Flt
						    {
						        ifCNVisaPass = false;
						        break;
						    }
						}		
					}
					rs.close();
				}//for (int i = 0; i < aSwapSect.length; i++) 				
		    }//if(aSkjAL != null && aSwapSkjIdx != null)
		    
		    if(ifCNVisaPass == true)
		    {//ビ叫痁硄筁CN Visa check
		        if(rSkjAL != null && rSwapSkjIdx != null)
			    {//砆传ビ叫传痁のビ叫Visa expired date
					String[] rSwapSect = new String[rSwapSkjIdx.length];
					for (int i = 0; i < rSwapSect.length; i++) 
					{
						CrewSkjObj obj = (CrewSkjObj) rSkjAL.get(Integer.parseInt(rSwapSkjIdx[i]));
						
						sql = " select CASE WHEN (t2.sum_cn >0 AND nvl(expiry_dts,to_date('2099','yyyy')) " +
							  " < To_Date('"+obj.getFdate()+"','yyyy/mm/dd')) THEN 1 ELSE 0 END valid " +
							  " from crew_qualifications_v t1, " +
							  " (select Sum(Decode(region_cd,'CN',1,0)) sum_cn from port_v " +
							  " where arp_cd in ('"+obj.getDpt()+"','"+obj.getArv()+"') ) t2 " +
							  " where staff_num = '"+aCrewObj.getEmpno()+"' and qual_cd='CHN' ";
						
						returnstr = returnstr + " ** " +sql+"  "; 
						rs = stmt.executeQuery(sql);
						
						if (rs.next())
						{
						    int ifpass = rs.getInt("valid");
						    if(ifpass>0)
						    {
						        ifCNVisaPass = false;
						        break;
						    }
						}	
						else
						{//crew_qualifications_v is null
						    sql = " select Sum(Decode(region_cd,'CN',1,0)) sum_cn from port_v " +
								  " where arp_cd in ('"+obj.getDpt()+"','"+obj.getArv()+"') ";
						    rs.close();
						    rs = stmt.executeQuery(sql);
						    if (rs.next())
							{
							    int ifcnflt = rs.getInt("sum_cn");
							    if(ifcnflt>0)//1 means is CN Flt
							    {
							        ifCNVisaPass = false;
							        break;
							    }
							}		
						}
						rs.close();
					}//for (int i = 0; i < aSwapSect.length; i++) 
			    }//if(aSkjAL != null && aSwapSkjIdx != null)		    
		    }	
		} 
		catch (Exception e) 
		{
		    returnstr = returnstr + "Error : "+e.toString();
		    ifCNVisaPass = false;
//			return e.toString();
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}
			
			if (conn != null)
				try {
//				     System.out.println("********conn close ***********");
					conn.close();
				} catch (SQLException e) {}		
			
		}
		return ifCNVisaPass;  
	}
	
	public String getStr()
	{
	    return returnstr;
	}
}