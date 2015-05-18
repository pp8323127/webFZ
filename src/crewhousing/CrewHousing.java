package crewhousing;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/8/5
 */
public class CrewHousing
{

    ArrayList mergeFltAL = new ArrayList();
    ArrayList mergeCrewAL = new ArrayList();
    ArrayList mergeCrewTempAL = new ArrayList();
    String returnsql = "";
    public static void main(String[] args)
    {
        CrewHousing chouse = new CrewHousing();
//        String str = chouse.getAvailableMergeFlt("639455");
//        System.out.println(chouse.getMergeFltAL().size());
//        System.out.println(str);
        
//        String str = chouse.getMergeFlt("2008/08/22");
//        System.out.println(chouse.getMergeFltAL().size());
//        System.out.println(str);
        
        String str1 = chouse.getAvailableMergeCrew("1102265");
        System.out.println(chouse.getMergeCrewAL().size());
        System.out.println(str1);
    }
	
	public String getAvailableMergeFlt(String empno) 
	{		
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		String stn = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT s.stn stn  FROM fztrstn s " +
		      	  " WHERE s.effdt <= Trunc(sysdate,'dd') AND ( s.expdt IS NULL OR s.expdt >= Trunc(sysdate,'dd')) ";
		//      System.out.println(sql);
		      rs = stmt.executeQuery(sql);
		      while(rs.next())
		      {
		          stn = stn +",'"+rs.getString("stn")+"'";
		      }
		      stn = stn.substring(1);
		      rs.close();
			
			sql = " SELECT r.staff_num, r.str_dt, r.act_str_dt, to_char(dps.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt_tm_gmt, " +
				  " to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') act_str_dt_tm_gmt, " +
				  " r.end_dt, r.act_end_dt,dps.end_dt_tm_gmt,dps.act_end_dt_tm_gmt,r.roster_num, " +
				  " r.duty_cd, dps.duty_cd, r.series_num, r.location_cd, dps.trip_num, dps.series_num, " +
				  " dps.tod_start_loc_ds, dps.str_dt_tm_gmt, dps.act_str_dt_tm_gmt, " +
				  " dps.end_dt_tm_gmt, dps.act_end_dt_tm_gmt,dps.flt_num, dps.act_port_a, dps.act_port_b, " +
				  " dps.fd_ind, dps.duty_seq_num, dps.item_seq_num " +
				  " FROM fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps , " +
				  "      ( SELECT  r.staff_num, r.series_num " +
				  "        FROM fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps , " +
				  "            (  SELECT r.series_num series_num  " +
				  "               FROM  fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps " +
				  "               WHERE dps.series_num=r.series_num AND r.staff_num ='"+empno+"' " +
				  "                   AND  r.delete_ind='N' and dps.duty_seq_num||dps.item_seq_num=11  " +
				  "                   AND fd_ind = 'N' AND dps.delete_ind='N' AND r.duty_cd IN ('FLY','TVL') " +
				  "                   AND act_str_dt >= SYSDATE+2 " +
				  "                   AND act_str_dt <= ( SELECT Max(Last_Day(To_Date(yyyy||'/'||mm||'/01 23:59','yyyy/mm/dd hh24:mi'))) " +
				  "                                        FROM fztspub WHERE pubdate <= SYSDATE))  s  " +
				  "        								  WHERE dps.series_num=r.series_num AND r.series_num IN (s.series_num) " +
				  "              							AND r.delete_ind='N' AND r.staff_num ='"+empno+"'  AND dps.delete_ind='N' " +
				  "              							AND act_port_b IN ("+stn+") GROUP BY  r.staff_num, r.series_num ) s2 " +
				  "        WHERE dps.series_num=r.series_num AND r.series_num IN (s2.series_num) " +
				  "              AND r.delete_ind='N' AND r.staff_num ='"+empno+"'  AND dps.delete_ind='N' " +
				  "              and dps.duty_seq_num||dps.item_seq_num=11 ORDER BY dps.act_str_dt_tm_gmt ";
//			System.out.println(sql);
			returnsql = sql;
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
			    CrewHousingObj obj = new CrewHousingObj();
			    obj.setTrip_str_tpe(rs.getString("str_dt_tm_gmt"));
			    obj.setFdate_loc(rs.getString("act_str_dt_tm_gmt"));
			    obj.setFltno(rs.getString("flt_num"));
			    obj.setSeries_num1(rs.getString("series_num"));
			    obj.setPort_a(rs.getString("act_port_a"));
			    obj.setPort_b(rs.getString("act_port_b"));
			    mergeFltAL.add(obj);
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
	
	public String getMergeFlt(String fdate) //List Flts of available station
	{		
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		String stn = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT s.stn stn  FROM fztrstn s " +
		      	  " WHERE s.effdt <= Trunc(sysdate,'dd') AND ( s.expdt IS NULL OR s.expdt >= Trunc(sysdate,'dd')) ";
		//      System.out.println(sql);
		      rs = stmt.executeQuery(sql);
		      while(rs.next())
		      {
		          stn = stn +",'"+rs.getString("stn")+"'";
		      }
		      stn = stn.substring(1);
		      rs.close();
			
			sql = " SELECT To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') str_dt_tm_loc , flt_num, act_port_a, " +
				  " act_port_b, To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') end_dt_tm_loc, " +
				  " To_Char(dps.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt_tm_gmt " +
				  " FROM  fzdb.duty_prd_seg_v dps " +
				  " WHERE  str_dt_tm_loc BETWEEN To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " AND  To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi') AND delete_ind <> 'Y' " +
				  " AND act_port_b IN ("+stn+") AND duty_cd IN ('FLY','TVL') AND dps.fd_ind = 'N' " +
				  " GROUP BY dps.str_dt_tm_loc , flt_num, act_port_a, act_port_b, dps.end_dt_tm_loc, dps.str_dt_tm_gmt " +
				  " ORDER BY str_dt_tm_loc ";
			returnsql = sql;
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
			    CrewHousingInfoObj obj = new CrewHousingInfoObj();
			    obj.setStr_loc(rs.getString("str_dt_tm_loc"));
			    obj.setEnd_loc(rs.getString("end_dt_tm_loc"));
			    obj.setTrip_str_tpe(rs.getString("str_dt_tm_gmt"));
			    obj.setFltno(rs.getString("flt_num"));
			    obj.setPort_a(rs.getString("act_port_a"));
			    obj.setPort_b(rs.getString("act_port_b"));
			    mergeFltAL.add(obj);
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
	
	public String getAvailableMergeCrew(String series_num)
	{		
	    Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		String sql = "";
		String tpe_str_dt = "";
		String stn = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT to_char(str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt_tm_gmt, s.stn stn " +
            	  " FROM fzdb.duty_prd_seg_v dps, fztrstn s " +
            	  " WHERE dps.series_num ='"+series_num+"' AND dps.duty_seq_num=1 and dps.item_seq_num =1 " +
            	  "       AND dps.delete_ind='N' AND fd_ind = 'N' and s.effdt <= Trunc(dps.str_dt_tm_gmt,'dd') " +
            	  "       AND ( s.expdt IS NULL OR s.expdt >= Trunc(dps.str_dt_tm_gmt,'dd')) ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                tpe_str_dt = rs.getString("str_dt_tm_gmt");
                stn = stn + rs.getString("stn") + ",";
            }
            rs.close();
//            System.out.println(tpe_str_dt);
//            System.out.println(stn);
			
			sql = " SELECT r.staff_num, c.preferred_name, r.series_num, dps.flt_num, dps.act_port_a, " +
				  " dps.act_port_b, dps.duty_seq_num,dps.item_seq_num , to_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') str_dt_tm_loc, " +
				  " to_char(dps.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt_tm_gmt , " +
				  " Round(act_end_dt_tm_gmt-act_str_dt_tm_gmt,0) range_days " +
				  " FROM fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps , fzdb.crew_v c " +
				  " WHERE  dps.series_num=r.series_num AND r.staff_num = c.staff_num AND r.series_num ='"+series_num+"'" +
				  " AND r.delete_ind='N' AND dps.delete_ind='N' AND fd_ind = 'N' " +
				  " ORDER BY staff_num , duty_seq_num ";
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
			    CrewHousingObj obj = new CrewHousingObj();
			    if(stn.indexOf(rs.getString("act_port_b")) >= 0)
			    {
				    obj.setEmpno2(rs.getString("staff_num"));
				    obj.setCname2(ci.tool.UnicodeStringParser.removeExtraEscape(rs.getString("preferred_name")));
				    obj.setSeries_num2(rs.getString("series_num"));
				    obj.setFltno(rs.getString("flt_num"));
				    obj.setDuty_seq_num(rs.getString("duty_seq_num"));
				    obj.setItem_seq_num(rs.getString("item_seq_num"));
				    obj.setFdate_loc(rs.getString("str_dt_tm_loc"));
				    obj.setTrip_str_tpe(tpe_str_dt);
				    obj.setFltno(rs.getString("flt_num"));
				    obj.setPort_a(rs.getString("act_port_a"));
				    obj.setPort_b(rs.getString("act_port_b"));
				    obj.setLo_cnt(rs.getString("range_days"));		    
				    mergeCrewTempAL.add(obj);
			    }
			}

			CrewHousingObj dummyobj = new CrewHousingObj();
			mergeCrewTempAL.add(dummyobj);			
			
			if(mergeCrewTempAL.size()>1)
			{
				for(int i=0; i<mergeCrewTempAL.size()-1; i++)
				{
				    CrewHousingObj obj1 = (CrewHousingObj) mergeCrewTempAL.get(i);
				    CrewHousingObj obj2 = (CrewHousingObj) mergeCrewTempAL.get(i+1);	
				    if("LO".equals(obj2.getFltno()))
				    {
				        obj1.setLo_cnt(obj2.getLo_cnt());
				    }
	
				    if(!"LO".equals(obj1.getFltno()))
				    {
				        mergeCrewAL.add(obj1);
				    }
				}
			}
			
			if(mergeCrewAL.size()>1)
			{
			    sql = " SELECT nvl(empno1,' ') empno1, nvl(empno2,' ') empno2, type, empno2_tmst, " +
					  " CASE WHEN (TYPE='SR' AND empno2_tmst IS NOT NULL ) OR (TYPE='NR') THEN 'Y' ELSE 'N' END ifvalid " +
					  " FROM fztroom " +
					  " WHERE ( series_num1 = '"+series_num+"' or series_num2 = '"+series_num+"') " +
					  " AND (delete_ind <> 'Y' OR delete_ind IS null) ";
			    rs = stmt.executeQuery(sql);
				while (rs.next())
				{			    
//				    if("Y".equals(rs.getString("ifvalid")))
//				    {
						for(int i=0; i<mergeCrewAL.size(); i++)
						{
						    CrewHousingObj obj1 = (CrewHousingObj) mergeCrewAL.get(i);
						    if(rs.getString("empno1").equals(obj1.getEmpno2()) | rs.getString("empno2").equals(obj1.getEmpno2()))
						    {   
//						        System.out.println(obj1.getEmpno2());
						        obj1.setIfvalid("Y");
						    }					    
						}
//				    }
				}
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
	
	public ArrayList  getMergeFltAL()
	{
	    return mergeFltAL;
	}
	
	public ArrayList  getMergeCrewAL()
	{
	    return mergeCrewAL;
	}
	
	 public String  getSQL()
	{
	    return returnsql;
	}
    
}
