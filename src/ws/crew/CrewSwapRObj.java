package ws.crew;

import java.util.*;

import swap3ac.*;
public class CrewSwapRObj
{

    /**
     * @param args
     */
    private String errorMsg = null;
    private String resultMsg = null;
    
    private swap3ac.CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
    private swap3ac.CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料
    private swap3ackhh.CrewInfoObj aCrewInfo2Obj = null; //申請者的組員個人資料
    private swap3ackhh.CrewInfoObj rCrewInfo2Obj = null;//被換者的組員個人資料
    
    private ArrayList aCrewSkjAL = null;//申請者的班表
    private ArrayList rCrewSkjAL = null; //被換者的班表
    private ArrayList commItemAL = null;
    private int workingDay;// 工作天數
  
    
    public String getErrorMsg()
    {
        return errorMsg;
    }
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
    public String getResultMsg()
    {
        return resultMsg;
    }
    public void setResultMsg(String resultMsg)
    {
        this.resultMsg = resultMsg;
    }
    
    public CrewInfoObj getaCrewInfoObj()
    {
        return aCrewInfoObj;
    }
    public void setaCrewInfoObj(CrewInfoObj aCrewInfoObj)
    {
        this.aCrewInfoObj = aCrewInfoObj;
    }
    public CrewInfoObj getrCrewInfoObj()
    {
        return rCrewInfoObj;
    }
    public void setrCrewInfoObj(CrewInfoObj rCrewInfoObj)
    {
        this.rCrewInfoObj = rCrewInfoObj;
    }
    public ArrayList getaCrewSkjAL()
    {
        return aCrewSkjAL;
    }
    public void setaCrewSkjAL(ArrayList aCrewSkjAL)
    {
        this.aCrewSkjAL = aCrewSkjAL;
    }
    public ArrayList getrCrewSkjAL()
    {
        return rCrewSkjAL;
    }
    public void setrCrewSkjAL(ArrayList rCrewSkjAL)
    {
        this.rCrewSkjAL = rCrewSkjAL;
    }
    public ArrayList getCommItemAL()
    {
        return commItemAL;
    }
    public void setCommItemAL(ArrayList commItemAL)
    {
        this.commItemAL = commItemAL;
    }
    public int getWorkingDay()
    {
        return workingDay;
    }
    public void setWorkingDay(int workingDay)
    {
        this.workingDay = workingDay;
    }
    public swap3ackhh.CrewInfoObj getaCrewInfo2Obj()
    {
        return aCrewInfo2Obj;
    }
    public void setaCrewInfo2Obj(swap3ackhh.CrewInfoObj aCrewInfo2Obj)
    {
        this.aCrewInfo2Obj = aCrewInfo2Obj;
    }
    public swap3ackhh.CrewInfoObj getrCrewInfo2Obj()
    {
        return rCrewInfo2Obj;
    }
    public void setrCrewInfo2Obj(swap3ackhh.CrewInfoObj rCrewInfo2Obj)
    {
        this.rCrewInfo2Obj = rCrewInfo2Obj;
    }
    
    
}
