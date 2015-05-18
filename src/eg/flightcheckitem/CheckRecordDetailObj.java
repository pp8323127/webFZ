package eg.flightcheckitem;

/**
 * CheckRecordDetailObj 考核項目資料細項
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/26
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckRecordDetailObj {
	private String checkSeqno; // 對照的查核項目流水號
	private String checkDetailSeq;// 對照的查核項目選項流水號
	private String checkRdSeq;// 查核記錄主檔流水號
	private String comments;// 附註
	private boolean isCorrect = false;// 是否矯正
	private String description;// 查核項目細項敘述

	public String getCheckDetailSeq() {
		return checkDetailSeq;
	}
	public void setCheckDetailSeq(String checkDetailSeq) {
		this.checkDetailSeq = checkDetailSeq;
	}
	public String getCheckRdSeq() {
		return checkRdSeq;
	}
	public void setCheckRdSeq(String checkRdSeq) {
		this.checkRdSeq = checkRdSeq;
	}
	public String getCheckSeqno() {
		return checkSeqno;
	}
	public void setCheckSeqno(String checkSeqno) {
		this.checkSeqno = checkSeqno;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public boolean isCorrect() {
		return isCorrect;
	}
	public void setCorrect(String isCorrect) {
		if ("Y".equals(isCorrect)) {
			this.isCorrect = true;
		}
		// this.isCorrect = isCorrect;
	}
	public void setCorrect(boolean isCorrect) {
		this.isCorrect = isCorrect;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

}
