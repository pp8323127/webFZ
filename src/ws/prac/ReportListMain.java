package ws.prac;

import java.text.*;
import java.util.*;

import javax.jws.*;

import ws.*;
import ws.header.*;
import ws.personal.*;
import ws.personal.css.*;
import ws.personal.mvc.*;
import ws.personal.reFun.*;
import ws.prac.FltInfo.FltInfoFun;
import ws.prac.FltInfo.FltInfoRObj;
import ws.prac.PA.PAEvalCrewRObj;
import ws.prac.PA.PAEvalItemRObj;
import ws.prac.PA.PAFun;
import ws.prac.SFLY.PRProjRObj;
import ws.prac.SFLY.PRSFlyRObj;
import ws.prac.SFLY.PRfltChkItemRObj;
import ws.prac.SFLY.PSFlyFactorRObj;
import ws.prac.SFLY.SFLYRptFun;
import ws.prac.SFLY.MP.*;

import ws.prac.ZC.*;
import ws.prac.ftp.*;


@WebService


public class ReportListMain {

	/**
	 * @param args
	 * Cabin iService (I) : 1~23.
	 */
    
    /**
     * @param args
     * Cabin iService (II) 2-1~
     * 1.回傳客戶資料:MVC & CSS內容
     * 2.回傳選項
     * 3.存回DB
     * 4.回傳客戶資料:MVC & CSS內容(新格式)
     */
    
    /**
     * @param args
     * Cabin iService (II) 3-1~
     * 3-1 取得事務長ZC(PR)報告
     * 3-2.ZC Irr all item list
     * 3-3.ZC get upload filename from egtzcfile
     * 3-4.ZC 考評項目
     * 3-5.ZC save rpt
     * 3-6.ZC send rpt
     */
    
    /**
     * @param args
     * Cabin iService (II) 4-1~
     * 4-1. MP 1.Cabin Safety check Item
     * 4-2 MP. 2.Self Inspection Item
     * 4-3 MP. 3.Evaluation
     */
    private CusRObj perAL = null;
    private CusItemsRObj itemAL = null;
    
    private ProvidCssRObj cssAL = null;
    private ProvidCusRObj cusAL = null;
    
    private CusDetailRObj perAL2 = null;//依西川格式要求
    private SavaCusRObj saveAL = null;
    private SimpleDateFormat ft = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    private String startTime = null;
    private String endTime = null;
    
	public static void main(String[] args) {
		ReportListMain m = new ReportListMain();
		m.getReportListFlt("630304", "2015", "01", "");
//		 m.getPRChkItem("630304", "2013/06/03", "0018", "NRTHNL");
//		m.getPACrewData("2013/06/03", "0019", "NRTHNL", "630488");
//		System.out.println(m. getEmpInfo("630304/643937/633020", "sdfdf").getResultMsg());
	    
		 System.out.println("Done.");
	 }
	// 1.傳回當月班表
	public ReportListFltRObj getReportListFlt(String empno, String yy, String mm, String sysPwd) {
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();        
        startTime = ft.format(new java.util.Date());
        if(wsAuth){            
            rtobj.getPurFltSch(empno, yy, mm);
        }else{
            rtobj.fltObj = new ReportListFltRObj();
            rtobj.fltObj.setResultMsg("0");
            rtobj.fltObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getReportListFlt", startTime, endTime, "", "", "", empno);
        lg.WriteLog();
		return rtobj.fltObj;
	}

	// 2.傳回報告編輯狀態
	public ReportListCfltUpdObj getReportListCflt(String empno, String fdate,
			String fltno, String sect, String sysPwd) {
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            rtobj.getPurCflt(empno, fdate, fltno, sect);
        }else{
            rtobj.cfltObj = new ReportListCfltUpdObj();
            rtobj.cfltObj.setResultMsg("0");
            rtobj.cfltObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getReportListCflt", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return rtobj.cfltObj;
	}

	// 3.傳回CM資料
	public PurInfoObj getPurInfo(String empno, String sysPwd) {
	    boolean wsAuth = false;
	    ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
		ReportListFun rtobj = new ReportListFun();
		startTime = ft.format(new java.util.Date());
		if(wsAuth){
		    rtobj.getPurInfo(empno);
		}else{
		    rtobj.purObj = new PurInfoObj();  
            rtobj.purObj.setResultMsg("0");
            rtobj.purObj.setErrorMsg("No Auth");
        }
		endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getPurInfo", startTime, endTime, "", "", "", empno);
        lg.WriteLog();
		return rtobj.purObj;
	}
	
	// 4.傳回empn資料
	public EmpnoInfoRObj getEmpInfo(String empno, String sysPwd) {
	    boolean wsAuth = false;
//        DESede d = new DESede();
	    ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){            
            rtobj.getEmpInfo(empno);
//            System.out.println(rtobj.empObj.getErrorMsg());
        }else{
            rtobj.empObj = new EmpnoInfoRObj();            
            rtobj.empObj.setResultMsg("0");
            rtobj.empObj.setErrorMsg("No Auth");
//            System.out.println(rtobj.empObj.getErrorMsg());
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getEmpInfo", startTime, endTime, "", "", "", empno);
        lg.WriteLog();
        return rtobj.empObj;
    }
	
	// 5.傳回MVC資料 yyyymmdd
	public ReportListMVCObj getMVCList(String empno, String fdate,
			String fltno, String sect, String sysPwd) {
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            rtobj.getMVC(empno, fdate, fltno, sect);
        }else{
            rtobj.mvcObj = new ReportListMVCObj();  
            rtobj.mvcObj.setResultMsg("0");
            rtobj.mvcObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMVCList", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return rtobj.mvcObj;

	}

	// 6.原始組員名單
	public CrewListRObj getOriCrewList(String fltdate, String fltno,
			String ftime, String port, String inner_sect, String sysPwd)
			throws InstantiationException, IllegalAccessException,
			ClassNotFoundException {
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            rtobj.getOriCrewList(fltdate, fltno, ftime, port, inner_sect);
        }else{
            rtobj.oriCrewObj = new CrewListRObj();  
            rtobj.oriCrewObj.setResultMsg("0");
            rtobj.oriCrewObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getOriCrewList", startTime, endTime, fltdate, fltno, port, "");
        lg.WriteLog();
		return rtobj.oriCrewObj;
	}
	
	// 7.當班客艙經理check
	public ActPurObj getActPur(String fdate,String fltno,String sect, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            rtobj.getActPur(fdate, fltno,sect);
        }else{
            rtobj.onePurObj = new ActPurObj();
            rtobj.onePurObj.setResultMsg("0");
            rtobj.onePurObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getActPur", startTime, endTime, fdate, fltno, sect, "");
        lg.WriteLog();
		return rtobj.onePurObj;
	}
	
	// 8.打考績組員名單,from egtcflt. 有組員名單,無則顯示原始組員名單
	public MdCrewListObj getMdCrewList(String empno,String fdate, String fltno, String sect, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun rtobj = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            rtobj.getMdCrewList(empno, fdate, fltno, sect);
        }else{
            rtobj.mdCrewObj = new MdCrewListObj();
            rtobj.mdCrewObj.setResultMsg("0");
            rtobj.mdCrewObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMdCrewList", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return rtobj.mdCrewObj;
	}
	//------------------------------
	// 9.Irr已編輯資料
	public FltIrrRObj getEdIrr(String fdate,String fltno,String sect,String empno, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        FltIrrFun fiObj = new FltIrrFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){            
            fiObj.getEdFltIrr(fdate, fltno, sect, empno);
        }else{
            fiObj.irrObj = new FltIrrRObj();
            fiObj.irrObj.setResultMsg("0");
            fiObj.irrObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getEdIrr", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return fiObj.irrObj;
	}
	
	// 10.Irr all item list
	public FltIrrItemRObj getIrrItem(String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        FltIrrFun fiObj = new FltIrrFun();
        if(wsAuth){ 
		    fiObj.getIrrAllItem();
        }else{
            fiObj.itemObj = new FltIrrItemRObj();
            fiObj.itemObj.setResultMsg("0");
            fiObj.itemObj.setErrorMsg("No Auth");
        }
		return fiObj.itemObj;
	}
	
	// 11.編輯自我督察
	public PRSFlyRObj getPRSFly(String empno,String fdate,String fltno,String sect ,String fleet,String acno, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        SFLYRptFun sflyObj = new SFLYRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){ 
            sflyObj.PRSFlyEd(empno, fdate, fltno, sect, fleet, acno);   
        }else{
            sflyObj.prSFlyObj = new PRSFlyRObj();
            sflyObj.prSFlyObj.setResultMsg("0");
            sflyObj.prSFlyObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getPRSFly", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();	
		return sflyObj.prSFlyObj;
	}
	
	// 12.自我督察考評內容不合格問項
	public PSFlyFactorRObj PRSFlyItem(String psfmItemno, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        SFLYRptFun sflyObj = new SFLYRptFun();
        if(wsAuth){
            sflyObj.PRSFlyItem(psfmItemno); 
        }else{
            sflyObj.pSFlyObj = new PSFlyFactorRObj();
            sflyObj.pSFlyObj.setResultMsg("0");
            sflyObj.pSFlyObj.setErrorMsg("No Auth");
        }			
		return sflyObj.pSFlyObj;		
	}
	
	// 13.編輯專案調查/追蹤考核
	public PRProjRObj getPRPj(String empno,String fdate,String fltno,String sect ,String fleet,String acno, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        SFLYRptFun sflyObj = new SFLYRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            sflyObj.PRProjEd(empno, fdate, fltno, sect, fleet, acno);
        }else{
            sflyObj.prPjObj = new PRProjRObj();
            sflyObj.prPjObj.setResultMsg("0");
            sflyObj.prPjObj.setErrorMsg("No Auth");
        }		
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getPRPj", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return sflyObj.prPjObj;
	}
	
	// 14.查核
	public PRfltChkItemRObj getPRChkItem(String empno,String fdate,String fltno,String sect, String sysPwd ){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        SFLYRptFun sflyObj = new SFLYRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            sflyObj.PRFltchkItem(empno, fdate, fltno, sect);
        }else{
            sflyObj.prChkObj = new PRfltChkItemRObj();
            sflyObj.prChkObj.setResultMsg("0");
            sflyObj.prChkObj.setErrorMsg("No Auth");
        }	
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getPRChkItem", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return sflyObj.prChkObj;
	}
	
	// 15.PA考評 item
	public PAEvalItemRObj getPAEvalItem( String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        PAFun paObj = new PAFun();
        if(wsAuth){
            paObj.getPAEvalItem();
        }else{
            paObj.paItemObj = new PAEvalItemRObj();
            paObj.paItemObj.setResultMsg("0");
            paObj.paItemObj.setErrorMsg("No Auth");
        }
		return paObj.paItemObj;
	}
	
	// 16.PA Crew考評 
	public PAEvalCrewRObj getPACrewData(String fdate,String fltno,String sect ,String empno, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        PAFun paObj = new PAFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){	    
            paObj.getPACrewData(fdate, fltno, sect, empno);
        }else{
            paObj.paCrewObj = new PAEvalCrewRObj();
            paObj.paCrewObj.setResultMsg("0");
            paObj.paCrewObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getPACrewData", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return paObj.paCrewObj;
	}
	
	// 17.ZC考評 item
	public ZcEvalItemRObj getZCEvalItem( String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ZCFun zcObj = new ZCFun();
        if(wsAuth){   
            zcObj.getZCEvalItem();
        }else{
            zcObj.zcItemObj = new ZcEvalItemRObj();
            zcObj.zcItemObj.setResultMsg("0");
            zcObj.zcItemObj.setErrorMsg("No Auth");
        }
		
		return zcObj.zcItemObj;
	}
	
	// 18.ZC Crew考評 
	public ZcEvalCrewRObj getZCCrewData(String fdate,String fltno,String sect ,String empno, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ZCFun zcObj = new ZCFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            zcObj.getZCCrewData(fdate, fltno, sect, empno);
        }else{
            zcObj.zcCrewObj = new ZcEvalCrewRObj();
            zcObj.zcCrewObj.setResultMsg("0");
            zcObj.zcCrewObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getZCCrewData", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
		return zcObj.zcCrewObj;
	}
	
	// 19.previous flt info
	public FltInfoRObj getPreFlt(String acNo,String fltd,String sect, String sysPwd){//yyyymmdd hh24mi
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        FltInfoFun pflt = new FltInfoFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){            
            pflt.getPreFltInfo(acNo, fltd, sect);
        }else{
            pflt.fltObj = new FltInfoRObj();
            pflt.fltObj.setResultMsg("0");
            pflt.fltObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getPreFlt", startTime, endTime, fltd, "", sect, "");
        lg.WriteLog();
		return pflt.fltObj;
	}
	
	// 20.this flt info
	public FltInfoRObj getThisFlt(String acNo,String fltd,String sect,String fltno, String sysPwd){//yyyymmdd hh24mi
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        FltInfoFun pflt = new FltInfoFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){ 
            pflt.getThisFltInfo(acNo, fltd, sect,fltno);
        }else{
            pflt.fltObj2 = new FltInfoRObj();
            pflt.fltObj2.setResultMsg("0");
            pflt.fltObj2.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getThisFlt", startTime, endTime, fltd, fltno, sect, "");
        lg.WriteLog();
		return pflt.fltObj2;
	}

	// 21.get upload filename from egtfile
	public FtpFileRObj getUploadFile(String fdate,String fltno,String sect, String sysPwd){//yyyy/mm/dd
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        AppFile file = new AppFile();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            file.getFile(fdate, fltno, sect);
        }else{
            file.ftpObj = new FtpFileRObj();
            file.ftpObj.setResultMsg("0");
            file.ftpObj.setErrorMsg("No Auth");
        }	    
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getUploadFile", startTime, endTime, fdate, fltno, sect, "");
        lg.WriteLog();
		return file.ftpObj;
	}

	// 22.考評項目
	public GradeItemRObj getGradetItem( String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun gdItem = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){	    
            gdItem.getGradeItem();
        }else{
            gdItem.gdObj = new GradeItemRObj();
            gdItem.gdObj.setResultMsg("0");
            gdItem.gdObj.setErrorMsg("No Auth");
        }
		return gdItem.gdObj;
	}
	
	// 23.考評內容
	public GradeRObj getGrade(String fdate,String fltno,String sect, String sysPwd){
	    boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListFun gdRec = new ReportListFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){ 	    
            gdRec.getGradeRecord(fdate, fltno, sect);
        }else{
            gdRec.gdRecObj = new GradeRObj();
            gdRec.gdRecObj.setResultMsg("0");
            gdRec.gdRecObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getGrade", startTime, endTime, fdate, fltno, sect, "");
        lg.WriteLog();
		return gdRec.gdRecObj;
	}
	
	//////////////////
	
//  2-1 回傳MVC & CSS內容
    public CusRObj CusMvcCss(InputCusObj[] cusArr ,String rank ,String sysPwd) {        
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        perAL = new CusRObj();
        if(wsAuth){            
            ProvidCssFun css = new ProvidCssFun();
            css.ProvideCss(cusArr, rank);
            perAL.setCssArr(css.getProCssAL().getProCssArr());
            ProvidCusFun cus = new ProvidCusFun();
            cus.ProvideCusMvcCss(cusArr);            
            perAL.setCusArr(cus.getProCusAL().getProCusArr());
//            if(!"0".equals(css.getProCssAL().getResultMsg()) && !"0".equals(mvc.getProMvcAL().getResultMsg())){
//                perAL.setResultMsg("1");
//            }else{
//                perAL.setResultMsg("0");
//                perAL.setErrorMsg(css.getProCssAL().getErrorMsg()+ ";" + mvc.getProMvcAL().getErrorMsg());
//            }
            perAL.setErrorMsg(css.getProCssAL().getErrorMsg()+ ";" + cus.getProCusAL().getErrorMsg());
        }else{
            perAL.setResultMsg("0");
            perAL.setErrorMsg("No Auth!!");
            perAL.setCusArr(null);
            perAL.setCssArr(null);
        }
        
        return perAL;
    }
//  2-2 回傳選項
    public CusItemsRObj CusItems(String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        itemAL = new CusItemsRObj();
        if(wsAuth){ 
            ProvidCusDetailFun cus = new ProvidCusDetailFun();
            cus.AllOption();
            itemAL = cus.getCusItemAL();
        }else{
            itemAL.setResultMsg("0");
            itemAL.setErrorMsg("No Auth!!");
        }
        return itemAL; 
        
    }
//  2-3 存回DB
    public SavaCusRObj SaveCusData(SaveCusObj[] saveCusArr, String sysPwd) {
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        SaveCusFun sCus = new SaveCusFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){            
            sCus.saveCus(saveCusArr);
        }else{
            sCus.getSaveCusReturnAL().setErrorMsg("0") ;
            sCus.getSaveCusReturnAL().setResultMsg("No Auth!!");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("SaveCusData", startTime, endTime, "", "", "", "");
        lg.WriteLog();
        return sCus.getSaveCusReturnAL();
    }
//  2-4 回傳MVC & CSS內容    (新格式)
    public CusDetailRObj CusMvcCssD(String[] cardNumArr,String[] cusIDArr ,String rank ,String sysPwd) {        
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        perAL2 = new CusDetailRObj();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){                        
            ProvidCusDetailFun cus = new ProvidCusDetailFun();
            cus.ProvideCus(cardNumArr, rank);
            perAL2 = cus.getProCusAL();
        }else{
            perAL2.setResultMsg("0");
            perAL2.setErrorMsg("No Auth!!");
            
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("CusMvcCssD", startTime, endTime, "", "", "", "");
        lg.WriteLog();
        return perAL2;
    }
    
    //////////////////
    
//  3-1 取得事務長ZC(PR)報告
    public ReportListZCfltRObj getZcMdList(String empno, String fdate, String fltno,String sect, String sysPwd){//yyyy/mm/dd HH24:MI
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListZCFun zcRpt = new ReportListZCFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){         
            zcRpt.getZcMdList(empno, fdate, fltno, sect);
        }else{
            zcRpt.zcfltObj = new ReportListZCfltRObj();
            zcRpt.zcfltObj.setResultMsg("0");
            zcRpt.zcfltObj.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getZcMdList", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
        return zcRpt.zcfltObj;
    }
//  3-2.ZC Irr all item list
    public FltIrrItemRObj getZcIrrItem(String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        FltIrrFun fiObj = new FltIrrFun();
        if(wsAuth){ 
            fiObj.getZcIrrAllItem();
        }else{
            fiObj.zcItemObj = new FltIrrItemRObj();
            fiObj.zcItemObj.setResultMsg("0");
            fiObj.zcItemObj.setErrorMsg("No Auth");
        }
        
        return fiObj.zcItemObj;
    }
 // 3-3.ZC get upload filename from egtzcfile
    public FtpFileRObj getZcUploadFile(String fdate,String fltno,String sect, String sysPwd){//yyyy/mm/dd
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        AppFile file = new AppFile();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){
            file.getZcFile(fdate, fltno, sect);
        }else{
            file.zcFtpObj = new FtpFileRObj();
            file.zcFtpObj.setResultMsg("0");
            file.zcFtpObj.setErrorMsg("No Auth");
        }       
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getZcUploadFile", startTime, endTime, fdate, fltno, sect, "");
        lg.WriteLog();
        return file.zcFtpObj;
    }
 // 3-4.ZC 考評項目
    public GradeItemRObj getZcGradetItem(String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListZCFun zcGdItem = new ReportListZCFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            zcGdItem.getZcGradeItem();
        }else{
            zcGdItem.zcGdObj = new GradeItemRObj();
            zcGdItem.zcGdObj.setResultMsg("0");
            zcGdItem.zcGdObj.setErrorMsg("No Auth");
        }
        
        return zcGdItem.zcGdObj;
    }
//  3-5.ZC save rpt  
    public ReturnMsgObj saveZCreport(saveReportZCfltObj[] saverptAL,String sysPwd){//"Y":成功
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListZCFun save = new ReportListZCFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            save.saveZCreport(saverptAL);
        }else{
            save.getSaveobj().setErrorMsg("0") ;
            save.getSaveobj().setResultMsg("No Auth!!");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("saveZCreport", startTime, endTime, "", "", "", "");
        lg.WriteLog();
        return save.getSaveobj();
    }
//  3-6.ZC send rpt
    public ReturnMsgObj sentZCreport(saveReportZCfltObj[] sentrptAL,String sysPwd){//"Y":成功
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        ReportListZCFun save = new ReportListZCFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            save.sendZCreport(sentrptAL);//"Y":成功
        }else{
            save.getSendobj().setErrorMsg("0") ;
            save.getSendobj().setResultMsg("No Auth!!");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("sentZCreport", startTime, endTime, "", "", "", "");
        lg.WriteLog();
        return save.getSendobj();
    }
    
//  4-1. MP 1.Cabin Safety check Item
    public MPsflySafetyChkItemRObj getMpSafetyChkItem(String fdate,String sect,String fltno,String Empno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun mpsfly = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            mpsfly.CabinSafetyItem(fdate, sect, fltno, Empno);
        }else{
            mpsfly.SChkItem = new MPsflySafetyChkItemRObj();
            mpsfly.SChkItem.setResultMsg("0");
            mpsfly.SChkItem.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMpSafetyChkItem", startTime, endTime, fdate, fltno, sect, Empno);
        lg.WriteLog();
        return mpsfly.SChkItem;        
    }
//  4-2 MP. 2.Self Inspection Item
    public MPsflySelfInsItemRObj getMpSelfInsItem(String fdate2,String sect,String fltno,String Empno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun mpsfly = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            mpsfly.SelfInsItem(fdate2, sect, fltno, Empno);
        }else{
            mpsfly.sInsItem = new MPsflySelfInsItemRObj();
            mpsfly.sInsItem.setResultMsg("0");
            mpsfly.sInsItem.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMpSelfInsItem", startTime, endTime, fdate2, fltno, sect, Empno);
        lg.WriteLog();
        return mpsfly.sInsItem;        
    }
//  4-3 MP. 3.Evaluation
    public MPsflyEvaItemRObj getMpEvaluationItem(String fdate,String sect,String fltno,String Empno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun mpsfly = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            mpsfly.EvaluationItem(fdate, sect, fltno, Empno);
        }else{
            mpsfly.sEvaItem = new MPsflyEvaItemRObj();
            mpsfly.sEvaItem.setResultMsg("0");
            mpsfly.sEvaItem.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMpEvaluationItem", startTime, endTime, fdate, fltno, sect, Empno);
        lg.WriteLog();
        return mpsfly.sEvaItem;        
    }
//  4-4 MP. Query all rpt
    public MpSflyRObj getMPsflyDetail(String fdate,String sect,String fltno,String empno,String fleet,String acNo,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun mpsfly = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            mpsfly.getMpSfly(fdate, sect, fltno, empno, fleet, acNo);
        }else{
            mpsfly.sfly = new MpSflyRObj();
            mpsfly.sfly.setResultMsg("0");
            mpsfly.sfly.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMPsflyDetail", startTime, endTime, fdate, fltno, sect, empno);
        lg.WriteLog();
        return mpsfly.sfly; 
    }
//  4-5 MP.save all rpt
    public ReturnMsgObj saveMPreport(MpSflyRObj[] saverptAL,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun save = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            save.saveMpSfly(saverptAL);
        }else{
            save.getSaveobj().setErrorMsg("0") ;
            save.getSaveobj().setResultMsg("No Auth!!");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("saveMPreport", startTime, endTime, "", "", "", "");
        lg.WriteLog();
        return save.getSaveobj();
    } 
//  4-6 MP.send all rpt    
    public ReturnMsgObj sentMPreport(MpSflyRObj[] sentrptAL,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun save = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            save.sendMpSfly(sentrptAL);
        }else{
            save.getSendobj().setErrorMsg("0") ;
            save.getSendobj().setResultMsg("No Auth!!");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("sentMPreport", startTime, endTime, "", "", "", "");
        lg.WriteLog();
        return save.getSendobj();
    } 
//  4-7 MP. 4.Safety audit
    public MPsflySafetyChkItemRObj getMpSafetyAudItem(String fdate,String sect,String fltno,String Empno,String sysPwd){
        boolean wsAuth = false;
        ThreeDes d = new ThreeDes();
        wsAuth = d.auth(sysPwd);
        MPsflyRptFun mpsfly = new MPsflyRptFun();
        startTime = ft.format(new java.util.Date());
        if(wsAuth){     
            mpsfly.SafetyAuditItem(fdate, sect, fltno, Empno);
        }else{
            mpsfly.sAduItem = new MPsflySafetyChkItemRObj();
            mpsfly.sAduItem.setResultMsg("0");
            mpsfly.sAduItem.setErrorMsg("No Auth");
        }
        endTime = ft.format(new java.util.Date());
        WriteWSLog lg = new WriteWSLog("getMpSafetyAudItem", startTime, endTime, fdate, fltno, sect, Empno);
        lg.WriteLog();
        return mpsfly.sAduItem;        
    }
//   test
//    public int test(String[] card){
//        int a = 0;        
//        for(int i=0;i<card.length;i++){            
//            if(!"".equals(card[i])){
//                a ++;    
//            }
//        }        
//        return a;
//    }
}
