package ws.prac.SFLY;

import java.util.*;


import fz.projectinvestigate.*;
import fz.psfly.*;

public class CheckSFLYRpt
{

    /**
     * @param args
     */
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub   	

    }
 // 是否需填自我督察
    public String ReportListHasPRSFly(String empno, String fdate, String fltno,String sect, String flag, String upd) {
        
        boolean needfill = false;
        String r = "";
        PRSFlyIssue psf = new PRSFlyIssue();
        try{
            psf.getPsflyTopic_no(fdate, fltno, sect.substring(0, 3),sect.substring(3), empno, "", "");
        }catch(Exception e){
            r = "Error:PRSFly"+e.toString();
        }

        if (psf.getTopic_noAL().size() > 0) {
            needfill = true;
        }
        // 已編輯過報告且已送出，不可再編輯 , flag 代表有無報告
        if ("Y".equals(flag) && "N".equals(upd)) {
            if (needfill == true) {
                r = "view";
            } else {
                r = "none";
            }
        } else if ("Y".equals(flag) && "Y".equals(upd)) {
            if (needfill == true) {
                r = "edit";
            } else {
                r = "none";
            }
        } else if ("N".equals(flag)) {
            if (needfill == true) {
                String topic_no = "";
                for (int k = 0; k < psf.getTopic_noAL().size(); k++) {
                    topic_no = topic_no + "," + psf.getTopic_noAL().get(k);
                    r = "preView/" + topic_no.substring(1);
                }
            } else {
                r = "none";
            }
        }
        return r;
    }
    
    // 是否需填專案調查
    public String ReportListHasProj(String empno, String fdate, String fltno,String sect, String flag, String upd) {
        
        boolean pjneedfill = false;
        String r = "";
        PRPJIssue pj = new PRPJIssue();
        try{
            pj.getPRProj_no(fdate, fltno, sect.substring(0, 3), sect.substring(3),empno, "", "");
        }catch(Exception e){
            r = "Error:Proj"+e.toString();
        }
        
        if (pj.getProj_noAL().size() > 0) {
            pjneedfill = true;
        }
        // 已編輯過報告且已送出，不可再編輯 flag 代表有無報告
        if ("Y".equals(flag) && "N".equals(upd)) {
            if (pjneedfill == true) {
                r = "view";
            } else {
                r = "none";
            }
        } else if ("Y".equals(flag) && "Y".equals(upd)) {
            if (pjneedfill == true) {
                r = "edit";
            } else {
                r = "none";
            }
        } else if ("N".equals(flag)) {
            if (pjneedfill == true) {
                String proj_no = "";
                for (int k = 0; k < pj.getProj_noAL().size(); k++) {
                    proj_no = proj_no + "," + pj.getProj_noAL().get(k);
                }
                r = "preView/" + proj_no.substring(1);

            } else {
                r = "none";
            }
        }
        return r;
    }
    
    // 是否需填查核項目
    public String ReportListHasCkeItem(String empno, String fdate, String fltno,String sect, String flag, String upd){
        
        eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
        ckKey.setFltd(fdate);
        ckKey.setFltno(fltno);
        ckKey.setSector(sect);
        ckKey.setPsrEmpn(empno);
        eg.flightcheckitem.CheckItemWithFlight ckhItemFlt = null;
        ArrayList al = null;
        String r = "";
        try {
            ckhItemFlt = new eg.flightcheckitem.CheckItemWithFlight(ckKey);
            al = ckhItemFlt.getChkItemAL();
        } catch (Exception e) {
            r = "Error chkItem:"+e.toString();
        }

        // ********************************************************************************************
        if (al != null) {
            // 已編輯過報告且已送出，不可再編輯 flag 代表有無報告
            if ("Y".equals(flag) && "N".equals(upd)) {
                for (int q = 0; q < al.size(); q++) {
                    eg.flightcheckitem.CheckMainItemObj obj = (eg.flightcheckitem.CheckMainItemObj) al
                            .get(q);
                    if (obj.isHasCheckData()) {
                        r = "view";
                    } else {
                        r = "none";
                    }
                }
            } else if ("Y".equals(flag) && "Y".equals(upd)) {
                r = "edit";
            } else if ("N".equals(flag)) {
                r = "insert";
            } else {// if(al != null)
                r = "none";
            }
        } else {// if(al != null)
            r = "none";
        }
        return r;
    }

    
}
