package eg.flightcheckitem;

/**
 * CheckDetailItemObj 考核細項資料物件
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/21
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckDetailItemObj {
	private String seqno;// 考核主項流水號
	private String itemSeqno;// 考核細項流水號
	private boolean executeStatus = false;// 執行狀態,Y=true,N=false
	private boolean evalStatus = false;// 考核狀態,Y=true,N=false
	private String description;// 選項敘述

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isEvalStatus() {
		return evalStatus;
	}
	public void setEvalStatus(String evalStatus) {
		if ("Y".equals(evalStatus)) {
			this.evalStatus = true;
		}

	}
	public boolean isExecuteStatus() {
		return executeStatus;
	}
	public void setExecuteStatus(String executeStatus) {
		if ("Y".equals(executeStatus)) {
			this.executeStatus = true;
		}

	}
	public String getItemSeqno() {
		return itemSeqno;
	}
	public void setItemSeqno(String itemSeqno) {
		this.itemSeqno = itemSeqno;
	}
	public String getSeqno() {
		return seqno;
	}
	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

}
