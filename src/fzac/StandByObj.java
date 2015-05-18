package fzac;

/**
 * StandByObj Stand By Info
 * 
 * @author cs66
 * @version 1.0 2006/2/14
 * 
 * Copyright: Copyright (c) 2006
 */
public class StandByObj {
    private String dutyCd;
    private String startDt;
    private String endDt;
    private String empno;
    private String sern;
    private String cname;
    private String grps;
    private String rank;
    private String startTm;
    private String endTm;

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getDutyCd() {
        return dutyCd;
    }

    public void setDutyCd(String dutyCd) {
        this.dutyCd = dutyCd;
    }

    public String getEmpno() {
        return empno;
    }

    public void setEmpno(String empno) {
        this.empno = empno;
    }

    public String getEndDt() {
        return endDt;
    }

    public void setEndDt(String end) {
        this.endDt = end;
    }

    public String getGrps() {
        return grps;
    }

    public void setGrps(String grps) {
        this.grps = grps;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getSern() {
        return sern;
    }

    public void setSern(String sern) {
        this.sern = sern;
    }

    public String getStartDt() {
        return startDt;
    }

    public void setStartDt(String start) {
        this.startDt = start;
    }

    public String getEndTm() {
        return endTm;
    }

    public void setEndTm(String endTm) {
        this.endTm = endTm;
    }

    public String getStartTm() {
        return startTm;
    }

    public void setStartTm(String startTm) {
        this.startTm = startTm;
    }
}