package ws;

public class LoginAppObj {
	private boolean result = false;
	private String code = null;
	private String message = null;
	private String employid = null;
    private String cname = null;
    private String ename = null;
    private String sitacode = null;
    private String email = null;
	
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
    public String getEmployid()
    {
        return employid;
    }
    public void setEmployid(String employid)
    {
        this.employid = employid;
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
    public String getSitacode()
    {
        return sitacode;
    }
    public void setSitacode(String sitacode)
    {
        this.sitacode = sitacode;
    }
    public String getEmail()
    {
        return email;
    }
    public void setEmail(String email)
    {
        this.email = email;
    }

	
//	public HRObj getHrObj() {
//		return hrObj;
//	}
//	public void setHrObj(HRObj hrObj) {
//		this.hrObj = hrObj;
//	}
	
	
}
