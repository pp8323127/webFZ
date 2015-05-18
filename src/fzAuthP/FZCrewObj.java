
package fzAuthP;

/**
 * 儲存fztcrew資料的物件
 * 
 * @author cs66 at 2005/6/30
 */
public class FZCrewObj 
{
	private String	empno;
	private String	sern;
	private String	sess;
	private String	cname;
	private String	ename;
	private String	cabin;
	private String	occu;
	private String	fleet;
	private String	base;
	private String	locked;

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getSern() {
		return sern;
	}

	public void setSern(String box) {
		this.sern = box;
	}

	public String getCabin() {
		return cabin;
	}

	public void setCabin(String cabin) {
		this.cabin = cabin;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getFleet() {
		return fleet;
	}

	public void setFleet(String fleet) {
		this.fleet = fleet;
	}

	public String getOccu() {
		return occu;
	}

	public void setOccu(String occu) {
		this.occu = occu;
	}

	public String getSess() {
		return sess;
	}

	public void setSess(String sess) {
		this.sess = sess;
	}

	public String getLocked() {
		return locked;
	}

	public void setLocked(String locked) {
		this.locked = locked;
	}
}