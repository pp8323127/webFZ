package fz.pracP.pa;

import java.util.*;

/**
 * PACrewEvalMainObj PA Crews �ҵ�����--�D�n��T
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/19
 * 
 * Copyright: Copyright (c) 2007
 */
public class PACrewEvalMainObj {
	private String seqno;// ��ƧǸ�
	private String gdYear;// ���Z�~��
	private String fltd;// flight Date,format: yyyy/mm/dd
	private Date flightDate;// flight Date
	private String fltno;// ��Z��
	private String sect;// �Ϭq
	private String empno;// PA���u��
	private String upduser;// ��s��
	private Date upddate;// ��s���

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
