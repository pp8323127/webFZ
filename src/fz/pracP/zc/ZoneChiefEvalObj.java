package fz.pracP.zc;

import java.util.*;

/**
 * ZoneChiefEvalObj �U�z�y�����ҵ�����
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/14
 * 
 * Copyright: Copyright (c) 2007
 */
public class ZoneChiefEvalObj {

	private String seqno;//��ƧǸ�
	private String gdYear;// ���Z�~��
	private String fltd;// flight Date,format: yyyy/mm/dd
	private Date flightDate;// flight Date
	private String fltno;// ��Z��
	private String sect;// �Ϭq
	private String empno;// ZC���u��
	private String upduser;// ��s��
	private Date upddate;// ��s���
	private String scoreType; // �ҵ����إN��
	private int score;// ����
	private String comm;// ���y
	private String scoreDesc;// �ҵ��ԭz
	private String descDetail;// �ҵ��ԭz�y�z
	
	public String getComm() {
		return comm;
	}
	public void setComm(String comm) {
		this.comm = comm;
	}
	public String getDescDetail() {
		return descDetail;
	}
	public void setDescDetail(String descDetail) {
		this.descDetail = descDetail;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
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
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getScoreDesc() {
		return scoreDesc;
	}
	public void setScoreDesc(String scoreDesc) {
		this.scoreDesc = scoreDesc;
	}
	public String getScoreType() {
		return scoreType;
	}
	public void setScoreType(String scoreType) {
		this.scoreType = scoreType;
	}
	public String getSect() {
		return sect;
	}
	public void setSect(String sect) {
		this.sect = sect;
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
	public Date getFlightDate() {
		return flightDate;
	}
	public void setFlightDate(Date flightDate) {
		this.flightDate = flightDate;
	}
	public String getSeqno() {
		return seqno;
	}
	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

}