package fz.pracP.pa;

import java.util.*;

/**
 * PACrewEvalMainObj PA Crews 考評物件--主要資訊
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/19
 * 
 * Copyright: Copyright (c) 2007
 */
public class PACrewEvalMainObj {
	private String seqno;// 資料序號
	private String gdYear;// 考績年度
	private String fltd;// flight Date,format: yyyy/mm/dd
	private Date flightDate;// flight Date
	private String fltno;// 航班號
	private String sect;// 區段
	private String empno;// PA員工號
	private String upduser;// 更新者
	private Date upddate;// 更新日期

	private ArrayList detailObjAL;
	
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public Date getFlightDate() {
		return flightDate;
	}
	public void setFlightDate(Date flightDate) {
		this.flightDate = flightDate;
	}
	public String getFltd() {
		return fltd;
	}
	public void setFltd(String fltd) {
		this.fltd = fltd;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getGdYear() {
		return gdYear;
	}
	public void setGdYear(String gdYear) {
		this.gdYear = gdYear;
	}
	public String getSect() {
		return sect;
	}
	public void setSect(String sect) {
		this.sect = sect;
	}
	public String getSeqno() {
		return seqno;
	}
	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}
	public Date getUpddate() {
		return upddate;
	}
	public void setUpddate(Date upddate) {
		this.upddate = upddate;
	}
	public String getUpduser() {
		return upduser;
	}
	public void setUpduser(String upduser) {
		this.upduser = upduser;
	}
	public ArrayList getDetailObjAL() {
		return detailObjAL;
	}
	public void setDetailObjAL(ArrayList detailObj) {
		this.detailObjAL = detailObj;
	}

}
