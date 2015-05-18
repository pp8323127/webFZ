package eg.zcrpt;

import java.util.*;

/**
 * @author cs71 Created on  2009/10/7
 */
public class ZCReportObj
{
    String seqno    = "";
    String fltd     = "";
    String fltno    = "";
    String sect      = "";
    String cpname    = "";
    String cpno      = "";
    String acno      = "";
    String psrempn   = "";
    String psrsern   = "";
    String psrname   = "";
    String pgroups   = "";
    String zcempn    = "";
    String zcsern    = "";
    String zcname    = "";
    String zcgrps    = "";
    String memo      = "";
    String ifsent    = "";
    String sentdate  = "";
    String newuser   = "";
    String newdate   = "";
    String chguser   = "";
    String chgdate   = "";
    String rjtuser   = "";
    String rjtdate   = "";
    //**********************
    //aircrew obj
    String fdate     = ""; //dps.str_dt_tm_loc yyyy/mm/dd
    String stdDt     = ""; //dps.str_dt_tm_loc yyyy/mm/dd hh24:mi
    String flt_num   = "";
    String port      = ""; //dps.port_a||dps.port_b       
    String act_rank  = ""; //r.acting_rank qual   
    String special_indicator = ""; //r.special_indicator
    
    String fleet_cd  = "";//¾÷«¬
    
    ArrayList zccrewObjAL = new ArrayList();    
    ArrayList zcfltirrObjAL = new ArrayList();       
    
    
    public String getSpecial_indicator()
    {
        return special_indicator;
    }
    public void setSpecial_indicator(String special_indicator)
    {
        this.special_indicator = special_indicator;
    }
    public ArrayList getZcfltirrObjAL()
    {
        return zcfltirrObjAL;
    }
    public void setZcfltirrObjAL(ArrayList zcfltirrObjAL)
    {
        this.zcfltirrObjAL = zcfltirrObjAL;
    }
    public ArrayList getZccrewObjAL()
    {
        return zccrewObjAL;
    }
    public void setZccrewObjAL(ArrayList zccrewObjAL)
    {
        this.zccrewObjAL = zccrewObjAL;
    }
    public String getFdate()
    {
        return fdate;
    }
    public void setFdate(String fdate)
    {
        this.fdate = fdate;
    }
    public String getFlt_num()
    {
        return flt_num;
    }
    public void setFlt_num(String flt_num)
    {
        this.flt_num = flt_num;
    }
    public String getPort()
    {
        return port;
    }
    public void setPort(String port)
    {
        this.port = port;
    }
    public String getStdDt()
    {
        return stdDt;
    }
    public void setStdDt(String stdDt)
    {
        this.stdDt = stdDt;
    }
    public String getAcno()
    {
        return acno;
    }
    public void setAcno(String acno)
    {
        this.acno = acno;
    }
    public String getAct_rank()
    {
        return act_rank;
    }
    public void setAct_rank(String act_rank)
    {
        this.act_rank = act_rank;
    }
    public String getChgdate()
    {
        return chgdate;
    }
    public void setChgdate(String chgdate)
    {
        this.chgdate = chgdate;
    }
    public String getChguser()
    {
        return chguser;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
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
    public String getIfsent()
    {
        return ifsent;
    }
    public void setIfsent(String ifsent)
    {
        this.ifsent = ifsent;
    }
    public String getMemo()
    {
        return memo;
    }
    public void setMemo(String memo)
    {
        this.memo = memo;
    }
    public String getNewdate()
    {
        return newdate;
    }
    public void setNewdate(String newdate)
    {
        this.newdate = newdate;
    }
    public String getNewuser()
    {
        return newuser;
    }
    public void setNewuser(String newuser)
    {
        this.newuser = newuser;
    }
    public String getPgroups()
    {
        return pgroups;
    }
    public void setPgroups(String pgroups)
    {
        this.pgroups = pgroups;
    }
    public String getPsrempn()
    {
        return psrempn;
    }
    public void setPsrempn(String psrempn)
    {
        this.psrempn = psrempn;
    }
    public String getPsrname()
    {
        return psrname;
    }
    public void setPsrname(String psrname)
    {
        this.psrname = psrname;
    }
    public String getPsrsern()
    {
        return psrsern;
    }
    public void setPsrsern(String psrsern)
    {
        this.psrsern = psrsern;
    }
    public String getRjtdate()
    {
        return rjtdate;
    }
    public void setRjtdate(String rjtdate)
    {
        this.rjtdate = rjtdate;
    }
    public String getRjtuser()
    {
        return rjtuser;
    }
    public void setRjtuser(String rjtuser)
    {
        this.rjtuser = rjtuser;
    }
    public String getSect()
    {
        return sect;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public String getSentdate()
    {
        return sentdate;
    }
    public void setSentdate(String sentdate)
    {
        this.sentdate = sentdate;
    }
    public String getSeqno()
    {
        return seqno;
    }
    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }
    
    public String getZcempn()
    {
        return zcempn;
    }
    public void setZcempn(String zcempn)
    {
        this.zcempn = zcempn;
    }
    public String getZcgrps()
    {
        return zcgrps;
    }
    public void setZcgrps(String zcgrps)
    {
        this.zcgrps = zcgrps;
    }
    public String getZcname()
    {
        return zcname;
    }
    public void setZcname(String zcname)
    {
        this.zcname = zcname;
    }
    public String getZcsern()
    {
        return zcsern;
    }
    public void setZcsern(String zcsern)
    {
        this.zcsern = zcsern;
    }
    public String getFleet_cd() {
        return fleet_cd;
    }
    public void setFleet_cd(String fleet_cd) {
        this.fleet_cd = fleet_cd;
    }
}
