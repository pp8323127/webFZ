package fzac;

import java.io.*;
import java.util.*;

/**
 * CrewPutSkjObj 儲存組員丟班資料
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/16
 * @version 1.1 2007/01/11 新增組員BASE資料
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewPutSkjObj implements Serializable{
	
	private static final long serialVersionUID = -3882677556080295757L;
	
	private String empno;
	private String sern;
	private String cname;
	private String occu;
	private String base;
	private ArrayList skjObj; // 儲存swap3ac.CrewSkjObj
	private ArrayList commentAL;

	public void setCrewInfo(swap3ac.CrewInfoObj obj) {
		this.empno = obj.getEmpno();
		this.sern = obj.getSern();
		this.base = obj.getBase();
		try {
			this.cname = new String(ci.tool.UnicodeStringParser
					.removeExtraEscape(obj.getCname()).getBytes(), "Big5");
		} catch (UnsupportedEncodingException e) {} catch (Exception e) {}
		this.occu = obj.getOccu();
	}
	public ArrayList getSkjObj() {
		return skjObj;
	}
	public void setSkjObj(ArrayList skjObj) {
		this.skjObj = skjObj;
	}
	public ArrayList getCommentAL() {
		return commentAL;
	}
	public void setCommentAL(ArrayList commentAL) {
		this.commentAL = commentAL;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getOccu() {
		return occu;
	}
	public void setOccu(String occu) {
		this.occu = occu;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}
	
	public String getBase() {
		return base;
	}
}
