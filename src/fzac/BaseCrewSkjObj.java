package fzac;

import java.util.*;

/**
 * BaseCrewSkjObj
 * 
 * 
 * @author cs66
 * @version 1.0 2006/3/23
 * 
 * Copyright: Copyright (c) 2006
 */
public class BaseCrewSkjObj {
	
	private String empno;
	private String sern;
	private ArrayList crewSkj;

	public ArrayList getCrewSkj() {
		return crewSkj;
	}
	public void setCrewSkj(ArrayList crewSkj) {
		this.crewSkj = crewSkj;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}

}
