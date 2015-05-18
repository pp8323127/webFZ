package df.overTime.ac;

import java.sql.*;
import java.util.*;
import java.util.Date;

import ci.db.*;

/**
 * RetrieveOverTimeData
 * 
 * @author cs71
 * @version 1.0 2005/12/29
 * 
 * Copyright: Copyright (c) 2005
 */
// 增加航班需修改 RetrieveOverTimeData_For16Hrs.java & SumOverTime_For16Hrs.java
//
public class RetrieveSBIRData_AC
{

    public static void main(String[] args)
    {
        System.out.println(new Date());
        RetrieveSBIRData_AC rot = new RetrieveSBIRData_AC("2012", "02", "17","7923", "");
//        rot.getSBIRData();
        rot.retrieveSBIRData();
//        System.out.println(rot.getObjAL().size());
//        System.out.println("Done");
        System.out.println(new Date());
    }

    private String year = "";
    private String month = "";
    private String dd = "";
    private String fltno = "";
    private String empno = "";

    private int count = 0;
    private String sql = "";
    ArrayList objAL = null;
    private String errorstr = "";
    

    public RetrieveSBIRData_AC(String year, String month, String dd, String fltno, String empno)
    {
        this.year = year;
        if (month.length() < 2)
        {
            month = "0" + month;
        }
        this.month = month;

        if (!"".equals(dd) && dd != null)
        {
            if (dd.length() < 2)
            {
                dd = "0" + dd;
            }
        }
        this.dd = dd;
        this.fltno = fltno;
        this.empno = empno;
    }

    public void getSBIRData()
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();

            sql = " select series_num , duty_seq_num, To_Char(skj_report_gmt,'yyyy/mm/dd hh24:mi:ss') rep,  "
                    + " To_Char(act_release_gmt,'yyyy/mm/dd hh24:mi:ss') rel, "
                    + " To_Char(skj_takeoff_gmt,'yyyy/mm/dd hh24:mi:ss') takeoff, "
                    + " To_Char(act_land_gmt,'yyyy/mm/dd hh24:mi:ss') land, "
                    + " To_Char(act_takeoff_utc,'yyyy/mm/dd hh24:mi:ss') act_takeoff, "
                    + " workmins, basemins, empno, fltno, port_a, port_b, port_base, overmins, overmins2,"
                    + " paymm, chguser, To_Char(chgdt,'yyyy/mm/dd hh24:mi:ss') chgdt "
                    + " from dftsbir ";
            if ("".equals(dd) || dd == null)
            {
                sql = sql + " where paymm = to_char(last_day(to_date('" + year
                        + month + "01','yyyymmdd'))+1,'yyyymm') ";
            }
            else
            {
                sql = sql + " where  trunc(act_takeoff_utc,'dd') = to_date('"
                        + year + month + dd + "','yyyymmdd')";
            }

            if (!"".equals(fltno) || fltno == null)
            {
                sql = sql + " and fltno = lpad('" + fltno + "',4,0) ";
            }

            if (!"".equals(empno) || empno == null)
            {
                sql = sql + " and empno = '" + empno + "' ";
            }
            sql = sql + " order by  act_takeoff_utc, fltno, port_a, empno ";

//            System.out.println(sql);
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            objAL = new ArrayList();

            while (rs.next())
            {
                OverTimeObj obj = new OverTimeObj();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setDuty_seq_num(rs.getString("duty_seq_num"));
                obj.setWorkmins(rs.getString("workmins"));
                obj.setSkj_report_gmt(rs.getString("rep"));
                obj.setAct_release_gmt(rs.getString("rel"));
                obj.setSkj_takeoff_gmt(rs.getString("takeoff"));
                obj.setAct_land_gmt(rs.getString("land"));
                obj.setAct_takeoff_utc(rs.getString("act_takeoff"));
                obj.setBasemins(rs.getString("basemins"));
                obj.setEmpno(rs.getString("empno"));
                obj.setFltno(rs.getString("fltno"));
                obj.setPort_a(rs.getString("port_a"));
                obj.setPort_b(rs.getString("port_b"));
                obj.setPort_base(rs.getString("port_base"));
                obj.setPaymm(rs.getString("paymm"));
                obj.setOvermins(rs.getString("overmins"));
                obj.setOvermins2(rs.getString("overmins2"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdt(rs.getString("chgdt"));
                objAL.add(obj);
            }
            errorstr = "Y";
        }
        catch ( SQLException e )
        {

            errorstr = e.toString();
        }
        catch ( Exception e )
        {

            errorstr = e.toString();
        }
        finally
        {
            if (rs != null)
                try
                {
                    rs.close();
                }
                catch ( SQLException e )
                {
                }
            if (pstmt != null)
                try
                {
                    pstmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }

    }

    public void retrieveSBIRData()
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();

            sql =   " SELECT t1.series_num, t1.duty_seq_num, t1.wkhr, t1.rep, t1.rel, t1.takeoff, t1.land, " +
            		" t1.act_takeoff, t1.staff_num, t1.flt_num, t1.port_a, t1.port_b, t1.port_ori, t1.paymm, " +
            		"  decode(t2.empno,NULL,'0',t2.overmins) overmins_sbir, " +
               		"  decode(t2.empno,NULL,'0',t2.overmins2) overmins2_sbir, " +     
               		"  decode(t2.empno,NULL,'N',t2.chguser) sbir FROM ( " +              		
            		"  SELECT tdp.series_num , tdp.duty_seq_num, " +
                    " Round((tdp.act_end_dt_tm_gmt- tdp.act_str_dt_tm_gmt)*24*60,0) wkhr, " +
                    " To_Char(tdp.act_str_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') rep,  " +
                    " To_Char(tdp.act_end_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') rel, " +
                    " To_Char(dpsr.str_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') takeoff, " +
                    " To_Char(dpsr.act_end_dt_tm_gmt,'yyyy/mm/dd hh24:mi:ss') land, " +
                    " To_Char(dpsr.act_str_dt_tm_gmt-(8/24),'yyyy/mm/dd hh24:mi:ss') act_takeoff, " +
//                    " dpsr.staff_num, lpad(dpsr.flt_num,4,0) flt_num, dpsr.port_a, dpsr.port_b, " +
                    " dpsr.staff_num, dpsr.flt_num flt_num, dpsr.port_a, dpsr.port_b, " +           
                    " tdp.airport_cd port_ori, To_Char(last_day(dpsr.act_str_dt_tm_gmt)+1,'yyyymm') paymm " +
                    " FROM ( SELECT r.staff_num, dps.series_num, dps.port_a, dps.port_b, dps.str_dt_tm_gmt,  " +
                    "        dps.act_str_dt_tm_gmt, dps.act_end_dt_tm_gmt, dps.duty_seq_num, dps.flt_num " +
                    "        FROM ( SELECT t1.* FROM  duty_prd_seg_v t1, " +
                    "                  ( SELECT dps.series_num, dps.duty_seq_num, Max(dps.act_end_dt_tm_gmt) act_end_dt_tm_gmt " +
                    "                      FROM duty_prd_seg_v dps, " +
                    "                           (SELECT  dps.series_num, dps.duty_seq_num FROM  duty_prd_seg_v dps " +
                    "                             WHERE dps.act_str_dt_tm_gmt BETWEEN to_date('"+year+month+"01 00:00:00','yyyymmdd hh24:mi:ss')+(8/24) " +
                    "                                   AND Last_Day(to_date('"+year+month+"01 23:59:59','yyyymmdd hh24:mi:ss'))+(8/24) " +
                    "                                   AND Trunc(dps.act_str_dt_tm_gmt-(8/24),'dd') = to_date('"+year+month+dd+"','yyyymmdd') " +
//                    "                                   and dps.flt_num = lpad('"+fltno+"',4,0) AND dps.fd_ind = 'N' " +
                    "									  and dps.flt_num = '"+fltno+"' AND dps.fd_ind = 'N' " +
                    "                                   AND  dps.delete_ind = 'N' " +
                    "									AND  dps.duty_cd in ('FLY','TVL') " + //20120220 應吳曉星 20120217 7923Z 加入TVL
//                    "									AND  dps.duty_cd = 'FLY' " + 
                    "                           GROUP BY series_num, duty_seq_num )  dps2 " +
                    "                     WHERE dps.series_num = dps2.series_num AND dps.duty_seq_num = dps2.duty_seq_num " +
                    "                           AND dps.fd_ind = 'N' AND  dps.delete_ind = 'N' " +
                    "                           AND  dps.duty_cd in ('FLY','TVL') " +                
//                    "                           AND  dps.duty_cd = 'FLY' " +   
                    "                     GROUP BY  dps.series_num, dps.duty_seq_num ) t2  " +
                    "               WHERE t1.series_num=t2.series_num  AND t1.act_end_dt_tm_gmt = t2.act_end_dt_tm_gmt and t1.delete_ind = 'N'" +
                    "                     AND t1.duty_seq_num=t2.duty_seq_num ) dps, roster_v r " +
                    "       WHERE dps.series_num = r.series_num AND r.delete_ind = 'N'  " +
//                    "             AND r.duty_cd in ('FLY','TVL') " +
                    "             AND r.duty_cd = 'FLY' " +                    
                    "             AND SubStr(r.staff_num,1,1) <> '8'  " +
                    "             ORDER BY r.staff_num ) dpsr, trip_duty_prd_v tdp " +
                    " WHERE  dpsr.series_num = tdp.series_num AND  dpsr.duty_seq_num = tdp.duty_seq_num and tdp.delete_ind = 'N' " +
                    "  ) t1, dftsbir t2 " +
                    " WHERE t1.series_num =t2.series_num (+) " +
                    " AND t1.duty_seq_num = t2.duty_seq_num (+)  and  t1.staff_num = t2.empno (+)  " +
                    " ORDER BY t1.takeoff, t1.port_a, t1.port_b, t1.staff_num ";

//            System.out.println("*******##**********" + new Date());
//            System.out.println(" sql = " +sql);
//            System.out.println("*******##***********" + new Date());

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            objAL = new ArrayList();            
            
//          get transfer flt *******************      
            TransferFlt flt = new TransferFlt();
            flt.getTransferFlt();
            ArrayList transfltAL = new ArrayList();
            transfltAL = flt.getObjAL();            
            //************************************      
            RetrieveCrewBase cb = new RetrieveCrewBase(year,month);
            //************************************
            while (rs.next())
            {
                OverTimeObj obj = new OverTimeObj();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setDuty_seq_num(rs.getString("duty_seq_num"));
                obj.setWorkmins(rs.getString("wkhr"));
                obj.setSkj_report_gmt(rs.getString("rep"));
                obj.setAct_release_gmt(rs.getString("rel"));
                obj.setSkj_takeoff_gmt(rs.getString("takeoff"));
                obj.setAct_land_gmt(rs.getString("land"));
                obj.setAct_takeoff_utc(rs.getString("act_takeoff"));                
                obj.setEmpno(rs.getString("staff_num"));
                obj.setFltno(rs.getString("flt_num"));
                obj.setPort_a(rs.getString("port_a"));
                obj.setPort_b(rs.getString("port_b"));
                obj.setPort_base(rs.getString("port_ori"));
                obj.setSbirflag(rs.getString("sbir"));
                obj.setPaymm(rs.getString("paymm"));   
                obj.setOvermins_sbir(rs.getString("overmins_sbir"));
                obj.setOvermins2_sbir(rs.getString("overmins2_sbir"));
                
                if("KHH".equals(cb.getBase(obj.getEmpno())))
                {//khh base flt 
                    obj.setBasemins("660");
                }                             
                else
                {//TPE BASE flt maybe 區域flt or 越洋 flt
                    for(int j=0; j<transfltAL.size(); j++)
                    {
                    	obj.setBasemins("720");
                        TransferFltObj fltobj = (TransferFltObj) transfltAL.get(j);
                        if(obj.getPort_a().equals(fltobj.getSector()) | obj.getPort_b().equals(fltobj.getSector())|obj.getPort_base().equals(fltobj.getSector()))
                        {//越洋 flt
                            obj.setBasemins("840");                            
                            if("AKLBNE".equals(rs.getString("port_a")+rs.getString("port_b")))
                            {
                                obj.setBasemins("720");
                            }
                            break;
                        }
                    }                
                }
                //calculate overtimemins
                int tempwkhr = Integer.parseInt(obj.getWorkmins());
                int tempbasetime = Integer.parseInt(obj.getBasemins());
                int tempovertime = 0;
                int tempovertime2 = 0;
                tempovertime = tempwkhr - tempbasetime;
                if(tempovertime<=0)
                {
                    tempovertime=0;
                }
                obj.setOvermins(Integer.toString(tempovertime));
                obj.setOvermins2("0");
                
//              2009Apr後則無二倍計算情形
                if(Integer.parseInt(year+month) < 200904)
                {
	                if(tempwkhr>960 && !"0061".equals(obj.getFltno()))
	                {//Besides ci0061, over 16 hrs, 以2倍計算
	                    obj.setOvermins(Integer.toString(960-Integer.parseInt(obj.getBasemins())));
	                    obj.setOvermins2(Integer.toString(tempwkhr-960));
	                }
                }
                objAL.add(obj);
            }
            errorstr = "Y";
        }
        catch ( SQLException e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();

        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            if (rs != null)
                try
                {
                    rs.close();
                }
                catch ( SQLException e )
                {
                }
            if (pstmt != null)
                try
                {
                    pstmt.close();
                }
                catch ( SQLException e )
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                }
                catch ( SQLException e )
                {
                }
        }

    }

    public String getSQLStr()
    {
        return sql;
    }

    public String getErrorStr()
    {
        return errorstr;
    }

    public ArrayList getObjAL()
    {
        return objAL;
    }

}