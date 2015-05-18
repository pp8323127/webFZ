package swap3ackhh.smsacP;

import java.io.*;

/**
 * CrewPhoneListObj 儲存組員手機號碼等資料
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewPhoneListObj implements Serializable {
	
	private static final long serialVersionUID = 6289054199938688136L;
	private String empno;
	private String cname;
	private String mphone;
	private String fltno;
	private String sern;
	private String rank;
	private boolean newCrew = false;// 是否為新增組員
	private String dutyCd;

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
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
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
	public boolean isNewCrew() {
		return newCrew;
	}
	public void setNewCrew(boolean remark) {
		this.newCrew = remark;
	}
	public String getDutyCd() {
		return dutyCd;
	}
	public void setDutyCd(String dutyCd) {
		this.dutyCd = dutyCd;
	}

}
