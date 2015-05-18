package ws.crew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import swap3ac.ApplyCheck;
import swap3ac.CheckFullAttendance;
import swap3ac.CheckValidCNVisa;
import swap3ac.CrewCrossCr;
import swap3ac.CrewSkjObj;
import swap3ac.CrewSwapSkj;
import swap3ac.RestHourObj;
import swap3ac.SwapCheck;
import swap3ac.TripInfo;
import ci.db.ConnectionHelper;
import credit.CheckFormTimes;
import credit.CreditList;
import credit.CreditObj;

public class CrewSwapFunALL {

	/**
	 * @param args
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
	    int times = 4;
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
//	        fun.SwapSkj(aE,rE,year,mm);
//	        CrewInfoObj a = fun.crewSpObjAL.getaCrewInfoObj();
//	        CrewInfoObj r =fun.crewSpObjAL.getrCrewInfoObj();
//	        ArrayList objAL1 = fun.crewSpObjAL.getaCrewSkjAL();
//	        ArrayList objAL2 = fun.crewSpObjAL.getrCrewSkjAL();
//	        fun.SwapDetail(year, mm, a, r, objAL1, objAL2, aChoSwapSkj, rChoSwapSkj);
//	        fun.ChkCrewBase("636263","633033");
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
	    
	    /*step0-1-1.    �Pbase�~�i�H����*/
	    public StatusObj ChkCrewBase(String aEmpno,String[] rEmpno){
	        StatusObj obj = new StatusObj(); 
	        fzac.CrewInfo c = new fzac.CrewInfo(aEmpno);
            fzac.CrewInfoObj obja = null;
            if (c.isHasData()) 
            {
                obja = c.getCrewInfo();
            }
	        if(null!= rEmpno && rEmpno.length > 0 ){
	        	for(int i=0;i<rEmpno.length;i++){
		        	if(aEmpno.equals(rEmpno[i])){
			            obj.setStatus(0);
			            obj.setErrMsg("���i�P�ۤv���Z.");
			            break;
			        }else{
			                     
			            c = null;
			            c = new fzac.CrewInfo(rEmpno[i]);
			            fzac.CrewInfoObj objr = null;
			            if (c.isHasData()) 
			            {
			                objr = c.getCrewInfo();
			            } 	
			            if (obja != null && objr != null && "N".equals(obja.getFd_ind()) && "N".equals(objr.getFd_ind()) ) {
			                //���խ��򥻸��,�B���῵�խ�        
			                 if (!obja.getBase().equals(objr.getBase())) {
			                     obj.setStatus(0);
			                     obj.setErrMsg("���o�ӽлP��L Base�խ����Z."+objr.getEmpno());
			                     break;
			                }else if ((!"TPE".equals(obja.getBase()) && !"KHH".equals(obja.getBase())) || (!"TPE".equals(objr.getBase()) && !"KHH".equals(objr.getBase()))  ) {
			                    obj.setStatus(0);
			                    obj.setErrMsg("�|���}��~���խ��ϥδ��Z�\��."+objr.getEmpno());
			                    break;
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
			                        break;
			                    }                
			                }
			            } else {
			                if(obja == null || !"N".equals(obja.getFd_ind())){
			                    obj.setStatus(0);
			                    obj.setErrMsg(aEmpno +" �D���ĭ��u��.");
			                    break;
			                }
			                if(objr == null || !"N".equals(objr.getFd_ind())){
			                    obj.setStatus(0);
			                    obj.setErrMsg(rEmpno +" �D���ĭ��u��.");
			                    break;
			                }        
			            }
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
//	    if (!"B1".equals(obj.getDutycode())
//	            && !"EE".equals(obj.getDutycode())
//	            && !"MT".equals(obj.getDutycode())
//	            && !"CT".equals(obj.getDutycode())
//	            && !"FT".equals(obj.getDutycode())
//	            && !"B2".equals(obj.getDutycode())
//	            && !"GS".equals(obj.getDutycode())
//	            && !"BL".equals(obj.getDutycode())
//	            && ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) 
//	        || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) || "XL".equals(obj.getDutycode()) || "LVE".equals(obj.getDutycode())))))
//	    {
	    }

	   
	    /**�ӽг�&�n�I**//*step1-1.TPE ���Z��� �ˬd*/
	    public String ChkSwapInfoTPE(String aEmpno,String rEmpno,String yyyy,String mm){
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
//	            //�ˬd�Z��O�_����
	            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
	            ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
	            //***********************************************************************
	            
	            if(!pc.isPublished()){
	                //�Z��O�_����
	                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
	            }else
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
	    
	    /**�ӽг�A**/ /*�ˬdA����*/
	    public String FullAttforA(String aEmpno,String yyyy,String mm,int aTimes){
	    	String str = "";
	    	//�ӽЪ̬O�_����
            CheckFullAttendance acs = new CheckFullAttendance(aEmpno, yyyy+mm);
            String a_isfullattendance = acs.getCheckMonth();
            String displaystr = "";
            if(!"Y".equals(a_isfullattendance))
            {
                displaystr = a_isfullattendance;
            }
            if (!"Y".equals(a_isfullattendance)){
                //�䤤�@�H�S������
                str=displaystr; 
            }else if (aTimes >=times ){ 
                // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
                str="�ӽЪ�("+aEmpno+")"+yyyy+"/"+mm+ "�ӽЦ��Ƥw�W�L"+times+"��, �t�Τ����z����.";
            }else {
                setaTimes(aTimes);
                str = "Y";
            } 
            //***********************************************************************
            return str;
	    }
	    
	    /**�ӽг�R**/ /*�ˬdR����*/
	    /*public String FullAttforR(String rEmpno,String yyyy,String mm,int rTimes){
	    	String str = "";
            //�Q���̬O�_����
            CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, yyyy+mm);
            String r_isfullattendance = rcs.getCheckMonth();
            String displaystr = "";
           
            if(!"Y".equals(r_isfullattendance))
            {
                displaystr = r_isfullattendance;
            }
            if (!"Y".equals(r_isfullattendance)){
                //�䤤�@�H�S������
                str=displaystr; 
            }else if (rTimes >=times ){ 
                // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
                str="�Q����("+rEmpno+")"+yyyy+"/"+mm+ "�ӽЦ��Ƥw�W�L"+times+"��, �t�Τ����z����.";    
            }else {
                setaTimes(aTimes);
                setrTimes(rTimes);
                str = "Y";
            } 
            //***********************************************************************
            return str;
	    }*/
	    
	    /**A�n�I**/ /*A�n�I��� �ˬd*/
	    public String CreditAvlforA(String aEmpno,String yyyy,String mm){
	    	crewCtObjAL = new CrewSwapCreditRObj();
	    	String str = "N";
	    	CreditList aCl = new CreditList();
	        aCl.getCreditList("N",aEmpno);
	        if(aCl.getObjAL()!=null  && aCl.getObjAL().size() > 0){
	        	objAL = aCl.getObjAL();
	        	str ="Y";
	        }//if(aCl.getObjAL()!=null  && aCl.getObjAL().size() > 0)
	        else{
	            str = aEmpno+"�L�i�οn�I";
	        }
	        return str;
	    }
	    
	    /**R�n�I**/ /*R�n�I��� �ˬd*/
	    public String CreditAvlforR(String rEmpno,String yyyy,String mm){
	    	crewCtObjAL = new CrewSwapCreditRObj(); 
	    	String str = "N";
	    	//check rEmpno �ӽг� or �n�I
            CheckFormTimes ck = new CheckFormTimes();
            str = ck.get3FormTimes(rEmpno, yyyy , mm);
            if("N".equals(str))
            {
                //N:rEmpno �i�ϥΥӽг洫�Z("Y".equals(r_isfullattendance)  && times <4)
                crewCtObjAL.setrEmpnoAvb(2);
                str = "Y";
            }
            else if("Y".equals(str))
            {
                //Y:�Q���̥�����  or �Q���̷��ӽЦ��ư���4��,�~��οn�I
                CreditList rCl = new CreditList();
                rCl.getCreditList("N",rEmpno);
                if(rCl.getObjAL()!=null  && rCl.getObjAL().size() > 0){
                    //rEmpno �ݥοn�I
                	objAL = rCl.getObjAL();
    	        	str ="Y";
                }
            }
            else{
                str = ck.getErrorstr();
            }    
	        return str;
	    }
	   	
	    /*���o�Z�� */
	    public void SwapSkjTPE(String aEmpno,String rEmpno,String yyyy,String mm){
	        String str = "N";
	        String step = "";
	        String base ="";
	        crewSpObjAL = new CrewSwapRObj();
	        try 
	        { 
//	              �Z��
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
	        } catch (SQLException e) {
	            crewSpObjAL.setResultMsg("0");
	            crewSpObjAL.setErrorMsg(base+step+":"+e.toString()); 
	        }catch(Exception e){
	            crewSpObjAL.setResultMsg("0");
	            crewSpObjAL.setErrorMsg(base+step+":"+e.toString());
	        }finally{
	          //log
//	               System.out.println(crewObjAL.getErrorMsg());
	        }
	           
	    }
	    
	    /*�����T�{*/
	     public void SwapDetail(String aEmpno,String rEmpno,String yyyy,String mm,String[] aChoSwapSkj,String[] rChoSwapSkj)
	    //(String year ,String month ,CrewInfoObj aCrewInfoObj,CrewInfoObj rCrewInfoObj,
//	            ArrayList aCrewSkjAL , ArrayList rCrewSkjAL ,String[] aChoSwapSkj,String[] rChoSwapSkj)
	    {
	        crewSpDetailObjAL = new CrewSwapDetailRObj();
	        boolean ifpasscnvisa = false;
	        if(null == aChoSwapSkj || null == rChoSwapSkj){
	            crewSpDetailObjAL.setResultMsg("0");
	            crewSpDetailObjAL.setErrorMsg("�|����ܯZ��");
	        }else{
	            SwapSkjTPE(aEmpno,rEmpno,yyyy,mm);
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

	     
	    /**�պ�**/
	    /*3-1* TPE & KHH �պ���:�O�_�T��Z&�Z��O�_����&��w*/
	    public String CorssCr(String aEmpno,String[] rEmpno,String yyyy,String mm){
	        String str = "N";
	        //�O�_�T��Z
	        ApplyCheckMuti ac = new ApplyCheckMuti();
	        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
	        if(ac.isNoSwap())
	        {
	            str = ac.getNoSwapStr();
	        }
	        else
	        {
	            //�ˬd�Z��O�_����
	            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
	            //***********************************************************************
	            if(!pc.isPublished()){
	                //�Z��O�_����
	                str=yyyy+"/"+mm +"�Z��|�����������A�t�Τ����z����.";
	            }else if(ac.isALocked()){
	                //�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
	                str="�ӽЪ�("+rEmpno+") �Z����w���A,���o�d��.�]����ݳ]�w�Z���}�񪬺A,��i�ϥέ��ɸպ�d�ߥ\��^.";
	            }else if(ac.isRLocked()){
	                //�Q���̯Z����w
	                str="�Q����("+ac.getrLockedStr()+") �Z����w���A,���o�d��.�]����ݳ]�w�Z���}�񪬺A,��i�ϥέ��ɸպ�d�ߥ\��^.";
	            }else {
	                str = "Y";
	            }   
	        }
	        return str;
	    }
	    
	    /*3-2. ���Z  ���ɸպ�Z��*/
	    public void CorssCrSkjTPE(String aEmpno,String rEmpno,String yyyy,String mm){ 
	        crewCorssObjAL = new CrewCorssCrRObj();
	        String step = "";
	        String base = "";
	        String str ="";
	        try 
	        {
	          //step0.
                base = "TPE";
                step = "1";      
//	                      �Z��
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
                if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
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
                    crewCorssObjAL.setResultMsg("1");
                    crewCorssObjAL.setErrorMsg("No Data.");
                }//null 

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
	    
	    public void CorssCrSkjKHH(String aEmpno,String rEmpno,String yyyy,String mm){ 
	        crewCorssObjAL = new CrewCorssCrRObj();
	        String step = "";
	        String base = "";
	        String str ="";
	        try 
	        {
	          //step0.
	          base = "KHH";
              step = "1";
//            �Z��
              /**************************************/
              step = "Sch";
              swap3ackhh.CrewCrossCr csk = new swap3ackhh.CrewCrossCr(aEmpno, rEmpno, yyyy, mm);
              csk.SelectData();     
              if(null != csk.getACrewInfoObj() && null != csk.getRCrewInfoObj()){
//                     crewObjAL.setCrewInfoAL(objAL);
                  crewCorssObjAL.setaCrewInfo2Obj(csk.getACrewInfoObj());
                  crewCorssObjAL.setrCrewInfo2Obj(csk.getRCrewInfoObj());        
                  crewCorssObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                  crewCorssObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());
                  /*�ӽЪ�*/
                  for(int i=0;i<crewCorssObjAL.getaCrewSkjAL().size();i++){
                      swap3ackhh.CrewSkjObj obj =(swap3ackhh.CrewSkjObj) crewCorssObjAL.getaCrewSkjAL().get(i); 
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
                      crewCorssObjAL.getaCrewSkjAL().set(i, obj);
                  }
                  /*�Q����*/
                  for(int i=0;i<crewCorssObjAL.getrCrewSkjAL().size();i++){
                      swap3ackhh.CrewSkjObj obj = (swap3ackhh.CrewSkjObj) crewCorssObjAL.getrCrewSkjAL().get(i);
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
                      crewCorssObjAL.getrCrewSkjAL().set(i, obj);
                  }
                  /**************************************/
                  crewCorssObjAL.setResultMsg("1");
                  crewCorssObjAL.setErrorMsg("Done");
                  }else{
                      crewCorssObjAL.setResultMsg("1");
                      crewCorssObjAL.setErrorMsg("No Data.");
                  }//null                 

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
	    public void CorssCrDetail(String aEmpno,String abase ,String rEmpno,String yyyy,String mm,String[] aChoSwapSkj,String[] rChoSwapSkj){
	        crewCrossDetailObjAL = new CrewCorssDetailRObj();
	        boolean ifpasscnvisa = false;
	        if(null == aChoSwapSkj || null == rChoSwapSkj){
	            crewCrossDetailObjAL.setResultMsg("0");
	            crewCrossDetailObjAL.setErrorMsg("�|����ܯZ��");
	        }else{
	        	if("TPE".equals(abase)){
	        		CorssCrSkjTPE(aEmpno,rEmpno,yyyy,mm);
	        	}else{
	        		CorssCrSkjKHH(aEmpno,rEmpno,yyyy,mm);
	        	}
	            
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

	    public void setrTimes(int rTimes){
	        this.rTimes = rTimes;
	    }

}
