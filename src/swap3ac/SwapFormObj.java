package swap3ac;

import java.util.*;

/**
 * ¡iAirCrews´ú¸Õª©¡j <br>
 * SwapFormObj
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * 
 * Copyright: Copyright (c) 2005
 */
public class SwapFormObj {
    private String formno;
    private String aEmpno;
    private String aSern;
    private String aCname;
    private String aGrps;
    private String aApplyTimes;
    private String aQual;
    private String rEmpno;
    private String rSern;
    private String rCname;
    private String rGrps;
    private String rApplyTimes;
    private String rQual;
    private String chg_all;
    private String aSwapHr;
    private String rSwapHr;
    private String aSwapDiff;
    private String rSwapDiff;
    private String aPrjcr;
    private String rPrjcr;
    private String aSwapCr;
    private String rSwapCr;
    private String overpay;
    private String over_hr;
    private String crew_comm;
    private String ed_check;
    private String comments;
    private String newuser;
    private String newdate;
    private String checkuser;
    private String checkdate;
    private ArrayList aSwapSkjAL;
    private ArrayList rSwapSkjAL;
    
    //Add by Betty on 20080601
    private String acount;
    private String acomm;
    private String rcount;
    private String rcomm;
    private String formtype;

    public String getAApplyTimes() {
        return aApplyTimes;
    }

    public void setAApplyTimes(String applyTimes) {
        aApplyTimes = applyTimes;
    }

    public String getACname() {
        return aCname;
    }

    public void setACname(String cname) {
        aCname = cname;
    }

    public String getAEmpno() {
        return aEmpno;
    }

    public void setAEmpno(String empno) {
        aEmpno = empno;
    }

    public String getAGrps() {
        return aGrps;
    }

    public void setAGrps(String grps) {
        aGrps = grps;
    }

    public String getAPrjcr() {
        return aPrjcr;
    }

    public void setAPrjcr(String prjcr) {
        aPrjcr = prjcr;
    }

    public String getAQual() {
        return aQual;
    }

    public void setAQual(String qual) {
        aQual = qual;
    }

    public String getASern() {
        return aSern;
    }

    public void setASern(String sern) {
        aSern = sern;
    }

    public String getASwapCr() {
        return aSwapCr;
    }

    public void setASwapCr(String swapCr) {
        aSwapCr = swapCr;
    }

    public String getASwapDiff() {
        return aSwapDiff;
    }

    public void setASwapDiff(String swapDiff) {
        aSwapDiff = swapDiff;
    }

    public String getASwapHr() {
        return aSwapHr;
    }

    public void setASwapHr(String swapHr) {
        aSwapHr = swapHr;
    }

    public ArrayList getASwapSkjAL() {
        return aSwapSkjAL;
    }

    public void setASwapSkjAL(ArrayList swapSkjAL) {
        aSwapSkjAL = swapSkjAL;
    }

    public String getCheckdate() {
        return checkdate;
    }

    public void setCheckdate(String checkdate) {
        this.checkdate = checkdate;
    }

    public String getCheckuser() {
        return checkuser;
    }

    public void setCheckuser(String checkuser) {
        this.checkuser = checkuser;
    }

    public String getChg_all() {
        return chg_all;
    }

    public void setChg_all(String chg_all) {
        this.chg_all = chg_all;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getCrew_comm() {
        return crew_comm;
    }

    public void setCrew_comm(String crew_comm) {
        this.crew_comm = crew_comm;
    }

    public String getEd_check() {
        return ed_check;
    }

    public void setEd_check(String ed_check) {
        this.ed_check = ed_check;
    }

    public String getFormno() {
        return formno;
    }

    public void setFormno(String formno) {
        this.formno = formno;
    }

    public String getNewdate() {
        return newdate;
    }

    public void setNewdate(String newdate) {
        this.newdate = newdate;
    }

    public String getNewuser() {
        return newuser;
    }

    public void setNewuser(String newuser) {
        this.newuser = newuser;
    }

    public String getOver_hr() {
        return over_hr;
    }

    public void setOver_hr(String over_hr) {
        this.over_hr = over_hr;
    }

    public String getOverpay() {
        return overpay;
    }

    public void setOverpay(String overpay) {
        this.overpay = overpay;
    }

    public String getRApplyTimes() {
        return rApplyTimes;
    }

    public void setRApplyTimes(String applyTimes) {
        rApplyTimes = applyTimes;
    }

    public String getRCname() {
        return rCname;
    }

    public void setRCname(String cname) {
        rCname = cname;
    }

    public String getREmpno() {
        return rEmpno;
    }

    public void setREmpno(String empno) {
        rEmpno = empno;
    }

    public String getRGrps() {
        return rGrps;
    }

    public void setRGrps(String grps) {
        rGrps = grps;
    }

    public String getRPrjcr() {
        return rPrjcr;
    }

    public void setRPrjcr(String prjcr) {
        rPrjcr = prjcr;
    }

    public String getRQual() {
        return rQual;
    }

    public void setRQual(String qual) {
        rQual = qual;
    }

    public String getRSern() {
        return rSern;
    }

    public void setRSern(String sern) {
        rSern = sern;
    }

    public String getRSwapCr() {
        return rSwapCr;
    }

    public void setRSwapCr(String swapCr) {
        rSwapCr = swapCr;
    }

    public String getRSwapDiff() {
        return rSwapDiff;
    }

    public void setRSwapDiff(String swapDiff) {
        rSwapDiff = swapDiff;
    }

    public String getRSwapHr() {
        return rSwapHr;
    }

    public void setRSwapHr(String swapHr) {
        rSwapHr = swapHr;
    }

    public ArrayList getRSwapSkjAL() {
        return rSwapSkjAL;
    }

    public void setRSwapSkjAL(ArrayList swapSkjAL) {
        rSwapSkjAL = swapSkjAL;
    }
    
    //Add by Betty on 20080601
    public String getAcomm()
    {
        return acomm;
    }
    public void setAcomm(String acomm)
    {
        this.acomm = acomm;
    }
    public String getAcount()
    {
        return acount;
    }
    public void setAcount(String acount)
    {
        this.acount = acount;
    }
    public String getRcomm()
    {
        return rcomm;
    }
    public void setRcomm(String rcomm)
    {
        this.rcomm = rcomm;
    }
    public String getRcount()
    {
        return rcount;
    }
    public void setRcount(String rcount)
    {
        this.rcount = rcount;
    }
    public String getFormtype()
    {
        return formtype;
    }
    public void setFormtype(String formtype)
    {
        this.formtype = formtype;
    }
}