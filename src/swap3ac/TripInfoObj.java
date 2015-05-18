package swap3ac;

import ci.tool.*;

/**
 * TripInfoObj
 * 
 * @author cs66
 * @version 1.0 2006/1/17
 * 
 * Copyright: Copyright (c) 2006
 */
public class TripInfoObj {
	private String tripno;
	private String fdate;
	private String dpt;
	private String arv;
	private String btime;
	private String etime;
	private String duty;
	private String crInMin;
	private String crInHHMM;
	private String crInHours;
	public String getArv() {
		return arv;
	}

	public void setArv(String arv) {
		this.arv = arv;
	}

	public String getBtime() {
		return btime;
	}

	public void setBtime(String btime) {
		this.btime = btime;
	}

	public String getDpt() {
		return dpt;
	}

	public void setDpt(String dpt) {
		this.dpt = dpt;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public String getTripno() {
		return tripno;
	}

	public void setTripno(String tripno) {
		this.tripno = tripno;
	}

	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}

	public String getCrInMin() {
		return crInMin;
	}

	public void setCrInMin(String cr) {
		this.crInMin = cr;
		setCrInHHMM(TimeUtil.minToHHMM(cr));
		setCrInHours(TimeUtil.minToHours(3, cr));
	}

	public String getCrInHHMM() {
		return crInHHMM;
	}

	public void setCrInHHMM(String crInHHMM) {
		this.crInHHMM = crInHHMM;
	}

	public String getCrInHours() {
		return crInHours;
	}

	public void setCrInHours(String crInHours) {
		this.crInHours = crInHours;
	}
}