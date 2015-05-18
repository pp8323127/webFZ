package fz.pracP;

public class PRreportToolObj
{    
    private String ti_itemdsc = "";
    private String pi_kin     = "";
    private String pi_itemno  = "";
    private String pi_itemdsc = "";
    private String td_itemdsc = "";
    private String level	  = ""; //ti, pi, pd    
    
    public String getLevel()
    {
        return level;
    }
    public void setLevel(String level)
    {
        this.level = level;
    }
    public String getPi_itemdsc()
    {
        return pi_itemdsc;
    }
    public void setPi_itemdsc(String pi_itemdsc)
    {
        this.pi_itemdsc = pi_itemdsc;
    }
    public String getPi_itemno()
    {
        return pi_itemno;
    }
    public void setPi_itemno(String pi_itemno)
    {
        this.pi_itemno = pi_itemno;
    }
    public String getPi_kin()
    {
        return pi_kin;
    }
    public void setPi_kin(String pi_kin)
    {
        this.pi_kin = pi_kin;
    }
    public String getTd_itemdsc()
    {
        return td_itemdsc;
    }
    public void setTd_itemdsc(String td_itemdsc)
    {
        this.td_itemdsc = td_itemdsc;
    }
    public String getTi_itemdsc()
    {
        return ti_itemdsc;
    }
    public void setTi_itemdsc(String ti_itemdsc)
    {
        this.ti_itemdsc = ti_itemdsc;
    }
}