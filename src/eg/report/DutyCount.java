package eg.report;

import java.sql.*;
import java.util.*;

import ci.db.*;
import eg.*;
/*
 * 累計12個月之組員任務統計
 * 累計每三個月之ADO(包含全天休假)統計
 * 
 */
public class DutyCount
{       
    private String sql = null;
    private ArrayList objAL = new ArrayList();
    private String errorstr = "";

    public static void main(String[] args)
    {          
         DutyCount dc = new DutyCount();
//         dc.getOriSkj("201401", "201412", "635849");
//         dc.getActSkj("201401", "201412", "635849");
//         dc.getOriOffDays("201401", "201412", "635863");
         dc.getActOffDays("201401", "201412", "635863");
//         dc.getActOffDays("201401", "201403", "635849");
//         dc.getOriADODays("201401","201412","635863"); 
         
         System.out.println(dc.getObjAL().size());
        System.out.println("Done");
    }


    public void getOriSkj(String syyyymm, String eyyyymm, String empno) 
    {                
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;  
        Driver dbDriver = null;
        objAL.clear();
        
        try
        {           
        	ConnDB cn = new ConnDB();   
        	cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

            sql = " SELECT staff_num, sern, cname, base, grp, duty_cd, dpt, arv, Count(*) c FROM ( " +
            	  " select dps.act_str_dt_tm_gmt fdate, r.staff_num staff_num, cb.sern sern, cb.cname cname, cb.groups grp, cb.station base, " +
            	  " To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateDptLoc, To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateArvLoc , " +
            	  " (CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE REPLACE(dps.flt_num,'Z','') end ) duty_cd, dps.act_port_a dpt,dps.act_port_b arv, " +
            	  " dps.fleet_cd actp from fzdb.fztskj1 dps, fzdb.fztskj2 r, egtcbas cb " +
            	  " where dps.series_num=r.series_num and dps.yyyymm_version = r.yyyymm_version and dps.yyyymm_version like '%_00' " +
            	  " AND dps.duty_cd IN ('TVL','FLY')  AND dps.yyyymm_version = r.yyyymm_version " +
            	  " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+syyyymm+"01 00:00','yyyymmdd hh24:mi') " +
            	  " AND Last_Day(To_Date('"+eyyyymm+"01 23:59','yyyymmdd hh24:mi')) AND duty_seq_num =1 AND dps.act_port_a IN ('KHH','TSA','TPE') " +
            	  " AND r.staff_num ='"+empno+"' and r.staff_num = trim(cb.empn) ) " +
            	  " GROUP BY   staff_num, duty_cd, dpt, arv, sern, cname, base, grp ORDER BY staff_num, arv ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql); 
            while (rs.next())
            {
                DutyCountObj obj = new DutyCountObj();
                obj.setStaff_num(rs.getString("staff_num"));
                obj.setSern(rs.getString("sern"));
                obj.setCname(rs.getString("cname"));
                obj.setBase(rs.getString("base"));
                obj.setGrp(rs.getString("grp"));
                obj.setDuty_cd(rs.getString("duty_cd"));
                obj.setDpt(rs.getString("dpt"));
                obj.setArv(rs.getString("arv"));
                obj.setCnt(rs.getString("c"));                
                objAL.add(obj);
            }      
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public void getActSkj(String syyyymm, String eyyyymm, String empno) 
    {                
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        objAL.clear();
        
        try
        {           
        	ConnDB cn = new ConnDB();   
        	cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

            sql = " SELECT staff_num, sern, cname, base, grp, duty_cd, dpt, arv, Count(*) c FROM ( " +
            	  " select dps.act_str_dt_tm_gmt fdate, r.staff_num staff_num, cb.sern sern, " +
            	  " cb.cname cname, cb.groups grp, cb.station base, " +
            	  " To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateDptLoc, " +
            	  " To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateArvLoc , " +
            	  " (CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE REPLACE(dps.flt_num,'Z','') end ) duty_cd, " +
            	  " dps.act_port_a dpt,dps.act_port_b arv, dps.fleet_cd actp " +
            	  " from duty_prd_seg_v dps, roster_v r, egtcbas cb " +
            	  " where dps.series_num=r.series_num AND r.delete_ind='N' AND dps.delete_ind='N' " +
            	  " AND dps.duty_cd IN ('TVL','FLY') " +
            	  " AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+syyyymm+"01 00:00','yyyymmdd hh24:mi') " +
                  " AND Last_Day(To_Date('"+eyyyymm+"01 23:59','yyyymmdd hh24:mi')) " +
                  " AND r.act_str_dt BETWEEN  to_date('"+syyyymm+"01 00:00','yyyymmdd hh24:mi') -10 " +
                  " AND Last_Day(To_Date('"+eyyyymm+"01 23:59','yyyymmdd hh24:mi')) + 10 " +
                  " AND duty_seq_num =1 AND dps.act_port_a IN ('KHH','TSA','TPE') AND dps.fd_ind='N' " +
                  " AND r.staff_num ='"+empno+"' and r.staff_num = trim(cb.empn)) " +
                  " GROUP BY staff_num, duty_cd, dpt, arv ,sern, cname, base, grp ORDER BY staff_num, arv ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                DutyCountObj obj = new DutyCountObj();
                obj.setStaff_num(rs.getString("staff_num"));
                obj.setSern(rs.getString("sern"));
                obj.setCname(rs.getString("cname"));
                obj.setBase(rs.getString("base"));
                obj.setGrp(rs.getString("grp"));
                obj.setDuty_cd(rs.getString("duty_cd"));
                obj.setDpt(rs.getString("dpt"));
                obj.setArv(rs.getString("arv"));
                obj.setCnt(rs.getString("c"));                
                objAL.add(obj);
            }      
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public void getOriOffDays(String syyyymm, String eyyyymm, String empno) 
    {                
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;  
        objAL.clear();
        Driver dbDriver = null;
        String yyyymm ="";
        yyyymm = syyyymm;
        String end_loop = "";
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyyMM");  
        GregorianCalendar date = new GregorianCalendar(); 
        date.set(Integer.parseInt(eyyyymm.substring(0,4)),Integer.parseInt(eyyyymm.substring(4,6))-1,1);
        date.add(Calendar.MONTH,1);  
        end_loop = format.format(date.getTime());
        int idx = 0;
        
//        System.out.println("end_loop "+end_loop);
        
        
        
        try
        {           
        	ConnDB cn = new ConnDB();   
        	cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

            while (!yyyymm.equals(end_loop))
            { 
//                System.out.println("yyyymm "+yyyymm);
                
//                sql = " SELECT cb.empn empn, cb.sern sern,cb.cname cname, cb.jobno jobno, cb.GROUPS grp, cb.station station, " +
//                        " ca.duty_day duty_day, ca.off_day off_day FROM ( " +
//                        " SELECT staff_num, Count(*) duty_day, To_Number(To_Char(Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')),'dd')) - Count(*) off_day FROM " +
//                        " ( SELECT t1.mdate duty_date, t2.staff_num staff_num " +
//                        " FROM ( SELECT To_Date('"+yyyymm+"01','yyyymmdd')+jday-1 mdate, empno FROM egtdate, " +
//                        " (SELECT Trim(empn) empno FROM egtcbas where empn = '"+empno+"' ) cb " +
//                        " WHERE jday <= To_Char(Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')),'dd') ) t1 , ( " +
//                        " SELECT r.staff_num staff_num, r.duty_cd duty_cd, dps.series_num series_num,  Min(dps.tod_start_loc_ds) min_tod_start_loc_ds, " +
//                        " Max(dps.act_end_dt_tm_gmt) max_act_end_dt_tm_gmt, Min(CASE WHEN dps.tod_start_loc_ds < To_Date('"+yyyymm+"01','yyyymmdd') " +
//                        " THEN To_Date('"+yyyymm+"01','yyyymmdd')    ELSE Trunc(dps.tod_start_loc_ds,'dd') end ) tod_start_loc_ds, " +
//                        " CASE WHEN r.duty_cd in ('FLY','TVL') THEN Max(CASE WHEN dps.act_end_dt_tm_gmt+1/24 > Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
//                        " THEN Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')) ELSE Trunc(dps.act_end_dt_tm_gmt+1/24,'dd') END) " +
//                        " ELSE Max(CASE WHEN dps.act_end_dt_tm_gmt > Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
//                        " THEN Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')) ELSE Trunc(dps.act_end_dt_tm_gmt,'dd') end) end act_end_dt_tm_gmt " +
//                        " FROM fzdb.fztskj1 dps, fzdb.fztskj2 r WHERE dps.series_num = r.series_num and dps.yyyymm_version = r.yyyymm_version and dps.yyyymm_version = '"+yyyymm+"_00' " +
//                        " AND dps.act_str_dt_tm_gmt between To_Date('"+yyyymm+"01','yyyymmdd') -15  AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) +15 " +
//                        " AND (dps.tod_start_loc_ds between To_Date('"+yyyymm+"01','yyyymmdd')  AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
//                        " OR dps.act_str_dt_tm_gmt between To_Date('"+yyyymm+"01','yyyymmdd')  AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) ) " +
//                        " AND dps.duty_seq_num <> '99'  AND str_dt between To_Date('"+yyyymm+"01','yyyymmdd') -15 " +
//                        " AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) +15  AND r.str_dt between To_Date('"+yyyymm+"01','yyyymmdd')-15 " +
//                        " AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi'))+15  AND  r.duty_cd IN ('FLY','SBY','GRD','TVL') " +
//                        " AND r.staff_num ='"+empno+"' GROUP BY  r.staff_num, r.duty_cd, dps.series_num " +
//                        " UNION " +
//                        " SELECT  DISTINCT r.staff_num, r.duty_cd, r.series_num series_num,  r.str_dt min_tod_start_loc_ds, " +
//                        " end_dt max_act_end_dt_tm_gmt, str_dt tod_start_loc_ds, end_dt act_end_dt_tm_gmt " +
//                        " FROM fzdb.fztskj2 r  where series_num =0 AND duty_cd NOT IN ('RDO','ADO','BOFF') AND yyyymm_version = '"+yyyymm+"_00'" +
//                        " and r.str_dt between to_date('"+yyyymm+"01 0000','yyyy/mm/dd hh24mi') and Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
//                        " AND r.staff_num ='"+empno+"') t2 " +
//                        " WHERE  t1.mdate BETWEEN  t2.tod_start_loc_ds and t2.act_end_dt_tm_gmt  AND t1.empno = t2.staff_num  GROUP BY staff_num , t1.mdate )  " +
//                        " GROUP BY staff_num ) ca,  (SELECT Trim(empn) empn, sern ,cname , jobno, GROUPS, station " +
//                        " FROM egdb.egtcbas WHERE empn='"+empno+"') cb WHERE ca.staff_num = cb.empn   ORDER BY ca.staff_num "; 
                
                sql = " SELECT cb.empn empn, cb.sern sern,cb.cname cname, cb.jobno jobno, cb.GROUPS grp, cb.station station, " +
                      " nvl(ca.duty_day, '') duty_day, nvl(ca.off_days, '') off_day FROM ( " +
                      " SELECT r.staff_num, yyyymm_version, off_days, fly_days+grd_days duty_day FROM fzdb.fztskj3 r " +
                      " where yyyymm_version = '"+yyyymm+"_00' AND r.staff_num ='"+empno+"') ca,  " +
                      " (SELECT Trim(empn) empn, sern ,cname , jobno, GROUPS, station " +
                      " FROM egdb.egtcbas WHERE empn='"+empno+"') cb " +
                      " WHERE ca.staff_num = cb.empn   ORDER BY ca.staff_num "; 
              
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);
                if (rs.next())
                {
                    DutyCountObj obj = new DutyCountObj();
                    obj.setStaff_num(rs.getString("empn"));
                    obj.setSern(rs.getString("sern"));
                    obj.setCname(rs.getString("cname"));
                    obj.setBase(rs.getString("station"));
                    obj.setGrp(rs.getString("grp"));       
                    obj.setOffyyyymm(yyyymm);
                    obj.setOff_days(rs.getString("off_day"));
                    if("".equals(obj.getOff_days())){
                    	obj.setOff_days("No Data");
                    }
                    obj.setDuty_days(rs.getString("duty_day"));
                    if("".equals(obj.getDuty_days())){
                    	obj.setDuty_days("No Data");
                    }
//                    System.out.println(obj.getOffyyyymm()+" ~ "+obj.getOff_days());
                    objAL.add(obj);                    
                }  
                idx++;
                
                GregorianCalendar thisdate = new GregorianCalendar(); 
                thisdate.set(Integer.parseInt(syyyymm.substring(0,4)),Integer.parseInt(syyyymm.substring(4,6))-1,1);
                thisdate.add(Calendar.MONTH,idx);  
                yyyymm = format.format(thisdate.getTime());
                
                rs.close();
            }
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    
    public void getActOffDays(String syyyymm, String eyyyymm, String empno) 
    {                
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;  
        Driver dbDriver = null;
        objAL.clear();
        String yyyymm ="";
        yyyymm = syyyymm;
        String end_loop = "";
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyyMM");  
        GregorianCalendar date = new GregorianCalendar(); 
        date.set(Integer.parseInt(eyyyymm.substring(0,4)),Integer.parseInt(eyyyymm.substring(4,6))-1,1);
        date.add(Calendar.MONTH,1);  
        end_loop = format.format(date.getTime());
        int idx = 0;
        
//        System.out.println("end_loop "+end_loop);
        
        
        try
        {           
        	ConnDB cn = new ConnDB();   
        	cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            
            while (!yyyymm.equals(end_loop))
            { 
//                System.out.println("yyyymm "+yyyymm);
                
                sql = " SELECT cb.empn empn, cb.sern sern,cb.cname cname, cb.jobno jobno, cb.GROUPS grp, cb.station station, " +
                        " ca.duty_day duty_day, ca.off_day off_day FROM ( " +
                        " SELECT staff_num, Count(*) duty_day, To_Number(To_Char(Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')),'dd')) - Count(*) off_day FROM " +
                        " ( SELECT t1.mdate duty_date, t2.staff_num staff_num " +
                        " FROM ( SELECT To_Date('"+yyyymm+"01','yyyymmdd')+jday-1 mdate, empno FROM egtdate, " +
                        " (SELECT Trim(empn) empno FROM egtcbas where empn = '"+empno+"' ) cb " +
                        " WHERE jday <= To_Char(Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')),'dd') ) t1 , ( " +
                        " SELECT r.staff_num staff_num, r.duty_cd duty_cd, dps.series_num series_num,  Min(dps.tod_start_loc_ds) min_tod_start_loc_ds, " +
                        " Max(dps.act_end_dt_tm_gmt) max_act_end_dt_tm_gmt, Min(CASE WHEN dps.tod_start_loc_ds < To_Date('"+yyyymm+"01','yyyymmdd') " +
                        " THEN To_Date('"+yyyymm+"01','yyyymmdd')    ELSE Trunc(dps.tod_start_loc_ds,'dd') end ) tod_start_loc_ds, " +
                        " CASE WHEN r.duty_cd in ('FLY','TVL') THEN Max(CASE WHEN dps.act_end_dt_tm_gmt+1/24 > Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
                        " THEN Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')) ELSE Trunc(dps.act_end_dt_tm_gmt+1/24,'dd') END) " +
                        " ELSE Max(CASE WHEN dps.act_end_dt_tm_gmt > Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
                        " THEN Last_Day(To_Date('"+yyyymm+"01','yyyymmdd')) ELSE Trunc(dps.act_end_dt_tm_gmt,'dd') end) end act_end_dt_tm_gmt " +
                        " FROM egdb.duty_prd_seg_v dps, egdb.roster_v r WHERE dps.series_num = r.series_num AND dps.delete_ind ='N' AND r.delete_ind ='N'  AND  dps.duty_seq_num <> '99'  AND dps.fd_ind='N' " +
                        " AND dps.act_str_dt_tm_gmt between To_Date('"+yyyymm+"01','yyyymmdd') -15  AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) +15 " +
                        " AND (dps.tod_start_loc_ds between To_Date('"+yyyymm+"01','yyyymmdd')  AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
                        " OR dps.act_str_dt_tm_gmt between To_Date('"+yyyymm+"01','yyyymmdd')  AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) ) " +
                        " AND dps.duty_seq_num <> '99'  AND str_dt between To_Date('"+yyyymm+"01','yyyymmdd') -15 " +
                        " AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) +15  AND r.str_dt between To_Date('"+yyyymm+"01','yyyymmdd')-15 " +
                        " AND Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi'))+15  AND  r.duty_cd IN ('FLY','SBY','GRD','TVL') " +
                        " AND r.staff_num ='"+empno+"' GROUP BY  r.staff_num, r.duty_cd, dps.series_num " +
                        " UNION SELECT  DISTINCT r.staff_num, r.duty_cd, r.series_num series_num,  r.str_dt min_tod_start_loc_ds, " +
                        " end_dt max_act_end_dt_tm_gmt, str_dt tod_start_loc_ds, end_dt act_end_dt_tm_gmt " +
                        " FROM egdb.roster_v r  where r.delete_ind ='N' and series_num =0 AND duty_cd NOT IN ('RDO','ADO','BOFF') " +
                        " and r.str_dt between to_date('"+yyyymm+"01 0000','yyyy/mm/dd hh24mi') and Last_Day(To_Date('"+yyyymm+"01 2359','yyyymmdd hh24mi')) " +
                        " AND r.staff_num ='"+empno+"') t2 " +
                        " WHERE  t1.mdate BETWEEN  t2.tod_start_loc_ds and t2.act_end_dt_tm_gmt  AND t1.empno = t2.staff_num  GROUP BY staff_num , t1.mdate )  " +
                        " GROUP BY staff_num ) ca,  (SELECT Trim(empn) empn, sern ,cname , jobno, GROUPS, station " +
                        " FROM egdb.egtcbas WHERE empn='"+empno+"') cb WHERE ca.staff_num = cb.empn   ORDER BY ca.staff_num ";
                
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);
                if (rs.next())
                {
                    DutyCountObj obj = new DutyCountObj();
                    obj.setStaff_num(rs.getString("empn"));
                    obj.setSern(rs.getString("sern"));
                    obj.setCname(rs.getString("cname"));
                    obj.setBase(rs.getString("station"));
                    obj.setGrp(rs.getString("grp"));       
                    obj.setOffyyyymm(yyyymm);
                    obj.setOff_days(rs.getString("off_day"));
                    obj.setDuty_days(rs.getString("duty_day"));
//                    System.out.println(obj.getOffyyyymm()+" ~ "+obj.getOff_days());
                    objAL.add(obj);                    
                }  
                idx++;
                
                GregorianCalendar thisdate = new GregorianCalendar(); 
                thisdate.set(Integer.parseInt(syyyymm.substring(0,4)),Integer.parseInt(syyyymm.substring(4,6))-1,1);
                thisdate.add(Calendar.MONTH,idx);  
                yyyymm = format.format(thisdate.getTime());
                
                rs.close();
            }
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public void getOriADODays(String syyyymm, String eyyyymm, String empno) 
    {                
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        objAL.clear();
        
        try
        {           
        	ConnDB cn = new ConnDB();   
        	cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

            sql = " SELECT yyyymm, staff_num , sern, cname, grp, station, Count(*) c FROM ( " +
            	  " SELECT DISTINCT cb.empn empn, cb.sern sern,cb.cname cname, cb.jobno jobno, cb.GROUPS grp, cb.station station, " +
            	  " SubStr(yyyymm_version,0,6) yyyymm, To_Char(str_dt,'yyyy/mm/dd'), staff_num " +
            	  " FROM fzdb.fztskj2 r, egtcbas cb WHERE r.series_num=0  AND r.duty_cd ='ADO' AND r.staff_num = Trim(cb.empn) " +
            	  " AND r.staff_num ='"+empno+"' AND str_dt BETWEEN To_Date('"+syyyymm+"01 0000','yyyymmdd hh24mi') " +
            	  " AND Last_Day(To_Date('"+eyyyymm+"01 23:59','yyyymmdd hh24:mi')) AND yyyymm_version like '%_00') " +
            	  " GROUP BY yyyymm, staff_num , sern, cname, grp, station ORDER BY yyyymm ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql); 
            while (rs.next())
            {
                DutyCountObj obj = new DutyCountObj();
                obj.setStaff_num(rs.getString("staff_num"));
                obj.setSern(rs.getString("sern"));
                obj.setCname(rs.getString("cname"));
                obj.setBase(rs.getString("station"));
                obj.setGrp(rs.getString("grp"));
                obj.setDuty_cd("ADO");
                obj.setOffyyyymm(rs.getString("yyyymm"));
                obj.setCnt(rs.getString("c"));            
//                System.out.println(obj.getOffyyyymm()+" ~ "+obj.getCnt());
                objAL.add(obj);          
            }      
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public void getActADODays(String syyyymm, String eyyyymm, String empno) 
    {                
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;  
        Driver dbDriver = null;
        objAL.clear();
        
        try
        {           
        	ConnDB cn = new ConnDB();   
        	cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();

            sql = " SELECT yyyymm, staff_num , sern, cname, grp, station, Count(*) c FROM ( " +
            	  " SELECT DISTINCT cb.empn empn, cb.sern sern,cb.cname cname, cb.jobno jobno, cb.GROUPS grp, cb.station station, " +
            	  " to_char(str_dt,'yyyymm') yyyymm, To_Char(str_dt,'yyyy/mm/dd'), staff_num " +
            	  " FROM egdb.roster_v r, egtcbas cb WHERE r.series_num=0  AND r.duty_cd ='ADO' AND r.staff_num = Trim(cb.empn) " +
            	  " AND r.delete_ind = 'N' AND r.staff_num ='"+empno+"' " +
            	  " AND act_str_dt BETWEEN To_Date('"+syyyymm+"01 0000','yyyymmdd hh24mi') AND Last_Day(To_Date('"+eyyyymm+"01 23:59','yyyymmdd hh24:mi')) " +
            	  " ) GROUP BY yyyymm, staff_num , sern, cname, grp, station ORDER BY yyyymm ";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql); 
            while (rs.next())
            {
                DutyCountObj obj = new DutyCountObj();
                obj.setStaff_num(rs.getString("staff_num"));
                obj.setSern(rs.getString("sern"));
                obj.setCname(rs.getString("cname"));
                obj.setBase(rs.getString("station"));
                obj.setGrp(rs.getString("grp"));
                obj.setDuty_cd("ADO");
                obj.setOffyyyymm(rs.getString("yyyymm"));
                obj.setCnt(rs.getString("c"));                
                objAL.add(obj);
            }      
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
   
    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }

    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return errorstr;
    }
   
    
}
