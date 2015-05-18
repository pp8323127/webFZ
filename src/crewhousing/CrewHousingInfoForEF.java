package crewhousing;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/8/6
 */
public class CrewHousingInfoForEF
{

    public static void main(String[] args)
    {
        CrewHousingInfoForEF chouse = new CrewHousingInfoForEF();
        ArrayList housingInfoForEFAL = new ArrayList();
        String str = chouse.getCrewHousingInfo("2009/05/16 16:40","0006","LAX");
        housingInfoForEFAL=chouse.getHousingInfoForEFAL();
        for(int i=0; i<housingInfoForEFAL.size(); i++)//skj crew list
	    {
	        CrewHousingInfoObj obj = (CrewHousingInfoObj) housingInfoForEFAL.get(i);	
	        System.out.println(obj.getEmpno()+"-->"+obj.getQual()+"--> roomtype : "+obj.getRoomtype()+"--> singleroom "+obj.getSingleroom()+"-->  doubleroom : " + obj.getDoubleroom());

	    }
        
        System.out.println(str);
    }
    
    ArrayList housingInfoForEFAL = new ArrayList();
    ArrayList roomInfoAL = new ArrayList();
    String  returnsql = "";
    
    public String getCrewHousingInfo(String fdate, String fltno, String port_b) 
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
            

			sql = " SELECT  * FROM ( SELECT To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') str_dt_tm_loc, " +
				  " To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') end_dt_tm_loc, " +
				  " To_Char(dps.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi') str_dt_tm_gmt, dps.flt_num, dps.act_port_a, " +
				  " dps.act_port_b, nvl(c.section_number,' ') grp, r.staff_num, nvl(r.acting_rank,' ') acting_rank, " +
				  " c.other_surname lastname, c.other_first_name firstname, dps.fleet_cd fleet, " +
				  " Decode(r.acting_rank, 'CA',1,'RP',2 ,'FO',3,'PR',4,5) sorting, " +
				  " c.preferred_name whole_name " +
				  " FROM fzdb.roster_v r,  fzdb.duty_prd_seg_v  dps, fzdb.crew_v c " +
				  " WHERE r.series_num = dps.series_num  AND r.staff_num = c.staff_num " +
				  " AND r.delete_ind <> 'Y' AND dps.delete_ind <> 'Y' " +
				  " and dps.flt_num = '"+fltno+"' and dps.act_port_b = '"+port_b+"' " +
				  //" AND dps.str_dt_tm_loc = To_Date('"+fdate+"','yyyy/mm/dd hh24:mi') ) " +
				  " AND dps.str_dt_tm_gmt = To_Date('"+fdate+"','yyyy/mm/dd hh24:mi') ) " +
//				  " AND dps.str_dt_tm_loc between To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi') and To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi') ) " +
				  " ORDER BY sorting, staff_num ";
//			System.out.println(sql);
			returnsql = sql ;
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
			    CrewHousingInfoObj obj = new CrewHousingInfoObj();			   
			    obj.setEmpno(rs.getString("staff_num"));
			    obj.setStr_loc(rs.getString("str_dt_tm_loc"));
			    obj.setEnd_loc(rs.getString("end_dt_tm_loc"));
			    obj.setTrip_str_tpe(rs.getString("str_dt_tm_gmt"));
			    obj.setFltno(rs.getString("flt_num"));
			    obj.setPort_a(rs.getString("act_port_a"));
			    obj.setPort_b(rs.getString("act_port_b"));
			    obj.setGrp(rs.getString("grp"));
			    obj.setFleet(rs.getString("fleet"));
			    obj.setQual(rs.getString("acting_rank"));
			    obj.setCname(ci.tool.UnicodeStringParser.removeExtraEscape(rs.getString("whole_name")));
//			    obj.setCname(rs.getString("whole_name"));
			    obj.setEname(rs.getString("lastname")+" "+rs.getString("firstname"));		
			    obj.setSingleroom("1");
			    obj.setDoubleroom("0");
			    housingInfoForEFAL.add(obj);
			}
			rs.close();		
			
			
			sql = " SELECT empno1, empno2, type, empno2_tmst, " +
				  " CASE WHEN (TYPE='SR' AND empno2_tmst IS NOT NULL ) OR (TYPE='NR') THEN 'Y' ELSE 'N' END ifvalid " +
				  " FROM fztroom " +
//				  " WHERE fdate_loc = To_Date('"+fdate+"','yyyy/mm/dd hh24:mi') " +
				  " WHERE trip_str_tpe = To_Date('"+fdate+"','yyyy/mm/dd hh24:mi') " +				  
//				  " WHERE fdate_loc between To_Date('"+fdate+" 00:00','yyyy/mm/dd hh24:mi') and To_Date('"+fdate+" 23:59','yyyy/mm/dd hh24:mi') " +
				  " and ((empno1_tmst is not null and empno2_tmst is not null and type='SR') or type='NR') " +
//				  " AND (r.delete_ind IS NULL OR r.delete_ind <> 'Y') " +
				  " AND fltno = '"+fltno+"' AND port_b = '"+port_b+"' ";
			returnsql = sql ;
			System.out.println(sql);
				rs = stmt.executeQuery(sql);
				while (rs.next())
				{
				    CrewHousingObj obj = new CrewHousingObj();			   
				    obj.setEmpno1(rs.getString("empno1"));
				    obj.setEmpno2(rs.getString("empno2"));
				    obj.setType(rs.getString("type"));
				    if("Y".equals(rs.getString("ifvalid")))
				    {
				        //兩者皆confirm 才有效
				        roomInfoAL.add(obj);
				    }
				}
				
				if(roomInfoAL.size()>0)
				{//set room type				   
				    int seq =1;
				    
				    for(int j=0; j<roomInfoAL.size(); j++)
			        {
			            CrewHousingObj obj1 = (CrewHousingObj) roomInfoAL.get(j);	
			            boolean empno1inskj = false;
					    boolean empno2inskj = false;
				    
					    //check empno1 if in crew list
			            for(int i=0; i<housingInfoForEFAL.size(); i++)//skj crew list
					    {
					        CrewHousingInfoObj obj = (CrewHousingInfoObj) housingInfoForEFAL.get(i);	
					        if(obj1.getEmpno1().equals(obj.getEmpno()))
					        {
					            if("NR".equals(obj1.getType()))
				                {
				                    obj.setSingleroom("0");
				                    obj.setDoubleroom("0");
				                    obj.setRoomtype("NR");
				                }			
				                
				                if("SR".equals(obj1.getType()))
				                {
				                    obj.setSingleroom("0");
				                    obj.setDoubleroom("0");
				                    obj.setRoomtype("SR"+seq);
				                    empno1inskj = true;
				                }
					        }
					    }
			            

			            if("SR".equals(obj1.getType()))
		                {			            
					        //check empno2 if in crew list
				            for(int i=0; i<housingInfoForEFAL.size(); i++)//skj crew list
						    {
						        CrewHousingInfoObj obj = (CrewHousingInfoObj) housingInfoForEFAL.get(i);
						        if(obj1.getEmpno2().equals(obj.getEmpno()))
					            {
				                    if (empno1inskj == true)
				                    {
					                    obj.setSingleroom("0");
					                    obj.setDoubleroom("1");
					                    obj.setRoomtype("SR"+seq);
					                    empno2inskj = true;
					                    seq++;
				                    }                       
					            }
						    }
				            
				            if( empno1inskj == true && empno2inskj==false)
				            {//set empno1inskj to single room
				                for(int i=0; i<housingInfoForEFAL.size(); i++)//skj crew list
							    {
							        CrewHousingInfoObj obj = (CrewHousingInfoObj) housingInfoForEFAL.get(i);	
							        if(obj1.getEmpno1().equals(obj.getEmpno()))
							        {
					                    obj.setSingleroom("1");
					                    obj.setDoubleroom("0");
					                    obj.setRoomtype("");
							        }
							    }
				            }
		                }
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
    
    public ArrayList  getHousingInfoForEFAL()
	{
	    return housingInfoForEFAL;
	}
    
    public String  getSQL()
	{
	    return returnsql;
	}
}
