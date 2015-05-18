package ws.prac;

public class CrewListRObj {
	private CrewListObj[] crewList = null;
	private String errorMsg = null;
	private String resultMsg = null;
	public CrewListObj[] getCrewList() {
		return crewList;
	}
	public void setCrewList(CrewListObj[] crewList) {
		this.crewList = crewList;
	}
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
}
