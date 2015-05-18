package ws.prac;

import java.util.ArrayList;

public class MdCrewListObj {
	int crewNum = 20;// 20名
	int shNum = 4;// 4次
	String cpname = null;
	String cpno = null;
	String psrempn = null;
	String psrsern = null;
	String psrname = null;
	String pgroups = null;
	String acno = null;
	String book_f = null;
	String book_c = null;
	String book_w = null;
	String book_y = null;
	String pxac = null;
	String inf = null;
	String upd = null;
	String chgdate = null;
	String sh_mp = null;
	String mp_empn = null;
	String mpname = null;
	String[] class_cat = null;
	
	String[] empn = new String[crewNum];
	String[] sern = new String[crewNum];
	String[] crew = new String[crewNum];
	String[] crewgrp = new String[crewNum];//組別
	String[] score = new String[crewNum];
	String[] duty = new String[crewNum];
	String[] shift = new String[crewNum];
	String[] sh_staTime = new String[shNum];
	String[] sh_endTime = new String[shNum];
	// String sh_staTime2 = null;//
	// String sh_endTime2 = null;//
	String sh_remark = null;//
	String isShift = null;//
	String sh_cm = null;//
	// ****************************************************************
	boolean iflessdisp = true;
	String fleet = "";
	String fltno = "";
	// ****************************************************************

	ArrayList gsEmpno = new ArrayList();// 服務
	ArrayList baEmpno = new ArrayList();// 服儀

	private String errorMsg = "";
	private String resultMsg = "";
	
	
	// ****************************************************************
	String bdot = "";
    String bdreason = "";
    // ****************************************************************    
	public String getBdot()
    {
        return bdot;
    }

    public String getBdreason()
    {
        return bdreason;
    }

    public void setBdot(String bdot)
    {
        this.bdot = bdot;
    }

    public void setBdreason(String bdreason)
    {
        this.bdreason = bdreason;
    }

    public int getCrewNum() {
		return crewNum;
	}

	public void setCrewNum(int crewNum) {
		this.crewNum = crewNum;
	}

	public int getShNum() {
		return shNum;
	}

	public void setShNum(int shNum) {
		this.shNum = shNum;
	}

	public String getCpname() {
		return cpname;
	}

	public void setCpname(String cpname) {
		this.cpname = cpname;
	}

	public String getCpno() {
		return cpno;
	}

	public void setCpno(String cpno) {
		this.cpno = cpno;
	}

	public String getPsrempn() {
		return psrempn;
	}

	public void setPsrempn(String psrempn) {
		this.psrempn = psrempn;
	}

	public String getPsrsern() {
		return psrsern;
	}

	public void setPsrsern(String psrsern) {
		this.psrsern = psrsern;
	}

	public String getPsrname() {
		return psrname;
	}

	public void setPsrname(String psrname) {
		this.psrname = psrname;
	}

	public String getPgroups() {
		return pgroups;
	}

	public void setPgroups(String pgroups) {
		this.pgroups = pgroups;
	}

	public String getAcno() {
		return acno;
	}

	public void setAcno(String acno) {
		this.acno = acno;
	}
	
	public String getChgdate() {
		return chgdate;
	}

	public void setChgdate(String chgdate) {
		this.chgdate = chgdate;
	}

	public String[] getEmpn() {
		return empn;
	}

	public void setEmpn(String[] empn) {
		this.empn = empn;
	}

	public String[] getSern() {
		return sern;
	}

	public void setSern(String[] sern) {
		this.sern = sern;
	}

	public String[] getCrew() {
		return crew;
	}

	public void setCrew(String[] crew) {
		this.crew = crew;
	}

	public String[] getScore() {
		return score;
	}

	public void setScore(String[] score) {
		this.score = score;
	}

	public String[] getDuty() {
		return duty;
	}

	public void setDuty(String[] duty) {
		this.duty = duty;
	}

	public String[] getShift() {
		return shift;
	}

	public void setShift(String[] shift) {
		this.shift = shift;
	}

	public String getBook_f() {
		return book_f;
	}

	public void setBook_f(String book_f) {
		this.book_f = book_f;
	}

	public String getBook_c() {
		return book_c;
	}

	public void setBook_c(String book_c) {
		this.book_c = book_c;
	}

	public String getBook_y() {
		return book_y;
	}

	public void setBook_y(String book_y) {
		this.book_y = book_y;
	}

	public String getPxac() {
		return pxac;
	}

	public void setPxac(String pxac) {
		this.pxac = pxac;
	}

	public String getInf() {
		return inf;
	}

	public void setInf(String inf) {
		this.inf = inf;
	}

	public String getUpd() {
		return upd;
	}

	public void setUpd(String upd) {
		this.upd = upd;
	}

	public String[] getSh_staTime() {
		return sh_staTime;
	}

	public void setSh_staTime(String[] sh_staTime) {
		this.sh_staTime = sh_staTime;
	}

	public String[] getSh_endTime() {
		return sh_endTime;
	}

	public void setSh_endTime(String[] sh_endTime) {
		this.sh_endTime = sh_endTime;
	}

	public String getSh_remark() {
		return sh_remark;
	}

	public void setSh_remark(String sh_remark) {
		this.sh_remark = sh_remark;
	}

	public String getIsShift() {
		return isShift;
	}

	public void setIsShift(String isShift) {
		this.isShift = isShift;
	}

	public String getSh_cm() {
		return sh_cm;
	}

	public void setSh_cm(String sh_cm) {
		this.sh_cm = sh_cm;
	}

	public String getFleet() {
		return fleet;
	}

	public void setFleet(String fleet) {
		this.fleet = fleet;
	}

	public boolean isIflessdisp() {
		return iflessdisp;
	}

	public void setIflessdisp(boolean iflessdisp) {
		this.iflessdisp = iflessdisp;
	}

	public String getFltno() {
		return fltno;
	}

	public void setFltno(String fltno) {
		this.fltno = fltno;
	}

	public ArrayList getGsEmpno() {
		return gsEmpno;
	}

	public void setGsEmpno(ArrayList gsEmpno) {
		this.gsEmpno = gsEmpno;
	}

	public ArrayList getBaEmpno() {
		return baEmpno;
	}

	public void setBaEmpno(ArrayList baEmpno) {
		this.baEmpno = baEmpno;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

    public String[] getCrewgrp()
    {
        return crewgrp;
    }

    public void setCrewgrp(String[] crewgrp)
    {
        this.crewgrp = crewgrp;
    }

    public String getSh_mp()
    {
        return sh_mp;
    }

    public void setSh_mp(String sh_mp)
    {
        this.sh_mp = sh_mp;
    }

    public String getMp_empn()
    {
        return mp_empn;
    }

    public void setMp_empn(String mp_empn)
    {
        this.mp_empn = mp_empn;
    }

    public String getMpname()
    {
        return mpname;
    }

    public void setMpname(String mpname)
    {
        this.mpname = mpname;
    }

    public String getBook_w()
    {
        return book_w;
    }

    public void setBook_w(String book_w)
    {
        this.book_w = book_w;
    }

    public String[] getClass_cat()
    {
        return class_cat;
    }

    public void setClass_cat(String[] class_cat)
    {
        this.class_cat = class_cat;
    }
    
    
}
