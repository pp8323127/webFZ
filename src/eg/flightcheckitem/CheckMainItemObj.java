package eg.flightcheckitem;

import java.util.*;

/**
 * CheckMainItemObj 考核主項資料物件
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/21
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckMainItemObj {
	private String seqno; // 查核項目序號
	//private boolean executeCheck = false;// 是否需查核
	private String description; // 查核項目敘述
	private String updUser; // 更新者
	private Date updDate; // 更新時間
	private String unit; // 負責單位

	private String fltno; // 查核航班

	private boolean hasCheckData = false;// 已輸入查核項目

	private ArrayList fltnoAL; // 需檢查的航班資料列表
	private ArrayList checkDetailAL; // 查核細項資料, 儲存 CheckDetailItemObj 物件

	private String checkRdSeq; // 查核紀錄序號

	private Date startDate;// 查核開始日期
	private Date endDate;// 查核結束日期
	
	public String getCheckRdSeq() {
		return checkRdSeq;
	}
	public void setCheckRdSeq(String checkRdSeq) {
		this.checkRdSeq = checkRdSeq;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
//	public boolean isExecuteCheck() {
//		return executeCheck;
//	}
//	public void setExecuteCheck(String executeCheck) {
//		if ("Y".equals(executeCheck)) {
//			this.executeCheck = true;
//		}
//
//	}
	public String getSeqno() {
		return seqno;
	}
	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public boolean isHasCheckData() {
		return hasCheckData;
	}
	public void setHasCheckData(boolean hasCheckData) {
		this.hasCheckData = hasCheckData;
	}
	public ArrayList getCheckDetailAL() {
		return checkDetailAL;
	}
	public void setCheckDetailAL(ArrayList checkDetailAL) {
		this.checkDetailAL = checkDetailAL;
	}
//	public void setExecuteCheck(boolean executeCheck) {
//		this.executeCheck = executeCheck;
//	}
	public Date getUpdDate() {
		return updDate;
	}
	public void setUpdDate(Date updDate) {
		this.updDate = updDate;
	}
	public String getUpdUser() {
		return updUser;
	}
	public void setUpdUser(String updUser) {
		this.updUser = updUser;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public ArrayList getFltnoAL() {
		return fltnoAL;
	}
	public void setFltnoAL(ArrayList fltnoAL) {
		this.fltnoAL = fltnoAL;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

}
