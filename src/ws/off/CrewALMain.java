package ws.off;

import java.text.*;
import java.util.*;

import eg.off.*;
import ws.*;
import ws.crew.*;
import ws.header.*;

public class CrewALMain
{

    /**
     * @param args
     * 1.個人AL記錄
     * 2.AL總quota
     * 3.送出AL申請
     * 4.查詢假單選項
     * 5.查詢假單
     * 6.刪除AL
     */
//    public static void main(String[] args)
//    {
//        // TODO Auto-generated method stub
//        CrewALMain main = new CrewALMain();
//        main.QueryoffsList("", "");
//
//    }
    //1.個人AL記錄
    private SimpleDateFormat ft = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    private String startTime = null;
    private String endTime = null;

    
    public CrewALRObj HistoryListOfAL(String empno, String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewALFun crewObj = new CrewALFun();
        if (wsAuth)
        {
            crewObj.ListOfAL(empno);
        }
        else
        {
            crewObj.setCrewALAL(new CrewALRObj());
            crewObj.getCrewALAL().setResultMsg("0");
            crewObj.getCrewALAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewALAL();
    }
   
    //2.AL總quota
    public CrewALQuotaRObj QuotaListOfAL(String jobtype,String year,String month, String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewALFun crewObj = new CrewALFun();
        if (wsAuth)
        {
            crewObj.ListALquota(jobtype, year, month);
        }
        else
        {
            crewObj.setCrewQuotaAL(new CrewALQuotaRObj());
            crewObj.getCrewQuotaAL().setResultMsg("0");
            crewObj.getCrewQuotaAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewQuotaAL();
    }
    
    //3.送出AL申請
    public CrewMsgObj SendALRequest(String off_type,String empno,String[] offsdate,String[] offedate,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewMsgObj sendObj = new CrewMsgObj();
        if(wsAuth){
            CrewALFun obj = new CrewALFun();            
            sendObj = obj.sendAL(off_type, empno, offsdate, offedate);
        }else{
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg("No Auth");
        }
        return sendObj;
    }
    
    //4.查詢假單選項
    public ArrayList<OffTypeObj> QueryoffsList(String time,String sysPwd){
        ArrayList<OffTypeObj> objAL = new ArrayList<OffTypeObj>();
        boolean flag =false;
        if(null == time || "".equals(time) || !(10 == time.length())){ //yyyy/mm/dd 
            flag = true;
        }else if (null != time && "".equals(time)){
            GregorianCalendar cal1 = new GregorianCalendar();//app更新日
            int year = Integer.parseInt(time.substring(0, 4));
            int mm = Integer.parseInt(time.substring(5, 7));
            int dd = Integer.parseInt(time.substring(8, 10));
            cal1.set(1, year);
            cal1.set(2, mm-1);
            cal1.set(5, dd);
            cal1.set(10, 0);
            cal1.set(12, 0);
            cal1.set(13, 0);
            GregorianCalendar cal2 = new GregorianCalendar();//生效日
            cal2.set(1, 2014);
            cal2.set(2, 12-1);
            cal2.set(5, 1);
            cal2.set(10, 0);
            cal2.set(12, 0);
            cal2.set(13, 0);
            
            if (cal1.after(cal2) || cal1.equals(cal2))
            {
                flag = false;           
            }
            else 
            {
                flag = true;    
            }
        }        
        
        if(flag){                        
            OffTypeObj obj = new OffTypeObj();
            obj.setOffcode("");
            obj.setOffdesc("AL/XL/LVE/LSW/OL");
            obj.setOfftype("1");
            objAL.add(obj);
            obj = new OffTypeObj();
            obj.setOffcode("");
            obj.setOffdesc("SL/PL/CL/EL/FCL/HNSL/HNEL/HNCL/HNI/CNSL/CNCL");
            obj.setOfftype("2");
            objAL.add(obj);
            obj = new OffTypeObj();
            obj.setOffcode("");
            obj.setOffdesc("Others");
            obj.setOfftype("3");
            objAL.add(obj);
        }else{
            objAL = null;
        }
        return objAL;
    }
    
    //5.查詢假單
    public CrewOffListRObj OffHistoryList(String year,String empno,String type, String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewALFun crewObj = new CrewALFun();
        if (wsAuth)
        {
            crewObj.OffsList(year, empno, type);
        }
        else
        {
            crewObj.setCrewQuotaAL(new CrewALQuotaRObj());
            crewObj.getCrewQuotaAL().setResultMsg("0");
            crewObj.getCrewQuotaAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewOffsAL();
    }

    //6.刪除AL
    public CrewMsgObj DelALFromApp(String[] checkdel,String empno,String offyear, String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewMsgObj sendObj = new CrewMsgObj();
        if(wsAuth){
            CrewALFun obj = new CrewALFun();            
            sendObj = obj.DelAL(checkdel, empno, offyear);
        }else{
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg("No Auth");
        }
        return sendObj;
    }
}
