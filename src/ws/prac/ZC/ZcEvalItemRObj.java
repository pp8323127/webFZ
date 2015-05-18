package ws.prac.ZC;

import java.util.ArrayList;

import fz.pracP.zc.EvaluationTypeObj;



public class ZcEvalItemRObj {
    private String errorMsg = null;
    private String resultMsg = null;
    private EvaluationTypeObj[] typeObj = null;
    private ArrayList tempObj = null;
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
    public EvaluationTypeObj[] getTypeObj() {
        return typeObj;
    }
    public void setTypeObj(EvaluationTypeObj[] typeObj) {
        this.typeObj = typeObj;
    }
    public ArrayList getTempObj() {
        return tempObj;
    }
    public void setTempObj(ArrayList tempObj) {
        this.tempObj = tempObj;
    }
    
}
