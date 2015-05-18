package ws.prac.SFLY;

import fz.projectinvestigate.PRProjIssueObj;
import fz.projectinvestigate.PRProjTemplateObj;

public class PRProjRObj {
	private String errorMsg = "";
	private String resultMsg = "";
	PRProjIssueObj[] prPjIss = null;
	PRProjTemplateObj[] prPjtemp = null;
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
	public PRProjIssueObj[] getPrPjIss() {
		return prPjIss;
	}
	public void setPrPjIss(PRProjIssueObj[] prPjIss) {
		this.prPjIss = prPjIss;
	}
	public PRProjTemplateObj[] getPrPjtemp() {
		return prPjtemp;
	}
	public void setPrPjtemp(PRProjTemplateObj[] prPjtemp) {
		this.prPjtemp = prPjtemp;
	}
	
	
}
