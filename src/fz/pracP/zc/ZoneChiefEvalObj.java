package fz.pracP.zc;

import java.util.*;

/**
 * ZoneChiefEvalObj 助理座艙長考評物件
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/14
 * 
 * Copyright: Copyright (c) 2007
 */
public class ZoneChiefEvalObj {

	private String seqno;//資料序號
	private String gdYear;// 考績年度
	private String fltd;// flight Date,format: yyyy/mm/dd
	private Date flightDate;// flight Date
	private String fltno;// 航班號
	private String sect;// 區段
	private String empno;// ZC員工號
	private String upduser;// 更新者
	private Date upddate;// 更新日期
	private String scoreType; // 考評項目代號
	private int score;// 分數
	private String comm;// 評語
	private String scoreDesc;// 考評敘述
	private String descDetail;// 考評詳述描述
	
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