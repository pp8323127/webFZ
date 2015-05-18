package ws.personal.mvc;

public class ProvidPerObj
{
    private String CusCardNo = null;
    private CusReqObj cusReq= null;
    private CusSpecReqObj[] cusSpecReqArr = null;
    private CusMileObj cusMile = null;
    private CusOthersObj[] cusOthersArr = null;
    
    public String getCusCardNo()
    {
        return CusCardNo;
    }
    public void setCusCardNo(String cusCardNo)
    {
        CusCardNo = cusCardNo;
    }
    public CusReqObj getCusReq()
    {
        return cusReq;
    }
    public void setCusReq(CusReqObj cusReq)
    {
        this.cusReq = cusReq;
    }
    public CusSpecReqObj[] getCusSpecReqArr()
    {
        return cusSpecReqArr;
    }
    public void setCusSpecReqArr(CusSpecReqObj[] cusSpecReqArr)
    {
        this.cusSpecReqArr = cusSpecReqArr;
    }
    public CusMileObj getCusMile()
    {
        return cusMile;
    }
    public void setCusMile(CusMileObj cusMile)
    {
        this.cusMile = cusMile;
    }
    public CusOthersObj[] getCusOthersArr()
    {
        return cusOthersArr;
    }
    public void setCusOthersArr(CusOthersObj[] cusOthersArr)
    {
        this.cusOthersArr = cusOthersArr;
    }

    
}
