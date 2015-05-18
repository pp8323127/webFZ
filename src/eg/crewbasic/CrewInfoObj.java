package eg.crewbasic;

import java.io.*;

/**
 * 【AirCrews正式版】 <br>
 * CrewInfoObj 組員個人資料,含：empno,cname,sern,base,gorups
 * 
 * @author cs66
 * @version 1.0 2006/02/11
 * 
 * Copyright: Copyright (c) 2005
 */
public class CrewInfoObj implements Serializable{     
		
	private static final long serialVersionUID = -5864576591890763377L;
	
	private String empno;
    private String cname;
    private String sern;
    private String occu;
    private String base;
    private String grp;
    private String ename;
    private String spCode;
    private boolean isNewCrew = false; //新增的組員，for 座艙長報告之班機組員名單
    private String fd_ind;//前艙為Y,後艙為N
    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getEmpno() {
        return empno;
    }

    public void setEmpno(String empno) {
        this.empno = empno;
    }

    public String getSern() {
        return sern;
    }

    public void setSern(String sern) {
        this.sern = sern;
    }

    public String getBase() {
        return base;
    }

    public void setBase(String base) {
        this.base = base;
    }

    public String getOccu() {
        return occu;
    }

    public void setOccu(String occu) {
        this.occu = occu;
    }

    public String getGrp() {
        return grp;
    }

    public void setGrp(String grp) {
        this.grp = grp;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getSpCode() {
        return spCode;
    }

    public void setSpCode(String spCode) {
        this.spCode = spCode;
    }

    public boolean isNewCrew() {
        return isNewCrew;
    }

    public void setNewCrew(boolean isNewCrew) {
        this.isNewCrew = isNewCrew;
    }

	public String getFd_ind() {
		return fd_ind;
	}

	public void setFd_ind(String fd_ind) {
		this.fd_ind = fd_ind;
	}
}