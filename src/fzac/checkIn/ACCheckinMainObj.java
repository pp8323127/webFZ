package fzac.checkIn;

import java.util.*;

/**
 * ACCheckinMainObj AirCrews Checkin Main Data Object
 * 
 * 
 * @author cs66
 * @version 1.0 2007/8/29
 * 
 * Copyright: Copyright (c) 2007
 */
public class ACCheckinMainObj {
	private String fltno;
	private String dptStation;
	private int noShowNum = 0;
	private ArrayList detailObjAL;
	
	public String getDptStation() {
		return dptStation;
	}
	public void setDptStation(String dptStation) {
		this.dptStation = dptStation;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public int getNoShowNum() {
		return noShowNum;
	}
	public void setNoShowNum(int noShowNum) {
		this.noShowNum = noShowNum;
	}
	public ArrayList getDetailObjAL() {
		return detailObjAL;
	}
	public void setDetailObjAL(ArrayList detailObjAL) {
		this.detailObjAL = detailObjAL;
	}
}
