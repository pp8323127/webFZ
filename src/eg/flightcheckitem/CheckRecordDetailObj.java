package eg.flightcheckitem;

/**
 * CheckRecordDetailObj �Үֶ��ظ�ƲӶ�
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/26
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckRecordDetailObj {
	private String checkSeqno; // ��Ӫ��d�ֶ��جy����
	private String checkDetailSeq;// ��Ӫ��d�ֶ��ؿﶵ�y����
	private String checkRdSeq;// �d�ְO���D�ɬy����
	private String comments;// ����
	private boolean isCorrect = false;// �O�_�B��
	private String description;// �d�ֶ��زӶ��ԭz

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
