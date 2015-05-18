package sch;

import java.util.*;

/**
 * CrewMonthlyScheObj
 * 
 * 
 * @author cs66
 * @version 1.0 2007/5/2
 * 
 * Copyright: Copyright (c) 2007
 */
public class CrewMonthlyScheObj {
	private String empno;
	private String cname;
	private String cr;
	private String rank;
	private ArrayList skjAL; // crewScheDetailObj
	private String scheStr;
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCr() {
		return cr;
	}
	public void setCr(String cr) {
		this.cr = cr;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public ArrayList getSkjAL() {
		return skjAL;
	}
	public void setSkjAL(ArrayList skjAL) {
		this.skjAL = skjAL;
	}
	public String getScheStr() {
		return scheStr;
	}
	public void setScheStr(String scheStr) {
		this.scheStr = scheStr;
	}
	
}
