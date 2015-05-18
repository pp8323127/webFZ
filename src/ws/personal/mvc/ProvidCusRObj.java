package ws.personal.mvc;


public class ProvidCusRObj
{
    private String resultMsg = null;
    private String errorMsg = null;
    private ProvidCusObj[] proCusArr = null;
    public String getResultMsg()
    {
        return resultMsg;
    }
    public void setResultMsg(String resultMsg)
    {
        this.resultMsg = resultMsg;
    }
    public String getErrorMsg()
    {
        return errorMsg;
    }
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
   
    public ProvidCusObj[] getProCusArr()
    {
        return proCusArr;
    }
    public void setProCusArr(ProvidCusObj[] proCusArr)
    {
        this.proCusArr = proCusArr;
    }

    
}
