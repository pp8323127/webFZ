package fz.prObj;

/**
 * FltRptDataObj 儲存座艙長報告之flt data
 * 
 * @author cs66
 * @version 1.0 2006/2/20
 * 
 * Copyright: Copyright (c) 2006
 */
public class FltRptDataObj {
    private String stdDt;
    private String fltno;
    private String dpt;
    private String arv;
    private String psrEmpno;
    private String upd;//update status
    private String GdYear;
    private String bdot;

    public String getArv() {
        return arv;
    }

    public void setArv(String arv) {
        this.arv = arv;
    }

    public String getBdot() {
        return bdot;
    }

    public void setBdot(String bdot) {
        this.bdot = bdot;
    }

    public String getDpt() {
        return dpt;
    }

    public void setDpt(String dpt) {
        this.dpt = dpt;
    }

    public String getFltno() {
        return fltno;
    }

    public void setFltno(String fltno) {
        this.fltno = fltno;
    }

    public String getGdYear() {
        return GdYear;
    }

    public void setGdYear(String gdYear) {
        GdYear = gdYear;
    }

    public String getPsrEmpno() {
        return psrEmpno;
    }

    public void setPsrEmpno(String psrEmpno) {
        this.psrEmpno = psrEmpno;
    }

    public String getUpd() {
        return upd;
    }

    public void setUpd(String upd) {
        this.upd = upd;
    }

    public String getStdDt() {
        return stdDt;
    }

    public void setStdDt(String stdDt) {
        this.stdDt = stdDt;
    }
}