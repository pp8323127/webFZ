package fzac;

import java.io.*;

import ci.tool.*;

/**
 * FlyingTimeObj
 * 
 * 
 * @author cs66
 * @version 1.0 2006/3/29
 * 
 * Copyright: Copyright (c) 2006
 */
public class FlyingTimeObj  implements Serializable{
	private static final long serialVersionUID = -5007468055135930042L;
	private String fltno;
	private String series_num;
	private String flyTimeHHMM;
	private String flyTimeMins;
	private String flytimeHrs;
	private String fdateLocal;
	private String fdateTPE;
	private String dpt;
	private String arv;
	private String duty_cd;

	public String getFdateLocal() {
		return fdateLocal;
	}
	public void setFdateLocal(String fdateLocal) {
		this.fdateLocal = fdateLocal;
	}
	public String getFdateTPE() {
		return fdateTPE;
	}
	public void setFdateTPE(String fdateTPE) {
		this.fdateTPE = fdateTPE;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getFlyTimeHHMM() {
		return flyTimeHHMM;
	}
	private void setFlyTimeHHMM(String flyTimeHHMM) {
		this.flyTimeHHMM = flyTimeHHMM;
	}
	public String getFlytimeHrs() {
		return flytimeHrs;
	}
	private void setFlytimeHrs(String flytimeHrs) {
		this.flytimeHrs = flytimeHrs;
	}
	public String getFlyTimeMins() {
		return flyTimeMins;
	}
	public void setFlyTimeMins(String flyTimeMins) {
		this.flyTimeMins = flyTimeMins;
		setFlytimeHrs(TimeUtil.minToHours(4, flyTimeMins));
		setFlyTimeHHMM(TimeUtil.minToHHMM(flyTimeMins));
	}
	public String getSeries_num() {
		return series_num;
	}
	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}
	public String getArv() {
		return arv;
	}
	public void setArv(String arv) {
		this.arv = arv;
	}
	public String getDpt() {
		return dpt;
	}
	public void setDpt(String dpt) {
		this.dpt = dpt;
	}
	public String getDuty_cd() {
		return duty_cd;
	}
	public void setDuty_cd(String duty_cd) {
		this.duty_cd = duty_cd;
	}

}
