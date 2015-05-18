package eg.off;

import java.sql.*;
import java.text.*;
import java.util.*;

import eg.*;
import ci.db.*;

/**
 * @author cs71 Created on 2007/4/4
 * cs80 2012/12/25
 * CS80 2014/07/22 WL->六個月
 * cs80  2014/11/18 NB 限制,LSW < 67hrs 需補班 
 */
public class LeaveRules
{   
    private String sql = null;
    private String empno = "";
    private String offsdate = "";
    private String offedate = "";
    private String offtype = "";
    private String duty = "";
    private String series_num = "";
    private String userid = "";
    private String occurdate = ""; 
    private String relation = "";
    private String first_event_date = "";
    private int days =0;
    OffsObj obj = new OffsObj();

    public static void main(String[] args)
    {
//        LeaveRules arc = new LeaveRules("633836", "2012/12/22", "2012/12/22","27","0130","SYSTEM");/*補班日報LSW*/
//        System.out.println(arc.ifLSWOKDate());
        LeaveRules arc = new LeaveRules("641635", "2015/07/18", "2015/07/19","2","2015/04/11","15","","SYSTEM");
//        System.out.println(arc.isWithinMaxDays());
//        System.out.println(arc.isValidSubmitTime());
//        System.out.println(arc.lswFullAttendanceCheck());
//        System.out.println(arc.lswQuotaCheck());
//        System.out.println(arc.ifLSWOKDate());
        
//        System.out.println(arc.isValidSubmitTime2());
//        System.out.println(arc.isWithinMaxDays2());
//        System.out.println(arc.isValidSubmitTime());
//        System.out.println(arc.isValidSubmitTime2());        
//        System.out.println(arc.hasUL());
//        System.out.println(arc.isNotDuplicated());
//        System.out.println(arc.hasUnHandle());
        System.out.println(arc.isWithinMaxDays());        
//        System.out.println(arc.reAssign());
//       System.out.println("1 "+arc.needDoc());
//       System.out.println("2 "+arc.needDoc());
//       OffsObj obj = arc.getObj();
//       System.out.println("3 "+obj.getDoc_status());       
//        System.out.println(arc.hasSkj());
//        System.out.println(arc.chkContinues());
        System.out.println("Done");
    }
       
    public LeaveRules (String offsdate)
    {
        this.offsdate = offsdate;
    }
    //offftype like 0,1,2,3........
    //duty like S1, 067
    public LeaveRules (String empno, String offsdate, String offedate, String offtype, String duty, String userid)
    {
        this.empno = GetEmpno.getEmpno(empno);
        obj.setEmpn(empno);
        this.offsdate = offsdate;
        obj.setOffsdate(offsdate);
        this.offedate = offedate;
        obj.setOffedate(offedate);
        this.duty = duty;  
        obj.setOffftno(duty);
        this.offtype = offtype;
        obj.setOfftype(offtype);
        this.userid = userid;
        obj.setNewuser(userid);
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        try
        {       
            
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            //get data from egtalco, egtcbas, hrvegemploy
            sql = " SELECT cbas.empn empno, cbas.sern sern, cbas.station base, " +
                  " (to_date('" + offedate + "', 'yyyy/mm/dd') - to_date('"+ offsdate + "', 'yyyy/mm/dd'))+1 offdays " +
                  " FROM egtcbas cbas WHERE cbas.empn = '" + empno + "' " ;                

//System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                obj.setOffdays(rs.getString("offdays"));
                obj.setSern(rs.getString("sern"));
                obj.setStation(rs.getString("base"));
                obj.setRank(GetJobType.getEmpJobType(empno));
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {

            System.out.println(e.toString());
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    
    //offftype like 0,1,2,3........
    //duty like S1, 067
    public LeaveRules (String empno, String offsdate, String offedate, String offtype, String occurdate, String relation, String duty, String userid)
    {
        this.empno = GetEmpno.getEmpno(empno);
        obj.setEmpn(empno);
        this.offsdate = offsdate;
        obj.setOffsdate(offsdate);
        this.offedate = offedate;
        obj.setOffedate(offedate);
        this.duty = duty;  
        obj.setOffftno(duty);
        this.offtype = offtype;
        obj.setOfftype(offtype);
        this.userid = userid;
        obj.setNewuser(userid);
        this.occurdate = occurdate;
        obj.setOccur_date(occurdate);
        this.relation = relation;
        obj.setRelation(relation);
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            //get data from egtalco, egtcbas, hrvegemploy
            sql = " SELECT cbas.empn empno, cbas.sern sern, cbas.station base, " +
                  " (to_date('" + offedate + "', 'yyyy/mm/dd') - to_date('"+ offsdate + "', 'yyyy/mm/dd'))+1 offdays " +
                  " FROM egtcbas cbas WHERE cbas.empn = '" + empno + "' " ;                

//System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                obj.setOffdays(rs.getString("offdays"));
                obj.setSern(rs.getString("sern"));
                obj.setStation(rs.getString("base"));
                obj.setRank(GetJobType.getEmpJobType(empno));
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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


    //  Crew 是否為可遞單時間
    public String isValidSubmitTime()
    {//有班表者,皆需依報到時間規則請假
     //依原任務reporting time 判斷需要請一天或二天     
        
        String str = "";//是否已過當天請假時間
        String str2 = "";//請假最後一天必須大於等於今天
        String begin_time = "";
        String deadline = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        try
        {
//            Class.forName("oracle.jdbc.driver.OracleDriver");
//            conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:orp3","fzw2","xns72fs9kf");
//            stmt = conn.createStatement();
            
//            ConnDB cn = new ConnDB();        
//            cn.setAOCIPROD();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();            
            
            ConnDB cn = new ConnDB();             
            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            //******************************************************************************
            sql = " SELECT staff_num, duty_cd, str_dt_tm_gmt, checkin_time, to_char(begin_time,'yyyy/mm/dd hh24:mi') begin_time, " +
                  " to_char(deadline,'yyyy/mm/dd hh24:mi') deadline, series_num, " +
                  " CASE WHEN Trunc(SYSDATE,'mi') BETWEEN begin_time AND deadline THEN 'Y' " +
                  //*********************************
                  " WHEN ( To_Date('"+offsdate+"','yyyy/mm/dd') > SYSDATE AND Trunc(SYSDATE,'mi') BETWEEN Trunc(SYSDATE,'dd') AND deadline) THEN 'Y' " +
                  //************************************
                  " ELSE 'N' END  flag, CASE WHEN To_Date('"+offedate+" 1630','yyyy/mm/dd hh24mi') < SYSDATE THEN 'N' ELSE 'Y' END flag2 " +
                  " from ( " +
                  "     select r.duty_cd  duty_cd, dps.str_dt_tm_gmt str_dt_tm_gmt, dps.tod_start_loc_ds checkin_time, " +
                          // start time of available to submit 
                  "       To_Date(to_char(dps.tod_start_loc_ds,'yyyy/mm/dd')||' 00:00','yyyy/mm/dd hh24:mi') begin_time, " +
                          // report time <= 17:00, deadline is today's 17:00 else next day's 12:00
                          // report time <= 16:30, deadline is today's 16:30 else next day's 12:00
                  "       CASE WHEN dps.tod_start_loc_ds <= To_Date(to_char(dps.tod_start_loc_ds,'yyyy/mm/dd')||' 16:30','yyyy/mm/dd hh24:mi') " +
                  "       then To_Date(to_char(dps.tod_start_loc_ds,'yyyy/mm/dd')||' 16:30','yyyy/mm/dd hh24:mi') ELSE  " +
                  "       To_Date(to_char(dps.tod_start_loc_ds+1,'yyyy/mm/dd')||' 12:00','yyyy/mm/dd hh24:mi') END deadline, " +
                  "       r.staff_Num staff_Num, dps.delete_ind  delete_ind1, r.delete_ind delete_ind2, " +
                  "       dps.flt_num flt_num, r.pub_dt_tm  pub_dt_tm, dps.series_num series_num " +
                  "     from duty_prd_seg_v dps, roster_v r " +
                  "     where dps.series_num = r.series_num " +
                  "       AND (dps.flt_num=LPad('"+duty+"',4,0) OR dps.flt_num='0' OR dps.flt_num='"+duty+"') " +
                  "       and r.staff_num='"+empno+"' and r.delete_ind='Y' AND dps.port_a in ('"+obj.getStation()+"','TSA') " +
                  // 20091109 修改為以報到時間為主
                  "       and dps.tod_start_loc_ds between to_date('"+offsdate+" 0000','yyyy/mm/dd hh24mi') " +
                  "       and to_date('"+offsdate+" 2359','yyyy/mm/dd hh24mi') " +
//                "       and dps.act_str_dt_tm_gmt between to_date('"+offsdate+" 0000','yyyy/mm/dd hh24mi')-1 " +
//                "       and to_date('"+offsdate+" 2359','yyyy/mm/dd hh24mi') " +
                  "       order by rownum DESC ) a " +
                  " where rownum=1 ";

//            System.out.println(sql);
         
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                str = rs.getString("flag").trim();
                str2 = rs.getString("flag2").trim();
                begin_time = rs.getString("begin_time");
                deadline = rs.getString("deadline");
                series_num = rs.getString("series_num");                
            }
            //******************************************************************************
            //need the series_num to adjudge if need reAssign
            //***********************************************
            reAssign();
            //***********************************************
//            System.out.println(str);
//            System.out.println(obj.getOffdays());
            //no match record
            if ("N".equals(str) && Integer.parseInt(obj.getOffdays()) <=1)
            {
                return "已過允許遞單時間 <"+begin_time+" ~ "+deadline+"> !!";
            }
            else if ("N".equals(str) && "N".equals(str2))
            {
                return "已過允許遞單時間 <"+begin_time+" ~ "+deadline+"> !!";
            }
            else if ("".equals(str))
            {
                return "輸入之日期或班號不正確!!";
            }
            else
            {
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    
//  Crew 是否為可遞單時間
    public String isValidSubmitTime2()
    {//For WL/FL     
     //WL須預請,Offsdate 不可為今天, offsdate > sysdate
     //WL occurdate <= offsdate 
     //WL deadline rule mm+3  dd-1
     //FL 第一次請假可為當天,第二次以後不可為當日
     //FL 需於100天內請完
     SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");   
     if("1".equals(offtype))
     {//WL
         GregorianCalendar date1 = new GregorianCalendar(); //offsdate
         GregorianCalendar date2 = new GregorianCalendar(); //sysdate
         GregorianCalendar date3 = new GregorianCalendar(); //occurdate
         GregorianCalendar date4 = new GregorianCalendar(); //deadline 三個月 ->六個月
         GregorianCalendar date5 = new GregorianCalendar(); //offedate
         
         date1.set(Integer.parseInt(offsdate.substring(0,4)),Integer.parseInt(offsdate.substring(5,7))-1,Integer.parseInt(offsdate.substring(8,10)));
         date3.set(Integer.parseInt(occurdate.substring(0,4)),Integer.parseInt(occurdate.substring(5,7))-1,Integer.parseInt(occurdate.substring(8,10)));
         date4.set(Integer.parseInt(occurdate.substring(0,4)),Integer.parseInt(occurdate.substring(5,7))-1,Integer.parseInt(occurdate.substring(8,10)));
         date4.add(Calendar.MONTH,6);
         date5.set(Integer.parseInt(offedate.substring(0,4)),Integer.parseInt(offedate.substring(5,7))-1,Integer.parseInt(offedate.substring(8,10)));
         
//         System.out.println(f.format(date1.getTime()));
//         System.out.println(f.format(date2.getTime()));
//         System.out.println(f.format(date3.getTime()));
         
//         System.out.println("date1.after(date2) = "+date1.before(date2));
//         System.out.println("date3.before(date1) = "+date3.before(date1));   
         
         if(!date1.after(date2))
         {
             return "WL 必須預先申請,請至空管辦理!";
         }
         else if (date1.before(date3))
         {
             return "不符合WL 請假規則,請至空管辦理!";
         }
         else if (!date5.before(date4))
         {
             return "WL 必須於六個月內申請完畢!";
         }
     }
     
     if("2".equals(offtype))
     {//FL
         GregorianCalendar date1 = new GregorianCalendar(); //offsdate
         GregorianCalendar date2 = new GregorianCalendar(); //sysdate
         GregorianCalendar date3 = new GregorianCalendar(); //occurdate
         GregorianCalendar date4 = new GregorianCalendar(); //deadline 100天
         GregorianCalendar date5 = new GregorianCalendar(); //offedate
         
         
         date1.set(Integer.parseInt(offsdate.substring(0,4)),Integer.parseInt(offsdate.substring(5,7))-1,Integer.parseInt(offsdate.substring(8,10)));
         date3.set(Integer.parseInt(occurdate.substring(0,4)),Integer.parseInt(occurdate.substring(5,7))-1,Integer.parseInt(occurdate.substring(8,10)));
         date4.set(Integer.parseInt(occurdate.substring(0,4)),Integer.parseInt(occurdate.substring(5,7))-1,Integer.parseInt(occurdate.substring(8,10)));
         date4.add(Calendar.DATE,99);
         date5.set(Integer.parseInt(offedate.substring(0,4)),Integer.parseInt(offedate.substring(5,7))-1,Integer.parseInt(offedate.substring(8,10)));
                
         if (date5.after(date4))
         {
             return "FL 必須於百日內申請完畢!";
         }
         
//         System.out.println(f.format(date1.getTime()));
//         System.out.println(f.format(date2.getTime()));
//         System.out.println(f.format(date3.getTime()));
         
//         System.out.println("date1.after(date2) = "+date1.before(date2));
//         System.out.println("date3.before(date1) = "+date3.before(date1));
         
         String str = "";
         Connection conn = null;
         Statement stmt = null;
         ResultSet rs = null;
         Driver dbDriver = null;
         int countfl = 0;
         try
         {
             ConnectionHelper ch = new ConnectionHelper();
             conn = ch.getConnection();
             stmt = conn.createStatement();
             //******************************************************************************
             sql = " select count(*) c from egtoffs where remark <> '*' and offtype = '2' " +
                   " and occur_date = to_date('"+occurdate+"','yyyy/mm/dd') and relation = '"+relation+"' " +
                   " and empn = '"+empno+"'";

//             System.out.println(sql);
             rs = stmt.executeQuery(sql);

             if (rs.next())
             {
                 countfl = rs.getInt("c");
             }
             //******************************************************************************            
         }
         catch ( Exception e )
         {
             System.out.println(e.toString());
             return "Error : "+e.toString();
         }
         finally
         {
             try
             {
                 if (rs != null)
                 {
                     rs.close();
                 }
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
         //*************************************************************************        
         if(countfl>0)
         {//不是第一次請必須預請
             if(!date1.after(date2))
             {
                 return "FL 必須預先申請,請至空管辦理!";
             }             
         }
         else
         {//第一次可當天請
//           System.out.println(f.format(date1.getTime()));
//           System.out.println(f.format(date2.getTime()));             
             if(date1.before(date2))
             {
                 return "FL 必須預先申請,請至空管辦理!";
             } 
         }
         
         if (date1.before(date3))
         {
             return "不符合FL 請假規則!";
         }   
      } //if("2".equals(offtype))
     
     //**********************************************************************************
     //是否依報到時間準時遞單
//     if(!"".equals(duty) && duty != null)
//     {
//       String str = "";
//       String begin_time = "";
//       String deadline = "";
//       Connection conn = null;
//       Statement stmt = null;
//       ResultSet rs = null;
//       Driver dbDriver = null;
//       try
//       {
//  //         Class.forName("oracle.jdbc.driver.OracleDriver");
//  //         conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:orp3","fzw2","xns72fs9kf");
//  //         stmt = conn.createStatement();
//           
////             ConnDB cn = new ConnDB();        
////             cn.setAOCIPRODFZUser();
////             java.lang.Class.forName(cn.getDriver());
////             conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
////             stmt = conn.createStatement();            
//           
//           ConnDB cn = new ConnDB();             
//           cn.setAOCIPRODCP();
//           dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//           conn = dbDriver.connect(cn.getConnURL(), null);
//           stmt = conn.createStatement();
//           //******************************************************************************
//           sql = " SELECT staff_num, duty_cd, str_dt_tm_gmt, checkin_time, to_char(begin_time,'yyyy/mm/dd hh24:mi') begin_time, " +
//                " to_char(deadline,'yyyy/mm/dd hh24:mi') deadline, series_num, " +       
//                " CASE WHEN Trunc(SYSDATE,'mi') BETWEEN begin_time AND deadline THEN 'Y' " +
//                //*********************************
//                " WHEN ( To_Date('"+offsdate+"','yyyy/mm/dd') > SYSDATE AND Trunc(SYSDATE,'mi') BETWEEN Trunc(SYSDATE,'dd') AND deadline) THEN 'Y' " +
//                //************************************
//                "  ELSE 'N' END  flag " +
//                " from ( " +
//                "     select r.duty_cd  duty_cd, dps.str_dt_tm_gmt str_dt_tm_gmt, dps.tod_start_loc_ds checkin_time, " +
//                        // start time of available to submit 
//                "       To_Date(to_char(dps.tod_start_loc_ds,'yyyy/mm/dd')||' 00:00','yyyy/mm/dd hh24:mi') begin_time, " +
//                        // report time <= 17:30, deadline is today's 17:30 else next day's 12:30
//                "       CASE WHEN dps.tod_start_loc_ds <= To_Date(to_char(dps.tod_start_loc_ds,'yyyy/mm/dd')||' 17:00','yyyy/mm/dd hh24:mi') " +
//                "       then To_Date(to_char(dps.tod_start_loc_ds,'yyyy/mm/dd')||' 17:00','yyyy/mm/dd hh24:mi') ELSE  " +
//                "       To_Date(to_char(dps.tod_start_loc_ds+1,'yyyy/mm/dd')||' 12:00','yyyy/mm/dd hh24:mi') END deadline, " +
//                "       r.staff_Num staff_Num, dps.delete_ind  delete_ind1, r.delete_ind delete_ind2, " +
//                "       dps.flt_num flt_num, r.pub_dt_tm  pub_dt_tm, dps.series_num series_num " +
//                "     from duty_prd_seg_v dps, roster_v r " +
//                "     where dps.series_num = r.series_num " +
//                "       AND (dps.flt_num=LPad('"+duty+"',4,0) OR dps.flt_num='0' ) " +
//                "       and r.staff_num='"+empno+"' and r.delete_ind='Y' AND dps.port_a = '"+obj.getStation()+"' " +
//                "       and dps.str_dt_tm_gmt between to_date('"+offsdate+" 0000','yyyy/mm/dd hh24mi')-1 " +
//                "       and to_date('"+offsdate+" 2359','yyyy/mm/dd hh24mi') " +
//                "       order by rownum DESC ) a " +
//                " where rownum=1 ";
//  
////             System.out.println(sql);
//           rs = stmt.executeQuery(sql);
//  
//           if (rs.next())
//           {
//               str = rs.getString("flag").trim();
//               begin_time = rs.getString("begin_time");
//               deadline = rs.getString("deadline");
//               series_num = rs.getString("series_num");                
//           }
//           //******************************************************************************
//           //need the series_num to adjudge if need reAssign
//             //***********************************************
//             reAssign();
//             //***********************************************    
//           //no match record
//           if ("N".equals(str) && Integer.parseInt(obj.getOffdays()) <=1)
//           {
//               return "已過允許遞單時間 <"+begin_time+" ~ "+deadline+"> !!";
//           }
//           else if ("".equals(str))
//           {
//               return "輸入之日期或班號不正確!!";
//           }         
//       }
//       catch ( Exception e )
//       {
//           System.out.println(e.toString());
//           return "Error : "+e.toString();
//       }
//       finally
//       {
//           try
//           {
//               if (rs != null)
//               {
//                   rs.close();
//               }
//           }
//           catch ( Exception e )
//           {
//           }
//           try
//           {
//               if (stmt != null)
//                   stmt.close();
//           }
//           catch ( Exception e )
//           {
//           }
//           try
//           {
//               if (conn != null)
//                   conn.close();
//           }
//           catch ( Exception e )
//           {
//           }
//       } 
//     }
    return "Y";
   }

    //  是否有電話預告,mark UL
    public String hasUL()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count = -1;
        try
        {
//          Class.forName("oracle.jdbc.driver.OracleDriver");
//          conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:orp3","fzw2","xns72fs9kf");
//          stmt = conn.createStatement();
          
            ConnDB cn = new ConnDB();             
            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();
            //******************************************************************************
            sql = " SELECT Count(*) c from roster_v r " +
                  " where r.staff_num='"+empno+"' " +
                  " AND r.duty_cd = 'UL' and r.delete_ind='N' " +
                  " and r.str_dt between to_date('"+offsdate+" 0000','yyyy/mm/dd hh24mi') " +
                  " and to_date('"+offedate+" 2359','yyyy/mm/dd hh24mi') ";

            //          System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                count = rs.getInt("c");
            }
            //******************************************************************************

            //no match record
            if (count <= 0)
            {
                return "尚未預先通知請假 !!";
            }
            else if (count<Integer.parseInt(obj.getOffdays()) | count>Integer.parseInt(obj.getOffdays()))
            {
                return "通報之請假日期與實際請假日期不符合!!";
            }
            else
            {
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    
    //  is re-submit
    public String isNotDuplicated()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int dupdate = 0;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************
            sql = " SELECT Count(*) c FROM egtoffs WHERE remark <> '*' AND empn = '"+empno+"' " +
                  " AND ( To_Date('"+offsdate+"','yyyy/mm/dd') BETWEEN offsdate AND offedate " ;
            for(int i=1; i< Integer.parseInt(obj.getOffdays()); i++)
            {//逐日檢查是否已請過
                sql = sql + " or To_Date('"+offsdate+"','yyyy/mm/dd')+"+i+" BETWEEN offsdate AND offedate ";
            }
            sql = sql +  " )";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                dupdate = rs.getInt("c");
            }
            //******************************************************************************
//System.out.println("days "+dupdate);
            if (dupdate > 0)
            {
                return "請勿重複遞單(當日有假單未註銷)!!";
            }
            else
            {
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
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
    
    //是否有未處理假單  
    public String hasUnHandle()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count =1;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************
            sql = " select count(*) c from egtoffs where remark <> '*' and empn = '"+empno+"' " +
                  " and offtype in ('3','5','12','27') " +//FL WL 可遞多張單
                  " and ( ef_judge_status = 'U' or (ef_judge_status = 'Y' and ed_inform_tmst is null ) )  ";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                count = rs.getInt("c");
            }
            //******************************************************************************
            if (count > 0)
            {
                return "尚有未處理之申請單";
            }
            else
            {
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
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
    
    //檢查整年請假天數,不可超過整年請假天數 病假 30 天, 事假 14 天
    //檢查pl一個月限請一天
    //檢查兩年內所有SL+PL+CL+HNSL+HNCL+CNCL+CNSL 不得超過365天 
    //2011/05/10 加入空轉地的請假天數
    //2014/01/08 SR3226 配合《性別工作平等法》修正案，女性勞工每年最多可請33天病假加生理假。
    //2014/09/09 修改SL/PL 請假規則, 判斷生理假(PL)目前已請天數,前三天不計入全年度的30天上限           
    public String isWithinMaxDays()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count = 0;
        int limit_days = 0;
        String sqlstr = "";
        String sqlstr2 = "";
        String errstr = "";
        
        //2014/09/09 修改SL/PL 請假規則, SL 整年度不得大於30日, SL+PL 不得大於 33日
        if("3".equals(offtype) | "12".equals(offtype) | "21".equals(offtype) )
        {
            limit_days = 30;
            sqlstr = "offtype = 3 OR offtype = 12 OR offtype = 21  ";
            sqlstr2 = "lvcd = '003' or lvcd = '029' or lvcd ='036' ";
            errstr = "整年度病假及生理假不得超過";
        }
         
        if("5".equals(offtype) | "14".equals(offtype) | "20".equals(offtype) | "22".equals(offtype))
        {
            limit_days = 14;
            sqlstr = " offtype = 5 OR offtype = 14 OR offtype = 20 OR offtype = 22 ";
            sqlstr2 = " lvcd = '005' OR lvcd = '030' OR lvcd = '035' OR lvcd = '037' ";
            errstr = "整年度事假不得超過";
        }        
            
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();   
            
            //超出的三天只限請PL
//            if("12".equals(offtype))
//            {
//                //判斷生理假(PL)目前是否已超過三天           
//                sql = " SELECT Sum(days) pldays FROM ( " +
//                        " SELECT Sum(offdays) + " +
//                          //if over to next year, just count the off days of this year
//                        " CASE WHEN To_Date('"+offedate+"','yyyy/mm/dd') > To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') " +
//                        " THEN  To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 " +
//                        " ELSE To_Date('"+offedate+"','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 END days " +
//                        " FROM egtoffs WHERE offtype = 12  AND remark <> '*' " +
//                        " AND empn = '"+empno+"' " +
//                        " AND Trunc(offsdate,'yyyy') =  Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy') " + 
//                        " UNION all " +
//                        " SELECT Ceil(Sum((lvdt*8)+lvhr-(candt*8)-canhr)/8) days " +
//                        " FROM hrvegpolvda WHERE employid = '"+empno+"' " +
//                        " AND strdt BETWEEN To_Date(to_char(to_date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'0101 00:01','yyyymmdd hh24:mi') " +
//                        " AND To_Date(to_char(to_date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'1231 23:59','yyyymmdd hh24:mi') " +
//                        " AND lvcd ='029' GROUP BY employid )";     
//                
//                rs = stmt.executeQuery(sql);
//    
//                if (rs.next())
//                {
//                    count = rs.getInt("pldays");
//                    if(count>3)
//                    {
//                        limit_days = 33;       
//                        count = 0;
//                    }
//                }
//                rs.close();
//            }  
            
            //判斷生理假(PL)目前已請天數,前三天不計入全年度的30天上限                
            if("3".equals(offtype) | "12".equals(offtype) | "21".equals(offtype))
            {
                  count = 0;                 
                  sql = " SELECT Sum(days) pldays FROM ( " +
                            //if over to next year, just count the off days of this year
                          " SELECT CASE WHEN To_Date('"+offedate+"','yyyy/mm/dd') > To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') " +
                          " THEN  To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 " +
                          " ELSE To_Date('"+offedate+"','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 END days " +
                          " FROM egtoffs WHERE offtype = 12  AND remark <> '*' " +
                          " AND empn = '"+empno+"' " +
                          " AND Trunc(offsdate,'yyyy') =  Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy') " + 
                          " UNION all " +
                          " SELECT Ceil(Sum((lvdt*8)+lvhr-(candt*8)-canhr)/8) days " +
                          " FROM hrvegpolvda WHERE employid = '"+empno+"' " +
                          " AND strdt BETWEEN To_Date(to_char(to_date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'0101 00:01','yyyymmdd hh24:mi') " +
                          " AND To_Date(to_char(to_date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'1231 23:59','yyyymmdd hh24:mi') " +
                          " AND lvcd ='029' GROUP BY employid )";     
                  
//                  System.out.println(sql);
                  rs = stmt.executeQuery(sql);
      
                  if (rs.next())
                  {
                      count = rs.getInt("pldays");
                      if(count>=3)
                      {
                          count=3;
                      }
                      
                      if("12".equals(offtype))//2014/10/13 若請PL 上限 33 天 
                      {
                          count=3;
                      }                      
                      
                      limit_days = limit_days + count;       
                      count = 0;
                  }
                  rs.close();
            }   
            
            //******************************************************************************
//            sql = " SELECT Sum(offdays) + " +
//                    //if over to next year, just count the off days of this year
//                " CASE WHEN To_Date('"+offedate+"','yyyy/mm/dd') > To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') " +
//                " THEN  To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 " +
//                " ELSE To_Date('"+offedate+"','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 END days " +
//                " FROM egtoffs WHERE ("+sqlstr+")  AND remark <> '*' " +
//                " AND empn = '"+empno+"' " +
//                " AND Trunc(offsdate,'yyyy') =  Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy') ";
            
            sql = " SELECT Sum(days) days FROM ( " +
                  " SELECT Sum(offdays) + " +
                    //if over to next year, just count the off days of this year
                  " CASE WHEN To_Date('"+offedate+"','yyyy/mm/dd') > To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') " +
                  " THEN  To_Date(To_Char(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'/12/31','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 " +
                  " ELSE To_Date('"+offedate+"','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1 END days " +
                  " FROM egtoffs WHERE ("+sqlstr+")  AND remark <> '*' " +
                  " AND empn = '"+empno+"' " +
                  " AND Trunc(offsdate,'yyyy') =  Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'yyyy') " + 
                  " UNION all " +
                  " SELECT Ceil(Sum((lvdt*8)+lvhr-(candt*8)-canhr)/8) days " +
                  " FROM hrvegpolvda WHERE employid = '"+empno+"' " +
                  " AND strdt BETWEEN To_Date(to_char(to_date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'0101 00:01','yyyymmdd hh24:mi') " +
                  " AND To_Date(to_char(to_date('"+offsdate+"','yyyy/mm/dd'),'yyyy')||'1231 23:59','yyyymmdd hh24:mi') " +
                  " AND ("+sqlstr2+") GROUP BY employid )";     
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                count = rs.getInt("days");
            }
//            System.out.println(count);
            //******************************************************************************         
            
            if (count > limit_days)
            {
                return errstr+limit_days+"天";
            }
            else
            {       
//              ***************************************************************
                //檢查pl一個月限請一天
                count =0;
                if("12".equals(offtype))
                {
                    sql = " SELECT count(*) c FROM egtoffs WHERE empn= '"+empno+"' AND offtype = '12' " +
                          " AND remark <> '*' AND offsdate BETWEEN Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'mm') " +
                          " AND Last_Day(Trunc(To_Date('"+offsdate+"','yyyy/mm/dd'),'mm')) ";
//                  System.out.println(sql);
                  rs = stmt.executeQuery(sql);
    
                  if (rs.next())
                  {
                    count = rs.getInt("c");
                  }
                  
                  if(count>=1)
                  {
                      return "PL 一個月限請一次";
                  }                
                } //if("12".equals(offtype))     
                //********************************************************************
                //檢查兩年內所有SL+PL+CL+HNSL+HNCL+CNCL+CNSL 不得超過365天                
                if("3".equals(offtype) | "12".equals(offtype) | "13".equals(offtype) | "21".equals(offtype) | "23".equals(offtype) | "25".equals(offtype) | "26".equals(offtype) )
                {
                    count =0;
//                    sql = " SELECT Nvl(Sum(Nvl(offdays,0)),0)+ (To_Date('"+offedate+"','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1) s_offdays " +
//                        " FROM egtoffs WHERE (offtype = 3 OR offtype = 12 OR offtype = 13 OR offtype = 21 " +
//                        " OR offtype = 23 OR offtype = 25 OR offtype = 26) " +
//                        " AND (offsdate between To_Date('"+offedate+"','yyyy/mm/dd')-(365*2) AND To_Date('"+offedate+"','yyyy/mm/dd') " +
//                        " OR offedate between To_Date('"+offedate+"','yyyy/mm/dd')-(365*2) AND To_Date('"+offedate+"','yyyy/mm/dd')) " +
//                        " AND remark <> '*' AND empn = '"+empno+"'";
                    
                    sql = " SELECT Sum(s_offdays) s_offdays FROM (" +
                          " SELECT Nvl(Sum(Nvl(offdays,0)),0)+ (To_Date('"+offedate+"','yyyy/mm/dd') - To_Date('"+offsdate+"','yyyy/mm/dd') +1) s_offdays " +
                          " FROM egtoffs WHERE (offtype = 3 OR offtype = 12 OR offtype = 13 OR offtype = 21 " +
                          " OR offtype = 23 OR offtype = 25 OR offtype = 26) " +
                          " AND (offsdate between To_Date('"+offedate+"','yyyy/mm/dd')-(365*2) AND To_Date('"+offedate+"','yyyy/mm/dd') " +
                          " OR offedate between To_Date('"+offedate+"','yyyy/mm/dd')-(365*2) AND To_Date('"+offedate+"','yyyy/mm/dd')) " +
                          " AND remark <> '*' AND empn = '"+empno+"'" +
                          " union all " +
                          " SELECT Ceil(Sum((lvdt*8)+lvhr-(candt*8)-canhr)/8) s_offdays " +
                          " FROM hrvegpolvda WHERE employid = '"+empno+"' " +
                          " AND (strdt between To_Date('"+offedate+"','yyyy/mm/dd')-(365*2) AND To_Date('"+offedate+" 2359','yyyy/mm/dd hh24mi') " +
                          " OR enddt between To_Date('"+offedate+"','yyyy/mm/dd')-(365*2) AND To_Date('"+offedate+" 2359','yyyy/mm/dd hh24mi')) " +                       
                          " AND (lvcd = '003' or lvcd ='036' or lvcd = '029' OR lvcd = '004' or lvcd ='038' " +
                          " or lvcd = '043' or lvcd = '042' or lvcd = '038') GROUP BY employid )"; 

//                  System.out.println(sql);
                    rs = stmt.executeQuery(sql);

                    if (rs.next())
                    {
                        count = rs.getInt("s_offdays");
                    }
                    
                    if(count > 365)
                    {
                        return "兩年內所有SL+PL+CL+HNSL+HNCL+CNCL+CNSL 不得超過365天";
                    }   
                }
                
                //***************************************************************
                //檢查不得連請
//                if("5".equals(offtype))
//                {
//                    count = Integer.parseInt(obj.getOffdays());
//                    sql = " SELECT Nvl(Sum(s.offdays),0) c FROM egtoffs s " +
//                        " WHERE  remark <> '*' AND offtype ='5' AND empn = '"+empno+"' " +
//                        " AND offedate between (To_Date('"+offsdate+"','yyyy/mm/dd')-(6-"+obj.getOffdays()+")) " +
//                        " AND (To_Date('"+offsdate+"','yyyy/mm/dd')-1)";
//                  System.out.println(sql);
//                rs = stmt.executeQuery(sql);
//  
//                if (rs.next())
//                {
//                  count = count + rs.getInt("c");
//                }
//                
//                if(count>5)
//                {
//                    return "每次以不超過五日為原則";
//                }                
//                } //if("5".equals(offtype)) 
                //********************************************************************
                return "Y";
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
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
    
//  檢查請假天數,婚假 8 天, 喪假 依親屬關係而定
//  天數記錄於 EGTFLDY 
//  get the event date of first offsheet    
    public String isWithinMaxDays2()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count = 0;
        int limit_days = 0;
        String sqlstr = "";
        String errstr = "";
        
        if("1".equals(offtype))
        {
            limit_days = 8;
            sqlstr = " offtype = 1 AND occur_date = To_Date('"+occurdate+"','yyyy/mm/dd') ";
            errstr = "婚假不得超過8天";
        }
         
        if("2".equals(offtype))
        {
            if("22".equals(relation) | "23".equals(relation) | "24".equals(relation) | "25".equals(relation) | "26".equals(relation) | "27".equals(relation) | "28".equals(relation) | "29".equals(relation))
            {
                limit_days = 3;
            }
            else if("1".equals(relation) | "2".equals(relation) | "3".equals(relation) | "4".equals(relation) | "5".equals(relation) | "6".equals(relation) | "7".equals(relation) )
            {
                limit_days = 8;
            }
            else
            {
                limit_days = 6;
            }
            
            sqlstr = " offtype = 2 AND occur_date = To_Date('"+occurdate+"','yyyy/mm/dd') and relation = '"+relation+"' ";
            errstr = "喪假不得超過"+limit_days+"天";
        }
            
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            //******************************************************************************
            sql = " SELECT Nvl(Sum((offedate-offsdate)+1),0) + (To_Date('"+offedate+"','yyyy/mm/dd')-To_Date('"+offsdate+"','yyyy/mm/dd')+1) days " +
                  " FROM egtoffs " +
                  " WHERE ("+sqlstr+") AND empn = '"+empno+"' AND remark <> '*' ";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                count = rs.getInt("days");
            }
//            System.out.println(count);
            //******************************************************************************
            if (count > limit_days)
            {
                return errstr;
            }
            else
            {
                //檢查Event date 之正確性
//              ******************************************************************************                
                if("1".equals(offtype))
                {
                    sql = " SELECT  To_Char(Min(occur_date),'yyyy/mm/dd') min_occur FROM egtoffs " +
                          " WHERE offtype = '1' AND empn = '"+empno+"' AND remark <> '*' " +
                          " AND offsdate BETWEEN add_months(To_Date('"+offedate+"','yyyy/mm/dd'),-3) " +
                          " AND To_Date('"+offedate+"','yyyy/mm/dd') ";    
                }
                 
                if("2".equals(offtype))
                {
                    sql = " SELECT  To_Char(Min(occur_date),'yyyy/mm/dd') min_occur FROM egtoffs " +
                          " WHERE offtype = '2' AND empn = '"+empno+"' AND remark <> '*' " +
                          " AND relation = '"+relation+"' " +
                          " AND offsdate BETWEEN To_Date('"+offedate+"','yyyy/mm/dd')-99 " +
                          " AND To_Date('"+offedate+"','yyyy/mm/dd') ";
                }
//                System.out.println(sql);
                rs = stmt.executeQuery(sql);

                if (rs.next())
                {
                    first_event_date = rs.getString("min_occur");
                }
                
                if(!"".equals(first_event_date) && first_event_date != null && !first_event_date.equals(occurdate))
                {
                    return "發生日填寫不正確，您上一張單填寫的日期為 "+first_event_date+"!!";
                }
                
                return "Y";
            }
        }
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            return e.toString();
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
    
//  檢查請假天數不可連續超過7天
    public String chkContinues()
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count = 0;
        int limit_days = 7;
        int left_days = 0;
        String sqlstr = "";
        String errstr = "";
        
        if("7".equals(obj.getOfftype()))
        {
            limit_days = 3;
        }
        
        left_days = limit_days - Integer.parseInt(obj.getOffdays());  
        
        if(left_days <0)
        {
            return "已連續請假超過"+ limit_days + "天, 請至組上辦理請假事宜";
        }
        else
        {            
            try
            {
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();
                stmt = conn.createStatement();
    
                //******************************************************************************
                sql = " SELECT Sum((offedate-offsdate)+1) days FROM egtoffs WHERE empn = '"+empno+"' " +
                      " AND remark <> '*' AND offtype = '"+obj.getOfftype()+"' " +
                      " AND offsdate BETWEEN To_Date('"+offsdate+"','yyyy/mm/dd')-"+left_days+"-1 " +
                      " AND To_Date('"+offedate+"','yyyy/mm/dd') ";
    
//              System.out.println(sql);
                rs = stmt.executeQuery(sql);
    
                if (rs.next())
                {
                    count = rs.getInt("days");
                }
//              System.out.println(count+"  "+ left_days);
                //******************************************************************************
                if (count > left_days)
                {
                    return "已連續請假超過"+ limit_days + "天, 請至組上辦理請假事宜";
                }
                else
                {
                    return "Y";
                }
            }
            catch ( Exception e )
            {
                System.out.println(e.toString());
                return e.toString();
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
    }
    
//  是否有班表判斷
    public String hasSkj()
    {             
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String ifhasSkj = "N";
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();            
           
            sql = " SELECT CASE WHEN ( pubdate <= SYSDATE ) THEN 'Y' ELSE 'N' END ifpub " +
                  " FROM fztspub WHERE yyyy='"+offsdate.substring(0,4)+"' " +
                  " AND mm = '"+offsdate.substring(5,7)+"'";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                ifhasSkj = rs.getString("ifpub").trim();
            }
            
            return ifhasSkj;   
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    
    
//  是否補班判斷 return Y(reassign) or N(not reassign)
    public String reAssign()
    {
        if(Integer.parseInt(obj.getOffdays()) >1)
        {
            //需補班
            obj.setReassign("Y");
            return "Y";
        }        
        else
        {    
            if("27".equals(offtype))
            {           
                //2014/11 請LSW飛時<67 hrs,需補班
                Driver dbDriver = null;
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                PreparedStatement pstmt = null;
                String sql = null;
                String st = "";
                String et = "";
                double flyHrs = 0.0;
                try 
                {
                    ConnDB cn = new ConnDB();             
                    cn.setAOCIPRODCP();
                    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                    conn = dbDriver.connect(cn.getConnURL(), null);
                    stmt = conn.createStatement();
             
//                 cn.setAOCIPRODFZUser();
////                   cn.setORT1AOCITESTUser();
//                 java.lang.Class.forName(cn.getDriver());
//                 conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//                 stmt = conn.createStatement(); 

                    sql = " select to_char(to_date('"+obj.getOffsdate().substring(0,7)+"01','yyyy/mm/dd') ,'yyyy/mm/dd') st , " +
                        " to_char(LAST_DAY (to_date('"+obj.getOffsdate().substring(0,7)+"01','yyyy/mm/dd')) ,'yyyy/mm/dd') et from dual";

                    rs = stmt.executeQuery(sql);
                    if (rs.next()) 
                    {
                        st = rs.getString("st");
                        et = rs.getString("et");
                    }                   
                    
                    pstmt = conn.prepareStatement(" SELECT staff_num,sum(non_std_fly_hours) totalcr "
                                    + "FROM crew_cum_hr_cc_v c   WHERE staff_num = ? AND  c.cal_dt  BETWEEN "
                                    + "To_Date(?,'yyyy/mm/dd hh24mi')  AND Last_Day(To_Date(?,'yyyy/mm/dd hh24mi')) GROUP BY  staff_num");
                    pstmt.clearParameters();
                    pstmt.setString(1, empno);
                    pstmt.setString(2, st + "0000");
                    pstmt.setString(3, et + "2359");
                    rs = pstmt.executeQuery();

                    while (rs.next()) 
                    {
                        flyHrs = Integer.parseInt(rs.getString("totalcr"));
                    }
                                
//                  System.out.println("flyHrs"+flyHrs);
                    if(flyHrs < 67*60 ){
                        obj.setReassign("Y");
                        return "Y";
                    }       
                    
                } catch (Exception e) {
                    return "LSW 取得當月飛時失敗"+e.toString();
                } finally {
                    try {
                        if (rs != null)
                            rs.close();
                    } catch (SQLException e) {
                    }
                    try {
                        if (stmt != null)
                            stmt.close();
                    } catch (SQLException e) {
                    }
                    try
                    {
                        if (pstmt != null)
                            pstmt.close();
                    }
                    catch ( Exception e )
                    {
                    }  
                    try {
                        if (conn != null)
                            conn.close();
                    } catch (SQLException e) {
                    }
                }
            }
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            Driver dbDriver = null;
            int count = 0;
            try
            {
    //          Class.forName("oracle.jdbc.driver.OracleDriver");
    //          conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.242.55:1521:orp3","fzw2","xns72fs9kf");
    //          stmt = conn.createStatement();
              
                ConnDB cn = new ConnDB();             
                cn.setAOCIPRODCP();
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                conn = dbDriver.connect(cn.getConnURL(), null);
                stmt = conn.createStatement();
         
////                cn.setAOCIPRODFZUser();
//              cn.setORT1AOCITESTUser();
//              java.lang.Class.forName(cn.getDriver());
//              conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//              stmt = conn.createStatement();   
                
                if(!"".equals(series_num))
                {//有任務
                    //******************************************************************************
                    //是否為當天來回
                    //series_num loads from isValidSubmitTime
                    sql = " SELECT Count(*) c from duty_prd_seg_v " +
                          " where series_num = '"+series_num+"' and duty_cd = 'LO' ";
        
                    //System.out.println(sql);
                    rs = stmt.executeQuery(sql);
        
                    if (rs.next())
                    {
                        count = rs.getInt("c");
                    }
                    
                    if(count > 0)
                    {
                        // 排除短暫休息case ex:ci0641,ci0301
                        sql = " SELECT CASE WHEN Trunc(Min(tod_start_loc_ds),'dd') = Trunc(Max(act_str_dt_tm_gmt),'dd') " +
                              " THEN 'Y' ELSE 'N' END ifsameday from duty_prd_seg_v " +
                              " where series_num = '"+series_num+"' AND flt_num <> 'RST'";
    
                       //System.out.println(sql); 
                       rs.close();
                       rs = stmt.executeQuery(sql);
                       
                       if (rs.next())
                       {
                           if("Y".equals(rs.getString("ifsameday").trim()))
                           {
                               count = 0;
                           }               
                       }
                    }
                }
                
                //非當日來回班
                if (count > 0 )
                {
                    //需補班
                    obj.setReassign("Y");
                    return "Y";
                }
                else
                {   
                    //為當日來回班
                    //******************************************************************************                    
                    //若為婚喪假,則不需檢核,不補班
                    if("1".equals(offtype) || "2".equals(offtype))
                    {
                        obj.setReassign("N");
                        return "N";
                    }
                    else
                    {
                        // checking step 2, 過去60日內是否有請假
                        sql = " select count(*) c from roster_v where (duty_cd in ('PL','SL','EL','UL','LL','NS','CL','CNSL','CNCL') " +
                          " or (duty_cd = 'LA' AND To_Char(end_dt,'hh24mi') = '2359')) " +
                              " and delete_ind='N' and staff_num = '"+empno+"' " +
                              " and str_dt between To_Date('"+offsdate+"','yyyy/mm/dd')-60 and To_Date('"+offsdate+"','yyyy/mm/dd')-1 ";
                        rs = stmt.executeQuery(sql);
                        count =0;
                        if (rs.next())
                        {
                            count = rs.getInt("c");
                        }  
                    
                        if (count <= 0 )
                        {//過去60日內未請假
                            obj.setReassign("N");
                            return "N";
                        }
                        else
                        {//過去60日內有請假
                            obj.setReassign("Y");
                            return "Y";
                        }
                    }//if("1".equals(offtype) || "2".equals(offtype))
                }
            }
            catch ( Exception e )
            {
                System.out.println(e.toString());
                return "Error : "+e.toString();
            }
            finally
            {
                try
                {
                    if (rs != null)
                    {
                        rs.close();
                    }
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
        }//if(obj.getOffdays()>1)        
    }
    
//  可否申請LSW
    public String lswFullAttendanceCheck()
    {                  
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count = 0;
        try
        {       
            ConnDB cn = new ConnDB();             
            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();    

//            cn.setORT1AOCITESTUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();   
            
            //check 當年度至目前為止是否全勤
            sql = " select count(*) c from roster_v where (duty_cd in ('PL','SL','EL','UL','LL','NS','CL','CNSL','CNCL') " +
              " or (duty_cd = 'LA' AND To_Char(end_dt,'hh24mi') = '2359')) " +
              " and delete_ind='N' and staff_num = '"+empno+"' " +
              " and str_dt between To_Date('"+offsdate.substring(0,4)+"/01/01','yyyy/mm/dd') " +
              " and To_Date('"+offsdate+" 2359','yyyy/mm/dd hh24mi')-1 ";
//              System.out.println(sql);
              rs = stmt.executeQuery(sql);
              
              if (rs.next())
              {
                  count = rs.getInt("c");
              }
              
              if(count <= 0)
              {
                  return "Y";
              }
            
              //**************************************************************************************
              //check 前一年是否全勤
              count = 0;
              rs.close();
              sql =  " select count(*) c from roster_v where (duty_cd in ('PL','SL','EL','UL','LL','NS','CL','CNSL','CNCL') " +
                     " or (duty_cd = 'LA' AND To_Char(end_dt,'hh24mi') = '2359')) " +
                     " and delete_ind='N' and staff_num = '"+empno+"' " +
                     " and str_dt between To_Date('"+Integer.toString(Integer.parseInt(offsdate.substring(0,4))-1)+"/01/01','yyyy/mm/dd') " +
                     " and To_Date('"+Integer.toString(Integer.parseInt(offsdate.substring(0,4))-1)+"/12/31 2359','yyyy/mm/dd hh24mi') ";
//             System.out.println(sql);
             rs = stmt.executeQuery(sql);
            
             if (rs.next())
             {
                count = rs.getInt("c");
             }
            
             if(count <= 0)
             {
                return "Y";
             }
             
             return "不符合申請資格";
         }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    
//  可否申請LSW
    public String lswQuotaCheck()
    {                  
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        int count = 0;
        try
        {       
            ConnDB cn = new ConnDB();             
            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();    
            
//            cn.setORT1AOCITESTUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
//            stmt = conn.createStatement();   
            
            //check 當年度lsw使用天數
            sql = " select count(*)+"+Integer.parseInt(obj.getOffdays())+" c from roster_v where duty_cd = 'LSW' " +
                  " and delete_ind='N' and staff_num = '"+empno+"' " +
                  " and str_dt between To_Date('"+offsdate.substring(0,4)+"/01/01','yyyy/mm/dd') " +
                  " and To_Date('"+offsdate.substring(0,4)+"/12/31 2359','yyyy/mm/dd hh24mi')";
//            System.out.println(sql);
              rs = stmt.executeQuery(sql);
              
              if (rs.next())
              {
                  count = rs.getInt("c");
              }
              
              if(count <= 5)
              {
                  return "Y";
              }
              else
              {
                  return "當年度LSW僅限申請五日";
              }     
         }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
        
//  是否為控管日 控管日 return 'N' else return 'Y' 2012/12/21 改2013補行上班日
    public String ifLSWOKDate()
    {             
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String iflswok = "Y";

        int count = 0;
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement(); 
            
            sql = " SELECT Count(*) c FROM egtnolsw " +
                  " WHERE To_Date('"+offsdate+"','yyyy/mm/dd') BETWEEN sdate AND edate " +
                  " OR To_Date('"+offedate+"','yyyy/mm/dd') BETWEEN sdate AND edate " +
                  " OR sdate between To_Date('"+offsdate+"','yyyy/mm/dd') AND To_Date('"+offedate+"','yyyy/mm/dd') " +
                  " OR edate between To_Date('"+offsdate+"','yyyy/mm/dd') AND To_Date('"+offedate+"','yyyy/mm/dd') ";
           
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                count = rs.getInt("c");
            }
              
            //請假日落在控管日
            if(count > 0)
            {
                  return "請假日為LSW管制請假日";
            }
            else
            {//check 是否落在六日
                sql = " select To_Char(allday,'yyyy/mm/dd') eachdate, " +
                      " to_char(allday,'DY','NLS_DATE_LANGUAGE=AMERICAN') dayofweek from ( " +
                      " select to_date('"+offsdate.substring(0,8)+"'||jday,'yyyy/mm/dd') allday from fztdate " +
                      " WHERE  jday <= To_Char(Last_Day(To_Date('"+offsdate+"','yyyy/mm/dd')),'dd') " +
                      " and to_date('"+offsdate.substring(0,8)+"'||jday,'yyyy/mm/dd') " +
                      "   BETWEEN To_Date('"+offsdate+"','yyyy/mm/dd') and To_Date('"+offedate+"','yyyy/mm/dd') " +
                      " UNION select to_date('"+offedate.substring(0,8)+"'||jday,'yyyy/mm/dd') allday from fztdate " +
                      " WHERE  jday <= To_Char(Last_Day(To_Date('"+offedate+"','yyyy/mm/dd')),'dd') " +
                      " and to_date('"+offedate.substring(0,8)+"'||jday,'yyyy/mm/dd') " +
                      "   BETWEEN To_Date('"+offsdate+"','yyyy/mm/dd') and To_Date('"+offedate+"','yyyy/mm/dd')) ";
//                  System.out.println(sql);
                  rs.close();
                  count = 0;
                  rs = stmt.executeQuery(sql);
                  while (rs.next())
                  {
                      //System.out.println(rs.getString("eachdate")+"  "+rs.getString("dayofweek"));
                      /*2012原始檔*/
//                    if("SAT".equals(rs.getString("dayofweek")) | "SUN".equals(rs.getString("dayofweek")))
//                    {
//                        return "請假日為LSW管制請假日";
//                    }/********/
                      
                      if("SAT".equals(rs.getString("dayofweek")) | "SUN".equals(rs.getString("dayofweek")) 
                              | "2012/12/31".equals(rs.getString("eachdate")) | "2013/02/15".equals(rs.getString("eachdate")) | "2013/09/20".equals(rs.getString("eachdate")))//調整放假
                      {
                          if("2012/12/22".equals(rs.getString("eachdate")) | "2013/02/23".equals(rs.getString("eachdate")) | "2013/09/14".equals(rs.getString("eachdate"))){//補班                             
                          }else{
                              return "請假日為LSW管制請假日";    
                          }
                      }           
                      
                  }
                  return "Y";
            }        
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                {
                    rs.close();
                }
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
    
    //  是否需交証明文件  return N(待交証明) or U(不需交証明)
    public String needDoc()
    {
        if("1".equals(offtype) | "2".equals(offtype))
        {
            obj.setDoc_status("N");
            return "N";//待交証明
        }
        else if(Integer.parseInt(obj.getOffdays()) > 1)
        {
            obj.setDoc_status("N");
            return "N";//待交証明
        }
        else
        {
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            Driver dbDriver = null;
            try
            {
                ConnectionHelper ch = new ConnectionHelper();
                conn = ch.getConnection();
                stmt = conn.createStatement();
                
                //******************************************************************************
                sql = " SELECT Count(*) c FROM egtoffs WHERE offtype = '"+offtype+"'  " +
//                    " offtype in ('3','12','5','13','14')  " +  //同假別才需要
                      " AND remark <> '*' AND empn = '"+empno+"' " +
                      " AND ( offedate = To_Date('"+offsdate+"','yyyy/mm/dd') - 1 or " +
                      " offsdate = To_Date('"+offsdate+"','yyyy/mm/dd') + 1  ) "; 
                rs = stmt.executeQuery(sql);
                
                if(rs.next())
                {
                    if(rs.getInt("c") > 0)
                    {
                        obj.setDoc_status("N");
                        return "N";
                    }
                }
                obj.setDoc_status("U");
                return "U";
            }
            catch ( Exception e )
            {
                System.out.println(e.toString());
                return "Error : "+e.toString();
            }
            finally
            {
                try
                {
                    if (rs != null)
                    {
                        rs.close();
                    }
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
    }
    
    
    
    public OffsObj getObj()
    {
        return obj;
    }
    
    public String getFirstEventDate()
    {
        return first_event_date;
    }
}