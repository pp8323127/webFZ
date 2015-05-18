package crewhousing;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/8/6
 */
public class CrewHousingInfoForStat
{

    public static void main(String[] args)
    {
        CrewHousingInfoForStat chouse = new CrewHousingInfoForStat();
        String str = chouse.getCrewHousingInfo("2009/05/16","2009/05/16","LAX");
        System.out.println(chouse.getHousingInfoForStatAL().size());
        chouse.setCrewHousingValid();

        System.out.println(str);
    }
    
    ArrayList housingInfoForStatAL = new ArrayList();
    
    public String getCrewHousingInfo(String sdate, String edate, String station) 
	{	       
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		String series_num  = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            

			sql = " SELECT r.*, " +
				  " To_Char(r.trip_str_tpe,'yyyy/mm/dd hh24:mi') trip_str_tpe2, " +
				  " To_Char(r.fdate_loc,'yyyy/mm/dd hh24:mi') fdate_loc2, " +
				  " To_Char(r.delete_apply_tmst,'yyyy/mm/dd hh24:mi') delete_apply_tmst2, " +
				  " To_Char(r.delete_reply_tmst,'yyyy/mm/dd hh24:mi') delete_reply_tmst2, " +
				  " To_Char(r.empno1_tmst,'yyyy/mm/dd hh24:mi') empno1_tmst2, " +
				  " To_Char(r.empno2_tmst,'yyyy/mm/dd hh24:mi') empno2_tmst2, " +
				  " To_Char(r.chgdate,'yyyy/mm/dd hh24:mi') chgdate2 " +
				  " FROM fztroom r " +
				  " WHERE r.trip_str_tpe BETWEEN To_Date('"+sdate+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " and To_Date('"+edate+" 23:59','yyyy/mm/dd hh24:mi') " +
				  " and ((empno1_tmst is not null and empno2_tmst is not null and type='SR') or type='NR') " +
				  " AND (r.delete_ind IS NULL OR r.delete_ind <> 'Y') " +
				  " and r.port_b = '"+station+"' " +
				  " order by r.trip_str_tpe ";
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			housingInfoForStatAL.clear();
			while (rs.next())
			{
			    CrewHousingObj obj = new CrewHousingObj();
			    obj.setFormno(rs.getString("formno"));
			    obj.setEmpno1(rs.getString("empno1"));
			    obj.setEmpno2(rs.getString("empno2"));			
			    obj.setSeries_num1(rs.getString("series_num1"));
			    series_num = rs.getString("series_num1");
			    obj.setSeries_num2(rs.getString("series_num2"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setFdate_loc(rs.getString("fdate_loc2"));
			    obj.setTrip_str_tpe(rs.getString("trip_str_tpe2"));
			    obj.setPort_a(rs.getString("port_a"));
			    obj.setPort_b(rs.getString("port_b"));
			    obj.setLo_cnt(rs.getString("lo_cnt"));
			    obj.setType(rs.getString("type").trim());
			    obj.setPhone(rs.getString("phone"));
			    obj.setEmpno1_tmst(rs.getString("empno1_tmst2"));
			    obj.setEmpno2_tmst(rs.getString("empno2_tmst2"));
			    obj.setDelete_ind(rs.getString("delete_ind"));			    
			    obj.setDelete_apply_empno(rs.getString("delete_apply_empno"));
			    obj.setDelete_apply_tmst(rs.getString("delete_apply_tmst2"));
			    obj.setDelete_reply_empno(rs.getString("delete_reply_empno"));
			    obj.setDelete_reply_tmst(rs.getString("delete_reply_tmst2"));
			    obj.setChguser(rs.getString("chguser"));
			    obj.setChgdate(rs.getString("chgdate2"));	
			    obj.setIfvalid("N");
			    housingInfoForStatAL.add(obj);
			}
			rs.close();			
			
			return "Y";			
		} 
		catch (Exception e) 
		{
			return e.toString();
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
					conn.close();
				} catch (SQLException e) {}
		}
	}
    
    public String setCrewHousingValid() 
	{		
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            for(int i=0; i<housingInfoForStatAL.size(); i++)
            {
                CrewHousingObj obj = (CrewHousingObj) housingInfoForStatAL.get(i);
                
                if("SR".equals(obj.getType()))
                {
					sql = " SELECT Count(*) c  FROM fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps " +
						  " WHERE dps.series_num=r.series_num  AND  r.delete_ind='N'  AND dps.delete_ind='N' " +
						  " AND (r.staff_num = '"+obj.getEmpno1()+"' OR r.staff_num = '"+obj.getEmpno2()+"') " +
//						  " AND (r.series_num = '"+obj.getSeries_num1()+"' OR r.series_num = '"+obj.getSeries_num2()+"') " +
						  " AND trunc(dps.str_dt_tm_gmt,'mi') = To_Date('"+obj.getTrip_str_tpe()+"','yyyy/mm/dd hh24:mi:ss') " +
						  " AND dps.port_a = '"+obj.getPort_a()+"' AND dps.port_b = '"+obj.getPort_b()+"'  " +
						  " AND r.duty_cd IN ('FLY','TVL') ";
                }
                else
                {
                    sql = " SELECT Count(*) c  FROM fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps " +
						  " WHERE dps.series_num=r.series_num  AND  r.delete_ind='N'  AND dps.delete_ind='N' " +
						  " AND r.staff_num = '"+obj.getEmpno1()+"' " +
//						  " AND r.series_num = '"+obj.getSeries_num1()+"' " +
						  " AND trunc(dps.str_dt_tm_gmt,'mi') = To_Date('"+obj.getTrip_str_tpe()+"','yyyy/mm/dd hh24:mi:ss') " +
						  " AND dps.port_a = '"+obj.getPort_a()+"' AND dps.port_b = '"+obj.getPort_b()+"'  " +
						  " AND r.duty_cd IN ('FLY','TVL') ";
                }
//				System.out.println(sql);
				rs = stmt.executeQuery(sql);
				if (rs.next())
				{
				    int c = rs.getInt("c");
//				    System.out.println("c="+ c+ "  type = "+obj.getType());
				    if("SR".equals(obj.getType()) && c==2)
				    {
//				        System.out.println("set Y");
				        obj.setIfvalid("Y");
				    } 
				   				    
				    if("NR".equals(obj.getType()) && c==1)
				    {
				        obj.setIfvalid("Y");
//				        System.out.println("set Y");
				    }
				}
				rs.close();			
            }
			return "Y";			
		} 
		catch (Exception e) 
		{
			return e.toString();
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
					conn.close();
				} catch (SQLException e) {}
		}
	}
    
    public ArrayList  getHousingInfoForStatAL()
	{
	    return housingInfoForStatAL;
	}
}
