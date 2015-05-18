package crewhousing;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/8/6
 */
public class CrewHousingInfo
{

    public static void main(String[] args)
    {
        CrewHousingInfo chouse = new CrewHousingInfo();
        String str = chouse.getCrewHousingInfo("639455");
        System.out.println(chouse.getHousingInfoAL().size());
        System.out.println(str);
    }
    
    ArrayList housingInfoAL = new ArrayList();
    
    public String getCrewHousingInfo(String empno) 
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
            

			sql = " SELECT r.*, To_Char(trip_str_tpe,'yyyy/mm/dd hh24:mi') trip_str_tpe2, " +
				  " To_Char(fdate_loc,'yyyy/mm/dd hh24:mi') fdate_loc2, " +
				  " To_Char(delete_apply_tmst,'yyyy/mm/dd hh24:mi') delete_apply_tmst2, " +
				  " To_Char(delete_reply_tmst,'yyyy/mm/dd hh24:mi') delete_reply_tmst2, " +
				  " To_Char(empno1_tmst,'yyyy/mm/dd hh24:mi') empno1_tmst2, " +
				  " To_Char(empno2_tmst,'yyyy/mm/dd hh24:mi') empno2_tmst2, " +
				  " To_Char(chgdate,'yyyy/mm/dd hh24:mi') chgdate2, " +
		          " case when trip_str_tpe-sysdate >2 then 'Y' else 'N' end editable " + 
				  //" CASE WHEN r.trip_str_tpe>= (SYSDATE+2) THEN 'Y' ELSE 'N' END display " +
				  " FROM fztroom r WHERE empno1='"+empno+"' OR empno2 ='"+empno+"' " +
				  " order by trip_str_tpe desc ";
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
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
			    obj.setEditable(rs.getString("editable"));
			    housingInfoAL.add(obj);
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
    
    public String getCrewHousingInfoByFdate(String fdate) 
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
            

			sql = " SELECT r.*, To_Char(trip_str_tpe,'yyyy/mm/dd hh24:mi') trip_str_tpe2, " +
				  " To_Char(fdate_loc,'yyyy/mm/dd hh24:mi') fdate_loc2, " +
				  " To_Char(delete_apply_tmst,'yyyy/mm/dd hh24:mi') delete_apply_tmst2, " +
				  " To_Char(delete_reply_tmst,'yyyy/mm/dd hh24:mi') delete_reply_tmst2, " +
				  " To_Char(empno1_tmst,'yyyy/mm/dd hh24:mi') empno1_tmst2, " +
				  " To_Char(empno2_tmst,'yyyy/mm/dd hh24:mi') empno2_tmst2, " +
				  " To_Char(chgdate,'yyyy/mm/dd hh24:mi') chgdate2," +
				  " case when trip_str_tpe-sysdate >2 then 'Y' else 'N' end editable " +	
				  " FROM fztroom r " +
				  " WHERE fdate_loc BETWEEN To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " AND  To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi')" +
				  " order by trip_str_tpe desc ";
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
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
			    obj.setEditable(rs.getString("editable"));
			    housingInfoAL.add(obj);
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
    
    public ArrayList  getHousingInfoAL()
	{
	    return housingInfoAL;
	}
}
