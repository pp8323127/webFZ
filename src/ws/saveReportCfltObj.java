package ws;

public class saveReportCfltObj
{
  private String fltd = "";
  private String fltno = "";
  private String sect = "";
  private String cpname = "";
  private String cpno = "";
  private String acno = "";
  private String psrempn = "";
  private String psrsern = "0";
  private String psrname = "";
  private String pgroups = "";
  private String chguser = "";
  private String chgdate = "";
  private String remark = "";
  private String book_f = "0";
  private String book_c = "0";
  private String book_y = "0";
  private String book_w = "0";
  private String pxac = "0";
  private String upd = "";
  private String inf = "0";
  private String reject = "";
  private String reject_dt = "";
  private String reply = "";
  private String bdot = "";
  private String bdtime = "";
  private String bdreason = "";
  private String sh_st1 = "";
  private String sh_et1 = "";
  private String sh_st2 = "";
  private String sh_et2 = "";
  private String sh_st3 = "";
  private String sh_et3 = "";
  private String sh_st4 = "";
  private String sh_et4 = "";
  private String sh_remark = "";
  private String shift = "";
  private String noshift = "";
  private String sh_cm = "";
  private String update_time = "";
  private String new_time = "";

  private String mp_empn = "";
  private String sh_mp = "";

  saveReportCrewScoreObj[] scoreobjAL = null;
  saveReportCrewGdObj[] gdobjAL = null;
  saveReportFltIrrObj[] fltirrobjAL = null;
  saveReportPrpjObj[] projobjAL = null;
  saveReportPrsfObj[] prsfobjAL = null;
  saveReportChkrdmObj[] chkrdmobjAL = null;
  saveReportFileObj[] fileobjAL = null;
  saveReportPAObj[] paobjAL = null;
  saveReportPRObj[] probjAL = null;
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
public String getRemark()
{
    return remark;
}
public void setRemark(String remark)
{
    this.remark = remark;
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
public String getBook_y()
{
    return book_y;
}
public void setBook_y(String book_y)
{
    this.book_y = book_y;
}
public String getBook_w()
{
    return book_w;
}
public void setBook_w(String book_w)
{
    this.book_w = book_w;
}
public String getPxac()
{
    return pxac;
}
public void setPxac(String pxac)
{
    this.pxac = pxac;
}
public String getUpd()
{
    return upd;
}
public void setUpd(String upd)
{
    this.upd = upd;
}
public String getInf()
{
    return inf;
}
public void setInf(String inf)
{
    this.inf = inf;
}
public String getReject()
{
    return reject;
}
public void setReject(String reject)
{
    this.reject = reject;
}
public String getReject_dt()
{
    return reject_dt;
}
public void setReject_dt(String reject_dt)
{
    this.reject_dt = reject_dt;
}
public String getReply()
{
    return reply;
}
public void setReply(String reply)
{
    this.reply = reply;
}
public String getBdot()
{
    return bdot;
}
public void setBdot(String bdot)
{
    this.bdot = bdot;
}
public String getBdtime()
{
    return bdtime;
}
public void setBdtime(String bdtime)
{
    this.bdtime = bdtime;
}
public String getBdreason()
{
    return bdreason;
}
public void setBdreason(String bdreason)
{
    this.bdreason = bdreason;
}
public String getSh_st1()
{
    return sh_st1;
}
public void setSh_st1(String sh_st1)
{
    this.sh_st1 = sh_st1;
}
public String getSh_et1()
{
    return sh_et1;
}
public void setSh_et1(String sh_et1)
{
    this.sh_et1 = sh_et1;
}
public String getSh_st2()
{
    return sh_st2;
}
public void setSh_st2(String sh_st2)
{
    this.sh_st2 = sh_st2;
}
public String getSh_et2()
{
    return sh_et2;
}
public void setSh_et2(String sh_et2)
{
    this.sh_et2 = sh_et2;
}
public String getSh_st3()
{
    return sh_st3;
}
public void setSh_st3(String sh_st3)
{
    this.sh_st3 = sh_st3;
}
public String getSh_et3()
{
    return sh_et3;
}
public void setSh_et3(String sh_et3)
{
    this.sh_et3 = sh_et3;
}
public String getSh_st4()
{
    return sh_st4;
}
public void setSh_st4(String sh_st4)
{
    this.sh_st4 = sh_st4;
}
public String getSh_et4()
{
    return sh_et4;
}
public void setSh_et4(String sh_et4)
{
    this.sh_et4 = sh_et4;
}
public String getSh_remark()
{
    return sh_remark;
}
public void setSh_remark(String sh_remark)
{
    this.sh_remark = sh_remark;
}
public String getShift()
{
    return shift;
}
public void setShift(String shift)
{
    this.shift = shift;
}
public String getNoshift()
{
    return noshift;
}
public void setNoshift(String noshift)
{
    this.noshift = noshift;
}
public String getSh_cm()
{
    return sh_cm;
}
public void setSh_cm(String sh_cm)
{
    this.sh_cm = sh_cm;
}
public String getUpdate_time()
{
    return update_time;
}
public void setUpdate_time(String update_time)
{
    this.update_time = update_time;
}
public String getNew_time()
{
    return new_time;
}
public void setNew_time(String new_time)
{
    this.new_time = new_time;
}
public String getMp_empn()
{
    return mp_empn;
}
public void setMp_empn(String mp_empn)
{
    this.mp_empn = mp_empn;
}
public String getSh_mp()
{
    return sh_mp;
}
public void setSh_mp(String sh_mp)
{
    this.sh_mp = sh_mp;
}
public saveReportCrewScoreObj[] getScoreobjAL()
{
    return scoreobjAL;
}
public void setScoreobjAL(saveReportCrewScoreObj[] scoreobjAL)
{
    this.scoreobjAL = scoreobjAL;
}
public saveReportCrewGdObj[] getGdobjAL()
{
    return gdobjAL;
}
public void setGdobjAL(saveReportCrewGdObj[] gdobjAL)
{
    this.gdobjAL = gdobjAL;
}
public saveReportFltIrrObj[] getFltirrobjAL()
{
    return fltirrobjAL;
}
public void setFltirrobjAL(saveReportFltIrrObj[] fltirrobjAL)
{
    this.fltirrobjAL = fltirrobjAL;
}
public saveReportPrpjObj[] getProjobjAL()
{
    return projobjAL;
}
public void setProjobjAL(saveReportPrpjObj[] projobjAL)
{
    this.projobjAL = projobjAL;
}
public saveReportPrsfObj[] getPrsfobjAL()
{
    return prsfobjAL;
}
public void setPrsfobjAL(saveReportPrsfObj[] prsfobjAL)
{
    this.prsfobjAL = prsfobjAL;
}
public saveReportChkrdmObj[] getChkrdmobjAL()
{
    return chkrdmobjAL;
}
public void setChkrdmobjAL(saveReportChkrdmObj[] chkrdmobjAL)
{
    this.chkrdmobjAL = chkrdmobjAL;
}
public saveReportFileObj[] getFileobjAL()
{
    return fileobjAL;
}
public void setFileobjAL(saveReportFileObj[] fileobjAL)
{
    this.fileobjAL = fileobjAL;
}
public saveReportPAObj[] getPaobjAL()
{
    return paobjAL;
}
public void setPaobjAL(saveReportPAObj[] paobjAL)
{
    this.paobjAL = paobjAL;
}
public saveReportPRObj[] getProbjAL()
{
    return probjAL;
}
public void setProbjAL(saveReportPRObj[] probjAL)
{
    this.probjAL = probjAL;
}

  
}