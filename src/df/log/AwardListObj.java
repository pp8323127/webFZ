package df.log;

/**
 * AwardListObj Àx¦saward Lsit¸ê®Æ
 * 
 * @author cs66
 * @version 1.0 2005/10/28
 * 
 * Copyright: Copyright (c) 2005
 */
public class AwardListObj {
    private String transdt;
    private String empno;
    private String awardid;
    private String awardcd;
    private String basert;
    private String apdesc;
    private String remarks;

    public String getApdesc() {
        return apdesc;
    }

    public void setApdesc(String apdesc) {
        this.apdesc = apdesc;
    }

    public String getAwardcd() {
        return awardcd;
    }

    public void setAwardcd(String awardcd) {
        this.awardcd = awardcd;
    }

    public String getAwardid() {
        return awardid;
    }

    public void setAwardid(String awardid) {
        this.awardid = awardid;
    }

    public String getBasert() {
        return basert;
    }

    public void setBasert(String basert) {
        this.basert = basert;
    }

    public String getEmpno() {
        return empno;
    }

    public void setEmpno(String empno) {
        this.empno = empno;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        if(null ==remarks){
            this.remarks="";
        }else{
            this.remarks = remarks;    
        }
        
    }

    public String getTransdt() {
        return transdt;
    }

    public void setTransdt(String transdt) {
        this.transdt = transdt;
    }
}