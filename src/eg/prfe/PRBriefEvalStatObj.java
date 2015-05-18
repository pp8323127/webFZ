package eg.prfe;

import java.util.*;

/**
 * @author cs71 Created on  2009/6/18
 */
public class PRBriefEvalStatObj
{
    private String purempno = "";
    private String pursern = "";
    private String purname = "";
    private String purgrp = "";
    private String base = "";
    private Hashtable myHT = new Hashtable();
    private String score_str = "";
    private int chk_times = 0;    
     
    
    public String getPurgrp()
    {
        return purgrp;
    }
    public void setPurgrp(String purgrp)
    {
        this.purgrp = purgrp;
    }
    public String getBase()
    {
        return base;
    }
    public void setBase(String base)
    {
        this.base = base;
    }
    public int getChk_times()
    {
        return chk_times;
    }
    public void setChk_times(int chk_times)
    {
        this.chk_times = chk_times;
    }
    public Hashtable getMyHT()
    {
        return myHT;
    }
    public void setMyHT(Hashtable myHT)
    {
        this.myHT = myHT;
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
    public String getScore_str()
    {
        return score_str;
    }
    public void setScore_str(String score_str)
    {
        this.score_str = score_str;
    }
}
