package fzac;

import java.io.*;

/**
 * CrewSkjObj
 * 
 * @author cs66
 * @version 1.0 2006/2/13
 * @version 1.1 2007/04/03 add duty_cd & dptTPELoc;
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewSkjObj implements Serializable {
	private static final long serialVersionUID = 8950641235844410765L;

	private String empno;
	private String dpt;
	private String arv;
	private String fltno;
	private String DtLoc;
	private String AvLoc;
	private String spCode;
	private String actingRank;
	private String fdateLoc;
	private String actp;
	private String series_num;
	private String roster_num;
	private String trnCd = "";
	private String trnDesc = "";
	private String trnFunction = "";
	private String duty_Cd;
	private String dptTPELoc;	//act_str_dt_tm_gmt,format yyyy/mm/ddhh24mi
	 

	public String getArv() {
		return arv;
	}

	public void setArv(String arv) {
		this.arv = arv;
	}

	public String getAvLoc() {
		return AvLoc;
	}

	public void setAvLoc(String avLoc) {
		AvLoc = avLoc;
	}

	public String getDpt() {
		return dpt;
	}

	public void setDpt(String dpt) {
		this.dpt = dpt;
	}

	public String getDtLoc() {
		return DtLoc;
	}

	public void setDtLoc(String dtLoc) {
		DtLoc = dtLoc;
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

	public String getSpCode() {
		return spCode;
	}

	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

	public String getActingRank() {
		return actingRank;
	}

	public void setActingRank(String actingRank) {
		this.actingRank = actingRank;
	}

	public String getFdateLoc() {
		return fdateLoc;
	}

	public void setFdateLoc(String fdateLoc) {
		this.fdateLoc = fdateLoc;
	}
	public String getActp() {
		return actp;
	}
	public void setActp(String actp) {
		this.actp = actp;
	}

	public String getRoster_num() {
		return roster_num;
	}

	public void setRoster_num(String roster_num) {
		this.roster_num = roster_num;
	}

	public String getSeries_num() {
		return series_num;
	}

	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}

	public String getTrnCd() {
		return trnCd;
	}

	public void setTrnCd(String trnCd) {
		this.trnCd = trnCd;
	}

	public String getTrnDesc() {
		return trnDesc;
	}

	public void setTrnDesc(String trnDesc) {
		this.trnDesc = trnDesc;
	}

	public String getTrnFunction() {
		return trnFunction;
	}

	public void setTrnFunction(String trnFunction) {
		this.trnFunction = trnFunction;
	}

	public String getDuty_Cd() {
		return duty_Cd;
	}

	public void setDuty_Cd(String duty_Cd) {
		this.duty_Cd = duty_Cd;
	}

	public String getDptTPELoc() {
		return dptTPELoc;
	}

	public void setDptTPELoc(String dptTPELoc) {
		this.dptTPELoc = dptTPELoc;
	}

	
}