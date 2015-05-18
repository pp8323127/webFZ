package eg.zcrpt;

import java.util.*;

/**
 * @author cs71 Created on  2009/10/8
 */
public class ZCFltIrrItemObj
{
    private String seqkey = "";
    private String seqno = "";
    private String fltd = ""; 
    private String fltno = "";
    private String sect = ""; 
    private String acno ="";
    private String psrname = "";
    private String psrsern = "";
    private String psrempn = "";
    private String itemno = "";
    private String itemdsc = "";
    private String itemdsc2 = "";
    private String comments = "";
    private String flag = "";
    private String itemclose = "";
    private String itemclose_date = "";  
    ArrayList itemhandleobjAL = new ArrayList();       
    
    public ArrayList getItemhandleobjAL()
    {
        return itemhandleobjAL;
    }
    public void setItemhandleobjAL(ArrayList itemhandleobjAL)
    {
        this.itemhandleobjAL = itemhandleobjAL;
    }
    public String getItemclose()
    {
        return itemclose;
    }
    public void setItemclose(String itemclose)
    {
        this.itemclose = itemclose;
    }
    public String getItemclose_date()
    {
        return itemclose_date;
    }
    public void setItemclose_date(String itemclose_date)
    {
        this.itemclose_date = itemclose_date;
    }
    public String getSeqkey()
    {
        return seqkey;
    }
    public void setSeqkey(String seqkey)
    {
        this.seqkey = seqkey;
    }
    public String getItemdsc2()
    {
        return itemdsc2;
    }
    public void setItemdsc2(String itemdsc2)
    {
        this.itemdsc2 = itemdsc2;
    }
    public String getAcno()
    {
        return acno;
    }
    public void setAcno(String acno)
    {
        this.acno = acno;
    }
    public String getComments()
    {
        return comments;
    }
    public void setComments(String comments)
    {
        this.comments = comments;
    }
    public String getFlag()
    {
        return flag;
    }
    public void setFlag(String flag)
    {
        this.flag = flag;
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
    public String getItemdsc()
    {
        return itemdsc;
    }
    public void setItemdsc(String itemdsc)
    {
        this.itemdsc = itemdsc;
    }
    public String getItemno()
    {
        return itemno;
    }
    public void setItemno(String itemno)
    {
        this.itemno = itemno;
    }
    public String getPsrempn()
    {
        return psrempn;
    }
    public void setPsrempn(String psrempn)
    {
        this.psrempn = psrempn;
    }
    public String getPsrname()
    {
        return psrname;
    }
    public void setPsrname(String psrname)
    {
        this.psrname = psrname;
    }
    public String getPsrsern()
    {
        return psrsern;
    }
    public void setPsrsern(String psrsern)
    {
        this.psrsern = psrsern;
    }
    public String getSect()
    {
        return sect;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public String getSeqno()
    {
        return seqno;
    }
    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }
}
