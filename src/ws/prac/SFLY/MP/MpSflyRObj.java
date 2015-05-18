package ws.prac.SFLY.MP;

public class MpSflyRObj
{
    private String errorMsg = null;
    private String resultMsg = null;
    private MPsflySafetyChkRObj sChkR = null;
    private MPsflySelfInsRObj sInsR = null; 
    private MPsflyEvaRObj sEvaR = null;
    
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
    public MPsflySafetyChkRObj getsChkR()
    {
        return sChkR;
    }
    public void setsChkR(MPsflySafetyChkRObj sChkR)
    {
        this.sChkR = sChkR;
    }
    public MPsflySelfInsRObj getsInsR()
    {
        return sInsR;
    }
    public void setsInsR(MPsflySelfInsRObj sInsR)
    {
        this.sInsR = sInsR;
    }
    public MPsflyEvaRObj getsEvaR()
    {
        return sEvaR;
    }
    public void setsEvaR(MPsflyEvaRObj sEvaR)
    {
        this.sEvaR = sEvaR;
    }
   

    
    
    
}
