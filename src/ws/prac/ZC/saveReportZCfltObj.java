package ws.prac.ZC;

import ws.*;

public class saveReportZCfltObj
{
    private String seqno = "";
    private String fltd = "";
    private String fltno = "";
    private String sect = "";
    private String cpname = "";
    private String cpno = "";
    private String acno = "";
    private String psrempn = "";
    private String psrsern = "";
    private String psrname = "";
    private String pgroups = "";
    private String zcempn = "";
    private String zcsern = "";
    private String zcname = "";
    private String zcgrps = "";
    private String memo = "";
    private String ifsent = "";
    private String sentdate = "";
    private String newuser = "";
    private String newdate = "";
    private String chguser = "";
    private String chgdate = "";
    private String rjtuser = "";
    private String rjtdate = "";
    private String rptclose = "";
    private String rptclose_userid = "";
    private String rptclose_date = "";
    
    saveReportZCCrewScoreObj[] zcScoreObjAL = null;//egtzcflt.·í¯Zcrews and egtgddt.score
    saveReportZCCrewGdObj[] zcGdObjAL = null; //egtzcgddt.gd items 
    saveReportZCFltIrrObj[] zcFltirrObjAL = null;//egtzcdm «È¿µ°ÊºA,egtzccmdt detail
    saveReportZCFileObj[] zcFileObjAL = null; // file upload
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
    public String getRptclose()
    {
        return rptclose;
    }
    public void setRptclose(String rptclose)
    {
        this.rptclose = rptclose;
    }
    public String getRptclose_userid()
    {
        return rptclose_userid;
    }
    public void setRptclose_userid(String rptclose_userid)
    {
        this.rptclose_userid = rptclose_userid;
    }
    public String getRptclose_date()
    {
        return rptclose_date;
    }
    public void setRptclose_date(String rptclose_date)
    {
        this.rptclose_date = rptclose_date;
    }
    public saveReportZCCrewScoreObj[] getZcScoreObjAL()
    {
        return zcScoreObjAL;
    }
    public void setZcScoreObjAL(saveReportZCCrewScoreObj[] zcScoreObjAL)
    {
        this.zcScoreObjAL = zcScoreObjAL;
    }
    public saveReportZCCrewGdObj[] getZcGdObjAL()
    {
        return zcGdObjAL;
    }
    public void setZcGdObjAL(saveReportZCCrewGdObj[] zcGdObjAL)
    {
        this.zcGdObjAL = zcGdObjAL;
    }
    public saveReportZCFltIrrObj[] getZcFltirrObjAL()
    {
        return zcFltirrObjAL;
    }
    public void setZcFltirrObjAL(saveReportZCFltIrrObj[] zcFltirrObjAL)
    {
        this.zcFltirrObjAL = zcFltirrObjAL;
    }
    public saveReportZCFileObj[] getZcFileObjAL()
    {
        return zcFileObjAL;
    }
    public void setZcFileObjAL(saveReportZCFileObj[] zcFileObjAL)
    {
        this.zcFileObjAL = zcFileObjAL;
    }


    
    
}
