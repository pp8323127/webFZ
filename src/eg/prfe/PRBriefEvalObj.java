package eg.prfe;

import java.util.*;

/**
 * @author cs71 Created on  2009/6/16
 */
public class PRBriefEvalObj
{
    private String brief_dt   ="";
    private String brief_time ="";
    private String fltno      ="";
    private String purempno   ="";
    private String pursern   ="";
    private String purname   ="";
    private String chk1_score  ="";
    private String chk2_score  ="";
    private String chk3_score  ="";
    private String chk4_score  ="";
    private String chk5_score  ="";
    private String ttlscore    ="";
    private String comm        ="";
    private String newuser     ="";
    private String newname     ="";
    private String newdate     =""; 
    private String caseclose   ="";
    private String close_tmst  ="";
    private String close_user  ="";
    private String confirm_tmst  ="";
    private ArrayList beObjAL = new ArrayList(); 
    private ArrayList subScoreObjAL = new ArrayList();   
    
    public ArrayList getSubScoreObjAL()
    {
        return subScoreObjAL;
    }
    public void setSubScoreObjAL(ArrayList subScoreObjAL)
    {
        this.subScoreObjAL = subScoreObjAL;
    }
    public String getCaseclose()
    {
        return caseclose;
    }
    public void setCaseclose(String caseclose)
    {
        this.caseclose = caseclose;
    }
    public String getClose_tmst()
    {
        return close_tmst;
    }
    public void setClose_tmst(String close_tmst)
    {
        this.close_tmst = close_tmst;
    }
    public String getClose_user()
    {
        return close_user;
    }
    public void setClose_user(String close_user)
    {
        this.close_user = close_user;
    }
    public String getConfirm_tmst()
    {
        return confirm_tmst;
    }
    public void setConfirm_tmst(String confirm_tmst)
    {
        this.confirm_tmst = confirm_tmst;
    }
    public java.util.ArrayList getBeObjAL()
    {
        return beObjAL;
    }
    public void setBeObjAL(java.util.ArrayList beObjAL)
    {
        this.beObjAL = beObjAL;
    }
    public String getBrief_dt()
    {
        return brief_dt;
    }
    public void setBrief_dt(String brief_dt)
    {
        this.brief_dt = brief_dt;
    }
    public String getBrief_time()
    {
        return brief_time;
    }
    public void setBrief_time(String brief_time)
    {
        this.brief_time = brief_time;
    }
    public String getChk1_score()
    {
        return chk1_score;
    }
    public void setChk1_score(String chk1_score)
    {
        this.chk1_score = chk1_score;
    }
    public String getChk2_score()
    {
        return chk2_score;
    }
    public void setChk2_score(String chk2_score)
    {
        this.chk2_score = chk2_score;
    }
    public String getChk3_score()
    {
        return chk3_score;
    }
    public void setChk3_score(String chk3_score)
    {
        this.chk3_score = chk3_score;
    }
    public String getChk4_score()
    {
        return chk4_score;
    }
    public void setChk4_score(String chk4_score)
    {
        this.chk4_score = chk4_score;
    }
    public String getChk5_score()
    {
        return chk5_score;
    }
    public void setChk5_score(String chk5_score)
    {
        this.chk5_score = chk5_score;
    }
    public String getComm()
    {
        return comm;
    }
    public void setComm(String comm)
    {
        this.comm = comm;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getNewdate()
    {
        return newdate;
    }
    public void setNewdate(String newdate)
    {
        this.newdate = newdate;
    }
    public String getNewname()
    {
        return newname;
    }
    public void setNewname(String newname)
    {
        this.newname = newname;
    }
    public String getNewuser()
    {
        return newuser;
    }
    public void setNewuser(String newuser)
    {
        this.newuser = newuser;
    }
    public String getPurempno()
    {
        return purempno;
    }
    public void setPurempno(String purempno)
    {
        this.purempno = purempno;
    }
    public String getPurname()
    {
        return purname;
    }
    public void setPurname(String purname)
    {
        this.purname = purname;
    }
    public String getPursern()
    {
        return pursern;
    }
    public void setPursern(String pursern)
    {
        this.pursern = pursern;
    }
    public String getTtlscore()
    {
        return ttlscore;
    }
    public void setTtlscore(String ttlscore)
    {
        this.ttlscore = ttlscore;
    }
}
