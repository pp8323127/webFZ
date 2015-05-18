package ws.prac.ZC;

import java.util.*;

import eg.zcrpt.*;

public class ReportListZCfltRObj
{
    private String errorMsg = null;
    private String resultMsg = null;
    
    private String seqno    = null;
    private String fltd     = null;
    private String fltno    = null;
    private String sect     = null;
    private String cpname   = null;
    private String cpno     = null;
    private String acno     = null;
    private String fleet    = null;
    private String psrempn  = null;
    private String psrsern  = null;
    private String psrname  = null;
    private String pgroups  = null;
    private String zcempn   = null;
    private String zcsern   = null;
    private String zcname   = null;
    private String zcgrps   = null;
    private String memo     = null;
    private String ifsent   = null;
    private String sentdate = null;
    private String newuser  = null;
    private String newdate  = null;
    private String chguser  = null;
    private String chgdate  = null;
    private String rjtuser  = null;
    private String rjtdate  = null;
    private String wflag    = null; // Y: 有報告 N:無報告
    private String upd      = null; // Y:報告可再編輯 N:報告不可再編輯
    private boolean late     = false;
    private String cmFirrReply = "";
    
    String[] class_cat = null;
    String book_f = "0";
    String book_c = "0";
    String book_w = "0";
    String book_y = "0";
//    private ArrayList zccrewObjAL = new ArrayList();    
//    private ArrayList zcfltirrObjAL = new ArrayList();   
    private ZCReportCrewListObj[] zccrewObjArr = null;
    private ZCFltIrrItemObj[] zcfltirrObjArr = null;
    private CmIirrObj[] cmIirrObjArr = null;
     
    public String getErrorMsg()
    {
        return errorMsg;
    }
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
    public String getResultMsg()
    {
        return resultMsg;
    }
    public void setResultMsg(String resultMsg)
    {
        this.resultMsg = resultMsg;
    }
    
    public String getFleet()
    {
        return fleet;
    }
    public void setFleet(String fleet)
    {
        this.fleet = fleet;
    }
    public String getSeqno()
    {
        return seqno;
    }
    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }
    public String getFltd()
    {
        return fltd;
    }
    public void setFltd(String fltd)
    {
        this.fltd = fltd;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getSect()
    {
        return sect;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public String getCpname()
    {
        return cpname;
    }
    public void setCpname(String cpname)
    {
        this.cpname = cpname;
    }
    public String getCpno()
    {
        return cpno;
    }
    public void setCpno(String cpno)
    {
        this.cpno = cpno;
    }
    public String getAcno()
    {
        return acno;
    }
    public void setAcno(String acno)
    {
        this.acno = acno;
    }
    public String getPsrempn()
    {
        return psrempn;
    }
    public void setPsrempn(String psrempn)
    {
        this.psrempn = psrempn;
    }
    public String getPsrsern()
    {
        return psrsern;
    }
    public void setPsrsern(String psrsern)
    {
        this.psrsern = psrsern;
    }
    public String getPsrname()
    {
        return psrname;
    }
    public void setPsrname(String psrname)
    {
        this.psrname = psrname;
    }
    public String getPgroups()
    {
        return pgroups;
    }
    public void setPgroups(String pgroups)
    {
        this.pgroups = pgroups;
    }
    public String getZcempn()
    {
        return zcempn;
    }
    public void setZcempn(String zcempn)
    {
        this.zcempn = zcempn;
    }
    public String getZcsern()
    {
        return zcsern;
    }
    public void setZcsern(String zcsern)
    {
        this.zcsern = zcsern;
    }
    public String getZcname()
    {
        return zcname;
    }
    public void setZcname(String zcname)
    {
        this.zcname = zcname;
    }
    public String getZcgrps()
    {
        return zcgrps;
    }
    public void setZcgrps(String zcgrps)
    {
        this.zcgrps = zcgrps;
    }
    public String getMemo()
    {
        return memo;
    }
    public void setMemo(String memo)
    {
        this.memo = memo;
    }
    public String getIfsent()
    {
        return ifsent;
    }
    public void setIfsent(String ifsent)
    {
        this.ifsent = ifsent;
    }
    public String getSentdate()
    {
        return sentdate;
    }
    public void setSentdate(String sentdate)
    {
        this.sentdate = sentdate;
    }
    public String getNewuser()
    {
        return newuser;
    }
    public void setNewuser(String newuser)
    {
        this.newuser = newuser;
    }
    public String getNewdate()
    {
        return newdate;
    }
    public void setNewdate(String newdate)
    {
        this.newdate = newdate;
    }
    public String getChguser()
    {
        return chguser;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
    }
    public String getChgdate()
    {
        return chgdate;
    }
    public void setChgdate(String chgdate)
    {
        this.chgdate = chgdate;
    }
    public String getRjtuser()
    {
        return rjtuser;
    }
    public void setRjtuser(String rjtuser)
    {
        this.rjtuser = rjtuser;
    }
    public String getRjtdate()
    {
        return rjtdate;
    }
    public void setRjtdate(String rjtdate)
    {
        this.rjtdate = rjtdate;
    }
    public String getWflag()
    {
        return wflag;
    }
    public void setWflag(String wflag)
    {
        this.wflag = wflag;
    }
    public String getUpd()
    {
        return upd;
    }
    public void setUpd(String upd)
    {
        this.upd = upd;
    }
    public boolean isLate()
    {
        return late;
    }
    public void setLate(boolean late)
    {
        this.late = late;
    }
    public ZCReportCrewListObj[] getZccrewObjArr()
    {
        return zccrewObjArr;
    }
    public void setZccrewObjArr(ZCReportCrewListObj[] zccrewObjArr)
    {
        this.zccrewObjArr = zccrewObjArr;
    }
    public ZCFltIrrItemObj[] getZcfltirrObjArr()
    {
        return zcfltirrObjArr;
    }
    public void setZcfltirrObjArr(ZCFltIrrItemObj[] zcfltirrObjArr)
    {
        this.zcfltirrObjArr = zcfltirrObjArr;
    }
    public String[] getClass_cat()
    {
        return class_cat;
    }
    public void setClass_cat(String[] class_cat)
    {
        this.class_cat = class_cat;
    }
    public String getBook_f()
    {
        return book_f;
    }
    public void setBook_f(String book_f)
    {
        this.book_f = book_f;
    }
    public String getBook_c()
    {
        return book_c;
    }
    public void setBook_c(String book_c)
    {
        this.book_c = book_c;
    }
    public String getBook_w()
    {
        return book_w;
    }
    public void setBook_w(String book_w)
    {
        this.book_w = book_w;
    }
    public String getBook_y()
    {
        return book_y;
    }
    public void setBook_y(String book_y)
    {
        this.book_y = book_y;
    }
    public String getCmFirrReply()
    {
        return cmFirrReply;
    }
    public void setCmFirrReply(String cmFirrReply)
    {
        this.cmFirrReply = cmFirrReply;
    }
    public CmIirrObj[] getCmIirrObjArr()
    {
        return cmIirrObjArr;
    }
    public void setCmIirrObjArr(CmIirrObj[] cmIirrObjArr)
    {
        this.cmIirrObjArr = cmIirrObjArr;
    }
    


   
    
}
