package eg.CrewEval;

/**
 * @author CS71 Created on  2012/10/2
 */
public class InqueryCrewEvalObj
{
    private String yyyy= "";
    private String mm= "";
    private String empno= "";
    private String sern = "";
    private String cname = "";
    private String base = "";
    private String individual_avg ="";//個人當月任務平均分數
    private String individual_seq ="";//個人當月名次
    private String base_total = "";//該員base總人數
    private String base_avg ="";
    
    public String getBase()
    {
        return base;
    }
    public void setBase(String base)
    {
        this.base = base;
    }
    public String getBase_avg()
    {
        return base_avg;
    }
    public void setBase_avg(String base_avg)
    {
        this.base_avg = base_avg;
    }
    public String getBase_total()
    {
        return base_total;
    }
    public void setBase_total(String base_total)
    {
        this.base_total = base_total;
    }
    public String getCname()
    {
        return cname;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getIndividual_avg()
    {
        return individual_avg;
    }
    public void setIndividual_avg(String individual_avg)
    {
        this.individual_avg = individual_avg;
    }
    public String getIndividual_seq()
    {
        return individual_seq;
    }
    public void setIndividual_seq(String individual_seq)
    {
        this.individual_seq = individual_seq;
    }
    public String getMm()
    {
        return mm;
    }
    public void setMm(String mm)
    {
        this.mm = mm;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getYyyy()
    {
        return yyyy;
    }
    public void setYyyy(String yyyy)
    {
        this.yyyy = yyyy;
    }
}
