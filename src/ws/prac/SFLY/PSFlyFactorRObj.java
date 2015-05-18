package ws.prac.SFLY;

import java.util.ArrayList;

import fz.psfly.PSFlyFactorObj;

public class PSFlyFactorRObj {
	private String errorMsg = "";
	private String resultMsg = "";
	private PSFlyFactorObj[] facQA = null;
	

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
	public PSFlyFactorObj[] getFacQA() {
		return facQA;
	}
	public void setFacQA(PSFlyFactorObj[] facQA) {
		this.facQA = facQA;
	}

}
