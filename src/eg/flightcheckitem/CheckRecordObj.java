package eg.flightcheckitem;

import java.util.*;

/**
 * CheckRecordObj 考核項目資料主檔
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/26
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckRecordObj {
	private String series_num;// series_num
	private String fltd; // flight date ,format: yyyy/mm/dd
	private String fltno;// flight number
	private String sector;// departure and arrival station
	private String psrEmpn;// purser's empno
	private String psrCname; // purser's Chinese Name from EG
	private java.sql.Date flightDate;// flight date in type if java.sql.Date

	private String seqno;
	private String checkSeqno;
	private boolean executeCheck = false;// 是否執行查核
	private boolean evalStatus = false;// 執行結果
	private String comments;// 附註

	private ArrayList checkDetailAL;// 儲存 CheckRecordDetailObj

	private String acno;// ACNO
	private String psrSern;// 座艙長序號
	public ArrayList getCheckDetailAL() {
		return checkDetailAL;
	}

	public void setCheckDetailAL(ArrayList checkDetailAL) {
		this.checkDetailAL = checkDetailAL;
	}

	public String getCheckSeqno() {
		return checkSeqno;
	}

	public void setCheckSeqno(String checkSeqno) {
		this.checkSeqno = checkSeqno;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public boolean isEvalStatus() {
		return evalStatus;
	}

	public void setEvalStatus(String evalStatus) {
		if ("Y".equals(evalStatus)) {
			this.evalStatus = true;
		} else {
			this.evalStatus = false;
		}
		// this.evalStatus = evalStatus;
	}

	public boolean isExecuteCheck() {
		return executeCheck;
	}

	public void setExecuteCheck(String executeCheck) {
		if ("Y".equals(executeCheck)) {
			this.executeCheck = true;
		} else {
			this.executeCheck = false;
		}
		// this.executeCheck = executeCheck;
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

	public String getPsrEmpn() {
		return psrEmpn;
	}

	public void setPsrEmpn(String psrEmpn) {
		this.psrEmpn = psrEmpn;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public String getSeqno() {
		return seqno;
	}

	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

	public String getSeries_num() {
		return series_num;
	}

	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}

	public java.sql.Date getFlightDate() {
		return flightDate;
	}

	public void setFlightDate(java.sql.Date flightDate) {
		this.flightDate = flightDate;
	}

	public void setEvalStatus(boolean evalStatus) {
		this.evalStatus = evalStatus;
	}

	public void setExecuteCheck(boolean executeCheck) {
		this.executeCheck = executeCheck;
	}

	public String getPsrCname() {
		return psrCname;
	}

	public void setPsrCname(String psrCname) {
		this.psrCname = psrCname;
	}

	public String getAcno() {
		return acno;
	}

	public void setAcno(String acno) {
		this.acno = acno;
	}

	public String getPsrSern() {
		return psrSern;
	}

	public void setPsrSern(String psrSern) {
		this.psrSern = psrSern;
	}

}
