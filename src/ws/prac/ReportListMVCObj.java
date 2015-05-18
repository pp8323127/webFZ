package ws.prac;

import eg.mvc.MVCObj;

public class ReportListMVCObj {
	private String errorMsg = null;
	private String resultMsg = null;
	private MVCObj[] mvcList = null;
	
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
	public MVCObj[] getMvcList() {
		return mvcList;
	}
	public void setMvcList(MVCObj[] mvcList) {
		this.mvcList = mvcList;
	}

	
	
}
