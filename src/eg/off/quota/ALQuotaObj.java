package eg.off.quota;

/**
 * @author cs71 Created on  2007/9/28
 */
public class ALQuotaObj
{
    private String quota_dt  	= "";
    private String leaverank 	= "";
    private String quota     	= "0";
    private String quota_used   = "0";
    private String quota_left   = "0";
    private String quota_release   = "0";
    private String upduser   	= "";
    private String upddate   	= "";
    
    public String getQuota_release()
    {
        return quota_release;
    }
    public void setQuota_release(String quota_release)
    {
        this.quota_release = quota_release;
    }
    public String getLeaverank()
    {
        return leaverank;
    }
    public void setLeaverank(String leaverank)
    {
        this.leaverank = leaverank;
    }
    public String getQuota()
    {
        return quota;
    }
    public void setQuota(String quota)
    {
        this.quota = quota;
    }
    public String getQuota_dt()
    {
        return quota_dt;
    }
    public void setQuota_dt(String quota_dt)
    {
        this.quota_dt = quota_dt;
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
    public String getQuota_used()
    {
        return quota_used;
    }
    public void setQuota_used(String quota_used)
    {
        this.quota_used = quota_used;
    }
    public String getQuota_left()
    {
        return quota_left;
    }
    public void setQuota_left(String quota_left)
    {
        this.quota_left = quota_left;
    }
}
