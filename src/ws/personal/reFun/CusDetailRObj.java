package ws.personal.reFun;

import ws.personal.css.*;
import ws.personal.mvc.*;

public class CusDetailRObj
{
    private String errorMsg = null;
    private String resultMsg = null;
    private ProvidPerObj[] cusArr = null;
    private ProvidCssObj[] cssArr = null;
    
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

    public ProvidPerObj[] getCusArr()
    {
        return cusArr;
    }
    public void setCusArr(ProvidPerObj[] cusArr)
    {
        this.cusArr = cusArr;
    }
    public ProvidCssObj[] getCssArr()
    {
        return cssArr;
    }
    public void setCssArr(ProvidCssObj[] cssArr)
    {
        this.cssArr = cssArr;
    }    

}
