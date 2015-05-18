package crewhousing;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/8/6
 */
public class CrewHousingInfoForTelex
{

    public static void main(String[] args)
    {
        CrewHousingInfoForTelex chouse = new CrewHousingInfoForTelex();
        chouse.getCrewHousingInfo("2009/05/16");
        String str = chouse.getCrewHousingTelexInfo("2009/05/16");
        System.out.println(chouse.getHousingInfoForTelexAL().size());
        System.out.println(str);
    }
    
    ArrayList housingInfoForTelexAL = new ArrayList();
    String  returnsql = "";
    
    public String getCrewHousingInfo(String fdate) 
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
            

			sql = " SELECT r.*, Nvl(t.TYPE,'N') ifsent, " +
				  //" CASE WHEN t.fdate_loc <= SYSDATE THEN 'Y' ELSE 'N' END  shouldsent, " +
				  " CASE WHEN (t.fdate_loc <= SYSDATE OR t.fdate_loc IS NULL ) THEN 'Y' ELSE 'N' END  shouldsent, " +		
				  " To_Char(r.trip_str_tpe,'yyyy/mm/dd hh24:mi') trip_str_tpe2, " +
				  " To_Char(r.fdate_loc,'yyyy/mm/dd hh24:mi') fdate_loc2, " +
				  " To_Char(r.delete_apply_tmst,'yyyy/mm/dd hh24:mi') delete_apply_tmst2, " +
				  " To_Char(r.delete_reply_tmst,'yyyy/mm/dd hh24:mi') delete_reply_tmst2, " +
				  " To_Char(r.empno1_tmst,'yyyy/mm/dd hh24:mi') empno1_tmst2, " +
				  " To_Char(r.empno2_tmst,'yyyy/mm/dd hh24:mi') empno2_tmst2, " +
				  " To_Char(r.chgdate,'yyyy/mm/dd hh24:mi') chgdate2 " +
				  " FROM fztroom r , fztelex t " +
				  " WHERE r.trip_str_tpe = t.fdate_tpe (+)  " +
				  " and r.trip_str_tpe BETWEEN To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " and To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi') " +
				  " and ((empno1_tmst is not null and empno2_tmst is not null and r.type='SR') or r.type='NR') " +
				  " AND (r.delete_ind IS NULL OR r.delete_ind <> 'Y') " +
				  " order by r.trip_str_tpe desc ";
//			System.out.println(sql);
			returnsql = sql;
			rs = stmt.executeQuery(sql);
			housingInfoForTelexAL.clear();
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
			    obj.setType(rs.getString("type"));
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
			    obj.setIfsent(rs.getString("ifsent").trim());
			    obj.setShouldsent(rs.getString("shouldsent").trim());
			    housingInfoForTelexAL.add(obj);
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
    
    public String getCrewHousingTelexInfo(String fdate) 
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

//			sql = " SELECT To_Char(a.trip_str_tpe,'yyyy/mm/dd hh24:mi') trip_str_tpe, " +
//				  " To_Char(a.fdate_loc,'yyyy/mm/dd hh24:mi') fdate_loc, a.fltno, a.port_a, a.port_b, " +
//				  " CASE WHEN t.fdate_loc IS null THEN 'N' ELSE 'Y' END ifsent, " +
//				  " CASE WHEN (a.trip_str_tpe-2)<=SYSDATE THEN 'Y' ELSE 'N' END shouldsent FROM ( " +
//				  " SELECT trip_str_tpe, fdate_loc, fltno, port_a, port_b, " +
//				  " CASE WHEN (TYPE='SR' AND empno2_tmst IS NOT NULL ) OR (TYPE='NR') THEN 'Y' ELSE 'N' END ifvalid " +
//				  " FROM fztroom " +
//				  " WHERE fdate_loc BETWEEN To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi')  " +
//				  " AND  To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi') " +
//				  " AND (delete_ind IS NULL OR delete_ind <> 'Y') ) a, fztelex t " +
//				  " WHERE a.fdate_loc = t.fdate_loc(+) AND a.ifvalid = 'Y' " +
//				  " GROUP BY a.trip_str_tpe, a.fdate_loc, a.fltno, a.port_a, a.port_b, t.fdate_loc ";
            
            sql = " SELECT To_Char(a.trip_str_tpe,'yyyy/mm/dd hh24:mi') trip_str_tpe, " +
				  " To_Char(a.fdate_loc,'yyyy/mm/dd hh24:mi') fdate_loc, a.fltno, a.port_a, a.port_b, " +
				  " CASE WHEN t.fdate_loc IS null THEN 'N' ELSE 'Y' END ifsent, " +
//				  " CASE WHEN (a.trip_str_tpe-2)<=SYSDATE THEN 'Y' ELSE 'N' END shouldsent " +
				  //********************* add bt betty
				  " CASE WHEN a.ifvalid = 'Y' THEN 'Y' ELSE 'N' END shouldsent " +
				  //*********************
				  " FROM ( " +
				  " SELECT trip_str_tpe, fdate_loc, fltno, port_a, port_b, " +
				  " CASE WHEN (TYPE='SR' AND empno2_tmst IS NOT NULL ) OR (TYPE='NR') THEN 'Y' ELSE 'N' END ifvalid " +
				  " FROM fztroom " +
				  " WHERE fdate_loc BETWEEN To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi')  " +
				  " AND  To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi') " +
				  " AND (delete_ind IS NULL OR delete_ind <> 'Y') ) a, fztelex t " +
				  " WHERE a.fdate_loc = t.fdate_loc(+) " +
				  //delete
//				  " AND a.ifvalid = 'Y' " +
				  " GROUP BY a.trip_str_tpe, a.fdate_loc, a.fltno, a.port_a, a.port_b, t.fdate_loc, " +
				  //********************
				  " a.ifvalid ";
            	  //********************
//			System.out.println(sql);
			returnsql = sql;
			rs = stmt.executeQuery(sql);
			housingInfoForTelexAL.clear();
			while (rs.next())
			{
			    CrewHousingInfoObj obj = new CrewHousingInfoObj();
			   
			    obj.setFltno(rs.getString("fltno"));
			    obj.setStr_loc(rs.getString("fdate_loc"));
			    obj.setTrip_str_tpe(rs.getString("trip_str_tpe"));
			    obj.setPort_a(rs.getString("port_a"));
			    obj.setPort_b(rs.getString("port_b"));
			    obj.setIfsent(rs.getString("ifsent").trim());
			    obj.setShouldsent(rs.getString("shouldsent").trim());
			    housingInfoForTelexAL.add(obj);
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
    
    public ArrayList  getHousingInfoForTelexAL()
	{
	    return housingInfoForTelexAL;
	}
    
    public String  getSQL()
	{
	    return returnsql;
	}
}
