package ws.prac.PA;

import fz.pracP.pa.PACrewEvalObj;

public class PAEvalCrewRObj {

	private String errorMsg = null;
	private String resultMsg = null;
	private PACrewEvalObj[] paCrewObj = null;
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
	public PACrewEvalObj[] getPaCrewObj() {
		return paCrewObj;
	}
	public void setPaCrewObj(PACrewEvalObj[] paCrewObj) {
		this.paCrewObj = paCrewObj;
	}
}
