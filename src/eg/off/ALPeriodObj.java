package eg.off;

/**
 * @author cs71 Created on  2007/12/19
 */
public class ALPeriodObj
{

    private String empno    = "";
    private String sern     = "";
    private String offtype  = "";
    private String offquota = "";
    private String useddays = "";
    private String eff_dt   = "";
    private String exp_dt   = "";
    private String newuser  = "";
    private String newdate  = "";
    private String upduser  = "";
    private String upddate  = "";
    private String memo  = "";    
    private String origdays = "";
    private String overdays = ""; 
    private String deduct_tmst = ""; 
    
    
    public String getDeduct_tmst()
    {
        return deduct_tmst;
    }
    public void setDeduct_tmst(String deduct_tmst)
    {
        this.deduct_tmst = deduct_tmst;
    }
    public String getOrigdays()
    {
        return origdays;
    }
    public void setOrigdays(String origdays)
    {
        this.origdays = origdays;
    }
    public String getOverdays()
    {
        return overdays;
    }
    public void setOverdays(String overdays)
    {
        this.overdays = overdays;
    }
    public String getMemo()
    {
        return memo;
    }
    public void setMemo(String memo)
    {
        this.memo = memo;
    }
    public String getEff_dt()
    {
        return eff_dt;
    }
    public void setEff_dt(String eff_dt)
    {
        this.eff_dt = eff_dt;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getExp_dt()
    {
        return exp_dt;
    }
    public void setExp_dt(String exp_dt)
    {
        this.exp_dt = exp_dt;
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
    public String getOffquota()
    {
        return offquota;
    }
    public void setOffquota(String offquota)
    {
        this.offquota = offquota;
    }
    public String getOfftype()
    {
        return offtype;
    }
    public void setOfftype(String offtype)
    {
        this.offtype = offtype;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getUpddate()
    {
        return upddate;
    }
    public void setUpddate(String upddate)
    {
        this.upddate = upddate;
    }
    public String getUpduser()
    {
        return upduser;
    }
    public void setUpduser(String upduser)
    {
        this.upduser = upduser;
    }
    public String getUseddays()
    {
        return useddays;
    }
    public void setUseddays(String useddays)
    {
        this.useddays = useddays;
    }
}