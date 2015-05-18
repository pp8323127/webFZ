package pay;

/**
 * @author cs71 Created on  2006/11/29
 */
public class BankDataObj
{
    private String empno = ""; 
    private String name = "";
    private String ename = "";
    private String banknont = "";
    private String banknous = "";
    private String sern = "";
    private String banknont_prefix = "";//8位
    private String banknous_prefix = "";//8位
    private String prefixnont  = "";//5位
    private String prefixnous  = "";//5位  
    
    
    public String getPrefixnont()
    {
        return prefixnont;
    }
    public void setPrefixnont(String prefixnont)
    {
        this.prefixnont = prefixnont;
    }
    public String getPrefixnous()
    {
        return prefixnous;
    }
    public void setPrefixnous(String prefixnous)
    {
        this.prefixnous = prefixnous;
    }
    public String getBanknont_prefix()
    {
        return banknont_prefix;
    }
    public void setBanknont_prefix(String banknont_prefix)
    {
        this.banknont_prefix = banknont_prefix;
    }
    public String getBanknous_prefix()
    {
        return banknous_prefix;
    }
    public void setBanknous_prefix(String banknous_prefix)
    {
        this.banknous_prefix = banknous_prefix;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getBanknont()
    {
        return banknont;
    }
    public void setBanknont(String banknont)
    {
        this.banknont = banknont;
    }
    public String getBanknous()
    {
        return banknous;
    }
    public void setBanknous(String banknous)
    {
        this.banknous = banknous;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getEname()
    {
        return ename;
    }
    public void setEname(String ename)
    {
        this.ename = ename;
    }
    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
}
