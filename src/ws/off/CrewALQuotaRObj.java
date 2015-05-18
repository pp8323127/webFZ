package ws.off;

import eg.off.quota.*;
import ws.*;

public class CrewALQuotaRObj extends CrewMsgObj
{
    
    private ALQuotaObj[] quotaArr= null; //ALQuotaObj
//    private ArrayList quotaAL = null;
    private String msg = "";
    
    public ALQuotaObj[] getQuotaArr()
    {
        return quotaArr;
    }
    public void setQuotaArr(ALQuotaObj[] quotaArr)
    {
        this.quotaArr = quotaArr;
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
