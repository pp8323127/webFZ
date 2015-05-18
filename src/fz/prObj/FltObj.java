package fz.prObj;

import fzac.*;

/**
 * FltObj �Z�����
 * 
 * SYSTEM:�y�������i
 * 
 * @author cs66
 * @version 1.0 2006/2/18
 * 2014/11/15 W�� 12/04�W��java
 * 
 * Copyright: Copyright (c) 2006
 */
public class FltObj {
    private String stdDt;//start Date Time yyyy/mm/dd hh24:mi
    private String endDt;//end Date Time yyyy/mm/dd hh24:mi
    private String stdD;//start Date yyyy/mm/dd
    private String endD;//end Date yyyy/mm/dd
    private CrewInfoObj purCrewObj; //�]�x�s�y�����ӤH���)
    private String purEmpno;
    private String dpt;
    private String arv;
    private String fltno;
    private String acno;
    private String actp;//fleet
    private String pxac;//���ȼ�
    private String actualF;//���F���ȫȤH��
    private String actualC;//���C���ȫȤH��
    private String actualY;//���Y���ȫȤH��
    private String actualW;//���W���ȫȤH��
    private String book_total;//�q���`�H��
    private String series_num;

    public String getPurEmpno() {
        return purEmpno;
    }

    public void setPurEmpno(String purEmpno) {
        this.purEmpno = purEmpno;
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

    public String getEndD() {
        return endD;
    }

    public void setEndD(String endD) {
        this.endD = endD;
    }

    public String getEndDt() {
        return endDt;
    }

    public void setEndDt(String endDt) {
        this.endDt = endDt;
    }

    public String getFltno() {
        return fltno;
    }

    public void setFltno(String fltno) {
        this.fltno = fltno;
    }

    public String getStdD() {
        return stdD;
    }

    public void setStdD(String stdD) {
        this.stdD = stdD;
    }

    public String getStdDt() {
        return stdDt;
    }

    public void setStdDt(String stdDt) {
        this.stdDt = stdDt;
    }

    public CrewInfoObj getPurCrewObj() {
        return purCrewObj;
    }

    public void setPurCrewObj(CrewInfoObj purCrewObj) {
        this.purCrewObj = purCrewObj;
    }

    public String getAcno() {
        return acno;
    }

    public void setAcno(String acno) {
        this.acno = acno;
    }

    public String getActualC() {
        return actualC;
    }

    public void setActualC(String actualC) {
        this.actualC = actualC;
    }

    public String getActualF() {
        return actualF;
    }

    public void setActualF(String actualF) {
        this.actualF = actualF;
    }

    public String getActualY() {
        return actualY;
    }

    public void setActualY(String actualY) {
        this.actualY = actualY;
    }

    public String getActualW()
    {
        return actualW;
    }

    public void setActualW(String actualW)
    {
        this.actualW = actualW;
    }

    public String getBook_total() {
        return book_total;
    }

    public void setBook_total(String book_total) {
        this.book_total = book_total;
    }

    public String getPxac() {
        return pxac;
    }

    public void setPxac(String pxac) {
        this.pxac = pxac;
    }
    public String getSeries_num() {
        return series_num;
    }
    public void setSeries_num(String series_num) {
        this.series_num = series_num;
    }

    public String getActp()
    {
        return actp;
    }

    public void setActp(String actp)
    {
        this.actp = actp;
    }
    
}