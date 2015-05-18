package fzAuthP;

/**
 * @author cs66 at 2005/6/30
 * 
 * 2006/12/28 新增 jobno 2007/01/18 新增 group
 */
public class EGObj {

	private String empno;
	private String sern;
	private String section;
	private String cname;
	private String ename;
	private String occu;
	private String station;
	private String birth;
	private String jobno;
	private String group;
	private String status;

	public String getJobno() {
		return jobno;
	}

	public void setJobno(String jobno) {
		this.jobno = jobno;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
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

	public String getOccu() {
		return occu;
	}

	public void setOccu(String occu) {
		this.occu = occu;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getSern() {
		return sern;
	}

	public void setSern(String sern) {
		this.sern = sern;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
