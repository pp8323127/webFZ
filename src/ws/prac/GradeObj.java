package ws.prac;

public class GradeObj {
	private String gdtype = null;
	private String gdtypeName = null;
	private String comments = null;
	private String yearsern = null;	
	private String gdyear = null;
	private String empn = null;
	private String sern = null;
    private String newuser = null;
    private String newdate = null;
    private String chguser = null; 
	private String  chgdate = null; 		
	
	public String getGdyear()
    {
        return gdyear;
    }
    public void setGdyear(String gdyear)
    {
        this.gdyear = gdyear;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getEmpn()
    {
        return empn;
    }
    public String getNewuser()
    {
        return newuser;
    }
    public String getNewdate()
    {
        return newdate;
    }
    public String getChguser()
    {
        return chguser;
    }
    public String getChgdate()
    {
        return chgdate;
    }
    public void setEmpn(String empn)
    {
        this.empn = empn;
    }
    public void setNewuser(String newuser)
    {
        this.newuser = newuser;
    }
    public void setNewdate(String newdate)
    {
        this.newdate = newdate;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
    }
    public void setChgdate(String chgdate)
    {
        this.chgdate = chgdate;
    }
    public String getGdtype() {
		return gdtype;
	}
	public void setGdtype(String gdtype) {
		this.gdtype = gdtype;
	}
	public String getGdtypeName() {
		return gdtypeName;
	}
	public void setGdtypeName(String gdtypeName) {
		this.gdtypeName = gdtypeName;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getYearsern() {
		return yearsern;
	}
	public void setYearsern(String yearsern) {
		this.yearsern = yearsern;
	}
	
}
