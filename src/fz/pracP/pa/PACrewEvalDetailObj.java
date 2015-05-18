package fz.pracP.pa;

/**
 * PACrewEvalDetailObj PA Crew 考評物件--細項資訊：分數、評語部分
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/19
 * 
 * Copyright: Copyright (c) 2007
 */
public class PACrewEvalDetailObj {
	private String seqno;// 資料序號
	private String scoreType; // 考評項目代號
	private int score;// 分數
	private String comm;// 評語
	private String scoreDesc;// 考評項目敘述,EX: 領導統御
	private String descDetail;// 考評項目詳述描述,EX: 具邏輯組織決斷力及溝通協調能力
	
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
