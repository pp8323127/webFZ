package swap3ac;

/**
 * CleanMonthObj 全勤基準月份物件
 * 
 * 
 * @author cs66
 * @version 1.0 2008/3/9
 * 
 * Copyright: Copyright (c) 2008
 */
public class RestHourObj 
{
    private String seq       = "";
	private String condi_col = "";
	private String condi_val = "";
	private String resthr    = "";
	private String expdt     = "";
	private String base      = "";
	private String newuser   = "";
	private String newdate   = "";
	private String upduser   = "";
	private String upddate   = "";	
	
    public String getSeq()
    {
        return seq;
    }
    public void setSeq(String seq)
    {
        this.seq = seq;
    }
    public String getBase()
    {
        return base;
    }
    public void setBase(String base)
    {
        this.base = base;
    }
    public String getCondi_col()
    {
        return condi_col;
    }
    public void setCondi_col(String condi_col)
    {
        this.condi_col = condi_col;
    }
    public String getCondi_val()
    {
        return condi_val;
    }
    public void setCondi_val(String condi_val)
    {
        this.condi_val = condi_val;
    }   
    public String getExpdt()
    {
        return expdt;
    }
    public void setExpdt(String expdt)
    {
        this.expdt = expdt;
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
    public String getResthr()
    {
        return resthr;
    }
    public void setResthr(String resthr)
    {
        this.resthr = resthr;
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
}
