package fz.pracP.pa;

/**
 * PACrewEvalDetailObj PA Crew �ҵ�����--�Ӷ���T�G���ơB���y����
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/19
 * 
 * Copyright: Copyright (c) 2007
 */
public class PACrewEvalDetailObj {
	private String seqno;// ��ƧǸ�
	private String scoreType; // �ҵ����إN��
	private int score;// ����
	private String comm;// ���y
	private String scoreDesc;// �ҵ����رԭz,EX: ��ɲαs
	private String descDetail;// �ҵ����ظԭz�y�z,EX: ���޿��´�M�_�O�η��q��կ�O
	
	public String getComm() {
		return comm;
	}
	public void setComm(String comm) {
		this.comm = comm;
	}
	public String getDescDetail() {
		return descDetail;
	}
	public void setDescDetail(String descDetail) {
		this.descDetail = descDetail;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getScoreDesc() {
		return scoreDesc;
	}
	public void setScoreDesc(String scoreDesc) {
		this.scoreDesc = scoreDesc;
	}
	public String getScoreType() {
		return scoreType;
	}
	public void setScoreType(String scoreType) {
		this.scoreType = scoreType;
	}
	public String getSeqno() {
		return seqno;
	}
	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}
	
	
}
