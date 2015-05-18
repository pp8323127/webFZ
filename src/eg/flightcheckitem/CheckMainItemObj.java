package eg.flightcheckitem;

import java.util.*;

/**
 * CheckMainItemObj �Ү֥D����ƪ���
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/21
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckMainItemObj {
	private String seqno; // �d�ֶ��اǸ�
	//private boolean executeCheck = false;// �O�_�ݬd��
	private String description; // �d�ֶ��رԭz
	private String updUser; // ��s��
	private Date updDate; // ��s�ɶ�
	private String unit; // �t�d���

	private String fltno; // �d�֯�Z

	private boolean hasCheckData = false;// �w��J�d�ֶ���

	private ArrayList fltnoAL; // ���ˬd����Z��ƦC��
	private ArrayList checkDetailAL; // �d�ֲӶ����, �x�s CheckDetailItemObj ����

	private String checkRdSeq; // �d�֬����Ǹ�

	private Date startDate;// �d�ֶ}�l���
	private Date endDate;// �d�ֵ������
	
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
