package ws.prac.SFLY;

import java.util.ArrayList;

import fz.psfly.PRSFlyFactorObj;
import fz.psfly.PSFlyIssueObj;

public class PRSFlyRObj {
	private String errorMsg = "";
	private String resultMsg = "";

//	ArrayList bankItemobjAL = new ArrayList();
//	private ArrayList prSFly = new ArrayList();
	private ArrayList dutyAL = new ArrayList();
	private PSFlyIssueObj[] prSFlyIss = null; 
	private PRSFlyFactorObj[] prSFlyFac = null;
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

//	public ArrayList getBankItemobjAL() {
//		return bankItemobjAL;
//	}
//	public void setBankItemobjAL(ArrayList bankItemobjAL) {
//		this.bankItemobjAL = bankItemobjAL;
//	}
//	public ArrayList getPrSFly() {
//		return prSFly;
//	}
//	public void setPrSFly(ArrayList prSFly) {
//		this.prSFly = prSFly;
//	}
	public PSFlyIssueObj[] getPrSFlyIss() {
		return prSFlyIss;
	}
	public void setPrSFlyIss(PSFlyIssueObj[] prSFlyIss) {
		this.prSFlyIss = prSFlyIss;
	}
	public PRSFlyFactorObj[] getPrSFlyFac() {
		return prSFlyFac;
	}
	public void setPrSFlyFac(PRSFlyFactorObj[] prSFlyFac) {
		this.prSFlyFac = prSFlyFac;
	}
	public ArrayList getDutyAL() {
		return dutyAL;
	}
	public void setDutyAL(ArrayList dutyAL) {
		this.dutyAL = dutyAL;
	}
	
	
}
