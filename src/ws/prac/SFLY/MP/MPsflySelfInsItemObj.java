package ws.prac.SFLY.MP;

public class MPsflySelfInsItemObj
{
    private String itemno = null;   
    private String subject = null;
    private String flag = null;
    private String corr = "0";  //correct
    private String noChecked = "0"; //total checked
    private String crew = null;
    
    public String getItemno()
    {
        return itemno;
    }
    public void setItemno(String itemno)
    {
        this.itemno = itemno;
    }
    public String getSubject()
    {
        return subject;
    }
    public void setSubject(String subject)
    {
        this.subject = subject;
    }
    public String getFlag()
    {
        return flag;
    }
    public void setFlag(String flag)
    {
        this.flag = flag;
    }
    public String getCorr()
    {
        return corr;
    }
    public void setCorr(String corr)
    {
        this.corr = corr;
    }
    public String getNoChecked()
    {
        return noChecked;
    }
    public void setNoChecked(String noChecked)
    {
        this.noChecked = noChecked;
    }
    public String getCrew()
    {
        return crew;
    }
    public void setCrew(String crew)
    {
        this.crew = crew;
    }

    
}
