package ws.prac;

public class ReportListCfltUpdObj {
    // 取得是否已經更新 list.add
    /**
     * @param args
     */
    private String fltd     = null;
    private String fltno    = null;
    private String sect     = null;
    private String wflag    = null; // Y: 有報告 N:無報告
    private String upd      = null; // Y:報告可再編輯 N:報告不可再編輯
    private String reject   = null; // 報告是否被退回
    private String rejectTime = null;//報告退回時間
    private String reply = null;//辦公室回覆
    private String acno     = null;
    private boolean late    = false;
    private String chgdate  = null;
    private String hasZc    = null;
    
    private String hasPRSFly = null;
    private String hasProj   = null;
    private String hasChkItem = null;
    
    private String errorMsg = "";
    private String resultMsg = "";

    // ////

    public String getWflag() {
        return wflag;
    }

    public void setWflag(String wflag) {
        this.wflag = wflag;
    }

    public String getUpd() {
        return upd;
    }

    public void setUpd(String upd) {
        this.upd = upd;
    }

    public String getReject() {
        return reject;
    }

    public void setReject(String reject) {
        this.reject = reject;
    }

    public String getAcno() {
        return acno;
    }

    public void setAcno(String acno) {
        this.acno = acno;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String getResultMsg() {
        return this.resultMsg;
    }

    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }

    public boolean isLate() {
        return late;
    }

    public void setLate(boolean late) {
        this.late = late;
    }

    public String getChgdate() {
        return chgdate;
    }

    public void setChgdate(String chgdate) {
        this.chgdate = chgdate;
    }

    public String getHasZc() {
        return hasZc;
    }

    public void setHasZc(String hasZc) {
        this.hasZc = hasZc;
    }

    public String getHasPRSFly() {
        return hasPRSFly;
    }

    public void setHasPRSFly(String hasPRSFly) {
        this.hasPRSFly = hasPRSFly;
    }

    public String getHasProj() {
        return hasProj;
    }

    public void setHasProj(String hasProj) {
        this.hasProj = hasProj;
    }

    public String getHasChkItem() {
        return hasChkItem;
    }

    public void setHasChkItem(String hasChkItem) {
        this.hasChkItem = hasChkItem;
    }

    public String getRejectTime()
    {
        return rejectTime;
    }

    public void setRejectTime(String rejectTime)
    {
        this.rejectTime = rejectTime;
    }

    public String getReply()
    {
        return reply;
    }

    public void setReply(String reply)
    {
        this.reply = reply;
    }

    public String getFltd() {
        return fltd;
    }

    public void setFltd(String fltd) {
        this.fltd = fltd;
    }

    public String getFltno() {
        return fltno;
    }

    public void setFltno(String fltno) {
        this.fltno = fltno;
    }

    public String getSect() {
        return sect;
    }

    public void setSect(String sect) {
        this.sect = sect;
    }


    
}
