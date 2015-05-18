package swap3ackhh.smsacP;

import java.io.*;

/**
 * ContactPhoneObj
 * 
 * 
 * @author cs66
 * @version 1.0 2007/12/22
 * 
 * Copyright: Copyright (c) 2007
 */
public class ContactPhoneObj implements Serializable {

	private static final long serialVersionUID = 7921129522309474470L;
	private String empno;
	private String surName;
	private String firstName;
	private String phoneNumber;
	private String fdate;
	private String fltno;
	private String crewName;

	public String getFdate() {
		return fdate;
	}
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getSurName() {
		return surName;
	}
	public void setSurName(String surName) {
		this.surName = surName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
}
