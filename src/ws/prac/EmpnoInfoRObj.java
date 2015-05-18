package ws.prac;

public class EmpnoInfoRObj
{

    /**
     * @param args
     */ 
    private String errorMsg = "";
    private String resultMsg = "";
    private PurInfoObj[] info = null;
    public String getErrorMsg()
    {
        return errorMsg;
    }
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
    public String getResultMsg()
    {
        return resultMsg;
    }
    public void setResultMsg(String resultMsg)
    {
        this.resultMsg = resultMsg;
    }
    public PurInfoObj[] getInfo()
    {
        return info;
    }
    public void setInfo(PurInfoObj[] info)
    {
        this.info = info;
    }

}
