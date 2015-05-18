package ws.off;

import java.util.*;
import eg.*;

import ws.*;
import ws.crew.*;

public class CrewALRObj extends CrewMsgObj
{
    private ArrayList offsAL = null;// OffsObj
    private ArrayList ALperiodAL = null; //ALPeriodObj
    private CrewBasicObj egInfo = null; //
    private int undeduct = 0;//³Ñ¾l¤Ñ¼Æ
    private ArrayList offType = null;// OffTypeObj
    private String msg = "";
    
    public ArrayList getOffsAL()
    {
        return offsAL;
    }
    public void setOffsAL(ArrayList offsAL)
    {
        this.offsAL = offsAL;
    }
    
    public ArrayList getALperiodAL()
    {
        return ALperiodAL;
    }
    public void setALperiodAL(ArrayList aLperiodAL)
    {
        ALperiodAL = aLperiodAL;
    }

    public CrewBasicObj getEgInfo()
    {
        return egInfo;
    }
    public void setEgInfo(CrewBasicObj egInfo)
    {
        this.egInfo = egInfo;
    }
    public int getUndeduct()
    {
        return undeduct;
    }
    public void setUndeduct(int undeduct)
    {
        this.undeduct = undeduct;
    }
    public ArrayList getOffType()
    {
        return offType;
    }
    public void setOffType(ArrayList offType)
    {
        this.offType = offType;
    }
    public String getMsg()
    {
        return msg;
    }
    public void setMsg(String msg)
    {
        this.msg = msg;
    }
    
    
}
