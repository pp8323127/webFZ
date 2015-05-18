package ws.prac.ZC;

import java.io.*;
import java.sql.*;
import java.util.*;

import ws.*;
import ws.prac.*;

import ci.db.*;
import eg.*;
import eg.crewbasic.*;
import eg.zcrpt.*;
import ftp.*;
import fz.pracP.*;
import fz.pracP.dispatch.*;

public class ReportListZCFun
{

    /**
     * @param args
     * 
     */
    
    //
    public ReportListZCfltRObj zcfltObj = null;
    public GradeItemRObj zcGdObj = null;
    ReturnMsgObj saveobj = null; 
    ReturnMsgObj sendobj = null; 
    private String error_str ="";  
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        ReportListZCFun zc = new ReportListZCFun();
        
//        zc.getZcMdList("631958", "2014/08/07 17:10", "0006", "TPELAX");
        zc.getZcMdList("633020", "2014/08/25 08:35", "0753", "TPESIN");
//        saveReportZCFileObj zcFileObjAL = new saveReportZCFileObj();
//        saveReportZCFileObj[] zcFileObjAr = new saveReportZCFileObj[1];
//
//        saveReportZCCrewScoreObj zcScoreObjAL = new saveReportZCCrewScoreObj();
//        saveReportZCCrewScoreObj[] zcScoreObjAr = new saveReportZCCrewScoreObj[1];
//        zcScoreObjAL.setEmpno("654321");
//        zcScoreObjAL.setSeqno("");
//        zcScoreObjAL.setDuty("ZZ");
//        zcScoreObjAL.setScore("8");
//        zcScoreObjAL.setCname("XXX");
//        zcScoreObjAL.setBest_performance("Y");
//        zcScoreObjAr[0] = zcScoreObjAL;
//
//        saveReportZCCrewGdObj zcGdObjAL = new saveReportZCCrewGdObj();
//        saveReportZCCrewGdObj[] zcGdObjAr = new saveReportZCCrewGdObj[1];  
//        zcGdObjAL.setEmpno("654321");
//        zcGdObjAL.setSern("12345");
//        zcGdObjAL.setGdtype("GD99");
//        zcGdObjAr[0] = zcGdObjAL;
//        
//        saveReportZCFltIrrObj zcFltirrObjAL = new saveReportZCFltIrrObj();
//        saveReportZCFltIrrObj[] zcFltirrObjAr = new saveReportZCFltIrrObj[1];
//        zcFltirrObjAL.setItemno("Z01");
//        zcFltirrObjAL.setItemdsc("test");
//        zcFltirrObjAr[0] = zcFltirrObjAL;
//        
//        saveReportZCfltObj[] saverptAr = new saveReportZCfltObj[1];
//        saveReportZCfltObj saverptAL = new saveReportZCfltObj();
//        saverptAL.setSeqno("43012");
//        saverptAL.setFltd("2014/08/21");
//        saverptAL.setFltno("9999");
//        saverptAL.setSect("TPETPE");
//        saverptAL.setAcno("18011");
//        saverptAL.setZcempn("99999");
//        saverptAL.setChgdate("2014/08/07 00:00:00");
//        saverptAL.setChguser("99999");
//        saverptAL.setPsrempn("99998");
//        saverptAL.setPsrname("QQQ");
//        saverptAL.setPsrsern("11111");
//        ArrayList al = new ArrayList();
//        al.add(saverptAL);
//        saverptAL.setZcFltirrObjAL(zcFltirrObjAr);
//        saverptAL.setZcGdObjAL(zcGdObjAr);
//        saverptAL.setZcScoreObjAL(zcScoreObjAr);
//        if(al.size()>0){
//            saverptAr[0] = (saveReportZCfltObj) al.get(0);
//        }
//        zc.saveZCreport(saverptAr);
    }


//    ZC(PR) 打考績組員名單,from zcflt.有組員名單,無則顯示原始組員名單 
//    客艙動態,考評資料
    public void getZcMdList(String empno, String sdate, String fltno,String sect){
        
        zcfltObj = new ReportListZCfltRObj();
        
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ci.db.ConnDB cn = new ci.db.ConnDB();
        String sql = null;
        String yy = sdate.substring(0, 4);
        String mm = sdate.substring(5, 7);
        String fdate = sdate.substring(0,10);
        String str = "";
        boolean fltnowithZ = false;
        ArrayList zccrewAL = new ArrayList();
        ArrayList zcFltirrAL = new ArrayList();

        try { 
            GregorianCalendar cal4 = new GregorianCalendar();//today
            cal4.set(Calendar.HOUR_OF_DAY,00);
            cal4.set(Calendar.MINUTE,01);
            //Fltd+1天
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
                 
             
             cn.setORP3EGUserCP();
             dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
             conn = dbDriver.connect(cn.getConnURL(), null);
             
//             ConnectionHelper ch = new ConnectionHelper();
//             conn = ch.getConnection();
             stmt = conn.createStatement();             
                  
             sql =
                " SELECT seqno,To_Char(fltd, 'yyyy/mm/dd') fdate,fltno,sect,cpname,cpno, " +
                " acno,psrempn,psrsern,psrname,pgroups,zcempn,zcsern,zcname,zcgrps,memo," +
                " nvl(ifsent, 'N') upd, nvl(rjtuser, '') reject, " +
                " to_char(rjtdate, 'yyyy/mm/dd hh24:mi:ss') rjtdate, " +
                " to_char(chgdate, 'yyyy/mm/dd hh24:mi:ss') chgdate" +
                " FROM egtzcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno ='"+fltno+"' " +
                " and sect='"+sect+"' and zcempn = '"+empno+"'" ;
             rs = stmt.executeQuery(sql);
            
            String wflg = "";
            if (rs.next()){
                wflg = "Y";
                zcfltObj.setWflag(wflg);// Y:egtzcflt有,N:egtzcflt無
                zcfltObj.setUpd(rs.getString("upd"));// Y:可編輯,N:不可
                zcfltObj.setSeqno(rs.getString("seqno"));
                zcfltObj.setFltd(fdate);
                zcfltObj.setFltno(fltno);
                zcfltObj.setSect(sect);
                zcfltObj.setCpname(rs.getString("cpname"));
                zcfltObj.setCpno(rs.getString("cpno"));
                zcfltObj.setAcno(rs.getString("acno"));
                zcfltObj.setPsrempn(rs.getString("psrempn"));
                zcfltObj.setPsrsern(rs.getString("psrsern"));
                zcfltObj.setPsrname(rs.getString("psrname"));
                zcfltObj.setPgroups(rs.getString("pgroups"));
                zcfltObj.setZcempn(rs.getString("zcempn"));
                zcfltObj.setZcsern(rs.getString("zcsern"));
                zcfltObj.setZcname(rs.getString("zcname"));
                zcfltObj.setZcgrps(rs.getString("zcgrps"));
                zcfltObj.setMemo(rs.getString("memo"));
                zcfltObj.setUpd(rs.getString("upd"));
                zcfltObj.setRjtuser(rs.getString("reject"));
                zcfltObj.setRjtdate(rs.getString("rjtdate"));      
                zcfltObj.setChgdate(rs.getString("chgdate"));
            }else {
                wflg = "N";
                zcfltObj.setWflag(wflg);// Y:egtcflt有,N:egtcflt無
                zcfltObj.setFltd(fdate);
                zcfltObj.setFltno(fltno);
                zcfltObj.setSect(sect); 
                if(cal6.after(cal4)){//未編輯之報告,10/22不可編輯10/23
                    zcfltObj.setUpd("N");
                }else{
                    zcfltObj.setUpd("Y");
                }                    
            }            
            rs.close();
            
          //Class Type
            ClassType fun = new ClassType();
            if(null!= zcfltObj.getFleet() && !"".equals( zcfltObj.getFleet())){
                if("Y".equals(fun.getClassTypebyFleet(zcfltObj.getFleet()))){
                    zcfltObj.setClass_cat(fun.getClassTypeAr());
                } 
            }else{
                if(null!=zcfltObj.getAcno() && !"".equals(zcfltObj.getAcno())){                                                
                    if("Y".equals(fun.getClassTypebyACno(zcfltObj.getAcno()))){
                        zcfltObj.setClass_cat(fun.getClassTypeAr());
                    }                        
                }
            }
            //判斷報告是否過期未繳===================================================    
            //非TVL Flt && 非Inspector Flt, 早於今天的fltd又未繳交則底色改為遲交              
            if(cal4.after(cal5) && (!"N".equals(zcfltObj.getUpd())) && (yy+"/"+mm).equals(fdate.substring(0,7))){
                zcfltObj.setLate(true);
            }
            //Crew資訊===========================================================
            if("Y".equals(wflg)){                    
                ZCReport zcCrew = new ZCReport();
                //己編輯組員名單,考評資料
                zccrewAL = zcCrew.getZCCrewList(zcfltObj.getSeqno());                       
                //set Flt irr
                zcFltirrAL = zcCrew.getZCFltIrrItem(zcfltObj.getSeqno());
                if(zcFltirrAL != null && zcFltirrAL.size()>0){
                    ZCFltIrrItemObj[] zcfltirrObjArr = new ZCFltIrrItemObj[zcFltirrAL.size()];
                    for(int i=0;i<zcFltirrAL.size();i++){                            
                        zcfltirrObjArr[i] = (ZCFltIrrItemObj)zcFltirrAL.get(i);
                    }                    
                    zcfltObj.setResultMsg("1");
                    zcfltObj.setZcfltirrObjArr(zcfltirrObjArr);
                }else{
                    zcfltObj.setResultMsg("1");
                    //str += "No fltirr data.";
                }   
            }else if("N".equals(wflg)){
                FlightCrewList fcl = null;                   
                //Set purser info
                if(zcfltObj.getFltno().indexOf("Z")>0){
                    fltnowithZ = true;
                }
                GetFltInfo ft = new GetFltInfo(zcfltObj.getFltd(), zcfltObj.getFltno(), fltnowithZ);                               
                fcl = new FlightCrewList(ft,zcfltObj.getSect(),sdate);   
                fcl.RetrieveDataForZC(empno,zcfltObj.getSect());
                //set ca info    
                fzac.CrewInfoObj caObj = fcl.getCAObj();
                if(caObj != null)
                {
                    zcfltObj.setCpname(caObj.getCname());
                    zcfltObj.setCpno(caObj.getEmpno()); 
                }                 
                fz.prObj.FltObj fltObj  = fcl.getFltObj();  
                zcfltObj.setAcno(fltObj.getAcno());      
              
                // If 彈派
                FlexibleDispatch fd = new FlexibleDispatch();
                zcfltObj.setFleet(fd.getDa13_Fleet_cd(fdate, fltno, sect));
                //Class Type
                if(null!= zcfltObj.getFleet() && !"".equals( zcfltObj.getFleet())){
                    if("Y".equals(fun.getClassTypebyFleet(zcfltObj.getFleet()))){
                        zcfltObj.setClass_cat(fun.getClassTypeAr());
                    } 
                }else{
                    if(null!=zcfltObj.getAcno() && !"".equals(zcfltObj.getAcno())){                                               
                        if("Y".equals(fun.getClassTypebyACno(zcfltObj.getAcno()))){
                            zcfltObj.setClass_cat(fun.getClassTypeAr());
                        }                        
                    }
                }
                //set PR info 
                fzac.CrewInfoObj purObj = fcl.getPurCrewObj();  
                CrewBasicWs pr = new CrewBasicWs(purObj.getEmpno());
                zcfltObj.setPsrempn(purObj.getEmpno());
                zcfltObj.setPsrsern(purObj.getSern());
                zcfltObj.setPsrname(pr.getCrewInfo().getCname());        
                zcfltObj.setPgroups(purObj.getGrp());
                //Set ZC info
                CrewBasicWs zc = new CrewBasicWs(empno);
                zcfltObj.setZcempn(zc.getCrewInfo().getEmpno());
                zcfltObj.setZcname(zc.getCrewInfo().getCname());
                zcfltObj.setZcsern(zc.getCrewInfo().getSern());
                zcfltObj.setZcgrps(zc.getCrewInfo().getGrp());
            }//end wflg
            
            //Set Crews===========================================================
            if(zccrewAL == null || zccrewAL.size()<=0){
                //from aircrews crew list
                //Set purser info       
                if(zcfltObj.getFltno().indexOf("Z")>0){
                    fltnowithZ = true;
                }
                GetFltInfo ft = new GetFltInfo(zcfltObj.getFltd(), zcfltObj.getFltno(), fltnowithZ);                               
                FlightCrewList fcl = new FlightCrewList(ft,zcfltObj.getSect(),sdate);   
                fcl.RetrieveDataForZC(empno,zcfltObj.getSect());                   

                ArrayList crewObjList = fcl.getCrewObjList();  
                if(crewObjList.size()>0){
                    for(int i = 0; i<crewObjList.size(); i++){
                         fzac.CrewInfoObj cobj = (fzac.CrewInfoObj)crewObjList.get(i);
                         if(!empno.equals(cobj.getEmpno())){
                             ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
                             zccrewobj.setEmpno(cobj.getEmpno());
                             zccrewobj.setSern(cobj.getSern());
                             zccrewobj.setCname(cobj.getCname());
                             zccrewobj.setEname(cobj.getEname());
                             zccrewobj.setGrp(cobj.getGrp());           
                             zccrewobj.setDuty("X");
                             zccrewobj.setSeqno(zcfltObj.getSeqno());
                             zccrewAL.add(zccrewobj);
                             //str += cobj.getEmpno()+",";
                         }
                     }
                }  
            }
            
            
            if(zccrewAL != null && zccrewAL.size()>0){
                ZCReportCrewListObj[] zccrewObjArr = new ZCReportCrewListObj[zccrewAL.size()];
                for(int i=0;i<zccrewAL.size();i++){
                    zccrewObjArr[i] = (ZCReportCrewListObj)zccrewAL.get(i);
                }        
                zcfltObj.setZccrewObjArr(zccrewObjArr);   
                zcfltObj.setResultMsg("1");
                zcfltObj.setErrorMsg(str);
            }else{
                zcfltObj.setResultMsg("1");
                //str += "No crew data.";
            }
                         
                      
            
            //CM IRR Reply
            sql = "select reply from egtcflt where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect=upper('"+sect+"')";
            rs  = stmt.executeQuery(sql);
            while(rs.next()){
                zcfltObj.setCmFirrReply(rs.getString("reply"));                
            }                        
            zcfltObj.setCmIirrObjArr(getViewZcRpt(fdate,fltno,sect));    
            
          
        } catch (Exception e) {
            if(e.toString().contains("Null")){
                zcfltObj.setResultMsg("1");
                zcfltObj.setErrorMsg("X");
            }else{
                zcfltObj.setResultMsg("0");
                zcfltObj.setErrorMsg(str+"error ZcMdList : " + e.toString());
            }
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
    
//  ZC(PR)考評項目
    public void getZcGradeItem(){
        String str = "";
        try {
            fz.pracP.GdTypeName gn = new fz.pracP.GdTypeName();
            gn.SelectData();//優點
            ArrayList commAL = gn.getCommAL();
            if(commAL.size()>0){
                for(int i=0;i<commAL.size();i++){
                    if(i==commAL.size()-1){
                        str += commAL.get(i);
                    }
                    str+=commAL.get(i)+"/";
                }
            }            
            
            zcGdObj = new GradeItemRObj();
            ArrayList itemAL = new ArrayList();
            int itemNum = 3;
            for(int i=0;i<itemNum;i++){
                GradeItemObj obj = new GradeItemObj();
                switch (i) {
                case 0:
                    obj.setItem("優點");
                    obj.setItemKey("GD3");
                    obj.setItemTemp(str);                
                    break;
                case 1:
                    obj.setItem("註記(REC)");
                    obj.setItemKey("GD17");
//                    obj.setItemTemp("");
                    break;
                case 2:
                    obj.setItem("CCOM考核");
                    obj.setItemKey("GD20");
                    obj.setItemTemp("YES/NO");
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
                zcGdObj.setGdArr(array);
                zcGdObj.setResultMsg("1");
            }else{
                zcGdObj.setErrorMsg("NO data");
                zcGdObj.setResultMsg("1");
            }
        } catch (SQLException e) {
            zcGdObj.setErrorMsg(e.toString());
            zcGdObj.setResultMsg("0");
        }
        catch ( InstantiationException e )
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch ( IllegalAccessException e )
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch ( ClassNotFoundException e )
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

//  view PR(CM) irr report
    public CmIirrObj[] getViewZcRpt(String fdate,String fltno,String sect){
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        ci.db.ConnDB cn = new ci.db.ConnDB();
        String sql = "";
        CmIirrObj[] cmIirrObjArr = null;
        String path = "/apsource/csap/projfz/txtin/appLogs/";//"E://";
        FileWriter fw = null;
        try
        {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            stmt = con.createStatement();
            
            ArrayList CMirrObjAL = new ArrayList();
            sql =" select a.itemdsc desc1, b.itemdsc desc2, nvl(b.comments,'') comm, nvl(b.reply,'') reply, b.clb clb,b.mcr mcr, b.rca rca,b.emg emg from egtcmpi a, egtcmdt b " +
            	" where a.itemno=b.itemno and b.fltd=to_date('"+fdate+"','yyyy/mm/dd') and b.fltno='"+fltno+"' and b.sect='"+sect+"' order by b.newdate ";
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                CmIirrObj obj = new CmIirrObj();
                obj.setDsc1(rs.getString("desc1"));
                obj.setDsc2(rs.getString("desc2"));
                obj.setComm(rs.getString("comm"));
                obj.setReply(rs.getString("reply"));
                obj.setClb(rs.getString("clb"));
                obj.setMcr(rs.getString("mcr"));
                obj.setEmg(rs.getString("rca"));
                obj.setRac(rs.getString("emg"));
                CMirrObjAL.add(obj);
            }
            if(CMirrObjAL.size() > 0){
                cmIirrObjArr = new CmIirrObj[CMirrObjAL.size()];
                for(int i=0 ;i<CMirrObjAL.size();i++){
                    cmIirrObjArr[i] = (CmIirrObj) CMirrObjAL.get(i);
                }                
            }
        } catch(Exception e) {      
            try
            {
//                fw = new FileWriter(path+"serviceLog.txt");
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+" CM irr rpt \r\n");       
                fw.write(e.toString() + " ** " + fdate +" "+ fltno +" "+ sect +" Failed \r\n"); 
                fw.write(sql +"\r\n"); 
                fw.write("****************************************************************\r\n");
                fw.flush();
                fw.close();
            }
            catch (Exception e1)
            {
//                  System.out.println("e1"+e1.toString());
            }
            finally
            {               
            }
        }
        finally 
        {            
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(con != null) con.close();}catch(SQLException e){}
        }    
        return cmIirrObjArr;
    }
    
//  save rpt
    public String saveZCreport(saveReportZCfltObj[] saverptAL){
        saveobj = new ReturnMsgObj();
        Connection con = null;
        PreparedStatement pstmt = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql ="";
        String error_sql ="";
        String error_step ="";
        String path = "/apsource/csap/projfz/txtin/appLogs/";//"E://";
        FileWriter fw = null;
               
        ci.db.ConnDB cn = new ci.db.ConnDB();
        StringBuffer sqlsb = new StringBuffer();
        String ifupdate = "Y";
        String seqno_str = ""; 
        String returnStr = "";
        String fltnoInfo = "";
        String oldSeqno = "";
        boolean ifNew = true;
        try
        {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG            
//              cn.setORT1EG();
//              Class.forName(cn.getDriver());
//              con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            con.setAutoCommit(false);   
            stmt = con.createStatement();
                
            if(saverptAL.length>0)
            {
                for(int i=0; i<saverptAL.length; i++)
                { 
                    ifupdate = "Y";
                    saveReportZCfltObj saverptobj = (saveReportZCfltObj)saverptAL[i];
                    if(!"".equals(saverptAL[i].getFltd()) && !"".equals(saverptAL[i].getFltno()) && !"".equals(saverptAL[i].getSect()) && saverptAL[i].getFltd() != null && saverptAL[i].getFltno() != null && saverptAL[i].getSect() != null)
                    {
                        
                          //檢查是否為delay 航班, 是否需修改 fltd & fltno +Z
                          //**************************************************************
                          String fdate_aircrews = saverptAL[i].getFltd();//aircrews 調整後的日期
//                          String fltno_cflt = saverptAL[i].getFltno();//判斷是否加Z後的航班號碼
                          
                          sql =" select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate," +
                               " dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, " +
                               " to_char(str_dt_tm_loc,'hh24mi') ftime, dps.act_port_a dpt,dps.act_port_b arv " +
                               " from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num " +
                               " and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
                               " and r.staff_num ='"+saverptAL[i].getPsrempn()+"' " +
                               " AND dps.str_dt_tm_loc BETWEEN  to_date('"+saverptAL[i].getFltd()+" 00:00','yyyy/mm/dd hh24:mi') " +
                               " AND to_date('"+saverptAL[i].getFltd()+" 23:59','yyyy/mm/dd hh24:mi') +1 " +
                               " AND dps.port_a||dps.port_b ='"+saverptAL[i].getSect()+"' " +
                               " AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') " +
                               " AND ( r.acting_rank IN ('FC')  OR Nvl(r.special_indicator,' ') = 'J') order by str_dt_tm_gmt ";
                                 
                          rs = stmt.executeQuery(sql);
                      
                          if (rs.next()) 
                          {
                                fdate_aircrews = rs.getString("fdate");      
//                                fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate_aircrews.substring(0, 4)+fdate_aircrews.substring(5, 7)+fdate_aircrews.substring(8),rs.getString("fltno"), rs.getString("dpt")+rs.getString("arv"),rs.getString("stdDt"));
//                                if (gf.getFltnoWithSuffix().indexOf("Z") > -1) 
//                                {
//                                    // 最後一碼為Z時，不檢查delay班次號碼
//                                    fltno_cflt =gf.getFltnoWithSuffix();
//                                }
                         }              
                          
                         if(!saverptAL[i].getFltd().equals(fdate_aircrews))// || !saverptAL[i].getFltno().equals(fltno_cflt)
                         {//更改存入的fltd & fltno
                             saverptAL[i].setFltd(fdate_aircrews);
//                             saverptAL[i].setFltno(fltno_cflt);
                         }
                         //*************************************************************************************
                        
                        //check if ipad's is updated data
                        //saverptAL[i].getUpdate_time() 較小或已送出則無需覆蓋(更新)
    //                      if(saverptAL[i].getUpdate_time()!=null && !"".equals(saverptAL[i].getUpdate_time()) && !"N".equals(saverptAL[i].getUpd()))
                        if(saverptAL[i].getChgdate()!=null && !"".equals(saverptAL[i].getChguser()))
                        {
    //                        check report status
                            saveZcRptCheck src = new saveZcRptCheck();
                            String status_str = src.doSaveReportCheck(saverptAL[i].getFltd(),saverptAL[i].getFltno(),saverptAL[i].getSect(),saverptAL[i].getZcempn());
                            
                            if("Y".equals(status_str))
                            {                       
                                sql = "select CASE WHEN To_Date('"+saverptAL[i].getChgdate()+"','yyyy/mm/dd hh24:mi:ss') < chgdate THEN 'N' ELSE 'Y' END ifupdated from egtzcflt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and zcempn = '"+saverptAL[i].getZcempn()+"'";                    
                                rs = stmt.executeQuery(sql);
            
                                if (rs.next()) 
                                {
                                    ifupdate = rs.getString("ifupdated");      
                                    ifupdate = ifupdate.trim();                             
                                }
                            }
                            else
                            {
                                saveobj.setResultMsg("0");
                                saveobj.setErrorMsg(status_str);
                                return status_str;
                            }
                        }
                        else
                        {
                            error_str = "資料不完整，資料同步失敗";
                            saveobj.setResultMsg("0");
                            saveobj.setErrorMsg(error_str);
                            return "資料不完整，資料同步失敗";
                        }
                                           
    //                    檢查組員名單是否為空
                        if("Y".equals(ifupdate))                    
                        {
                            if(saverptAL[i].getZcScoreObjAL() != null)
                            {                           
                                saveReportZCCrewScoreObj insertcrewobj = saverptAL[i].getZcScoreObjAL()[0];                                                             
                                if(insertcrewobj==null)
                                {   
    
                                    saveobj.setResultMsg("0");
                                    saveobj.setErrorMsg("AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!");
                                    return "AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!";
                                }     
                                else
                                {
                                    if(insertcrewobj.getEmpno()==null | "".equals(insertcrewobj.getEmpno()))
                                    {
                                        saveobj.setResultMsg("0");
                                        saveobj.setErrorMsg("AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!");
                                        return "AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!";
                                    }                                
                                }
                            }
                            else
                            {
                                saveobj.setResultMsg("0");
                                saveobj.setErrorMsg("AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!");
                                return "AirCrews班表資訊有異動 ，請重新整理月班表 ，再進My Flight更新資訊!";
                            }
                        }
                        
                        if("Y".equals(ifupdate))
                        {
    
                            error_step = "儲存報告主檔";
                            if(saverptAL[i].getSeqno()!=null && !"".equals(saverptAL[i].getSeqno())){
                                //delete egtzcflt then insert 
                                sql = " select seqno from egtzcflt where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and zcempn = '"+saverptAL[i].getZcempn()+"'";
                                rs = stmt.executeQuery(sql);
                                if (rs.next()){
                                    oldSeqno = rs.getString("seqno");   
                                    if(saverptAL[i].getSeqno().equals(oldSeqno)){                                
                                        ifNew = false;
                                    }else{
                                        error_str = "資料與序號不符合" + saverptAL[i].getSeqno();
                                        saveobj.setResultMsg("0");
                                        saveobj.setErrorMsg(error_str);
                                        return "資料與序號不符合" + saverptAL[i].getSeqno();
                                    }   
                                }                                                
                            }  
                            
                            fltnoInfo = saverptAL[i].getFltd() + " " + saverptAL[i].getFltno() + " " +saverptAL[i].getSect() + " " +saverptAL[i].getZcempn();
                            if(!ifNew){
                                sql = " delete from egtzcflt where seqno = '"+saverptAL[i].getSeqno()+"'" ;
                                stmt.executeUpdate(sql);
                            }else{
                                //get new seqno.
                                sql = "select max(seqno)+1 seqno from egtzcflt";
                                rs = stmt.executeQuery(sql);
                                if (rs.next()){
                                    saverptAL[i].setSeqno(rs.getString("seqno"));    
    //                                System.out.println(rs.getString("seqno"));
                                }                             
                            } 
                            sqlsb = new StringBuffer();
                            sqlsb.append(" insert into egtzcflt (seqno,fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,");
                            sqlsb.append(" zcempn,zcsern,zcname,zcgrps,memo,ifsent,newuser,newdate,chguser,chgdate,");
                            sqlsb.append(" rjtuser,rjtdate,rptclose,rptclose_userid,rptclose_date ) ");
                            sqlsb.append(" values (?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,");
                            sqlsb.append(" ?,?,?,?,?,'N',?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),");
                            sqlsb.append(" ?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,?, to_date(?,'yyyy/mm/dd hh24:mi:ss'))");                                      
    //error_str=sqlsb.toString();
                            
                            pstmt = con.prepareStatement(sqlsb.toString());
    
    //                        System.out.println(sqlsb.toString());
                            int idx =0;
                            pstmt.setString(++idx, saverptAL[i].getSeqno());
                            pstmt.setString(++idx, saverptAL[i].getFltd());
                            pstmt.setString(++idx, saverptAL[i].getFltno());
                            pstmt.setString(++idx, saverptAL[i].getSect());
                            pstmt.setString(++idx, saverptAL[i].getCpname());
                            pstmt.setString(++idx, saverptAL[i].getCpno());
                            pstmt.setString(++idx, saverptAL[i].getAcno());                     
                            pstmt.setString(++idx, saverptAL[i].getPsrempn());
                            pstmt.setString(++idx, saverptAL[i].getPsrsern());
                            pstmt.setString(++idx, saverptAL[i].getPsrname());
                            pstmt.setString(++idx, saverptAL[i].getPgroups());  
                            
                            pstmt.setString(++idx, saverptAL[i].getZcempn());
                            pstmt.setString(++idx, saverptAL[i].getZcsern());
                            pstmt.setString(++idx, saverptAL[i].getZcname());
                            pstmt.setString(++idx, saverptAL[i].getZcgrps());
                            pstmt.setString(++idx, saverptAL[i].getMemo());
                            pstmt.setString(++idx, saverptAL[i].getNewuser());
                            pstmt.setString(++idx, saverptAL[i].getNewdate());                       
                            pstmt.setString(++idx, saverptAL[i].getChguser());
                            pstmt.setString(++idx, saverptAL[i].getChgdate());
                            
                            pstmt.setString(++idx, saverptAL[i].getRjtuser());
                            pstmt.setString(++idx, saverptAL[i].getRjtdate());
                            pstmt.setString(++idx, saverptAL[i].getRptclose());
                            pstmt.setString(++idx, saverptAL[i].getRptclose_userid());
                            pstmt.setString(++idx, saverptAL[i].getRptclose_date());
                                        
                            pstmt.executeUpdate();
    
    //                        insert 組員名單與分數
                            error_step = "儲存組員名單與分數";
                            if(!ifNew){
    //                          delete egtzccrew then insert score record
                                error_step = "儲存舊的組員名單與分數";
                                sql = " delete FROM egtzccrew where seqno = '"+saverptAL[i].getSeqno()+"'";
                                stmt.executeUpdate(sql);
                            }  
                            
                            if(saverptAL[i].getZcScoreObjAL()!= null)
                            {
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into egtzccrew (seqno,empno,sern,cname,duty,score,grp,best_performance) ");
                                sqlsb.append("values (?,?,?,?,?,?,?,?)");
                                
                                pstmt.clearParameters();
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                
                                for(int j =0; j<saverptAL[i].getZcScoreObjAL().length; j++)
                                {
                                    idx =0;
                                    saveReportZCCrewScoreObj insertcrewobj = saverptAL[i].getZcScoreObjAL()[j];
                                    if(insertcrewobj.getScore() != null  &&  !"".equals(insertcrewobj.getScore()))
                                    {//!"X".equals(insertcrewobj.getScore()) && !"0".equals(insertcrewobj.getScore()) &&
                                        pstmt.setString(++idx, saverptAL[i].getSeqno());
                                        pstmt.setString(++idx, insertcrewobj.getEmpno());
                                        pstmt.setString(++idx, insertcrewobj.getSern());
                                        pstmt.setString(++idx, insertcrewobj.getCname());
                                        pstmt.setString(++idx, insertcrewobj.getDuty());                      
                                        pstmt.setString(++idx, insertcrewobj.getScore());
                                        pstmt.setString(++idx, insertcrewobj.getGrp());
                                        pstmt.setString(++idx, insertcrewobj.getBest_performance());
                                        pstmt.addBatch();
                                    }
                                }
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                               
    //                        insert 組員的考評
                            error_step = "儲存組員的考評";
                            if(!ifNew){
    //                        delete egtgddt then insert score record
                                  error_step = "儲存舊的考評";
                                  sql = " delete FROM egtzcgddt where seqno = '"+saverptAL[i].getSeqno()+"'";
                                  stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getZcGdObjAL()!=null)
                            {
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into egtzcgddt (seqno,empno,sern,gdtype,comments,newuser,newdate,chguser,chgdate) ");
                                sqlsb.append("values (?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,to_date(?,'yyyy/mm/dd hh24:mi:ss'))");
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                
                                for(int j =0; j<saverptAL[i].getZcGdObjAL().length; j++)
                                {
                                    idx =0;
                                    saveReportZCCrewGdObj insertgdobj = saverptAL[i].getZcGdObjAL()[j];
                                    if(!"".equals(insertgdobj.getGdtype()) && insertgdobj.getGdtype() != null && insertgdobj.getEmpno() != null && !"".equals(insertgdobj.getEmpno()))
                                    {
                                        pstmt.setString(++idx, saverptAL[i].getSeqno());
                                        pstmt.setString(++idx, insertgdobj.getEmpno());
                                        pstmt.setString(++idx, insertgdobj.getSern());                           
                                        pstmt.setString(++idx, insertgdobj.getGdtype());
                                        pstmt.setString(++idx, insertgdobj.getComments());
                                        pstmt.setString(++idx, insertgdobj.getNewuser());
                                        pstmt.setString(++idx, insertgdobj.getNewdate());
                                        pstmt.setString(++idx, insertgdobj.getChguser());
                                        pstmt.setString(++idx, insertgdobj.getChgdate());
                                        pstmt.addBatch();
                                    }                          
                                }   
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                            
                            
                            error_step = "儲存客艙動態";                       
                            
    //                        insert 客艙動態
                            if(!ifNew){
    //                          delete egtzcdm then insert 客艙動態 
                                error_step = "儲存舊的客艙動態 ";
                                sql = " delete FROM egtzccmdt where seqno = '"+saverptAL[i].getSeqno()+"'";
                                stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getZcFltirrObjAL()!= null)
                            {  
                                
                                
                                sqlsb = new StringBuffer();
                                sqlsb.append("INSERT INTO egtzccmdt(seqkey,seqno,itemno,itemdsc,comments,flag)");
                                sqlsb.append(" VALUES (?,?,?,?,?,?)");//(SELECT Nvl(Max(seqkey),0)+1 FROM egtzccmdt)
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                
                                for(int j =0; j<saverptAL[i].getZcFltirrObjAL().length; j++)
                                {       
                                    idx=0;
                                    saveReportZCFltIrrObj fltirrobj = saverptAL[i].getZcFltirrObjAL()[j];
                                    sql = "SELECT (Nvl(Max(seqkey),0)+"+j+"+1) seqkey FROM egtzccmdt ";                    
                                    rs = stmt.executeQuery(sql);                
                                    if (rs.next()) 
                                    {
                                        fltirrobj.setSeqkey(rs.getString("seqkey"));  
                                    }    
                                    if(!"".equals(fltirrobj.getItemno()) && fltirrobj.getItemno() != null && !"".equals(fltirrobj.getSeqkey()) && fltirrobj.getSeqkey() != null )
                                    {
                                        sql =
                                                "INSERT INTO egtzccmdt(seqkey,seqno,itemno,itemdsc,comments,flag)"+
                                        "VALUES ((SELECT Nvl(Max(seqkey),0)+1 FROM egtzccmdt),"+saverptAL[i].getSeqno()+","+fltirrobj.getItemno()+","+fltirrobj.getItemdsc()+",?,?)";
                                       
                                        pstmt.setString(++idx,fltirrobj.getSeqkey());
                                        pstmt.setString(++idx,saverptAL[i].getSeqno());
                                        pstmt.setString(++idx,fltirrobj.getItemno());
                                        pstmt.setString(++idx,fltirrobj.getItemdsc());
                                        pstmt.setString(++idx,fltirrobj.getComments());
                                        pstmt.setString(++idx,fltirrobj.getFlag());
                                        pstmt.addBatch();
                                    }
                                                                      
                                    
                                }
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                               
                            
                            error_step = "儲存上傳檔案 ";
                            if(!ifNew){
                                error_step = "儲存舊上傳檔案 ";
    //                            delete egtfile then insert Cabin report file upload
                                sql = "select filename from egtzcfile where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and src='IPAD' ";                  
                                rs = stmt.executeQuery(sql);
            
                                while (rs.next()) 
                                {
                                    fz.pracP.uploadFile.DeleteFile df = new fz.pracP.uploadFile.DeleteFile(rs.getString("filename"));               
                                    df.DoZCDelete();
                                }
                                sql = " delete FROM egtzcfile where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and src='IPAD' ";
                                stmt.executeUpdate(sql);  
                            }
    //                        get byte[] convert to zip then unzip then upload (ftp) to server
                            if(saverptAL[i].getZcFileObjAL()!=null)//有上傳檔案有
                            {        
                                for(int fi=0; fi<saverptAL[i].getZcFileObjAL().length; fi++)
                                {
//                                      error_step = "儲存上傳檔案  fileobj.length = "+saverptAL[i].getFileobjAL().length;
                                    saveReportZCFileObj fileobj = saverptAL[i].getZcFileObjAL()[fi];                                
    //                                  String zipFile = "c:\\zip\\test.zip"; 
                                    error_step = "取得副檔名";
                                    String tempfilename = fileobj.getFilename().substring(0,fileobj.getFilename().indexOf("."));
                                    String zipFile = "/apsource/csap/projfz/webap/uploadfile/"+tempfilename+".zip"; 
        //                              String targetDirectory = "c:\\zip";                              
                                    String targetDirectory = "/apsource/csap/projfz/webap/uploadfile/";
                                    String saveDirectory = "/apsource/csap/projfz/webap/uploadfile/";
                                    error_step = "解壓縮";
                                    UnZipBean uzb = new UnZipBean(zipFile, targetDirectory);
                                    byte[] file_byte = fileobj.getZipfile();
                                    uzb.writeByteToZip(zipFile,file_byte);
                                    boolean succ = uzb.unzip();
                                    String[] unzipAL = null;  
                                    unzipAL = uzb.getFileAL();
                                    if(unzipAL.length>0)
                                    {  
                                        //insert Cabin report file upload
                                        sqlsb = new StringBuffer();
                                        sqlsb.append(" insert into egtzcfile (fltd,fltno,sect,filename,filedsc,upduser,upddate,src,app_filename)");
                                        sqlsb.append(" values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),'IPAD',?)");
                                        sql = sqlsb.toString();
                                        pstmt=null;
                                        pstmt = con.prepareStatement(sqlsb.toString());
                                        for(int j=0; j<unzipAL.length; j++)
                                        { //已unzip的檔案名稱                                    
                                          
                                          //****************file 上傳至ftp server                                          
                                            updZCFilePath ufp = new updZCFilePath();
                                            String newFilename =  ufp.getFilename() + unzipAL[j].substring(unzipAL[j].lastIndexOf(".")); //取副檔名
                                            
                                            try
                                            {
                                              //*************************************FTP to 202.165.148.99
//                                              FtpUtility example = new FtpUtility("202.165.148.99","/EG/PR/","egftp01","cseg#01");
//                                              FtpUtility example = new FtpUtility("202.165.148.99","/EGTEST/PR/","egtestftp01","egtest#01");
                                            
                                                FtpUrl url = new FtpUrl();//統一設定ftp Url.
                                                FtpUtility example = new FtpUtility(url.getIp(), url.getDirectory()+"PR/", url.getAccount(), url.getPass());
                                                example.connect();
//                                            example.setDirectory("/EG/PR/");
//                                            example.setDirectory("/EGTEST/PR/");       
                                                example.setDirectory(url.getDirectory()+"PR/");   
                                                example.putBinFile(saveDirectory + unzipAL[j],newFilename);
                                                example.close();
                                            }
                                            catch(Exception e)
                                            {
                                                error_step = "儲存上傳檔案 "+ e.toString();
    //                                            System.out.println(e);
                                            } 
                                            //******delete weblogic server temp file
                                            File f = new File(saveDirectory+unzipAL[j]);
                                            f.delete();                                  
                                            File zipf = new File(saveDirectory+tempfilename+".zip");
                                            zipf.delete();
                                            
                                            idx=0;                                          
                                            pstmt.setString(++idx,saverptAL[i].getFltd());
                                            pstmt.setString(++idx,saverptAL[i].getFltno());
                                            pstmt.setString(++idx,fileobj.getSect());
                                            pstmt.setString(++idx,newFilename);
                                            pstmt.setString(++idx,"N/A");
                                            pstmt.setString(++idx,fileobj.getUpduser());
                                            pstmt.setString(++idx,fileobj.getUpddate());
                                            pstmt.setString(++idx,fileobj.getFilename());
//                                            pstmt.setString(++idx,unzipAL[j]);
                                            pstmt.executeUpdate();
                                            con.commit();
                                        }    
                                    }
                                }
                            }//if(fileAL.size()>0)//有上傳檔案有
                            
                            //更新最後更新時間
                            error_step = "更新最後更新時間 ";
                            sql = " update egtzcflt set chgdate = to_date('"+saverptAL[i].getChgdate()+"','yyyy/mm/dd hh24:mi:ss') " +//, src = 'IPAD', src_tmst = sysdate
                            		"where fltd = to_date('"+saverptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+saverptAL[i].getFltno()+"' and sect = '"+saverptAL[i].getSect()+"' and zcempn = '"+saverptAL[i].getZcempn()+"'";
                            stmt.executeUpdate(sql); 
                            con.commit(); 
                            
                            saveobj.setResultMsg("1");
                            saveobj.setErrorMsg(saverptAL[i].getSeqno());
                            return "Y";
                        }//if("Y".equals(ifupdate))      
                        else
                        {
                            error_str = "WEB資料 已更新，無需同步";
                            saveobj.setResultMsg("0");
                            saveobj.setErrorMsg(error_str);                         
                            return "WEB資料 已更新，無需同步";                        
                        }
                    }// if(!"".equals(saverptAL[i].getFltd()) && !"".equals(saverptAL[i].getFltno()) && !"".equals(saverptAL[i].getSect()))
                    else
                    {
                        error_str = "資料輸入不完整";
                        saveobj.setResultMsg("0");
                        saveobj.setErrorMsg(error_str);
                        return "資料輸入不完整";    
                    }
                }//for(int i=0; i<saverptAL.length; i++)
                
            }
            else
            {                
                error_str = "無需更新資料"; 
                saveobj.setResultMsg("0");
                saveobj.setErrorMsg(error_str);
                return "無需更新資料";                
            }
        } 
        catch(Exception e) 
        {
//            System.out.println(e.toString());

            try
            {
//                fw = new FileWriter(path+"serviceLog.txt");
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+" "+fltnoInfo+" save PR rpt \r\n");       
                fw.write(e.toString() + " ** " +error_step +" Failed \r\n");   
                fw.write(sql+"\r\n");  
                fw.write("****************************************************************\r\n");
                fw.flush();
                fw.close();
            }
            catch (Exception e1)
            {
//                  System.out.println("e1"+e1.toString());
            }
            finally
            {               
            }
            saveobj.setResultMsg("0");
            saveobj.setErrorMsg(e.toString() + " ** " +error_step +" Failed");
            
            
            try{con.rollback();}catch(SQLException se){ return se.toString();}          
            return e.toString() + " ** " +error_step +" Failed";            
        }
        finally 
        {

            try
            {
//                fw = new FileWriter(path+"serviceLog.txt");
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+" save PR rpt \r\n");       
                fw.write(saveobj.getResultMsg() + "," +error_step + "," + saveobj.getErrorMsg() +" \r\n");   
                fw.write("****************************************************************\r\n");
                fw.flush();
                fw.close();
            }
            catch (Exception e1)
            {
//                  System.out.println("e1"+e1.toString());
            }
            finally
            {               
            }
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
            try{if(con != null) con.close();}catch(SQLException e){}
        } 
        return "Y";
    }
//  sent rpt
    public String sendZCreport(saveReportZCfltObj[] sendrptAL){
        String str = saveZCreport(sendrptAL);
        sendobj = new ReturnMsgObj();
        String path = "/apsource/csap/projfz/txtin/appLogs/";//"E://";
        FileWriter fw = null;
        if("Y".equals(str)){
            Connection con = null;
            PreparedStatement pstmt = null;
            Statement stmt = null;
            ResultSet rs = null;
            Driver dbDriver = null;
            String sql ="";
            String error_sql ="";
            String error_step ="";
            
                   
            ci.db.ConnDB cn = new ci.db.ConnDB();
            String oldSeqno = "";
            try
            {
                cn.setORP3EGUserCP();
                dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
                con = dbDriver.connect(cn.getConnURL(), null);
                
                //connect ORT1 EG            
//                  cn.setORT1EG();
//                  Class.forName(cn.getDriver());
//                  con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
                
                con.setAutoCommit(false);   
                stmt = con.createStatement();
                    
                if(sendrptAL.length>0){
                    for(int i=0; i<sendrptAL.length; i++){ 
                        error_step = "送出報告";
                        if(sendrptAL[i].getSeqno()!=null && !"".equals(sendrptAL[i].getSeqno())){
                            //delete egtzcflt then insert 
                            sql = " select seqno ,ifsent from egtzcflt where fltd = to_date('"+sendrptAL[i].getFltd()+"','yyyy/mm/dd') and fltno = '"+sendrptAL[i].getFltno()+"' and sect = '"+sendrptAL[i].getSect()+"' and zcempn = '"+sendrptAL[i].getZcempn()+"'";
                            rs = stmt.executeQuery(sql);
                            if (rs.next()){
                                oldSeqno = rs.getString("seqno"); 
                                if("Y".equals(rs.getString("ifsent"))){
                                    error_str = "報告已送出,不可編輯.";
                                    sendobj.setResultMsg("0");
                                    sendobj.setErrorMsg(error_str);
                                    return "報告已送出,不可編輯.";
                                }
                                if(sendrptAL[i].getSeqno().equals(oldSeqno)){
//                                  更新送出時間
                                    sql = " update egtzcflt set ifsent = 'Y' ,sentdate = to_date('"+sendrptAL[i].getChgdate()+"','yyyy/mm/dd hh24:mi:ss') , chgdate = to_date('"+sendrptAL[i].getChgdate()+"','yyyy/mm/dd hh24:mi:ss') , src = 'IPAD', src_tmst = sysdate " +
                                            "where fltd = to_date('"+sendrptAL[i].getFltd()+"','yyyy/mm/dd') and " +
                                            "fltno = '"+sendrptAL[i].getFltno()+"' and " +
                                            "sect = '"+sendrptAL[i].getSect()+"' and " +
                                            "zcempn = '"+sendrptAL[i].getZcempn()+"' and " +
                                            "seqno = '"+sendrptAL[i].getSeqno()+"' ";
                                    stmt.executeUpdate(sql);
                                }else{
                                    error_str = "資料與序號不符合";
                                    sendobj.setResultMsg("0");
                                    sendobj.setErrorMsg(error_str);
                                    return "資料與序號不符合";
                                }
                            }  
                        }                          
                        con.commit(); 
                        sendobj.setResultMsg("1");
                        sendobj.setErrorMsg(sendrptAL[i].getSeqno());
                    }//for(int i=0; i<sendrptAL.length; i++)    
                }else{
                    sendobj.setResultMsg("0");
                    sendobj.setErrorMsg("No data input.");                    
                }
            } 
            catch(Exception e) 
            {
//                System.out.println(e.toString());
                try
                {
                    fw = new FileWriter(path+"serviceLog.txt",true);
                    fw.write(new java.util.Date()+" send PR rpt \r\n");       
                    fw.write(e.toString() + " ** " +error_step +" Failed \r\n");   
                    fw.write(error_sql+"\r\n");  
                    fw.write("****************************************************************\r\n");
                    fw.flush();
                    fw.close();
                }
                catch (Exception e1)
                {
//                      System.out.println("e1"+e1.toString());
                }
                finally
                {               
                }
                
                try{con.rollback();}catch(SQLException se){ return se.toString();}    
                sendobj.setResultMsg("0");
                sendobj.setErrorMsg(e.toString() + " ** " +error_step +" Failed");
                return e.toString() + " ** " +error_step +" Failed";            
            }
            finally 
            {
                try
                {
//                    fw = new FileWriter(path+"serviceLog.txt");
                    fw = new FileWriter(path+"serviceLog.txt",true);
                    fw.write(new java.util.Date()+" send PR rpt \r\n");       
                    fw.write(sendobj.getResultMsg() + "," +error_step + "," + sendobj.getErrorMsg() +" \r\n");
                    fw.write("****************************************************************\r\n");
                    fw.flush();
                    fw.close();
                }
                catch (Exception e1)
                {
//                      System.out.println("e1"+e1.toString());
                }
                finally
                {               
                }
                try{if(rs != null) rs.close();}catch(SQLException e){}
                try{if(stmt != null) stmt.close();}catch(SQLException e){}
                try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
                try{if(con != null) con.close();}catch(SQLException e){}
            } 
            return "Y";
        }else{     
            sendobj.setResultMsg("0");
            sendobj.setErrorMsg(str);
            try
            {
//                fw = new FileWriter(path+"serviceLog.txt");
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+"\r\n");       
                fw.write(sendobj.getResultMsg() + " ** XXX Failed "+ sendobj.getErrorMsg() +" \r\n");   
                fw.write("****************************************************************\r\n");
                fw.flush();
                fw.close();
            }
            catch (Exception e1)
            {
//                  System.out.println("e1"+e1.toString());
            }
            finally
            {               
            }
            return str;
        }
    }
    
    public String error_str()
    {       
        return error_str;
    }

    public ReturnMsgObj getSaveobj()
    {
        return saveobj;
    }

    public ReturnMsgObj getSendobj()
    {
        return sendobj;
    }

    public void setSendobj(ReturnMsgObj sendobj)
    {
        this.sendobj = sendobj;
    }

    public void setSaveobj(ReturnMsgObj saveobj)
    {
        this.saveobj = saveobj;
    }
    
}
