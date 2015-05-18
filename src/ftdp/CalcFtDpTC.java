package ftdp;

import ci.db.*;
import java.sql.*;
import java.util.*;
import ci.tool.*;

public class CalcFtDpTC
{
    private String sql = null;
    private ArrayList objAL = new ArrayList();
    private Hashtable objHT = new Hashtable();
    private String errorstr = "";
    private String sdate="";
    private String edate="";
    private String order_str = " order by tmp.staff_num ";
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        CalcFtDpTC cdp = new CalcFtDpTC();
        cdp.setOrderStr("dp");
//        cdp.getCrewFtDp("2014/02/23","2014/03/25", "","ALL","PR");
//        cdp.getCrewFtDpByDate("2014/02/12","2014/03/14", "631581");
        cdp.getCrewFtDpByDate3("2014/04/09","2014/05/08", "637060");
        Hashtable objHT = new Hashtable();
        objHT = cdp.getObjHT();       
        //System.out.println("objHT "+objHT.size());
        Set set = objHT.keySet();
        Iterator itr = set.iterator();    
        // sorted keys output  
        Vector v = new Vector(objHT.keySet());
        Collections.sort(v);
        itr = v.iterator();        
        int dp =0;
        int dp2 =0;
        while (itr.hasNext()) 
        {
            ftdpObj2 obj = (ftdpObj2) objHT.get(itr.next());
            
//            dp = dp +Integer.parseInt(obj.getDp_mins());
//            dp2 = dp2 +Integer.parseInt(obj.getDp2_mins());
            //System.out.println( TimeUtil.minToHHMM(obj.getFdp_mins()));
            //System.out.println( TimeUtil.minToHHMMWithColon(obj.getFdp_mins()));
//            System.out.println(obj.getStaff_num() + ":" + obj.getCal_dt()+"*"+obj.getAct_rpt()+": dp=" + obj.getDp_mins()+ "/dp2="+ obj.getDp2_mins());//+ "/fdp2="+ obj.getFdp_mins()+ "/lo="+ obj.getLo_mins()+ "/rst="+ obj.getRp_mins());
//            System.out.println(obj.getStaff_num() + ":" + obj.getCal_dt()+ ":" +obj.getCheck_dp()+ "**" +obj.getDp_mins());
//            System.out.println(obj.getStaff_num() + ":" + obj.getCal_dt()+ ":" +obj.getCheck_ft()+ "**" +obj.getFt_mins());
//            System.out.println(obj.getCal_dt()+ ":" +obj.getFlt_num()+ "**" +obj.getPort_a()+ "**" +obj.getPort_b()+ "**" +obj.getCheck_dp()+ "**" +obj.getRp_mins());
//            System.out.println(obj.getCal_dt()+ ":" + "**" +obj.getRp_mins());
        }  
//        
//       System.out.println("dp = "+dp);
//       System.out.println("dp2 = "+dp2);
        

//        ArrayList objAL = new ArrayList();
//        objAL = cdp.getObjAL();
//        int ft = 0;
//        for(int i=1; i<objAL.size()-1; i++)
//        {
//            ftdpObj obj = (ftdpObj) objAL.get(i);
//            ft = ft + Integer.parseInt(obj.getFt()); 
//            
//            if(Integer.parseInt(obj.getFt())>0)
//            {
//            
////            System.out.print(obj.getSeries_num()+"/");
//////            System.out.print(obj.getStaff_num()+"/");
//////            System.out.print(obj.getSkj_fdate()+"*");
////            System.out.print(obj.getRpt()+"/");
////            System.out.print(obj.getRls()+"/");
//            System.out.print(obj.getFdateDptgmt()+"*");
//            System.out.print(obj.getFdateArvgmt()+"*");
//            System.out.print(obj.getDuty_cd()+"*");
//////            System.out.print(obj.getDpt()+"*");
//////            System.out.print(obj.getArv()+"*");
////            System.out.print(obj.getDtype()+"*");
//////            System.out.print(obj.getDsn()+"*");
//////            System.out.print(obj.getRpt_mins()+"*");
//////            System.out.print(obj.getRls_mins()+"*");
//            System.out.println(obj.getFt()+"*");
////            System.out.println(obj.getDp()+"#");
//            }
//        }
//        System.out.println("#### "+ft);

    }
    
    public void setOrderStr(String order_str )
    { 
        if("ft".equals(order_str))
        {
            order_str = " order by tmp3.ft desc, tmp.staff_num ";
        }
        else if("dp".equals(order_str))
        {
            order_str = " order by (tmp.cum_dp+tmp.cum_dh+tmp.cum_stby+nvl(tmp7.adjust_mins,0)) desc, tmp.staff_num ";
        }
        else
        {
            order_str = " order by tmp.staff_num ";
        }  
        this.order_str = order_str;
    }
    
    public void getCrewFtDp(String sdate, String edate, String empno, String base, String rank )
    {        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String empnoCond, baseCond, rankCond, levelFT, sdt, edt;
        this.sdate = sdate;
        this.edate = edate;
        
        if ("ALL".equals(base))  baseCond  = "" ;else baseCond  = " and bs.base='"+base+"' ";
        if ("ALL".equals(rank))  rankCond  = "" ;else rankCond  = " and rk.rank_cd='"+rank+"' ";
        if (empno.equals("") | empno==null)  empnoCond  = "" ;else empnoCond  = " and c.staff_num='"+empno+"'" ;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
//            System.out.println("set getCrewFtDp st "+ new java.util.Date());
            
            sql = "select distinct rk.rank_cd, tmp.staff_num, bs.base, " +
                   "cb.name cname, cb.fleet, " +
//                 "tmp.dp+nvl(tmp7.adjust_mins,0) DP, " +
                   "(tmp.cum_dp+tmp.cum_dh+tmp.cum_stby) DP, " +
                   "(tmp.cum_dh+tmp.cum_stby) dhsb, tmp3.ft ft, " +
                   " nvl(tmp7.adjust_mins,0) adjust_mins " +
                   "from FZDB.crew_base_v bs, FZDB.crew_rank_v rk, crew_v c,  dftcrew cb,  " +
                /*==============DP==============================*/
//                "(select cc.staff_num, SUM(cc.cum_dp + cc.act_total_dead_head_mins + cc.act_home_stby_mins) dp  " +
                "(select cc.staff_num, SUM(cc.cum_dp) cum_dp, SUM(cc.act_total_dead_head_mins) cum_dh, SUM(cc.act_home_stby_mins) cum_stby  " +
                /*後面再計算 TVL report+release=140(TPE出發)/120min(外站出發)*/
                "from FZDB.crew_cum_hr_tc_v cc " +
                "where cc.cal_dt between to_date('"+sdate+" 0000','yyyy/mm/dd hh24mi') " +
                "and to_date('"+edate+"  2359','yyyy/mm/dd hh24mi') " +
                "GROUP BY cc.staff_num ) TMP , " +                
                /*=============ft===============================*/
                "(select cc.staff_num, sum(cc.rem_fh_28) ft  " +
                "from FZDB.crew_cum_hr_tc_v cc  " +
                "where cc.cal_dt between to_date('"+sdate+" 0000','yyyy/mm/dd hh24mi')  " +
                "and to_date('"+edate+" 2359','yyyy/mm/dd hh24mi')  " +
                "GROUP BY cc.staff_num ) TMP3 , " +
                /*=============ADJUST Mins ===============================*/
//                "( SELECT r.staff_num staff_num, nvl(Sum((dps.tod_start_loc_ds - lin.tsa_dt)*24*60),0) adjust_mins " +
//                  " FROM fztflin lin, duty_prd_seg_v dps, roster_v r " +
//                  " WHERE lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                  " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                  " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
//                  " AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                  " OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
//                  " AND lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                  " AND dps.act_port_a = 'TPE' AND lin.fltno = dps.flt_num AND lin.sect = dps.port_a||dps.port_b " +
//                  " AND dps.delete_ind='N' and dps.fd_ind='N' and dps.act_port_a <> dps.act_port_b " +
//                  " AND r.delete_ind='N' AND r.series_num = dps.series_num " +
//                  " AND  lin.tsa_dt < dps.tod_start_loc_ds " +                  
//                  " AND (dps.tod_start_loc_ds - lin.tsa_dt)*24*60 >=5 AND (dps.tod_start_loc_ds - lin.tsa_dt)*24*60 <=15 " +
//                  " GROUP BY r.staff_num ) TMP7 " +
                  /*=============ADJUST Mins ===============================*/
                  "( SELECT staff_num, nvl(Round(Sum((crews.tod_start_loc_ds - lin.tsa_dt)*24*60)),0) adjust_mins  " +
                  " FROM fztflin lin, ( SELECT r.staff_num staff_num, dps.tod_start_loc_ds tod_start_loc_ds, " +
                  " dps.act_str_dt_tm_gmt, dps.port_a||dps.port_b  sect , dps.flt_num flt_num " +
                  " FROM duty_prd_seg_v dps, roster_v r " +
                  " WHERE (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " OR  dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  " AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  " AND dps.act_port_a = 'TPE'  AND r.series_num = dps.series_num  " +
                  " AND dps.delete_ind='N' and dps.fd_ind='Y' AND r.delete_ind='N' " +
                  " and dps.act_port_a <> dps.act_port_b  )  crews " +
                  " WHERE lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " AND lin.fltno = crews.flt_num  AND lin.sect = crews.sect " +
                  " AND  lin.tsa_dt < crews.tod_start_loc_ds  " +
                  " AND lin.tsa_dt BETWEEN crews.tod_start_loc_ds -(15/(24*60)) AND crews.tod_start_loc_ds - (5/(24*60)) " +
                  " GROUP BY staff_num  ) TMP7 " +
                /*============================================*/
                "where tmp.staff_num=tmp3.staff_num  " +
                "and tmp.staff_num=trim(cb.empno)  " +
                "and tmp.staff_num=c.staff_num  and tmp.staff_num = TMP7.staff_num(+) " +
                "and tmp.staff_num=rk.staff_num  and tmp.staff_num=bs.staff_num  " +
                "and sysdate between rk.eff_dt " +
                "and NVL(rk.exp_dt,to_date('20500101','yyyymmdd')) and (bs.exp_dt is null or bs.exp_dt > sysdate)  " +
                "and bs.prim_base='Y' " + empnoCond + rankCond + baseCond + order_str +" ";
            
//              System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    ftdpObj obj = new ftdpObj();                    
                    obj.setStaff_num(rs.getString("staff_num"));  
                    obj.setCname(rs.getString("cname"));                    
                    //obj.setSern(rs.getString("sern"));
                    obj.setGrp(rs.getString("fleet"));    
                    obj.setBase(rs.getString("base"));
                    obj.setRank(rs.getString("rank_cd"));
                    obj.setDp(rs.getString("dp"));
                    obj.setFt(rs.getString("ft"));
                    obj.setAdjust_mins(rs.getString("adjust_mins"));
                    obj.setDhsb(rs.getString("dhsb"));
                    objAL.add(obj);
                }
//            System.out.println("set getCrewFtDp ed "+ new java.util.Date());
        } 
        catch(Exception e)
        {
        	errorstr = e.toString();
            System.out.println("Error : "+ e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public void getCrewFtDpByDate(String sdate, String edate, String empno)
    {        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        this.sdate = sdate;
        this.edate = edate;        
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            sql = " SELECT cc.staff_num, cb.cname, cb.sern, cb.GROUPS, cb.station, rk.rank_cd, " +
            	  " To_Char(cal_dt,'yyyy/mm/dd') cal_dt,rem_fh_28 ft_mins, " +
            	  " TRUNC(rem_fh_28/60) || ':' || LPAD(TRUNC(MOD(rem_fh_28,60)),2,'0') ft_hr, " +            	  
            	  " (cum_dp+act_total_dead_head_mins+act_home_stby_mins) cum_dp_mins," +
            	  " TRUNC((cum_dp+act_total_dead_head_mins+act_home_stby_mins)/60) || ':' || LPAD(TRUNC(MOD((cum_dp+act_total_dead_head_mins+act_home_stby_mins),60)),2,'0') cum_dp_hr, " +
            	  " non_std_fly_hours credit_mins," +
            	  " TRUNC(non_std_fly_hours/60) || ':' || LPAD(TRUNC(MOD(non_std_fly_hours,60)),2,'0') credit_hr, " +
            	  " act_total_dead_head_mins act_total_dead_head_mins, act_home_stby_mins act_home_stby_mins  " +
            	  " from fzdb.crew_cum_hr_cc_v cc, egtcbas cb, FZDB.crew_rank_v rk " +
            	  " where cal_dt between to_date('"+sdate+" 0000','yyyy/mm/dd hh24mi')  and to_date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
            	  " AND cc.staff_num = Trim(cb.empn) AND cc.staff_num = rk.staff_num " +
            	  " AND cc.staff_num = '"+empno+"' AND sysdate between rk.eff_dt and NVL(rk.exp_dt,to_date('20500101','yyyymmdd')) ";
            
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    ftdpObj2 obj = new ftdpObj2();                    
                    obj.setStaff_num(rs.getString("staff_num"));  
                    obj.setCname(rs.getString("cname"));                    
                    obj.setSern(rs.getString("sern"));
                    obj.setGrp(rs.getString("groups"));    
                    obj.setBase(rs.getString("station"));
                    obj.setRank(rs.getString("rank_cd"));
                    obj.setCal_dt(rs.getString("cal_dt"));
                    obj.setDp(rs.getString("cum_dp_hr"));
                    obj.setDp_mins(rs.getString("cum_dp_mins"));
                    obj.setFt(rs.getString("ft_hr"));
                    obj.setFt_mins(rs.getString("ft_mins"));
                    obj.setCredit(rs.getString("credit_hr"));
                    obj.setCredit_mins(rs.getString("credit_mins"));
                    obj.setAct_home_stby_mins(rs.getString("act_home_stby_mins"));
                    obj.setAct_total_dead_head_mins(rs.getString("act_total_dead_head_mins"));
                    objHT.put(obj.getCal_dt(),obj);
                }
                rs.close();                
                
                sql = "SELECT staff_num, fdp, To_Char(act_str_dt_tm_gmt,'yyyy/mm/dd') cal_dt, act_str_dt_tm_gmt, act_end_dt_tm_gmt FROM ( "+
                    "SELECT staff_num, (act_end_dt_tm_gmt-act_str_dt_tm_gmt)*24*60 fdp, act_str_dt_tm_gmt, act_end_dt_tm_gmt "+
                    "FROM ( "+
                    "SELECT r.staff_num, CASE WHEN tdp.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') THEN To_Date('"+sdate+"','yyyy/mm/dd') "+
                    "else tdp.act_str_dt_tm_gmt END act_str_dt_tm_gmt, CASE WHEN (tdp.act_end_dt_tm_gmt-1/24) > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "THEN  To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE  (tdp.act_end_dt_tm_gmt-1/24) END act_end_dt_tm_gmt "+
                    "FROM fzdb.trip_duty_prd_v tdp , roster_v r "+
                    "WHERE (tdp.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "OR (tdp.act_end_dt_tm_gmt-1/24)  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) "+
                    "AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) "+
                    "AND tdp.series_num = r.series_num AND r.delete_ind='N' AND tdp.delete_ind = 'N' AND fd_ind = 'N' AND act_dt_hr >0 "+
                    "AND staff_num ='"+empno+"' "+
                    ") "+
                    "WHERE To_Char(act_str_dt_tm_gmt,'yyyy/mm/dd') = To_Char(act_end_dt_tm_gmt,'yyyy/mm/dd') "+
                    "UNION ALL "+
                    "SELECT staff_num, (Trunc(act_str_dt_tm_gmt+1,'dd') - act_str_dt_tm_gmt)*24*60  fdp, act_str_dt_tm_gmt act_str_dt_tm_gmt, Trunc(act_str_dt_tm_gmt+1,'dd') act_end_dt_tm_gmt "+
                    "FROM ( "+
                    "SELECT r.staff_num, CASE WHEN tdp.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') THEN To_Date('"+sdate+"','yyyy/mm/dd')  "+
                    "else tdp.act_str_dt_tm_gmt END act_str_dt_tm_gmt, CASE WHEN (tdp.act_end_dt_tm_gmt-1/24) > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')  "+
                    "THEN  To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE  (tdp.act_end_dt_tm_gmt-1/24) END act_end_dt_tm_gmt "+
                    "FROM fzdb.trip_duty_prd_v tdp , roster_v r "+
                    "WHERE (tdp.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "OR (tdp.act_end_dt_tm_gmt-1/24)  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) "+
                    "AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) "+
                    "AND tdp.series_num = r.series_num AND r.delete_ind='N' AND tdp.delete_ind = 'N' AND fd_ind = 'N' AND act_dt_hr >0 "+
                    "AND staff_num ='"+empno+"' "+
                    ") "+
                    "WHERE To_Char(act_str_dt_tm_gmt+1,'yyyy/mm/dd') = To_Char(act_end_dt_tm_gmt,'yyyy/mm/dd') "+
                    "UNION  ALL "+
                    "SELECT staff_num, (act_end_dt_tm_gmt-Trunc(act_str_dt_tm_gmt+1,'dd'))*24*60  fdp, Trunc(act_str_dt_tm_gmt+1,'dd') act_str_dt_tm_gmt, act_end_dt_tm_gmt act_end_dt_tm_gmt "+
                    "FROM ( "+
                    "SELECT r.staff_num, CASE WHEN tdp.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') THEN To_Date('"+sdate+"','yyyy/mm/dd') "+
                    "else tdp.act_str_dt_tm_gmt END act_str_dt_tm_gmt, CASE WHEN (tdp.act_end_dt_tm_gmt-1/24) > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "THEN  To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE  (tdp.act_end_dt_tm_gmt-1/24) END act_end_dt_tm_gmt "+
                    "FROM fzdb.trip_duty_prd_v tdp , roster_v r "+
                    "WHERE (tdp.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "OR (tdp.act_end_dt_tm_gmt-1/24)  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) "+
                    "AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') "+
                    "OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) "+
                    "AND tdp.series_num = r.series_num AND r.delete_ind='N' AND tdp.delete_ind = 'N' AND fd_ind = 'N' AND act_dt_hr >0 "+
                    "AND staff_num ='"+empno+"' "+
                    ") "+
                    "WHERE To_Char(act_str_dt_tm_gmt+1,'yyyy/mm/dd') = To_Char(act_end_dt_tm_gmt,'yyyy/mm/dd') "+
                    ") "+
                    "ORDER BY  act_str_dt_tm_gmt ";
                
//                  System.out.println(sql);
                  rs = stmt.executeQuery(sql);        
                  while(rs.next())
                  {
                      ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                      obj.setFdp_mins(Integer.toString(Integer.parseInt(obj.getFdp_mins())+Integer.parseInt(rs.getString("fdp"))));   
                      objHT.put(obj.getCal_dt(),obj);
                  }
        } 
        catch(Exception e)
        {
            System.out.println("Error : "+ e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public void getCrewFtDpByDate2(String sdate, String edate, String empno)
    {        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        this.sdate = sdate;
        this.edate = edate;        
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            //set dp
            sql = " SELECT cc.staff_num, cb.cname, cb.sern, cb.GROUPS, cb.station, rk.rank_cd, " +
                  " To_Char(cal_dt,'yyyy/mm/dd') cal_dt,rem_fh_28 ft_mins, " +
                  " (cum_dp+act_total_dead_head_mins+act_home_stby_mins) cum_dp_mins," +
                  " non_std_fly_hours credit_mins," +
                  " act_total_dead_head_mins act_total_dead_head_mins, act_home_stby_mins act_home_stby_mins  " +
                  " from fzdb.crew_cum_hr_cc_v cc, egtcbas cb, FZDB.crew_rank_v rk " +
                  " where cal_dt between to_date('"+sdate+" 0000','yyyy/mm/dd hh24mi')  and to_date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " AND cc.staff_num = Trim(cb.empn) AND cc.staff_num = rk.staff_num " +
                  " AND cc.staff_num = '"+empno+"' AND sysdate between rk.eff_dt and NVL(rk.exp_dt,to_date('20500101','yyyymmdd')) ";
            
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    ftdpObj2 obj = new ftdpObj2();                    
                    obj.setStaff_num(rs.getString("staff_num"));  
                    obj.setCname(rs.getString("cname"));                    
                    obj.setSern(rs.getString("sern"));
                    obj.setGrp(rs.getString("groups"));    
                    obj.setBase(rs.getString("station"));
                    obj.setRank(rs.getString("rank_cd"));
                    obj.setCal_dt(rs.getString("cal_dt"));
                    obj.setDp_mins(rs.getString("cum_dp_mins"));  
                    obj.setCredit_mins(rs.getString("credit_mins"));
                    obj.setAct_home_stby_mins(rs.getString("act_home_stby_mins"));
                    obj.setAct_total_dead_head_mins(rs.getString("act_total_dead_head_mins"));
                    obj.setFt(rs.getString("ft_mins"));
                    objHT.put(obj.getCal_dt(),obj);
                }
                rs.close();
                
                //Set fdp/lo/rst
                sql = " SELECT series_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt, tod_start_loc_ds,port_a, port_b, dps_duty_cd, flt_num, duty_seq_num, " +
                	  " item_seq_num , skj_sd,act_sd, act_ed, act_rpt, act_rls, overnight_ind, staff_num, r_duty_cd, " +
                	  " CASE WHEN dps_duty_cd in ('FLY','TVL') then Round((act_rls-(1/24)-act_rpt)*24*60,0) ELSE 0 END fdp, " +
                	  " CASE WHEN dps_duty_cd in ('RST','LO') then Round((act_rls-act_rpt)*24*60,0) ELSE 0 END rst, " +
                	  " CASE WHEN dps_duty_cd NOT in ('RST','LO','FLY','TVL') then Round((act_rls-act_rpt)*24*60,0) ELSE 0 END grd_dp " +
                	  " FROM ( " +
                	  " SELECT tdp.trip_num series_num, dps.tod_start_loc_ds tod_start_loc_ds, dps.act_port_a port_a, " +
                	  " dps.act_port_b port_b, dps.duty_cd dps_duty_cd,  dps.flt_num flt_num,tdp.duty_seq_num duty_seq_num, " +
                	  " dps.item_seq_num item_seq_num, tdp.str_dt_tm_gmt skj_sd, " +
                	  " CASE WHEN To_Date('"+sdate+"','yyyy/mm/dd') > dps.act_str_dt_tm_gmt " +
                	  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                	  " CASE WHEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') < dps.act_end_dt_tm_gmt  " +
                	  " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed, " +
                	  " CASE WHEN To_Date('"+sdate+"','yyyy/mm/dd') > tdp.act_str_dt_tm_gmt " +
                	  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE tdp.act_str_dt_tm_gmt END act_rpt, " +
                	  " CASE WHEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') < tdp.act_end_dt_tm_gmt " +
                	  " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE tdp.act_end_dt_tm_gmt END act_rls, " +
                	  " tdp.overnight_ind overnight_ind, r.staff_num staff_num, r.duty_cd r_duty_cd " +
                	  " FROM fzdb.trip_duty_prd_v tdp , roster_v r, duty_prd_seg_v dps " +
                	  " WHERE (tdp.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                	  " OR (tdp.act_end_dt_tm_gmt-1/24)  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                	  " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                	  " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                	  " AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                	  " OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                	  " AND tdp.series_num = r.series_num  AND tdp.series_num = dps.series_num " +
                	  " AND dps.delete_ind = 'N'  AND r.delete_ind='N' AND tdp.delete_ind = 'N' AND tdp.fd_ind = 'N'  " +
                	  " AND dps.duty_seq_num =tdp.duty_seq_num   AND dps.item_seq_num='1' AND r.staff_num ='"+empno+"' " +
                	  " ) ORDER BY act_sd ";
                
//                  System.out.println(sql);
                  rs = stmt.executeQuery(sql);        
                  while(rs.next())
                  {
                      ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                      if(obj!=null)
                      {
                          if(!"LO".equals(rs.getString("dps_duty_cd")) && !"RST".equals(rs.getString("dps_duty_cd")))
                          {   
                              obj.setTod_start_loc_ds(rs.getString("tod_start_loc_ds"));
                              obj.setPort_a(rs.getString("port_a"));
                              obj.setPort_b(rs.getString("port_b"));    
                              obj.setDps_duty_cd(rs.getString("dps_duty_cd"));
//                              System.out.println(obj.getDps_duty_cd());
                              obj.setFlt_num(rs.getString("flt_num"));
                              obj.setSkj_sd(rs.getString("skj_sd"));
                              obj.setOvernight_ind(rs.getString("overnight_ind"));
                              obj.setR_duty_cd(rs.getString("r_duty_cd"));   
                              obj.setAct_rpt(rs.getString("act_rpt"));
                              obj.setAct_rls(rs.getString("act_rls"));
                              obj.setFdp_mins(rs.getString("fdp"));  
                              obj.setDp2_mins(Integer.toString(Integer.parseInt(rs.getString("grd_dp"))+Integer.parseInt(rs.getString("fdp"))+60));
                          }
                          else if ("LO".equals(rs.getString("dps_duty_cd")))
                          {
                              obj.setLo_mins(rs.getString("rst"));
                          }
                          else if ("RST".equals(rs.getString("dps_duty_cd")))
                          {
                              obj.setRp_mins(rs.getString("rst"));
                          }
                          obj.setSeries_num(rs.getString("series_num"));  
                      }
                  }
                  
                  rs.close();
                  
                  //set ft TVL 不計
                  sql = " SELECT staff_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt, series_num, Round(sum(act_ed-act_sd)*24*60,0) ft FROM ( " +
                  		" SELECT r.staff_num staff_num, " +
                  		" dps.series_num series_num , CASE WHEN dps.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  		" THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                  	    " CASE WHEN dps.act_end_dt_tm_gmt > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  	    " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed " +
                  	    " FROM roster_v r, fzdb.duty_prd_seg_v dps WHERE (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                  	    " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                  	    " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  	    " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                  	    " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  	    " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  	    " AND r.delete_ind='N' AND  dps.delete_ind = 'N' AND r.series_num = dps.series_num   " +
                  	    " AND dps.duty_cd IN ('FLY')  AND fd_ind='N' AND r.staff_num ='"+empno+"' ) " +
                  	    " GROUP BY staff_num , To_Char(act_sd,'yyyy/mm/dd'), series_num  ";
                    
//                      System.out.println(sql);
                  rs = stmt.executeQuery(sql);        
                  while(rs.next())
                  {
                      ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                      if(obj!=null)
                      {
                          obj.setFt_mins(rs.getString("ft")); 
                      }
                  }       
              
                  rs.close();
                  
                //set adjust mins  ** 加入empno的條件,response 久
              sql = " SELECT To_Char(fltd,'yyyy/mm/dd') cal_dt, to_char(Min(lin.tsa_dt),'yyyy/mm/dd hh24:mi') tsa_dt, " +
              		" Sum((dps.tod_start_loc_ds - lin.tsa_dt)*24*60) adjust_mins, r.staff_num " +
              		" FROM fztflin lin, duty_prd_seg_v dps, roster_v r " +
              		" WHERE lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
              		" AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
              		" OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
              		" AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
              		" OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
              		" AND lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
              		" AND dps.act_port_a = 'TPE' AND lin.fltno = dps.flt_num AND lin.sect = dps.port_a||dps.port_b " +
              		" AND dps.delete_ind='N' and dps.fd_ind='N' and dps.act_port_a <> dps.act_port_b " +
              		" AND r.delete_ind='N' AND r.series_num = dps.series_num " +
              	    " AND  lin.tsa_dt < dps.tod_start_loc_ds " +
              	    " AND (dps.tod_start_loc_ds - lin.tsa_dt)*24*60 >=5 AND (dps.tod_start_loc_ds - lin.tsa_dt)*24*60 <=15 " +
              	    " GROUP BY staff_num, fltd ";
                
//                  System.out.println(sql);
              rs = stmt.executeQuery(sql);        
              while(rs.next())
              {
                  ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                  if(obj!=null)
                  {
                      if(empno.equals(obj.getStaff_num()))
                      {
                          obj.setAdjust_mins(rs.getString("adjust_mins"));
                          obj.setDp_mins(Integer.toString(Integer.parseInt(obj.getDp_mins())+Integer.parseInt(obj.getAdjust_mins())));
                          obj.setFdp_mins(Integer.toString(Integer.parseInt(obj.getFdp_mins())+Integer.parseInt(obj.getAdjust_mins())));
                          obj.setTod_start_loc_ds(rs.getString("tsa_dt"));
                          obj.setAct_rpt(rs.getString("tsa_dt"));
                      }
                  }
              }       
        } 
        catch(Exception e)
        {
            System.out.println("Error : "+ e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public void getCrewFtDpByDate3(String sdate, String edate, String empno)
    {        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        this.sdate = sdate;
        this.edate = edate;        
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            
            //set check_dp,check_ft
            sql = " SELECT cc.staff_num, cb.cname, cb.sern, cb.GROUPS, cb.station, rk.rank_cd, " +
                  " To_Char(cal_dt,'yyyy/mm/dd') cal_dt,rem_fh_28 ft_mins, " +
                  " (cum_dp+act_total_dead_head_mins+act_home_stby_mins) cum_dp_mins," +
                  " non_std_fly_hours credit_mins," +
                  " act_total_dead_head_mins act_total_dead_head_mins, act_home_stby_mins act_home_stby_mins  " +
                  " from fzdb.crew_cum_hr_cc_v cc, egtcbas cb, FZDB.crew_rank_v rk " +
                  " where cal_dt between to_date('"+sdate+" 0000','yyyy/mm/dd hh24mi')  and to_date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " AND cc.staff_num = Trim(cb.empn) AND cc.staff_num = rk.staff_num " +
                  " AND cc.staff_num = '"+empno+"' AND sysdate between rk.eff_dt and NVL(rk.exp_dt,to_date('20500101','yyyymmdd')) ";
            
                System.out.println("check_dp "+sql);
//            System.out.println("check_dp,check_ft st  "+ new java.util.Date());
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    ftdpObj2 obj = new ftdpObj2();                    
                    obj.setStaff_num(rs.getString("staff_num"));  
                    obj.setCname(rs.getString("cname"));                    
                    obj.setSern(rs.getString("sern"));
                    obj.setGrp(rs.getString("groups"));    
                    obj.setBase(rs.getString("station"));
                    obj.setRank(rs.getString("rank_cd"));
                    obj.setCal_dt(rs.getString("cal_dt"));
                    obj.setCheck_dp(rs.getString("cum_dp_mins"));  
                    obj.setAct_home_stby_mins(rs.getString("act_home_stby_mins"));
                    obj.setAct_total_dead_head_mins(rs.getString("act_total_dead_head_mins"));
                    obj.setCheck_ft(rs.getString("ft_mins"));
                    objHT.put(obj.getCal_dt(),obj);
                }
                rs.close();
//             System.out.println("check_dp,check_ft ed  "+ new java.util.Date());
//             System.out.println("set ft st  "+ new java.util.Date());
              //set ft 只計FLY , TVL 不計      
                sql = " SELECT staff_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt, Round(sum(act_ed-act_sd)*24*60,0) ft FROM ( " +
                      " SELECT r.staff_num staff_num, " +
                      " dps.series_num series_num , CASE WHEN dps.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') " +
                      " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                      " CASE WHEN dps.act_end_dt_tm_gmt > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                      " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed " +
                      " FROM roster_v r, fzdb.duty_prd_seg_v dps WHERE (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10 " +
                      " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10 OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10 " +
                      " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10) " +
                      " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                      " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                      " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                      " AND r.delete_ind='N' AND  dps.delete_ind = 'N' AND r.series_num = dps.series_num   " +
                      " AND dps.duty_cd ='FLY'  AND fd_ind='N' AND r.staff_num ='"+empno+"' ) " +
                      " GROUP BY staff_num , To_Char(act_sd,'yyyy/mm/dd') ";
                  
//                System.out.println("FLY "+sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                    if(obj!=null)
                    {
                        obj.setFt_mins(rs.getString("ft")); 
                    }
                }       
            
                rs.close();
                
//              System.out.println("set ft ed  "+ new java.util.Date());
//              System.out.println("set fltno/port st  "+ new java.util.Date());
              //set fltno/port 
                sql = " SELECT staff_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt,  act_port_a, act_port_b, " +
                	  " duty_cd, flt_num FROM ( " +
                	  " SELECT r.staff_num staff_num,  CASE WHEN dps.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') " +
                      " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                      " CASE WHEN dps.act_end_dt_tm_gmt > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                      " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed, " +
                      " act_port_a, act_port_b, dps.duty_cd, " +
                      " CASE WHEN dps.duty_cd IN ('FLY','TVL') THEN dps.flt_num ELSE dps.duty_cd END flt_num " +
                      " FROM roster_v r, fzdb.duty_prd_seg_v dps " +
                      " WHERE (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10 " +
                      " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10 OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10 " +
                      " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10) " +
                      " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                      " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                      " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                      " AND r.delete_ind='N' AND  dps.delete_ind = 'N' AND r.series_num = dps.series_num   " +
                      " AND fd_ind='N' AND r.staff_num ='"+empno+"' ) ORDER BY act_sd ";
                  
//                System.out.println("set fltno/port  "+sql);
                rs = stmt.executeQuery(sql);        
                while(rs.next())
                {
                    ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                    if(obj!=null)
                    {
                        if((obj.getFlt_num() == null || "".equals(obj.getFlt_num())) && !"LO".equals(rs.getString("duty_cd")) && !"RST".equals(rs.getString("duty_cd")))
                        {      
                            if("FLY".equals(rs.getString("duty_cd")) | "TVL".equals(rs.getString("duty_cd")))
                            {
                                obj.setFlt_num(rs.getString("flt_num"));
                            }
                            else if(!"RST".equals(rs.getString("duty_cd")) | "LO".equals(rs.getString("duty_cd")))
                            {
                                obj.setFlt_num(rs.getString("duty_cd"));
                            }
                            obj.setPort_a(rs.getString("act_port_a"));
                            obj.setPort_b(rs.getString("act_port_b"));                            
                        }
                    }
                } 
                rs.close();
                
//                System.out.println("set fltno/port ed  "+ new java.util.Date());
//                System.out.println("set fdp st "+ new java.util.Date());
                //Set fdp
                ArrayList fdpAL = new ArrayList();
                fdpAL = getCal_fdpAL(sdate, edate, empno);
                if(fdpAL.size()>0)
                {
                    for(int i=0; i< fdpAL.size(); i++)
                    {
                        ftdpObj3 fdpobj = (ftdpObj3) fdpAL.get(i);
//                        System.out.println(fdpobj.getCal_dt()+"/"+fdpobj.getCal_st()+"/"+fdpobj.getCal_ed());
                        
                        if(!"TVLTVL".equals(fdpobj.getCnt_str()))
                        {
                            ftdpObj2 obj = (ftdpObj2) objHT.get(fdpobj.getCal_dt());
                            if(obj!=null)
                            {                        
                                obj.setFdp_mins(TimeUtil.differenceOfTwoDate(fdpobj.getCal_st(), fdpobj.getCal_ed())); 
                            }
                        }
                    }
                }
//                System.out.println("@@@");
//                System.out.println("set fdp ed "+ new java.util.Date());
//                System.out.println("set dp st "+ new java.util.Date());
                //Set dp
                ArrayList dpAL = new ArrayList();
                dpAL = getCal_dpAL(sdate, edate, empno);
                if(dpAL.size()>0)
                {
                    for(int i=0; i< dpAL.size(); i++)
                    {
                        ftdpObj3 dpobj = (ftdpObj3) dpAL.get(i);
//                        System.out.println(dpobj.getCal_dt()+"/"+dpobj.getFlt_num()+"/"+dpobj.getCal_st()+"/"+dpobj.getCal_ed());
//                        System.out.println(dpobj.getFlt_num()+"*");
                       
                        ftdpObj2 obj = (ftdpObj2) objHT.get(dpobj.getCal_dt());
                        if(obj!=null)
                        {                        
                            obj.setDp_mins(TimeUtil.differenceOfTwoDate(dpobj.getCal_st(), dpobj.getCal_ed()));
                            obj.setCal_sdate(dpobj.getCal_st());
                            obj.setCal_edate(dpobj.getCal_ed());
//                            System.out.println(obj.getFlt_num()+"#");
                            if(!"".equals(dpobj.getFlt_num()) && dpobj.getFlt_num()!=null)
                            {
                                obj.setFlt_num(dpobj.getFlt_num());
//                                System.out.println(obj.getFlt_num());
                            }
                        }
                    }
                }
//                System.out.println("###");
//                System.out.println("set dp et "+ new java.util.Date());
//                System.out.println("set LO/RST st "+ new java.util.Date());
                //set LO/RST
                  sql = " SELECT staff_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt, Round(sum(act_ed-act_sd)*24*60,0) rst FROM ( " +
                        " SELECT r.staff_num staff_num, " +
                        " dps.series_num series_num , CASE WHEN dps.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') " +
                        " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                        " CASE WHEN dps.act_end_dt_tm_gmt > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                        " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed " +
                        " FROM roster_v r, fzdb.duty_prd_seg_v dps WHERE (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                        " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') OR r.end_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                        " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                        " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                        " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                        " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                        " AND r.delete_ind='N' AND  dps.delete_ind = 'N' AND r.series_num = dps.series_num   " +
                        " AND dps.duty_cd IN ('RST','LO')  AND fd_ind='N' AND r.staff_num ='"+empno+"' ) " +
                        " GROUP BY staff_num , To_Char(act_sd,'yyyy/mm/dd')  ";
                    
//                      System.out.println("LO/RST "+sql);
                  rs = stmt.executeQuery(sql);        
                  while(rs.next())
                  {
                      ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                      if(obj!=null)
                      {                          
                          obj.setRp_mins(rs.getString("rst")) ;
                      }
                  }                     
                  rs.close();   
                  
//                  System.out.println("set LO/RST ed "+ new java.util.Date());
//                  System.out.println("set adjust st "+ new java.util.Date());
                  //set adjust mins  ** 加入empno的條件,response 久
//                  sql = " SELECT To_Char(act_str_dt_tm_gmt,'yyyy/mm/dd') cal_dt, to_char(Min(lin.tsa_dt),'yyyy/mm/dd hh24:mi') tsa_dt, " +
//                        " Sum((dps.tod_start_loc_ds - lin.tsa_dt)*24*60) adjust_mins, r.staff_num " +
//                        " FROM fztflin lin, duty_prd_seg_v dps, roster_v r " +
//                        " WHERE lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                        " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                        " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
//                        " AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                        " OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
//                        " AND lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
//                        " AND dps.act_port_a = 'TPE' AND lin.fltno = dps.flt_num AND lin.sect = dps.port_a||dps.port_b " +
//                        " AND dps.delete_ind='N' and dps.fd_ind='N' and dps.act_port_a <> dps.act_port_b " +
//                        " AND r.delete_ind='N' AND r.series_num = dps.series_num  and r.staff_num ='"+empno+"' " +
//                        " AND  lin.tsa_dt < dps.tod_start_loc_ds " +
//                        " AND (dps.tod_start_loc_ds - lin.tsa_dt)*24*60 >=5 AND (dps.tod_start_loc_ds - lin.tsa_dt)*24*60 <=15 " +
//                        " GROUP BY staff_num, To_Char(act_str_dt_tm_gmt,'yyyy/mm/dd') ";
                    
                  sql = " SELECT To_Char(act_str_dt_tm_gmt,'yyyy/mm/dd') cal_dt, " +
                  		" to_char(Min(lin.tsa_dt),'yyyy/mm/dd hh24:mi') tsa_dt, " +
                  		" Sum((crews.tod_start_loc_ds - lin.tsa_dt)*24*60) adjust_mins, staff_num " +
                  		" FROM fztflin lin, ( SELECT r.staff_num staff_num, dps.tod_start_loc_ds tod_start_loc_ds, " +
                  		" dps.act_str_dt_tm_gmt, dps.port_a||dps.port_b  sect , dps.flt_num flt_num " +
                  		" FROM duty_prd_seg_v dps, roster_v r " +
                  		" WHERE (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  		" OR  dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  		" AND (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  		" OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  	    " AND dps.act_port_a = 'TPE'  AND r.series_num = dps.series_num  and r.staff_num ='"+empno+"' " +
                  	    " AND dps.delete_ind='N' and dps.fd_ind='N' AND r.delete_ind='N' " +
                  	    " and dps.act_port_a <> dps.act_port_b  )  crews " +
                  	    " WHERE lin.fltd BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  	    " AND lin.fltno = crews.flt_num  AND lin.sect = crews.sect " +
                  	    " AND  lin.tsa_dt < crews.tod_start_loc_ds  " +
                  	    " AND lin.tsa_dt BETWEEN crews.tod_start_loc_ds -(15/(24*60)) AND crews.tod_start_loc_ds - (5/(24*60)) " +
                  	    " GROUP BY staff_num, To_Char(act_str_dt_tm_gmt,'yyyy/mm/dd') ";
                  
//                      System.out.println(sql);
                  rs = stmt.executeQuery(sql);        
                  while(rs.next())
                  {
                      ftdpObj2 obj = (ftdpObj2) objHT.get(rs.getString("cal_dt"));
                      if(obj!=null)
                      {
                          obj.setAdjust_mins(rs.getString("adjust_mins"));
                      }
                  }   
                  
//                  System.out.println("set adjust ed "+ new java.util.Date());
        } 
        catch(Exception e)
        {
            System.out.println("Error : "+ e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    
    public ArrayList getCal_fdpAL(String sdate, String edate, String empno)
    {        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        this.sdate = sdate;
        this.edate = edate;        
        ArrayList cal_objAL = new ArrayList();
        ArrayList fdpAL = new ArrayList();
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
                
            //set cal_sd/cal_ed
            sql = " SELECT series_num, staff_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt,  " +
                  " To_Char(tpe_rpt,'yyyymmddhh24mi') tpe_rpt, To_Char(out_rpt,'yyyymmddhh24mi') out_rpt, " +
                  " To_Char(act_sd,'yyyymmddhh24mi') act_sd, To_Char(act_ed,'yyyymmddhh24mi') act_ed, " +
                  " To_Char(tpe_rls,'yyyymmddhh24mi') tpe_rls, act_port_a, act_port_b, duty_cd, flt_num, " +
                  " duty_seq_num, item_seq_num FROM ( " +
                  " SELECT dps.series_num , r.staff_num staff_num,  " +
                  " CASE WHEN dps.tod_start_loc_ds < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.tod_start_loc_ds END tpe_rpt, " +
                  " CASE WHEN dps.act_str_dt_tm_gmt-(1/24) < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt-(1/24) END out_rpt, " +
                  " CASE WHEN dps.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                  " CASE WHEN dps.act_end_dt_tm_gmt > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed, " +
                  " CASE WHEN dps.act_end_dt_tm_gmt+(1/24) > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt+(1/24) END tpe_rls, " +
                  " act_port_a, act_port_b, dps.duty_cd, " +
                  " CASE WHEN dps.duty_cd IN ('FLY','TVL') THEN dps.flt_num ELSE dps.duty_cd END flt_num, " +
                  " duty_seq_num, item_seq_num, dps.act_str_dt_tm_gmt act_str_dt_tm_gmt " +
                  " FROM roster_v r, fzdb.duty_prd_seg_v dps " +
                  " WHERE (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10  " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10 " +
                  " OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10  " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10) " +
                  " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')  " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  " AND r.delete_ind='N' AND  dps.delete_ind = 'N' AND r.series_num  = dps.series_num " +
                  " AND fd_ind='N' AND r.staff_num ='"+empno+"' ) ORDER BY act_str_dt_tm_gmt ";
              
//            System.out.println("getCal_fdpAL "+sql);
            ftdpObj3 dummyobj = new ftdpObj3();
            cal_objAL.add(dummyobj); 
            rs = stmt.executeQuery(sql);        
            while(rs.next())
            {
                ftdpObj3 obj = new ftdpObj3();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setCal_dt(rs.getString("cal_dt"));
                obj.setStaff_num(rs.getString("staff_num"));
                obj.setTpe_rpt(rs.getString("tpe_rpt"));
                obj.setOut_rpt(rs.getString("out_rpt"));
                obj.setAct_sd(rs.getString("act_sd"));
                obj.setAct_ed(rs.getString("act_ed"));
                obj.setAct_port_a(rs.getString("act_port_a"));
                obj.setAct_port_a(rs.getString("act_port_b"));                    
                obj.setTpe_rls(rs.getString("tpe_rls"));
                obj.setDuty_cd(rs.getString("duty_cd"));
                obj.setFlt_num(rs.getString("flt_num"));
                obj.setDuty_seq_num(rs.getString("duty_seq_num"));
                obj.setItem_seq_num(rs.getString("item_seq_num"));
                cal_objAL.add(obj);                   
            }       
            cal_objAL.add(dummyobj);               
            
            ftdpObj3 fdpobj = null;
            for(int i=1; i<cal_objAL.size()-1; i++)
            {
                ftdpObj3 aobj = (ftdpObj3) cal_objAL.get(i-1);
                ftdpObj3 obj = (ftdpObj3) cal_objAL.get(i);
                ftdpObj3 bobj = (ftdpObj3) cal_objAL.get(i+1);
                
                if((!obj.getSeries_num().equals(aobj.getSeries_num()) | "RST".equals(aobj.getDuty_cd()) | "LO".equals(aobj.getDuty_cd()) | "1".equals(obj.getItem_seq_num())) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {//
                    fdpobj = new ftdpObj3();                    
                }
                //set cal_st
                if("1".equals(obj.getDuty_seq_num()) && "1".equals(obj.getItem_seq_num()) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {
                    fdpobj.setCal_dt(obj.getCal_dt());
                    fdpobj.setCal_st(obj.getTpe_rpt());      
                    fdpobj.setCnt_str(fdpobj.getCnt_str()+obj.getDuty_cd());
                }
                else if("1".equals(obj.getItem_seq_num()) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {
                    fdpobj.setCal_dt(obj.getCal_dt());
                    fdpobj.setCal_st(obj.getOut_rpt());   
                    fdpobj.setCnt_str(fdpobj.getCnt_str()+obj.getDuty_cd());
                }
                
                //set cal_ed
                if("TVL".equals(obj.getDuty_cd()) && "FLY".equals(aobj.getDuty_cd()) && !"1".equals(obj.getItem_seq_num()))
                {
                    fdpobj.setCal_ed(aobj.getAct_ed());      
                    fdpobj.setCnt_str(fdpobj.getCnt_str()+obj.getDuty_cd());
                    fdpAL.add(fdpobj);
                }
                else if(("99".equals(bobj.getDuty_seq_num()) | !obj.getSeries_num().equals(bobj.getSeries_num()) | "1".equals(bobj.getItem_seq_num())) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {
                    fdpobj.setCal_ed(obj.getAct_ed());      
                    fdpobj.setCnt_str(fdpobj.getCnt_str()+obj.getDuty_cd());
                    fdpAL.add(fdpobj);
                }
            }
              
        } 
        catch(Exception e)
        {
            System.out.println("Error : "+ e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
        return fdpAL;
    }
    
    public ArrayList getCal_dpAL(String sdate, String edate, String empno)
    {        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        this.sdate = sdate;
        this.edate = edate;        
        ArrayList cal_objAL = new ArrayList();
        ArrayList dpAL = new ArrayList();
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
                
            //set cal_sd/cal_ed
            sql = " SELECT series_num, staff_num, To_Char(act_sd,'yyyy/mm/dd') cal_dt,  " +
                  " To_Char(tpe_rpt,'yyyymmddhh24mi') tpe_rpt, To_Char(out_rpt,'yyyymmddhh24mi') out_rpt, " +
                  " To_Char(act_sd,'yyyymmddhh24mi') act_sd, To_Char(act_ed,'yyyymmddhh24mi') act_ed, " +
                  " To_Char(tpe_rls,'yyyymmddhh24mi') tpe_rls, act_port_a, act_port_b, duty_cd, flt_num, " +
                  " duty_seq_num, item_seq_num FROM ( " +
                  " SELECT dps.series_num , r.staff_num staff_num,  " +
                  " CASE WHEN dps.tod_start_loc_ds < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.tod_start_loc_ds END tpe_rpt, " +
                  " CASE WHEN dps.act_str_dt_tm_gmt-(1/24) < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt-(1/24) END out_rpt, " +
                  " CASE WHEN dps.act_str_dt_tm_gmt < To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " THEN To_Date('"+sdate+"','yyyy/mm/dd') ELSE dps.act_str_dt_tm_gmt END act_sd, " +
                  " CASE WHEN dps.act_end_dt_tm_gmt > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt END act_ed, " +
                  " CASE WHEN dps.act_end_dt_tm_gmt+(1/24) > To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " THEN To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') ELSE dps.act_end_dt_tm_gmt+(1/24) END tpe_rls, " +
                  " act_port_a, act_port_b, dps.duty_cd, " +
                  " CASE WHEN dps.duty_cd IN ('FLY','TVL') THEN dps.flt_num ELSE dps.duty_cd END flt_num, " +
                  " duty_seq_num, item_seq_num, dps.act_str_dt_tm_gmt act_str_dt_tm_gmt " +
                  " FROM roster_v r, fzdb.duty_prd_seg_v dps " +
                  " WHERE (r.str_dt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10  " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10 " +
                  " OR r.end_dt BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')-10  " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')+10) " +
                  " AND (dps.act_str_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd')  " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +
                  " OR dps.act_end_dt_tm_gmt  BETWEEN To_Date('"+sdate+"','yyyy/mm/dd') " +
                  " AND To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')) " +
                  " AND r.delete_ind='N' AND  dps.delete_ind = 'N' AND r.series_num  = dps.series_num " +
                  " AND fd_ind='N' AND r.staff_num ='"+empno+"' ) ORDER BY act_str_dt_tm_gmt ";
              
//            System.out.println("getCal_dpAL "+sql);
            ftdpObj3 dummyobj = new ftdpObj3();
            cal_objAL.add(dummyobj); 
            rs = stmt.executeQuery(sql);        
            while(rs.next())
            {
                ftdpObj3 obj = new ftdpObj3();
                obj.setSeries_num(rs.getString("series_num"));
                obj.setCal_dt(rs.getString("cal_dt"));
                obj.setStaff_num(rs.getString("staff_num"));
                obj.setTpe_rpt(rs.getString("tpe_rpt"));
                obj.setOut_rpt(rs.getString("out_rpt"));
                obj.setAct_sd(rs.getString("act_sd"));
                obj.setAct_ed(rs.getString("act_ed"));
                obj.setAct_port_a(rs.getString("act_port_a"));
                obj.setAct_port_a(rs.getString("act_port_b"));                    
                obj.setTpe_rls(rs.getString("tpe_rls"));
                obj.setDuty_cd(rs.getString("duty_cd"));
                obj.setFlt_num(rs.getString("flt_num"));
                obj.setDuty_seq_num(rs.getString("duty_seq_num"));
                obj.setItem_seq_num(rs.getString("item_seq_num"));
                cal_objAL.add(obj);                   
            }       
            cal_objAL.add(dummyobj);               
            //*******************************************************************
            ftdpObj3 dpobj = null;
            for(int i=1; i<cal_objAL.size()-1; i++)
            {                
                ftdpObj3 aobj = (ftdpObj3) cal_objAL.get(i-1);
                ftdpObj3 obj = (ftdpObj3) cal_objAL.get(i);
                ftdpObj3 bobj = (ftdpObj3) cal_objAL.get(i+1);
                
                if((!obj.getSeries_num().equals(aobj.getSeries_num()) | "RST".equals(aobj.getDuty_cd()) | "LO".equals(aobj.getDuty_cd()) | "1".equals(obj.getItem_seq_num())) && (!"LO".equals(obj.getDuty_cd()) && !"RST".equals(obj.getDuty_cd())))
                {//
                    dpobj = new ftdpObj3();      
//                    System.out.println("getFlt_num "+obj.getFlt_num());
                }
                //set cal_st
                if("1".equals(obj.getDuty_seq_num()) && "1".equals(obj.getItem_seq_num()) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {
                    dpobj.setCal_dt(obj.getCal_dt());
                    dpobj.setCal_st(obj.getTpe_rpt());   
//                    System.out.println("getFlt_num "+obj.getFlt_num());
                }
                else if("1".equals(obj.getItem_seq_num()) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {
                    dpobj.setCal_dt(obj.getCal_dt());
                    dpobj.setCal_st(obj.getOut_rpt());   
//                    System.out.println("getFlt_num "+obj.getFlt_num());
                }
                else if("1".equals(obj.getItem_seq_num()) && (!"LO".equals(obj.getDuty_cd()) && !"RST".equals(obj.getDuty_cd()) && !"ADO".equals(obj.getDuty_cd()) && !"TVL".equals(obj.getDuty_cd()) && !"FLY".equals(obj.getDuty_cd())))
                {
                    dpobj.setCal_dt(obj.getCal_dt());
                    dpobj.setCal_st(obj.getAct_sd());   
//                    dpobj.setFlt_num(aobj.getFlt_num()+"/"+obj.getFlt_num());
//                    System.out.println("*dpobj.getFlt_num "+dpobj.getFlt_num()+"#obj.getFlt_num() "+obj.getFlt_num());
                }
                
                //set cal_ed
                if(("99".equals(bobj.getDuty_seq_num()) | "RST".equals(bobj.getDuty_cd()) | "LO".equals(bobj.getDuty_cd()) | !obj.getSeries_num().equals(bobj.getSeries_num()) | "1".equals(bobj.getItem_seq_num())) && ("TVL".equals(obj.getDuty_cd()) | "FLY".equals(obj.getDuty_cd())))
                {
                    dpobj.setCal_ed(obj.getTpe_rls()); 
                    dpAL.add(dpobj);
//                    System.out.println(dpobj.getCal_dt()+"/"+dpobj.getFlt_num()+"/"+dpobj.getCal_st()+"/"+dpobj.getCal_ed());
//                    System.out.println("getFlt_num  end "+obj.getFlt_num());
                }
                else if(("99".equals(bobj.getDuty_seq_num()) | !obj.getSeries_num().equals(bobj.getSeries_num()) | "1".equals(bobj.getItem_seq_num())) && (!"LO".equals(obj.getDuty_cd()) && !"RST".equals(obj.getDuty_cd()) && !"ADO".equals(obj.getDuty_cd()) && !"TVL".equals(obj.getDuty_cd()) && !"FLY".equals(obj.getDuty_cd())))
                {
//                    System.out.println("getFlt_num  end "+obj.getFlt_num());
                    dpobj.setCal_ed(obj.getAct_ed()); 
                    if(!"RST".equals(aobj.getFlt_num()))
                    {
                        //一天有兩個地面任務
                        dpobj.setFlt_num(aobj.getFlt_num()+"/"+obj.getFlt_num());
                    }
                    dpAL.add(dpobj);
//                    System.out.println(dpobj.getCal_dt()+"/"+dpobj.getFlt_num()+"/"+dpobj.getCal_st()+"/"+dpobj.getCal_ed());
//                    System.out.println(dpobj.getCal_dt()+ "* dpobj.getFlt_num "+dpobj.getFlt_num());
                }
            }
//            System.out.println(dpAL.size());
              
        } 
        catch(Exception e)
        {
            System.out.println("Error : "+ e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
        return dpAL;
    }
    
//    public void calcRptRlsMins() //yyyy/mm/dd hh24:mi  return mins
//    {    
//        Connection conn = null;
//        Statement stmt = null;
//        ResultSet rs = null;
//        
//        try
//        {
//            for(int i=0; i<objAL.size(); i++)
//            {           
//                ftdpObj obj = (ftdpObj) objAL.get(i);  
//                //計算該日期區間內TVL+FLY report+release 
//                sql=" select Nvl(sum(case when dps.duty_seq_num =1 then 200 else 120 end),0) report_release_min  " +
//                    " from duty_prd_seg_v dps, roster_v r " +
//                    " where dps.delete_ind='N' and r.delete_ind='N' and dps.series_num=r.series_num  " +
//                    " and dps.item_seq_num='1' " +
//                    " and dps.fd_ind='N' and dps.duty_cd in ('FLY','TVL') " +
//                    " and dps.str_dt_tm_gmt " +
//                    " between to_date('"+sdate+" 0000','yyyy/mm/dd hh24mi') " + 
//                    " and to_date('"+edate+" 2359','yyyy/mm/dd hh24mi') " +                    
//                    " and r.staff_num='" + obj.getStaff_num() + "' "; 
//                
//                rs = stmt.executeQuery(sql);        
//                if(rs.next())
//                {
//                    
//                }
//                
//                
//            }  
//        } 
//        catch(Exception e)
//        {
//            System.out.println("Error : "+ e.toString());
//        }
//        finally
//        {
//            try{if(rs != null) rs.close();}catch(SQLException e){}
//            try{if(stmt != null) stmt.close();}catch(SQLException e){}
//            try{if(conn != null) conn.close();}catch(SQLException e){}
//        }
//    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }

    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }

    public String getSql()
    {
        return sql;
    }

    public void setSql(String sql)
    {
        this.sql = sql;
    }
    
    public Hashtable getObjHT()
    {
        return objHT;
    }
    
    public String getErrorstr() {
		return errorstr;
	}

	public void setErrorstr(String errorstr) {
		this.errorstr = errorstr;
	}
    
    
    
    
}