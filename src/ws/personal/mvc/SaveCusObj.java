package ws.personal.mvc;

public class SaveCusObj
{
    private String tableKey     = null;// 資料識別主檔:主key與異動檔勾稽
    private String customerId   = null;// 客戶代碼:每一位客戶均有唯一的代碼,YYMM+8位數字流水號,Ex:140100000001
    private String cardNo   = null;// 會員卡號:會員不可缺;非會員則Customer_ID 不可空白
    private String lastName = null;// 護照英文姓:1.入會未搭乘DFP 2.非會員CIL(優先)
    private String fstName1 = null;// 護照英文名:1.入會未搭乘DFP 2.非會員CIL(優先)
    private String fstName2 = null;// 英文別名
    private String chinName = null;//中文姓名:1.入會未搭乘DFP 2.非會員CIL(優先)
    private String gender   = null;// 性別:F-女；M-男1.入會未搭乘DFP 2.非會員CIL(優先)
    private String brthDt   = null;// 出生年月日:YYYY-MM-DD 1.入會未搭乘DFP 2.非會員CIL(優先)
    private String language = null;//
    private String[] note     = null;// 備註:Special Important Information資料
    private String corpNm   = null;// 工作單位英文名稱
    private String corpNmC  = null;// 工作單位中文(日文)名稱
    private String title    = null;// 工作職稱:詳細之TITLE
    private String titleC   = null;// 工作職稱中文(日文)名稱
    private String depDt    = null;// 搭乘日期
    private String cdc      = null;// 航空公司
    private String fltno    = null;//
    private String dep      = null;//
    private String arr      = null;// 
    private String updtDt   = null;// 異動日期
//    private String updtTime = null;// 異動時間
    private String updtUser = null;// 異動人員:UserID(6碼)
//    private String updtPgm  = "CISAPP";//異動程式
    private SaveDetailCusObj[] detailArr = null;
    
    
    public String getTableKey()
    {
        return tableKey;
    }
    public void setTableKey(String tableKey)
    {
        this.tableKey = tableKey;
    }
    public String getCustomerId()
    {
        return customerId;
    }
    public void setCustomerId(String customerId)
    {
        this.customerId = customerId;
    }
    public String getCardNo()
    {
        return cardNo;
    }
    public void setCardNo(String cardNo)
    {
        this.cardNo = cardNo;
    }
    public String getLastName()
    {
        return lastName;
    }
    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }
    public String getFstName1()
    {
        return fstName1;
    }
    public void setFstName1(String fstName1)
    {
        this.fstName1 = fstName1;
    }
    public String getFstName2()
    {
        return fstName2;
    }
    public void setFstName2(String fstName2)
    {
        this.fstName2 = fstName2;
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
    public String getLanguage()
    {
        return language;
    }
    public void setLanguage(String language)
    {
        this.language = language;
    }

    public String[] getNote()
    {
        return note;
    }
    public void setNote(String[] note)
    {
        this.note = note;
    }
    public String getCorpNm()
    {
        return corpNm;
    }
    public void setCorpNm(String corpNm)
    {
        this.corpNm = corpNm;
    }
    public String getCorpNmC()
    {
        return corpNmC;
    }
    public void setCorpNmC(String corpNmC)
    {
        this.corpNmC = corpNmC;
    }
    public String getTitle()
    {
        return title;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }
    public String getTitleC()
    {
        return titleC;
    }
    public void setTitleC(String titleC)
    {
        this.titleC = titleC;
    }
    public String getDepDt()
    {
        return depDt;
    }
    public void setDepDt(String depDt)
    {
        this.depDt = depDt;
    }
    public String getCdc()
    {
        return cdc;
    }
    public void setCdc(String cdc)
    {
        this.cdc = cdc;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getDep()
    {
        return dep;
    }
    public void setDep(String dep)
    {
        this.dep = dep;
    }
    public String getArr()
    {
        return arr;
    }
    public void setArr(String arr)
    {
        this.arr = arr;
    }
    public String getUpdtDt()
    {
        return updtDt;
    }
    public void setUpdtDt(String updtDt)
    {
        this.updtDt = updtDt;
    }
//    public String getUpdtTime()
//    {
//        return updtTime;
//    }
//    public void setUpdtTime(String updtTime)
//    {
//        this.updtTime = updtTime;
//    }
    public String getUpdtUser()
    {
        return updtUser;
    }
    public void setUpdtUser(String updtUser)
    {
        this.updtUser = updtUser;
    }
//    public String getUpdtPgm()
//    {
//        return updtPgm;
//    }
//    public void setUpdtPgm(String updtPgm)
//    {
//        this.updtPgm = updtPgm;
//    }
    public SaveDetailCusObj[] getDetailArr()
    {
        return detailArr;
    }
    public void setDetailArr(SaveDetailCusObj[] detailArr)
    {
        this.detailArr = detailArr;
    }




    
}
