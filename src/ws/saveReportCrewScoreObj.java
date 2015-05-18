package ws;

import java.util.*;
/**
 * @author cs71 Created on  2013/08/19
 */
public class saveReportCrewScoreObj
{
    private String seq      ="";
    private String empn     ="";
    private String sern     ="";
    private String crew     ="";
    private String score    ="";
    private String duty     ="";
    private String grp      ="";  
    private String sh_session    =""; //½ü¥ð®É¬q
    private String fd_ind   ="";
    private String newuser   ="";
    private String newdate   ="";
    private String chguser   ="";
    private String chgdate   ="";
    
//    ArrayList serviceAL = new ArrayList();    

    
    public String getNewdate()
    {
        return newdate;
    }
    public String getNewuser()
    {
        return newuser;
    }
    public void setNewdate(String newdate)
    {
        this.newdate = newdate;
    }
    public void setNewuser(String newuser)
    {
        this.newuser = newuser;
    }
    public String getChgdate()
    {
        return chgdate;
    }
    public String getChguser()
    {
        return chguser;
    }
    public void setChgdate(String chgdate)
    {
        this.chgdate = chgdate;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
    }
    public String getCrew()
    {
        return crew;
    }
    public String getDuty()
    {
        return duty;
    }
    public String getEmpn()
    {
        return empn;
    }
    public String getFd_ind()
    {
        return fd_ind;
    }
    public String getGrp()
    {
        return grp;
    }
    public String getScore()
    {
        return score;
    }
    public String getSeq()
    {
        return seq;
    }
    public String getSern()
    {
        return sern;
    }
    public String getSh_session()
    {
        return sh_session;
    }
    public void setCrew(String crew)
    {
        this.crew = crew;
    }
    public void setDuty(String duty)
    {
        this.duty = duty;
    }
    public void setEmpn(String empn)
    {
        this.empn = empn;
    }
    public void setFd_ind(String fd_ind)
    {
        this.fd_ind = fd_ind;
    }
    public void setGrp(String grp)
    {
        this.grp = grp;
    }
    public void setScore(String score)
    {
        this.score = score;
    }
    public void setSeq(String seq)
    {
        this.seq = seq;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }

    public void setSh_session(String sh_session)
    {
        this.sh_session = sh_session;
    }
}
