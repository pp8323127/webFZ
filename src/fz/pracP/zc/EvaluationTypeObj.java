package fz.pracP.zc;

/**
 * EvaluationTypeObj 考評項目物件
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/15
 * 
 * Copyright: Copyright (c) 2007
 */
public class EvaluationTypeObj {
	private String scoreType; // 考評項目代號
	private String scoreDesc;// 考評敘述
	private String descDetail;// 考評詳述描述

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
