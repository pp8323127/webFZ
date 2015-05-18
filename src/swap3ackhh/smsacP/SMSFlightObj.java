package swap3ackhh.smsacP;

import java.io.*;
import java.util.*;

/**
 * SMSFlightObj 儲存航班資料及組員手機
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/12
 * 
 * Copyright: Copyright (c) 2006
 */
public class SMSFlightObj implements Serializable {

	private static final long serialVersionUID = -8824395973077209456L
	;
	private String fdate;
	private String fltno;
	private String series_num;
	private String btime;// HH:MM
	private String etime;// HH:MM
	private String dpt;
	private String arv;
	private ArrayList crewPhoneList;// 內容為crewPhoneListObj

	public ArrayList getCrewPhoneList() {
		return crewPhoneList;
	}
	public void setCrewPhoneList(ArrayList crewPhoneList) {
		this.crewPhoneList = crewPhoneList;
	}
	public String getFdate() {
		return fdate;
	}
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getSeries_num() {
		return series_num;
	}
	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}
	public String getBtime() {
		return btime;
	}
	public void setBtime(String btime) {
		this.btime = btime;
	}
	public String getEtime() {
		return etime;
	}
	public void setEtime(String etime) {
		this.etime = etime;
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

}
