package ws.crew;

import fzAuthP.*;

public class LoginAppBObj {
    private boolean result = false;
    private String code = null;
    private String message = null;
//    private String employid = null;
//    private String cname = null;
//    private String ename = null;
//    private String groups = null;
//    private String base = null;
//    private String lock = null;
    FZCrewObj fzCrewObj = null;
    
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public boolean isResult() {
        return result;
    }
    public void setResult(boolean result) {
        this.result = result;
    }
//    public String getEmployid()
//    {
//        return employid;
//    }
//    public void setEmployid(String employid)
//    {
//        this.employid = employid;
//    }
//    public String getCname()
//    {
//        return cname;
//    }
//    public void setCname(String cname)
//    {
//        this.cname = cname;
//    }
//    public String getEname()
//    {
//        return ename;
//    }
//    public void setEname(String ename)
//    {
//        this.ename = ename;
//    }
//    public String getGroups()
//    {
//        return groups;
//    }
//    public void setGroups(String groups)
//    {
//        this.groups = groups;
//    }
//    public String getBase()
//    {
//        return base;
//    }
//    public void setBase(String base)
//    {
//        this.base = base;
//    }
//    public String getLock()
//    {
//        return lock;
//    }
//    public void setLock(String lock)
//    {
//        this.lock = lock;
//    }
    public FZCrewObj getFzCrewObj()
    {
        return fzCrewObj;
    }
    public void setFzCrewObj(FZCrewObj fzCrewObj)
    {
        this.fzCrewObj = fzCrewObj;
    }


    
    
}
