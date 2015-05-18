package ws;

import java.util.*;

/**
 * @author 640790 Created on  2013/8/20
 */
public class saveReportChkrdmObj
{

    public static void main(String[] args)
    {
    }    
    private String fltd 			  = "";
    private String fltno              = "";
    private String sector             = "";
    private String psrempn            = "";
    private String seqno              = "";
    private String checkseqno         = "";  
    private String executestatus      = "";
    private String evalstatus         = "";
    private String comments		  	  = "";   
    
    private saveReportChkrddObj[] rddAL = null; 
    
    
    public saveReportChkrddObj[] getRddAL()
    {
        return rddAL;
    }
    public void setRddAL(saveReportChkrddObj[] rddAL)
    {
        this.rddAL = rddAL;
    }
    public String getCheckseqno()
    {
        return checkseqno;
    }
    public String getComments()
    {
        return comments;
    }
    public String getEvalstatus()
    {
        return evalstatus;
    }
    public String getExecutestatus()
    {
        return executestatus;
    }
    public String getFltd()
    {
        return fltd;
    }
    public String getFltno()
    {
        return fltno;
    }
    public String getPsrempn()
    {
        return psrempn;
    }
    public String getSector()
    {
        return sector;
    }
    public String getSeqno()
    {
        return seqno;
    }
    public void setCheckseqno(String checkseqno)
    {
        this.checkseqno = checkseqno;
    }
    public void setComments(String comments)
    {
        this.comments = comments;
    }
    public void setEvalstatus(String evalstatus)
    {
        this.evalstatus = evalstatus;
    }
    public void setExecutestatus(String executestatus)
    {
        this.executestatus = executestatus;
    }
    public void setFltd(String fltd)
    {
        this.fltd = fltd;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public void setPsrempn(String psrempn)
    {
        this.psrempn = psrempn;
    }
    public void setSector(String sector)
    {
        this.sector = sector;
    }
    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }
}
