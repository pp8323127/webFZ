package ws.prac.SFLY.MP;

import java.awt.*;
import java.io.*;
import java.sql.*;
import java.util.*;

import com.sun.org.apache.bcel.internal.generic.*;

import swap3ackhh.smsacP.*;
import ws.*;
import ws.prac.*;
import ws.prac.ZC.*;

import ci.db.*;
import eg.prfe.*;
import ftp.*;
import fz.pracP.*;
import fz.pracP.dispatch.*;
import fz.psfly.*;
import fzac.*;

public class MPsflyRptFun
{

    /**
     * @param args
     */
    public MPsflySafetyChkItemRObj SChkItem = null;
    public MPsflySelfInsItemRObj sInsItem = null; 
    public MPsflyEvaItemRObj sEvaItem = null;
    public MPsflySafetyChkItemRObj sAduItem = null;
    public MpSflyRObj sfly = null;
    
    private String seqno = "";
    MPsflySafetyChkRObj sChkR = null;
    MPsflySelfInsRObj sInsR = null;
    MPsflyEvaRObj sEvaR = null; 
    
    ReturnMsgObj saveobj = null;
    ReturnMsgObj sendobj = null;
    
    ArrayList objAL = new ArrayList();
    
    FileWriter fw = null;  
    String path = "/apsource/csap/projfz/txtin/appLogs/";

    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        MPsflyRptFun rpt = new MPsflyRptFun();
//        String fltd2 = "2014/09/04 17:10";
//        System.out.println(fltd2.substring(0,10));
//        rpt.SelfInsItem(fltd2, "TPELAX", "0006", "");
        rpt.SafetyAuditItem("2014/08/21", "", "", "");
        
//        rpt.CabinSafetyItem("2014/08/21", "", "", "");
//        System.out.println(rpt.getMpSflySeqno("2005/03/16", "TPE/LAX", "645/646", "625304","",""));
//        System.out.println(rpt.getSeqno());
//        rpt.setSeqno("13669");
//        rpt.getMpSfly("", "", "", "", "", "");
//        rpt.getSelfIns("924");
//        if("TPELAX".length() < 7){
//            System.out.println("TPE/LAX".substring(0,7));
//        } 
//        if("004".length() < 4){
//            System.out.println("0004".substring(0,4));
//        }
        
    }

//    1.Cabin Safety check Item yyyy/mm/dd
    public void CabinSafetyItem(String fltd,String sect,String fltno,String Empno){

        SChkItem = new MPsflySafetyChkItemRObj();   
        
        ConnDB cn = new ConnDB();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql = null;
        
        int count=1;
        int subcount=1;
        String siNo2 = "";
        try
        {
            String fdate_y  =   fltd.substring(0,4);
            String fdate_m  =   fltd.substring(5,7);
            String fdate_d  =   fltd.substring(8,10);
      
            GregorianCalendar cal1 = new GregorianCalendar();
            GregorianCalendar cal2 = new GregorianCalendar();
    
            //2009/07/20 後項目異動
            cal1.set(Calendar.YEAR,2009);
            cal1.set(Calendar.MONTH,7-1);
            cal1.set(Calendar.DATE,20);
     
            //Fltdt
            cal2.set(Calendar.YEAR,Integer.parseInt(fdate_y));
            cal2.set(Calendar.MONTH,Integer.parseInt(fdate_m)-1);
            cal2.set(Calendar.DATE,Integer.parseInt(fdate_d));
            
            if(cal2.before(cal1))
            {
                String[] cho = {"YES","NO","N/A"};
                String[] chokey = {"1","2","0"};
                SChkItem.setCho(cho);
                SChkItem.setChokey(chokey);
                
            }
            else
            {
                String[] cho = {"YES","NDIP","N/A"};
                String[] chokey = {"1","2","0"};
                SChkItem.setCho(cho);
                SChkItem.setChokey(chokey);
            }            
            
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
////          cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = con.createStatement();       
            
//          Attribute
            ArrayList attObjAL = new ArrayList();
            sql = "select itemno,itemdsc from egtstrm order by itemno";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflySafetyChkAttObj attObj = new MPsflySafetyChkAttObj();
                attObj.setItemNo(rs.getString("itemno"));
                attObj.setItemdsc(rs.getString("itemdsc"));
                attObjAL.add(attObj);
            }  
            if(attObjAL.size()>0){
                MPsflySafetyChkAttObj[] attributeArr = new MPsflySafetyChkAttObj[attObjAL.size()];
                for(int i=0;i<attObjAL.size();i++){
                    attributeArr[i] = (MPsflySafetyChkAttObj)attObjAL.get(i);
                }
                SChkItem.setAttributeArr(attributeArr);
            }
            
//          題庫
            sql = "select * from egtstfi where flag='Y' order by itemno";
            rs = stmt.executeQuery(sql); 
            ArrayList queObjAL = new ArrayList();      
            if(rs != null){        
                while(rs.next()){ 
                    MPsflySafetyChkQueObj queObj = new MPsflySafetyChkQueObj();
                    queObj.setItemno(rs.getString("itemno"));//fiNo
                    queObj.setItemDsc(rs.getString("itemDsc"));
                    queObj.setFlag(rs.getString("flag"));
                    queObjAL.add(queObj);
                }
            }            
            String temp =null;
//          子題庫
            if(null!=queObjAL && queObjAL.size()>0){
                MPsflySafetyChkQueObj[] queArr = new MPsflySafetyChkQueObj[queObjAL.size()];
                for(int i=0;i<queObjAL.size();i++){ 
                    MPsflySafetyChkQueObj queObj = (MPsflySafetyChkQueObj) queObjAL.get(i);                    
                    sql = "select itemno, itemdsc, kin, sflag,selectitem from egtstsi where kin='"+queObj.getItemno()+"' AND sflag = 'Y' order by itemdsc";
                    rs = stmt.executeQuery(sql);                     
                    ArrayList queSObjAL = new ArrayList();  
                    if(rs!= null){                    
                        while(rs.next()){      
                            MPsflySafetyChkQsubObj qsubObj = new MPsflySafetyChkQsubObj();
                            qsubObj.setItemno(rs.getString("itemno"));                
                            qsubObj.setItemdsc(rs.getString("itemdsc"));
                            qsubObj.setKin(rs.getString("kin"));
                            qsubObj.setSflag(rs.getString("sflag"));
                            temp=rs.getString("selectitem");
                            if(temp != null && !"".equals(temp)){
                                qsubObj.setSelectItem(temp.split("[*]"));
                            }
                            siNo2 = count +"."+ subcount;
                            qsubObj.setItemnoRv(siNo2);   
                            subcount++;
                            queSObjAL.add(qsubObj);
                         }
                        
                    }   
                    MPsflySafetyChkQsubObj[] subQueArr = new MPsflySafetyChkQsubObj[queSObjAL.size()];
                    for(int j=0;j<queSObjAL.size();j++){
                        subQueArr[j] = (MPsflySafetyChkQsubObj) queSObjAL.get(j);                        
                    }
                    queObj.setSubQueArr(subQueArr);  
                    queObj.setItemno(count+"");
                    subcount=1;
                    count++;                    
                    queArr[i] = queObj;
                }
                SChkItem.setQueArr(queArr);

                SChkItem.setResultMsg("1");
                SChkItem.setErrorMsg("done.");
            }
        }
         catch(Exception e)
        {
//            System.out.print(e.toString());
            SChkItem.setResultMsg("0");
            SChkItem.setErrorMsg("sfltySafety:"+e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(con != null) con.close();}catch(SQLException e){}
        }
    
    } 
//    2.Self Inspection Item yyyy/mm/dd hh24:mm
    public void SelfInsItem(String fltd,String sect,String fltno,String Empno){
        sInsItem = new MPsflySelfInsItemRObj();
        
        ConnDB cn = new ConnDB();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql = null;
        String fdate = fltd.substring(0,10);//yyyy/mm/dd hh24:mm
        int count=1;
        int subcount=1;
        String siNo2 = "";
        String CM = "";
        try
        {
            
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
////          cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = con.createStatement();       
            
           /*set Attribute*/
            ArrayList attObjAL = new ArrayList();
            sql = "select itemno,itemdsc from egtstrm order by itemno";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflySafetyChkAttObj attObj = new MPsflySafetyChkAttObj();
                attObj.setItemNo(rs.getString("itemno"));
                attObj.setItemdsc(rs.getString("itemdsc"));
                attObjAL.add(attObj);
            }  
            if(attObjAL.size()>0){
                MPsflySafetyChkAttObj[] attributeArr = new MPsflySafetyChkAttObj[attObjAL.size()];
                for(int i=0;i<attObjAL.size();i++){
                    attributeArr[i] = (MPsflySafetyChkAttObj)attObjAL.get(i);
                }
                sInsItem.setAttributeArr(attributeArr);
            }
            /*set Attribute*/
            
            /*set crew*/
            GetFltInfo ft = new GetFltInfo(fdate, fltno ,sect ,"");
            if(!ft.isHasData()){                    
                ft = new GetFltInfo(fdate,  fltno,  sect);
            }
            FlightCrewList fcl = new FlightCrewList(ft,sect,fltd);//hhmm
            ArrayList<fz.prObj.FltObj> dataAL = new ArrayList<fz.prObj.FltObj>();
            ArrayList<CrewInfoObj> crewObjList = new ArrayList<CrewInfoObj>();
            fzac.CrewInfoObj cmObj = null;
            
            fcl.RetrieveData();
            crewObjList = fcl.getCrewObjList(); // 組員資料名單
            
            ft.RetrieveData();
            dataAL = ft.getDataAL();                

            if(null != dataAL){
              if(dataAL.size()>0){
                  for(int i=0 ;i<dataAL.size();i++){  
                    if(!"TVL".equals(dataAL.get(i).getPurCrewObj().getDuty_cd())){//抓非TVL 顯示 
                            cmObj = dataAL.get(i).getPurCrewObj();
                    }
                  }                  
              }else{
                  cmObj = dataAL.get(0).getPurCrewObj();
              }         
              ReportListFun fun = new ReportListFun();
              fun.getPurInfo(cmObj.getEmpno());
              cmObj.setEmpno(cmObj.getEmpno());
              cmObj.setSern(fun.getPurObj().getPsrSern());              
              cmObj.setCname(fun.getPurObj().getPsrCName());//客艙經理   去掉特殊符號ex:PA*
              cmObj.setGrp(fun.getPurObj().getPsrGrp());
              crewObjList.add(cmObj); 

              CM = cmObj.getEmpno();
            }
            if (crewObjList != null && crewObjList.size() > 0) {
                MPsflySelfCrew[] crewArr = new MPsflySelfCrew[crewObjList.size()];
                for (int i = 0; i < crewObjList.size(); i++) {
                    MPsflySelfCrew obj = new MPsflySelfCrew();
                    obj.setEmpno(crewObjList.get(i).getEmpno().toString());
                    obj.setName(crewObjList.get(i).getCname().toString());
                    crewArr[i] = obj;
                }
                sInsItem.setCrewArr(crewArr);               
            }
//            else{
//                  MPsflySelfCrew[] crewArr = new MPsflySelfCrew[2];
//                  MPsflySelfCrew crewobj = new MPsflySelfCrew();
//                  crewobj.setEmpno("123456");
//                  crewobj.setName("張大寶");
//                  crewArr[0] = crewobj;
//      
//                  crewobj = new MPsflySelfCrew();
//                  crewobj.setEmpno("123457");
//                  crewobj.setName("李二寶");
//                  crewArr[1] = crewobj;
//                  sInsItem.setCrewArr(crewArr);
//            }
            /*set crew*/
            
            /*set Subject*/
            objAL = null;
            objAL = new ArrayList();
            sql = "select nvl(itemno,'0') itemno ,subject from egtstci where flag = 'Y' order by itemno";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflySelfInsItemObj itemObj = new MPsflySelfInsItemObj();
                itemObj.setItemno(rs.getString("itemno"));
                itemObj.setSubject(rs.getString("subject"));
                objAL.add(itemObj);
            }  
            
            if(objAL.size()>0){
                MPsflySelfInsItemObj[] itemArr = new MPsflySelfInsItemObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    MPsflySelfInsItemObj obj = (MPsflySelfInsItemObj) objAL.get(i);
//                    obj.setSern(i+1+"");//
                    if(null != obj && ( null != obj.getItemno()|| !("null").equalsIgnoreCase(obj.getItemno()))){
                        int temp = Integer.parseInt(obj.getItemno());
                        if(temp >=159 && temp <=189){//題庫預設值
                            obj.setNoChecked("1");
                            obj.setCorr("1");
                            obj.setCrew(CM);
                        }
                    }                    
                    itemArr[i] = obj;
                }
                sInsItem.setInsItem(itemArr);
                
            }
//            MPsflySelfInsItemObj[] item = new MPsflySelfInsItemObj[2];
//            MPsflySelfInsItemObj obj1 = new MPsflySelfInsItemObj();
//            obj1.setItemno("144");
//            obj1.setSubject("供個人使用之打火機，是否被允許放置於Check- In & carry-on baggage中？");
//            item[0] = obj1;
//            
//            obj1 = new MPsflySelfInsItemObj();
//            obj1.setItemno("142");
//            obj1.setSubject("如發覺旅客攜帶有Dangerous Goods標籤之盒子上機，該如何處理？");
//            item[1] = obj1;
//            sInsItem.setInsItem(itemArr);

            sInsItem.setResultMsg("1");
            sInsItem.setErrorMsg("done.");
        }
        catch(Exception e)
        {
          System.out.print(e.toString());
            sInsItem.setResultMsg("0");
            sInsItem.setErrorMsg("sfltyIns:"+e.toString());
      }
      finally
      {
          try{if(rs != null) rs.close();}catch(SQLException e){}
          try{if(stmt != null) stmt.close();}catch(SQLException e){}
          try{if(con != null) con.close();}catch(SQLException e){}
      }
    }
//    3.CM/MC Evaluation Item yyyy/mm/dd
    public void EvaluationItem(String fltd,String sect,String fltno,String Empno){
        sEvaItem = new MPsflyEvaItemRObj();
        ConnDB cn = new ConnDB();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql = null;
        String temp = "";
        try
        {
            
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
////          cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = con.createStatement();       
            
//          Attribute
            objAL = new ArrayList();
            sql = "SELECT mi.eval_itemno,mi.eval_itemdesc,si.eval_subitemno,si.eval_subitemdesc,si.EVAL_KIN,"+
                    "eval_grade_percentage, pi.KPI_ITEMNO,pi.KPI_ITEMDESC,KPI_KIN,KPI_FLAG "+
                    "FROM egtfekpi pi, egtfesi si, egtfemi mi "+
                    "WHERE kpi_flag = 'Y' AND pi.kpi_kin = si.eval_subitemno AND mi.eval_itemno = si.eval_kin "+
                    "ORDER BY mi.eval_itemno,To_Number(si.eval_subitemno),To_Number(pi.kpi_kin),To_Number(pi.kpi_itemno) ";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflyEvaItemObj obj = new MPsflyEvaItemObj();
                obj.setEval_itemno(rs.getString("eval_itemno"));
                obj.setEval_itemdesc(rs.getString("eval_itemdesc"));
                obj.setEval_subitemno(rs.getString("eval_subitemno"));
                obj.setEval_subitemdesc(rs.getString("eval_subitemdesc"));
                obj.setEval_kin(rs.getString("EVAL_KIN"));
                obj.setEval_grade_percentage(rs.getString("eval_grade_percentage"));
                obj.setKpi_itemno(rs.getString("KPI_ITEMNO"));
                obj.setKpi_itemdesc(rs.getString("KPI_ITEMDESC"));
                obj.setKpi_kin(rs.getString("KPI_KIN"));
                obj.setKpi_flag(rs.getString("KPI_FLAG"));
                objAL.add(obj);
            }  
            if(objAL.size()>0){
                MPsflyEvaItemObj[] evaItemArr = new MPsflyEvaItemObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    evaItemArr[i] = (MPsflyEvaItemObj)objAL.get(i);
                }
                sEvaItem.setEvaItemArr(evaItemArr);
            }
            
            /******建議事項******/
            objAL = new ArrayList();
            sql = "select itemno,itemdsc,flag from egtprsug where flag = 'Y'";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflySugObj obj = new MPsflySugObj();
                obj.setItemNo(rs.getString("itemno"));
                obj.setItemDsc(rs.getString("itemdsc"));                
                objAL.add(obj);
            }  
            if(objAL.size()>0){
                MPsflySugObj[] sugItemArr = new MPsflySugObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    sugItemArr[i] = (MPsflySugObj)objAL.get(i);
                }
                sEvaItem.setSugItemArr(sugItemArr);
            }
//            MPsflySugObj[] sugItemArr = new MPsflySugObj[3];
//            MPsflySugObj obj = new MPsflySugObj();
//            obj.setItemNo("SG001");
//            obj.setItemDsc("訂位");
//            sugItemArr[0] = obj;
//
//            obj = new MPsflySugObj();
//            obj.setItemNo("SG002");
//            obj.setItemDsc("票務");
//            sugItemArr[1] = obj;
//
//            obj = new MPsflySugObj();
//            obj.setItemNo("SG003");
//            obj.setItemDsc("會員事宜");
//            sugItemArr[2] = obj;

//            sEvaItem.setSugItemArr(sugItemArr);            
//               {"SG004/座椅", "SG005/設備","SG006/貴賓室","SG007/餐飲","SG008/空服","SG009/登機作業","SG010/AVOD","SG011/劃位櫃檯","SG012/公司政策","SG013/其他"};
            /******顧客反應******/
            objAL = new ArrayList();
            sql = "SELECT itemno,itemdsc,selectitem from egtprcus where flag = 'Y'";
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                MPsflyCatObj obj = new MPsflyCatObj();
                obj.setItemNo(rs.getString("itemno"));
                obj.setItem(rs.getString("itemdsc"));
                temp = rs.getString("selectitem");
                if(null!=temp && !"".equals(temp)){
                    obj.setSeletItem(temp.split("/"));
                }                
                objAL.add(obj);
            }            
            if(objAL.size()>0){
                MPsflyCatObj[] cateItemAr = new MPsflyCatObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    cateItemAr[i] = (MPsflyCatObj)objAL.get(i);
                }

                sEvaItem.setCateItemAr(cateItemAr);
            }
//            MPsflyCatObj[] cateItemAr = new MPsflyCatObj[2];
//            MPsflyCatObj obj1 = new MPsflyCatObj();
//            obj1.setItemNo("001");
//            obj1.setItem("服務流程");
//            String[] selItem = {"流程完善","流程失當"};
//            obj1.setSeletItem(selItem);
//            cateItemAr[0]=obj1;
//            
//            obj1 = new MPsflyCatObj();
//            obj1.setItemNo("002");
//            obj1.setItem("餐飲");
//            String[] selItem2 = {"餐飲完善","餐飲缺失"};
//            obj1.setSeletItem(selItem2);
//            cateItemAr[1]=obj1;            
//            sEvaItem.setCateItemAr(cateItemAr);
            
            /************/
            sEvaItem.setResultMsg("1");
            sEvaItem.setErrorMsg("done.");
        }
        catch(Exception e)
        {
//          System.out.print(e.toString());
            sEvaItem.setResultMsg("0");
            sEvaItem.setErrorMsg("Eval:"+e.toString());
      }
      finally
      {
          try{if(rs != null) rs.close();}catch(SQLException e){}
          try{if(stmt != null) stmt.close();}catch(SQLException e){}
          try{if(con != null) con.close();}catch(SQLException e){}
      }
       
    }
//    4.Safety audit
    public void SafetyAuditItem(String fltd,String sect,String fltno,String Empno){

        sAduItem = new MPsflySafetyChkItemRObj();   
        
        ConnDB cn = new ConnDB();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql = null;
        
//        int count=1;
//        int subcount=1;
//        String siNo2 = "";
        int temp = 0;
        try
        {
//            String fdate_y  =   fltd.substring(0,4);
//            String fdate_m  =   fltd.substring(5,7);
//            String fdate_d  =   fltd.substring(8,10);
//      
//            GregorianCalendar cal1 = new GregorianCalendar();
//            GregorianCalendar cal2 = new GregorianCalendar();
//    
//            //2009/07/20 後項目異動
//            cal1.set(Calendar.YEAR,2009);
//            cal1.set(Calendar.MONTH,7-1);
//            cal1.set(Calendar.DATE,20);
//    
//            //Fltdt
//            cal2.set(Calendar.YEAR,Integer.parseInt(fdate_y));
//            cal2.set(Calendar.MONTH,Integer.parseInt(fdate_m)-1);
//            cal2.set(Calendar.DATE,Integer.parseInt(fdate_d));
//            
//            if(cal2.before(cal1))
//            {
//                String[] cho = {"YES","NO","N/A"};
//                SChkItem.setCho(cho);
//            }
//            else
//            {
//                String[] cho = {"YES","NDIP","N/A"};
//                SChkItem.setCho(cho);
//            }            
            String[] cho = {"PASS","FAIL"};
            sAduItem.setCho(cho);
            
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            con = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = con.createStatement();       
            
////          Attribute
//            ArrayList attObjAL = new ArrayList();
//            sql = "select itemno,itemdsc from egtstrm order by itemno";
//            rs = stmt.executeQuery(sql);
//            while(rs.next())
//            {
//                MPsflySafetyChkAttObj attObj = new MPsflySafetyChkAttObj();
//                attObj.setItemNo(rs.getString("itemno"));
//                attObj.setItemdsc(rs.getString("itemdsc"));
//                attObjAL.add(attObj);
//            }  
//            if(attObjAL.size()>0){
//                MPsflySafetyChkAttObj[] attributeArr = new MPsflySafetyChkAttObj[attObjAL.size()];
//                for(int i=0;i<attObjAL.size();i++){
//                    attributeArr[i] = (MPsflySafetyChkAttObj)attObjAL.get(i);
//                }
//                SChkItem.setAttributeArr(attributeArr);
//            }
            
//          題庫
            sql = "select * from egtsafi where flag = 'Y' order by itemno";
            rs = stmt.executeQuery(sql); 
            ArrayList queObjAL = new ArrayList();      
            if(rs != null){        
                while(rs.next()){ 
                    MPsflySafetyChkQueObj queObj = new MPsflySafetyChkQueObj();
                    queObj.setItemno(rs.getString("itemno"));
                    queObj.setItemDsc(rs.getString("itemDsc"));
                    queObj.setFlag(rs.getString("flag"));
                    queObjAL.add(queObj);
                }
            }            
            
//          子題庫   
            
            sql = "select * from egtpsfi where kin = 'F' order by to_number(itemno)";
            rs = stmt.executeQuery(sql);                     
            ArrayList queSObjAL = new ArrayList();  
            if(rs!= null){                    
                while(rs.next()){      
                    MPsflySafetyChkQsubObj qsubObj = new MPsflySafetyChkQsubObj();
                    qsubObj.setItemno(rs.getString("itemno"));                
                    qsubObj.setItemdsc(rs.getString("itemdesc"));
//                    qsubObj.setKin(rs.getString("kin"));
//                    qsubObj.setSflag(rs.getString("sflag"));
                    queSObjAL.add(qsubObj);
                 }
                
            }
//          A  Flight Preparation#335~343
//          B  Pax Boarding   #344~345
//          C  After CabinDoor Closed #346~352
//          D  In-flight   #353~356
//          E  Final Apporach #357~360
//          F  Taxing-In   #361~363
//          G  Post Flight  #364~365
            String[] selArr = {"EMK","FAK","UPK","POB","PBE","Flash Light","Radio beacon"," Megaphone","Infant life vest","Spare life vest","Fire extinguisher"," Water fire extinguisher","Demo kit","Extension seat belt"};
            if(null!=queObjAL && queObjAL.size()>0){
                MPsflySafetyChkQueObj[] queArr = new MPsflySafetyChkQueObj[queObjAL.size()];
                
                for(int i=0;i<queObjAL.size();i++){ 
                    MPsflySafetyChkQueObj queObj = (MPsflySafetyChkQueObj) queObjAL.get(i); 
                    ArrayList tempObjAL = new ArrayList();
                    for(int j=0;j<queSObjAL.size();j++){
                        MPsflySafetyChkQsubObj subQueObj = (MPsflySafetyChkQsubObj)queSObjAL.get(j);
                        if(subQueObj.getItemno()!= null && !"".equals(subQueObj.getItemno())){
                            temp = Integer.parseInt(subQueObj.getItemno());
                            if(temp == 339){
                                subQueObj.setSelectItem(selArr);
                            }
                        }
                        if(queObj.getItemno().equals("A") && (temp >= 335 && temp <= 343)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }else if(queObj.getItemno().equals("B") && (temp >= 344 && temp <= 345)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }else if(queObj.getItemno().equals("C") && (temp >= 346 && temp <= 352)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }else if(queObj.getItemno().equals("D") && (temp >= 353 && temp <= 356)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }else if(queObj.getItemno().equals("E") && (temp >= 357 && temp <= 360)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }else if(queObj.getItemno().equals("F") && (temp >= 361 && temp <= 363)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }else if(queObj.getItemno().equals("G") && (temp >= 364 && temp <= 365)){
                            subQueObj.setKin(queObj.getItemno());
                            tempObjAL.add(subQueObj);
                        }    
                        
                    } 
                    
                    MPsflySafetyChkQsubObj[] subQueArr = new MPsflySafetyChkQsubObj[tempObjAL.size()];
                    for(int j=0;j<tempObjAL.size();j++){
                        subQueArr[j] = (MPsflySafetyChkQsubObj) tempObjAL.get(j);                   
                    }
                    queObj.setSubQueArr(subQueArr);
               
                    queArr[i] = queObj;
                }
                sAduItem.setQueArr(queArr);

                sAduItem.setResultMsg("1");
                sAduItem.setErrorMsg("done.");
            }
        }
         catch(Exception e)
        {
//            System.out.print(e.toString()+sql);
             sAduItem.setResultMsg("0");
             sAduItem.setErrorMsg("sfltyAudit:"+e.toString());
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(con != null) con.close();}catch(SQLException e){}
        }
    
    } 
    
//    4.query all yyyy/mm/dd hh24:mm
    public void getMpSfly(String fltd2,String sect,String fltno,String empno,String fleet,String acNo){
        sfly = new MpSflyRObj();
        String fltd = fltd2.substring(0,10);
        String str = getMpSflySeqno(fltd, sect, fltno, empno, fleet, acNo);
//        str ="Y";
        String result = "";
        String errorStr = "";

        sect = sect.replace("/", "").substring(0,6);
        fltno = fltno.replace("/", "").substring(0,4);
        if("Y".equals(str)){
            /********Cabin Safety check Query*******/
            result =  getCabinSafety(getSeqno());
            if("Y".equals(result)){
                sfly.setsChkR(sChkR);   
            }else{
                errorStr += "SafetyChk:"+result;
            }            
            /********Self Inspection Query   *******/
            result = getSelfIns(getSeqno());
            if("Y".equals(result)){
                sfly.setsInsR(sInsR);
            }else{
                errorStr += "SelfIns:"+result; 
            }
            /********CM/PR Evaluation Query  *******/  
            result = getEval(getSeqno());
            if("Y".equals(result)){
                sfly.setsEvaR(sEvaR);
            }else{
                errorStr += "Evaluation:"+result; 
            }   
            if(!"".equals(errorStr) && null!=errorStr){
                sfly.setResultMsg("0");
                sfly.setErrorMsg("Query MP rpt Error1");
                try
                {
                    fw = new FileWriter(path+"serviceLog.txt",true);
                    fw.write(new java.util.Date() +" "+ fltd +" "+ fltno +" "+ sect + "\r\n");       
                    fw.write("MP rpt Y Error : " + errorStr +"\r\n");   
                    //fw.write(sql+"\r\n");  
                    fw.write("****************************************************************\r\n");
                    fw.flush();
                    fw.close();
                }
                catch (Exception e1){
//                          System.out.println("e1"+e1.toString());
                }
                finally{               
                }
            }else{
                sfly.setResultMsg("1");
                sfly.setErrorMsg("Done");
            }
        }else if("N".equals(str)){
//            stti無報告,查詢表頭回傳
            sChkR = new MPsflySafetyChkRObj();
            try
            {
                GetFltInfo ft = new GetFltInfo(fltd, fltno ,sect ,"");
                if(!ft.isHasData()){                    
                    ft = new GetFltInfo(fltd,  fltno,  sect);
                }
                FlightCrewList fcl = new FlightCrewList(ft,sect,fltd2);//hhmm
                
                fcl.RetrieveData();
                ArrayList<CrewInfoObj> crewObjList = fcl.getCrewObjList(); // 組員資料名單          
                fz.prObj.FltObj fltObj = fcl.getFltObj();// 航班資料   
                fzac.CrewInfoObj mpObj = fcl.getMpCrewObj();//MP 資料
                fzac.CrewInfoObj cmObj = fcl.getPurCrewObj();//CM/MC 資料
                        
                ft.RetrieveData();
                ArrayList<fz.prObj.FltObj> dataAL = ft.getDataAL();
                if(null != fltObj){
                    sChkR.setFltno(fltno);
                    sChkR.setAcno(fltObj.getAcno());                    
                    // If 彈派
                    FlexibleDispatch fd = new FlexibleDispatch();
                    sChkR.setFleet(fd.getDa13_Fleet_cd(fltd, fltno, sect)); 
                    
                    //Class Type
                    ClassType fun = new ClassType();
                    if(null!= sChkR.getFleet() && !"".equals( sChkR.getFleet())){
                        if("Y".equals(fun.getClassTypebyFleet(sChkR.getFleet()))){
                            sChkR.setClass_cat(fun.getClassTypeAr());
                        }                                            
                    }else{
                        if(null!=sChkR.getAcno() && !"".equals(sChkR.getAcno())){                                               
                            if("Y".equals(fun.getClassTypebyACno(sChkR.getAcno()))){
                                sChkR.setClass_cat(fun.getClassTypeAr());
                            } 
                        }
                    }
                }
                if(null != mpObj){
                    ReportListFun rpt = new ReportListFun();
                    rpt.getPurInfo(mpObj.getEmpno());//cmObj.getEmpno()
                    sChkR.setInstname(rpt.getPurObj().getPsrCName());
                    sChkR.setInstempno(mpObj.getEmpno());
                    if(null != dataAL){
                        if(dataAL.size()>0){                        
                            for(int i=0 ;i<dataAL.size();i++){  
                              if( empno.equals(dataAL.get(i).getPurCrewObj().getEmpno())){//有此empno
                                  cmObj = dataAL.get(i).getPurCrewObj();
                              }
                              else{//無此empno
                                  if( !"TVL".equals(dataAL.get(i).getPurCrewObj().getDuty_cd())){//抓非TVL 顯示 
                                      cmObj = dataAL.get(i).getPurCrewObj();
                                  }                              
                              }
                            }
                            
                        }else{
                            cmObj = dataAL.get(0).getPurCrewObj();
                        }
                        rpt.getPurInfo(cmObj.getEmpno());
                        sChkR.setPursern(rpt.getPurObj().getPsrSern());
                        sChkR.setPurname(rpt.getPurObj().getPsrCName());//客艙經理   去掉特殊符號ex:PA*
                    }
                    if(null!=fltObj){
//                        sChkR.setFltd(fltd);
//                        sChkR.setFltno(fltno);
//                        sChkR.setTrip(trip);
                        sChkR.setAcno(fltObj.getAcno());
                     // If 彈派
                        FlexibleDispatch fd = new FlexibleDispatch();
                        sChkR.setFleet(fd.getDa13_Fleet_cd(fltd, fltno, sect));//dd
                    }
                    sfly.setsChkR(sChkR);
                    sfly.setResultMsg("1");
                    sfly.setErrorMsg("done.");
                }else{
                    sfly.setResultMsg("1");
                    sfly.setErrorMsg("No data.");
                }
            }
            catch ( SQLException e ){
                sfly.setResultMsg("0");
                errorStr += e.toString();
                sfly.setErrorMsg("Query MP rpt Error2");
            }
            catch ( Exception e ){
                sfly.setResultMsg("0");
                errorStr += e.toString();
                sfly.setErrorMsg("Query MP rpt Error2");
            }finally{
                if("0".equals(sfly.getResultMsg())){
                    try
                    {
                        fw = new FileWriter(path+"serviceLog.txt",true);
                        fw.write(new java.util.Date() +" "+ fltd +" "+ fltno +" "+ sect +"\r\n");       
                        fw.write("MP rpt N Error : " + errorStr +"\r\n");   
                        //fw.write(sql+"\r\n");  
                        fw.write("****************************************************************\r\n");
                        fw.flush();
                        fw.close();
                    }
                    catch (Exception e1){
//                              System.out.println("e1"+e1.toString());
                    }
                    finally{               
                    }
                }                
            }
        }else{
            sfly.setResultMsg("0");
            sfly.setErrorMsg("Query MP rpt Error3");
            try
            {
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date() +" "+ fltd +" "+ fltno +" "+ sect +"\r\n");       
                fw.write("MP rpt sernno Error : " + str +"\r\n");   
                //fw.write(sql+"\r\n");  
                fw.write("****************************************************************\r\n");
                fw.flush();
                fw.close();
            }
            catch (Exception e1){
//                      System.out.println("e1"+e1.toString());
            }
            finally{               
            }
        }
        
    }
//    5.save all
    public String saveMpSfly(MpSflyRObj[] saverptAL){
//        if(sect.length() < 6){
//            return "請輸入航段";
//        }     
//        if(fltno.length() < 3){
//            return "請輸入至少一段班號";
//        }
//        if(fleet.length() < 3){
//            return "請輸入至少一機型代碼";
//        }
//        if(acNo.length() < 5){
//            return "請輸入至少一飛機編號";
//        }
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
        String oldSeqno = "";
        String error_str = "";
        String error_sql_dt = "";
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
                    MpSflyRObj saverptobj = (MpSflyRObj) saverptAL[i];
                    if(null != saverptAL[i].getsChkR() && !"".equals(saverptAL[i].getsChkR().getFltd()) && !"".equals(saverptAL[i].getsChkR().getFltno()) && !"".equals(saverptAL[i].getsChkR().getTrip()) && saverptAL[i].getsChkR().getFltd() != null && saverptAL[i].getsChkR().getFltno() != null && saverptAL[i].getsChkR().getTrip() != null)
                    {   
                         //*************************************************************************************
                        isNewCheckForSFLY check = new isNewCheckForSFLY();
                        boolean isNew = check.checkTime("",saverptAL[i].getsChkR().getFltd());//2014/11/11    
                        if(!isNew){
                            error_str="無法上傳! iCS SFLY同步報告,適用於2014年11月起之航班.先前航班請由網頁版進行編輯.";
                            saveobj.setResultMsg("0");
                            saveobj.setErrorMsg(error_str);
                            return error_str;
                        }
                        //check if ipad's is updated data
                        //saverptAL[i].getsChkR().getUpdate_time() 較小或已送出則無需覆蓋(更新)
    //                      if(saverptAL[i].getUpdate_time()!=null && !"".equals(saverptAL[i].getUpdate_time()) && !"N".equals(saverptAL[i].getUpd()))
                        if(saverptAL[i].getsChkR().getUpddt()!=null && !"".equals(saverptAL[i].getsChkR().getUpduser()))
                        {
    //                        check report status
                            String status_str  = "";
                            SaveMpRptCheck src = new SaveMpRptCheck();
                            status_str = src.doSaveReportCheck(saverptAL[i].getsChkR().getFltd(),saverptAL[i].getsChkR().getFltno(),saverptAL[i].getsChkR().getTrip(),saverptAL[i].getsChkR().getInstempno());
                            
                            if("Y".equals(status_str))
                            {                       
                                sql = "select CASE WHEN To_Date('"+saverptAL[i].getsChkR().getUpddt()+"','yyyy/mm/dd hh24:mi:ss') <= upddt THEN 'N' ELSE 'Y' END ifupdated from egtstti where fltd = to_date('"+saverptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and fltno like '"+saverptAL[i].getsChkR().getFltno()+"%' and trip like '"+saverptAL[i].getsChkR().getTrip()+"%'";                    
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
                                            
                        if("Y".equals(ifupdate))
                        {
    
                            error_step = "儲存報告主檔";
                            if(saverptAL[i].getsChkR().getSernno()!=null && !"".equals(saverptAL[i].getsChkR().getSernno())){
                                
                                sql = " select sernno from EGTSTTI where fltd = to_date('"+saverptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and fltno like '"+saverptAL[i].getsChkR().getFltno()+"%' and trip like '"+saverptAL[i].getsChkR().getTrip()+"%' and instempno = '"+saverptAL[i].getsChkR().getInstempno()+"'";
                                rs = stmt.executeQuery(sql);
                                if (rs.next()){
                                    oldSeqno = rs.getString("sernno");   
                                    if(saverptAL[i].getsChkR().getSernno().equals(oldSeqno)){                                
                                        ifNew = false;
                                    }else{
                                        error_str = "資料與序號不符合";
                                        saveobj.setResultMsg("0");
                                        saveobj.setErrorMsg(error_str);
                                        return "資料與序號不符合";
                                    }   
                                }                                                
                            }  
//                            try
//                            {
//                                fw = new FileWriter(path+"serviceLog.txt",true);
//                                fw.write("****************************************************************\r\n");       
//                                fw.write(sql+ifNew + " ** "+ error_step+ "\r\n");   
//                                fw.write("oldSeqno:"+oldSeqno+"\r\n");  
//                                fw.write("getSernno()"+saverptAL[i].getsChkR().getSernno()+"\r\n");  
//                                fw.write("****************************************************************\r\n");
//                                fw.flush();
//                                fw.close();
//                            }
//                            catch (Exception e1)
//                            {
////                                      System.out.println("e1"+e1.toString());
//                            }
//                            finally
//                            {               
//                            }
                            
                            if(!ifNew){
                                error_step = "儲存舊的主檔.";
                                //delete EGTSTTI then insert
                                sql = " delete from EGTSTTI where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'" ;
                                stmt.executeUpdate(sql);
                            }else{
                                //get new sernno.
                                sql = "select max(to_number(sernno))+1 sernno from EGTSTTI";
                                rs = stmt.executeQuery(sql);
                                if (rs.next()){
                                    saverptAL[i].getsChkR().setSernno(rs.getString("sernno"));    
    //                                System.out.println(rs.getString("sernno"));
                                }                             
                            } 
                            
                            sqlsb = new StringBuffer();
                         
                            sqlsb.append(" insert into egtstti (SERNNO, FLTD, FLTNO, TRIP, FLEET, ACNO, PURNAME, PURSERN, " +
                            		"INSTNAME, INSTEMPNO, QA, COMM, PROCESS, UPDUSER, UPDDT, " +
                            		"FE_SCORE) ");//, CASECLOSE, CLOSE_TMST, CONFIRM_TMST, CLOSE_USER
                            sqlsb.append(" values (?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,nvl(to_number(?),0),");
                            sqlsb.append(" ?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),");
                            sqlsb.append(" nvl(to_number(?),0)) ");//,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),to_date(?,'yyyy/mm/dd hh24:mi:ss'),?)                                      
    
                            pstmt = con.prepareStatement(sqlsb.toString());
    
    //                        System.out.println(sqlsb.toString());
                            int idx =0;
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getSernno());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getFltd());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getFltno());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getTrip());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getFleet());
                            
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getAcno());                                             
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getPurname());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getPursern());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getInstname());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getInstempno());
                            
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getQA());  
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getComm());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getProcess());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getUpduser());
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getUpddt());
                            
                            pstmt.setString(++idx, saverptAL[i].getsChkR().getFeScore());
    //                        pstmt.setString(++idx, saverptAL[i].getsChkR().getCaseclose());
    //                        pstmt.setString(++idx, saverptAL[i].getsChkR().getCloseTmst());
    //                        pstmt.setString(++idx, saverptAL[i].getsChkR().getConfirmTmst());                       
    //                        pstmt.setString(++idx, saverptAL[i].getsChkR().getCloseUser());
                            
                                        
                            pstmt.executeUpdate();
    
    //                        insert Safety chk.
                            error_step = "儲存Safety chk.";
                            if(!ifNew){
    //                          delete egtstdt then insert
                                error_step = "儲存舊的Safety chk.";
                                sql = " delete FROM egtstdt where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                stmt.executeUpdate(sql);
                            }  
                            
                            if(saverptAL[i].getsChkR().getSafetyArr()!= null)
                            {
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into egtstdt (SERNNO,itemno,flag,remark,itemno_rm) ");
                                sqlsb.append("values (?,?,?,?,?)");
                                
                                pstmt.clearParameters();
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                error_sql_dt ="";
                                
                                for(int j =0; j<saverptAL[i].getsChkR().getSafetyArr().length; j++)
                                {
                                    idx =0;
                                    MPsflySafetyChkObj insertChkobj = saverptAL[i].getsChkR().getSafetyArr()[j];
                                    if(insertChkobj.getItemno() != null )
                                    {
                                        if(null == insertChkobj.getRemark() || "".equals(insertChkobj.getRemark())){
                                            insertChkobj.setRemark("N/A");
                                        }
//                                        if("N/A".equals(insertChkobj.getItemno_rm())){
//                                            insertChkobj.setItemno_rm("000");
//                                        }
                                        pstmt.setString(++idx, saverptAL[i].getsChkR().getSernno());
                                        pstmt.setString(++idx, insertChkobj.getItemno());                                       
                                        pstmt.setString(++idx, insertChkobj.getFlag());                                        
                                        pstmt.setString(++idx, insertChkobj.getRemark());                                        
                                        pstmt.setString(++idx, insertChkobj.getItemno_rm());
                                        error_sql_dt += insertChkobj.getItemno()+","+ insertChkobj.getFlag()+","+insertChkobj.getRemark()+","+insertChkobj.getItemno_rm()+"\r\n";
                                        pstmt.addBatch();
                                    }
                                }
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                               
    //                        insert self ins
                            error_step = "儲存self ins";
                            if(!ifNew){
    //                        delete egtstcc then insert 
                                  error_step = "儲存舊的self ins";
                                  sql = " delete FROM egtstcc where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                  stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getsInsR()!=null && saverptAL[i].getsInsR().getInsArr()!=null)
                            {
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into egtstcc (SERNNO, ITEMNO,TCREW, CORRECT, INCOMPLETE, ACOMM, UPDUSER, UPDDATE, ITEMNO_RM)");
                                sqlsb.append("values (?,?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?)");
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                error_sql_dt ="";
                                for(int j =0; j<saverptAL[i].getsInsR().getInsArr().length; j++)
                                {
                                    idx =0;
                                    MPsflySelfInsObj  insertSelfobj = saverptAL[i].getsInsR().getInsArr()[j];
                                    if(!"".equals(insertSelfobj.getItemno()))
                                    {
                                        pstmt.setString(++idx, saverptAL[i].getsChkR().getSernno());
                                        pstmt.setString(++idx, insertSelfobj.getItemno());     
                                        pstmt.setString(++idx, insertSelfobj.getTcrew());
                                        pstmt.setString(++idx, insertSelfobj.getCorrect());
                                        pstmt.setString(++idx, insertSelfobj.getIncomplete());
                                        pstmt.setString(++idx, insertSelfobj.getAcomm());
                                        pstmt.setString(++idx, insertSelfobj.getUpduser());
                                        pstmt.setString(++idx, insertSelfobj.getUpddate());
                                        pstmt.setString(++idx, insertSelfobj.getItemno_rm());
                                        error_sql_dt += insertSelfobj.getItemno()+","+insertSelfobj.getCorrect()+","+insertSelfobj.getIncomplete()+","+insertSelfobj.getAcomm()
                                                +","+insertSelfobj.getItemno_rm()+"\r\n";
                                        pstmt.addBatch();
                                    }                          
                                }   
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                                
                                
                            }
                            
    //                        insert self ins crew
                            error_step = "儲存self ins crew";
                            if(!ifNew){
    //                        delete egtstcc2 then insert
                                  error_step = "儲存舊的self ins crew";
                                  sql = " delete FROM egtstcc2 where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                  stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getsInsR()!=null && saverptAL[i].getsInsR().getInsArr()!=null)
                            {
                                sqlsb = new StringBuffer();
                                sqlsb.append("insert into egtstcc2 (SERNNO, ITEMNO, empno, crew_comm )");
                                sqlsb.append("values (?,?,?,?)");
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                error_sql_dt ="";
                                for(int j =0; j<saverptAL[i].getsInsR().getInsArr().length; j++)
                                {
                                    
                                    MPsflySelfInsObj  insertSelfobj = saverptAL[i].getsInsR().getInsArr()[j];
                                    if(null!=insertSelfobj.getCrew()&&insertSelfobj.getCrew().length>0){
                                        for(int k=0;k<insertSelfobj.getCrew().length;k++){
                                            MPsflySelfCrewObj insertSelfCobj = insertSelfobj.getCrew()[k];
                                            idx =0;
//                                            error_step+="K="+k+",crew length="+insertSelfobj.getCrew();
                                            pstmt.setString(++idx, saverptAL[i].getsChkR().getSernno());
                                            pstmt.setString(++idx, insertSelfCobj.getItemno());                       
                                            pstmt.setString(++idx, insertSelfCobj.getEmpno());
                                            pstmt.setString(++idx, insertSelfCobj.getCrew_comm());
                                            error_sql_dt += insertSelfCobj.getItemno()+","+insertSelfCobj.getEmpno()+","+insertSelfCobj.getCrew_comm()+"\r\n";
                                            pstmt.addBatch();
                                        }
                                    }
                                }   
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
     
    //                      insert Eval prfe
                            ArrayList KPIobjAL = new ArrayList();
                            error_step = "儲存Eval prfe";
                            if(!ifNew){
    //                          delete egtprfe then insert
                                error_step = "儲存舊的Eval prfe";
                                sql = " delete FROM egtprfe where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getsEvaR() != null && saverptAL[i].getsEvaR().getEva() != null && saverptAL[i].getsEvaR().getEva().getPrfe() != null)
                            {  
                                sqlsb = new StringBuffer();
                                sqlsb.append("INSERT INTO egtprfe(SERNNO, MITEMNO, SITEMNO, GRADE_PERCENTAGE, KPINO, KPI_EVAL, UPDUSER, UPDDATE)");
                                sqlsb.append(" VALUES (?,?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'))");
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                error_sql_dt ="";
                                for(int j =0; j<saverptAL[i].getsEvaR().getEva().getPrfe().length; j++)
                                {       
                                    idx=0;
                                    MPEvalObj prfeobj = saverptAL[i].getsEvaR().getEva().getPrfe()[j];    
                                    pstmt.setString(++idx,saverptAL[i].getsChkR().getSernno());
                                    pstmt.setString(++idx,prfeobj.getMitemno());
                                    pstmt.setString(++idx,prfeobj.getSitemno());
                                    pstmt.setString(++idx,prfeobj.getGrade_percentage());
                                    pstmt.setString(++idx,prfeobj.getKpino());
                                    pstmt.setString(++idx,prfeobj.getKpi_eval());
                                    pstmt.setString(++idx,prfeobj.getUpduser());
                                    pstmt.setString(++idx,prfeobj.getUpddate());                                    
                                    error_sql_dt += prfeobj.getMitemno()+ "," +prfeobj.getSitemno() +","+prfeobj.getGrade_percentage()
                                            +","+prfeobj.getKpino()+","+prfeobj.getKpi_eval()+"\r\n";
                                                                        
                                    PRFuncEvalObj scoreObj = new PRFuncEvalObj();
                                    scoreObj.setMitemno(prfeobj.getMitemno());
                                    scoreObj.setSitemno(prfeobj.getSitemno());
                                    scoreObj.setGrade_percentage(prfeobj.getGrade_percentage());
                                    scoreObj.setKpino(prfeobj.getKpino());
                                    scoreObj.setKpi_eval(prfeobj.getKpi_eval());
                                    KPIobjAL.add(scoreObj);
                                    pstmt.addBatch();
                                }
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                               
    //                        insert Eval prfe2
                            error_step = "儲存Eval prfe2";
                            if(!ifNew){
    //                          delete egtprfe then insert
                                error_step = "儲存舊的Eval prfe2";
                                sql = " delete FROM egtprfe2 where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getsEvaR() != null && saverptAL[i].getsEvaR().getEva() != null && saverptAL[i].getsEvaR().getEva().getPrfe2() != null)
                            {  
                                sqlsb = new StringBuffer();
                                sqlsb.append("INSERT INTO egtprfe2(SERNNO, SECT, SEATNO, CUST_NAME,  CUST_TYPE,CARDNO, SEAT_CLASS,MEMO_TYPE,seqno, MEMO, EVENT, EVENT_TYPE)");
                                sqlsb.append(" VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                error_sql_dt ="";
                                for(int j =0; j<saverptAL[i].getsEvaR().getEva().getPrfe2().length; j++)
                                {       
                                    idx=0;
                                    MPEvalObj2 prfeobj = saverptAL[i].getsEvaR().getEva().getPrfe2()[j];                                
                                    pstmt.setString(++idx,saverptAL[i].getsChkR().getSernno());
                                    pstmt.setString(++idx,prfeobj.getSect());
                                    pstmt.setString(++idx,prfeobj.getSeatno());
                                    pstmt.setString(++idx,prfeobj.getCust_name());
                                    pstmt.setString(++idx,prfeobj.getCust_type());
                                    pstmt.setString(++idx,prfeobj.getCardNo());
                                    pstmt.setString(++idx,prfeobj.getSeat_class());
                                    pstmt.setString(++idx,prfeobj.getMemo_type());
                                    pstmt.setString(++idx,prfeobj.getSeqno());
                                    pstmt.setString(++idx,prfeobj.getMemo());
                                    pstmt.setString(++idx,prfeobj.getEvent());
                                    pstmt.setString(++idx,prfeobj.getEvent_type());
                                    error_sql_dt +=prfeobj.getCust_name()+","+prfeobj.getCust_type()+","+prfeobj.getCardNo()+","
                                    +prfeobj.getSeat_class()+","+prfeobj.getMemo_type()+","+prfeobj.getMemo()+","+prfeobj.getEvent()+","+prfeobj.getEvent_type()+"\r\n";
                                    pstmt.addBatch();
                                    
                                }
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                            
    
        //                    insert Eval 航班事務改善
                              error_step = "儲存航班事務改善";
                              if(!ifNew){
        //                        delete egtprfe then insert
                                  error_step = "儲存舊的航班事務改善";
                                  sql = " delete FROM egtprfs where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                  stmt.executeUpdate(sql);
                              }
                              if(saverptAL[i].getsEvaR() != null && saverptAL[i].getsEvaR().getEva() != null && saverptAL[i].getsEvaR().getEva().getSugfbk() != null)
                              {  
                                  sqlsb = new StringBuffer();
                                  sqlsb.append("INSERT INTO egtprfs(sernno, itemno, feedback)");
                                  sqlsb.append(" VALUES (?,?,?)");
                                  
                                  pstmt=null;
                                  pstmt = con.prepareStatement(sqlsb.toString());
                                  error_sql_dt ="";
                                  for(int j =0; j<saverptAL[i].getsEvaR().getEva().getSugfbk().length; j++)
                                  {       
                                      idx=0;
                                      MemofbkObj memoObj = saverptAL[i].getsEvaR().getEva().getSugfbk()[j];                                
                                      pstmt.setString(++idx,saverptAL[i].getsChkR().getSernno());
                                      pstmt.setString(++idx,memoObj.getQuesNo());
                                      pstmt.setString(++idx,memoObj.getFeedback());
                                      error_sql_dt += memoObj.getQuesNo()+ ","+memoObj.getFeedback()+"\r\n";
                                      pstmt.addBatch();
                                      
                                  }
                                  pstmt.executeBatch();
                                  pstmt.clearBatch(); 
                              }
    
        //                  insert Eval 旅客反映
                            error_step = "儲存旅客反映";
                            if(!ifNew){
        //                      delete egtprfe then insert
                                error_step = "儲存舊的旅客反映";
                                sql = " delete FROM egtprfc where sernno = '"+saverptAL[i].getsChkR().getSernno()+"'";
                                stmt.executeUpdate(sql);
                            }
                            if(saverptAL[i].getsEvaR() != null && saverptAL[i].getsEvaR().getEva() != null && saverptAL[i].getsEvaR().getEva().getCatefbk()!=null)
                            {  
                                sqlsb = new StringBuffer();
                                sqlsb.append("INSERT INTO egtprfc(sernno,seqno, itemno, feedback)");
                                sqlsb.append(" VALUES (?,?,?,?)");
                                
                                pstmt=null;
                                pstmt = con.prepareStatement(sqlsb.toString());
                                error_sql_dt ="";
                                for(int j =0; j<saverptAL[i].getsEvaR().getEva().getCatefbk().length; j++)
                                {       
                                    idx=0;
                                    MemofbkObj memoObj = saverptAL[i].getsEvaR().getEva().getCatefbk()[j];                                
                                    pstmt.setString(++idx,saverptAL[i].getsChkR().getSernno());
                                    pstmt.setString(++idx,memoObj.getSeqno());
                                    pstmt.setString(++idx,memoObj.getQuesNo());
                                    pstmt.setString(++idx,memoObj.getFeedback());
                                    error_sql_dt += memoObj.getSeqno()+","+ memoObj.getQuesNo()+ ","+memoObj.getFeedback()+"\r\n";
                                    pstmt.addBatch();
                                    
                                }
                                pstmt.executeBatch();
                                pstmt.clearBatch(); 
                            }
                            
                            
                            error_step = "儲存上傳檔案";
                            if(!ifNew){
    //                            delete egtmpfile then insert Cabin report file upload
                                sql = "select filename from egtmpfile where fltd = to_date('"+saverptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and fltno like '"+saverptAL[i].getsChkR().getFltno()+"%' and sect like '"+saverptAL[i].getsChkR().getTrip()+"%' and src='IPAD' ";                  
                                rs = stmt.executeQuery(sql);
            
                                while (rs.next()) 
                                {
                                    MPFilePath df = new MPFilePath(rs.getString("filename"));               
                                    df.DoMPDelete();//刪除server檔案
                                }
                                error_step = "儲存舊的上傳檔案";//刪除DB
                                sql = " delete FROM egtmpfile where fltd = to_date('"+saverptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and fltno like '"+saverptAL[i].getsChkR().getFltno()+"%' and sect like '"+saverptAL[i].getsChkR().getTrip()+"%' and src='IPAD' ";
                                stmt.executeUpdate(sql);  
                            }
    //                        get byte[] convert to zip then unzip then upload (ftp) to server
                            if(saverptAL[i].getsEvaR() != null && saverptAL[i].getsEvaR().getEva() != null && saverptAL[i].getsEvaR().getEva().getFile()!=null)//有上傳檔案
                            {                            
                                for(int fi=0; fi<saverptAL[i].getsEvaR().getEva().getFile().length; fi++)
                                {
    //                                error_step = "儲存上傳檔案  fileobj.length = "+saverptAL[i].getFileobjAL().length;
                                    SaveReportMpFileObj fileobj = saverptAL[i].getsEvaR().getEva().getFile()[fi];                                
    //                                  String zipFile = "c:\\zip\\test.zip"; 
                                    String tempfilename = fileobj.getFilename().substring(0,fileobj.getFilename().indexOf("."));
                                    String zipFile = "/apsource/csap/projfz/webap/uploadfile/"+tempfilename+".zip"; 
        //                              String targetDirectory = "c:\\zip";                              
                                    String targetDirectory = "/apsource/csap/projfz/webap/uploadfile/";
                                    String saveDirectory = "/apsource/csap/projfz/webap/uploadfile/";
                                    
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
                                        sqlsb.append(" insert into egtmpfile (sernno,fltd,fltno,sect,filename,filedsc, upduser,upddate,type,subtype,src,app_filename) " );
                                        sqlsb.append(" values (?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?,?,'IPAD',?)");
                                        pstmt=null;
                                        pstmt = con.prepareStatement(sqlsb.toString());
                                        for(int j=0; j<unzipAL.length; j++)
                                        { //已unzip的檔案名稱                                    
                                          
                                          //****************file 上傳至ftp server                                          
                                            MPFilePath ufp = new MPFilePath();
                                            String newFilename =  ufp.getFilename() + unzipAL[j].substring(unzipAL[j].lastIndexOf(".")); //取副檔名
                                            
                                            try
                                            {
                                                //*************************************FTP to 202.165.148.99
//                                              FtpUtility example = new FtpUtility("202.165.148.99","/EG/MP/","egftp01","cseg#01");
//                                              FtpUtility example = new FtpUtility("202.165.148.99","/EGTEST/MP/","egtestftp01","egtest#01");
                                            
                                                FtpUrl url = new FtpUrl();//統一設定ftp Url.
                                                FtpUtility example = new FtpUtility(url.getIp(), url.getDirectory()+"MP/", url.getAccount(), url.getPass());
                                                example.connect();
//                                            example.setDirectory("/EG/MP/");
//                                            example.setDirectory("/EGTEST/MP/");       
                                                example.setDirectory(url.getDirectory()+"MP/");   
                                                example.putBinFile(saveDirectory + unzipAL[j],newFilename);
                                                example.close();
                                            }
                                            catch(Exception e)
                                            {
                                                error_step = "儲存上傳檔案 :"+ j + e.toString();
    //                                            System.out.println(e);
                                            } 
                                            //******delete weblogic server temp file
                                            File f = new File(saveDirectory+unzipAL[j]);
                                            f.delete();                                  
                                            File zipf = new File(saveDirectory+tempfilename+".zip");
                                            zipf.delete();
                                            
                                            idx=0;                   
                                            pstmt.setString(++idx,saverptAL[i].getsChkR().getSernno());
                                            pstmt.setString(++idx,saverptAL[i].getsChkR().getFltd());
                                            pstmt.setString(++idx,saverptAL[i].getsChkR().getFltno());
                                            pstmt.setString(++idx,saverptAL[i].getsChkR().getTrip());
                                            pstmt.setString(++idx,newFilename);
                                            pstmt.setString(++idx,"N/A");
                                            pstmt.setString(++idx,fileobj.getUpduser());
                                            pstmt.setString(++idx,fileobj.getUpddate());
                                            pstmt.setString(++idx,fileobj.getType());
                                            pstmt.setString(++idx,fileobj.getSubtype());
                                            pstmt.setString(++idx,unzipAL[j]);
                                            error_sql_dt = saverptAL[i].getsChkR().getSernno()+","+
                                                    saverptAL[i].getsChkR().getFltd()+","+
                                                    saverptAL[i].getsChkR().getFltno()+","+
                                                    saverptAL[i].getsChkR().getTrip()+","+
                                                    newFilename+fileobj.getUpduser()+fileobj.getUpddate()+","+
                                                    fileobj.getType()+","+fileobj.getSubtype()+","+
                                                    unzipAL[j];
                                            pstmt.executeUpdate();
                                            con.commit();
                                        }    
                                    }
                                }
                            }//if(fileAL.size()>0)//有上傳檔案有
                            //更新分數
                            error_step = "更新分數與最後更新時間";
                            PRFuncEval prfe = new PRFuncEval();
                            String avgscore = prfe.getScore(KPIobjAL);
                            //更新最後更新時間                            
                            sql = " update EGTSTTI set fe_score = to_number("+avgscore+")/100 ,upddt = to_date('"+saverptAL[i].getsChkR().getUpddt()+"','yyyy/mm/dd hh24:mi:ss') " +//, src = 'IPAD', src_tmst = sysdate
                                    " where fltd = to_date('"+saverptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and fltno like '"+saverptAL[i].getsChkR().getFltno()+"%' and trip like '"+saverptAL[i].getsChkR().getTrip()+"%'" +
                                    " and instempno = '"+saverptAL[i].getsChkR().getInstempno()+"'";
                            stmt.executeUpdate(sql); 
                            con.commit(); 
                            saveobj.setResultMsg("1");
                            saveobj.setErrorMsg(saverptAL[i].getsChkR().getSernno());
                        }//if("Y".equals(ifupdate))      
                        else
                        {
                            error_str = "WEB資料 已更新，無需同步";
                            saveobj.setResultMsg("0");
                            saveobj.setErrorMsg(error_str);
                            return "WEB資料 已更新，無需同步";                        
                        }
                    }// if(null != saverptAL[i].getsChkR()...)
                    else
                    {
                        error_str = "資料輸入不完整"; //Cabin Safety Chk
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
//                System.out.println(e.toString());
            saveobj.setResultMsg("0");
            try
            {
                fw = new FileWriter(path+"serviceLog.txt",true);
                fw.write(new java.util.Date()+"\r\n");       
                fw.write(e.toString() + " ** " +error_step +" Failed \r\n");   
                if("0".equals(saveobj.getResultMsg())){
                     fw.write(error_sql_dt+"\r\n");  
                }
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
            saveobj.setResultMsg("0");
            saveobj.setErrorMsg(e.toString() + " ** " +error_step +" Failed");
            try{con.rollback();}catch(SQLException se){ return se.toString();}          
            return e.toString() + " ** " +error_step +" Failed";            
        }
        finally 
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
            try{if(con != null) con.close();}catch(SQLException e){}
        } 
    
        return "Y";
    }
//    6.send all
    public String sendMpSfly(MpSflyRObj[] sendrptAL){
        String str = saveMpSfly(sendrptAL);
        sendobj = new ReturnMsgObj();
        if("Y".equals(str)){
            Connection con = null;
            PreparedStatement pstmt = null;
            Statement stmt = null;
            ResultSet rs = null;
            Driver dbDriver = null;
            String sql ="";
            String error_sql ="";
            String error_step ="";
            String error_str = "";
            String path = "/apsource/csap/projfz/txtin/appLogs/";//"E://";
            FileWriter fw = null;
                   
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
                        error_step = "SFLY送出報告";
                        if(sendrptAL[i].getsChkR().getSernno()!=null && !"".equals(sendrptAL[i].getsChkR().getSernno())){
                            //delete egtzcflt then insert 
                            sql = " select sernno ,send from egtstti where fltd = to_date('"+sendrptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and fltno like '"+sendrptAL[i].getsChkR().getFltno()+"%' and trip like '"+sendrptAL[i].getsChkR().getTrip()+"%' and Instempno = '"+sendrptAL[i].getsChkR().getInstempno()+"'";
                            rs = stmt.executeQuery(sql);
                            if (rs.next()){
                                oldSeqno = rs.getString("sernno"); 
                                if("Y".equals(rs.getString("send"))){
                                    error_str = "報告已送出,不可編輯.";
                                    sendobj.setResultMsg("0");
                                    sendobj.setErrorMsg(error_str);
                                    return error_str;
                                }
                                if(sendrptAL[i].getsChkR().getSernno().equals(oldSeqno)){
//                                  更新送出時間
                                    sql = " update egtstti set send = 'Y' ,send_tmst = to_date('"+sendrptAL[i].getsChkR().getUpddt()+"','yyyy/mm/dd hh24:mi:ss') , upddt = to_date('"+sendrptAL[i].getsChkR().getUpddt()+"','yyyy/mm/dd hh24:mi:ss') " +//, src = 'IPAD', src_tmst = sysdate
                                            "where fltd = to_date('"+sendrptAL[i].getsChkR().getFltd()+"','yyyy/mm/dd') and " +
                                            "fltno = '"+sendrptAL[i].getsChkR().getFltno()+"' and " +
                                            "Trip like '"+sendrptAL[i].getsChkR().getTrip()+"%' and " +
                                            "instempno like '"+sendrptAL[i].getsChkR().getInstempno()+"%' and " +
                                            "sernno = '"+sendrptAL[i].getsChkR().getSernno()+"' ";
                                    stmt.executeUpdate(sql);
                                }else{
                                    error_str = "資料與序號不符合";
                                    sendobj.setResultMsg("0");
                                    sendobj.setErrorMsg(error_str);
                                    return error_str;
                                }
                            }  
                        }                          
                        con.commit(); 
                        sendobj.setResultMsg("1");
                        sendobj.setErrorMsg(sendrptAL[i].getsChkR().getSernno());
                    }//for(int i=0; i<sendrptAL.length; i++)    
                }
            } 
            catch(Exception e) 
            {
//                System.out.println(e.toString());
                try
                {
                    fw = new FileWriter(path+"serviceLog.txt",true);
                    fw.write(new java.util.Date()+"\r\n");       
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
                try{if(rs != null) rs.close();}catch(SQLException e){}
                try{if(stmt != null) stmt.close();}catch(SQLException e){}
                try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
                try{if(con != null) con.close();}catch(SQLException e){}
            } 
            return "Y";
        }else{     
            sendobj.setResultMsg("0");
            sendobj.setErrorMsg(str);
            return str;
        }
        
    }
    
//  取得序號
    public String getMpSflySeqno(String fltd,String sect,String fltno,String empno,String fleet,String acNo){
      if(sect.length() < 7){
          return "請輸入航段";
      }     
      if(fltno.length() < 4){
          return "請輸入至少一段班號";
      }
//      if(fleet.length() < 3){
//          return "請輸入至少一機型代碼";
//      }
//      if(acNo.length() < 5){
//          return "請輸入至少一飛機編號";
//      }
      Connection conn   = null;
      String sql = null;
      ResultSet rs = null;
      Statement stmt = null;
      ConnDB cn = new ConnDB();
      Driver dbDriver = null;       
      try
      {
          cn.setORP3EGUserCP();
          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
          conn = dbDriver.connect(cn.getConnURL(), null);
          
          //connect ORT1 EG     
//          cn.setORP3EGUser();
////          cn.setORT1EG();
//          Class.forName(cn.getDriver());
//          conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
          
          stmt = conn.createStatement();   
          
          
//          sql = " select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno, purname, instname, to_char(fltd,'yyyymmdd') as fltd," +
//              " to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d, acno, fleet " +
//              " from egtstti where sernno = '"+ sernno+ "'";
          
          sql = " select sernno from egtstti where fltd = to_date('"+fltd+"','yyyy/mm/dd') " +
                  " and fltno like '"+fltno.substring(0,4)+"%' and trip like '"+sect.substring(0,7)+"%' " +
                 // " and fleet like '"+fleet+"%' and acno like '"+acNo+"%' " +
                  " and instempno = '"+empno+"'";
          rs = stmt.executeQuery(sql); 
          if(rs.next())
          {
              setSeqno(rs.getString("sernno"));
          }else{
              return "N";
          }
      }
      catch (Exception e)
      {
//           System.out.print(e.toString());
          return e.toString();
      }
      finally
      {
          try{if(rs != null) rs.close();}catch(SQLException e){}
          try{if(stmt != null) stmt.close();}catch(SQLException e){}                      
          try{if(conn != null) conn.close();}catch(SQLException e){}
      }
      return "Y";
  }
//  query safety
    public String getCabinSafety (String seqno){
        sChkR = new MPsflySafetyChkRObj();
        Connection conn   = null;
        String sql = null;
        ResultSet rs = null;
        Statement stmt = null;
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;       
        try
        {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = conn.createStatement();   
            
            sql = "select sernno, to_char(FLTD,'yyyy/mm/dd') fltd, FLTNO, TRIP, FLEET, ACNO, PURNAME, PURSERN, " +
                    " INSTNAME, INSTEMPNO, UPDUSER, UPDDT, " +
                    " FE_SCORE, CASECLOSE, CLOSE_TMST, CONFIRM_TMST, CLOSE_USER ,'' send ," +
                    " NVL(qa, '　') qa, NVL(comm, '　') comm, NVL(process, '　') process" +
                    " from egtstti where sernno = '"+ seqno+ "' ";
              rs = stmt.executeQuery(sql); 
              if(rs.next()){
                  sChkR.setSernno(rs.getString("sernno"));
                  sChkR.setFltd(rs.getString("fltd"));
                  sChkR.setFltno(rs.getString("fltno"));
                  sChkR.setTrip(rs.getString("trip"));
                  sChkR.setFleet(rs.getString("fleet"));
                  sChkR.setAcno(rs.getString("acno"));
                  sChkR.setPurname(rs.getString("purname"));
                  sChkR.setPursern(rs.getString("pursern"));
                  sChkR.setInstname(rs.getString("instname"));
                  sChkR.setInstempno(rs.getString("instempno"));
                  sChkR.setCaseclose(rs.getString("caseclose"));
                  sChkR.setCloseTmst(rs.getString("CLOSE_TMST"));
                  sChkR.setConfirmTmst(rs.getString("CONFIRM_TMST"));
                  sChkR.setCloseUser(rs.getString("CLOSE_USER"));
                  sChkR.setSend(rs.getString("send"));
                  sChkR.setComm(rs.getString("comm"));
                  sChkR.setQA(rs.getString("qa"));
                  sChkR.setProcess(rs.getString("process"));
              }          
            //Class Type
            ClassType fun = new ClassType();
            if (null != sChkR.getAcno() && !"".equals(sChkR.getAcno())){                
                if ("Y".equals(fun.getClassTypebyACno(sChkR.getAcno().substring(0,5)))){
                    sChkR.setClass_cat(fun.getClassTypeAr());
                }
            }else{
                if(null!= sChkR.getFleet() && !"".equals( sChkR.getFleet())){
                    if("Y".equals(fun.getClassTypebyFleet(sChkR.getFleet()))){
                        sChkR.setClass_cat(fun.getClassTypeAr());
                    } 
                }
            }
            sql = "SELECT sernno,itemno,flag,remark,itemno_rm FROM egtstdt WHERE sernno = '"+seqno+"'";
            rs = stmt.executeQuery(sql); 
            
            objAL = new ArrayList();           
            while(rs.next())
            {
                MPsflySafetyChkObj obj = new MPsflySafetyChkObj();
                obj.setSernno(rs.getString("sernno"));
                obj.setItemno(rs.getString("itemno"));
                obj.setFlag(rs.getString("flag"));
                obj.setRemark(rs.getString("remark"));
                obj.setItemno_rm(rs.getString("itemno_rm"));
                objAL.add(obj);
            }
            if(objAL.size()>0){
                MPsflySafetyChkObj[] safetyArr = new MPsflySafetyChkObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    safetyArr[i] = (MPsflySafetyChkObj) objAL.get(i);
                    
                }
                sChkR.setSafetyArr(safetyArr);
            }
        }
        catch (Exception e)
        {
//             System.out.print("Safety:"+e.toString());
            
             return e.toString();
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}                      
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }        
        return "Y";
        
        
    }
//  query selfIns
    public String getSelfIns(String seqno){
        sInsR = new MPsflySelfInsRObj();
        Connection conn   = null;
        String sql = null;
        ResultSet rs = null;
        Statement stmt = null;
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;       
        try
        {
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
            //connect ORT1 EG     
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
            
            stmt = conn.createStatement();   
            
            sql = " select cc.sernno, ci.itemno as itemno, ci.subject as subject, "+ 
                    " NVL(cc.tcrew, 0) as tcrew, NVL(cc.correct, 0) as correct, NVL(cc.incomplete, 0) as incomplete,"+ 
                    " NVL(cc.crew_comm, '　') as crew_comm, NVL(cc.acomm, '　') as acomm , cc.itemno_rm "+
                    " from egtstcc cc, egtstci ci "+
                    " where cc.sernno='"+seqno+"' and cc.itemno=ci.itemno"+ 
                    " order by ci.itemno ";
            rs = stmt.executeQuery(sql); 
            
            objAL = new ArrayList();           
            while(rs.next())
            {
                MPsflySelfInsObj obj = new MPsflySelfInsObj();                 
                obj.setAcomm(rs.getString("acomm"));
                obj.setTcrew(rs.getString("tcrew"));
                obj.setCorrect(rs.getString("correct"));
                obj.setIncomplete(rs.getString("incomplete"));
                obj.setItemno(rs.getString("itemno"));
                obj.setItemno_rm(rs.getString("itemno_rm"));
                obj.setSernno(rs.getString("sernno"));
//                obj.setCrew(crew);
                objAL.add(obj);
            }
            
            if(objAL.size()>0){
                MPsflySelfInsObj[] insArr = new MPsflySelfInsObj[objAL.size()];
                for(int i=0;i<objAL.size();i++){
                    MPsflySelfInsObj obj = (MPsflySelfInsObj) objAL.get(i);                                        
                    sql = " select  sernno ,empno ,itemno ,crew_comm"+
                            " from egtstcc2 "+
                            " where sernno='"+seqno+"' and itemno= '"+obj.getItemno()+"'"+ 
                            " order by itemno ";
                    rs = stmt.executeQuery(sql); 
                    
                    ArrayList objAL2 = new ArrayList();           
                    while(rs.next())
                    {
                        MPsflySelfCrewObj crewObj = new MPsflySelfCrewObj();                 
                        crewObj.setSeqno(rs.getString("sernno"));
                        crewObj.setEmpno(rs.getString("empno"));
                        crewObj.setItemno(rs.getString("itemno"));
                        crewObj.setCrew_comm(rs.getString("crew_comm"));
                        objAL2.add(crewObj);
                    }
                    if(objAL2.size()>0){
                        MPsflySelfCrewObj[] crewArr = new MPsflySelfCrewObj[objAL2.size()];
                        for(int j=0;j<objAL2.size();j++){
                            crewArr[j] = (MPsflySelfCrewObj) objAL2.get(j);
                        }
                        obj.setCrew(crewArr);
                    }
                    insArr[i] = obj;
                }
                sInsR.setInsArr(insArr);
            }
        }
        catch (Exception e)
        {
//             System.out.print("self:"+e.toString());
             return e.toString();
        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}                      
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }        
        return "Y";
    }
//  query Eval  
    public String getEval(String seqno){
        sEvaR = new MPsflyEvaRObj();
        
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        String sql = "";
        
        
        try 
        {
            ConnDB cn = new ConnDB();
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
//            cn.setORP3EGUser();
//            cn.setORT1EG();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
            stmt = conn.createStatement();

            sql = " SELECT pr.*, pi.kpi_itemdesc, si.eval_subitemdesc, mi.eval_itemdesc, ti.fe_score " +
                  " FROM egtprfe pr, egtfekpi pi, egtfesi si, egtfemi mi, egtstti ti " +
                  " WHERE pr.sernno = '"+seqno+"' AND pr.sernno = ti.sernno " +
                  " AND pr.kpino = pi.kpi_itemno AND pr.sitemno = si.eval_subitemno " +
                  " AND pr.mitemno = mi.eval_itemno ORDER BY mi.eval_itemno, si.eval_subitemno, kpino ";
//                        System.out.println(sql);
            rs = stmt.executeQuery(sql);        
            ArrayList objAL1 = new ArrayList();  
            ArrayList objAL2 = new ArrayList();
            ArrayList memoAL = new ArrayList();//建議事項
            ArrayList memoAL2 = new ArrayList();//旅客反映
            ArrayList objAL3 = new ArrayList();
            while (rs.next()) 
            {
                MPEvalObj obj = new MPEvalObj();   
                obj.setSernno(rs.getString("sernno"));
                obj.setMitemno(rs.getString("mitemno"));
                obj.setSitemno(rs.getString("sitemno"));
                obj.setGrade_percentage(rs.getString("grade_percentage"));
                obj.setKpino(rs.getString("kpino"));
                obj.setKpi_eval(rs.getString("kpi_eval"));

//                obj.setMitemdesc(rs.getString("eval_itemdesc"));
//                obj.setSitemdesc(rs.getString("eval_subitemdesc"));
//                obj.setKpidesc(rs.getString("kpi_itemdesc"));
//                obj.setKpi_score(rs.getString("fe_score")); 
                objAL1.add(obj);
            }
            
            
            
            if(objAL1.size()>0)
            {
                MPsflyEvaObj obj = new MPsflyEvaObj();
                
                sql = " SELECT * FROM egtprfe2 WHERE sernno = '"+seqno+"' ";
                rs = stmt.executeQuery(sql);   
                while (rs.next()) 
                {
                    MPEvalObj2 obj2 = new MPEvalObj2();            
                    obj2.setSernno(rs.getString("sernno"));
                    obj2.setSeqno(rs.getString("seqno"));
                    obj2.setMemo_type(rs.getString("memo_type"));
                    obj2.setSect(rs.getString("sect"));
                    obj2.setSeatno(rs.getString("seatno"));
                    obj2.setSeat_class(rs.getString("seat_class"));
                    obj2.setCust_name(rs.getString("cust_name"));
                    obj2.setCust_type(rs.getString("cust_type"));
                    obj2.setCardNo(rs.getString("cardNo"));
                    obj2.setEvent_type(rs.getString("event_type"));
                    obj2.setEvent(rs.getString("event"));
                    obj2.setMemo(rs.getString("memo"));
                    objAL2.add(obj2);
                }   
          
                if(objAL2.size() > 0){
                    //建議事項
                    sql = " SELECT sernno,itemNo,feedback FROM egtprfs WHERE sernno = '"+seqno+"' ";
                    rs = stmt.executeQuery(sql);  
                    while (rs.next()) 
                    {
                        MemofbkObj objm = new MemofbkObj();            
                        objm.setSernno(rs.getString("sernno"));
                        objm.setQuesNo(rs.getString("itemNo"));//題目序號
                        objm.setFeedback(rs.getString("feedback"));                        
                        memoAL.add(objm);
                    }
                    //旅客反映
                    sql = " SELECT sernno,seqno,itemNo,feedback FROM egtprfc WHERE sernno = '"+seqno+"' ";
                    rs = stmt.executeQuery(sql);  
                    while (rs.next()) 
                    {
                        MemofbkObj objm = new MemofbkObj();  
                        objm.setSernno(rs.getString("sernno"));
                        objm.setSeqno(rs.getString("seqno"));
                        objm.setQuesNo(rs.getString("itemNo"));//題目序號
                        objm.setFeedback(rs.getString("feedback"));                        
                        memoAL2.add(objm);
                    }
                    //檔案
                    FtpUrl url = new FtpUrl();//統一設定ftp Url.
                    sql = " select sernno,fltd,fltno,sect,filename,filedsc,upduser,upddate,src,app_filename,type,subtype from egtmpfile WHERE sernno = '"+seqno+"' ";
                    rs = stmt.executeQuery(sql);  
                    while (rs.next()) 
                    {
                        SaveReportMpFileObj objf = new SaveReportMpFileObj();  
                        objf.setSernno(rs.getString("sernno"));
                        objf.setFltd(rs.getString("fltd"));
                        objf.setFltno(rs.getString("fltno"));
                        objf.setSect(rs.getString("sect"));
                        objf.setFilename(rs.getString("filename"));
                        objf.setApp_filename(rs.getString("app_filename"));
                        objf.setFiledsc(rs.getString("filedsc"));
                        objf.setSubtype(rs.getString("subtype"));
                        objf.setType(rs.getString("type"));
                        objf.setFileLink(url.getUrl()+"MP/"+rs.getString("filename"));//filename
                        objAL3.add(objf);
                    }
                }
                

                MPEvalObj[] prfeArr = new MPEvalObj[objAL1.size()];
                for(int i=0;i<objAL1.size();i++){
                    MPEvalObj obj1 = (MPEvalObj)objAL1.get(i);
                    prfeArr[i] = obj1;                    
                    if(objAL2.size()>0){

                        MPEvalObj2[] prfeArr2 = new MPEvalObj2[objAL2.size()];
                        for(int j=0;j<objAL2.size();j++){
                            MPEvalObj2 obj2 = (MPEvalObj2) objAL2.get(j);                            
                            prfeArr2[j] = obj2;
                        } 
                        obj.setPrfe2(prfeArr2);
                        
                        //建議事項
                        if(memoAL.size()>0){
                            MemofbkObj[] sugfbk = new MemofbkObj[memoAL.size()];
                            for(int j=0;j<memoAL.size();j++){
                                sugfbk[j] = (MemofbkObj) memoAL.get(j);
                            } 
                            obj.setSugfbk(sugfbk);
                        }
                        //旅客反映
                        if(memoAL2.size()>0){
                            MemofbkObj[] catefbk = new MemofbkObj[memoAL2.size()];
                            for(int j=0;j<memoAL2.size();j++){
                                catefbk[j] = (MemofbkObj) memoAL2.get(j);
                            } 
                            obj.setCatefbk(catefbk);
                        }
                        //file
                        if(objAL3.size()>0){
                            SaveReportMpFileObj[] file = new SaveReportMpFileObj[objAL3.size()];
                            for(int j=0;j<objAL3.size();j++){
                                file[j] = (SaveReportMpFileObj) objAL3.get(j);
                            } 
                            obj.setFile(file);
                        }

                    }
                    

                    
                }
                obj.setPrfe(prfeArr);
                sEvaR.setEva(obj);
                /*塞入sfly*/
                sfly.setsEvaR(sEvaR); 
            }         
            
        } 
        catch (SQLException e) 
        {
//            System.out.print(e.toString());
            return e.toString();
        } 
        catch (Exception e) 
        {
//            System.out.print(e.toString());
            return e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
        return "Y";
        
    }
    

    public ReturnMsgObj getSaveobj()
    {
        return saveobj;
    }

    public void setSaveobj(ReturnMsgObj saveobj)
    {
        this.saveobj = saveobj;
    }

    public ReturnMsgObj getSendobj()
    {
        return sendobj;
    }

    public void setSendobj(ReturnMsgObj sendobj)
    {
        this.sendobj = sendobj;
    }

    public String getSeqno()
    {
        return seqno;
    }

    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }

    public ArrayList getObjAL()
    {
        return objAL;
    }

    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }

    public MPsflySafetyChkRObj getsChkR()
    {
        return sChkR;
    }

    public void setsChkR(MPsflySafetyChkRObj sChkR)
    {
        this.sChkR = sChkR;
    }

    public MPsflySelfInsRObj getsInsR()
    {
        return sInsR;
    }

    public void setsInsR(MPsflySelfInsRObj sInsR)
    {
        this.sInsR = sInsR;
    }

    public MPsflyEvaRObj getsEvaR()
    {
        return sEvaR;
    }

    public void setsEvaR(MPsflyEvaRObj sEvaR)
    {
        this.sEvaR = sEvaR;
    }
    
}
