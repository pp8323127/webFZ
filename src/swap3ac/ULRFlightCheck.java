package swap3ac;

import java.util.*;
import java.sql.*;
import ci.db.*;
import ftdp.*;

/**
 * 【AirCrews正式版】 <br>
 * 012 超長程 AOR check 
 * @author cs71
 */
public class ULRFlightCheck//ultra Long Range Flight
{
        public static void main(String[] args) 
        {
//            CrewSwapSkj csk = new CrewSwapSkj("638546","640171","2015","01");
            CrewCrossCr csk = new CrewCrossCr("629246","630304","2015","01");
            CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
            CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料
            ArrayList aCrewSkjAL = null;//申請者的班表
            ArrayList rCrewSkjAL = null; //被換者的班表
            String[] aSwapSkjIdx = null;
            String[] rSwapSkjIdx = null;            
            aSwapSkjIdx = new String[] {"14"};
            rSwapSkjIdx = new String[] {"8","11"};
            try 
            {
	            csk.SelectData();
	            aCrewInfoObj =csk.getACrewInfoObj();
	            rCrewInfoObj =csk.getRCrewInfoObj();   
	 
	            aCrewSkjAL  = csk.getACrewSkjAL();
	            rCrewSkjAL = csk.getRCrewSkjAL(); 
            }catch(Exception e){
                System.out.println(e.toString());
                //out.println(e.toString());
            }

            ULRFlightCheck s = new ULRFlightCheck("2015","01","629246","630304",aCrewSkjAL,rCrewSkjAL,aSwapSkjIdx, rSwapSkjIdx);
            String return_str = s.setSwapSeries();
            if("Y".equals(return_str))
            {
                System.out.println(s.CheckULRFlight("2015","01")); 
            }
            else
            {
                System.out.println(return_str);
            }
           
//             System.out.println(s.getFlow());
//             System.out.println(s.getErrorMsg());
        }

        private String swapyear ="";//換班年份
        private String swapmm = "";//換班月份        
        private String aEmpno; //申請者員工號
        private String rEmpno; //被換者員工號號
        private String[] aSwapSkjIdx;// 申請者更換的任務 (index)
        private String[] rSwapSkjIdx;// 被換者更換的任務 (index)
        private ArrayList aFullSkjAL;//申請者全月換班前班次
        private ArrayList rFullSkjAL;//被換者全月換班前班次
        private ArrayList aSkjAL;//申請者換班前班次
        private ArrayList rSkjAL;//被換者換班前班次
        private ArrayList aSeriesAL;// 申請者 更換後的Series_num
        private ArrayList rSeriesAL;// 被換者 更換後的Series_num


    public ULRFlightCheck(String swapyear, String swapmm, String aEmpno,String rEmpno, ArrayList aSkjAL , ArrayList rSkjAL, String[] aSwapSkj, String[] rSwapSkj) 
    {
        this.swapyear = swapyear;
        this.swapmm = swapmm;
        this.aEmpno = aEmpno;
        this.rEmpno = rEmpno;
        this.aSwapSkjIdx = aSwapSkj;
        this.rSwapSkjIdx = rSwapSkj;
        this.aSkjAL = aSkjAL;
        this.rSkjAL = rSkjAL;        
        
        
        CrewCrossCr ccc = new CrewCrossCr(aEmpno, rEmpno, swapyear, swapmm);
        try 
        {
            ccc.SelectData();
            this.aFullSkjAL = ccc.getACrewSkjAL();
            this.rFullSkjAL = ccc.getRCrewSkjAL();
        } 
        catch (SQLException e) 
        {
            System.out.println("crossCr Exception :"+e.toString()); 
        }
        catch(Exception e)
        {
            System.out.println("crossCr Exception :"+e.toString());
            //out.println(e.toString());
        }        
    }
        
    
    public String setSwapSeries() 
    {
        if (aSkjAL == null && rSkjAL == null) 
        {
            return "無法取得班表,請稍後再試!";
        } 
        else 
        {
            try
            {
                if(aSwapSkjIdx != null)
                {
                    aSeriesAL = new ArrayList(); 
                    
                    for(int j = 0; j<aFullSkjAL.size(); j++)
                    {
                        CrewSkjObj obj = (CrewSkjObj) aFullSkjAL.get(j);
                        boolean ifadd = true;
                        
                        for (int i = 0; i < aSwapSkjIdx.length; i++) 
                        {
                            CrewSkjObj aobj = (CrewSkjObj) aSkjAL.get(Integer.parseInt(aSwapSkjIdx[i]));
                            if(obj.getTripno().equals(aobj.getTripno()))
                            {
                                //已換掉 ,do nothing
//                                System.out.println(obj.getTripno());
                                ifadd = false;
                            }                            
                        }   

                        if(ifadd==true)//未換掉
                        {                                
                            aSeriesAL.add(obj.getTripno());                                
                        }
                    }
                    //加入換進來的班
                    if(rSwapSkjIdx != null) 
                    {
                        for (int i = 0; i < rSwapSkjIdx.length; i++) 
                        {
                            CrewSkjObj robj = (CrewSkjObj) rSkjAL.get(Integer.parseInt(rSwapSkjIdx[i]));
//                            System.out.println(robj.getTripno());
                            aSeriesAL.add(robj.getTripno());     
                        }    
                    }
                }//if(aSwapSkjIdx != null) 
                
//                System.out.println("--");
                
                if(rSwapSkjIdx != null) 
                {
                    rSeriesAL = new ArrayList(); 
                    
                    for(int j = 0; j<rFullSkjAL.size(); j++)
                    {
                        CrewSkjObj obj = (CrewSkjObj) rFullSkjAL.get(j);
                        boolean ifadd = true;
                        
                        for (int i = 0; i < rSwapSkjIdx.length; i++) 
                        {
                            CrewSkjObj aobj = (CrewSkjObj) rSkjAL.get(Integer.parseInt(rSwapSkjIdx[i]));
                            if(obj.getTripno().equals(aobj.getTripno()))
                            {
                                //已換掉 ,do nothing
//                                System.out.println(obj.getTripno());
                                ifadd = false;
                            }                           
                        }   
                        
                        if(ifadd==true) //未換掉
                        {                                
                            rSeriesAL.add(obj.getTripno());                                
                        }
                    }
                    //加入換進來的班
                    if(aSwapSkjIdx != null) 
                    {
                        for (int i = 0; i < aSwapSkjIdx.length; i++) 
                        {
                            CrewSkjObj aobj = (CrewSkjObj) aSkjAL.get(Integer.parseInt(aSwapSkjIdx[i]));                            
                            rSeriesAL.add(aobj.getTripno());     
                        }    
                    }
                }//if(rSwapSkjIdx != null) 
            } 
            catch (Exception e) 
            {
                return e.toString();
            }
            
            return "Y";
        }
    }
    
    public String CheckULRFlight(String swapyear, String swapmm) 
    {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		String aSeries_str = "";
		String rSeries_str = "";
		String a_return_str = "Y";
		String r_return_str = "Y";
		ArrayList checkAL = new ArrayList();
		if(aSeriesAL.size()>0)
		{
		    for(int i=0; i<aSeriesAL.size(); i++)
		    {
		        if(!"0".equals(aSeriesAL.get(i)))
		        {
		            aSeries_str = aSeries_str+"'"+aSeriesAL.get(i)+"',";
		        }
		    }
		}
		
		if(rSeriesAL.size()>0)
        {
            for(int i=0; i<rSeriesAL.size(); i++)
            {
                if(!"0".equals(rSeriesAL.get(i)))
                {
                    rSeries_str = rSeries_str+"'"+rSeriesAL.get(i)+"',";
                }
            }
        }
		
//		System.out.println("aSeries_str "+aSeries_str);
//		System.out.println("rSeries_str "+rSeries_str);

		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();  
            
            //check 申請者換完班後有無還沒值勤的超長程班(012)
//			sql = " select dps.series_num, dps.tod_start_loc_ds rpt, dps.act_str_dt_tm_gmt sdate, dps.act_end_dt_tm_gmt edate, " +
//				  " r.staff_num staff_num, duty_seq_num, item_seq_num, " +
//				  " (CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd, " +
//				  " dps.act_port_a dpt,dps.act_port_b arv " +
//				  " from duty_prd_seg_v dps, roster_v r, crew_v c " +
//				  " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N' " +
//				  " and (c.staff_num = '"+aEmpno+"' OR c.staff_num = '"+rEmpno+"') " +
//				  " AND dps.str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " +
//				  " AND  dps.series_num IN ("+aSeries_str+"'') AND duty_seq_num='1' AND item_seq_num ='1' " +
//				  " AND (dps.flt_num = '0012' OR  dps.flt_num = '0012Z'  OR  dps.flt_num = '012Z') ORDER BY  dps.act_str_dt_tm_gmt ";
//            System.out.println(sql);
            sql = " select dps.series_num series_num, to_char(Min(dps.tod_start_loc_ds),'yyyy/mm/dd hh24:mi') rpt, to_char(Max(dps.act_end_dt_tm_gmt)+1/24,'yyyy/mm/dd hh24:mi') rls " +
            	  " from duty_prd_seg_v dps, roster_v r, crew_v c  " +
            	  " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N' " +
            	  " and (c.staff_num = '"+aEmpno+"' OR c.staff_num = '"+rEmpno+"') " +
            	  " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " + 
            	  " AND  dps.series_num IN ("+aSeries_str+"'') AND duty_seq_num <> '99' " +
            	  " AND (dps.flt_num = '0012' OR  dps.flt_num = '0012Z'  OR  dps.flt_num = '012Z' OR dps.flt_num = '0011' OR  dps.flt_num = '0011Z'  OR  dps.flt_num = '011Z') " +
            	  " AND  dps.act_end_dt_tm_gmt >= Trunc(SYSDATE+1) " +
            	  " GROUP BY dps.series_num order by  Min(dps.tod_start_loc_ds) ";
            
//			System.out.println(sql);
			checkAL.clear();
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) 
			{
			    ULRFlightObj aobj = new ULRFlightObj();
			    aobj.setSeries_num(rs.getString("series_num"));
			    aobj.setSdate(rs.getString("rpt"));
			    aobj.setEdate(rs.getString("rls"));
			    checkAL.add(aobj);	
			}
			rs.close();
			
//			System.out.println("a ##########");
//            System.out.println("a checkAL.size() "+checkAL.size());
            
			if(checkAL.size()>0)
			{
			    a_return_str = ULRFlightRuleCheck(aEmpno, checkAL, aSeries_str);
			}
			
			//check 被換者換完班後有無還沒值勤的超長程班(012)
//            sql = " select dps.series_num, dps.tod_start_loc_ds rpt, dps.act_str_dt_tm_gmt sdate, dps.act_end_dt_tm_gmt edate, " +
//                  " r.staff_num staff_num, duty_seq_num, item_seq_num, " +
//                  " (CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd, " +
//                  " dps.act_port_a dpt,dps.act_port_b arv " +
//                  " from duty_prd_seg_v dps, roster_v r, crew_v c " +
//                  " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N' " +
//                  " and (c.staff_num = '"+aEmpno+"' OR c.staff_num = '"+rEmpno+"') " +
//                  " AND dps.str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " +
//                  " AND  dps.series_num IN ("+rSeries_str+"'') AND duty_seq_num='1' AND item_seq_num ='1' " +
//                  " AND (dps.flt_num = '0012' OR  dps.flt_num = '0012Z'  OR  dps.flt_num = '012Z') ORDER BY  dps.act_str_dt_tm_gmt ";
//			System.out.println(sql);
			 sql = " select dps.series_num series_num, to_char(Min(dps.tod_start_loc_ds),'yyyy/mm/dd hh24:mi') rpt, to_char(Max(dps.act_end_dt_tm_gmt)+1/24,'yyyy/mm/dd hh24:mi') rls, " +
			 	   " to_char(Min(dps.tod_start_loc_ds),'yyyymmddhh24mi') rpt2, to_char(Max(dps.act_end_dt_tm_gmt)+1/24,'yyyymmddhh24mi') rls2 " +
	                  " from duty_prd_seg_v dps, roster_v r, crew_v c  " +
	                  " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N' " +
	                  " and (c.staff_num = '"+aEmpno+"' OR c.staff_num = '"+rEmpno+"') " +
	                  " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " + 
	                  " AND  dps.series_num IN ("+rSeries_str+"'') AND duty_seq_num <> '99' " +
	                  " AND (dps.flt_num = '0012' OR  dps.flt_num = '0012Z'  OR  dps.flt_num = '012Z' OR dps.flt_num = '0011' OR  dps.flt_num = '0011Z'  OR  dps.flt_num = '011Z') " +
	                  " AND  dps.act_end_dt_tm_gmt >= Trunc(SYSDATE+1) " +
	                  " GROUP BY dps.series_num order by  Min(dps.tod_start_loc_ds)";
	            
//	        System.out.println(sql);	        
            checkAL.clear();
            rs = stmt.executeQuery(sql);
            while (rs.next()) 
            {
                ULRFlightObj robj = new ULRFlightObj();
                robj.setSeries_num(rs.getString("series_num"));
                robj.setSdate(rs.getString("rpt"));
                robj.setEdate(rs.getString("rls"));
                robj.setRpt(rs.getString("rpt2"));
                robj.setRls(rs.getString("rls2"));
                checkAL.add(robj);  
            }
//            System.out.println("r ##########");
//            System.out.println("r checkAL.size() "+checkAL.size());
            if(checkAL.size()>0)
            {
                r_return_str = ULRFlightRuleCheck(rEmpno, checkAL, rSeries_str);
            }            
		} 
		catch (SQLException e) 
		{
			System.out.print(e.toString());
		} 
		catch (Exception e) 
		{
			System.out.print(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try 
				{
					rs.close();
				} 
				catch (SQLException e) 
				{}
			if (stmt != null)
				try 
				{
					stmt.close();
				} 
				catch (SQLException e) {}
			if (conn != null)
				try 
				{
					conn.close();
				} 
				catch (SQLException e) {}
		}
		
		if(!"Y".equals(a_return_str))
		{
		    return a_return_str;
		}
		else
		{
		    return r_return_str;
		}		
	}
    
    
    public String ULRFlightRuleCheck(String empno, ArrayList ulrfAL, String series_str)
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;      
        Driver dbDriver = null;        
        ArrayList ulrfcheckAL = new ArrayList();
        ArrayList ulrfcheckAL2 = new ArrayList();
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();  
            
            for(int i=0; i< ulrfAL.size(); i++)
            {
                ULRFlightObj obj = (ULRFlightObj) ulrfAL.get(i);
                ulrfcheckAL.clear();
                ulrfcheckAL2.clear();
//                System.out.println(empno);
//                System.out.println(obj.getSeries_num());
//                System.out.println(obj.getSdate());
//                System.out.println(obj.getEdate());
                
                sql = " select to_char(Trunc(To_Date('"+obj.getSdate()+"','yyyy/mm/dd hh24:mi'))-3,'yyyymmddhh24mi') f_border, to_char(Trunc(To_Date('"+obj.getEdate()+"','yyyy/mm/dd hh24:mi'))+4,'yyyymmddhh24mi') e_border, " +
                        " dps.series_num, to_char(dps.tod_start_loc_ds,'yyyymmddhh24mi') rpt, to_char(dps.act_str_dt_tm_gmt,'yyyymmddhh24mi') sdate, to_char(dps.act_end_dt_tm_gmt,'yyyymmddhh24mi') edate, " +
                        " CASE WHEN dps.duty_cd IN ('FLY','TVL') THEN to_char(dps.act_end_dt_tm_gmt+(1/24),'yyyymmddhh24mi') ELSE to_char(dps.act_end_dt_tm_gmt,'yyyymmddhh24mi') end rls, " +
                        " r.staff_num staff_num, duty_seq_num, item_seq_num,  dps.flt_num, dps.duty_cd, dps.act_port_a dpt,dps.act_port_b arv " +
                        " from duty_prd_seg_v dps, roster_v r, crew_v c " +
                        " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N'  " +
                        " and (c.staff_num = '"+aEmpno+"' OR c.staff_num = '"+rEmpno+"') " +
                        " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " +
                        " AND dps.series_num IN ("+series_str+"'') AND ( dps.act_str_dt_tm_gmt BETWEEN Trunc(To_Date('"+obj.getSdate()+"','yyyy/mm/dd hh24:mi'))-3 AND  Trunc(To_Date('"+obj.getEdate()+"','yyyy/mm/dd hh24:mi'))+4 " +
                        " OR dps.act_end_dt_tm_gmt BETWEEN Trunc(To_Date('"+obj.getSdate()+"','yyyy/mm/dd hh24:mi'))-3 AND  Trunc(To_Date('"+obj.getEdate()+"','yyyy/mm/dd hh24:mi'))+4 ) " +
                        " UNION " +
                        " select to_char(Trunc(To_Date('"+obj.getSdate()+"','yyyy/mm/dd hh24:mi'))-3,'yyyymmddhh24mi') f_border, to_char(Trunc(To_Date('"+obj.getEdate()+"','yyyy/mm/dd hh24:mi'))+4,'yyyymmddhh24mi') e_border, " +
                        " dps.series_num, to_char(dps.tod_start_loc_ds,'yyyymmddhh24mi') rpt, to_char(dps.act_str_dt_tm_gmt,'yyyymmddhh24mi') sdate, to_char(dps.act_end_dt_tm_gmt,'yyyymmddhh24mi') edate, " +
                        " CASE WHEN dps.duty_cd IN ('FLY','TVL') THEN to_char(dps.act_end_dt_tm_gmt+(1/24),'yyyymmddhh24mi') ELSE to_char(dps.act_end_dt_tm_gmt,'yyyymmddhh24mi') end rls, " +
                        " r.staff_num staff_num, duty_seq_num, item_seq_num,  dps.flt_num, dps.duty_cd, dps.act_port_a dpt,dps.act_port_b arv " +
                        " from duty_prd_seg_v dps, roster_v r, crew_v c " +
                        " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N' " +
                        " and c.staff_num = '"+empno+"' " +
                        " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " +
                        " AND ( dps.act_str_dt_tm_gmt BETWEEN Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd'))-3  AND  To_Date('"+swapyear+swapmm+"01','yyyymmdd')  OR " +
                        " dps.act_end_dt_tm_gmt BETWEEN Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd'))-3 AND  To_Date('"+swapyear+swapmm+"01','yyyymmdd')) " +
                        " AND Trunc(To_Date('"+obj.getSdate()+"','yyyy/mm/dd hh24:mi')) <= To_Date('"+swapyear+swapmm+"03 23:59','yyyymmdd hh24:mi') " +
                        " UNION " +
                        " select to_char(Trunc(To_Date('"+obj.getSdate()+"','yyyy/mm/dd hh24:mi'))-3,'yyyymmddhh24mi') f_border, to_char(Trunc(To_Date('"+obj.getEdate()+"','yyyy/mm/dd hh24:mi'))+4,'yyyymmddhh24mi') e_border, " +
                        " dps.series_num, to_char(dps.tod_start_loc_ds,'yyyymmddhh24mi') rpt, to_char(dps.act_str_dt_tm_gmt,'yyyymmddhh24mi') sdate, to_char(dps.act_end_dt_tm_gmt,'yyyymmddhh24mi') edate, " +
                        " CASE WHEN dps.duty_cd IN ('FLY','TVL') THEN to_char(dps.act_end_dt_tm_gmt+(1/24),'yyyymmddhh24mi') ELSE to_char(dps.act_end_dt_tm_gmt,'yyyymmddhh24mi') end rls, " +
                        " r.staff_num staff_num, duty_seq_num, item_seq_num,  dps.flt_num, dps.duty_cd, dps.act_port_a dpt,dps.act_port_b arv " +
                        " from duty_prd_seg_v dps, roster_v r, crew_v c " +
                        " where dps.series_num=r.series_num and r.staff_num=c.staff_num AND  r.delete_ind='N' AND  dps.delete_ind='N' " +
                        " and c.staff_num = '"+empno+"' " +
                        " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+swapyear+swapmm+"01 00:00','yyyymmdd hh24:mi')-10 AND Last_Day(To_Date('"+swapyear+swapmm+"01 23:59','yyyymmdd hh24:mi'))+10 " +
                        " AND ( dps.act_str_dt_tm_gmt BETWEEN Last_Day(Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd')))+1  AND  Last_Day(Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd')))+4 " +
                        " OR dps.act_end_dt_tm_gmt BETWEEN Last_Day(Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd')))+1  AND  Last_Day(Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd')))+4 ) " +
                        " AND Trunc(To_Date('"+obj.getEdate()+"','yyyy/mm/dd hh24:mi'))+4 >= Last_Day(Trunc(To_Date('"+swapyear+swapmm+"01','yyyymmdd')))+1 ORDER BY  sdate ";
                  
//                  System.out.println(sql);
                ULRFlightCheckObj dumyobj = new ULRFlightCheckObj();
                ulrfcheckAL.add(dumyobj);
                
                rs = stmt.executeQuery(sql);
                while (rs.next()) 
                {//start to check
                    ULRFlightCheckObj sobj = new ULRFlightCheckObj();
                    sobj.setUlrf_rpt(obj.getRpt());
                    sobj.setUlrf_rls(obj.getRls());
                    sobj.setUlrf_series(obj.getSeries_num());
                    sobj.setF_border(rs.getString("f_border"));
                    sobj.setE_border(rs.getString("e_border"));
                    sobj.setSeries_num(rs.getString("series_num"));
                    sobj.setRpt(rs.getString("rpt"));
                    sobj.setSdate(rs.getString("sdate"));
                    sobj.setEdate(rs.getString("edate"));
                    sobj.setRls(rs.getString("rls"));
                    sobj.setDuty_seq_num(rs.getString("duty_seq_num"));
                    sobj.setItem_seq_num(rs.getString("item_seq_num"));
                    sobj.setFlt_num(rs.getString("flt_num"));
                    sobj.setDuty_cd(rs.getString("duty_cd"));
                    sobj.setDpt(rs.getString("dpt"));
                    sobj.setArv(rs.getString("arv"));
                    ulrfcheckAL.add(sobj);
                }
                ulrfcheckAL.add(dumyobj);
                
                if(ulrfcheckAL.size()>2)
                {
                    for(int j=1; j<ulrfcheckAL.size()-1; j++)
                    {
                        ULRFlightCheckObj aobj = (ULRFlightCheckObj) ulrfcheckAL.get(j-1);
                        ULRFlightCheckObj sobj = (ULRFlightCheckObj) ulrfcheckAL.get(j);
                        ULRFlightCheckObj bobj = (ULRFlightCheckObj) ulrfcheckAL.get(j+1);
                        //set RST range
                        //地面任務LO算RST
                        if("0".equals(sobj.getFlt_num()))
                        {
                            ULRFlightCheckObj newobj = new ULRFlightCheckObj();
                            newobj.setUlrf_rpt(sobj.getUlrf_rpt());
                            newobj.setUlrf_rls(sobj.getUlrf_rls());
                            newobj.setUlrf_series(sobj.getSeries_num());
                            newobj.setF_border(sobj.getF_border());
                            newobj.setE_border(sobj.getE_border());
                            newobj.setSeries_num(sobj.getSeries_num());
                            //若有前一筆LO
                            if(aobj.getSdate()!=null && !"".equals(aobj.getSdate()))
                            {
                                newobj.setRst_s(aobj.getSdate());                                
                            }
                            else
                            {//無前一筆記錄,set f_border
                                newobj.setRst_s(sobj.getF_border());   
                            }
                            newobj.setRst_e(sobj.getSdate());
                            ulrfcheckAL2.add(newobj);
                        }
                        
                        if("99".equals(sobj.getDuty_seq_num()))
                        {
                            ULRFlightCheckObj newobj = new ULRFlightCheckObj();
                            newobj.setUlrf_rpt(sobj.getUlrf_rpt());
                            newobj.setUlrf_rls(sobj.getUlrf_rls());
                            newobj.setUlrf_series(sobj.getSeries_num());
                            newobj.setF_border(sobj.getF_border());
                            newobj.setE_border(sobj.getE_border());
                            newobj.setSeries_num(sobj.getSeries_num());                               
                            newobj.setRst_s(sobj.getSdate());     
                            //若有下一筆 Duty_seq_num =1
                            if(bobj.getRpt()!=null && !"".equals(bobj.getRpt()))
                            {
                                newobj.setRst_e(bobj.getRpt());                                
                            }
                            else
                            {//無後一筆記錄,set e_border
                                newobj.setRst_e(sobj.getE_border());   
                            }                            
                            ulrfcheckAL2.add(newobj);
                        }
                    } //for(int j=1; j<ulrfcheckAL.size()-1; j++)  
                   
                    if(ulrfcheckAL2.size()>0)
                    {//有休時記錄
                        //Check 012 前一日是否休一曆日
                        boolean ifpre_one_day_off_passcheck = false;
                        //Check 012 前三日22:00~08:00 是否皆休足8小時
                        boolean ifpre_2nd_day_has8hroff_passcheck = false;
                        boolean ifpre_3rd_day_has8hroff_passcheck = false;
                        //Check 011 後三晚22:00~08:00 是否皆休足8小時
                        boolean ifpos_1st_day_has8hroff_passcheck = false;
                        boolean ifpos_2nd_day_has8hroff_passcheck = false;
                        boolean ifpos_3rd_day_has8hroff_passcheck = false;
                        //Check 011 後至下個任務報到是否休足48小時
                        boolean ifpos_nextduty_has48hroff_passcheck = false;
                        
                        for(int r=0; r<ulrfcheckAL2.size(); r++)
                        {
                            ULRFlightCheckObj newobj = (ULRFlightCheckObj) ulrfcheckAL2.get(r);
                            
                            String pre_one_day_s = calcDatetime(newobj.getUlrf_rpt().substring(0,8),-1)+"0000";
                            String pre_one_day_e = newobj.getUlrf_rpt().substring(0,8)+"0000";
                            String pre_2nd_day_s = calcDatetime(newobj.getUlrf_rpt().substring(0,8),-2)+"2200";
                            String pre_2nd_day_e = calcDatetime(newobj.getUlrf_rpt().substring(0,8),-1)+"0800";
                            String pre_3rd_day_s = calcDatetime(newobj.getUlrf_rpt().substring(0,8),-3)+"2200";
                            String pre_3rd_day_e = calcDatetime(newobj.getUlrf_rpt().substring(0,8),-2)+"0800";
                            
                            String pos_1st_day_s = newobj.getUlrf_rls().substring(0,8)+"2200";
                            String pos_1st_day_e = calcDatetime(newobj.getUlrf_rls().substring(0,8),+1)+"0800";
                            String pos_2nd_day_s = calcDatetime(newobj.getUlrf_rls().substring(0,8),+1)+"2200";
                            String pos_2nd_day_e = calcDatetime(newobj.getUlrf_rls().substring(0,8),+2)+"0800";
                            String pos_3rd_day_s = calcDatetime(newobj.getUlrf_rls().substring(0,8),+2)+"2200";
                            String pos_3rd_day_e = calcDatetime(newobj.getUlrf_rls().substring(0,8),+3)+"0800";
                            
                            String pre_off_s = "";
                            String pre_off_e = "";
                            //compareTo 相同-> 0 , 大.compareTo小 -> 正數, 小.compareTo大 -> 負數
//                            System.out.println("201501120102".compareTo("201501120102"));
//                            System.out.println("201501120103".compareTo("201501120102"));
//                            System.out.println("201501120101".compareTo("201501120102"));
                          
                          if(newobj.getRst_s().compareTo(pre_one_day_s) <=0)
                          {
                              pre_off_s = pre_one_day_s;
                          }
                          else
                          {
                              pre_off_s = newobj.getRst_s();
                          }
//                          System.out.println("****");
                          if(pre_one_day_e.compareTo(newobj.getRst_e()) <=0) 
                          {
                              pre_off_e = pre_one_day_e;
                          }
                          else
                          {
                              pre_off_e = newobj.getRst_e();
                          }
                          
                          String pre_one_day_rst_mins = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e);                            
//                          System.out.println(pre_off_s+" * "+pre_off_e+" - "+pre_one_day_rst_mins);
                          if(Integer.parseInt(pre_one_day_rst_mins)>=1440)
                          {
                              //前一天休足一曆日
                              ifpre_one_day_off_passcheck = true;
                          }
                          
                           //****************************************
                          //Check 前第二天22:00~前第一天08:00 是否休足8小時
                           pre_off_s = "";
                           pre_off_e = "";
                            
                            if(newobj.getRst_s().compareTo(pre_2nd_day_s) <=0)
                            {
                                pre_off_s = pre_2nd_day_s;
                            }
                            else
                            {
                                pre_off_s = newobj.getRst_s();
                            }
//                            System.out.println("****");
                            if(pre_2nd_day_e.compareTo(newobj.getRst_e()) <=0) 
                            {
                                pre_off_e = pre_2nd_day_e;
                            }
                            else
                            {
                                pre_off_e = newobj.getRst_e();
                            }
                            
                            String rst_min = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e);  
//                            System.out.println(pre_off_s+" - "+pre_off_e+ "rst_min "+rst_min);
//                            System.out.println(pre_off_s+" * "+pre_off_e+" - "+rst_min);
//                            System.out.println(pre_2nd_day_s+" * "+pre_2nd_day_e+" - "+ftdp.TimeUtil.differenceOfTwoDate(pre_2nd_day_s, pre_2nd_day_e));
                            if(Integer.parseInt(rst_min)>=480)
                            {
                                //前第二天休足8小時
                                ifpre_2nd_day_has8hroff_passcheck = true;
                            }
                            
                            //****************************************
                            pre_off_s = "";
                            pre_off_e = "";
                            
                            if(newobj.getRst_s().compareTo(pre_3rd_day_s) <=0)
                            {
                                pre_off_s = pre_3rd_day_s;
                            }
                            else
                            {
                                pre_off_s = newobj.getRst_s();
                            }
//                            System.out.println("****");
                            if(pre_3rd_day_e.compareTo(newobj.getRst_e()) <=0) 
                            {
                                pre_off_e = pre_3rd_day_e;
                            }
                            else
                            {
                                pre_off_e = newobj.getRst_e();
                            }
                            
                            String rst_min2 = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e); 
//                            System.out.println("rst_min2 "+rst_min2);
//                            System.out.println(pre_off_s+" - "+pre_off_e+ " rst_min2 "+rst_min2);
                            if(Integer.parseInt(rst_min2)>=480)
                            {
                                //前第二天休足8小時
                                ifpre_3rd_day_has8hroff_passcheck = true;
                            }
                            
                            //Check 011後第一晚是否休足8小時
                            //****************************************
                            pre_off_s = "";
                            pre_off_e = "";
                            
                            if(newobj.getRst_s().compareTo(pos_1st_day_s) <=0)
                            {
                                pre_off_s = pos_1st_day_s;
                            }
                            else
                            {
                                pre_off_s = newobj.getRst_s();
                            }
//                            System.out.println("****");
                            if(pos_1st_day_e.compareTo(newobj.getRst_e()) <=0) 
                            {
                                pre_off_e = pos_1st_day_e;
                            }
                            else
                            {
                                pre_off_e = newobj.getRst_e();
                            }
                            
                            String rst_min3 = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e); 
//                            System.out.println("rst_min2 "+rst_min2);
//                            System.out.println(pre_off_s+" - "+pre_off_e+ " rst_min3 "+rst_min3);
                            if(Integer.parseInt(rst_min3)>=480)
                            {
                                //後第一天休足8小時
                                ifpos_1st_day_has8hroff_passcheck = true;
                            }
                            
                            //Check 011後第二晚是否休足8小時
                            //****************************************    
                            pre_off_s = "";
                            pre_off_e = "";
                            
                            if(newobj.getRst_s().compareTo(pos_2nd_day_s) <=0)
                            {
                                pre_off_s = pos_2nd_day_s;
                            }
                            else
                            {
                                pre_off_s = newobj.getRst_s();
                            }
//                            System.out.println("****");
                            if(pos_2nd_day_e.compareTo(newobj.getRst_e()) <=0) 
                            {
                                pre_off_e = pos_2nd_day_e;
                            }
                            else
                            {
                                pre_off_e = newobj.getRst_e();
                            }
                            
                            String rst_min4 = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e); 
//                            System.out.println("rst_min2 "+rst_min2);
//                            System.out.println(pre_off_s+" - "+pre_off_e+ " rst_min4 "+rst_min4);
                            if(Integer.parseInt(rst_min4)>=480)
                            {
                                //後第二天休足8小時
                                ifpos_2nd_day_has8hroff_passcheck = true;
                            }
                            
                            //Check 011後第三晚是否休足8小時
                            //****************************************    
                            pre_off_s = "";
                            pre_off_e = "";
                            
                            if(newobj.getRst_s().compareTo(pos_3rd_day_s) <=0)
                            {
                                pre_off_s = pos_3rd_day_s;
                            }
                            else
                            {
                                pre_off_s = newobj.getRst_s();
                            }
//                            System.out.println("****");
                            if(pos_3rd_day_e.compareTo(newobj.getRst_e()) <=0) 
                            {
                                pre_off_e = pos_3rd_day_e;
                            }
                            else
                            {
                                pre_off_e = newobj.getRst_e();
                            }
                            
                            String rst_min5 = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e); 
//                            System.out.println("rst_min2 "+rst_min2);
//                            System.out.println(pre_off_s+" - "+pre_off_e+ " rst_min5 "+rst_min5);
                            if(Integer.parseInt(rst_min5)>=480)
                            {
                                //後第三天休足8小時
                                ifpos_3rd_day_has8hroff_passcheck = true;
                            }
                            
                            //Check 011 後至下個任務報到是否休足48小時
                           //****************************************  
                            pre_off_s = "";
                            pre_off_e = "";
//                            System.out.println("012 series " + obj.getSeries_num());
//                            System.out.println("check series " + newobj.getSeries_num());
                            if(newobj.getSeries_num().equals(obj.getSeries_num()))
                            {
                                //012.series_num                                
                                pre_off_s = newobj.getRst_s();
                                pre_off_e = newobj.getRst_e();   
//                                System.out.println(pre_off_s + " ** " + pre_off_e);
                                String rst_min6 = ftdp.TimeUtil.differenceOfTwoDate(pre_off_s, pre_off_e); 
//                              System.out.println("rst_min2 "+rst_min2);
//                                System.out.println(pre_off_s+" - "+pre_off_e+ " rst_min6 "+rst_min6);
                                if(Integer.parseInt(rst_min6)>=2880)
                                {
                                    //至下個任務報到是否休足48小時     
                                    ifpos_nextduty_has48hroff_passcheck = true;
                                }
                            }                            
                        }//for(int r=0; r<ulrfcheckAL2.size(); r++)    
                        
                        if(ifpre_one_day_off_passcheck==false | ifpre_2nd_day_has8hroff_passcheck==false | ifpre_3rd_day_has8hroff_passcheck==false)
                        {
                            return "012 任務前休時 不得少於1個日曆天及3個整晚。";
                        }     
                        
                        if(ifpos_1st_day_has8hroff_passcheck==false | ifpos_2nd_day_has8hroff_passcheck == false || ifpos_3rd_day_has8hroff_passcheck == false || ifpos_nextduty_has48hroff_passcheck == false)
                        {
                            return "012 任務後休時不得少於包含3個整晚之連續48小時。";
                        } 
                        
                    }//if(ulrfcheckAL2.size()>0)
                }//if(ulrfcheckAL.size()>2)
            }//for(int i=0; i< ulrfAL.size(); i++)        
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
        } 
        finally 
        {
            if (rs != null)
                try 
                {
                    rs.close();
                } 
                catch (SQLException e) 
                {}
            if (stmt != null)
                try 
                {
                    stmt.close();
                } 
                catch (SQLException e) {}
            if (conn != null)
                try 
                {
                    conn.close();
                } 
                catch (SQLException e) {}
        }
        return "Y";
    }
    
    public class ULRFlightObj 
    {
        private String series_num ="";
        private String sdate = ""; //yyyy/mm/dd hh24:mi
        private String edate = ""; //yyyy/mm/dd hh24:mi
        private String rpt = ""; //yyyymmddhh24mi
        private String rls = ""; //yyyymmddhh24mi
        
        public String getRpt()
        {
            return rpt;
        }
        public String getRls()
        {
            return rls;
        }
        public void setRpt(String rpt)
        {
            this.rpt = rpt;
        }
        public void setRls(String rls)
        {
            this.rls = rls;
        }
        public String getSeries_num()
        {
            return series_num;
        }
        public String getSdate()
        {
            return sdate;
        }
        public String getEdate()
        {
            return edate;
        }
        public void setSeries_num(String series_num)
        {
            this.series_num = series_num;
        }
        public void setSdate(String sdate)
        {
            this.sdate = sdate;
        }
        public void setEdate(String edate)
        {
            this.edate = edate;
        }        
    }
    
    public String calcDatetime(String yyyymmdd, int daydiff)
    {
//        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyyMMdd");          
//        GregorianCalendar date1 = new GregorianCalendar(); 
//        date1.set(Integer.parseInt(yyyymmdd.substring(0,4)), Integer.parseInt(yyyymmdd.substring(5,6))-1, Integer.parseInt(yyyymmdd.substring(7,8)));
//        date1.add(Calendar.DATE,daydiff);
//       return format.format(date1.getInstance().getTime());
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;   
        String d = "";
        try 
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();  
            
            sql = " select to_char(to_date('"+yyyymmdd+"','yyyymmdd') +("+daydiff+"),'yyyymmdd') d from dual";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                d=rs.getString("d");
            }
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
        } 
        finally 
        {
            if (rs != null)
                try 
                {
                    rs.close();
                } 
                catch (SQLException e) 
                {}
            if (stmt != null)
                try 
                {
                    stmt.close();
                } 
                catch (SQLException e) {}
            if (conn != null)
                try 
                {
                    conn.close();
                } 
                catch (SQLException e) {}
        }
        return d;
    }
    
    public class ULRFlightCheckObj
    {
        private String ulrf_rpt = "";
        private String ulrf_rls = "";
        private String ulrf_series = "";
        private String f_border ="";
        private String e_border ="";
        private String series_num ="";
        private String rpt = "";
        private String sdate ="";
        private String edate ="";
        private String rls ="";
        private String duty_seq_num ="";
        private String item_seq_num ="";
        private String flt_num ="";
        private String duty_cd ="";
        private String dpt = "";
        private String arv = "";
        private String rst_s = "";
        private String rst_e = "";   
        
        
        public String getUlrf_series()
        {
            return ulrf_series;
        }

        public void setUlrf_series(String ulrf_series)
        {
            this.ulrf_series = ulrf_series;
        }

        public String getUlrf_rls()
        {
            return ulrf_rls;
        }

        public void setUlrf_rls(String ulrf_rls)
        {
            this.ulrf_rls = ulrf_rls;
        }

        public String getUlrf_rpt()
        {
            return ulrf_rpt;
        }
        
        public void setUlrf_rpt(String ulrf_rpt)
        {
            this.ulrf_rpt = ulrf_rpt;
        }
        
        public String getRst_s()
        {
            return rst_s;
        }
        public String getRst_e()
        {
            return rst_e;
        }
        public void setRst_s(String rst_s)
        {
            this.rst_s = rst_s;
        }
        public void setRst_e(String rst_e)
        {
            this.rst_e = rst_e;
        }
        public String getF_border()
        {
            return f_border;
        }
        public String getE_border()
        {
            return e_border;
        }
        public String getSeries_num()
        {
            return series_num;
        }
        public String getRpt()
        {
            return rpt;
        }
        public String getSdate()
        {
            return sdate;
        }
        public String getEdate()
        {
            return edate;
        }
        public String getRls()
        {
            return rls;
        }
        public String getDuty_seq_num()
        {
            return duty_seq_num;
        }
        public String getItem_seq_num()
        {
            return item_seq_num;
        }
        public String getFlt_num()
        {
            return flt_num;
        }
        public String getDuty_cd()
        {
            return duty_cd;
        }
        public String getDpt()
        {
            return dpt;
        }
        public String getArv()
        {
            return arv;
        }
        public void setF_border(String f_border)
        {
            this.f_border = f_border;
        }
        public void setE_border(String e_border)
        {
            this.e_border = e_border;
        }
        public void setSeries_num(String series_num)
        {
            this.series_num = series_num;
        }
        public void setRpt(String rpt)
        {
            this.rpt = rpt;
        }
        public void setSdate(String sdate)
        {
            this.sdate = sdate;
        }
        public void setEdate(String edate)
        {
            this.edate = edate;
        }
        public void setRls(String rls)
        {
            this.rls = rls;
        }
        public void setDuty_seq_num(String duty_seq_num)
        {
            this.duty_seq_num = duty_seq_num;
        }
        public void setItem_seq_num(String item_seq_num)
        {
            this.item_seq_num = item_seq_num;
        }
        public void setFlt_num(String flt_num)
        {
            this.flt_num = flt_num;
        }
        public void setDuty_cd(String duty_cd)
        {
            this.duty_cd = duty_cd;
        }
        public void setDpt(String dpt)
        {
            this.dpt = dpt;
        }
        public void setArv(String arv)
        {
            this.arv = arv;
        }        
    }
}