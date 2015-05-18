package fzAuthP;

/**
 * 儲存人事資料的物件
 * 
 * @author cs66 at 2005/6/23
 */
public class HRObj {
	private String employid;
	private String exstflg;
	private String cname;
	private String analysa;
	private String unitcd;
	private String postlvl;
	private String postcd;
	private String indt;
	public String getAnalysa() {
		return analysa;
	}

	public void setAnalysa(String analysa) {
		this.analysa = analysa;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getEmployid() {
		return employid;
	}

	public void setEmployid(String employid) {
		this.employid = employid;
	}

	public String getExstflg() {
		return exstflg;
	}

	public void setExstflg(String exstflg) {
		this.exstflg = exstflg;
	}

	public String getUnitcd() {
		return unitcd;
	}

	public void setUnitcd(String unitcd) {
		this.unitcd = unitcd;
	}

	public String getPostlvl() {
		return postlvl;
	}

	public void setPostlvl(String postlvl) {
		this.postlvl = postlvl;
	}

	public String getPostcd() {
		return postcd;
	}

	public void setPostcd(String postcd) {
		this.postcd = postcd;
	}

	public String getIndt() {
		return indt;
	}

	public void setIndt(String indt) {
		this.indt = indt;
	}
}