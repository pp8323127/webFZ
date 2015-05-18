package ws.personal.mvc;

public class ProvidCusObj
{

//    public ProvidMvcObj()
//    {
//        super();
//        // TODO Auto-generated constructor stub
//    }
    private String cardnum = null;
    private String card_type = null;
    private String gender = null;
    private String nationality = null;
    private String brthdt = null;
    private String engLnm = null;
    private String engFnm = null;
    private String chinName = null;
    private String company_cname = null;
    private String title = null;
//    private String spec_import = null;
    private String note = null;
    private CusReqObj cusReq= null;
    private CusSpecReqObj[] cusSpecReqArr = null;
//    private CusSugObj[] custSugArr = null;
    private CusMileObj cusMile = null;
    private CusSpewObj[] cusSpewArr = null;
    private CusOthersObj[] cusOtherArr = null;
    
    
    public String getCardnum()
    {
        return cardnum;
    }
    public void setCardnum(String cardnum)
    {
        this.cardnum = cardnum;
    }
    public String getCard_type()
    {
        return card_type;
    }
    public void setCard_type(String card_type)
    {
        this.card_type = card_type;
    }
    public String getGender()
    {
        return gender;
    }
    public void setGender(String gender)
    {
        this.gender = gender;
    }
    public String getNationality()
    {
        return nationality;
    }
    public void setNationality(String nationality)
    {
        this.nationality = nationality;
    }
    public String getBrthdt()
    {
        return brthdt;
    }
    public void setBrthdt(String brthdt)
    {
        this.brthdt = brthdt;
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
    public String getCompany_cname()
    {
        return company_cname;
    }
    public void setCompany_cname(String company_cname)
    {
        this.company_cname = company_cname;
    }
    public String getTitle()
    {
        return title;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }
    public String getNote()
    {
        return note;
    }
    public void setNote(String note)
    {
        this.note = note;
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
    public CusSpewObj[] getCusSpewArr()
    {
        return cusSpewArr;
    }
    public void setCusSpewArr(CusSpewObj[] cusSpewArr)
    {
        this.cusSpewArr = cusSpewArr;
    }
    public CusOthersObj[] getCusOtherArr()
    {
        return cusOtherArr;
    }
    public void setCusOtherArr(CusOthersObj[] cusOtherArr)
    {
        this.cusOtherArr = cusOtherArr;
    }






    /*private String cardnum = "";
    private String cname = "";
    private String ename = "";
    private String ename2 = "";
    private String company_cname = "";
    private String company_ename = "";
    private String card_type = "";
    private String title = "";
    private String title_desc = "";
    private String gender = "";
    private String type = "";
    private String type_desc = "";
    private String code = "";
    private String code_desc = "";
    private String brthdt = "";
    private String note = "";    
    private String seatno="";
    private String cabin_class = "";
    public String getCardnum()
    {
        return cardnum;
    }
    public void setCardnum(String cardnum)
    {
        this.cardnum = cardnum;
    }
    public String getCname()
    {
        return cname;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
    }
    public String getEname()
    {
        return ename;
    }
    public void setEname(String ename)
    {
        this.ename = ename;
    }
    public String getEname2()
    {
        return ename2;
    }
    public void setEname2(String ename2)
    {
        this.ename2 = ename2;
    }
    public String getCompany_cname()
    {
        return company_cname;
    }
    public void setCompany_cname(String company_cname)
    {
        this.company_cname = company_cname;
    }
    public String getCompany_ename()
    {
        return company_ename;
    }
    public void setCompany_ename(String company_ename)
    {
        this.company_ename = company_ename;
    }
    public String getCard_type()
    {
        return card_type;
    }
    public void setCard_type(String card_type)
    {
        this.card_type = card_type;
    }
    public String getTitle()
    {
        return title;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }
    public String getTitle_desc()
    {
        return title_desc;
    }
    public void setTitle_desc(String title_desc)
    {
        this.title_desc = title_desc;
    }
    public String getGender()
    {
        return gender;
    }
    public void setGender(String gender)
    {
        this.gender = gender;
    }
    public String getType()
    {
        return type;
    }
    public void setType(String type)
    {
        this.type = type;
    }
    public String getType_desc()
    {
        return type_desc;
    }
    public void setType_desc(String type_desc)
    {
        this.type_desc = type_desc;
    }
    public String getCode()
    {
        return code;
    }
    public void setCode(String code)
    {
        this.code = code;
    }
    public String getCode_desc()
    {
        return code_desc;
    }
    public void setCode_desc(String code_desc)
    {
        this.code_desc = code_desc;
    }
    public String getBrthdt()
    {
        return brthdt;
    }
    public void setBrthdt(String brthdt)
    {
        this.brthdt = brthdt;
    }
    public String getNote()
    {
        return note;
    }
    public void setNote(String note)
    {
        this.note = note;
    }
    public String getSeatno()
    {
        return seatno;
    }
    public void setSeatno(String seatno)
    {
        this.seatno = seatno;
    }
    public String getCabin_class()
    {
        return cabin_class;
    }
    public void setCabin_class(String cabin_class)
    {
        this.cabin_class = cabin_class;
    }*/
    
    
}
