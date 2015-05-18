package ws.prac.FltInfo;

public class FltInfoRObj {
	private String errorMsg = null;
	private String resultMsg = null;
	FltInfoObj[] fInfo= null;
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
	public FltInfoObj[] getfInfo() {
		return fInfo;
	}
	public void setfInfo(FltInfoObj[] fInfo) {
		this.fInfo = fInfo;
	}
	
			
}
