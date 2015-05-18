package fz.sb;

import java.sql.*;

/**
 * StanbyCrewObj
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/1
 * 
 * Copyright: Copyright (c) 2007
 */
public class StanbyCrewObj {
	private String series_num;
	private String empno;
	private java.util.Date str_dt;
	private java.util.Date end_dt;
	private Timestamp str_dt_ts;
	private Timestamp end_dt_ts;

	private Timestamp rRptDateTime;
	private Timestamp eRptDateTime;

	private boolean isReported = false;
	private boolean isOnTimeReported = false;
	private String sern;
	private String cname;
	private String groups;
	private String comments;
	private String duty_cd;

	public String getDuty_cd() {
		return duty_cd;
	}
	public void setDuty_cd(String duty_cd) {
		this.duty_cd = duty_cd;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public java.util.Date getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(java.util.Date end_dt) {
		this.end_dt = end_dt;
	}
	public String getSeries_num() {
		return series_num;
	}
	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}
	public java.util.Date getStr_dt() {
		return str_dt;
	}
	public void setStr_dt(java.util.Date str_dt) {
		this.str_dt = str_dt;
	}
	public boolean isReported() {
		return isReported;
	}
	public void setReported(boolean isReported) {
		this.isReported = isReported;
	}
	public Timestamp getEnd_dt_ts() {
		return end_dt_ts;
	}
	public void setEnd_dt_ts(Timestamp end_dt_ts) {
		this.end_dt_ts = end_dt_ts;
	}
	public Timestamp getStr_dt_ts() {
		return str_dt_ts;
	}
	public void setStr_dt_ts(Timestamp str_dt_ts) {
		this.str_dt_ts = str_dt_ts;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getGroups() {
		return groups;
	}
	public void setGroups(String groups) {
		this.groups = groups;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}
	public Timestamp getERptDateTime() {
		return eRptDateTime;
	}
	public void setERptDateTime(Timestamp rptDateTime) {
		eRptDateTime = rptDateTime;
	}
	public Timestamp getRRptDateTime() {
		return rRptDateTime;
	}
	public void setRRptDateTime(Timestamp rptDateTime) {
		rRptDateTime = rptDateTime;
		if (rptDateTime != null) {
			setReported(true);
		}
	}
	public boolean isOnTimeReported() {
		return isOnTimeReported;
	}
	public void setOnTimeReported(boolean isOnTimeReported) {
		this.isOnTimeReported = isOnTimeReported;
		if (isOnTimeReported) {
			this.isReported = true;
		}
	}

}