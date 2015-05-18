package eg.interview;

import java.util.*;

/**
 * @author CS71 Created on  2011/1/14
 */
public class InterviewObj
{
    private String interview_no  	="";
    private String empno  			="";
    private String sern				="";
    private String cname			="";
    private String grp			    ="";
    private String jobno			="";
    private String base				="";
    private String interview_date  	="";
    private String fltd   			="";
    private String fltno   			="";
    private String sect   			="";
    private String main_item  		="";
    private String main_item_desc	="";
    private String sub_item     	="";
    private String sub_item_desc   	="";
    private String subject       	="";
    private String crew_desc       	="";
    private String manager_desc     ="";
    private String suggestion       ="";
    private String new_user         ="";
    private String new_date         ="";
    private String upd_user         ="";
    private String upd_date         ="";
    private String close_user       ="";
    private String close_date       ="";
    private String if_notice        ="";
    private String acknowledge_tmst ="";	
    ArrayList suggestionAL = new ArrayList();
    ArrayList attachAL = new ArrayList();       
    
    
    public String getBase()
    {
        return base;
    }
    public void setBase(String base)
    {
        this.base = base;
    }
    public String getUpd_date()
    {
        return upd_date;
    }
    public void setUpd_date(String upd_date)
    {
        this.upd_date = upd_date;
    }
    public String getUpd_user()
    {
        return upd_user;
    }
    public void setUpd_user(String upd_user)
    {
        this.upd_user = upd_user;
    }
    public String getNew_date()
    {
        return new_date;
    }
    public void setNew_date(String new_date)
    {
        this.new_date = new_date;
    }
    public String getNew_user()
    {
        return new_user;
    }
    public void setNew_user(String new_user)
    {
        this.new_user = new_user;
    }
    public String getMain_item_desc()
    {
        return main_item_desc;
    }
    public void setMain_item_desc(String main_item_desc)
    {
        this.main_item_desc = main_item_desc;
    }
    public String getSub_item_desc()
    {
        return sub_item_desc;
    }
    public void setSub_item_desc(String sub_item_desc)
    {
        this.sub_item_desc = sub_item_desc;
    }
    public ArrayList getAttachAL()
    {
        return attachAL;
    }
    public void setAttachAL(ArrayList attachAL)
    {
        this.attachAL = attachAL;
    }
    public ArrayList getSuggestionAL()
    {
        return suggestionAL;
    }
    public void setSuggestionAL(ArrayList suggestionAL)
    {
        this.suggestionAL = suggestionAL;
    }
    public String getAcknowledge_tmst()
    {
        return acknowledge_tmst;
    }
    public void setAcknowledge_tmst(String acknowledge_tmst)
    {
        this.acknowledge_tmst = acknowledge_tmst;
    }
    public String getClose_date()
    {
        return close_date;
    }
    public void setClose_date(String close_date)
    {
        this.close_date = close_date;
    }
    public String getClose_user()
    {
        return close_user;
    }
    public void setClose_user(String close_user)
    {
        this.close_user = close_user;
    }
    public String getCname()
    {
        return cname;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
    }
    public String getCrew_desc()
    {
        return crew_desc;
    }
    public void setCrew_desc(String crew_desc)
    {
        this.crew_desc = crew_desc;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getFltd()
    {
        return fltd;
    }
    public void setFltd(String fltd)
    {
        this.fltd = fltd;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getGrp()
    {
        return grp;
    }
    public void setGrp(String grp)
    {
        this.grp = grp;
    }
    public String getIf_notice()
    {
        return if_notice;
    }
    public void setIf_notice(String if_notice)
    {
        this.if_notice = if_notice;
    }
    public String getInterview_date()
    {
        return interview_date;
    }
    public void setInterview_date(String interview_date)
    {
        this.interview_date = interview_date;
    }
    public String getInterview_no()
    {
        return interview_no;
    }
    public void setInterview_no(String interview_no)
    {
        this.interview_no = interview_no;
    }
    public String getJobno()
    {
        return jobno;
    }
    public void setJobno(String jobno)
    {
        this.jobno = jobno;
    }
    public String getMain_item()
    {
        return main_item;
    }
    public void setMain_item(String main_item)
    {
        this.main_item = main_item;
    }
    public String getManager_desc()
    {
        return manager_desc;
    }
    public void setManager_desc(String manager_desc)
    {
        this.manager_desc = manager_desc;
    }
    public String getSect()
    {
        return sect;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getSub_item()
    {
        return sub_item;
    }
    public void setSub_item(String sub_item)
    {
        this.sub_item = sub_item;
    }
    public String getSubject()
    {
        return subject;
    }
    public void setSubject(String subject)
    {
        this.subject = subject;
    }
    public String getSuggestion()
    {
        return suggestion;
    }
    public void setSuggestion(String suggestion)
    {
        this.suggestion = suggestion;
    }
}
