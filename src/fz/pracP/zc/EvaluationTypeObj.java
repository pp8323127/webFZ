package fz.pracP.zc;

/**
 * EvaluationTypeObj �ҵ����ت���
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/15
 * 
 * Copyright: Copyright (c) 2007
 */
public class EvaluationTypeObj {
	private String scoreType; // �ҵ����إN��
	private String scoreDesc;// �ҵ��ԭz
	private String descDetail;// �ҵ��ԭz�y�z

	public String getDescDetail() {
		return descDetail;
	}
	public void setDescDetail(String descDetail) {
		this.descDetail = descDetail;
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
}
