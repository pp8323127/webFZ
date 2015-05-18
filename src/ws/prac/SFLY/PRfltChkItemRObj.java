package ws.prac.SFLY;

import eg.flightcheckitem.CheckDetailItemObj;
import eg.flightcheckitem.CheckMainItemObj;
import eg.flightcheckitem.CheckRecordDetailObj;
import eg.flightcheckitem.CheckRecordObj;
import eg.flightcheckitem.RetrieveCheckItem;

public class PRfltChkItemRObj {

	private String errorMsg = null;
	private String resultMsg = null;
	//題目
	private	CheckMainItemObj[] chkObj = null;
	private CheckDetailItemObj[] chkDObj = null;
	//內容
	private CheckRecordObj[] chkEdObj = null;

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
	public CheckMainItemObj[] getChkObj() {
		return chkObj;
	}
	public void setChkObj(CheckMainItemObj[] chkObj) {
		this.chkObj = chkObj;
	}
	public CheckDetailItemObj[] getChkDObj() {
		return chkDObj;
	}
	public void setChkDObj(CheckDetailItemObj[] chkDObj) {
		this.chkDObj = chkDObj;
	}
	public CheckRecordObj[] getChkEdObj() {
		return chkEdObj;
	}
	public void setChkEdObj(CheckRecordObj[] chkEdObj) {
		this.chkEdObj = chkEdObj;
	}

}
