package ws.personal.mvc;

public class SaveDetailCusObj
{
    private String tableKey = null;// �Dkey�P�D�ɤĽ]
    private String serialNo = null;// ��Ƭy���s�� int
    private String type     = null;// ��ƫ��A
//    M:meal
//    B:beverage
//    N:Newspaper
//    G:Magazine
//    V:Movie
//    S:Suggestion
//    R:Special request

    private String code     = null;// ��ƥN�X:refer �U��ƥN�X��;�p�GType=��R������쬰Null
    private String desc     = null;// �A�Ȼ��� :ex�S���\/���n����/Avia�q�u��; �p�GType=��R������줣�i��Null
    private String priority  = null;// �u������:1:must 2:nice to have 3:option�A�w�]��1
    private String frequency = null;// �ݨD�W�v:1: every time  2: periodically  3:one time�A�w�]��1
//    private int score    = 0;// ����:�Ƨ���ܥ�,MEAL:9 SEAT:8 OTHERS:1
//    private String status   = null;// �ݨD���A:1:open 2:close�A�w�]��1
    private String place    = null;// �ݨD��I�a�I:�����d�x/�n�����f/�ȿ�
//    private String permission = null;// �ݨD�P�N�P�_:Y/N�A�w�]���ť�
//    private String owner    = null;// �v�d���:CC/TZ/EF/SF/SZ/SV/KZ�A�w�]��SF
    private String updtDt   = null;// ���ʮɶ�   current date
//    private String updtTime = null;// �Y���s���Insert�ɡA�h�����PCRTUSER�ۦP, current time
    private String updtUser = null;// ���ʤH��  Station(3�X)+CRI(6�X)+Update UserID(6�X)
//    private String updtPgm  = "CISAPP";//���ʵ{�� 
    
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
