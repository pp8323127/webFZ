package fzac;

import java.io.*;

/**
 * DailyCheckObj
 * 
 * 
 * @author cs66
 * @version 1.0 2006/6/13
 * 
 * Copyright: Copyright (c) 2006
 */
public class DailyCheckObj implements Serializable {

	private static final long serialVersionUID = -3945797068360715455L;

	private String fdate;	
	private String stTPE;// 台北起飛時間
	private String edTPE;// 台北落地時間
	private String stLoc;// local 起飛時間
	private String fltno;
	private String fleet;
	private String sect;
	private String edLoc;// local 落地時間
	private String rmk;// 備註(TVL 或空白)
	private String eRpt;// 預估報到時間
	private String rRpt; // 實際報到時間
	private String fleet_cd;
	private String duty_cd;
	private int openCC1;
	private int openCC2;
	private int openCC3;
	private int openCC4;
	private int openCC5;
	private int openCC6;
	private int openCC7;
	private int totalPln;
	private int totalFil;
	private int totalOpen;
	
	
	private String sch; //schedule time yyyy/mm/ddHH24MI
	private String arln_cd;
	
	private int noShowNum=0;
	
	public String getEdLoc() {
		return edLoc;
	}
	public void setEdLoc(String edLoc) {
		this.edLoc = edLoc;
	}
	public String getERpt() {
		return eRpt;
	}
	public void setERpt(String rpt) {
		eRpt = rpt;
	}
	public String getFleet() {
		return fleet;
	}
	public void setFleet(String fleet) {
		this.fleet = fleet;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getRmk() {
		return rmk;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
	public String getRRpt() {
		return rRpt;
	}
	public void setRRpt(String rpt) {
		rRpt = rpt;
	}
	public String getSect() {
		return sect;
	}
	public void setSect(String sect) {
		this.sect = sect;
	}
	public String getStLoc() {
		return stLoc;
	}
	public void setStLoc(String stLoc) {
		this.stLoc = stLoc;
	}
	public String getStTPE() {
		return stTPE;
	}
	public void setStTPE(String stTPE) {
		this.stTPE = stTPE;
	}
	public String getEdTPE() {
		return edTPE;
	}
	public void setEdTPE(String edTPE) {
		this.edTPE = edTPE;
	}
	public String getFleet_cd() {
		return fleet_cd;
	}
	public void setFleet_cd(String fleet_cd) {
		this.fleet_cd = fleet_cd;
	}
	public String getDuty_cd() {
		return duty_cd;
	}
	public void setDuty_cd(String duty_cd) {
		this.duty_cd = duty_cd;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public int getOpenCC1() {
		return openCC1;
	}
	public void setOpenCC1(int openCC1) {
		this.openCC1 = openCC1;
	}
	public int getOpenCC2() {
		return openCC2;
	}
	public void setOpenCC2(int openCC2) {
		this.openCC2 = openCC2;
	}
	public int getOpenCC3() {
		return openCC3;
	}
	public void setOpenCC3(int openCC3) {
		this.openCC3 = openCC3;
	}
	public int getOpenCC4() {
		return openCC4;
	}
	public void setOpenCC4(int openCC4) {
		this.openCC4 = openCC4;
	}
	public int getOpenCC5() {
		return openCC5;
	}
	public void setOpenCC5(int openCC5) {
		this.openCC5 = openCC5;
	}
	public int getOpenCC6() {
		return openCC6;
	}
	public void setOpenCC6(int openCC6) {
		this.openCC6 = openCC6;
	}
	public int getOpenCC7() {
		return openCC7;
	}
	public void setOpenCC7(int openCC7) {
		this.openCC7 = openCC7;
	}
	public int getTotalFil() {
		return totalFil;
	}
	public void setTotalFil(int totalFil) {
		this.totalFil = totalFil;
	}
	public int getTotalOpen() {
		return totalOpen;
	}
	public void setTotalOpen(int totalOpen) {
		this.totalOpen = totalOpen;
	}
	public int getTotalPln() {
		return totalPln;
	}
	public void setTotalPln(int totalPln) {
		this.totalPln = totalPln;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	public String getArln_cd() {
		return arln_cd;
	}
	public void setArln_cd(String arln_cd) {
		this.arln_cd = arln_cd;
	}
	public String getSch() {
		return sch;
	}
	public void setSch(String sch) {
		this.sch = sch;
	}
	public int getNoShowNum() {
		return noShowNum;
	}
	public void setNoShowNum(int noShowNum) {
		this.noShowNum = noShowNum;
	}

}
