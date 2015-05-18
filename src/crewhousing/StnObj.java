package crewhousing;

/**
 * @author cs71 Created on  2008/8/26
 */
public class StnObj
{

    private String stn ="";
    private String effdt ="";
    private String expdt ="";
    private String chguser ="";
    private String chgdate ="";
    private String ifvalid = "";
    

    public String getChgdate()
    {
        return chgdate;
    }
    public void setChgdate(String chgdate)
    {
        this.chgdate = chgdate;
    }
    public String getIfvalid()
    {
        return ifvalid;
    }
    public void setIfvalid(String ifvalid)
    {
        this.ifvalid = ifvalid;
    }
    public String getChguser()
    {
        return chguser;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
    }
    public String getEffdt()
    {
        return effdt;
    }
    public void setEffdt(String effdt)
    {
        this.effdt = effdt;
    }
    public String getExpdt()
    {
        return expdt;
    }
    public void setExpdt(String expdt)
    {
        this.expdt = expdt;
    }
    public String getStn()
    {
        return stn;
    }
    public void setStn(String stn)
    {
        this.stn = stn;
    }
}
