package ws.prac;

public class ReportListFltRObj {
	// 取得當樂班表 retrun
	/**
	 * @param args
	 */

	private String errorMsg = null;
	private String resultMsg = null;
	private ReportListCfltUpdObj[] status = null;//一併call狀態
	private String check_pre_mm_done = "";
	private String noticeQA = "";
	
	private ReportListFltObj[] schList = null;

	public String getErrorMsg() {
		return this.errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getResultMsg() {
		return this.resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public ReportListFltObj[] getSchList() {
		return this.schList;
	}

	public void setSchList(ReportListFltObj[] schList) {
		this.schList = schList;
	}

	public String getCheck_pre_mm_done() {
		return check_pre_mm_done;
	}

	public void setCheck_pre_mm_done(String check_pre_mm_done) {
		this.check_pre_mm_done = check_pre_mm_done;
	}

	public String getNoticeQA() {
		return noticeQA;
	}

	public void setNoticeQA(String noticeQA) {
		this.noticeQA = noticeQA;
	}

	public ReportListCfltUpdObj[] getStatus() {
		return status;
	}

	public void setStatus(ReportListCfltUpdObj[] status) {
		this.status = status;
	}



}
