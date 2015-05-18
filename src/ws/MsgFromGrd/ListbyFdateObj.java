package ws.MsgFromGrd;

public class ListbyFdateObj {

	private String fltno = null;
	private String empno = null;
	private String cname = null;
	private String ename = null;
	private String grp = null;
	private String sern = null;
	private String sect = null;
	private String occu = null;
	private String trip_num = null;
	private String actFltTime = null;//提供時間判斷,發送前X小時
	
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getGrp() {
		return grp;
	}
	public void setGrp(String grp) {
		this.grp = grp;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}
	public String getSect() {
		return sect;
	}
	public void setSect(String sect) {
		this.sect = sect;
	}
	public String getOccu() {
		return occu;
	}
	public void setOccu(String occu) {
		this.occu = occu;
	}
	public String getTrip_num() {
		return trip_num;
	}
	public void setTrip_num(String trip_num) {
		this.trip_num = trip_num;
	}
    public String getActFltTime()
    {
        return actFltTime;
    }
    public void setActFltTime(String actFltTime)
    {
        this.actFltTime = actFltTime;
    }
	
}
