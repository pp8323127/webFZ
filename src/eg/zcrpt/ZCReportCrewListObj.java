package eg.zcrpt;

import java.util.*;

/**
 * @author cs71 Created on  2009/10/8
 */
public class ZCReportCrewListObj
{
    private String seqno      = "";
    private String empno      = "";
    private String sern       = "";
    private String cname      = "";
    private String duty       = "";
    private String score      = "";
    private String grp        = "";
    private String best_performance  = "";    
    private String ifcheck  = "";    
    private ArrayList gradeobjAL = new ArrayList();    
    
    public ArrayList getGradeobjAL()
    {
        return gradeobjAL;
    }
    public void setGradeobjAL(ArrayList gradeobjAL)
    {
        this.gradeobjAL = gradeobjAL;
    }
    public String getIfcheck()
    {
        return ifcheck;
    }
    public void setIfcheck(String ifcheck)
    {
        this.ifcheck = ifcheck;
    }
    public String getBest_performance()
    {
        return best_performance;
    }
    public void setBest_performance(String best_performance)
    {
        this.best_performance = best_performance;
    }
    public String getCname()
    {
        return cname;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
    }
    public String getDuty()
    {
        return duty;
    }
    public void setDuty(String duty)
    {
        this.duty = duty;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getGrp()
    {
        return grp;
    }
    public void setGrp(String grp)
    {
        this.grp = grp;
    }
    public String getScore()
    {
        return score;
    }
    public void setScore(String score)
    {
        this.score = score;
    }
    public String getSeqno()
    {
        return seqno;
    }
    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
}
