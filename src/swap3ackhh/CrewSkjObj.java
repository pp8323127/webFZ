package swap3ackhh;

import java.io.*;

import ci.tool.*;

/**
 * 
 * CrewSkjObj 儲存組員班表資料（換班用）,CR單位為HHMM
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * @version 1.1 2008/03/06 加入「星期」,dayOfWeek from 1-7,SUN=1
 * 
 * Copyright: Copyright (c) 2005
 */
public class CrewSkjObj implements Serializable{
	
    private static final long serialVersionUID = 7140354091696939393L;
  
	private String empno;
    private String fdate;//format: yyyy/mm/dd
    private String dutycode;
    private String tripno;
    private String cr;//每趟任務的飛時
    private String btime;
    private String etime;
    private String dpt;
    private String arv;
    private String cd;
    private String spCode; //roster_v.special_indicator
    private String dayOfWeek;//dayOfWeek from 1-7,SUN=1
    private String resthr;
    private String chkBox;
    private String detail;
    
    public String getResthr()
    {
        return resthr;
    }
    public void setResthr(String resthr)
    {
        this.resthr = resthr;
    }
    public String getCd() {
        return cd;
    }
    public void setCd(String cd) {
        this.cd = cd;
    }
    public String getCr() {
        return cr;
    }

    public void setCr(String cr) {
        if ( null == cr | "".equals(cr.trim()) ) {
            cr = "0000";
        }

        this.cr = TimeUtil.minToHHMM(cr);
    }

    public String getDutycode() {
        return dutycode;
    }

    public void setDutycode(String dutycode) {
        this.dutycode = dutycode;
    }

    public String getEmpno() {
        return empno;
    }

    public void setEmpno(String empno) {
        this.empno = empno;
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
        if ( null == tripno | "".equals(tripno.trim()) ) {
            tripno = "0000";
        }
        this.tripno = tripno;
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
    public String getSpCode() {
        return spCode;
    }
    public void setSpCode(String spCode) {
        this.spCode = spCode;
    }
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
    public String getChkBox()
    {
        return chkBox;
    }
    public void setChkBox(String chkBox)
    {
        this.chkBox = chkBox;
    }
    public String getDetail()
    {
        return detail;
    }
    public void setDetail(String detail)
    {
        this.detail = detail;
    }
	
}