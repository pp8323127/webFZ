package ws.personal.mvc;

public class SaveCusObj
{
    private String tableKey     = null;// ����ѧO�D��:�Dkey�P�����ɤĽ]
    private String customerId   = null;// �Ȥ�N�X:�C�@��Ȥ᧡���ߤ@���N�X,YYMM+8��Ʀr�y����,Ex:140100000001
    private String cardNo   = null;// �|���d��:�|�����i��;�D�|���hCustomer_ID ���i�ť�
    private String lastName = null;// �@�ӭ^��m:1.�J�|���f��DFP 2.�D�|��CIL(�u��)
    private String fstName1 = null;// �@�ӭ^��W:1.�J�|���f��DFP 2.�D�|��CIL(�u��)
    private String fstName2 = null;// �^��O�W
    private String chinName = null;//����m�W:1.�J�|���f��DFP 2.�D�|��CIL(�u��)
    private String gender   = null;// �ʧO:F-�k�FM-�k1.�J�|���f��DFP 2.�D�|��CIL(�u��)
    private String brthDt   = null;// �X�ͦ~���:YYYY-MM-DD 1.�J�|���f��DFP 2.�D�|��CIL(�u��)
    private String language = null;//
    private String[] note     = null;// �Ƶ�:Special Important Information���
    private String corpNm   = null;// �u�@���^��W��
    private String corpNmC  = null;// �u�@��줤��(���)�W��
    private String title    = null;// �u�@¾��:�ԲӤ�TITLE
    private String titleC   = null;// �u�@¾�٤���(���)�W��
    private String depDt    = null;// �f�����
    private String cdc      = null;// ��Ť��q
    private String fltno    = null;//
    private String dep      = null;//
    private String arr      = null;// 
    private String updtDt   = null;// ���ʤ��
//    private String updtTime = null;// ���ʮɶ�
    private String updtUser = null;// ���ʤH��:UserID(6�X)
//    private String updtPgm  = "CISAPP";//���ʵ{��
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
