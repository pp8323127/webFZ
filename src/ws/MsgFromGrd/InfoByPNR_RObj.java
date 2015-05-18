package ws.MsgFromGrd;

public class InfoByPNR_RObj {
	private String errorMsg = null;
	private String resultMsg = null;
	private String name[] = null;
	private int headCount = 0;
	private InfoByPNRObj[] fltObj = null;
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
	public InfoByPNRObj[] getFltObj() {
		return fltObj;
	}
	public void setFltObj(InfoByPNRObj[] fltObj) {
		this.fltObj = fltObj;
	}
	public String[] getName() {
		return name;
	}
	public void setName(String[] name) {
		this.name = name;
	}
    public int getHeadCount()
    {
        return headCount;
    }
    public void setHeadCount(int headCount)
    {
        this.headCount = headCount;
    }
   
}
