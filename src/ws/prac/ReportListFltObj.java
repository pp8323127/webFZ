package ws.prac;

import java.util.ArrayList;

	//取得當月班表 list.add
public class ReportListFltObj {
	/*
	private String matchStr = null;
	private String ftime 	= null;
	private String rj 		= null;
	
	private String updAL	= null;//儲存報告的狀態(Y: 可編輯，N: 不可編輯)
	*/
		
	private String fdate	= null;
	private String ftime	= null;
	private String sdate	= null;
	private String edate	= null;
	private String etime	= null;
	private String fltno	= null;
	private String sect	= null;
	private String duty = null;
	private String qual = null;//acting_rank
	private String special_indicator = null;
	
	private String book_fdate   = null;
	private String book_fltno   = null;
	private String book_arln_cd   = null;//CI or AE
	private String acno = null;
	
	private String[] functionCode = null;
	///////
	
	public String getFdate() {
		return fdate;
	}
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}	
	public String getFtime() {
		return ftime;
	}
	public void setFtime(String ftime) {
		this.ftime = ftime;
	}
	
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getEtime() {
		return etime;
	}
	public void setEtime(String etime) {
		this.etime = etime;
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
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getQual() {
		return qual;
	}
	public void setQual(String qual) {
		this.qual = qual;
	}
	public String getSpecial_indicator() {
		return special_indicator;
	}
	public void setSpecial_indicator(String special_indicator) {
		this.special_indicator = special_indicator;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
    public String getBook_fdate()
    {
        return book_fdate;
    }
    public void setBook_fdate(String book_fdate)
    {
        this.book_fdate = book_fdate;
    }
    public String getBook_fltno()
    {
        return book_fltno;
    }
    public void setBook_fltno(String book_fltno)
    {
        this.book_fltno = book_fltno;
    }
    public String getBook_arln_cd()
    {
        return book_arln_cd;
    }
    public void setBook_arln_cd(String book_arln_cd)
    {
        this.book_arln_cd = book_arln_cd;
    }
    public String getAcno()
    {
        return acno;
    }
    public void setAcno(String acno)
    {
        this.acno = acno;
    }
    public String[] getFunctionCode()
    {
        return functionCode;
    }
    public void setFunctionCode(String[] functionCode)
    {
        this.functionCode = functionCode;
    }

	
	
	
}
