package fz.psfly;

import ws.prac.SFLY.MP.MPsflySelfCrewObj;

public class PSFlySelfInsObj {
	private String sernno = null;
    private String itemno = null;
    private String tcrew = null;
    private String correct = null;
    private String incomplete = null;
    private String acomm = null;
    private String upduser = null;
    private String upddate = null;
    private String itemno_rm = null;
    private String subject = null;
    
    private MPsflySelfCrewObj[] crew = null;
    
    
    
    public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSernno()
    {
        return sernno;
    }
    public void setSernno(String sernno)
    {
        this.sernno = sernno;
    }
    public String getItemno()
    {
        return itemno;
    }
    public void setItemno(String itemno)
    {
        this.itemno = itemno;
    }
    public String getCorrect()
    {
        return correct;
    }
    public void setCorrect(String correct)
    {
        this.correct = correct;
    }
    public String getIncomplete()
    {
        return incomplete;
    }
    public void setIncomplete(String incomplete)
    {
        this.incomplete = incomplete;
    }
    public String getAcomm()
    {
        return acomm;
    }
    public void setAcomm(String acomm)
    {
        this.acomm = acomm;
    }
    public String getUpduser()
    {
        return upduser;
    }
    public void setUpduser(String upduser)
    {
        this.upduser = upduser;
    }
    public String getUpddate()
    {
        return upddate;
    }
    public void setUpddate(String upddate)
    {
        this.upddate = upddate;
    }
    public String getItemno_rm()
    {
        return itemno_rm;
    }
    public void setItemno_rm(String itemno_rm)
    {
        this.itemno_rm = itemno_rm;
    }
    public MPsflySelfCrewObj[] getCrew()
    {
        return crew;
    }
    public void setCrew(MPsflySelfCrewObj[] crew)
    {
        this.crew = crew;
    }
    public String getTcrew()
    {
        return tcrew;
    }
    public void setTcrew(String tcrew)
    {
        this.tcrew = tcrew;
    }

}
