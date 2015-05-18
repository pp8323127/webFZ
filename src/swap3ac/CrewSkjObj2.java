package swap3ac;



/**
 * 【AirCrews測試版】 <br>
 * CrewSkjObj 儲存組員班表資料（換班用）
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * 
 * Copyright: Copyright (c) 2005
 */
public class CrewSkjObj2 {
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
    private String actp;

    
    public String getActp()
    {
        return actp;
    }

    public void setActp(String actp)
    {
        this.actp = actp;
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
        } else {
            this.cr = cr;
        }

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
}