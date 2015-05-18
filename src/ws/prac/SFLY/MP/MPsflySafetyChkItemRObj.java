package ws.prac.SFLY.MP;

public class MPsflySafetyChkItemRObj
{
    private String errorMsg = null;
    private String resultMsg = null;

    private String[] cho = null;
    private String[] chokey = null;
    private MPsflySafetyChkAttObj[] attributeArr = null;
    private MPsflySafetyChkQueObj[] QueArr = null;

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



    public String[] getCho()
    {
        return cho;
    }

    public void setCho(String[] cho)
    {
        this.cho = cho;
    }

    public MPsflySafetyChkAttObj[] getAttributeArr()
    {
        return attributeArr;
    }

    public void setAttributeArr(MPsflySafetyChkAttObj[] attributeArr)
    {
        this.attributeArr = attributeArr;
    }

    public MPsflySafetyChkQueObj[] getQueArr()
    {
        return QueArr;
    }

    public void setQueArr(MPsflySafetyChkQueObj[] queArr)
    {
        QueArr = queArr;
    }

    public String[] getChokey()
    {
        return chokey;
    }

    public void setChokey(String[] chokey)
    {
        this.chokey = chokey;
    }




}
