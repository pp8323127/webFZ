package ws.prac.SFLY;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ws.prac.*;

import ci.db.ConnectionHelper;

import eg.flightcheckitem.CheckDetailItemObj;
import eg.flightcheckitem.CheckItemKeyValue;
import eg.flightcheckitem.CheckItemWithFlight;
import eg.flightcheckitem.CheckMainItemObj;
import eg.flightcheckitem.CheckRecordDetailObj;
import eg.flightcheckitem.CheckRecordObj;
import eg.flightcheckitem.RetrieveCheckItem;
import eg.flightcheckitem.RetrieveCheckRd;
import eg.mvc.MVCObj;
import fz.pracP.*;
import fz.projectinvestigate.PRPJIssue;
import fz.projectinvestigate.PRProjIssueObj;
import fz.projectinvestigate.PRProjTemplate;
import fz.projectinvestigate.PRProjTemplateObj;
import fz.psfly.PRSFlyFactorObj;
import fz.psfly.PRSFlyIssue;
import fz.psfly.PSFlyFactor;
import fz.psfly.PSFlyFactorObj;
import fz.psfly.PSFlyIssueObj;
import fzac.*;

public class SFLYRptFun {

    /**
     * @param args
     */
    
    public PRSFlyRObj prSFlyObj = null;//自我督察
    public PSFlyFactorRObj pSFlyObj = null;//自我督察&不合格題目
    public PRProjRObj prPjObj = null;//專案
    public PRfltChkItemRObj prChkObj = null;//題目與已編輯內容
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        SFLYRptFun sfly = new SFLYRptFun();
//        System.out.println(sfly.ReportListHasPRSFly("630304", "2013/03/16", "0156", "TPEKIX", "N", "Y"));
        sfly.PRProjEd("631193", "2014/11/05", "0947", "KHHHKG", "333", "18353");
//        sfly.PRSFlyItem("A");
//      sfly.PRProjEd("630304", "2013/05/14", "0066", "AMSBKK", "343", "18802");
//        sfly.PRFltchkItem("630304", "2013/06/03", "0018", "NRTHNL");
//        sfly.PRFltchkItem("630304", "2013/09/22", "0110", "TPEFUK");
        
//        ArrayList<String> a= new ArrayList<String>();
//        a.add("test");
//        for(int i=0;i<a.size();i++){
//            System.out.println(a.get(i));
//        }
        

        System.out.println("done");
        
    }
    
    //編輯自我督察
    public void PRSFlyEd(String empno, String fdate, String fltno,String sect,String fleet,String acno){
        //是否有自我督察
        boolean needfill = false;
        prSFlyObj = new PRSFlyRObj();
        PRSFlyIssue psf = new PRSFlyIssue();
             
        try
        {
            psf.getPsflyTopic_no(fdate, fltno, sect.substring(0,3), sect.substring(3),empno,"","") ;
            //psf.getPsflyTopic_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
            //out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
            if(psf.getTopic_noAL().size()>0){
                needfill = true;
            }else{
                //無須填寫
                prSFlyObj.setErrorMsg("無須填寫/沒有資料");
                prSFlyObj.setResultMsg("1");
            }
        }
        catch(Exception e){
            prSFlyObj.setErrorMsg(e.toString());
            prSFlyObj.setResultMsg("0");
        }
        ArrayList<String> dutyAL = new ArrayList<String>();
        String allduty = "";
        
        if("738".equals(fleet)){
            dutyAL.add("PUR");
            dutyAL.add("1R");
            //dutyAL.add("2L");
            //dutyAL.add("2R");
            dutyAL.add("3L");
            dutyAL.add("3R");
            dutyAL.add("3RA");
            dutyAL.add("Z2");
            dutyAL.add("FLIGHT CREW");
        }else if("333".equals(fleet)){
            dutyAL.add("PUR");
            for(int d=1; d<=4; d++){
                dutyAL.add(d+"L");
                dutyAL.add(d+"R");
            }
            dutyAL.add("Z1");
            dutyAL.add("Z2");
            dutyAL.add("Z3");
            dutyAL.add("FLIGHT CREW");
        }else if("343".equals(fleet)){
            dutyAL.add("PUR");
            for(int d=1; d<=4; d++){
                dutyAL.add(d+"L");
                dutyAL.add(d+"R");
            }
            dutyAL.add("Z1");
            dutyAL.add("Z3");
            dutyAL.add("FLIGHT CREW");
        }else if("74C".equals(fleet)){
            dutyAL.add("PUR");
            for(int d=1; d<=5; d++){
                dutyAL.add(d+"L");
                dutyAL.add(d+"R");
            }
            dutyAL.add("3LA");
            dutyAL.add("3RA");
            dutyAL.add("Z1");
            dutyAL.add("Z3");
            dutyAL.add("UDL");
            dutyAL.add("UDR");
            dutyAL.add("UDZ");
            dutyAL.add("UDA"); 
            dutyAL.add("DFA"); 
            dutyAL.add("FLIGHT CREW");
        }else{
            dutyAL.add("PUR");
            for(int d=1; d<=5; d++){
                dutyAL.add(d+"L");
                dutyAL.add(d+"R");
            }
            dutyAL.add("3LA");
            dutyAL.add("3RA");
            dutyAL.add("Z1");
            dutyAL.add("Z2");
            dutyAL.add("Z3");
            dutyAL.add("UDL");
            dutyAL.add("UDR");
            dutyAL.add("UDZ");
            dutyAL.add("DFA"); 
            dutyAL.add("FLIGHT CREW");
        }
        allduty = dutyAL.get(0);
        for(int j=1 ; j<dutyAL.size(); j++){
            allduty += "/"+dutyAL.get(j);
        }
//        System.out.println(allduty);
//        dutyAL = null;
        
        if(needfill == true)
        {
            //找出topic_no
            String topic_no = "";
            for(int k =0; k<psf.getTopic_noAL().size(); k++)
            {
                topic_no = topic_no+","+psf.getTopic_noAL().get(k);
            }
            
            //set obj
            try{
                ArrayList bankItemobjAL = new ArrayList();
                ArrayList prSFly = new ArrayList();
                //***********************************************
//              System.out.println(topic_no+"  **  "+fdate+"  **  "+fltno+"  **  "+ sect.substring(0,3)+"  **  "+sect.substring(3)+"  **  "+empno+"  **  "+fleet+"  **  "+acno);
                psf.getBankItemno(topic_no.substring(1));//blank 
                bankItemobjAL  = psf.getBankObjAL();
                          
                //題目
                if(bankItemobjAL != null){
                    for(int i=0 ;i<bankItemobjAL.size();i++){
                        PSFlyIssueObj obj = (PSFlyIssueObj) bankItemobjAL.get(i);
                        //A--check duty無值,則塞入預設duty 
                        if("A".equals(obj.getPsfm_itemno()) && ("".equals(obj.getCheck_duty()) || obj.getCheck_duty()==null)){                                           
                            obj.setCheck_duty(allduty);
    //                        System.out.println(obj.getItemdesc());
    //                        System.out.println(obj.getCheck_duty());
                            bankItemobjAL.set(i, obj);
                        }//A check_duty
                    }
                    
                    PSFlyIssueObj[] arrayIssue = new PSFlyIssueObj[bankItemobjAL.size()];
                    for (int i = 0; i < bankItemobjAL.size(); i++) {
                        arrayIssue[i] = (PSFlyIssueObj) bankItemobjAL.get(i);
//                        System.out.println(arrayIssue[i].getCheck_duty());
                    }
                    prSFlyObj.setPrSFlyIss(arrayIssue);
                    prSFlyObj.setResultMsg("1"); 
                }
                
                //**********************************************
                psf.getBankItemno(topic_no.substring(1),fdate, fltno, sect.substring(0,3),sect.substring(3),empno,fleet,acno);
                prSFly =psf.getBankObjAL();                 
                
                if(prSFly != null){
                    for(int i=0 ;i<prSFly.size();i++){
                        PRSFlyFactorObj obj = (PRSFlyFactorObj) prSFly.get(i);
                      //A--check duty無值,則塞入預設duty 
                        if("A".equals(obj.getPsfm_itemno()) && ("".equals(obj.getCheck_duty()) || obj.getCheck_duty()==null)){                                           
                            obj.setCheck_duty(allduty);
                            prSFly.set(i, obj);
                        }//A check_duty
                    }                    
                    
                    PRSFlyFactorObj[] arrayFac = new PRSFlyFactorObj[prSFly.size()];
                    for (int i = 0; i < prSFly.size(); i++) {
                        arrayFac[i] = (PRSFlyFactorObj) prSFly.get(i);
                    }
                    prSFlyObj.setPrSFlyFac(arrayFac);
                    prSFlyObj.setResultMsg("1");
                }
                //**********************************************                
//                prSFlyObj.setDutyAL(dutyAL);
                               
            }catch (Exception e) {
                prSFlyObj.setErrorMsg(e.toString());
                prSFlyObj.setResultMsg("0");
            }
        }
        
    }
    
    //取題目.A/E
    public void PRSFlyItem(String psfmItemno){
        pSFlyObj = new PSFlyFactorRObj();
        ArrayList factorAL = null;
        PSFlyFactor psff = new PSFlyFactor();
        try{
            psff.getFactorList("Y", psfmItemno);
            factorAL = psff.getFactorAL();
            if(factorAL.size()>0){
                PSFlyFactorObj[] arrayFacAll = new PSFlyFactorObj[factorAL.size()];
                for (int i = 0; i < factorAL.size(); i++) {
                    arrayFacAll[i] = (PSFlyFactorObj) factorAL.get(i);
//                  System.out.println(arrayFacAll[i].getFactor_desc().toString());
//                  System.out.println(arrayFacAll[i].getFactor_sub_desc().toString());
//                  arrayFacAll[0].setFactor_desc("XXX");
                }
                pSFlyObj.setFacQA(arrayFacAll);
                pSFlyObj.setResultMsg("1");
            }else{
                 pSFlyObj.setErrorMsg("No Data!");
                 pSFlyObj.setResultMsg("1");
            }
            
        }catch (Exception e) {
            pSFlyObj.setErrorMsg(e.toString());
            pSFlyObj.setResultMsg("0");
        }
    }
    
    
    //編輯專案調查/追蹤考核
    public void PRProjEd(String empno, String fdate, String fltno,String sect,String fleet,String acno){
        boolean pjneedfill = false;
        prPjObj = new PRProjRObj();
        PRPJIssue pj = new PRPJIssue();
        try
        {
            pj.getPRProj_no(fdate, fltno, sect.substring(0,3), sect.substring(3),empno,"","") ;
            //pj.getPRProj_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
            //out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
            if(pj.getProj_noAL().size()>0)
            {
                pjneedfill = true;
            }else{
                prPjObj.setErrorMsg("無須填寫/沒有資料");
                prPjObj.setResultMsg("1");
            }
            
        }
        catch(Exception e){
            prPjObj.setErrorMsg(e.toString());
            prPjObj.setResultMsg("0");
        } 
        
        try{
            if(pjneedfill == true){
                //找出proj_no
                String proj_no = "";
                for(int k =0; k<pj.getProj_noAL().size(); k++)
                {
                    proj_no = proj_no+","+pj.getProj_noAL().get(k);
                }
                ArrayList bankItemobjAL = new ArrayList();
                ArrayList tempobjAL = new ArrayList();
                //System.out.println(proj_no.substring(1)+"  **  "+fdate+"  **  "+fltno+"  **  "+ sect.substring(0,3)+"  **  "+sect.substring(3)+"  **  "+empno+"  **  "+fleet+"  **  "+acno);
                pj.getBankItemno(proj_no.substring(1),fdate, fltno, sect.substring(0,3),sect.substring(3),empno,fleet,acno);
                bankItemobjAL = pj.getBankObjAL();      
                
                PRProjIssueObj[] arrayIss = new PRProjIssueObj[bankItemobjAL.size()];
                for (int i = 0; i < bankItemobjAL.size(); i++) {
                    arrayIss[i] = (PRProjIssueObj) bankItemobjAL.get(i);
                }
                prPjObj.setPrPjIss(arrayIss);                
                prPjObj.setResultMsg("1");
                
                //***************************************************
                PRProjTemplate pjt = new PRProjTemplate();
                pjt.getTemplate();
                tempobjAL = pjt.getObjAL();
                
                PRProjTemplateObj[] arrayTemp = new PRProjTemplateObj[tempobjAL.size()];
                for (int i = 0; i < tempobjAL.size(); i++) {
                    arrayTemp[i] = (PRProjTemplateObj) tempobjAL.get(i);
                }
                //prPjObj.setPrPjtemp(arrayTemp);                
                prPjObj.setResultMsg("1");
            }
        }catch(Exception e){
            prPjObj.setErrorMsg(e.toString());
            prPjObj.setResultMsg("0");
        }
        
    }
    
    //取題目查核報告
    public void PRFltchkItem(String empno, String fdate, String fltno,String sect){
        prChkObj = new PRfltChkItemRObj();
        
        CheckItemKeyValue ckKey = new CheckItemKeyValue();
            ckKey.setFltd(fdate);
            ckKey.setFltno(fltno);
            ckKey.setSector(sect);
            ckKey.setPsrEmpn(empno); 
        CheckItemWithFlight chkItemFlt = null;
        ArrayList chkAL = null;
        //題目
        RetrieveCheckItem rCk = null;
        CheckMainItemObj chkDALObj = null;
        //內容
        RetrieveCheckRd  rcd = null;
        CheckRecordObj rdObj = null;
        
        ArrayList chkMAL = null;
        ArrayList chkDAL = null;
        ArrayList chkEdAL= null;
        try
        {
            chkItemFlt = new CheckItemWithFlight(ckKey);            
            chkAL = chkItemFlt.getChkItemAL();              
            if(chkAL!= null){
                for(int i=0;i<chkAL.size();i++){
                    CheckMainItemObj  obj= (CheckMainItemObj)chkAL.get(i);
                    chkMAL = new ArrayList();
                    chkMAL.add(obj);
                  //主項
                    CheckMainItemObj[] arrayMain = new CheckMainItemObj[chkMAL.size()];
                    for (int j = 0; j < chkMAL.size(); j++) {
                        arrayMain[j] = (CheckMainItemObj) chkMAL.get(j);
//                        System.out.println(arrayMain[j].getCheckRdSeq());
                    }
                    prChkObj.setChkObj(arrayMain);  
                    
                  //找細項
                    rCk = new RetrieveCheckItem(obj.getSeqno());
                    rCk.SelectData();
                    chkDALObj = rCk.getChkMainItemObj();
                    chkDAL = chkDALObj.getCheckDetailAL();
                    if(chkDAL!=null){
                        if(chkDAL.size() > 0){
                            CheckDetailItemObj[] arrayChk = new CheckDetailItemObj[chkDAL.size()];
                            for (int j = 0; j < chkDAL.size(); j++) {
                                arrayChk[j] = (CheckDetailItemObj) chkDAL.get(j);
//                                System.out.println(arrayChk[j].getSeqno());
                            }
                            prChkObj.setChkDObj(arrayChk);
                            prChkObj.setResultMsg("1");
                        }
                    }
                    else{
                        prChkObj.setErrorMsg("No detail date!");
                        prChkObj.setResultMsg("1");                        
                    }
                    
                    //找內容
                    rcd = new RetrieveCheckRd(obj.getSeqno());
                    rcd.setCheckRdSeqno(obj.getCheckRdSeq());
                    rcd.setChkItemKey(ckKey);
                    rcd.SelectData();
                    rdObj = rcd.getCheckRdObj();
                    if(rdObj != null){
                    chkEdAL = new ArrayList();
                    chkEdAL.add(rdObj);
                    
                        if(chkEdAL.size() > 0){
                            CheckRecordObj[] arrayEd = new CheckRecordObj[chkEdAL.size()];
                            for (int j = 0; j < chkEdAL.size(); j++) {
                             arrayEd[j] = (CheckRecordObj) chkEdAL.get(j);                           
                                arrayEd[j].setFlightDate(null);//此格式無法用於web service XML.
                            }
                            prChkObj.setChkEdObj(arrayEd); //主內容
                            prChkObj.setResultMsg("1");
                        }
                    }
                    else{
                         prChkObj.setErrorMsg("Not write!");
                         prChkObj.setResultMsg("1");                        
                     }
                }           
            }else{
                prChkObj.setErrorMsg("No date!");
                prChkObj.setResultMsg("1");
            }
        }catch(Exception e){
            prChkObj.setErrorMsg(e.toString());
            prChkObj.setResultMsg("0");
//            System.out.println(e.toString());
        }
    }

    
}
