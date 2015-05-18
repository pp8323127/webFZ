package eg.off;

/**
 * @author cs71 Created on  2007/3/28
 */
public class ALRulesObj
{   
    private String offyear = "";
    private String jobtype = ""; //TPE FS | TPE FA | TPE PUR | TPE ZC | TPE TU | TPE KOR | TPE TYO
    						    //KHH CREW | KHH PUR | TPE ZC | KHH TU 
    private String empno = "";
    private String sern = "";
    private String jobno = "";
    private String indate = "";
    private String hraldate = "";
    private String status = "";
    private String sex = "";
    private String base = "";   
    private String specialcode = "";
    private String fltno = "";
    private String offtype = "";    
   
    private String offdate = ""; //yyyy/mm/dd   
    private int dayquota = 0;
    private int leftquota = 0;
    private String offsdate = "";
    private String offedate = "";    
    private int offday = 0;
    private int openday = 0;
    private String opentime = ""; 
    private int offdays =0; 
    private String deloffno = ""; 
    private String chguser =""; 
    private String userid =""; 
    
    public String getOfftype()
    {
        return offtype;
    }
    public void setOfftype(String offtype)
    {
        this.offtype = offtype;
    }    
    public String getUserid()
    {
        return userid;
    }
    public void setUserid(String userid)
    {
        this.userid = userid;
    }
    public String getBase()
    {
        return base;
    }
    public void setBase(String base)
    {
        this.base = base;
    }
    public String getChguser()
    {
        return chguser;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
    }
    public int getDayquota()
    {
        return dayquota;
    }
    public void setDayquota(int dayquota)
    {
        this.dayquota = dayquota;
    }
    public String getDeloffno()
    {
        return deloffno;
    }
    public void setDeloffno(String deloffno)
    {
        this.deloffno = deloffno;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getHraldate()
    {
        return hraldate;
    }
    public void setHraldate(String hraldate)
    {
        this.hraldate = hraldate;
    }
    public String getIndate()
    {
        return indate;
    }
    public void setIndate(String indate)
    {
        this.indate = indate;
    }
    public String getJobno()
    {
        return jobno;
    }
    public void setJobno(String jobno)
    {
        this.jobno = jobno;
    }
    public String getJobtype()
    {
        return jobtype;
    }
    public void setJobtype(String jobtype)
    {
        this.jobtype = jobtype;
    }
    public int getLeftquota()
    {
        return leftquota;
    }
    public void setLeftquota(int leftquota)
    {
        this.leftquota = leftquota;
    }
    public String getOffdate()
    {
        return offdate;
    }
    public void setOffdate(String offdate)
    {
        this.offdate = offdate;
    }
    public int getOffday()
    {
        return offday;
    }
    public void setOffday(int offday)
    {
        this.offday = offday;
    }
    public int getOffdays()
    {
        return offdays;
    }
    public void setOffdays(int offdays)
    {
        this.offdays = offdays;
    }
    public String getOffedate()
    {
        return offedate;
    }
    public void setOffedate(String offedate)
    {
        this.offedate = offedate;
    }
    public String getOffsdate()
    {
        return offsdate;
    }
    public void setOffsdate(String offsdate)
    {
        this.offsdate = offsdate;
    }
    public String getOffyear()
    {
        return offyear;
    }
    public void setOffyear(String offyear)
    {
        this.offyear = offyear;
    }
    public int getOpenday()
    {
        return openday;
    }
    public void setOpenday(int openday)
    {
        this.openday = openday;
    }
    public String getOpentime()
    {
        return opentime;
    }
    public void setOpentime(String opentime)
    {
        this.opentime = opentime;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getSex()
    {
        return sex;
    }
    public void setSex(String sex)
    {
        this.sex = sex;
    }
    public String getSpecialcode()
    {
        return specialcode;
    }
    public void setSpecialcode(String specialcode)
    {
        this.specialcode = specialcode;
    }
    public String getStatus()
    {
        return status;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }
}
