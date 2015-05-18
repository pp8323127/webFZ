package fsrpt;

/**
 * @author CS71 Created on  2010/9/16
 */
public class FSRptObj
{
    private String seq          			= "";
    private String rpt_subject 				= "";
    private String rpt_desc	 	 			= "";
    private String potential_consequence	= "";
    private String reply_request		 	= "";
    private String event_date	     		= "";
    private String carrier		 			= "";
    private String fltno		 			= "";
    private String sect 	 				= "";
    private String actype 	     			= "";
    private String acno 	     			= "";
    private String new_user 	 			= "";
    private String new_user_sern 			= "";
    private String new_user_name 			= "";
    private String new_date 	    		= "";
    private String sent_date	 			= "";
    private String chg_user 				= "";
    private String chg_date		 	 		= "";
    private String close_user		 		= "";
    private String close_date	 	 		= "";
    private String flag						= "";
    
    
    public String getCarrier()
    {
        return carrier;
    }
    public void setCarrier(String carrier)
    {
        this.carrier = carrier;
    }
    public String getNew_user_sern()
    {
        return new_user_sern;
    }
    public void setNew_user_sern(String new_user_sern)
    {
        this.new_user_sern = new_user_sern;
    }
    public String getFlag()
    {
        return flag;
    }
    public void setFlag(String flag)
    {
        this.flag = flag;
    }
    public String getAcno()
    {
        return acno;
    }
    public void setAcno(String acno)
    {
        this.acno = acno;
    }
    public String getActype()
    {
        return actype;
    }
    public void setActype(String actype)
    {
        this.actype = actype;
    }
    public String getChg_date()
    {
        return chg_date;
    }
    public void setChg_date(String chg_date)
    {
        this.chg_date = chg_date;
    }
    public String getChg_user()
    {
        return chg_user;
    }
    public void setChg_user(String chg_user)
    {
        this.chg_user = chg_user;
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
    public String getEvent_date()
    {
        return event_date;
    }
    public void setEvent_date(String event_date)
    {
        this.event_date = event_date;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
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
    public String getNew_user_name()
    {
        return new_user_name;
    }
    public void setNew_user_name(String new_user_name)
    {
        this.new_user_name = new_user_name;
    }
    public String getPotential_consequence()
    {
        return potential_consequence;
    }
    public void setPotential_consequence(String potential_consequence)
    {
        this.potential_consequence = potential_consequence;
    }
    public String getReply_request()
    {
        return reply_request;
    }
    public void setReply_request(String reply_request)
    {
        this.reply_request = reply_request;
    }
    public String getRpt_desc()
    {
        return rpt_desc;
    }
    public void setRpt_desc(String rpt_desc)
    {
        this.rpt_desc = rpt_desc;
    }
    public String getRpt_subject()
    {
        return rpt_subject;
    }
    public void setRpt_subject(String rpt_subject)
    {
        this.rpt_subject = rpt_subject;
    }
    public String getSect()
    {
        return sect;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public String getSent_date()
    {
        return sent_date;
    }
    public void setSent_date(String sent_date)
    {
        this.sent_date = sent_date;
    }
    public String getSeq()
    {
        return seq;
    }
    public void setSeq(String seq)
    {
        this.seq = seq;
    }
}
