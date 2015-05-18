package ws.personal.mvc;

public class CusMileObj
{
    private String curreffMil = null;
    private String[] exprDt = null;
    private String[] balMil= null;
    private String errorMsg = null;

    public String getCurreffMil()
    {
        return curreffMil;
    }
    public void setCurreffMil(String curreffMil)
    {
        this.curreffMil = curreffMil;
    }
    
    public String[] getExprDt()
    {
        return exprDt;
    }
    public void setExprDt(String[] exprDt)
    {
        this.exprDt = exprDt;
    }
    public String[] getBalMil()
    {
        return balMil;
    }
    public void setBalMil(String[] balMil)
    {
        this.balMil = balMil;
    }
    public String getErrorMsg()
    {
        return errorMsg;
    }
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
    
}
