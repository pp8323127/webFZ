package ws.personal.mvc;

public class SaveDetailCusObj
{
    private String tableKey = null;// 主key與主檔勾稽
    private String serialNo = null;// 資料流水編號 int
    private String type     = null;// 資料型態
//    M:meal
//    B:beverage
//    N:Newspaper
//    G:Magazine
//    V:Movie
//    S:Suggestion
//    R:Special request

    private String code     = null;// 資料代碼:refer 各資料代碼檔;如果Type=’R’此欄位為Null
    private String desc     = null;// 服務說明 :ex猶太餐/不要牛奶/Avia礦泉水; 如果Type=’R’此欄位不可為Null
    private String priority  = null;// 優先順序:1:must 2:nice to have 3:option，預設為1
    private String frequency = null;// 需求頻率:1: every time  2: periodically  3:one time，預設為1
//    private int score    = 0;// 評等:排序顯示用,MEAL:9 SEAT:8 OTHERS:1
//    private String status   = null;// 需求狀態:1:open 2:close，預設為1
    private String place    = null;// 需求實施地點:報到櫃台/登機門口/客艙
//    private String permission = null;// 需求同意與否:Y/N，預設為空白
//    private String owner    = null;// 權責單位:CC/TZ/EF/SF/SZ/SV/KZ，預設為SF
    private String updtDt   = null;// 異動時間   current date
//    private String updtTime = null;// 若為新資料Insert時，則此欄位與CRTUSER相同, current time
    private String updtUser = null;// 異動人員  Station(3碼)+CRI(6碼)+Update UserID(6碼)
//    private String updtPgm  = "CISAPP";//異動程式 
    
    public String getTableKey()
    {
        return tableKey;
    }
    public void setTableKey(String tableKey)
    {
        this.tableKey = tableKey;
    }

    public String getSerialNo()
    {
        return serialNo;
    }
    public void setSerialNo(String serialNo)
    {
        this.serialNo = serialNo;
    }
    public String getType()
    {
        return type;
    }
    public void setType(String type)
    {
        this.type = type;
    }
    public String getCode()
    {
        return code;
    }
    public void setCode(String code)
    {
        this.code = code;
    }
    public String getDesc()
    {
        return desc;
    }
    public void setDesc(String desc)
    {
        this.desc = desc;
    }
    public String getPriority()
    {
        return priority;
    }
    public void setPriority(String priority)
    {
        this.priority = priority;
    }
    public String getFrequency()
    {
        return frequency;
    }
    public void setFrequency(String frequency)
    {
        this.frequency = frequency;
    }

//    public int getScore()
//    {
//        return score;
//    }
//    public void setScore(int score)
//    {
//        this.score = score;
//    }
    //    public String getStatus()
//    {
//        return status;
//    }
//    public void setStatus(String status)
//    {
//        this.status = status;
//    }
    public String getPlace()
    {
        return place;
    }
    public void setPlace(String place)
    {
        this.place = place;
    }
//    public String getPermission()
//    {
//        return permission;
//    }
//    public void setPermission(String permission)
//    {
//        this.permission = permission;
//    }
//    public String getOwner()
//    {
//        return owner;
//    }
//    public void setOwner(String owner)
//    {
//        this.owner = owner;
//    }
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
    
    
}
