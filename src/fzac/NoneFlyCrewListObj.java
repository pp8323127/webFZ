package fzac;

/**
 * NoneFlyCrewListObj 非FLY任務crew List 資料
 * 
 * @author cs66
 * @version 1.0 2006/2/17
 * 
 * Copyright: Copyright (c) 2006
 */
public class NoneFlyCrewListObj {
	private String empno;
	private String sern;
	private String cname;
	private String base;
	private String rank;
	private String fdate;
	private String dutyCd;
	private String fleet_cd;
	private String grp;

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getDutyCd() {
		return dutyCd;
	}

	public void setDutyCd(String dutyCd) {
		this.dutyCd = dutyCd;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public String getSern() {
		return sern;
	}

	public void setSern(String sern) {
		this.sern = sern;
	}

	public String getFleet_cd() {
		return fleet_cd;
	}

	public void setFleet_cd(String fleet_cd) {
		this.fleet_cd = fleet_cd;
	}

	public String getGrp() {
		return grp;
	}

	public void setGrp(String grp) {
		this.grp = grp;
	}
}