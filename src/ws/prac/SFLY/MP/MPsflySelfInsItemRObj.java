package ws.prac.SFLY.MP;

public class MPsflySelfInsItemRObj
{
    private String errorMsg = null;
    private String resultMsg = null;
    
    private MPsflySelfInsItemObj[] insItem = null;
    private MPsflySafetyChkAttObj[] attributeArr = null;
    private MPsflySelfCrew[] crewArr = null;
    
   
    public MPsflySafetyChkAttObj[] getAttributeArr()
    {
        return attributeArr;
    }
    public void setAttributeArr(MPsflySafetyChkAttObj[] attributeArr)
    {
        this.attributeArr = attributeArr;
    }

    public MPsflySelfCrew[] getCrewArr()
    {
        return crewArr;
    }
    public void setCrewArr(MPsflySelfCrew[] crewArr)
    {
        this.crewArr = crewArr;
    }
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
    public MPsflySelfInsItemObj[] getInsItem()
    {
        return insItem;
    }
    public void setInsItem(MPsflySelfInsItemObj[] insItem)
    {
        this.insItem = insItem;
    }
    
}
