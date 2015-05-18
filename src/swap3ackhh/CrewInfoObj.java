package swap3ackhh;

import ci.tool.*;

/**
 * 
 * CrewInfoObj 換班用組員個人資料,含：empno,cname,sern,qual,groups
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * 
 * Copyright: Copyright (c) 2005
 */
public class CrewInfoObj {
    private String empno;
    private String cname;
    private String sern;
    private String occu;
    private String qual;//FY,FC.....
    private String prjcr;

    private String grps;
    private String base;
    //private String spCode; 

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

    public String getGrps() {
        return grps;
    }

    public void setGrps(String grps) {
        this.grps = grps;
    }

    public String getQual() {
        return qual;
    }

    public void setQual(String qual) {
        this.qual = qual;
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

//    public String getSpCode() {
//        return spCode;
//    }
//
//    public void setSpCode(String spCode) {
//        if ( "N".equals(spCode) | "null".equals(spCode) | null == spCode ) {
//            this.spCode = "";
//        } else {
//            this.spCode = spCode;
//        }
//
//    }

    public String getPrjcr() {
        return prjcr;
    }

    public void setPrjcr(String prjcr) {
        
        this.prjcr = TimeUtil.minToHHMM(prjcr);
    }
}