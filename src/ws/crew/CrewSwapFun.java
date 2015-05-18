package ws.crew;

import java.sql.*;
import java.util.*;

import ci.db.*;

import swap3ac.*;
import ws.*;

import credit.*;


public class CrewSwapFun
{

    /**
     * @param args.
     * CS 80
     * step0.   �Pbase�~�i�H����.
     * step1.   �W�Z��T�{
     * 
     * step1-1.TPE ���Z��� �ˬd
     * step1-1.KHH ���Z��� �ˬd
     * step1-2. ���o�Z��
     * 
     * step2-1.TPE �n�I���Z��� �ˬd
     * step2-1.KHH �n�I���Z��� �ˬd
     * step2-2. ���o�n�I
     * step2-3. �Z��
     * 
     * type:
     *  3�� TPE:1 
     *  3�� KHH:2
     *  �n�I TPE:3,4
     *  �n�I KHH:5 
     */
    private CrewSwapRObj crewSpObjAL = null;
    private CrewSwapCreditRObj crewCtObjAL = null;
    private CrewSwapDetailRObj crewSpDetailObjAL = null;
    private CrewSwapCreditDetailRObj crewCtDetailObjAL = null;
    private CrewCorssCrRObj crewCorssObjAL = null;
    private CrewCorssDetailRObj crewCrossDetailObjAL = null; 
    private SwapRdRObj swapRdObjAL = null;
    private TripInfoRObj tripObjAL = null;
    
    private int aTimes =0;
    private int rTimes =0;
    private ArrayList objAL = new ArrayList();
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        CrewSwapFun fun = new CrewSwapFun();
        String year = "2014";
        String mm = "12";
        String aE = "636263";
        String rE = "633020";
        String[] aChoSwapSkj = {"4"} ;//idx
        String[] rChoSwapSkj = {"4"} ;
        fun.CorssCrDetail(aE, rE, year, mm, aChoSwapSkj, rChoSwapSkj);
//        fun.SwapSkj(aE,rE,year,mm);
//        CrewInfoObj a = fun.crewSpObjAL.getaCrewInfoObj();
//        CrewInfoObj r =fun.crewSpObjAL.getrCrewInfoObj();
//        ArrayList objAL1 = fun.crewSpObjAL.getaCrewSkjAL();
//        ArrayList objAL2 = fun.crewSpObjAL.getrCrewSkjAL();
//        fun.SwapDetail(year, mm, a, r, objAL1, objAL2, aChoSwapSkj, rChoSwapSkj);
//        fun.ChkCrewBase("636263","633033");
    }
      
    /*step0-1.    �Pbase�~�i�H����*/
    public StatusObj ChkCrewBase(String aEmpno,String rEmpno){
        StatusObj obj = new StatusObj(); 
        if(aEmpno.equals(rEmpno)){
            obj.setStatus(0);
            obj.setErrMsg("���i�P�ۤv���Z.");
        }else{
            fzac.CrewInfo c = new fzac.CrewInfo(aEmpno);
            fzac.CrewInfoObj obja = null;
            if (c.isHasData()) 
            {
                obja = c.getCrewInfo();
            }         
            c = null;
            c = new fzac.CrewInfo(rEmpno);
            fzac.CrewInfoObj objr = null;
            if (c.isHasData()) 
            {
                objr = c.getCrewInfo();
            } 
    
            
            if (obja != null && objr != null && "N".equals(obja.getFd_ind()) && "N".equals(objr.getFd_ind()) ) {
                //���խ��򥻸��,�B���῵�խ�        
                 if (!obja.getBase().equals(objr.getBase())) {
                     obj.setStatus(0);
                     obj.setErrMsg("���o�ӽлP��L Base�խ����Z.");
                }else if ((!"TPE".equals(obja.getBase()) && !"KHH".equals(obja.getBase())) || (!"TPE".equals(objr.getBase()) && !"KHH".equals(objr.getBase()))  ) {
                    obj.setStatus(0);
                    obj.setErrMsg("�|���}��~���խ��ϥδ��Z�\��.");
                }else{
                    if("TPE".equals(obja.getBase()) && "TPE".equals(objr.getBase())){
                        obj.setStatus(1);
                        obj.setErrMsg("TPE");
                    }else if("KHH".equals(obja.getBase()) && "KHH".equals(objr.getBase())){
                        obj.setStatus(2);
                        obj.setErrMsg("KHH");
                    }else{
                        obj.setStatus(0);
                        obj.setErrMsg("Error");
                    }                
                }
            } else {
                if(obja == null || !"N".equals(obja.getFd_ind())){
                    obj.setStatus(0);
                    obj.setErrMsg(aEmpno +" �D���ĭ��u��.");
                }
                if(objr == null || !"N".equals(objr.getFd_ind())){
                    obj.setStatus(0);
                    obj.setErrMsg(rEmpno +" �D���ĭ��u��.");
                }        
            }
        }
        return obj;
    }
      
    /*step0-2.    �W�Z��T�{ */
    public String ChkSwapWorkday(String base,String yyyy,String mm){
        String str = "N";
        //�ˬd�Z��O�_����
        swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
        if(!pc.isPublished()){
            //�Z��O�_����
            str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
        }else{
            if("TPE".equals(base)){
                swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
                ac.SelectDateAndCount();
                if( ac.isLimitedDate()){//�D�u�@��
                    str="�t�Υثe�����z���Z�A�Щ�"+ac.getLimitenddate()+"��}�l����i���]���G1.�Ұ���2.���ƬG(�䭷)";
                }else if( ac.isOverMax()){ //�W�L�B�z�W��
                    str="�w�W�L�t�γ��B�z�W���I�Щ�u�@��16:00�}�l����.";
                }else{
                    str = "Y";
                }
            }else if("KHH".equals(base)) {
                swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
                ac.SelectDateAndCount();
                if(ac.isLimitedDate()){//�D�u�@��
                    str="�t�Υثe�����z���Z�A�Щ�"+ac.getLimitenddate()+"��}�l����i���]���G1.�Ұ���2.���ƬG(�䭷)";
                }else if( ac.isOverMax()){ //�W�L�B�z�W��
                    str="�w�W�L�t�γ��B�z�W���I�Щ�u�@��17:30�}�l����.";
                }else{
                    str = "Y";
                }
            }else{
                str = "BASE���~";
            }
        }       
        return str;
    }
    
    /*step0-3.    �򥻬d�� */
    public StatusObj ChkMonth(String aEmpno,String rEmpno,String yyyy,String mm){
        StatusObj obj = new StatusObj();
        obj = ChkCrewBase(aEmpno, rEmpno);
        if(0!=obj.getStatus()){
            String base = "";
            if(obj.getStatus() == 1){
                base = "TPE";
            }else if(obj.getStatus() == 2){
                base = "KHH";
            }            
            //
            String str = ChkSwapWorkday(base, yyyy, mm);
            if("Y".equals(str)){
                obj.setErrMsg("done");
                obj.setStatus(1);
            }else{
                obj.setErrMsg(str);
                obj.setStatus(0);
            }
        }else{
            obj.setErrMsg(obj.getErrMsg());
            obj.setStatus(obj.getStatus());
        }
        return obj;
    }
    
    /*A.        �Z��O�_���checkBox*/
    public boolean isCheckBox(String dutyCd,String tripno){
        if (!"B1".equals(dutyCd)
                && !"EE".equals(dutyCd)
                && !"MT".equals(dutyCd)
                && !"CT".equals(dutyCd)
                && !"FT".equals(dutyCd)
                && !"B2".equals(dutyCd)
                && !"GS".equals(dutyCd)
                && !"BL".equals(dutyCd)
                && ((!"0".equals(tripno) && !"AL".equals(dutyCd) && !"XL".equals(dutyCd) && !"LVE".equals(dutyCd)) 
                        || ("0".equals(tripno) && ("AL".equals(dutyCd) || "XL".equals(dutyCd) || "LVE".equals(dutyCd))) ) )
        {
            return true;
        }else{
            return false;
        }
//    if (!"B1".equals(obj.getDutycode())
//            && !"EE".equals(obj.getDutycode())
//            && !"MT".equals(obj.getDutycode())
//            && !"CT".equals(obj.getDutycode())
//            && !"FT".equals(obj.getDutycode())
//            && !"B2".equals(obj.getDutycode())
//            && !"GS".equals(obj.getDutycode())
//            && !"BL".equals(obj.getDutycode())
//            && ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) 
//        || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) || "XL".equals(obj.getDutycode()) || "LVE".equals(obj.getDutycode())))))
//    {
    }

    /**�T��**/
    /*step1-1.TPE ���Z��� �ˬd*/
    public String ChkSwapInfoTPE(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        //�O�_�T��Z
        swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
        int times = 4;
        if(ac.isNoSwap())
        {
            str = ac.getNoSwapStr();
        }
        else
        {
//            //�ˬd�Z��O�_����
//            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
            ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
            //***********************************************************************
            //�ӽЪ̬O�_����
            CheckFullAttendance acs = new CheckFullAttendance(aEmpno, yyyy+mm);
            String a_isfullattendance = acs.getCheckMonth();
            //�Q���̬O�_����
            CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, yyyy+mm);
            String r_isfullattendance = rcs.getCheckMonth();
            String displaystr = "";
            if(!"Y".equals(a_isfullattendance))
            {
                displaystr = a_isfullattendance;
            }
            if(!"Y".equals(r_isfullattendance))
            {
                displaystr = r_isfullattendance;
            }
            //***********************************************************************
//            if(!pc.isPublished()){
//                //�Z��O�_����
//                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
//            }else
                if(ac.isUnCheckForm()){ 
                //���ӽг�|���֥i�A���i�ӽ�
                str=" �ӽЪ�("+aEmpno+")�γQ����( "+rEmpno+")���ӽг�|���gED�֥i,�t�Τ����z����.";
            }else if (!"Y".equals(a_isfullattendance) ||  !"Y".equals(r_isfullattendance)){
                //�䤤�@�H�S������
                str=displaystr; 
            }else if (ac.getAApplyTimes() >=times ){ 
                // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
                str="�ӽЪ�("+aEmpno+")"+yyyy+"/"+mm+ "�ӽЦ��Ƥw�W�L"+times+"��, �t�Τ����z����.";
            }else if (ac.getRApplyTimes() >=times ){ 
                // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
                str="�Q����("+rEmpno+")"+yyyy+"/"+mm+ "�ӽЦ��Ƥw�W�L"+times+"��, �t�Τ����z����.";    
            }else if(ac.isALocked()){
                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
                str="�ӽЪ�("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else if(ac.isRLocked()){
                //�Q���̯Z����w
                str="�Q����("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else {
                setaTimes(ac.getAApplyTimes());
                setrTimes(ac.getRApplyTimes());
                str = "Y";
            }        
            /*if("Y".equals(str)){
                swap3ac.CheckRetire cr = new swap3ac.CheckRetire(aEmpno);
                boolean aRetire = false;
                boolean rRetire = false;
                try {
                    cr.RetrieveDate();
                    if(cr.isRetire()){
                        aRetire = true;
                    }            
                    cr = new swap3ac.CheckRetire(rEmpno);             
                    cr.RetrieveDate();
                    if(cr.isRetire()){
                        rRetire= true;
                    }
                } catch (ClassNotFoundException e) {
                    str = e.toString();
                } catch (SQLException e) {
                    str = e.toString();
                } catch (InstantiationException e) {
                    str = e.toString();
                } catch (IllegalAccessException e) {
                    str = e.toString();
                }
        
                if(aRetire || rRetire)
                {//���@�����h�H���A�ϥ�applicantRetire.jsp
                    str = "�ӽЪ�("+aEmpno+") �� �Q����("+rEmpno+") �w�C����/���Z���ޤH���W��A�пˬ��ŪA�������H�H�u����覡�B�z�A���¡I";
                }
            }// if("Y".equals(str))*/
        }
        return str;
    }
    
    /*step1-1.KHH ���Z��� �ˬd*/
    public String ChkSwapInfoKHH(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        //�O�_�T��Z
        swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
        if(ac.isNoSwap())
        {
            str = ac.getNoSwapStr();
        }
        else
        {
            //�ˬd�Z��O�_����
            swap3ackhh.PublishCheck pc = new swap3ackhh.PublishCheck(yyyy, mm);
            ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
            //***********************************************************************
            //�ӽЪ̬O�_����
            CheckFullAttendance acs = new CheckFullAttendance(aEmpno, yyyy+mm);
            String a_isfullattendance = acs.getCheckMonth();
            //�Q���̬O�_����
            CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, yyyy+mm);
            String r_isfullattendance = rcs.getCheckMonth();
            String displaystr = "";
            if(!"Y".equals(a_isfullattendance))
            {
                displaystr = a_isfullattendance;
            }
            if(!"Y".equals(r_isfullattendance))
            {
                displaystr = r_isfullattendance;
            }
            //***********************************************************************
            if(!pc.isPublished()){
                //�Z��O�_����
                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
            }else if(ac.isUnCheckForm()){ 
                //���ӽг�|���֥i�A���i�ӽ�
                str=" �ӽЪ�("+aEmpno+")�γQ����( "+rEmpno+")���ӽг�|���gED�֥i,�t�Τ����z����.";
            }else if (!"Y".equals(a_isfullattendance) | !"Y".equals(r_isfullattendance)){
                //�䤤�@�H�S������
                str=displaystr; 
            }else if (ac.getAApplyTimes() >=3 ){ 
                // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
                str="�ӽЪ�("+aEmpno+")"+yyyy+"/"+mm+ "�ӽЦ��Ƥw�W�L�T��, �t�Τ����z����.";
            }else if (ac.getRApplyTimes() >=3 ){ 
                // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
                str="�Q����("+rEmpno+")"+yyyy+"/"+mm+ "�ӽЦ��Ƥw�W�L�T��, �t�Τ����z����.";    
            }else if(ac.isALocked()){
                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
                str="�ӽЪ�("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else if(ac.isRLocked()){
                //�Q���̯Z����w
                str="�Q����("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else {
                setaTimes(ac.getAApplyTimes());
                setrTimes(ac.getRApplyTimes());
                str = "Y";
            }        
            /*if("Y".equals(str)){
                swap3ackhh.CheckRetire cr = new swap3ackhh.CheckRetire(aEmpno);
                boolean aRetire = false;
                boolean rRetire = false;
                try {
                    cr.RetrieveDate();
                    if(cr.isRetire()){
                        aRetire = true;
                    }            
                    cr = new swap3ackhh.CheckRetire(rEmpno);             
                    cr.RetrieveDate();
                    if(cr.isRetire()){
                        rRetire= true;
                    }
                } catch (ClassNotFoundException e) {
                    str = e.toString();
                } catch (SQLException e) {
                    str = e.toString();
                } catch (InstantiationException e) {
                    str = e.toString();
                } catch (IllegalAccessException e) {
                    str = e.toString();
                }
        
                if(aRetire || rRetire)
                {//���@�����h�H���A�ϥ�applicantRetire.jsp
                    str = "�ӽЪ�("+aEmpno+") �� �Q����("+rEmpno+") �w�C����/���Z���ޤH���W��A�пˬ��ŪA�������H�H�u����覡�B�z�A���¡I";
                }
            }// if("Y".equals(str))*/
        }
        return str;
    }
    
    /*step1-2 ���o�Z�� */
    /*WS return*/
    public void SwapSkj(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        String step = "";
        String base ="";
        crewSpObjAL = new CrewSwapRObj();
        try 
        { 
            //step0.
            step = "0";
            StatusObj baseObj = ChkCrewBase(aEmpno, rEmpno);
            if(baseObj.getStatus() == 0){
                crewSpObjAL.setResultMsg("0");
                crewSpObjAL.setErrorMsg(baseObj.getErrMsg());
            }else{
//                /**TPE**/
                if(baseObj.getStatus() == 1)
                {
                    step = "Crew info";
                    base = "TPE";
//              step1
                    step = "1";
                    str = ChkSwapWorkday(base,yyyy,mm);
                    if("Y".equals(str)){
//              step1-1
                        step = "1-1";
                        str = ChkSwapInfoTPE(aEmpno,rEmpno,yyyy,mm);
                        if("Y".equals(str)){
//              �Z��
                                /**************************************/
                            step = "1Sch";
                            CrewSwapSkj csk = new CrewSwapSkj(aEmpno, rEmpno, yyyy, mm);
                            csk.SelectData();                       
                            if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
                                crewSpObjAL.setaCrewInfoObj(csk.getACrewInfoObj());
                                crewSpObjAL.setrCrewInfoObj(csk.getRCrewInfoObj());
                                crewSpObjAL.setCommItemAL(csk.getCommItemAL());  
                               
                                crewSpObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                                crewSpObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());
                                /*�ӽЪ�*/
                                for(int i=0;i<crewSpObjAL.getaCrewSkjAL().size();i++){
                                    swap3ac.CrewSkjObj obj = (swap3ac.CrewSkjObj) crewSpObjAL.getaCrewSkjAL().get(i); 
                                    swap3ac.ApplyCheck ack = new swap3ac.ApplyCheck();
                                    ArrayList resthrAL = ack.getRestHour(yyyy,mm,base);
                                    String resthr ="";
                                    resthr = obj.getResthr();
        
                                    for(int h=0; h<resthrAL.size(); h++)
                                    {
                                        RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
                                        if(resthrobj.getCondi_val().equals(obj.getDutycode()))
                                        {
                                            resthr = resthrobj.getResthr();
                                        }
                                        else if(resthrobj.getCondi_val().equals(obj.getArv()))
                                        {
                                            resthr = resthrobj.getResthr();
                                        }
                                    }   
                                    obj.setResthr(resthr);
                                    /**/
                                    if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                        obj.setDetail("Y");
                                    }else{
                                        obj.setDetail("N");
                                    }
                                    /**/
                                    if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                        obj.setChkBox("Y");
                                    }else{
                                        obj.setChkBox("N");
                                    }
                                    crewSpObjAL.getaCrewSkjAL().set(i, obj);
                                }
                                /*�Q����*/
                                for(int i=0;i<crewSpObjAL.getrCrewSkjAL().size();i++){
                                    swap3ac.CrewSkjObj obj = (swap3ac.CrewSkjObj) crewSpObjAL.getrCrewSkjAL().get(i); 
                                    swap3ac.ApplyCheck ack = new swap3ac.ApplyCheck();
                                    ArrayList resthrAL = ack.getRestHour(yyyy,mm,base);
                                    String resthr ="";
                                    resthr = obj.getResthr();
                
                                    for(int h=0; h<resthrAL.size(); h++)
                                    {
                                        RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
                                        if(resthrobj.getCondi_val().equals(obj.getDutycode()))
                                        {
                                            resthr = resthrobj.getResthr();
                                        }
                                        else if(resthrobj.getCondi_val().equals(obj.getArv()))
                                        {
                                            resthr = resthrobj.getResthr();
                                        }
                                    }
                                    obj.setResthr(resthr);                    
                                    /**/
                                    if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                        obj.setDetail("Y");
                                    }else{
                                        obj.setDetail("N");
                                    }
                                    /**/
                                    if(isCheckBox(obj.getDutycode(),obj.getTripno())){                                    
                                        obj.setChkBox("Y");
                                    }else{
                                        obj.setChkBox("N");
                                    }
                                    crewSpObjAL.getrCrewSkjAL().set(i, obj);
                                }
                                /**************************************/
                                crewSpObjAL.setResultMsg("1");
                                crewSpObjAL.setErrorMsg("Done");
                            }else{
                                crewSpObjAL.setResultMsg("1");
                                crewSpObjAL.setErrorMsg("No Data.");
                            }//null
                        }else{
                            crewSpObjAL.setResultMsg("0");
                            crewSpObjAL.setErrorMsg(str);
                        }//getchkSwapInfo(aEmpno,rEmpno,yyyy,mm);
                    }else{
                        crewSpObjAL.setResultMsg("0");
                        crewSpObjAL.setErrorMsg(str);
                    }//chkSwapWorkday();                        
                    
                }
                /**KHH**/
                else if(baseObj.getStatus() == 2){       
                    base = "KHH";
//              step1
                    step = "1";
                    str = ChkSwapWorkday(base, yyyy, mm);
                    if("Y".equals(str)){
//              step1-1
                        step = "1-1";
                        str = ChkSwapInfoKHH(aEmpno,rEmpno,yyyy,mm);
                        if("Y".equals(str)){
//              �Z��
                            /**************************************/
                            step = "Sch";
                            swap3ackhh.CrewSwapSkj csk = new swap3ackhh.CrewSwapSkj(aEmpno, rEmpno, yyyy, mm);
                            csk.SelectData();     
                            if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
//                                    crewObjAL.setCrewInfoAL(objAL);
                                crewSpObjAL.setaCrewInfo2Obj(csk.getACrewInfoObj());
                                crewSpObjAL.setrCrewInfo2Obj(csk.getRCrewInfoObj());
                                crewSpObjAL.setCommItemAL(csk.getCommItemAL());        
                                crewSpObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                                crewSpObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());
                                /*�ӽЪ�*/
                                for(int i=0;i<crewSpObjAL.getaCrewSkjAL().size();i++){
                                    swap3ackhh.CrewSkjObj obj =(swap3ackhh.CrewSkjObj) crewSpObjAL.getaCrewSkjAL().get(i); 
                                    /**/
                                    String resthr ="";
                                    resthr = obj.getResthr();
                                    if("SB".equals(obj.getDutycode()))
                                    {
                                        resthr = "24";          
                                    }
                                    else if ("0026".equals(obj.getDutycode()) || "1026".equals(obj.getDutycode()) || "2026".equals(obj.getDutycode()))
                                    {
                                        resthr = "36";          
                                    }
                                    else if ("0130".equals(obj.getDutycode()) || "2130".equals(obj.getDutycode()))
                                    {
                                        resthr = "�@���";         
                                    } 
                                    obj.setResthr(resthr);
                                    /**/ 
                                    if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                        obj.setChkBox("Y");
                                    }else{
                                        obj.setDetail("N");
                                    }                  
                                    /**/                    
                                    if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                        obj.setChkBox("Y");
                                    }else{
                                        obj.setChkBox("N");
                                    }
                                    crewSpObjAL.getaCrewSkjAL().set(i, obj);
                                }
                                /*�Q����*/
                                for(int i=0;i<crewSpObjAL.getrCrewSkjAL().size();i++){
                                    swap3ackhh.CrewSkjObj obj = (swap3ackhh.CrewSkjObj) crewSpObjAL.getrCrewSkjAL().get(i);
                                    /**/
                                    String resthr ="";
                                    resthr = obj.getResthr();
                
                                    if("SB".equals(obj.getDutycode()))
                                    {
                                        resthr = "24";          
                                    }
                                    else if ("0026".equals(obj.getDutycode()) | "1026".equals(obj.getDutycode()) | "2026".equals(obj.getDutycode()))
                                    {
                                        resthr = "36";          
                                    }
                                    else if ("0130".equals(obj.getDutycode()) | "2130".equals(obj.getDutycode()))
                                    {
                                        resthr = "�@���";         
                                    }
                                    obj.setResthr(resthr);
                                    /**/
                                    if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                        obj.setDetail("Y");
                                    }else{
                                        obj.setDetail("N");
                                    }
                                    /**/
                                    if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                        obj.setChkBox("Y");
                                    }else{
                                        obj.setChkBox("N");
                                    }            
                                    crewSpObjAL.getrCrewSkjAL().set(i, obj);
                                }
                                /**************************************/
                                crewSpObjAL.setResultMsg("1");
                                crewSpObjAL.setErrorMsg("Done");
                            }else{
                                crewSpObjAL.setResultMsg("1");
                                crewSpObjAL.setErrorMsg("No Data.");
                            }//null
                        }else{
                            crewSpObjAL.setResultMsg("0");
                            crewSpObjAL.setErrorMsg(str);
                        }//chkSwapInfo(aEmpno,rEmpno,yyyy,mm);
                    }else{
                        crewSpObjAL.setResultMsg("0");
                        crewSpObjAL.setErrorMsg(str);
                    }//chkSwapWorkday();                            
                }else{
                    crewSpObjAL.setResultMsg("0");
                    crewSpObjAL.setErrorMsg(baseObj.getErrMsg());
                }//baseObj.getStatus()
            }
        } catch (SQLException e) {
            crewSpObjAL.setResultMsg("0");
            crewSpObjAL.setErrorMsg(base+step+":"+e.toString()); 
        }catch(Exception e){
            crewSpObjAL.setResultMsg("0");
            crewSpObjAL.setErrorMsg(base+step+":"+e.toString());
        }finally{
          //log
//               System.out.println(crewObjAL.getErrorMsg());
        }
           
    }
    
    /*�����T�{*/
     public void SwapDetail(String aEmpno,String rEmpno,String yyyy,String mm,String[] aChoSwapSkj,String[] rChoSwapSkj)
    //(String year ,String month ,CrewInfoObj aCrewInfoObj,CrewInfoObj rCrewInfoObj,
//            ArrayList aCrewSkjAL , ArrayList rCrewSkjAL ,String[] aChoSwapSkj,String[] rChoSwapSkj)
    {
        crewSpDetailObjAL = new CrewSwapDetailRObj();
        boolean ifpasscnvisa = false;
        if(null == aChoSwapSkj || null == rChoSwapSkj){
            crewSpDetailObjAL.setResultMsg("0");
            crewSpDetailObjAL.setErrorMsg("�|����ܯZ��");
        }else{
            SwapSkj(aEmpno,rEmpno,yyyy,mm);
            if("0".equals(crewSpObjAL.getResultMsg())){
                crewSpDetailObjAL.setResultMsg("0");
                crewSpDetailObjAL.setErrorMsg(crewSpObjAL.getErrorMsg());
            }else{
               
                swap3ac.CrewInfoObj aCrewInfoObj = crewSpObjAL.getaCrewInfoObj();
                swap3ac.CrewInfoObj rCrewInfoObj = crewSpObjAL.getrCrewInfoObj();
                swap3ackhh.CrewInfoObj aCrewInfoObj2 = crewSpObjAL.getaCrewInfo2Obj();
                swap3ackhh.CrewInfoObj rCrewInfoObj2 = crewSpObjAL.getrCrewInfo2Obj();
                ArrayList aCrewSkjAL = crewSpObjAL.getaCrewSkjAL();
                ArrayList rCrewSkjAL = crewSpObjAL.getrCrewSkjAL();
        
                try
                {
                    if("TPE".equals(aCrewInfoObj.getBase())){
                        swap3ac.CalcSwapHrs cSHrs = new swap3ac.CalcSwapHrs();        
                        if(!cSHrs.job(aCrewInfoObj,rCrewInfoObj,aCrewSkjAL,rCrewSkjAL,aChoSwapSkj,rChoSwapSkj))
                        {
                            //System.out.print("�|����ܯZ��");
                            crewSpDetailObjAL.setResultMsg("0");
                            crewSpDetailObjAL.setErrorMsg("�|����ܯZ��");
                        }
                        else
                        {   
                              //System.out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
                              //System.out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
           
                                //SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
                                SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap(),yyyy,mm);
                                //***************************************************************
                                CheckValidCNVisa cnv = new CheckValidCNVisa();
                                ifpasscnvisa = cnv.job(aCrewInfoObj,rCrewInfoObj,aCrewSkjAL,rCrewSkjAL,aChoSwapSkj,rChoSwapSkj);
                                //*************************************************************** 
                                if(!sc.isExchangeable())
                                {
            //                                sc.getErrorMsg();
                                    crewSpDetailObjAL.setResultMsg("0");
                                    crewSpDetailObjAL.setErrorMsg(sc.getErrorMsg());
                                }else if(!ifpasscnvisa){
                                    crewSpDetailObjAL.setResultMsg("0");
                                    crewSpDetailObjAL.setErrorMsg("�ӽд��Z���󤣲šA���i���Z�C��]���G�ӽЪ̩γQ���̥x�M���Ĵ��w�O��");
                                }else{
                                    crewSpDetailObjAL.setType(1);
                                    crewSpDetailObjAL.setaCrewSkjAL(cSHrs.getASwapSkjAL());
                                    crewSpDetailObjAL.setrCrewSkjAL(cSHrs.getRSwapSkjAL());
                                    
                                    crewSpDetailObjAL.setaTimes(getaTimes());
                                    crewSpDetailObjAL.setrTimes(getrTimes());
                                    
                                    crewSpDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                    crewSpDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                    crewSpDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                    
                                    crewSpDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                    crewSpDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                    crewSpDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                    
                                    crewSpDetailObjAL.setResultMsg("1");
                                    crewSpDetailObjAL.setErrorMsg("Done");
                                    
                                }
                        }
                            
                    }else if("KHH".equals(aCrewInfoObj2.getBase())){
                        swap3ackhh.CalcSwapHrs cSHrs = new swap3ackhh.CalcSwapHrs();
                        if(!cSHrs.job(aCrewInfoObj2, rCrewInfoObj2, aCrewSkjAL, rCrewSkjAL, aChoSwapSkj, rChoSwapSkj)){
                            crewSpDetailObjAL.setResultMsg("0");
                            crewSpDetailObjAL.setErrorMsg("�|����ܯZ��");
                        }else{
                            //out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
                            //out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
                            swap3ackhh.SwapCheck sc = new swap3ackhh.SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
                            
                            if(!sc.isExchangeable()){   //���i���Z
                                crewSpDetailObjAL.setResultMsg("0");
                                crewSpDetailObjAL.setErrorMsg(sc.getErrorMsg());
                            }else{  // �ŦX���Z����
                                crewSpDetailObjAL.setType(2);
                                crewSpDetailObjAL.setaCrewSkjAL(cSHrs.getASwapSkjAL());
                                crewSpDetailObjAL.setrCrewSkjAL(cSHrs.getRSwapSkjAL());
                                
                                crewSpDetailObjAL.setaTimes(getaTimes());
                                crewSpDetailObjAL.setrTimes(getrTimes());
                                
                                crewSpDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                crewSpDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                crewSpDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                
                                crewSpDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                crewSpDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                crewSpDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                
                                crewSpDetailObjAL.setResultMsg("1");
                                crewSpDetailObjAL.setErrorMsg("Done");
                            }
                        }
                        
                    }   
                }
                catch ( Exception e )
                {
                    crewSpDetailObjAL.setResultMsg("0");
                    crewSpDetailObjAL.setErrorMsg(e.toString());
                } 
            }//  if("0".equals(crewSpObjAL.getResultMsg())){
        }//   if(null == aChoSwapSkj || null == rChoSwapSkj){
    }
    
    
    /**�n�I**/
    /*step2-1.TPE ���Z��� �ˬd*/ 
    public String ChkSwapCreditInfoTPE(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        //�O�_�T��Z
        swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
        if(ac.isNoSwap())
        {
            str = ac.getNoSwapStr();
        }
        else
        {
            //�ˬd�Z��O�_����
//            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
            ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
            //***********************************************************************
//            if(!pc.isPublished()){
//                //�Z��O�_����
//                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
//            }else 
             if(ac.isUnCheckForm()){ 
                //���ӽг�|���֥i�A���i�ӽ�
                str=" �ӽЪ�("+aEmpno+")�γQ����( "+rEmpno+")���ӽг�|���gED�֥i,�t�Τ����z����.";
            }else if(ac.isALocked()){
                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
                str="�ӽЪ�("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else if(ac.isRLocked()){
                //�Q���̯Z����w
                str="�Q����("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else {
                str = "Y";
            }   
        }
        return str;
    }
    
    /*step2-1.KHH ���Z��� �ˬd*/ 
    public String ChkSwapCreditInfoKHH(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        //�O�_�T��Z
        swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
        if(ac.isNoSwap())
        {
            str = ac.getNoSwapStr();
        }
        else
        {
            //�ˬd�Z��O�_����
//            swap3ackhh.PublishCheck pc = new swap3ackhh.PublishCheck(yyyy, mm);
            ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
            //***********************************************************************
//            if(!pc.isPublished()){
//                //�Z��O�_����
//                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
//            }else
            if(ac.isUnCheckForm()){ 
                //���ӽг�|���֥i�A���i�ӽ�
                str=" �ӽЪ�("+aEmpno+")�γQ����( "+rEmpno+")���ӽг�|���gED�֥i,�t�Τ����z����.";
            }else if(ac.isALocked()){
                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
                str="�ӽЪ�("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else if(ac.isRLocked()){
                //�Q���̯Z����w
                str="�Q����("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else {
                str = "Y";
            }   
        }
        return str;
    }
    
    /*step2-2.  �n�I��� �ˬd*/
    public String CreditAvl(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        CreditList aCl = new CreditList();
        aCl.getCreditList("N",aEmpno);                    
        if(aCl.getObjAL()!=null  && aCl.getObjAL().size() > 0){
            //aEmpno ���i�οn�I
            crewCtObjAL.setaEmpnoAvb(1);
            CreditObj[] aCrewCtAr = new CreditObj[aCl.getObjAL().size()];
            for(int i=0 ;i<aCl.getObjAL().size();i++){                
                aCrewCtAr[i] = (CreditObj) aCl.getObjAL().get(i);
            }
            crewCtObjAL.setaCrewCtAr(aCrewCtAr);
//            crewCtObjAL.setaCrewCtAL(aCl.getObjAL());
            //check rEmpno �T�� or �n�I
            CheckFormTimes ck = new CheckFormTimes();
            str = ck.get3FormTimes(rEmpno, yyyy , mm);
            if("N".equals(str))
            {
                //N:rEmpno �i�ϥΤT�����Z("Y".equals(r_isfullattendance)  && times <3)
                crewCtObjAL.setrEmpnoAvb(2);
                str = "Y";
            }
            else if("Y".equals(str))
            {
                //Y:�Q���̥�����  or �Q���̷��ӽЦ��ư���3��,�~��οn�I
                CreditList rCl = new CreditList();
                rCl.getCreditList("N",rEmpno);
                if(rCl.getObjAL()!=null  && rCl.getObjAL().size() > 0){
                    //rEmpno �ݥοn�I
                    crewCtObjAL.setrEmpnoAvb(1);
                    CreditObj[] rCrewCtAr = new CreditObj[rCl.getObjAL().size()];
                    for(int i=0 ;i<rCl.getObjAL().size();i++){                
                        rCrewCtAr[i] = (CreditObj) rCl.getObjAL().get(i);
                    }
                    crewCtObjAL.setrCrewCtAr(rCrewCtAr);
//                    crewCtObjAL.setrCrewCtAL(rCl.getObjAL());
                    str = "Y";
                }
            }
            else{
                str = ck.getErrorstr();
            }         
        }else{
            str = aEmpno+"�L�i�οn�I";
        }
        return str;
    }
        
    /*step2-3.  �Z��*/
    /*WS return*/
    public void SwapCredit(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        String step = "";
        String base = "";
        crewCtObjAL = new CrewSwapCreditRObj();
//      step0
        StatusObj baseObj = ChkCrewBase(aEmpno, rEmpno);
        if(baseObj.getStatus() == 0){
            crewCtObjAL.setResultMsg("0");
            crewCtObjAL.setErrorMsg(baseObj.getErrMsg());
        }else{
            try 
            {             
                /**TPE**/
                if(baseObj.getStatus() == 1)
                {
                    base = "TPE";
//              step1
                    step = "1";
                    str = ChkSwapWorkday(base,yyyy,mm);
                    if("Y".equals(str)){
//              step2-1
                        step = "2-1";
                        str = ChkSwapCreditInfoTPE(aEmpno, rEmpno, yyyy, mm);
                        if("Y".equals(str)){
//              step2-2
                            step = "2-2";
                            str = CreditAvl(aEmpno, rEmpno, yyyy, mm);
                            if("Y".equals(str)){
//              �Z��  
                                /**************************************/
                                step = "Sch";
                                swap3ac.CrewSwapSkj csk = new swap3ac.CrewSwapSkj(aEmpno, rEmpno, yyyy, mm);
                                csk.SelectData();
                                if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
                                    crewCtObjAL.setaCrewInfoObj(csk.getACrewInfoObj());
                                    crewCtObjAL.setrCrewInfoObj(csk.getRCrewInfoObj());
                                    crewCtObjAL.setCommItemAL(csk.getCommItemAL());                                    
                                    crewCtObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                                    crewCtObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());
                                    /*�ӽЪ�*/
                                    for(int i=0;i<crewCtObjAL.getaCrewSkjAL().size();i++){
                                        CrewSkjObj obj = (CrewSkjObj) crewCtObjAL.getaCrewSkjAL().get(i); 
                                        ApplyCheck ack = new ApplyCheck();
                                        ArrayList resthrAL = ack.getRestHour(yyyy,mm,base);
                                        String resthr ="";
                                        resthr = obj.getResthr();
            
                                        for(int h=0; h<resthrAL.size(); h++)
                                        {
                                            RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
                                            if(resthrobj.getCondi_val().equals(obj.getDutycode()))
                                            {
                                                resthr = resthrobj.getResthr();
                                            }
                                            else if(resthrobj.getCondi_val().equals(obj.getArv()))
                                            {
                                                resthr = resthrobj.getResthr();
                                            }
                                        }   
                                        obj.setResthr(resthr);
                                        /**/
                                        if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                            obj.setDetail("Y");
                                        }else{
                                            obj.setDetail("N");
                                        }
                                        /**/
                                        if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                            obj.setChkBox("Y");
                                        }else{
                                            obj.setChkBox("N");
                                        }
                                        crewCtObjAL.getaCrewSkjAL().set(i, obj);
                                    }
                                    /*�Q����*/
                                    for(int i=0;i<crewCtObjAL.getrCrewSkjAL().size();i++){
                                        CrewSkjObj obj = (CrewSkjObj) crewCtObjAL.getrCrewSkjAL().get(i); 
                                        ApplyCheck ack = new ApplyCheck();
                                        ArrayList resthrAL = ack.getRestHour(yyyy,mm,"TPE");
                                        String resthr ="";
                                        resthr = obj.getResthr();
                    
                                        for(int h=0; h<resthrAL.size(); h++)
                                        {
                                            RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
                                            if(resthrobj.getCondi_val().equals(obj.getDutycode()))
                                            {
                                                resthr = resthrobj.getResthr();
                                            }
                                            else if(resthrobj.getCondi_val().equals(obj.getArv()))
                                            {
                                                resthr = resthrobj.getResthr();
                                            }
                                        }
                                        obj.setResthr(resthr);                    
                                        /**/
                                        if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                            obj.setDetail("Y");
                                        }else{
                                            obj.setDetail("N");
                                        }
                                        /**/
                                        if(isCheckBox(obj.getDutycode(),obj.getTripno())){                                    
                                            obj.setChkBox("Y");
                                        }else{
                                            obj.setChkBox("N");
                                        }
                                        crewCtObjAL.getrCrewSkjAL().set(i, obj);
                                    }
                                    /**************************************/
                                    crewCtObjAL.setResultMsg("1");
                                    crewCtObjAL.setErrorMsg("Done");
                                }else{
                                    crewCtObjAL.setResultMsg("0");
                                    crewCtObjAL.setErrorMsg("No Data.");
                                }//null
                            }else{
                                crewCtObjAL.setResultMsg("0");
                                crewCtObjAL.setErrorMsg(str);
                            }//CreditAvl(aEmpno,rEmpno,yyyy,mm);
                        }else{
                            crewCtObjAL.setResultMsg("0");
                            crewCtObjAL.setErrorMsg(str);
                        }//ChkSwapInfoTPE(aEmpno,rEmpno,yyyy,mm);
                    }else{
                        crewCtObjAL.setResultMsg("0");
                        crewCtObjAL.setErrorMsg(str);
                    }//ChkSwapWorkday();
                    
                }
                /**KHH**/
                else if(baseObj.getStatus() == 2)
                {         
                    base = "KHH";
//              step1
                    step = "1";
                    str = ChkSwapWorkday(base, yyyy, mm);
                    if("Y".equals(str)){
//              step2-1
                        step = "2-1";
                        str = ChkSwapCreditInfoKHH(aEmpno, rEmpno, yyyy, mm);
                        if("Y".equals(str)){
//              step2-2
                            step = "2-2";
                            str = CreditAvl(aEmpno, rEmpno, yyyy, mm);
                            if("Y".equals(str)){
//              �Z��
                            /**************************************/
                                step = "Sch";
                                swap3ackhh.CrewSwapSkj csk = new swap3ackhh.CrewSwapSkj(aEmpno, rEmpno, yyyy, mm);
                                csk.SelectData();    
                                if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
                                    crewCtObjAL.setaCrewInfo2Obj(csk.getACrewInfoObj());
                                    crewCtObjAL.setrCrewInfo2Obj(csk.getRCrewInfoObj());
                                    crewCtObjAL.setCommItemAL(csk.getCommItemAL());        
                                    crewCtObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                                    crewCtObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());
                                    /*�ӽЪ�*/
                                    for(int i=0;i<crewCtObjAL.getaCrewSkjAL().size();i++){
                                        CrewSkjObj obj =(CrewSkjObj) crewCtObjAL.getaCrewSkjAL().get(i); 
                                        /**/
                                        String resthr ="";
                                        resthr = obj.getResthr();
                                        if("SB".equals(obj.getDutycode()))
                                        {
                                            resthr = "24";          
                                        }
                                        else if ("0026".equals(obj.getDutycode()) || "1026".equals(obj.getDutycode()) || "2026".equals(obj.getDutycode()))
                                        {
                                            resthr = "36";          
                                        }
                                        else if ("0130".equals(obj.getDutycode()) || "2130".equals(obj.getDutycode()))
                                        {
                                            resthr = "�@���";         
                                        } 
                                        obj.setResthr(resthr);
                                        /**/ 
                                        if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                            obj.setChkBox("Y");
                                        }else{
                                            obj.setDetail("N");
                                        }                  
                                        /**/                    
                                        if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                            obj.setChkBox("Y");
                                        }else{
                                            obj.setChkBox("N");
                                        }
                                        crewCtObjAL.getaCrewSkjAL().set(i, obj);
                                    }
                                    /*�Q����*/
                                    for(int i=0;i<crewCtObjAL.getrCrewSkjAL().size();i++){
                                        CrewSkjObj obj = (CrewSkjObj) crewCtObjAL.getrCrewSkjAL().get(i);
                                        /**/
                                        String resthr ="";
                                        resthr = obj.getResthr();
                    
                                        if("SB".equals(obj.getDutycode()))
                                        {
                                            resthr = "24";          
                                        }
                                        else if ("0026".equals(obj.getDutycode()) | "1026".equals(obj.getDutycode()) | "2026".equals(obj.getDutycode()))
                                        {
                                            resthr = "36";          
                                        }
                                        else if ("0130".equals(obj.getDutycode()) | "2130".equals(obj.getDutycode()))
                                        {
                                            resthr = "�@���";         
                                        }
                                        obj.setResthr(resthr);
                                        /**/
                                        if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                            obj.setDetail("Y");
                                        }else{
                                            obj.setDetail("N");
                                        }
                                        /**/
                                        if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                            obj.setChkBox("Y");
                                        }else{
                                            obj.setChkBox("N");
                                        }            
                                        crewCtObjAL.getrCrewSkjAL().set(i, obj);
                                    }
                                    /**************************************/
                                    crewCtObjAL.setResultMsg("1");
                                    crewCtObjAL.setErrorMsg("Done");
                                }else{
                                    crewCtObjAL.setResultMsg("0");
                                    crewCtObjAL.setErrorMsg("No Data.");
                                }//null
                            }else{
                                crewCtObjAL.setResultMsg("0");
                                crewCtObjAL.setErrorMsg(str);
                            }//CreditAvl(aEmpno,rEmpno,yyyy,mm);
                        }else{
                            crewCtObjAL.setResultMsg("0");
                            crewCtObjAL.setErrorMsg(str);
                        }//ChkSwapInfoKHH(aEmpno,rEmpno,yyyy,mm);
                    }else{
                        crewCtObjAL.setResultMsg("0");
                        crewCtObjAL.setErrorMsg(str);
                    }//ChkSwapWorkday();                   
                }else{
                    crewCtObjAL.setResultMsg("0");
                    crewCtObjAL.setErrorMsg(baseObj.getErrMsg());
                }//baseObj.getStatus()
            } catch (SQLException e) {
                crewCtObjAL.setResultMsg("0");
                crewCtObjAL.setErrorMsg(base+step+":"+e.toString()); 
            }catch(Exception e){
                crewCtObjAL.setResultMsg("0");
                crewCtObjAL.setErrorMsg(base+step+":"+e.toString());
            }finally{
              //log
//               System.out.println(crewCtObjAL.getErrorMsg());
            }
        }
    }

    /*step2-4. �n�I �����T�{*/
    public void SwapCreditDetail(String aEmpno,String rEmpno,String yyyy ,String mm ,String[] aChoSwapSkj,String[] rChoSwapSkj){
        crewCtDetailObjAL = new CrewSwapCreditDetailRObj();
        boolean ifpasscnvisa = false;
        if(null == aChoSwapSkj || null == rChoSwapSkj){
            crewCtDetailObjAL.setResultMsg("0");
            crewCtDetailObjAL.setErrorMsg("�|����ܯZ��");
        }else{            
            SwapCredit(aEmpno,rEmpno,yyyy,mm);
            if("0".equals(crewCtObjAL.getResultMsg())){
                crewCtDetailObjAL.setResultMsg("0");
                crewCtDetailObjAL.setErrorMsg(crewCtObjAL.getErrorMsg());
            }else{
                swap3ac.CrewInfoObj aCrewInfoObj = crewCtObjAL.getaCrewInfoObj();
                swap3ac.CrewInfoObj rCrewInfoObj = crewCtObjAL.getrCrewInfoObj();
                swap3ackhh.CrewInfoObj aCrewInfoObj2 = crewCtObjAL.getaCrewInfo2Obj();
                swap3ackhh.CrewInfoObj rCrewInfoObj2 = crewCtObjAL.getrCrewInfo2Obj();
                ArrayList aCrewSkjAL = crewCtObjAL.getaCrewSkjAL();
                ArrayList rCrewSkjAL = crewCtObjAL.getrCrewSkjAL();
                int aEmpnoAvb = crewCtObjAL.getaEmpnoAvb();
                int rEmpnoAvb = crewCtObjAL.getrEmpnoAvb();
                
                if("TPE".equals(aCrewInfoObj.getBase())){
                    swap3ac.CalcSwapHrs cSHrs = new swap3ac.CalcSwapHrs();
                    if(!cSHrs.job(aCrewInfoObj,rCrewInfoObj,aCrewSkjAL,rCrewSkjAL,aChoSwapSkj,rChoSwapSkj))
                    {
                        crewCtDetailObjAL.setResultMsg("0");
                        crewCtDetailObjAL.setErrorMsg("�|����ܯZ��");
                    }
                    else
                    {
                        //out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
                        //out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
                        //SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
                        SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap(),yyyy,mm);
        
                        //***************************************************************
                        CheckValidCNVisa cnv = new CheckValidCNVisa();
                        ifpasscnvisa = cnv.job(aCrewInfoObj,rCrewInfoObj,aCrewSkjAL,rCrewSkjAL,aChoSwapSkj,rChoSwapSkj);
                        //***************************************************************   
                        if(!sc.isExchangeable())
                        {   //���i���Z
                            crewCtDetailObjAL.setResultMsg("0");
                            crewCtDetailObjAL.setErrorMsg(sc.getErrorMsg()); 
                        }
                        else if (ifpasscnvisa == false)
                        {
                            crewCtDetailObjAL.setResultMsg("0");
                            crewCtDetailObjAL.setErrorMsg("�ӽд��Z���󤣲šA���i���Z�C��]���G�ӽЪ̩γQ���̥x�M���Ĵ��w�O��"); 
                        }else{
                            //�ŦX���Z����
                            crewCtDetailObjAL.setaCrewSkjAL(cSHrs.getASwapSkjAL());
                            crewCtDetailObjAL.setrCrewSkjAL(cSHrs.getRSwapSkjAL());
                            if(1==aEmpnoAvb && 1==rEmpnoAvb){
        //                      aCrew&rCrew �ҥοn�I
                                   crewCtDetailObjAL.setType(3);
                                   crewCtDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                   crewCtDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                   crewCtDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                   
                                   crewCtDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                   crewCtDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                   crewCtDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                   
                                   crewCtDetailObjAL.setResultMsg("1");
                                   crewCtDetailObjAL.setErrorMsg("Done");
                               }else if(1==aEmpnoAvb && 2==rEmpnoAvb){
        //                       aCrew�οn�I& rCrew�T��
                                   crewCtDetailObjAL.setType(4);
        //                           crewDetailObjAL.setaTimes(getaTimes());
                                   crewCtDetailObjAL.setrTimes(getrTimes());
                                   
                                   crewCtDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                   crewCtDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                   crewCtDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                   
                                   crewCtDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                   crewCtDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                   crewCtDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                   
                                   crewCtDetailObjAL.setResultMsg("1");
                                   crewCtDetailObjAL.setErrorMsg("Done");
                               }else{
        //                       �L�i�οn�I
                                   crewCtDetailObjAL.setResultMsg("0");
                                   crewCtDetailObjAL.setErrorMsg("�L�i�οn�I");
                               }                     
                        }
                            
                    }
                }else if ("KHH".equals(aCrewInfoObj.getBase())){
                    swap3ackhh.CalcSwapHrs cSHrs = new  swap3ackhh.CalcSwapHrs();
                    if(!cSHrs.job(aCrewInfoObj2, rCrewInfoObj2, aCrewSkjAL, rCrewSkjAL, aChoSwapSkj, rChoSwapSkj)){        
                        crewCtDetailObjAL.setResultMsg("0");
                        crewCtDetailObjAL.setErrorMsg("�|����ܯZ��");
                    }
                    else
                    {
                        //out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
                        //out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
                        SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap(),yyyy,mm);
                    
                        if(!sc.isExchangeable())
                        {   //���i���Z
                            crewCtDetailObjAL.setResultMsg("0");
                            crewCtDetailObjAL.setErrorMsg(sc.getErrorMsg());
                        }
                        else
                        {   // �ŦX���Z����
                            crewCtDetailObjAL.setaCrewSkjAL(cSHrs.getASwapSkjAL());
                            crewCtDetailObjAL.setrCrewSkjAL(cSHrs.getRSwapSkjAL());
                            if(1==aEmpnoAvb && 1==rEmpnoAvb){
        //                      aCrew&rCrew �ҥοn�I
                                   crewCtDetailObjAL.setType(5);
                                   crewCtDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                   crewCtDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                   crewCtDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                   
                                   crewCtDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                   crewCtDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                   crewCtDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                   
                                   crewCtDetailObjAL.setResultMsg("1");
                                   crewCtDetailObjAL.setErrorMsg("Done");
        //                       }else if("1".equals(aEmpnoAvb) && "2".equals(rEmpnoAvb)){
        ////                       aCrew�οn�I& rCrew�T��
        //                           crewCtDetailObjAL.setType(4);
        ////                           crewDetailObjAL.setaTimes(getaTimes());
        //                           crewCtDetailObjAL.setrTimes(getrTimes());
        //                           
        //                           crewCtDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
        //                           crewCtDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
        //                           crewCtDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
        //                           
        //                           crewCtDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
        //                           crewCtDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
        //                           crewCtDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
        //                           
        //                           crewCtDetailObjAL.setResultMsg("1");
        //                           crewCtDetailObjAL.setErrorMsg("Done");
                               }else{
        //                       �L�i�οn�I
                                   crewCtDetailObjAL.setResultMsg("0");
                                   crewCtDetailObjAL.setErrorMsg(aEmpno + "or" + rEmpno +"�L�i�δ��Z���");
                               }                     
                        }
                    }
                }else{
                    crewCtDetailObjAL.setResultMsg("0");
                    crewCtDetailObjAL.setErrorMsg("Base type not correct.");
                }
            }// if("0".equals(crewCtObjAL.getResultMsg())){
        }//if(null == aChoSwapSkj || null == rChoSwapSkj){
    }
      
    
    /**�պ�-->����CrewSwapFunALL**/
    /*3-1* TPE �պ���*/
    public String CorssCrTPE(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        //�O�_�T��Z
        swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
        if(ac.isNoSwap())
        {
            str = ac.getNoSwapStr();
        }
        else
        {
            //�ˬd�Z��O�_����
            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
            ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
            //***********************************************************************
            if(!pc.isPublished()){
                //�Z��O�_����
                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
            }else if(ac.isALocked()){
                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
                str="�ӽЪ�("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else if(ac.isRLocked()){
                //�Q���̯Z����w
                str="�Q����("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else {
                str = "Y";
            }   
        }
        return str;
    }
    
    /*3-1* KHH �պ���*/
    public String CorssCrKHH(String aEmpno,String rEmpno,String yyyy,String mm){
        String str = "N";
        //�O�_�T��Z
        swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
        if(ac.isNoSwap())
        {
            str = ac.getNoSwapStr();
        }
        else
        {
            //�ˬd�Z��O�_����
            swap3ackhh.PublishCheck pc = new swap3ackhh.PublishCheck(yyyy, mm);
            ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
            //***********************************************************************
            if(!pc.isPublished()){
                //�Z��O�_����
                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
            }else if(ac.isALocked()){
                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
                str="�ӽЪ�("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else if(ac.isRLocked()){
                //�Q���̯Z����w
                str="�Q����("+rEmpno+") �Z����w���A,�t�Τ����z����.�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.";
            }else {
                str = "Y";
            }   
        }
        return str;
    }
   
    /*3-2. ���Z  ���ɸպ�Z��*/
    /*WS return*/
    public void CorssCrSkj(String aEmpno,String rEmpno,String yyyy,String mm){ 
        crewCorssObjAL = new CrewCorssCrRObj();
        String step = "";
        String base = "";
        String str ="";
        try 
        {
          //step0.
            step = "0";
//            StatusObj baseObj = ChkCrewBase(aEmpno, rEmpno);
//            if(baseObj.getStatus() == 0){
//                crewCorssObjAL.setResultMsg("0");
//                crewCorssObjAL.setErrorMsg(baseObj.getErrMsg());
//            }else{
////                /**TPE**/
//                if(baseObj.getStatus() == 1)
//                {
//                    step = "Crew info";
                    base = "TPE";
                    step = "1";
//                    str = CorssCrTPE(aEmpno, rEmpno, yyyy, mm);
                    str= "Y";
                    if("Y".equals(str)){                        
//                      �Z��
                        /**************************************/
                        step = "1Sch";
                        CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, yyyy, mm);
                        csk.SelectData();
                        crewCorssObjAL.setaCrewInfoObj(csk.getACrewInfoObj());
                        crewCorssObjAL.setrCrewInfoObj(csk.getRCrewInfoObj());        
                        crewCorssObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                        crewCorssObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());

                        String resthr ="";
                        /*�ӽЪ�*/
                        for(int i=0;i<crewCorssObjAL.getaCrewSkjAL().size();i++){
                            swap3ac.CrewSkjObj obj = (swap3ac.CrewSkjObj) crewCorssObjAL.getaCrewSkjAL().get(i); 
                            ApplyCheck ack = new ApplyCheck();
                            ArrayList resthrAL = ack.getRestHour(yyyy,mm,base);
                            resthr = obj.getResthr();

                            for(int h=0; h<resthrAL.size(); h++)
                            {
                                RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
                                if(resthrobj.getCondi_val().equals(obj.getDutycode()))
                                {
                                    resthr = resthrobj.getResthr();
                                }
                                else if(resthrobj.getCondi_val().equals(obj.getArv()))
                                {
                                    resthr = resthrobj.getResthr();
                                }
                            }   
                            obj.setResthr(resthr);
                            /**/
                            if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                obj.setDetail("Y");
                            }else{
                                obj.setDetail("N");
                            }
                            /**/
                            if(isCheckBox(obj.getDutycode(),obj.getTripno())){
                                obj.setChkBox("Y");
                            }else{
                                obj.setChkBox("N");
                            }
                            crewCorssObjAL.getaCrewSkjAL().set(i, obj);
                        }
                        /*�Q����*/
                        for(int i=0;i<crewCorssObjAL.getrCrewSkjAL().size();i++){
                            swap3ac.CrewSkjObj obj = (swap3ac.CrewSkjObj) crewCorssObjAL.getrCrewSkjAL().get(i); 
                            swap3ac.ApplyCheck ack = new swap3ac.ApplyCheck();
                            ArrayList resthrAL = ack.getRestHour(yyyy,mm,base);
                            resthr = obj.getResthr();
        
                            for(int h=0; h<resthrAL.size(); h++)
                            {
                                RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
                                if(resthrobj.getCondi_val().equals(obj.getDutycode()))
                                {
                                    resthr = resthrobj.getResthr();
                                }
                                else if(resthrobj.getCondi_val().equals(obj.getArv()))
                                {
                                    resthr = resthrobj.getResthr();
                                }
                            }
                            obj.setResthr(resthr);                    
                            /**/
                            if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
                                obj.setDetail("Y");
                            }else{
                                obj.setDetail("N");
                            }
                            /**/
                            if(isCheckBox(obj.getDutycode(),obj.getTripno())){                                    
                                obj.setChkBox("Y");
                            }else{
                                obj.setChkBox("N");
                            }
                            crewCorssObjAL.getrCrewSkjAL().set(i, obj);
                        }
                        /**************************************/
                        crewCorssObjAL.setResultMsg("1");
                        crewCorssObjAL.setErrorMsg("Done");
                    }else{
                        crewCorssObjAL.setResultMsg("0");
                        crewCorssObjAL.setErrorMsg(str);
                        //ChkSwapWorkday(base);
                    }                    
//                }else if (baseObj.getStatus() == 2){
//                    base = "KHH";
//                    step = "1";
//                    str = CorssCrKHH(aEmpno, rEmpno, yyyy, mm);
//                    if("Y".equals(str)){
////                  �Z��
//                        /**************************************/
//                        step = "Sch";
//                        swap3ackhh.CrewCrossCr csk = new swap3ackhh.CrewCrossCr(aEmpno, rEmpno, yyyy, mm);
//                        csk.SelectData();     
//                        if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
////                                        crewObjAL.setCrewInfoAL(objAL);
//                            crewCorssObjAL.setaCrewInfo2Obj(csk.getACrewInfoObj());
//                            crewCorssObjAL.setrCrewInfo2Obj(csk.getRCrewInfoObj());        
//                            crewCorssObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
//                            crewCorssObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());
//                            /*�ӽЪ�*/
//                            for(int i=0;i<crewCorssObjAL.getaCrewSkjAL().size();i++){
//                                swap3ackhh.CrewSkjObj obj =(swap3ackhh.CrewSkjObj) crewCorssObjAL.getaCrewSkjAL().get(i); 
//                                /**/
//                                String resthr ="";
//                                resthr = obj.getResthr();
//                                if("SB".equals(obj.getDutycode()))
//                                {
//                                    resthr = "24";          
//                                }
//                                else if ("0026".equals(obj.getDutycode()) || "1026".equals(obj.getDutycode()) || "2026".equals(obj.getDutycode()))
//                                {
//                                    resthr = "36";          
//                                }
//                                else if ("0130".equals(obj.getDutycode()) || "2130".equals(obj.getDutycode()))
//                                {
//                                    resthr = "�@���";         
//                                } 
//                                obj.setResthr(resthr);
//                                /**/ 
//                                if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
//                                    obj.setChkBox("Y");
//                                }else{
//                                    obj.setDetail("N");
//                                }                  
//                                /**/                    
//                                if(isCheckBox(obj.getDutycode(),obj.getTripno())){
//                                    obj.setChkBox("Y");
//                                }else{
//                                    obj.setChkBox("N");
//                                }
//                                crewCorssObjAL.getaCrewSkjAL().set(i, obj);
//                            }
//                            /*�Q����*/
//                            for(int i=0;i<crewCorssObjAL.getrCrewSkjAL().size();i++){
//                                swap3ackhh.CrewSkjObj obj = (swap3ackhh.CrewSkjObj) crewCorssObjAL.getrCrewSkjAL().get(i);
//                                /**/
//                                String resthr ="";
//                                resthr = obj.getResthr();
//            
//                                if("SB".equals(obj.getDutycode()))
//                                {
//                                    resthr = "24";          
//                                }
//                                else if ("0026".equals(obj.getDutycode()) | "1026".equals(obj.getDutycode()) | "2026".equals(obj.getDutycode()))
//                                {
//                                    resthr = "36";          
//                                }
//                                else if ("0130".equals(obj.getDutycode()) | "2130".equals(obj.getDutycode()))
//                                {
//                                    resthr = "�@���";         
//                                }
//                                obj.setResthr(resthr);
//                                /**/
//                                if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
//                                    obj.setDetail("Y");
//                                }else{
//                                    obj.setDetail("N");
//                                }
//                                /**/
//                                if(isCheckBox(obj.getDutycode(),obj.getTripno())){
//                                    obj.setChkBox("Y");
//                                }else{
//                                    obj.setChkBox("N");
//                                }            
//                                crewCorssObjAL.getrCrewSkjAL().set(i, obj);
//                            }
//                            /**************************************/
//                            crewCorssObjAL.setResultMsg("1");
//                            crewCorssObjAL.setErrorMsg("Done");
//                        }else{
//                            crewCorssObjAL.setResultMsg("1");
//                            crewCorssObjAL.setErrorMsg("No Data.");
//                        }//null
//                    }else{
//                        crewCorssObjAL.setResultMsg("0");
//                        crewCorssObjAL.setErrorMsg(str);
//                        //ChkSwapWorkday(base);
//                    }
//                }else{
//                    crewSpObjAL.setResultMsg("0");
//                    crewSpObjAL.setErrorMsg(baseObj.getErrMsg());
//                }//baseObj.getStatus()
//           
//            }
        } 
        catch (SQLException e) 
        {
            crewCorssObjAL.setResultMsg("0");
            crewCorssObjAL.setErrorMsg("C"+base+step+":"+e.toString());
        }
        catch(Exception e)
        {
            crewCorssObjAL.setResultMsg("0");
            crewCorssObjAL.setErrorMsg("C"+base+step+":"+e.toString());        
        }
    }
        
    /*3-2. �������G*/
    public void CorssCrDetail(String aEmpno,String rEmpno,String yyyy,String mm,String[] aChoSwapSkj,String[] rChoSwapSkj){
        crewCrossDetailObjAL = new CrewCorssDetailRObj();
        boolean ifpasscnvisa = false;
        if(null == aChoSwapSkj || null == rChoSwapSkj){
            crewCrossDetailObjAL.setResultMsg("0");
            crewCrossDetailObjAL.setErrorMsg("�|����ܯZ��");
        }else{
          
            CorssCrSkj(aEmpno,rEmpno,yyyy,mm);
            if("0".equals(crewCorssObjAL.getResultMsg())){
                crewCrossDetailObjAL.setResultMsg("0");
                crewCrossDetailObjAL.setErrorMsg(crewCorssObjAL.getErrorMsg());
            }else{
                swap3ac.CrewInfoObj aCrewInfoObj = crewCorssObjAL.getaCrewInfoObj();
                swap3ac.CrewInfoObj rCrewInfoObj = crewCorssObjAL.getrCrewInfoObj();
                swap3ackhh.CrewInfoObj aCrewInfoObj2 = crewCorssObjAL.getaCrewInfo2Obj();
                swap3ackhh.CrewInfoObj rCrewInfoObj2 = crewCorssObjAL.getrCrewInfo2Obj();
                ArrayList aCrewSkjAL = crewCorssObjAL.getaCrewSkjAL();
                ArrayList rCrewSkjAL = crewCorssObjAL.getrCrewSkjAL();
                
                try
                {
                    if("TPE".equals(aCrewInfoObj.getBase())){
                        swap3ac.CalcSwapHrs cSHrs = new swap3ac.CalcSwapHrs();        
                        if(!cSHrs.job(aCrewInfoObj,rCrewInfoObj,aCrewSkjAL,rCrewSkjAL,aChoSwapSkj,rChoSwapSkj))
                        {
                            //System.out.print("�|����ܯZ��");
                            crewCrossDetailObjAL.setResultMsg("0");
                            crewCrossDetailObjAL.setErrorMsg("�|����ܯZ��");
                        }
                        else
                        {   
                              //System.out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
                              //System.out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
           
                                //SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
                                SwapCheck sc = new SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap(),yyyy,mm);
                                //***************************************************************
                                CheckValidCNVisa cnv = new CheckValidCNVisa();
                                ifpasscnvisa = cnv.job(aCrewInfoObj,rCrewInfoObj,aCrewSkjAL,rCrewSkjAL,aChoSwapSkj,rChoSwapSkj);
                                //*************************************************************** 
                                if(!sc.isExchangeable())
                                {
            //                                sc.getErrorMsg();
                                    crewCrossDetailObjAL.setResultMsg("0");
                                    crewCrossDetailObjAL.setErrorMsg(sc.getErrorMsg());
                                }else if(!ifpasscnvisa){
                                    crewCrossDetailObjAL.setResultMsg("0");
                                    crewCrossDetailObjAL.setErrorMsg("�ӽд��Z���󤣲šA���i���Z�C��]���G�ӽЪ̩γQ���̥x�M���Ĵ��w�O��");
                                }else{
                                    crewCrossDetailObjAL.setType(1);
                                    crewCrossDetailObjAL.setaCrewSkjAL(cSHrs.getASwapSkjAL());
                                    crewCrossDetailObjAL.setrCrewSkjAL(cSHrs.getRSwapSkjAL());
                                    crewCrossDetailObjAL.setaCrewInfoObj(aCrewInfoObj);
                                    crewCrossDetailObjAL.setrCrewInfoObj(rCrewInfoObj);
                                    
                                    crewCrossDetailObjAL.setaTimes(getaTimes());
                                    crewCrossDetailObjAL.setrTimes(getrTimes());
                                    
                                    crewCrossDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                    crewCrossDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                    crewCrossDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                    
                                    crewCrossDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                    crewCrossDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                    crewCrossDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                    
                                    crewCrossDetailObjAL.setResultMsg("1");
                                    crewCrossDetailObjAL.setErrorMsg("Done");
                                    
                                }
                        }
                            
                    }else if("KHH".equals(aCrewInfoObj2.getBase())){
                        swap3ackhh.CalcSwapHrs cSHrs = new swap3ackhh.CalcSwapHrs();
                        if(!cSHrs.job(aCrewInfoObj2, rCrewInfoObj2, aCrewSkjAL, rCrewSkjAL, aChoSwapSkj, rChoSwapSkj)){
                            crewCrossDetailObjAL.setResultMsg("0");
                            crewCrossDetailObjAL.setErrorMsg("�|����ܯZ��");
                        }else{
                            //out.print("�ӽЪ̴��e���ɡG"+aCrewInfoObj.getPrjcr()+"<br>�Q���̴��e���ɡG"+rCrewInfoObj.getPrjcr()+"<BR>");
                            //out.print("�ӽЪ̴��᭸�ɡG"+cSHrs.getACrAfterSwap()+"<br>�Q���̴��᭸�ɡG"+cSHrs.getRCrAfterSwap()+"<BR>");
                            swap3ackhh.SwapCheck sc = new swap3ackhh.SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
                            
                            if(!sc.isExchangeable()){   //���i���Z
                                crewCrossDetailObjAL.setResultMsg("0");
                                crewCrossDetailObjAL.setErrorMsg(sc.getErrorMsg());
                            }else{  // �ŦX���Z����
                                crewCrossDetailObjAL.setType(2);
                                crewCrossDetailObjAL.setaCrewSkjAL(cSHrs.getASwapSkjAL());
                                crewCrossDetailObjAL.setrCrewSkjAL(cSHrs.getRSwapSkjAL());
                                crewCrossDetailObjAL.setaCrewInfo2Obj(aCrewInfoObj2);
                                crewCrossDetailObjAL.setrCrewInfo2Obj(rCrewInfoObj2);
                                
                                crewCrossDetailObjAL.setaTimes(getaTimes());
                                crewCrossDetailObjAL.setrTimes(getrTimes());
                                
                                crewCrossDetailObjAL.setaSwapTotalCr(cSHrs.getASwapTotalCr());
                                crewCrossDetailObjAL.setaSwapDiffCr(cSHrs.getASwapDiffCr());
                                crewCrossDetailObjAL.setaCrAfterSwap(cSHrs.getACrAfterSwap());
                                
                                crewCrossDetailObjAL.setrSwapTotalCr(cSHrs.getRSwapTotalCr());
                                crewCrossDetailObjAL.setrSwapDiffCr(cSHrs.getRSwapDiffCr());
                                crewCrossDetailObjAL.setrCrAfterSwap(cSHrs.getRCrAfterSwap());
                                
                                crewCrossDetailObjAL.setResultMsg("1");
                                crewCrossDetailObjAL.setErrorMsg("Done");
                            }
                        }
                        
                    }   
                }
                catch ( Exception e )
                {
                    crewCrossDetailObjAL.setResultMsg("0");
                    crewCrossDetailObjAL.setErrorMsg(e.toString());
                }
            }//if("0".equals(crewCorssObjAL.getResultMsg())){            
        }//if(null == aChoSwapSkj || null == rChoSwapSkj)
    }
    
    /**�d��**/
    //4.�d�ߥӽг�
    public void SwapRdList(String year,String empno,String base ){

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        swapRdObjAL = new SwapRdRObj();  
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();

            String sql =" select * from ( select formno,acname,aempno,rcname,checkuser,"
            +"rempno,chg_all,nvl(ed_check,'') ed_check,nvl(comments,'') comments,"
            +"to_char(newdate,'yyyy/mm/dd hh24:mi') newdate,"
            +"nvl(to_char(checkdate,'yyyy/mm/dd hh24:mi'),'') checkdate, 'A' formtype from fztform "
            +"where (aempno = '"+ empno+"' or rempno='"+ empno+"') "
            +"and  formno ";

        if("".equals(year) || null == year)
        {
            sql = sql +" like  to_char(sysdate,'yyyy')||'%' ";

        }
        else
        {
            sql = sql +" like '"+year+"%' ";
        }
        sql = sql + "union all ";
        sql = sql + "select formno,acname,aempno,rcname,checkuser,"
            +"rempno,chg_all,nvl(ed_check,'') ed_check,nvl(comments,'') comments,"
            +"to_char(newdate,'yyyy/mm/dd hh24:mi') newdate,"
            +"nvl(to_char(checkdate,'yyyy/mm/dd hh24:mi'),'') checkdate, 'B' formtype from fztbform "
            +"where (aempno = '"+ empno+"' or rempno='"+ empno+"') "
            +"and  formno ";
        if("".equals(year) || null == year)
        {
            sql = sql +" like  to_char(sysdate,'yyyy')||'%' ";

        }
        else
        {
            sql = sql +" like '"+year+"%' ";
        }

        sql = sql + " ) order by formno desc ";

        rs = stmt.executeQuery(sql);
        while(rs.next())
        {
            SwapRdObj obj = new SwapRdObj();
            obj.setFormnoAL(rs.getString("formno"));
            obj.setaCnameAL(rs.getString("acname"));
            obj.setaEmpnoAL(rs.getString("aempno"));
            obj.setrCnameAL(rs.getString("rcname"));
            obj.setrEmpnoAL(rs.getString("rempno"));       
            obj.setEdCheckAL(rs.getString("ed_check"));
            obj.setCommentsAL(rs.getString("comments")) ;
            obj.setNewDateAL(rs.getString("newdate"));
            obj.setCheckDateAL(rs.getString("checkdate"));
            obj.setChgAllAL(rs.getString("chg_all"));  
            obj.setFormtypeAL(rs.getString("formtype"));
            objAL.add(obj);
        }
        rs.close();
        swapRdObjAL.setSwapRdObjAL(objAL);
        sql="";

        sql = "SELECT To_Char(r.chgdate,'yyyy/mm/dd') chgDate1,r.* FROM fztrform r WHERE yyyy=";
            if("".equals(year) || null == year){
                sql = sql +" to_char(sysdate,'yyyy') ";

            }else{
                sql = sql +" '"+year+"' ";
            }
        sql +=" AND ( aempno ='"+empno+"' OR rempno = '"+empno+"') order by formno";


            rs = stmt.executeQuery(sql);
            
        //out.println(sql+"<br>");

        objAL = null;
        objAL = new ArrayList();
        while(rs.next())
        {
            RealSwapRdObj obj = new RealSwapRdObj();
            obj.setAComm(rs.getString("acomm"));
            obj.setACount(rs.getString("aCount"));
            obj.setAEmpno(rs.getString("aempno"));
            obj.setChgDate(rs.getString("chgDate1"));
            obj.setChgUser(rs.getString("chguser"));
            obj.setFormno(rs.getString("formno"));
            obj.setMonth(rs.getString("mm"));
            obj.setRComm(rs.getString("rcomm"));
            obj.setRCount(rs.getString("rcount"));
            obj.setREmpno(rs.getString("rempno"));
            obj.setYear(rs.getString("yyyy"));
            objAL.add(obj);
        }
        swapRdObjAL.setRealSwapRdObjAL(objAL);

        if(!(swapRdObjAL.getRealSwapRdObjAL().size() > 0) || !(swapRdObjAL.getSwapRdObjAL().size() > 0)){
            swapRdObjAL.setResultMsg("1");
            swapRdObjAL.setErrorMsg("No Data.");
        }else{
            swapRdObjAL.setResultMsg("1");
            swapRdObjAL.setErrorMsg("Done.");
        }
        }catch (SQLException e){
//            System.out.print(e.toString());
            swapRdObjAL.setResultMsg("0");
            swapRdObjAL.setErrorMsg("SwapRD"+e.toString());

        }catch (Exception e){
//            System.out.print(e.toString());
            swapRdObjAL.setResultMsg("0");
            swapRdObjAL.setErrorMsg("SwapRD"+e.toString());

        }
        finally
        {
            try{if(rs != null) rs.close();}catch(SQLException e){}
            try{if(stmt != null) stmt.close();}catch(SQLException e){}
            try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    } 
    
    //5.�d�ߴ��Z���ɸպ�&���Z detail
    public void SwapTripDetail(String tripno){
        // TripInfoObj obj = (TripInfoObj)dataAL.get(i);
        tripObjAL = new TripInfoRObj();        
        TripInfo ti = new TripInfo(tripno);
        String bgColor= "";
        try{
            ti.SelectData();
            tripObjAL.setTripInfoObj(ti.getTripnoAL());
            tripObjAL.setResultMsg("1");
            tripObjAL.setErrorMsg("Done");
        }catch(Exception e){
            //System.out.print(e.toString());
            tripObjAL.setResultMsg("0");
            tripObjAL.setErrorMsg(e.toString());
        }        
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }
   
    public CrewSwapRObj getCrewSpObjAL()
    {
        return crewSpObjAL;
    }
    public void setCrewSpObjAL(CrewSwapRObj crewSpObjAL)
    {
        this.crewSpObjAL = crewSpObjAL;
    }
    public CrewSwapDetailRObj getCrewSpDetailObjAL()
    {
        return crewSpDetailObjAL;
    }
    public void setCrewSpDetailObjAL(CrewSwapDetailRObj crewSpDetailObjAL)
    {
        this.crewSpDetailObjAL = crewSpDetailObjAL;
    }
    public CrewSwapCreditRObj getCrewCtObjAL()
    {
        return crewCtObjAL;
    }
    public void setCrewCtObjAL(CrewSwapCreditRObj crewCtObjAL)
    {
        this.crewCtObjAL = crewCtObjAL;
    }
    public CrewSwapCreditDetailRObj getCrewCtDetailObjAL()
    {
        return crewCtDetailObjAL;
    }
    public void setCrewCtDetailObjAL(CrewSwapCreditDetailRObj crewCtDetailObjAL)
    {
        this.crewCtDetailObjAL = crewCtDetailObjAL;
    } 
    public CrewCorssCrRObj getCrewCorssObjAL()
    {
        return crewCorssObjAL;
    }
    public void setCrewCorssObjAL(CrewCorssCrRObj crewCorssObjAL)
    {
        this.crewCorssObjAL = crewCorssObjAL;
    }
    public CrewCorssDetailRObj getCrewCrossDetailObjAL()
    {
        return crewCrossDetailObjAL;
    }
    public void setCrewCrossDetailObjAL(CrewCorssDetailRObj crewCrossDetailObjAL)
    {
        this.crewCrossDetailObjAL = crewCrossDetailObjAL;
    }
    public SwapRdRObj getSwapRdObjAL()
    {
        return swapRdObjAL;
    }
    public void setSwapRdObjAL(SwapRdRObj swapRdObjAL)
    {
        this.swapRdObjAL = swapRdObjAL;
    }


    public TripInfoRObj getTripObjAL()
    {
        return tripObjAL;
    }

    public void setTripObjAL(TripInfoRObj tripObjAL)
    {
        this.tripObjAL = tripObjAL;
    }

    public int getaTimes()
    {
        return aTimes;
    }

    public void setaTimes(int aTimes)
    {
        this.aTimes = aTimes;
    }

    public int getrTimes()
    {
        return rTimes;
    }

    public void setrTimes(int rTimes)
    {
        this.rTimes = rTimes;
    }

    
}
