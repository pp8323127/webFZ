package ws.crew;

import ws.*;
import ws.header.*;
import credit.*;
import fzAuthP.*;

public class CrewSchMain
{

    /**
     * @param args
     */
    

    // public static void main(String[] args)
    // {
    // // TODO Auto-generated method stub
    //
    // }
    // 0.Eip & FZT �ҥi�n�J
    public LoginAppBObj AuthenticationBoth(String userid, String password,
            String sysPwd)
    {
        boolean wsAuth = true;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewLogin cl = new CrewLogin();
        if (wsAuth)
        {
        	cl.LoginiCrew(userid, password);
        }
        else
        {
            cl.setAuth(new LoginAppBObj());
            cl.getAuth().setCode("0");
            cl.getAuth().setMessage("Login - ws Auth failed.");
            cl.getAuth().setResult(false);
        }
        return cl.getAuth();
    }
    
    // 1. ���o3���Z��
    public CrewSwapRObj CrewSwapSkj(String aEmpno, String rEmpno, String yyyy,
            String mm, String sysPwd)
    {
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.SwapSkj(aEmpno, rEmpno, yyyy, mm);
        }
        else
        {
            crewObj.setCrewSpObjAL(new CrewSwapCreditRObj());
            crewObj.getCrewSpObjAL().setResultMsg("0");
            crewObj.getCrewSpObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewSpObjAL();

    }

    // 2. ���o�n�I�Z��
    public CrewSwapCreditRObj CrewSwapSkjCredit(String aEmpno, String rEmpno,
            String yyyy, String mm, String sysPwd)
    {
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.SwapCredit(aEmpno, rEmpno, yyyy, mm);
        }
        else
        {
            crewObj.setCrewCtObjAL(new CrewSwapCreditRObj());
            crewObj.getCrewCtObjAL().setResultMsg("0");
            crewObj.getCrewCtObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewCtObjAL();

    }

    // 3. 3�������T�{
    public CrewSwapDetailRObj CrewSwapDetail(String aEmpno, String rEmpno,
            String yyyy, String mm, String[] aChoSwapSkj, String[] rChoSwapSkj,
            String sysPwd)
    // (String year ,String month ,CrewInfoObj aCrewInfoObj,CrewInfoObj
    // rCrewInfoObj,
    // ArrayList aCrewSkjAL , ArrayList rCrewSkjAL ,String[]
    // aChoSwapSkj,String[] rChoSwapSkj,String sysPwd)
    {
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.SwapDetail(aEmpno, rEmpno, yyyy, mm, aChoSwapSkj,
                    rChoSwapSkj);
            // crewObj.SwapDetail(year, month, aCrewInfoObj, rCrewInfoObj,
            // aCrewSkjAL, rCrewSkjAL, aChoSwapSkj, rChoSwapSkj);
        }
        else
        {
            crewObj.setCrewSpDetailObjAL(new CrewSwapDetailRObj());
            crewObj.getCrewSpDetailObjAL().setResultMsg("0");
            crewObj.getCrewSpDetailObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewSpDetailObjAL();

    }

    // 4. �n�I�����T�{
    public CrewSwapCreditDetailRObj CrewSwapCreditDetail(String aEmpno,
            String rEmpno, String yyyy, String mm, String[] aChoSwapSkj,
            String[] rChoSwapSkj, String sysPwd)
    {
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.SwapCreditDetail(aEmpno, rEmpno, yyyy, mm, aChoSwapSkj,
                    rChoSwapSkj);
        }
        else
        {
            crewObj.setCrewCtDetailObjAL(new CrewSwapCreditDetailRObj());
            crewObj.getCrewCtDetailObjAL().setResultMsg("0");
            crewObj.getCrewCtDetailObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewCtDetailObjAL();

    }
    
    //5. ����ӽг�
    public CrewMsgObj SendSwapForm(SendCrewSwapFormObj swapFormAr,String type,String asno,String rsno,String sysPwd){
        int typeNum = 0;
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewMsgObj sendObj = new CrewMsgObj();
        if(wsAuth){
            if(null != swapFormAr && !"".equals(swapFormAr) && null != type && !"".equals(type) ){
            try{
                typeNum = Integer.parseInt(type);
                String rcount = "";
                String rcomm = "";            
                SendCrewSwap swap = new SendCrewSwap();
                switch (typeNum)
                {   
                    case 1:
//                      TPE �T��       
                        sendObj = swap.SendSwapFormTPE(swapFormAr);
                        break;
                    case 2:
//                      KHH �T��
                        sendObj = swap.SendSwapFormTPE(swapFormAr);
                        break;
                    case 3:
                        if(!"0".equals(asno)){                
//                      TPE aCrew&rCrew �ҥοn�I        
                            rcount= "N";
                            rcomm = rsno;
                            sendObj = swap.SendSwapCreditFormTPE(swapFormAr, asno, rsno, rcount, rcomm);
                        }else{
                            sendObj.setResultMsg("0");
                            sendObj.setErrorMsg("aEmpno �n�I�L��");
                        }                      
                        break;
                    case 4:
                        if(!"0".equals(asno)){ 
//                      TPE aCrew�οn�I & rCrew�T��
                            rsno = "0";
                            sendObj = swap.SendSwapCreditFormTPE(swapFormAr, asno, rsno, rcount, rcomm);
                        }else{
                            sendObj.setResultMsg("0");
                            sendObj.setErrorMsg("aEmpno �n�I�L��");
                        }
                        break;
                    case 5:
                        if(!"0".equals(asno)){ 
//                      KHH aCrew&rCrew �ҥοn�I
                            sendObj = swap.SendSwapCreditFormKHH(swapFormAr, asno, rsno, rcount, rcomm);
                        }else{
                            sendObj.setResultMsg("0");
                            sendObj.setErrorMsg("aEmpno �n�I�L��");
                        }
                        break;               
                    default:
                        sendObj.setResultMsg("0");
                        sendObj.setErrorMsg("Not correct type.");
                        break;
                }
            
            }catch ( Exception e ){
                sendObj.setResultMsg("0");
                sendObj.setErrorMsg("aEmpno �n�I�L��"+e.toString());
            }
            }else{
                sendObj.setResultMsg("0");
                sendObj.setErrorMsg("Input Info error.");
            }
        }else{
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg("No Auth");
        }
        return sendObj;        
    }
    
    //6. �n�I��Z���
    public CrewPickCreditRObj PickCreditAvbList(String empno,String yyyy,String mm,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewPickFun crewObj = new CrewPickFun();
        if(wsAuth){
            crewObj.ChkPickCtInfo(empno, yyyy, mm);
        }else{
            crewObj.setPickCtObjAL(new CrewPickCreditRObj());
            crewObj.getPickCtObjAL().setResultMsg("0");
            crewObj.getPickCtObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getPickCtObjAL();
    }
    
    //7. ���Կ�Z���
    public CrewPickFullAttRObj PickAttAvbList(String empno,String yyyy,String mm,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewPickFun crewObj = new CrewPickFun();
        if(wsAuth){
            crewObj.ChkPickAttInfo(empno, yyyy, mm);
        }else{
            crewObj.setPickAttObjAL(new CrewPickFullAttRObj());
            crewObj.getPickAttObjAL().setResultMsg("0");
            crewObj.getPickAttObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getPickAttObjAL();
    }
   
    //8. �����Z�� ,base 1:TPE,2:KHH
    public CrewMsgObj SendPickCtForm(String[] chkItem,String empno,String base,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewMsgObj sendObj = new CrewMsgObj();
        if(wsAuth){
            CrewPickFun obj = new CrewPickFun();            
            sendObj = obj.SendPickCtForm(chkItem, empno, base);
        }else{
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg("No Auth");
        }
        return sendObj;
    }
    
    //9. ������Կ�Z��  ,base 1:TPE,2:KHH
    public CrewMsgObj SendPickAttForm(String[] chkItem,FullAttendanceForPickSkjObj[] CrewAttAr,String base,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewMsgObj sendObj = new CrewMsgObj();
        if(wsAuth){
            CrewPickFun obj = new CrewPickFun();            
            sendObj = obj.SendPickAttForm(chkItem, CrewAttAr, base);
        }else{
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg("No Auth");
        }
        return sendObj;
    }

    //10.�պ�Z��
    public CrewCorssCrRObj CrewCorssSkj(String aEmpno, String rEmpno,String yyyy,String mm,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.CorssCrSkj(aEmpno, rEmpno, yyyy, mm);
        }
        else
        {
            crewObj.setCrewCorssObjAL(new CrewCorssCrRObj());
            crewObj.getCrewCorssObjAL().setResultMsg("0");
            crewObj.getCrewCorssObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewCorssObjAL();
        
    }
   
    //11.�պ⵲�G
    public CrewCorssDetailRObj CrewCorssDetail(String aEmpno,String rEmpno, String yyyy, String mm, String[] aChoSwapSkj,
            String[] rChoSwapSkj, String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.CorssCrDetail(aEmpno, rEmpno, yyyy, mm, aChoSwapSkj, rChoSwapSkj);
        }
        else
        {
            crewObj.setCrewCrossDetailObjAL(new CrewCorssDetailRObj());
            crewObj.getCrewCrossDetailObjAL().setResultMsg("0");
            crewObj.getCrewCrossDetailObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getCrewCrossDetailObjAL();
        
    }

    //12. ���Z�ӽг�d��
    public SwapRdRObj CrewSwapRecord(String year, String empno,String base,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.SwapRdList(year, empno, base);
        }
        else
        {
            crewObj.setCrewCrossDetailObjAL(new CrewCorssDetailRObj());
            crewObj.getCrewCrossDetailObjAL().setResultMsg("0");
            crewObj.getCrewCrossDetailObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getSwapRdObjAL();
    }
    
    //13. ��Z�ӽйw��  & ��Z�h/��w���C��
    public CrewPickApplyListRObj PickApplyList(String empno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewPickFun crewObj = new CrewPickFun();
        if (wsAuth)
        {
            crewObj.PickApplyList(empno);
        }
        else
        {
            crewObj.setPickListObjAL(new CrewPickApplyListRObj());
            crewObj.getPickListObjAL().setResultMsg("0");
            crewObj.getPickListObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getPickListObjAL();
    }
   
    //14. ���o����
    public CrewPickApplyNumRObj PickApplyNum(String empno,String base,String sno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewPickFun crewObj = new CrewPickFun();
        if (wsAuth)
        {
            crewObj.PickApplyNum(empno, base, sno);
        }
        else
        {
            crewObj.setPickNumObjAL(new CrewPickApplyNumRObj());
            crewObj.getPickNumObjAL().setResultMsg("0");
            crewObj.getPickNumObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getPickNumObjAL();
    }
    
    //15. �B�z��Z�d�߶i��
    public CrewPickProcessRObj PocessPickQuery(String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewPickFun crewObj = new CrewPickFun();
        if (wsAuth)
        {
            crewObj.PocessPickQuery();
        }
        else
        {
            crewObj.setProcPickObjAL(new CrewPickProcessRObj());
            crewObj.getProcPickObjAL().setResultMsg("0");
            crewObj.getProcPickObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getProcPickObjAL();
    }
    
    //16. ������
    public StatusObj ChkSwapMonth(String aEmpno, String rEmpno, String yyyy, String mm, String sysPwd)
    {
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        StatusObj statusObj = new StatusObj();
        if (wsAuth)
        {
            statusObj = crewObj.ChkMonth(aEmpno, rEmpno, yyyy, mm);
        }
        else
        {
            statusObj.setStatus(0);
            statusObj.setErrMsg("No Auth");
        }
        return statusObj;
    }
   
    //17.���Z&���ɸպ� tripno detail
    public TripInfoRObj TripNoDetail(String tripno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        CrewSwapFun crewObj = new CrewSwapFun();
        if (wsAuth)
        {
            crewObj.SwapTripDetail(tripno);
            
        }
        else
        {   
            crewObj.setTripObjAL(new TripInfoRObj());
            crewObj.getTripObjAL().setResultMsg("0");
            crewObj.getTripObjAL().setErrorMsg("No Auth");
        }
        return crewObj.getTripObjAL();
    }
}
