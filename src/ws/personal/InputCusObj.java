package ws.personal;


public class InputCusObj
{
    /* 卡號
                    顧客號碼(目前為空)
                    旅客護照英文姓
                    旅客護照英文名
                    旅客中文姓名
                    旅客性別
                    旅客生日
                    旅客護照號碼
     */
    private String cardNo = null;
    private String customerId = null;
    private String engLnm = null;
    private String engFnm = null;
    private String chinName = null;
    private String gender = null;
    private String brthDt = null;
    private String passport = null;
    public String getCardNo()
    {
        return cardNo;
    }
    public void setCardNo(String cardNo)
    {
        this.cardNo = cardNo;
    }
    public String getCustomerId()
    {
        return customerId;
    }
    public void setCustomerId(String customerId)
    {
        this.customerId = customerId;
    }
    public String getEngLnm()
    {
        return engLnm;
    }
    public void setEngLnm(String engLnm)
    {
        this.engLnm = engLnm;
    }
    public String getEngFnm()
    {
        return engFnm;
    }
    public void setEngFnm(String engFnm)
    {
        this.engFnm = engFnm;
    }
    public String getChinName()
    {
        return chinName;
    }
    public void setChinName(String chinName)
    {
        this.chinName = chinName;
    }
    public String getGender()
    {
        return gender;
    }
    public void setGender(String gender)
    {
        this.gender = gender;
    }
    public String getBrthDt()
    {
        return brthDt;
    }
    public void setBrthDt(String brthDt)
    {
        this.brthDt = brthDt;
    }
    public String getPassport()
    {
        return passport;
    }
    public void setPassport(String passport)
    {
        this.passport = passport;
    }
    
    
}
