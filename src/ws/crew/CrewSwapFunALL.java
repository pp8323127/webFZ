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
	      
	    /*step0-1.    同base才可以互換*/
	    public StatusObj ChkCrewBase(String aEmpno,String rEmpno){
	        StatusObj obj = new StatusObj(); 
	        if(aEmpno.equals(rEmpno)){
	            obj.setStatus(0);
	            obj.setErrMsg("不可與自己換班.");
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
	                //有組員基本資料,且為後艙組員        
	                 if (!obja.getBase().equals(objr.getBase())) {
	                     obj.setStatus(0);
	                     obj.setErrMsg("不得申請與其他 Base組員換班.");
	                }else if ((!"TPE".equals(obja.getBase()) && !"KHH".equals(obja.getBase())) || (!"TPE".equals(objr.getBase()) && !"KHH".equals(objr.getBase()))  ) {
	                    obj.setStatus(0);
	                    obj.setErrMsg("尚未開放外站組員使用換班功能.");
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
	                    obj.setErrMsg(aEmpno +" 非有效員工號.");
	                }
	                if(objr == null || !"N".equals(objr.getFd_ind())){
	                    obj.setStatus(0);
	                    obj.setErrMsg(rEmpno +" 非有效員工號.");
	                }        
	            }
	        }
	        return obj;
	    }
	    
	    /*step0-1-1.    同base才可以互換*/
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
			            obj.setErrMsg("不可與自己換班.");
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
			                //有組員基本資料,且為後艙組員        
			                 if (!obja.getBase().equals(objr.getBase())) {
			                     obj.setStatus(0);
			                     obj.setErrMsg("不得申請與其他 Base組員換班."+objr.getEmpno());
			                     break;
			                }else if ((!"TPE".equals(obja.getBase()) && !"KHH".equals(obja.getBase())) || (!"TPE".equals(objr.getBase()) && !"KHH".equals(objr.getBase()))  ) {
			                    obj.setStatus(0);
			                    obj.setErrMsg("尚未開放外站組員使用換班功能."+objr.getEmpno());
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
			                    obj.setErrMsg(aEmpno +" 非有效員工號.");
			                    break;
			                }
			                if(objr == null || !"N".equals(objr.getFd_ind())){
			                    obj.setStatus(0);
			                    obj.setErrMsg(rEmpno +" 非有效員工號.");
			                    break;
			                }        
			            }
			        }
		        }
	        
	        }
	        return obj;
	    }
	    /*step0-2.    上班日確認 */
	    public String ChkSwapWorkday(String base,String yyyy,String mm){
	        String str = "N";
	        //檢查班表是否公布
	        swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
	        if(!pc.isPublished()){
	            //班表是否公布
	            str=yyyy+"/"+mm +"班表尚未正式公布，系統不受理遞單.";
	        }else{
	            if("TPE".equals(base)){
	                swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
	                ac.SelectDateAndCount();
	                if( ac.isLimitedDate()){//非工作日
	                    str="系統目前不受理換班，請於"+ac.getLimitenddate()+"後開始遞件可能原因為：1.例假日2.緊急事故(颱風)";
	                }else if( ac.isOverMax()){ //超過處理上限
	                    str="已超過系統單日處理上限！請於工作日16:00開始遞件.";
	                }else{
	                    str = "Y";
	                }
	            }else if("KHH".equals(base)) {
	                swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
	                ac.SelectDateAndCount();
	                if(ac.isLimitedDate()){//非工作日
	                    str="系統目前不受理換班，請於"+ac.getLimitenddate()+"後開始遞件可能原因為：1.例假日2.緊急事故(颱風)";
	                }else if( ac.isOverMax()){ //超過處理上限
	                    str="已超過系統單日處理上限！請於工作日17:30開始遞件.";
	                }else{
	                    str = "Y";
	                }
	            }else{
	                str = "BASE錯誤";
	            }
	        }       
	        return str;
	    }
	    
	    /*step0-3.    基本查詢 */
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
	    
	    /*A.        班表是否顯示checkBox*/
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

	   
	    /**申請單&積點**//*step1-1.TPE 換班資格 檢查*/
	    public String ChkSwapInfoTPE(String aEmpno,String rEmpno,String yyyy,String mm){
	        String str = "N";
	        //是否禁止換班
	        swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
	        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;

	        if(ac.isNoSwap())
	        {
	            str = ac.getNoSwapStr();
	        }
	        else
	        {
//	            //檢查班表是否公布
	            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
	            ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,yyyy,mm);
	            //***********************************************************************
	            
	            if(!pc.isPublished()){
	                //班表是否公布
	                str=yyyy+"/"+mm +"班表尚未正式公布，系統不受理遞單.";
	            }else
                if(ac.isUnCheckForm()){ 
	                //有申請單尚未核可，不可申請
	                str=" 申請者("+aEmpno+")或被換者( "+rEmpno+")有申請單尚未經ED核可,系統不受理遞單.";
	            }else if(ac.isALocked()){
	                //申請者班表鎖定,(正常狀況應該不會發生，鎖定者看不到換班的功能選項)
	                str="申請者("+rEmpno+") 班表為鎖定狀態,系統不受理遞單.（換班雙方需設定班表為開放狀態,方可使用換班功能）.";
	            }else if(ac.isRLocked()){
	                //被換者班表鎖定
	                str="被換者("+rEmpno+") 班表為鎖定狀態,系統不受理遞單.（換班雙方需設定班表為開放狀態,方可使用換班功能）.";
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
	                {//有一為屆退人員，使用applicantRetire.jsp
	                    str = "申請者("+aEmpno+") 或 被換者("+rEmpno+") 已列為排/換班控管人員名單，請親洽空服派遣部以人工遞單方式處理，謝謝！";
	                }
	            }// if("Y".equals(str))*/
	        }
	        return str;
	    }
	    
	    /**申請單A**/ /*檢查A全勤*/
	    public String FullAttforA(String aEmpno,String yyyy,String mm,int aTimes){
	    	String str = "";
	    	//申請者是否全勤
            CheckFullAttendance acs = new CheckFullAttendance(aEmpno, yyyy+mm);
            String a_isfullattendance = acs.getCheckMonth();
            String displaystr = "";
            if(!"Y".equals(a_isfullattendance))
            {
                displaystr = a_isfullattendance;
            }
            if (!"Y".equals(a_isfullattendance)){
                //其中一人沒有全勤
                str=displaystr; 
            }else if (aTimes >=times ){ 
                // 申請者當月申請次數高於3次，不可申請
                str="申請者("+aEmpno+")"+yyyy+"/"+mm+ "申請次數已超過"+times+"次, 系統不受理遞單.";
            }else {
                setaTimes(aTimes);
                str = "Y";
            } 
            //***********************************************************************
            return str;
	    }
	    
	    /**申請單R**/ /*檢查R全勤*/
	    /*public String FullAttforR(String rEmpno,String yyyy,String mm,int rTimes){
	    	String str = "";
            //被換者是否全勤
            CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, yyyy+mm);
            String r_isfullattendance = rcs.getCheckMonth();
            String displaystr = "";
           
            if(!"Y".equals(r_isfullattendance))
            {
                displaystr = r_isfullattendance;
            }
            if (!"Y".equals(r_isfullattendance)){
                //其中一人沒有全勤
                str=displaystr; 
            }else if (rTimes >=times ){ 
                // 被換者當月申請次數高於3次，不可申請
                str="被換者("+rEmpno+")"+yyyy+"/"+mm+ "申請次數已超過"+times+"次, 系統不受理遞單.";    
            }else {
                setaTimes(aTimes);
                setrTimes(rTimes);
                str = "Y";
            } 
            //***********************************************************************
            return str;
	    }*/
	    
	    /**A積點**/ /*A積點資格 檢查*/
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
	            str = aEmpno+"無可用積點";
	        }
	        return str;
	    }
	    
	    /**R積點**/ /*R積點資格 檢查*/
	    public String CreditAvlforR(String rEmpno,String yyyy,String mm){
	    	crewCtObjAL = new CrewSwapCreditRObj(); 
	    	String str = "N";
	    	//check rEmpno 申請單 or 積點
            CheckFormTimes ck = new CheckFormTimes();
            str = ck.get3FormTimes(rEmpno, yyyy , mm);
            if("N".equals(str))
            {
                //N:rEmpno 可使用申請單換班("Y".equals(r_isfullattendance)  && times <4)
                crewCtObjAL.setrEmpnoAvb(2);
                str = "Y";
            }
            else if("Y".equals(str))
            {
                //Y:被換者未全勤  or 被換者當月申請次數高於4次,才能用積點
                CreditList rCl = new CreditList();
                rCl.getCreditList("N",rEmpno);
                if(rCl.getObjAL()!=null  && rCl.getObjAL().size() > 0){
                    //rEmpno 需用積點
                	objAL = rCl.getObjAL();
    	        	str ="Y";
                }
            }
            else{
                str = ck.getErrorstr();
            }    
	        return str;
	    }
	   	
	    /*取得班表 */
	    public void SwapSkjTPE(String aEmpno,String rEmpno,String yyyy,String mm){
	        String str = "N";
	        String step = "";
	        String base ="";
	        crewSpObjAL = new CrewSwapRObj();
	        try 
	        { 
//	              班表
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
                    /*申請者*/
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
                    /*被換者*/
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
	    
	    /*互換確認*/
	     public void SwapDetail(String aEmpno,String rEmpno,String yyyy,String mm,String[] aChoSwapSkj,String[] rChoSwapSkj)
	    //(String year ,String month ,CrewInfoObj aCrewInfoObj,CrewInfoObj rCrewInfoObj,
//	            ArrayList aCrewSkjAL , ArrayList rCrewSkjAL ,String[] aChoSwapSkj,String[] rChoSwapSkj)
	    {
	        crewSpDetailObjAL = new CrewSwapDetailRObj();
	        boolean ifpasscnvisa = false;
	        if(null == aChoSwapSkj || null == rChoSwapSkj){
	            crewSpDetailObjAL.setResultMsg("0");
	            crewSpDetailObjAL.setErrorMsg("尚未選擇班次");
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
	                            //System.out.print("尚未選擇班次");
	                            crewSpDetailObjAL.setResultMsg("0");
	                            crewSpDetailObjAL.setErrorMsg("尚未選擇班次");
	                        }
	                        else
	                        {   
	                              //System.out.print("申請者換前飛時："+aCrewInfoObj.getPrjcr()+"<br>被換者換前飛時："+rCrewInfoObj.getPrjcr()+"<BR>");
	                              //System.out.print("申請者換後飛時："+cSHrs.getACrAfterSwap()+"<br>被換者換後飛時："+cSHrs.getRCrAfterSwap()+"<BR>");
	           
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
	                                    crewSpDetailObjAL.setErrorMsg("申請換班條件不符，不可換班。原因為：申請者或被換者台胞証效期已逾期");
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

	     
	    /**試算**/
	    /*3-1* TPE & KHH 試算資格:是否禁止換班&班表是否公布&鎖定*/
	    public String CorssCr(String aEmpno,String[] rEmpno,String yyyy,String mm){
	        String str = "N";
	        //是否禁止換班
	        ApplyCheckMuti ac = new ApplyCheckMuti();
	        ac.swapRulesCheck(aEmpno, rEmpno, yyyy, mm) ;
	        if(ac.isNoSwap())
	        {
	            str = ac.getNoSwapStr();
	        }
	        else
	        {
	            //檢查班表是否公布
	            swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy, mm);
	            //***********************************************************************
	            if(!pc.isPublished()){
	                //班表是否公布
	                str=yyyy+"/"+mm +"班表尚未正式公布，系統不受理遞單.";
	            }else if(ac.isALocked()){
	                //申請者班表鎖定,(正常狀況應該不會發生，鎖定者看不到換班的功能選項)
	                str="申請者("+rEmpno+") 班表為鎖定狀態,不得查詢.（雙方需設定班表為開放狀態,方可使用飛時試算查詢功能）.";
	            }else if(ac.isRLocked()){
	                //被換者班表鎖定
	                str="被換者("+ac.getrLockedStr()+") 班表為鎖定狀態,不得查詢.（雙方需設定班表為開放狀態,方可使用飛時試算查詢功能）.";
	            }else {
	                str = "Y";
	            }   
	        }
	        return str;
	    }
	    
	    /*3-2. 換班  飛時試算班表*/
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
//	                      班表
                /**************************************/
                step = "1Sch";
                CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, yyyy, mm);
                csk.SelectData();
                crewCorssObjAL.setaCrewInfoObj(csk.getACrewInfoObj());
                crewCorssObjAL.setrCrewInfoObj(csk.getRCrewInfoObj());        
                crewCorssObjAL.setaCrewSkjAL(csk.getACrewSkjAL());
                crewCorssObjAL.setrCrewSkjAL(csk.getRCrewSkjAL());

                String resthr ="";
                /*申請者*/
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
		            /*被換者*/
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
//            班表
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
                  /*申請者*/
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
                          resthr = "一曆日";         
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
                  /*被換者*/
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
                          resthr = "一曆日";         
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
	    
	    /*3-2. 互換結果*/
	    public void CorssCrDetail(String aEmpno,String abase ,String rEmpno,String yyyy,String mm,String[] aChoSwapSkj,String[] rChoSwapSkj){
	        crewCrossDetailObjAL = new CrewCorssDetailRObj();
	        boolean ifpasscnvisa = false;
	        if(null == aChoSwapSkj || null == rChoSwapSkj){
	            crewCrossDetailObjAL.setResultMsg("0");
	            crewCrossDetailObjAL.setErrorMsg("尚未選擇班次");
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
	                            //System.out.print("尚未選擇班次");
	                            crewCrossDetailObjAL.setResultMsg("0");
	                            crewCrossDetailObjAL.setErrorMsg("尚未選擇班次");
	                        }
	                        else
	                        {   
	                              //System.out.print("申請者換前飛時："+aCrewInfoObj.getPrjcr()+"<br>被換者換前飛時："+rCrewInfoObj.getPrjcr()+"<BR>");
	                              //System.out.print("申請者換後飛時："+cSHrs.getACrAfterSwap()+"<br>被換者換後飛時："+cSHrs.getRCrAfterSwap()+"<BR>");
	           
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
	                                    crewCrossDetailObjAL.setErrorMsg("申請換班條件不符，不可換班。原因為：申請者或被換者台胞証效期已逾期");
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
	                            crewCrossDetailObjAL.setErrorMsg("尚未選擇班次");
	                        }else{
	                            //out.print("申請者換前飛時："+aCrewInfoObj.getPrjcr()+"<br>被換者換前飛時："+rCrewInfoObj.getPrjcr()+"<BR>");
	                            //out.print("申請者換後飛時："+cSHrs.getACrAfterSwap()+"<br>被換者換後飛時："+cSHrs.getRCrAfterSwap()+"<BR>");
	                            swap3ackhh.SwapCheck sc = new swap3ackhh.SwapCheck(aCrewInfoObj.getPrjcr(),rCrewInfoObj.getPrjcr(),cSHrs.getACrAfterSwap(),cSHrs.getRCrAfterSwap());
	                            
	                            if(!sc.isExchangeable()){   //不可換班
	                                crewCrossDetailObjAL.setResultMsg("0");
	                                crewCrossDetailObjAL.setErrorMsg(sc.getErrorMsg());
	                            }else{  // 符合換班條件
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
