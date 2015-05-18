package ws.prac;

import java.io.*;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import ws.*;
import ws.prac.SFLY.CheckSFLYRpt;

import ci.db.ConnDB;
import ci.db.ConnectionHelper;
import eg.crewbasic.*;
import eg.mvc.MVCObj;
import eg.mvc.MVCRecord;
import fz.prObj.FltObj;
import fz.pracP.*;
import fz.pracP.dispatch.FlexibleDispatch;
import fzAuthP.*;
import fzac.CrewInfoObj;

public class ReportListFun {

    /**
     * @param args
     * // w�Ǧ^����Z��
     * // w�Ǧ^���i�s�説�A
     * // �����OCrew or �줽��
     * // w�Ǧ^CM���
     * // w�Ǧ^MVC��� yyyymmdd
     * // w��l�խ��W��
     * // w���Z�ȿ��g�zcheck
     * // w�����Z�խ��W��,from cflt. ���խ��W��,�L�h��ܭ�l�խ��W��
     * 
     * // w�ҵ�����
     * // w�ҵ����e
     */
    ReportListFltRObj fltObj = null;
    ReportListCfltUpdObj cfltObj = null;
//    ReportListCfltUpdRObj cfltStatusObj = null;
    PurInfoObj purObj = null;
    EmpnoInfoRObj empObj= null;
    ReportListMVCObj mvcObj = null;
    CrewListRObj oriCrewObj = null;
    ActPurObj onePurObj = null;
    MdCrewListObj mdCrewObj = null; 
    GradeItemRObj gdObj = null;
    GradeRObj gdRecObj = null;
    

    FileWriter fw = null;  
    String path = "/apsource/csap/projfz/txtin/appLogs/";
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        ReportListFun fltObj = new ReportListFun();
//        fltObj.getPurFltSch("630304","2013","11");
//        fltObj.getPurCflt("631178", "2013/11/24", "0991", "TPEXMN");
//        fltObj.getPurCflt("632937", "2013/06/17", "0008Z", "TPELAX");
        fltObj.getPurInfo("633020");
//        fltObj.getEmpInfo("643937/630304/635863");
//        System.out.println(fltObj.getEmpnoType("643937"));
//        fltObj.getMVC("630304", "2013/07/08", "0916", "HKGTPE");
//        fltObj.getActPur( "2013/06/02", "0018","TPENRT");
//        fltObj.getMdCrewList("633020", "2013/12/01 18:16", "0006", "TPELAX");
//        fltObj.getMdCrewList("630752", "2014/09/05 00:19", "0008", "TPELAX");
//        fltObj.getMdCrewList("630304", "2013/11/14 17:15", "0130", "TPECTS");
//        fltObj.getFile("2013/10/6","0112" ,"TPEHIJ");
        System.out.println("done"); 
    }

    public ReportListFun() {

    }
    
    // �Ǧ^����Z��
    public void getPurFltSch(String empno, String yy, String mm) {//2013/07/08
         
//        empno = empno.substring(0,6);
        empno = empno.trim();
        Connection conn = null;
        Driver dbDriver = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        int jobno = 0;
        String rankSql = null;
        //2015/02 �睊����
        String[] funcCodeAll = {"1","2","3","4"};
        String[] funcCodeS = {"2","3","4"};
        String[] funcCodeG = {"2"};
//      1  PIL
//      2  My Flight 
//      3  Meal Order
//      4  Feedback 
 
//        ConnAOCI cna = new ConnAOCI();

        fltObj = new ReportListFltRObj();
        ReportListFltObj obj = null;
        ArrayList listSch = new ArrayList();
        ReportListCfltUpdObj[] listStatus = null;
        int rowCount = 0;
        
        String exStr = "";
        
        String fdate = null; 
        String ftime = null; 
        String dd = null;
        try
        {
            mm = "00".substring(0, 2 - mm.length()) + mm;
        }
        catch ( Exception e )
        {
            // TODO: handle exception
            fltObj.setResultMsg("0");
            fltObj.setErrorMsg("�d�ߪ�������~.");
        }

        //=============
//        try{
//            fw = new FileWriter(path+"serviceLog.txt",true);
//            fw.write("*****************Schedule Start*****************\r\n");
//            fw.write(new java.util.Date() + "Empno : "+empno +"\r\n");                  
//        }
//        catch (Exception e1){
////            System.out.println("e1"+e1.toString());
//        }
        //=============
      swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yy, mm);
        if (!pc.isPublished()){
            fltObj.setResultMsg("1");
            fltObj.setErrorMsg("�Z���|���������G");
        } else {
            getPurInfo(empno);
            jobno = Integer.parseInt(purObj.getJobno());//EG���� -- CM(80) or PR(95)
            if(jobno <= 80){
                rankSql = "and ( r.acting_rank = 'PR') ";//CM�����Z��
            }else if(jobno == 95){
                rankSql = "and ( r.acting_rank in ('MC', 'FC')) ";//PR�����Z��--air crews acting code �]�t���code:FC&MC ;MC�i�g�ȿ����i,FC���i��g
//                rankSql = "and ( r.acting_rank in ('MC')) ";//1.35�����}��
            }else if(jobno > 95 && 
                   ("635018".equals(empno) || "636680".equals(empno) || "637034".equals(empno) || "637656".equals(empno) || "630689".equals(empno) ||
                    "633834".equals(empno) || "633702".equals(empno) || "637659".equals(empno) || "631328".equals(empno) || "634170".equals(empno) ||
                    "637023".equals(empno) || "637447".equals(empno) || "638567".equals(empno) || "635681".equals(empno) || "638575".equals(empno) ||
                    "638554".equals(empno) 
                    )){//20140415
                rankSql ="02";
            }else{
                rankSql ="01";
            }
            
            if(!"".equals(rankSql)){   
                try { 

//                  ��AOCIPROD �Ӥ�duty��Pusrser���Z��
                    ConnDB cn = new ConnDB();
                    cn.setAOCIPRODCP();
                    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                    conn = dbDriver.connect(cn.getConnURL(), null);
                    stmt = conn.createStatement();
                    
//              cna.setAOCIFZUser();
//              java.lang.Class.forName(cna.getDriver());
//              conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(), cna.getConnPW());
//              stmt = conn.createStatement();
//                �����s�u
              
//              cn.setORT1FZ();
//              java.lang.Class.forName(cn.getDriver());
//              conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
//              stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
               
                 
//              sql =
//                 "select dps.duty_cd,dps.flt_num fltno, " +
//                 "to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, " +
//                 "to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, "+
//                 "to_char(str_dt_tm_loc,'hh24mi') ftime, " +
//                 "to_char(dps.end_dt_tm_loc,'yyyy/mm/dd') edate, " +
//                 "to_char(end_dt_tm_loc, 'yyyy/mm/dd hh24:mi') endDt, " +
//                 "to_char(end_dt_tm_loc, 'hh24mi') eftime,  " +                 
//                 "dps.act_port_a dpt,dps.act_port_b arv,r.acting_rank qual, r.special_indicator "+
//                 "from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num "+
//                 "and dps.delete_ind = 'N' AND  r.delete_ind='N' "+
//                 "and r.staff_num ='"+empno+"' AND dps.act_str_dt_tm_gmt BETWEEN  "+
//                 "to_date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') AND "+
//                 "Last_Day( To_Date('"+yy+mm+"01 23:59','yyyymmdd hh24:mi')) "+
//                 "AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') " +
////                 "AND  r.acting_rank='PR' " +
//                 " AND ( r.acting_rank in ('PR','MC') OR Nvl(r.special_indicator,' ') = 'J')"+//201306
//                 "order by str_dt_tm_gmt";
                  
                  //20131204
                  sql = "select dps.duty_cd, " +
                  		"       nvl(DA13_FLTNO ,dps.flt_num) bookfltno," +
                  		"       nvl(to_char(DA13_stdl,'yyyy/mm/dd'),to_char(dps.str_dt_tm_loc, 'yyyy/mm/dd')) bookDate, " +//--local time
                  		"       dps.flt_num fltno," +
                  		"       to_char(dps.str_dt_tm_loc, 'yyyy/mm/dd') fdate," +
                  		"       to_char(str_dt_tm_loc, 'yyyy/mm/dd hh24:mi') stdDt," +
                  		"       to_char(str_dt_tm_loc, 'hh24mi') ftime," +
                  		"       to_char(dps.end_dt_tm_loc, 'yyyy/mm/dd') edate," +
                  		"       to_char(end_dt_tm_loc, 'yyyy/mm/dd hh24:mi') endDt," +
                  		"       to_char(end_dt_tm_loc, 'hh24mi') eftime," +
                  		"       dps.act_port_a dpt," +
                  		"       dps.act_port_b arv," +
                  		"       DECODE(r.acting_rank , 'PR','CM' , 'FC','PR' ,r.acting_rank  ) qual," +
                  		"       rank.RANK_CD rank," +
                  		"       r.special_indicator," +
                  		"       decode(trim(dps.ARLN_CD), '' ,'CI',dps.ARLN_CD) ARLN_CD, " +
                  		"       Nvl(da13_v.DA13_ACNO,'X') acno," +
                  		"       Nvl(da13_v.DA13_ACTP,'X') actp " +      //--for PIL AE or CI            		
                  		"  from duty_prd_seg_v dps, roster_v r, v_ittda13_ci da13_v," +
                  		"  (select * from crew_rank_v where staff_num = '"+empno+"' and eff_dt < sysdate and (exp_dt is null or exp_dt > sysdate)) rank " +
                  		" where dps.series_num = r.series_num" +
                  		" and LPAD(dps.flt_num , 5, '0') =  LPAD(trim(da13_v.da13_fltno || da13_v.da13_op_suffix) , 5, '0')" +//������0 mapping 5�X 
                  		//"   and dps.flt_num  = trim(da13_v.da13_fltno || da13_v.da13_op_suffix)" +//--da13_v.da13_fltno (+)
                  		"   and dps.act_port_a = da13_v.da13_fm_sector (+)" +
                  		"   and dps.act_port_b = da13_v.da13_to_sector (+)" +
                  		"   and rank.staff_num = r.staff_num " +
//                  		"   and dps.str_dt_tm_gmt - (8/24) between da13_v.da13_stdu (+) - 1/8 and da13_v.da13_stdu (+) + 1/8" +//--���t3hrs.
                        "   and dps.RESCHEDULED_FLT_DT_TM - (8/24) between da13_v.da13_stdu (+) - 6/24 and da13_v.da13_stdu (+) + 6/24" +//--���t6hrs.
                        "   and dps.delete_ind = 'N' AND r.delete_ind = 'N'" +
                  		"   and r.staff_num ='"+empno+"'" +
                  		"   AND da13_v.DA13_SCDATE_U (+) BETWEEN" +
                  		"       to_date('"+yy+mm+"01 00:00', 'yyyymmdd hh24:mi') -1 AND" +
                  		"       Last_Day(To_Date('"+yy+mm+"01 23:59', 'yyyymmdd hh24:mi')) +1" +
                  		"   AND dps.act_str_dt_tm_gmt BETWEEN" +
                  		"       to_date('"+yy+mm+"01 00:00', 'yyyymmdd hh24:mi') AND" +
                  		"       Last_Day(To_Date('"+yy+mm+"01 23:59', 'yyyymmdd hh24:mi'))" +
                  		"   AND r.duty_cd = 'FLY'   AND dps.duty_cd IN ('FLY', 'TVL')";
                 
    //              		"   AND ( r.acting_rank in ('PR','MC') OR Nvl(r.special_indicator,' ') = 'J')"+//201306
//                      20140609 return ����Z��
//                  		if(!"crew".equals(rankSql)){
//                  		  sql += rankSql ;//201312 �Ϥ��ȿ��g�z or �ưȪ��Z��.
//                  		}  
                  /*test no acno
                 sql = "  select dps.duty_cd, "+
                       "  substr(dps.flt_num,0,4) bookfltno, "+
                       "  to_char(dps.str_dt_tm_loc, 'yyyy/mm/dd') bookDate,"+
                       "  dps.flt_num fltno,"+
                       "  to_char(dps.str_dt_tm_loc, 'yyyy/mm/dd') fdate,"+
                       "  to_char(str_dt_tm_loc, 'yyyy/mm/dd hh24:mi') stdDt,"+
                       "  to_char(str_dt_tm_loc, 'hh24mi') ftime,"+
                       "  to_char(dps.end_dt_tm_loc, 'yyyy/mm/dd') edate,"+
                       "  to_char(end_dt_tm_loc, 'yyyy/mm/dd hh24:mi') endDt,"+
                       "  to_char(end_dt_tm_loc, 'hh24mi') eftime,"+
                       "  dps.act_port_a dpt,"+
                       "  dps.act_port_b arv,"+
                       "  DECODE(r.acting_rank , 'PR','CM' , 'FC','PR' ,r.acting_rank  ) qual,"+
                       "  rank.RANK_CD rank,"+
                       "  r.special_indicator,"+
                       "  decode(trim(dps.ARLN_CD), '' ,'CI',dps.ARLN_CD) ARLN_CD, "+
                       "  'X' acno,"+
                       "  Nvl(dps.FLEET_CD,'X') actp"+       //--for PIL AE or CI                    
                       " from duty_prd_seg_v dps, roster_v r, "+
                       " (select * from crew_rank_v where staff_num = '"+empno+"' " +
                       " and eff_dt < sysdate and (exp_dt is null or exp_dt > sysdate)) rank"+ 
                       " where dps.series_num = r.series_num"+
                       "  and rank.staff_num = r.staff_num "+
                       "  and dps.delete_ind = 'N' AND r.delete_ind = 'N'"+
                       "  and r.staff_num ='"+empno+"' "+
                       "  AND dps.str_dt_tm_gmt BETWEEN"+
                       "      to_date('"+yy+mm+"01 00:00', 'yyyymmdd hh24:mi') AND"+
                       "      Last_Day(To_Date('"+yy+mm+"01 23:59', 'yyyymmdd hh24:mi'))"+
                       "  AND r.duty_cd = 'FLY'   AND dps.duty_cd IN ('FLY', 'TVL')"+
                       "  order by str_dt_tm_gmt";
                    */
                  
    //                System.out.println(sql);
                    rs = stmt.executeQuery(sql);
                    if (rs != null) {
                        while (rs.next()) {// ��X��Ƶ���
                            obj = new ReportListFltObj();
                            obj.setFdate(rs.getString("fdate").trim());
                            obj.setFtime(rs.getString("ftime").trim());
                            obj.setEdate(rs.getString("edate").trim());
                            obj.setEtime(rs.getString("eftime").trim());
                            obj.setFltno(rs.getString("fltno"));
                            obj.setSpecial_indicator(rs.getString("special_indicator"));    
                            obj.setSect(rs.getString("dpt") + rs.getString("arv"));
                            obj.setDuty(rs.getString("duty_cd"));
                            //201401 1.35�P�_�ժ�
                            
//                            obj.setFunctionCode(funcCodeAll);
//                            if(rankSql.equals("01")){
//                                obj.setFunctionCode(funcCodeG);
//                            }else if(rankSql.equals("02")){
//                                obj.setFunctionCode(funcCodeS);
//                            }
                            if(jobno == 30 && ( "S".equals(obj.getSpecial_indicator())|| "P".equals(obj.getSpecial_indicator()))){
                                obj.setQual("MP");//"I".equals(obj.getSpecial_indicator()) �Юv
                                
                            }else{
                                obj.setQual(rs.getString("qual"));
                                if("MC".equals(rs.getString("rank").trim()) && !"738".equals(rs.getString("actp").trim())){ 
                                    obj.setQual("PR");//crew_rank_v �� MC, ��738���ন�ưȪ����. 20141028
                                }                                
                            }          
                            obj.setSdate(rs.getString("stdDt"));    
                            obj.setBook_fdate(rs.getString("bookDate").trim());
                            obj.setBook_fltno(rs.getString("bookfltno"));
                            obj.setBook_arln_cd(rs.getString("ARLN_CD"));
                            obj.setAcno(rs.getString("acno"));
                            listSch.add(obj);
                            rowCount++;
                            // if(rowCount > 100) break;
                        }
                    }               
                    //*******************************************************************************               
//                    ReportListPre preObj = new ReportListPre(empno, yy, mm);
//                    if(!preObj.isCheck_pre_mm_done()){//�e��O�_ú��
//                        fltObj.setCheck_pre_mm_done("�e��Ӥ�|��������i");
//                    }
//                    if(preObj.isNoticeQA()){//QA�T��
//                        //fltObj.setNoticeQA("�i�����z�G11/19~23���12/14~21��ȿ��C�Z���ݩ��3�W�խ�SMS Q & A�A\r\n�ñN���G�x��CABIN REPORT�j");
//                        fltObj.setNoticeQA("�i�����z�G7/7~7/10���8/7~8/10��ȿ��C�Z���ݩ��3�W�խ�SMS Q & A�A\r\n�ñN���G�x��CABIN REPORT�j");
//                    }               
//                    fltObj.setResultMsg(preObj.getResultMsg());
//                    fltObj.setErrorMsg(preObj.getErrorMsg());
                    
                  //*******************************************************************************               
//                  cn.setORP3EGUserCP();
//                  dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//                  conn = dbDriver.connect(cn.getConnURL(), null);
//                  stmt = conn.createStatement();
//
////                 ConnectionHelper ch = new ConnectionHelper();
////                 conn = ch.getConnection();
////                 stmt = conn.createStatement();
//                  
////                  sql = " SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,acno,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'') reject "+
////                  " FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
////                  +" AND Last_Day(To_Date('"+yy+mm+"01 2359','yyyymmdd hh24mi'))+1/3  AND psrempn='"+empno+"'";
////                  2014/12 add mapping cflt
//                  sql = "SELECT To_Char(dps.str_dt_tm_loc, 'yyyy/mm/dd') fdate, "
//                        + "       to_char(str_dt_tm_loc, 'hh24mi') ftime, "
//                        + "       dps.flt_num fltno, "
//                        + "       sect, "
//                        + "       psrempn, "
//                        + "       acno, "
//                        + "       psrsern, "
//                        + "       psrname, "
//                        + "       nvl(upd, 'Y') upd, "
//                        + "       nvl(reject, '') reject "
//                        + "  FROM egtcflt,duty_prd_seg_v dps, "
//                        + "       roster_v r "
//                        + " where dps.series_num = r.series_num "
//                        + "   and (fltno = dps.flt_num or fltno =  dps.flt_num || 'Z') "
//                        + "   and sect = (dps.act_port_a || dps.act_port_b) "
//                        + "    AND dps.act_str_dt_tm_gmt BETWEEN "
//                        + "       to_date('"+yy+mm+"01 00:00', 'yyyymmdd hh24:mi') AND "
//                        + "       Last_Day(To_Date('"+yy+mm+"01 23:59', 'yyyymmdd hh24:mi')) "
//                        + "   and fltd between  dps.act_str_dt_tm_gmt-1 and dps.act_str_dt_tm_gmt+1 "
//                        + "   AND r.duty_cd = 'FLY' "
//                        + "   AND dps.duty_cd IN ('FLY', 'TVL') "
//                        + "   AND psrempn = '"+empno+"' "
//                        + "   AND psrempn = staff_num "
//                        + "   and fltd BETWEEN To_Date('"+yy+mm+"01 00:00', 'yyyymmdd hh24:mi') AND "
//                        + "       Last_Day(To_Date('"+yy+mm+"01 2359', 'yyyymmdd hh24mi')) + 1 / 3";
//                  String temp = "";
//                  boolean flag = false;
//                  rs = stmt.executeQuery(sql);
//                  if(rs!= null)
//                  {
//                      while (rs.next()) 
//                      {
//                          ReportListFltObj objTemp = null;
//                          temp = rs.getString("fdate").trim() + "," + rs.getString("fltno").trim()+ "," + rs.getString("sect").trim();
//                          flag = false;
//                          //�Y�L�b�Z����cflt�Z���h�[�J
//                          for(int i=0; i<listSch.size();i++){
//                              if(!(listSch.get(i).getFdate()+ "," +listSch.get(i).getFltno() + "," + listSch.get(i).getSect()).equals(temp)){
//                                  flag = true;
//                              }
//                          } 
//                          if(flag){
//                              objTemp = new ReportListFltObj();
//                              objTemp.setFltno(rs.getString("fltno"));
//                              objTemp.setSect(rs.getString("sect"));
//                              objTemp.setFdate(rs.getString("fdate").trim());
//                              objTemp.setFtime(rs.getString("ftime"));
//                              objTemp.setAcno(rs.getString("acno"));
//                              objTemp.setBook_arln_cd("CI");
//                              objTemp.setDuty("FLY");
//                              obj.setBook_fdate(rs.getString("fdate").trim());
//                              obj.setBook_fltno(rs.getString("fltno"));
//                              obj.setBook_arln_cd(rs.getString("fltno"));
//                              objTemp.setQual("CM");
//                              listSch.add(objTemp);
//                          }
//                      }
//                  }
                //*******************************************************************************
                    
                } catch (Exception e) {
                    fltObj.setResultMsg("0");  
                    exStr = e.toString()+sql;
                    fltObj.setErrorMsg("Error :Flt Schedule");
    //                System.out.println(e.toString());
                } finally {
//                    String error = "";
                    try {
                        if (rs != null){
                            rs.close();
//                            error += "WS:rs";
                        }
                    } catch (SQLException e) {
//                        error += e.toString();
                    }
                    try {
                        if (stmt != null){
                            stmt.close();
//                            error += "WS:stmt";
                        }
                    } catch (SQLException e) {
//                        error += e.toString();
                    }
                    try {
                        if (conn != null){
                            conn.close();
//                            error += "WS:conn";
                        }                            
                    } catch (SQLException e) {
//                        error += e.toString();
                    }
//                    System.out.println("sch end" + error);
//                    try{
//                        fw = new FileWriter(path+"serviceLog.txt",true);
//                        fw.write(new java.util.Date() + " Empno : "+empno +"\r\n");    
//                        fw.write("Schedule2 code :"+fltObj.getResultMsg() +"  "+ fltObj.getErrorMsg()+"\r\n");
//                        fw.write("****************************************************************\r\n"); 
//                        fw.flush();
//                        fw.close();
//                        
//                        if(null!=fw){ 
//                            fw.flush();
//                            fw.close();
//                        }
//                    }
//                    catch (Exception e1){
////                        System.out.println("e1"+e1.toString());
//                    }                    
                }
                try{
                    for(int i=0 ;i<listSch.size();i++){                        
                        ReportListFltObj obj1= (ReportListFltObj) listSch.get(i);
                        fdate = obj1.getFdate();
                        ftime = obj1.getFtime();
                        dd = fdate.substring(8); 
    //                  fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate.substring(0, 4) + 
    //                          fdate.substring(5, 7)+ 
    //                          fdate.substring(8),rs.getString("fltno"), rs.getString("dpt")+ 
    //                          rs.getString("arv"),rs.getString("stdDt"));
                        fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate.substring(0, 4) + 
                                fdate.substring(5, 7)+ 
                                fdate.substring(8),obj1.getFltno(), obj1.getSect(),obj1.getSdate());
                        if (gf.getFltnoWithSuffix().indexOf("Z") > -1) {
                            // �̫�@�X��Z�ɡA���ˬddelay�Z�����X
                            obj1.setFltno(gf.getFltnoWithSuffix());
                            // System.out.println(gf.getFltnoWithSuffix());                            
                        }                        
                    }
                    if (rowCount > 0) {
                        ReportListFltObj[] array = new ReportListFltObj[listSch.size()];
                        listStatus = new ReportListCfltUpdObj[listSch.size()];                                        
                        for (int i = 0; i < listSch.size(); i++) {
                            array[i] = (ReportListFltObj) listSch.get(i);
                            if(array[i].getQual().equals("CM") || array[i].getQual().equals("MC")){//���o�浧CM/MC report���A��T
                                getPurCflt(empno, array[i].getFdate(), array[i].getFltno(),array[i].getSect());                      
                                listStatus[i] = cfltObj;
        //                        System.out.println("chkitem:"+cfltObj.getHasChkItem()+"hasProj"+cfltObj.getHasProj()+"SFLY:"+cfltObj.getHasPRSFly());
                                cfltObj = null;//�M��                     
                            }
                        }                     
                        fltObj.setStatus(listStatus);
                        fltObj.setSchList(array);
                        fltObj.setResultMsg("1");
                        fltObj.setErrorMsg("");
                    } else {
                        fltObj.setResultMsg("1");
                        fltObj.setErrorMsg("NO data");
//                        fltObj.setErrorMsg("NO data + sql = "+sql);      
                         
                    }
                }catch (Exception e1){
//                  fltObj.setResultMsg("0");  
                    exStr = e1.toString()+sql;
                    fltObj.setErrorMsg("Error2 :Flt Schedule");
                }
            }else{
                fltObj.setResultMsg("1");
                fltObj.setErrorMsg("�d�ߵ���,�ثe�}��Z���d�߼ȭ�CM,MC.");
            }//!"".equals(rankSql)
        }//!pc.isPublished()
        try{
            fw = new FileWriter(path+"serviceLog.txt",true);
            fw.write(new java.util.Date() + " Empno : "+empno +"\r\n");    
            fw.write("Schedule1 "+mm+" code :"+fltObj.getResultMsg() +" "+ fltObj.getErrorMsg() +":"+ exStr +"\r\n");
            fw.write("****************************************************************\r\n"); 
            fw.flush();
            fw.close();
        }
        catch (Exception e1){
//            System.out.println("e1"+e1.toString());
        }
    }

    // ��X�ӯZ�O�_�w�s��
    public void getPurCflt(String empno, String fdate, String fltno,String sect) {// yyyy/mm/dd

        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        String yy = fdate.substring(0, 4);
        String mm = fdate.substring(5, 7);
        boolean flag = false;//�O�_�ݼg���i
        String wflg = "";
        //
        GregorianCalendar cal4 = new GregorianCalendar();//today
        cal4.set(Calendar.HOUR_OF_DAY,00);
        cal4.set(Calendar.MINUTE,01);
        //Fltd+1��
        GregorianCalendar cal5 = new GregorianCalendar();
        cal5.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
        cal5.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
        cal5.set(Calendar.DATE,Integer.parseInt(fdate.substring(8))); 
        cal5.add(Calendar.DATE,1);  
        //fltd-1
        GregorianCalendar cal6 = new GregorianCalendar();
        cal6.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
        cal6.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
        cal6.set(Calendar.DATE,Integer.parseInt(fdate.substring(8)));
        cal6.add(Calendar.DATE,-1);  
        try {
              ConnDB cn = new ConnDB();
              cn.setORP3EGUserCP();
              dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
              conn = dbDriver.connect(cn.getConnURL(), null);
              stmt = conn.createStatement();

//             ConnectionHelper ch = new ConnectionHelper();
//             conn = ch.getConnection();
//             stmt = conn.createStatement();
                  
             sql =
                "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,acno,psrsern,psrname,acno,nvl(upd,'Y') upd,nvl(reject,'') reject,to_char(chgdate,'yyyy/mm/dd hh24:mi') chgdate "+//crpt.flag,
                "FROM egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno ='"+fltno+"' and sect='"+sect+"' and psrempn = '"+empno+"'" ;
             //"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') AND Last_Day(To_Date('"+yy+mm+"01 2359','yyyymmdd hh24mi'))+1/3  AND psrempn='"+empno+"'";
             
             //"SELECT To_Char(cflt.fltd,'yyyy/mm/dd') fdate,cflt.fltno,cflt.sect,psrempn,acno,psrsern,psrname,acno,nvl(upd,'Y') upd,nvl(reject,'') reject,cflt.chgdate "+//crpt.flag,
             //"FROM egtcflt cflt ,egtcrpt crpt WHERE " +
             //"cflt.psrempn = crpt.empno and crpt.fltd = cflt.fltd  and crpt.fltno = cflt.fltno and crpt.sect = cflt.sect and " +
             //"cflt.fltd = to_date('"+fdate+"','yyyy/mm/dd') and cflt.fltno ='"+fltno+"' and cflt.sect='"+sect+"'";
            rs = stmt.executeQuery(sql);
            
            cfltObj = new ReportListCfltUpdObj();
     
            if(rs != null){
                if (rs.next()) {
                    wflg = "Y";
                    cfltObj.setWflag(wflg);// Y:egtcflt��,N:egtcflt�L
                    cfltObj.setUpd(rs.getString("upd"));// Y:�i�s��,N:���i                                                          
                    cfltObj.setReject(rs.getString("reject"));
                    cfltObj.setAcno(rs.getString("acno"));
                    cfltObj.setChgdate(rs.getString("chgdate"));
                    cfltObj.setFltd(rs.getString("fdate"));
                    cfltObj.setFltno(rs.getString("fltno"));
                    cfltObj.setSect(rs.getString("sect")); 
                    //�P�_���i�O�_�L����ú                        
                    //�DTVL Flt && �DInspector Flt, ���󤵤Ѫ�fltd�S��ú��h����אּ���
                    if(cal4.after(cal5) && (!"N".equals(cfltObj.getUpd())) && (yy+"/"+mm).equals(fdate.substring(0,7)) 
//                            && !"TVL".equals(rs.getString("duty_cd")) && !"I".equals(rs.getString("special_indicator"))
                    ){
                        cfltObj.setLate(true);
                    }
                    cfltObj.setResultMsg("1");
                    //cfltObj.setErrorMsg(sql);
                }
                else {
                    wflg = "N";
                    cfltObj.setFltd(fdate);
                    cfltObj.setFltno(fltno);
                    cfltObj.setSect(sect); 
                    cfltObj.setWflag(wflg);// Y:egtcflt��,N:egtcflt�L
                    if(cal6.after(cal4)){//���s�褧���i,10/22���i�s��10/23
                        cfltObj.setUpd("N");
                    }else{
                        cfltObj.setUpd("Y");
                    }
                    //�P�_���i�O�_�L����ú    
                    //�DTVL Flt && �DInspector Flt, ���󤵤Ѫ�fltd�S��ú��h����אּ���
                    if(cal4.after(cal5) && (!"N".equals(cfltObj.getUpd())) && (yy+"/"+mm).equals(fdate.substring(0,7)) 
//                  && !"TVL".equals(rs.getString("duty_cd")) && !"I".equals(rs.getString("special_indicator"))
                            ){
                        cfltObj.setLate(true);
                    }
                    cfltObj.setResultMsg("1");
//                    cfltObj.setErrorMsg("Not Edit yet.");//+cal4.DATE +cal6.DATE
                }
                
            }
            
        } catch (Exception e) {
            cfltObj.setResultMsg("0");
            cfltObj.setErrorMsg("error cflt : " + e.toString());
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
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
        try
        {
            if(!"".endsWith(wflg)){
          //�O�_��ZC���i
//          cfltObj.setHasZc(ReportListHasZc(empno, fdate, fltno, sect));
              CheckSFLYRpt sfly = new CheckSFLYRpt();
              //�ۧڷ���
              cfltObj.setHasPRSFly(sfly.ReportListHasPRSFly(empno, fdate, fltno, sect, wflg, cfltObj.getUpd()));
              //�M��
              cfltObj.setHasProj(sfly.ReportListHasProj(empno, fdate, fltno, sect, wflg, cfltObj.getUpd()));
              //�l��
              cfltObj.setHasChkItem(sfly.ReportListHasCkeItem(empno, fdate, fltno, sect, wflg , cfltObj.getUpd()));
            }
        }
        catch ( Exception e )
        {
            // TODO: handle exception
        }
    }
    
    //�����OCrew or �줽��
    public int getEmpnoType(String empno){
        UserID uid ;
        CheckHR ckHR;
        CheckFZCrew ckCrew;
        int type = 0;
        try {            
            //set id
            uid = new UserID(empno, "");
            // check HR
            ckHR = new CheckHR();
            // check fzcrew
            ckCrew = new CheckFZCrew();

            if (empno == null)
            {
                type = 0; // �L�b��
            }

            else if (ckCrew.isFZCrew())
            {
                type = 1;// crew
            }

            else if ("Y".equals(ckHR.getHrObj().getExstflg())
                    && !"200".equals(ckHR.getHrObj().getAnalysa()))
            {
                type = 2;// Eip�b¾,���D�῵�խ�,�줽�ǤH��
            }
            else
            {
                type = 3;// ���L���
            }   
        } catch (Exception e) {
            type = 99;
        }   
        return type;
    }
    
    //CM info
    public void getPurInfo(String empno) {
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        purObj = new PurInfoObj();
        try {
            ConnDB cn = new ConnDB();
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
//          //connect ORT1 EG     
//            cn.setORP3EGUser();
////          cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            
            stmt = conn.createStatement();
            sql = "select cname,ename,sern,groups,station,status,j.ejob rank ,c.jobno jobno from egtcbas c,egtjobi j"
                    + " where c.jobno = j.jobno "
                    + " and c.empn ='" + empno + "'";
            rs = stmt.executeQuery(sql);
            if (rs.next())
            {
                purObj.setPsrCName(rs.getString("cname"));
                purObj.setPsrEname(rs.getString("ename"));
                purObj.setPsrSern(rs.getString("sern"));
                purObj.setPsrGrp(rs.getString("groups"));
                purObj.setPsrBase(rs.getString("station"));
                purObj.setPsrStatus(rs.getString("status"));
                purObj.setRank(rs.getString("rank"));
                purObj.setJobno(rs.getString("jobno"));
                purObj.setResultMsg("1");
            }
            else
            {
                purObj.setResultMsg("1");
                purObj.setErrorMsg("Not Data.");
            }            
        } catch (Exception e) {
            purObj.setResultMsg("0");
            purObj.setErrorMsg("error info: "+ e.toString());
        } finally {
//            String error = "";
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
//                error+=e.toString();
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
//                error+=e.toString();
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
//                error+=e.toString();
            }
//            System.out.println("getPurInfo end" + error);
        }

    }
    
    //ground sys export data 
    public void getEmpInfo(String empno) {

        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        ArrayList info = new ArrayList();
        empObj = new EmpnoInfoRObj();
        empno = empno.replace("/", "','");
        boolean crew = false;
        boolean empn = false;
        try {
            ConnDB cn = new ConnDB();
            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement();            
            
//           cn.setORT1FZ();
//           java.lang.Class.forName(cn.getDriver());
//           conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
//           stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
           sql = "select empn, cname,ename,sern,groups,station,status,j.ejob rank from egtcbas c,egtjobi j"
                    + " where c.jobno = j.jobno "
                    + " and c.empn in ('" + empno+ "')";
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if (null != rs)
            {
                while (rs.next())
                {
                    PurInfoObj obj = new PurInfoObj();
                    obj.setEmpno(rs.getString("empn"));
                    obj.setPsrCName(rs.getString("cname"));
                    obj.setPsrEname(rs.getString("ename"));
                    obj.setPsrSern(rs.getString("sern"));
                    obj.setPsrGrp(rs.getString("groups"));
                    obj.setPsrBase(rs.getString("station"));
                    obj.setPsrStatus(rs.getString("status"));
                    obj.setRank(rs.getString("rank"));
                    obj.setResultMsg("1");
                    info.add(obj);
                }
                crew = true;
            }
            else
            {
                crew = false;
            }
            
            if (null != rs){
                rs.close();
            }
                
            sql = " select employid,cname,LNAME||','|| FNAME ename ,analysa,exstflg from hrvegemploy where "
                    + " employid in ('"+ empno+"')"
                    + " and analysa <> 200 and exstflg = 'Y'";// �D�խ�
            rs = stmt.executeQuery(sql);
            if (null != rs)
            {
                while (rs.next())
                {
                    PurInfoObj obj = new PurInfoObj();
                    obj.setEmpno(rs.getString("employid"));
                    obj.setPsrCName(rs.getString("cname"));
                    obj.setPsrEname(rs.getString("ename"));
                    obj.setPsrSern("");
                    obj.setPsrGrp("");
                    obj.setPsrBase("");
                    obj.setPsrStatus("");
                    obj.setRank("");
                    obj.setResultMsg("1");
                    info.add(obj);
                }
                empn = true;
            }
            else
            {
                empn = false;
            }
            if(!empn && !crew){
                empObj.setResultMsg("1");
                empObj.setErrorMsg("No data!");
            }else{
                PurInfoObj[] array = new PurInfoObj[info.size()];                                        
                for (int i = 0; i < info.size(); i++) {
                    array[i] = (PurInfoObj) info.get(i);
//                    System.out.println(array[i].getPsrCName());
                }                     
                empObj.setInfo(array);
                empObj.setResultMsg("1");
            }
            
        } catch (Exception e) {
            empObj.setResultMsg("0");
            empObj.setErrorMsg("error info: "+ e.toString());
//            System.out.println( e.toString());
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
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }

    }
   
    //MVC
    public void getMVC(String empno ,String fdate ,String fltno ,String sector){
        //fdate = "2013/07/08";
        //fltno = "0916";
        //sector = "HKGTPE";
        //purempn = "630304";
        GregorianCalendar cal1 = new GregorianCalendar();//today
        cal1.set(Calendar.HOUR_OF_DAY,00);
        cal1.set(Calendar.MINUTE,01);   
        
        //�T�ѫ�
        GregorianCalendar cal2 = new GregorianCalendar();
        cal2.add(Calendar.DATE,4);      

        //Fltd
        GregorianCalendar cal3 = new GregorianCalendar();
        cal3.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
        cal3.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
        cal3.set(Calendar.DATE,Integer.parseInt(fdate.substring(8)));       
        mvcObj = new ReportListMVCObj(); 
        //if(cal1.before(cal3) && cal2.after(cal3)) 
        if(cal1.before(cal3) && cal2.after(cal3) )
//                && ("632934".equals(empno) | "630304".equals(empno) | "628812".equals(empno) | "626929".equals(empno) | "630752".equals(empno) | "630557".equals(empno) | "631023".equals(empno) | "630937".equals(empno) | "630473".equals(empno) | "631748".equals(empno) )) 
        {//�T�Ѥ�����Z�~�i�d��MVC
            String flt_str = "";
            GregorianCalendar cal4 = new GregorianCalendar();
            cal4.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
            cal4.set(Calendar.MONTH,Integer.parseInt(fdate.substring(5,7))-1);
            cal4.set(Calendar.DATE,Integer.parseInt(fdate.substring(8,10)));
            SimpleDateFormat dFormat = new SimpleDateFormat("ddMMM", Locale.US);
            if(fltno.length()==6){
                flt_str = "*"+fltno+"/"+dFormat.format(cal4.getTime()).toUpperCase()+"/"+sector.substring(0,3);//20131220 ��� ��t ��J CI/AE (�j�g)
            }else{
                flt_str = "*CI"+fltno+"/"+dFormat.format(cal4.getTime()).toUpperCase()+"/"+sector.substring(0,3);
            }
                       
            MVCRecord mvc = new MVCRecord();
            //String cardnum = mvc.getCardnum(empno,flt_str);   
            String cardnum = null;
            cardnum = mvc.getCardnum2(empno,flt_str);
            
            if(!"".equals(cardnum)){
//                mvc.getMVCData(cardnum);
                mvc.getMVCData2(cardnum);
                ArrayList listMvc = new ArrayList(); 
                listMvc = mvc.getObjAL();               
                MVCObj[] array = new MVCObj[listMvc.size()];
                for (int i = 0; i < listMvc.size(); i++) {
                    array[i] = (MVCObj) listMvc.get(i);
                }
                mvcObj.setMvcList(array);
                if(mvc.getStr().equals("Y")){
                    mvcObj.setResultMsg("1");
                }else if(!"".equals(mvc.getStr()) && null!=mvc.getStr()){
                    mvcObj.setResultMsg("0");
                    mvcObj.setErrorMsg("MVC:"+mvc.getStr());                     
                }               
            } else {
                mvcObj.setResultMsg("1");
                mvcObj.setErrorMsg("No Data!");
                //dummy --------
                /*cardnum = "'AA0001675','AC0015355','AH0019675'";
                mvc.getMVCData2(cardnum); 
                ArrayList listMvc = new ArrayList(); 
                listMvc = mvc.getObjAL();               
                MVCObj[] array = new MVCObj[listMvc.size()];
                for (int i = 0; i < listMvc.size(); i++) {
                    array[i] = (MVCObj) listMvc.get(i);
                }
                mvcObj.setMvcList(array);
                if(mvc.getStr().equals("Y")){
                    mvcObj.setResultMsg("1");
                }else{
                    mvcObj.setResultMsg("0");
                    mvcObj.setErrorMsg("MVC2:"+mvc.getStr());
                }    */            
                
                //dummy -------------
//                mvcObj.setResultMsg("0");
//                mvcObj.setErrorMsg("NO data");
            }
        } else {
            mvcObj.setResultMsg("0");
            mvcObj.setErrorMsg("MVC information is not available");
        }
        
    }
    
    //���LZC
    public String ReportListHasZc(String empno,String fdate,String fltno,String sect){
        //ZC Report
        eg.zcrpt.ZCReport zcrt2 = new eg.zcrpt.ZCReport();
        zcrt2.getZCFltListForPR(fdate,fltno,sect,empno);
        ArrayList zcAL2 = new ArrayList();
        zcAL2 = zcrt2.getObjAL();
        String r = "none";
        if(zcAL2.size()>0){
            eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL2.get(0);
            if("Y".equals(zcobj.getIfsent())){//�w�e�X
                r = "Y";
            }else{//�s�褤
                r = "N";
            }
        }
        return r;
    }
    
    //��l�խ��W��
    public void getOriCrewList(String fltdate, String fltno, String ftime,
            String port, String inner_sect) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
        
        
        
        if ((inner_sect == null | "".equals(inner_sect)) && port != null
                && !"".equals(port)) {
            inner_sect = port;
        }
        String yy = fltdate.substring(0, 4);
        String mm = fltdate.substring(4, 6);

        // �ˬd�Z���O�_����
        swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yy, mm);

        if (!pc.isPublished()) {
            // �D��ȡB�ŪAñ���̡A�~�ˬd�Z���O�_���G

        } else {
            aircrew.CrewInfo cc = new aircrew.CrewInfo();
            StringBuffer sb = new StringBuffer();
            sb.append("SELECT d.series_num,to_char(act_str_dt_tm_gmt,'yyyymmdd hh24mi') actStrDt,");
            sb.append("To_Char(d.str_dt_tm_loc,'mm/dd hh24mi') str_dt_loc,To_Char(d.end_dt_tm_loc,'mm/dd hh24mi') end_dt_loc,");
            sb.append("d.flt_num,d.act_port_a||d.act_port_b sector, d.fleet_cd,d.flt_num ,rr.staff_num,rr.special_indicator,");
            sb.append("(CASE WHEN d.duty_cd='TVL' THEN 'TVL' ELSE '' END )   ACM ,cc.Rank_cd,cc.ename,cc.grp,cc.sern ,cc.cname ");
            sb.append(" FROM duty_prd_seg_v d ,");
            /* ���o�ӯZ�խ� */
            sb.append(" ( select r.series_num,r.staff_num,r.special_indicator  FROM roster_v r  WHERE r.delete_ind='N'   ) rr ,");
            /* ���o�խ���� */
            sb.append("  (SELECT c.staff_num,cv.rank_cd Rank_cd, c.other_surname||' '||c.other_first_name ename,");
            sb.append("    c.preferred_name  cname, c.section_number grp, LTrim(LPad(Nvl(Trim(c.seniority_code),'0'),12,'0'),'0') sern ");
            // sb.append("    c.preferred_name  cname, c.section_number grp, ltrim(c.seniority_code,'0') sern ");

            sb.append("  FROM crew_v c,crew_rank_v cv ");
            sb.append("  WHERE c.staff_num = cv.staff_num  AND cv.eff_dt<= To_Date(?,'yyyymmdd') ");
            sb.append("AND (cv.exp_dt IS null  OR cv.exp_dt >= To_Date(?,'yyyymmdd') ) ) cc ");
            sb.append("WHERE d.series_num = rr.series_num  AND rr.staff_num = cc.staff_num ");
            sb.append(" AND d.act_str_dt_tm_gmt BETWEEN (To_Date(?,'yyyymmdd hh24mi') - 2) and (To_Date(?,'yyyymmdd hh24mi') + 2) ");
            sb.append(" AND d.str_dt_tm_loc BETWEEN  To_Date(?,'yyyymmdd hh24mi') AND To_Date(?,'yyyymmdd hh24mi') ");

            sb.append(" AND d.delete_ind='N' AND d.duty_cd in ('FLY','TVL')"); 

            //2013/10/29 delay�Z--no data���D
            if(fltno.indexOf("Z") > -1){
               fltno = fltno.substring(0,4);
               sb.append("AND d.flt_num in ('"+fltno+"','"+fltno+"Z') ");
            }else{
               sb.append("AND d.flt_num='"+fltno+"' ");
            }
            /* ����q�ɡA�ݿ�JSector */
            if (null != inner_sect && !"".equals(inner_sect)) {

                sb.append("and d.act_port_a||d.act_port_b=upper('" + inner_sect
                        + "') ");
            }
            /* �ƧǮɡA�e���ƫe���A�῵PR�ƫe���A��l�ӧǸ��� */
            sb.append("  ORDER BY d.fd_ind DESC,  ");
            // sb.append("decode(cc.rank_cd,'PR','1','FC','2',rr.staff_num) ");
            // sb.append("decode(cc.rank_cd,'PR',1,'FC',2,To_Number(cc.sern,0)) ");
            sb.append("decode(cc.rank_cd,'PR','00001','FC','00002',lpad(cc.sern,5,'0')) ");

            Driver dbDriver = null;
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            ConnDB cn = new ConnDB();
            ArrayList dataAL = null;
            boolean status = false;
            String sect = null;
            String dpt = null;
            oriCrewObj = new CrewListRObj();
            try {
                cn.setAOCIPRODCP();
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                conn = dbDriver.connect(cn.getConnURL(), null);

                pstmt = conn.prepareStatement(sb.toString());
                pstmt.setString(1, fltdate);
                pstmt.setString(2, fltdate);
                // pstmt.setString(3,fltdate+" 0000");
                // pstmt.setString(4,fltdate+" 2359");
                pstmt.setString(3, fltdate + " 0000");
                pstmt.setString(4, fltdate + " 2359");
                pstmt.setString(5, fltdate + " " + ftime);
                pstmt.setString(6, fltdate + " " + ftime);                
//                pstmt.setString(7, fltno);

                rs = pstmt.executeQuery();
                while (rs.next()) {

                    if (dataAL == null) {
                        dataAL = new ArrayList();
                    }
                    CrewListObj obj = new CrewListObj();
                    obj.setAcm(rs.getString("acm"));
                    obj.setCname(cc.getCname(rs.getString("staff_num")));
                    obj.setEmpno(rs.getString("staff_num"));
                    obj.setEname(rs.getString("ename"));
                    obj.setEndDate(rs.getString("end_dt_loc"));
                    obj.setFleet(rs.getString("fleet_cd"));
                    obj.setFltno(rs.getString("flt_num"));
                    obj.setGrp(rs.getString("grp"));
                    obj.setQual(rs.getString("Rank_cd"));
                    obj.setSector(rs.getString("sector"));
                    sect = rs.getString("sector");
                    dpt = sect.substring(0, 3);
                    // �ư��h��A�u�Ǹ���줺�e�� [null]��
                    if (!"null".equals(rs.getString("sern"))) {
                        obj.setSerno(rs.getString("sern"));
                    }

                    obj.setSpcode(rs.getString("special_indicator"));
                    obj.setStartDate(rs.getString("str_dt_loc"));
                    obj.setSeries_num(rs.getString("series_num"));
                    obj.setAct_str_dt_tm_gmt(rs.getString("actStrDt"));
                    dataAL.add(obj);
                }
                rs.close();
                pstmt.close();

                if (dataAL != null) {
                    for (int i = 0; i < dataAL.size(); i++) {
                        CrewListObj obj = (CrewListObj) dataAL.get(i);
                        // ***********************************************************
                        // Set Credit Hour
                        fzac.CreditHrsForDispatch crh = new fzac.CreditHrsForDispatch(
                                obj.getEmpno(), yy + mm);
                        crh.SelectSingleCrew();
                        // obj.setCr(crh.getCrewCrinMin());
                        obj.setCr(ci.tool.TimeUtil.minToHHMM(crh
                                .getCrewCrinMin()));

                        if (!"6".equals(obj.getEmpno().substring(0, 1))
                                | "K".equals(obj.getSpcode())
                                | "J".equals(obj.getSpcode())
                                | "I".equals(obj.getSpcode())
                                | "PR".equals(obj.getQual())
                                | "CA".equals(obj.getQual())
                                | "FO".equals(obj.getQual())
                                | "FE".equals(obj.getQual())
                                | "RP".equals(obj.getQual())) {
                            obj.setPriority("0");
                        } else {
                            obj.setPriority(crh.getCrewCrinMin());
                        }
                        // ***********************************************************

                        // ���o�խ��\
                        pstmt = conn
                                .prepareStatement("SELECT staff_num, meal_type "
                                        + "FROM acdba.crew_special_meals_t "
                                        + "WHERE eff_fm_dt <= to_date(?,'yyyymmdd') "
                                        + "AND (eff_to_dt >= to_date(?,'yyyymmdd') OR eff_to_dt IS NULL ) "
                                        + "AND staff_num =?");
                        pstmt.setString(1, fltdate);
                        pstmt.setString(2, fltdate);
                        pstmt.setString(3, obj.getEmpno());
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            obj.setMeal(rs.getString("meal_type"));
                        }
                        rs.close();
                        pstmt.close();

                        pstmt = conn
                                .prepareStatement("select to_char(arvtm,'HH24:MI')||'/'||fltno lastfly "
                                        + "from (select dps.act_end_dt_tm_gmt arvtm, dps.flt_num fltno "
                                        + "from duty_prd_seg_v dps, roster_v r "
                                        + "where dps.series_num=r.series_num "
                                        + "and dps.act_str_dt_tm_gmt between to_date(?,'yyyymmdd')  "
                                        + "and (to_date(?,'yyyymmddHH24MI') - (1/1440))  "
                                        + "and dps.delete_ind='N' and r.delete_ind='N' "
                                        + "and dps.series_num=? "
                                        + "and dps.duty_cd in ('TVL','FLY') "
                                        + "order by dps.act_end_dt_tm_gmt desc) where rownum=1");
                        pstmt.setString(1, obj.getAct_str_dt_tm_gmt()
                                .substring(0, 8));
                        pstmt.setString(2, obj.getAct_str_dt_tm_gmt());
                        pstmt.setString(3, obj.getSeries_num());
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            obj.setLastFlight(rs.getString("lastfly"));
                        }
                        rs.close();
                        pstmt.close();

                        pstmt = conn.prepareStatement("select staff_num,nvl(no_show,'Y') no_show,"
                                        + "(CASE WHEN dp.no_show='N' THEN 'Y' ELSE 'N' END ) chkin from crew_dops_v dp "
                                        + "where flt_dt_tm between to_date(?,'yyyy/mm/dd HH24MI') "
                                        + "and to_date(?,'yyyy/mm/ddHH24MI') "
                                        + "and flt_num=lpad(?,4,'0') and dep_arp_cd=? and staff_num=?");
                        pstmt.setString(1, obj.getAct_str_dt_tm_gmt()
                                .substring(0, 8) + " 0000");
                        pstmt.setString(2, obj.getAct_str_dt_tm_gmt()
                                .substring(0, 8) + " 2359");
                        pstmt.setString(3, obj.getFltno());
                        pstmt.setString(4, obj.getSector().substring(0, 3));
                        pstmt.setString(5, obj.getEmpno());

                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            obj.setIsCheckIn(rs.getString("chkin"));
                        }
                        rs.close();
                        pstmt.close();

                    }

                    conn.close();
                    // ���o �խ�����a�I TODO
//                    cn.setORP3EGUserCP();
                    cn.setORP3FZUserCP();
                    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                    conn = dbDriver.connect(cn.getConnURL(), null);

                    for (int i = 0; i < dataAL.size(); i++) {
                        CrewListObj obj = (CrewListObj) dataAL.get(i);

//                        pstmt = conn.prepareStatement("select rptloc from egdb.egtchkin "
//                                        + "where empno=? "
//                                        + "AND sdate <= to_date(?,'yyyymmdd') "
//                                        + "and edate >= to_date(?,'yyyymmdd')");
                        //20131213�[�J�e���խ�
                        pstmt = conn.prepareStatement(" " +
                        		" select rptloc from egdb.egtchkin where empno = ?" +
                        		"    AND sdate <= to_date(?, 'yyyymmdd')" +
                        		"    and edate >= to_date(?, 'yyyymmdd')" +
                        		" UNION" +
                        		" select decode(rptloc, '0', 'TSA', '1', 'CAL PARK', '2', 'T1/T2', rptloc) rptloc" +
                        		"    from (select rptloc from dfdb.dftcrew_rptloc where empno = ?" +
                        		"    order by chgdt desc)  where rownum = 1");
                        
                        pstmt.setString(1, obj.getEmpno());
                        pstmt.setString(2, obj.getAct_str_dt_tm_gmt().substring(0, 8));
                        pstmt.setString(3, obj.getAct_str_dt_tm_gmt().substring(0, 8));
                        pstmt.setString(4, obj.getEmpno());
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            if (!"TSA".equals(rs.getString("rptloc"))) {
                                obj.setRptLoc(rs.getString("rptloc"));
                            }
                        }
                        rs.close();
                        pstmt.close();

                    }

                    conn.close();
                    status = true;

                    CrewListObj[] array = new CrewListObj[dataAL.size()];
                    for (int k = 0; k < dataAL.size(); k++) {
                        array[k] = (CrewListObj) dataAL.get(k);
                    }
                    oriCrewObj.setCrewList(array);
                    oriCrewObj.setResultMsg("1");
                    oriCrewObj.setErrorMsg("");
                } else {
                    oriCrewObj.setResultMsg("1");
                    oriCrewObj.setErrorMsg("NO data");
                }
            } catch (SQLException e) {
                oriCrewObj.setResultMsg("0");
                oriCrewObj.setErrorMsg("Error ORI Crew List.");
                try{
                    fw = new FileWriter(path+"serviceLog.txt",true);
                    fw.write(new java.util.Date() +" "+ fltdate +" "+ fltno +" "+ ftime +" "+ port+"\r\n");   
                    fw.write("OriCrewList code :"+oriCrewObj.getResultMsg()+"  "+ e.toString() +"\r\n");
                    fw.write("****************************************************************\r\n"); 
                    fw.flush();
                    fw.close();
                }
                catch (Exception e1){
//                    System.out.println("OriCrewList e1"+e1.toString());
                }
            } finally {
                try {
                    if (rs != null)
                        rs.close();
                } catch (SQLException e) {
                }
                try {
                    if (pstmt != null)
                        pstmt.close();
                } catch (SQLException e) {
                }
                try {
                    if (conn != null)
                        conn.close();
                } catch (SQLException e) {
                }
                
            }
        }

    }
    
    //���Z�ȿ��g�z
    public void getActPur(String fdate, String fltno,String sect){//yyyy/mm/dd
        // ���o���Z�~��
        String GdYear = fz.pracP.GdYear.getGdYear(fdate.substring(0, 7));// yyyy/mm
        fltno = fltno.replace('Z', ' ').trim();

        // ���o���
//        fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo(fdate, fltno);
        fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo(fdate, fltno, sect); 
        ArrayList dataAL = null;
        onePurObj = new ActPurObj();
        try {
            ft.RetrieveData();
            dataAL = ft.getDataAL();
            if(dataAL.size()>0){
                FltObj[] array = new FltObj[dataAL.size()];
                for (int i = 0; i < dataAL.size(); i++) {
                    array[i] = (FltObj) dataAL.get(i);
//                    System.out.println(array[i].getPurEmpno());
                }
//                for (int i = dataAL.size()-1; i >= 0; i--) {
//                    array[(dataAL.size()-1)-i] = (FltObj) dataAL.get(i);
////                    System.out.println(array[i].getPurEmpno());
//                }
                onePurObj.setActPurObj(array);
                onePurObj.setResultMsg("1");
            }else{
                onePurObj.setErrorMsg("No data!!");
                onePurObj.setResultMsg("1");
            }
            
        } catch (SQLException e) {
            onePurObj.setErrorMsg("SQL actCM:"+e.toString());
            onePurObj.setResultMsg("0");
        } catch (Exception e) {
            onePurObj.setErrorMsg("actCM:"+e.toString());
            onePurObj.setResultMsg("0");
        }
    
    }
    
    //�����Z�խ��W��,from cflt. ���խ��W��,�L�h��ܭ�l�խ��W��
    public void getMdCrewList(String empno,String sdate, String fltno, String sect){
        String sql= "";
        int count = 0;
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet myResultSet = null;
        String fdate = sdate.substring(0,10);
        String GdYear = fz.pracP.GdYear.getGdYear(fdate.substring(0, 7));// yyyy/mm
//        System.out.println(fdate);
        PurReport pr = new PurReport();    
        String exStr = "";
        if(!"".equals(empno)){
            empno = empno.trim();
        }
        try{
            
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();           
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
         
//            //�����s�u
//            ConnectionHelper ch = new ConnectionHelper();
//            conn = ch.getConnection();
//            stmt = conn.createStatement();
            
            sql = " select count(*) cnt from egtcflt " +
                         " where fltd = to_date('"+fdate+"','yyyy/mm/dd') and sect ='"+sect+"' and fltno = '"+fltno+"' and psrempn = '"+empno+"'" +
                         " and empn1 is not null"; 

            myResultSet = stmt.executeQuery(sql);
            if(myResultSet.next()){
                count = Integer.parseInt(myResultSet.getString("cnt"));
            }      
            if (myResultSet != null) myResultSet.close();
            
            if(count > 0){
                //egtcflt �ܤ֦��@empn �����
                sql = "SELECT FLTD, FLTNO, SECT, CPNAME, CPNO, ACNO, to_char(chgdate,'yyyymmdd hh24miss') chgdate ,PSREMPN, PSRSERN, PSRNAME, PGROUPS, "
                        + " EMPN1, SERN1, CREW1, SCORE1, EMPN2, SERN2, CREW2, SCORE2, EMPN3, SERN3, CREW3, SCORE3, EMPN4, SERN4, CREW4, SCORE4, EMPN5, SERN5, CREW5, SCORE5, EMPN6, SERN6, CREW6, SCORE6, EMPN7, SERN7, CREW7, SCORE7, EMPN8, SERN8, CREW8, SCORE8, EMPN9, SERN9, CREW9, SCORE9, EMPN10, SERN10, CREW10, SCORE10, EMPN11, SERN11, CREW11, SCORE11, EMPN12, SERN12, CREW12, SCORE12, EMPN13, SERN13, CREW13, SCORE13, EMPN14, SERN14, CREW14, SCORE14, EMPN15, SERN15, CREW15, SCORE15, EMPN16, SERN16, CREW16, SCORE16, EMPN17, SERN17, CREW17, SCORE17, EMPN18, SERN18, CREW18, SCORE18, EMPN19, SERN19, CREW19, SCORE19, EMPN20, SERN20, CREW20, SCORE20, CHGUSER, CHGDATE, REMARK, BOOK_F, BOOK_C, BOOK_Y,BOOK_W, PXAC, UPD, INF, DUTY1, DUTY2, DUTY3, DUTY4, DUTY5, DUTY6, DUTY7, DUTY8, DUTY9, DUTY10, DUTY11, DUTY12, DUTY13, DUTY14, DUTY15, DUTY16, DUTY17, DUTY18, DUTY19, DUTY20,"
                        + " REJECT, REJECT_DT, REPLY, BDOT, BDTIME, BDREASON, "
                        + " to_char(sh_st1,'yyyy/mm/dd hh24:mi') SH_ST1, to_char(sh_et1,'yyyy/mm/dd hh24:mi') SH_ET1,"
                        + " to_char(sh_st2,'yyyy/mm/dd hh24:mi') SH_ST2, to_char(sh_et2,'yyyy/mm/dd hh24:mi') SH_ET2, "
                        + " to_char(sh_st3,'yyyy/mm/dd hh24:mi') SH_ST3, to_char(sh_et3,'yyyy/mm/dd hh24:mi') SH_ET3,"
                        + " to_char(sh_st4,'yyyy/mm/dd hh24:mi') SH_ST4, to_char(sh_et4,'yyyy/mm/dd hh24:mi') SH_ET4, "
                        + " SH_CREW1, SH_CREW2, SH_CREW3, SH_CREW4, SH_CREW5, SH_CREW6, SH_CREW7, SH_CREW8, SH_CREW9, SH_CREW10, SH_CREW11, SH_CREW12, SH_CREW13, SH_CREW14, SH_CREW15, SH_CREW16, SH_CREW17, SH_CREW18, SH_CREW19, SH_CREW20, SH_REMARK, SHIFT,SH_CM ,SH_MP,MP_EMPN"
                        + " FROM egtcflt WHERE fltd=to_date('"+ fdate+ "','yyyy/mm/dd') AND fltno='"+ fltno+ "' AND sect ='" + sect + "' AND psrempn = '"+empno+"'";
                mdCrewObj = new MdCrewListObj();
                myResultSet = stmt.executeQuery(sql);
                String[] empn = new String[mdCrewObj.getCrewNum()];
                String[] sern = new String[mdCrewObj.getCrewNum()];
                String[] crew = new String[mdCrewObj.getCrewNum()];
                String[] crewgrp = new String[mdCrewObj.getCrewNum()];
                String[] score = new String[mdCrewObj.getCrewNum()];
                String[] duty = new String[mdCrewObj.getCrewNum()];
                String[] shift = new String[mdCrewObj.getCrewNum()];
                String[] sh_staTime = new String[mdCrewObj.getShNum()];
                String[] sh_endTime = new String[mdCrewObj.getShNum()];
                int cCount = 0;
                
                if (myResultSet.next()) {
                    mdCrewObj.setFltno(fltno);
                    mdCrewObj.setCpname(myResultSet.getString("cpname"));
                    mdCrewObj.setCpno(myResultSet.getString("cpno"));
                    mdCrewObj.setPsrempn(myResultSet.getString("psrempn"));
                    mdCrewObj.setPsrsern(myResultSet.getString("psrsern"));
                    mdCrewObj.setPsrname(myResultSet.getString("psrname"));
                    mdCrewObj.setPgroups(myResultSet.getString("pgroups"));
                    mdCrewObj.setMp_empn(myResultSet.getString("mp_empn"));
                    mdCrewObj.setSh_mp(myResultSet.getString("sh_mp"));
//                    mdCrewObj.setMpname(mpname);
                    mdCrewObj.setAcno(myResultSet.getString("acno"));
                    mdCrewObj.setChgdate(myResultSet.getString("chgdate"));
                    for (int i = 0; i < mdCrewObj.getEmpn().length; i++) {
                        empn[i] = myResultSet.getString("empn"+ String.valueOf(i + 1));
                        sern[i] = myResultSet.getString("sern"+ String.valueOf(i + 1));
                        crew[i] = myResultSet.getString("crew"+ String.valueOf(i + 1));
                        crewgrp[i] = pr.getGroups(sern[i]);
                        score[i] = myResultSet.getString("score"+ String.valueOf(i + 1));
                        duty[i] = myResultSet.getString("duty"+ String.valueOf(i + 1));
                        shift[i] = myResultSet.getString("SH_CREW"+ String.valueOf(i + 1));
                        if (!empn[i].equals("000000")) cCount++;
                    }
                    mdCrewObj.setEmpn(empn);
                    mdCrewObj.setSern(sern);
                    mdCrewObj.setCrew(crew);
                    mdCrewObj.setCrewgrp(crewgrp);
                    mdCrewObj.setScore(score);
                    mdCrewObj.setDuty(duty);
                    mdCrewObj.setShift(shift);
                    
                    mdCrewObj.setBook_f(myResultSet.getString("book_f"));
                    mdCrewObj.setBook_c(myResultSet.getString("book_c"));
                    mdCrewObj.setBook_y(myResultSet.getString("book_y"));
                    mdCrewObj.setBook_w(myResultSet.getString("book_w"));
//                    mdCrewObj.setBook_w("2");
                    mdCrewObj.setPxac(myResultSet.getString("pxac"));
                    mdCrewObj.setInf(myResultSet.getString("inf"));
                    mdCrewObj.setUpd(myResultSet.getString("upd"));
                    mdCrewObj.setBdot(myResultSet.getString("bdot"));
                    mdCrewObj.setBdreason(myResultSet.getString("bdreason"));

                    for (int i = 0; i < sh_staTime.length; i++) {
                        sh_staTime[i] = myResultSet.getString("SH_ST"+ String.valueOf(i + 1));
                        if (sh_staTime[i] == null)
                            sh_staTime[i] = "";
                        sh_endTime[i] = myResultSet.getString("SH_ET"+ String.valueOf(i + 1));
                        if (sh_endTime[i] == null)
                            sh_endTime[i] = "";
                    }
                    mdCrewObj.setSh_staTime(sh_staTime);
                    mdCrewObj.setSh_endTime(sh_endTime);
                    mdCrewObj.setSh_remark(myResultSet.getString("SH_REMARK"));
                    mdCrewObj.setIsShift(myResultSet.getString("SHIFT"));// Y,N
                    mdCrewObj.setSh_cm(myResultSet.getString("sh_cm"));
                    // If �u��
                    FlexibleDispatch fd = new FlexibleDispatch();
//                    fd.ifFlexibleDispatch(fdate, fltno,sect, empno);
//                    mdCrewObj.setIflessdisp(fd.getLongRang());
                    mdCrewObj.setFleet(fd.getDa13_Fleet_cd(fdate, fltno, sect));
                    /*if (fltno.length() >= 4) {
                        mdCrewObj.setFltno(fltno.substring(1, 4));
                    } else {
                        mdCrewObj.setFltno(fltno);
                    }*/
                    //Class Type
                    ClassType fun = new ClassType();
                    if(null!= mdCrewObj.getFleet() && !"".equals( mdCrewObj.getFleet())){
                        if("Y".equals(fun.getClassTypebyFleet(mdCrewObj.getFleet()))){
                            mdCrewObj.setClass_cat(fun.getClassTypeAr());
                        } 
                    }else{
                        if (null != mdCrewObj.getAcno() && !"".equals(mdCrewObj.getAcno())){                
                            if ("Y".equals(fun.getClassTypebyACno(mdCrewObj.getAcno().substring(0,5)))){
                                mdCrewObj.setClass_cat(fun.getClassTypeAr());
                            }
                        }
                    }
                    //�Y���ժ�empn,������
                    if(mdCrewObj.getMp_empn() != null && !"".equals(mdCrewObj.getMp_empn())){
                        if (myResultSet != null) myResultSet.close();
                        sql= "select cname from egtcbas where trim(empn) = '"+ mdCrewObj.getMp_empn().trim() +"'";
                        myResultSet = stmt.executeQuery(sql);
                        while (myResultSet.next()) {
                            mdCrewObj.setMpname(myResultSet.getString("cname"));
//                            System.out.println(myResultSet.getString("cname"));
                        }
                    }
                    mdCrewObj.setResultMsg("1");
//                  
                } else {
                    mdCrewObj.setResultMsg("1");
                    mdCrewObj.setErrorMsg("Not Data.");
                }
                
                
                //�A��&�A��
                if (myResultSet != null) myResultSet.close();

                sql = "SELECT trim(empn) empn ,gdtype FROM egtgddt WHERE gdyear='"+ GdYear+ "' "
                        + "AND fltd=to_date('"+ fdate+ "','yyyy/mm/dd') AND fltno='"+ fltno+ "' AND gdtype in ('GD1','GD2')";
                ArrayList<String> gsEmpno = new ArrayList<String>();// �A��
                ArrayList<String> baEmpno = new ArrayList<String>();// �A��
                myResultSet = stmt.executeQuery(sql);
                if (myResultSet != null) {
                    while (myResultSet.next()) {
                        if (myResultSet.getString("gdtype").equals("GD1")) {
                            gsEmpno.add(myResultSet.getString("empn"));
                        } else if (myResultSet.getString("gdtype")
                                .equals("GD2")) {
                            baEmpno.add(myResultSet.getString("empn"));
                        }
                    }
                }
                mdCrewObj.setGsEmpno(gsEmpno);
                mdCrewObj.setBaEmpno(baEmpno);      
            }else{
                //cflt �L���
                GetFltInfo ft = new GetFltInfo(fdate, fltno ,sect ,"");
                if(!ft.isHasData()){                    
                    ft = new GetFltInfo(fdate,  fltno,  sect);
                }
                FlightCrewList fcl = new FlightCrewList(ft,sect,sdate);
                ArrayList<fz.prObj.FltObj> dataAL = new ArrayList<fz.prObj.FltObj>();
                ArrayList<CrewInfoObj> crewObjList = new ArrayList<CrewInfoObj>();
                fzac.CrewInfoObj caObj = null;
                fzac.CrewInfoObj mpObj = null;
                fzac.CrewInfoObj cmObj = null;//Crew Info CM���
                fz.prObj.FltObj fltObj  = null;
                int crewNum = 0;
                mdCrewObj = new MdCrewListObj();
                
                        
                fcl.RetrieveData();
                crewObjList = fcl.getCrewObjList(); // �խ���ƦW��                
                caObj = fcl.getCAObj(); // CA ���
                fltObj = fcl.getFltObj(); // ��Z���                
                mpObj = fcl.getMpCrewObj();//MP ���
                
                ft.RetrieveData();
                dataAL = ft.getDataAL();      
                if(null != dataAL){
//                    for(int i=0 ;i<dataAL.size();i++){   
//                        cmObj = dataAL.get(i).getPurCrewObj();//Crew Info CM���(crew_v)
//                        if( !"TVL".equals(cmObj.getDuty_cd()) && empno.equals(cmObj.getEmpno())){
//                          
//                        }
//                    }
                    if(dataAL.size()>0){
                        for(int i=0 ;i<dataAL.size();i++){  
                          if( empno.equals(dataAL.get(i).getPurCrewObj().getEmpno())){//����empno
                              cmObj = dataAL.get(i).getPurCrewObj();
                              break;
                          }
                          else{//�L��empno
                              if( !"TVL".equals(dataAL.get(i).getPurCrewObj().getDuty_cd())){//��DTVL ��� 
                                  cmObj = dataAL.get(i).getPurCrewObj();
                              }                              
                          }
                        }
                        
                    }else{
                        cmObj = dataAL.get(0).getPurCrewObj();
                    }                    
                    CrewBasicWs bs = new CrewBasicWs(cmObj.getEmpno());
                    mdCrewObj.setPsrempn(cmObj.getEmpno());
                    mdCrewObj.setPsrname(bs.getCrewInfo().getCname());//�ȿ��g�z   �h���S���Ÿ�ex:PA*
                    mdCrewObj.setPsrsern(bs.getCrewInfo().getSern());
                    mdCrewObj.setPgroups(bs.getCrewInfo().getGrp());
                }else{
                    mdCrewObj.setPsrname("NO CM");//�ȿ��g�z   �h���S���Ÿ�ex:PA*                
                }
                if (fltObj == null) {
                    mdCrewObj.setResultMsg("0");
                    mdCrewObj.setErrorMsg("�d�L�ӯ�Z�A�Э��s�d��!!");
                } else if (crewObjList == null) {
                    mdCrewObj.setResultMsg("0");
                    mdCrewObj.setErrorMsg("�i��ѩ󥻾�[��Z��]��ƥ���s�A���Z���ثe�|�L�խ��W��");
                } else {
                    //�����
                    if(caObj != null){
                        mdCrewObj.setCpname(caObj.getCname());
                        mdCrewObj.setCpno(caObj.getEmpno());
                    }
                    if(mpObj != null){ 
                        CrewBasicWs bs = new CrewBasicWs(mpObj.getEmpno()); 
                        mdCrewObj.setMp_empn(mpObj.getEmpno());
                        mdCrewObj.setSh_mp("");
                        mdCrewObj.setMpname(bs.getCrewInfo().getCname());
                    }                    
//                    if(empno.equals(fltObj.getPurEmpno())){                        
                        mdCrewObj.setFltno(fltno);
                        mdCrewObj.setAcno(fltObj.getAcno());
//                        mdCrewObj.setFleet(fltObj.getActp());                        
                        mdCrewObj.setBook_f(fltObj.getActualF());
                        mdCrewObj.setBook_c(fltObj.getActualC());
                        mdCrewObj.setBook_y(fltObj.getActualY());
                        mdCrewObj.setBook_w(fltObj.getActualW());
                        mdCrewObj.setPxac(fltObj.getBook_total());
                        
                        // mdCrewObj.setInf();
                        GregorianCalendar cal4 = new GregorianCalendar();//today
                        cal4.set(Calendar.HOUR_OF_DAY,00);
                        cal4.set(Calendar.MINUTE,01);
                        //fltd-1
                        GregorianCalendar cal6 = new GregorianCalendar();
                        cal6.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
                        cal6.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
                        cal6.set(Calendar.DATE,Integer.parseInt(fdate.substring(8)));
                        cal6.add(Calendar.DATE,-1);  
                        if(cal6.after(cal4)){
                            mdCrewObj.setUpd("N");//���i�s��
                        }else{
                            mdCrewObj.setUpd("Y");//�i�s��
                        }                        
                       
                        if(crewObjList.size() > mdCrewObj.getCrewNum()){
                            crewNum = mdCrewObj.getCrewNum();
                        }else{
                            crewNum = crewObjList.size();
                        }                        
                        String[] empn = new String[crewNum];
                        String[] sern = new String[crewNum];
                        String[] crew = new String[crewNum];
                        String[] crewgrp = new String[crewNum];
                        String[] duty = new String[crewNum];

//                      for (int i = 0; i < crewObjList.size(); i++) {
                        for (int i = 0; i < crewNum; i++) {
                            empn[i] = crewObjList.get(i).getEmpno().toString();
                            sern[i] = crewObjList.get(i).getSern().toString();
                            crew[i] = crewObjList.get(i).getCname().toString();
                            crewgrp[i] = pr.getGroups(sern[i]);
                            duty[i] = "X";//crewObjList.get(i).getOccu().toString();
//                            System.out.println(empn[i]);
                        }
                        mdCrewObj.setEmpn(empn);
                        mdCrewObj.setSern(sern);
                        mdCrewObj.setCrew(crew);
                        mdCrewObj.setDuty(duty);
                        mdCrewObj.setCrewgrp(crewgrp);
                        // If �u��
                        FlexibleDispatch fd = new FlexibleDispatch();
                        mdCrewObj.setFleet(fd.getDa13_Fleet_cd(fdate, fltno, sect));                        
                        /***/
                        //Class Type
                        ClassType fun = new ClassType();
                        if(null!= mdCrewObj.getFleet() && !"".equals( mdCrewObj.getFleet())){
                            if("Y".equals(fun.getClassTypebyFleet(mdCrewObj.getFleet()))){
                                mdCrewObj.setClass_cat(fun.getClassTypeAr());
                            } 
                        }else{
                            if (null != mdCrewObj.getAcno() && !"".equals(mdCrewObj.getAcno())){                
                                if ("Y".equals(fun.getClassTypebyACno(mdCrewObj.getAcno().substring(0,5)))){
                                    mdCrewObj.setClass_cat(fun.getClassTypeAr());
                                }
                            }
                        }
                        mdCrewObj.setResultMsg("1");
//                        mdCrewObj.setErrorMsg(fdate + fltno + sect );
//                    }else{
//                        mdCrewObj.setResultMsg("0");
//                        mdCrewObj.setErrorMsg("CM mapping error" + fltObj.getPurEmpno());
//                    }                  
                }
                
            }     
        } catch (Exception e) {
            mdCrewObj.setResultMsg("0");
            exStr = e.toString();
            if(e.toString().contains("00936")){
                mdCrewObj.setErrorMsg("MDcrew Error:�Э��s��z��Z��");
            }else{
                mdCrewObj.setErrorMsg("MDcrew Error");
            }            
//            System.out.println(e.toString());
           
        } finally {
            try {
                if (myResultSet != null)
                    myResultSet.close();
            } catch (SQLException e) {
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
            try{
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+ " " + empno +" "+ sdate +" "+ fltno +" "+ sect +"\r\n"); 
                fw.write("MdCrewList code: " +mdCrewObj.getResultMsg() + " " +mdCrewObj.getErrorMsg() +":"+ exStr +"\r\n");
                fw.write("****************************************************************\r\n"); 
                fw.flush();
                fw.close();
            }
            catch (Exception e1){
//                System.out.println("MdCrewList e1"+e1.toString());
            }
        }
    }
   
    // �ҵ�����
    public void getGradeItem(){
        gdObj = new GradeItemRObj();
        ArrayList itemAL = new ArrayList();
        int itemNum = 6;
        
        for(int i=0;i<itemNum;i++){
            GradeItemObj obj = new GradeItemObj();
            switch (i) {
            case 0:
                obj.setItem("�u�I");
                obj.setItemKey("GD3");
                obj.setItemTemp("�ȫ��g��/���e�i�šB�A�ȿˤ�/�A�ȥD�ʡB�{�u�n��/���q�ޥ���");                
                break;
            case 1:
                obj.setItem("���O(REC)");
                obj.setItemKey("GD17");
                obj.setItemTemp("�ȫȩ��/�ʥF���e/�A�סB���藍��/�u�@��k�B�Q��/�����޲z����/�p�Фu�@�Ϥj�n����/�A���ʥ�");
                break;
            case 2:
                obj.setItem("CCOM�Ү�");
                obj.setItemKey("GD20");
                obj.setItemTemp("YES/NO");
                break;
            case 3:
                obj.setItem("KPI");
                obj.setItemKey("GD25");
                obj.setItemTemp("YES/NEED TO IMPROVE");
                break;
            case 4:
                obj.setItem("SMS Q&A");
                obj.setItemKey("GD28");
                obj.setItemTemp("YES/NO");
                break;
            case 5:
                obj.setItem("��L");
                obj.setItemKey("GD18");
                break;
            default:
                break;
            }
            itemAL.add(obj);
        }
        if(itemAL.size() > 0){
            GradeItemObj[] array = new GradeItemObj[itemAL.size()];
            for(int i=0 ;i<itemAL.size() ;i++){
                array[i] = (GradeItemObj) itemAL.get(i);
            }
            gdObj.setGdArr(array);
            gdObj.setResultMsg("1");
        }else{
            gdObj.setErrorMsg("NO data");
            gdObj.setResultMsg("1");
        }       
    }
    
    // �ҵ����e
    public void getGradeRecord(String fdate,String fltno,String sect){
        gdRecObj = new GradeRObj();
        //�ҵ�����
        fz.pracP.GdTypeName gn = new fz.pracP.GdTypeName();
        try {
            gn.SelectData();
        } catch (InstantiationException e) {
            gdRecObj.setErrorMsg(e.toString());
            gdRecObj.setResultMsg("0");
        } catch (IllegalAccessException e) {
            gdRecObj.setErrorMsg(e.toString());
            gdRecObj.setResultMsg("0");         
        } catch (ClassNotFoundException e) {
            gdRecObj.setErrorMsg(e.toString());
            gdRecObj.setResultMsg("0");
        } catch (SQLException e) {
            gdRecObj.setErrorMsg(e.toString());
            gdRecObj.setResultMsg("0");
        }
        
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "";
        ArrayList recordAL = new ArrayList();
        
        try{
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

            sql = " SELECT yearsern, gdyear, empn, sern, gdtype, comments, newuser, " +
                  " To_char(newdate,'yyyy/mm/dd hh24:mi:ss') newdate, chguser, " +
                  " To_char(chgdate,'yyyy/mm/dd hh24:mi:ss') chgdate FROM EGTGDDT " +
                  " WHERE  gdtype IS NOT NULL AND gdtype <> 'GD1' "+ //gdtype  not in ('GD1','GD2')"+ 
                  " AND fltd=to_date('"+fdate+"','yyyy/mm/dd') AND fltno='"+fltno+"' AND sect='"+sect+"'";

            rs = stmt.executeQuery(sql);
            
            if(rs!= null){              
                while(rs.next()){   
                    GradeObj obj = new GradeObj();
                    obj.setGdtype(rs.getString("gdtype"));
                    obj.setGdtypeName(gn.ConverGdTypeToName(rs.getString("gdtype")));
                    obj.setEmpn(rs.getString("empn"));
                    obj.setSern(rs.getString("sern"));
                    obj.setNewuser(rs.getString("newuser"));
                    obj.setNewdate(rs.getString("newdate"));
                    obj.setChguser(rs.getString("chguser"));
                    obj.setChgdate(rs.getString("chgdate"));
                    obj.setComments(rs.getString("comments"));     
                    obj.setGdyear(rs.getString("gdyear"));
                    obj.setYearsern(rs.getString("yearsern"));
                    recordAL.add(obj);
                }       
            }           
            rs.close(); 
            if(recordAL.size() > 0){
                GradeObj[] array = new GradeObj[recordAL.size()];
                for(int i=0;i<recordAL.size();i++){
                    array[i] = (GradeObj) recordAL.get(i);
                }
                gdRecObj.setGdRecArr(array);
                gdRecObj.setResultMsg("1");
            }else{
                gdRecObj.setErrorMsg("No data");
                gdRecObj.setResultMsg("1");
            }           
        }
        catch (Exception e){
            gdRecObj.setErrorMsg(e.toString());
            gdRecObj.setResultMsg("0");
        }
        finally{
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }

    public PurInfoObj getPurObj()
    {
        return purObj;
    }

    public void setPurObj(PurInfoObj purObj)
    {
        this.purObj = purObj;
    }

    
    
}