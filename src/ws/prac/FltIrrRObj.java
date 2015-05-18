package ws.prac;

import fz.pracP.BordingOnTime;


public class FltIrrRObj {
	private String errorMsg = "";
	private String resultMsg = "";
	private FltIrrObj[] edIrr1 = null;
	private BordingOnTime [] bot = null;
    private String recomendation = null;
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
	public FltIrrObj[] getEdIrr1() {
		return edIrr1;
	}
	public void setEdIrr1(FltIrrObj[] edIrr1) {
		this.edIrr1 = edIrr1;
	}
	public BordingOnTime[] getBot() {
		return bot;
	}
	public void setBot(BordingOnTime[] bot) {
		this.bot = bot;
	}
    public String getRecomendation()
    {
        return recomendation;
    }
    public void setRecomendation(String recomendation)
    {
        this.recomendation = recomendation;
    }
	
}
