package eg.off;

/**
 * @author cs71 Created on  2007/12/14
 */
public class HRALDateObj
{

    private String empno = "";
    private String sern = "";
    private String cname = "";
    private String ename = "";   
    private String aldate = "";
    private String hr_aldate = "";
    private String upduser = "";
    private String upddate = "";
    
    public String getEname()
    {
        return ename;
    }
    public void setEname(String ename)
    {
        this.ename = ename;
    }
    public String getCname()
    {
        return cname;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
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
    public String getAldate()
    {
        return aldate;
    }
    public void setAldate(String aldate)
    {
        this.aldate = aldate;
    }
    
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    
    public String getHr_aldate()
    {
        return hr_aldate;
    }
    public void setHr_aldate(String hr_aldate)
    {
        this.hr_aldate = hr_aldate;
    }
}
