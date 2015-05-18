package eg.flightcheckitem;

/**
 * CheckItemKeyValue 查核項目比對Key值, 以fltdate,fltno,sector,purser empno 為key值,
 * 改版後以series_num為key值
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/21
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckItemKeyValue {
	private String fltd; // flight date ,format: yyyy/mm/dd
	private String fltno;// flight number
	private String sector;// departure and arrival station
	private String psrEmpn;// purser's empno
	private String series_num;// series_num

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
	public String getPsrEmpn() {
		return psrEmpn;
	}
	public void setPsrEmpn(String psrEmpn) {
		this.psrEmpn = psrEmpn;
	}
	public String getSector() {
		return sector;
	}
	public void setSector(String sector) {
		this.sector = sector;
	}
	public String getSeries_num() {
		return series_num;
	}
	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}

}
