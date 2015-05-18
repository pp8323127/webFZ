package ws.personal;

import ws.personal.css.*;
import ws.personal.mvc.*;
import eg.mvc.*;

/**
 * @author cs80 Cabin iService (II)
 * 回傳MVC & CSS內容 
 */

public class CusRObj
{

    private String errorMsg = null;
    private String resultMsg = null;
//    private MVCObj[] mvcArr = null;
    private ProvidCusObj[] cusArr = null;
    private ProvidCssObj[] cssArr = null;    
    
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
    public ProvidCssObj[] getCssArr()
    {
        return cssArr;
    }
    public void setCssArr(ProvidCssObj[] cssArr)
    {
        this.cssArr = cssArr;
    }
    public ProvidCusObj[] getCusArr()
    {
        return cusArr;
    }
    public void setCusArr(ProvidCusObj[] cusArr)
    {
        this.cusArr = cusArr;
    }






}
