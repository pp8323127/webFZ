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
    
    private swap3ac.CrewInfoObj aCrewInfoObj = null; //�ӽЪ̪��խ��ӤH���
    private swap3ac.CrewInfoObj rCrewInfoObj = null;//�Q���̪��խ��ӤH���
    private swap3ackhh.CrewInfoObj aCrewInfo2Obj = null; //�ӽЪ̪��խ��ӤH���
    private swap3ackhh.CrewInfoObj rCrewInfo2Obj = null;//�Q���̪��խ��ӤH���
    
    private ArrayList aCrewSkjAL = null;//�ӽЪ̪��Z��
    private ArrayList rCrewSkjAL = null; //�Q���̪��Z��
    private ArrayList commItemAL = null;
    private int workingDay;// �u�@�Ѽ�
  
    
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
