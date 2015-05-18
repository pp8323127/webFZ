package fz.pracP.pa;

import java.util.*;

/**
 * PACrewEvalObj PA Crew 考評物件
 * 
 * 
 * @author cs71
 * @version 1.0 2007/07/10
 * 
 * Copyright: Copyright (c) 2008
 */
public class PACrewEvalObj {

	private String seqno;//資料序號
	private String gdYear;// 考績年度
	private String fltd;// flight Date,format: yyyy/mm/dd
	private Date flightDate;// flight Date
	private String fltno;// 航班號
	private String sect;// 區段
	private String empno;// PA員工號
	private String upduser;// 更新者
	private Date upddate;// 更新日期
	private String scoreType; // 考評項目代號
	private String score;// 分數
	private String comm;// 評語
	private String scoreDesc;// 考評敘述
	
	public String getComm() 
	{
		return comm;
	}
	
	public void setComm(String comm) 
	{
		this.comm = comm;
	}

	public String getEmpno() 
	{
		return empno;
	}
	
	public void setEmpno(String empno) 
	{
		this.empno = empno;
	}
	
	public String getFltd() 
	{
		return fltd;
	}
	
	public void setFltd(String fltd) 
	{
		this.fltd = fltd;
	}
	
	public String getFltno() 
	{
		return fltno;
	}
	
	public void setFltno(String fltno) 
	{
		this.fltno = fltno;
	}
	
	public String getGdYear() 
	{
		return gdYear;
	}
	
	public void setGdYear(String gdYear) 
	{
		this.gdYear = gdYear;
	}
	
	public String getScore() 
	{             
		return score;
	}
	
	public void setScore(String score) 
	{
		this.score = score;
	}
	
	public String getScoreDesc() 
	{
		return scoreDesc;
	}
	
	public void setScoreDesc(String scoreDesc) 
	{
		this.scoreDesc = scoreDesc;
	}
	
	public String getScoreType() 
	{
		return scoreType;
	}
	
	public void setScoreType(String scoreType) 
	{
		this.scoreType = scoreType;
	}
	
	public String getSect() 
	{
		return sect;
	}
	
	public void setSect(String sect) 
	{
		this.sect = sect;
	}
	
	public Date getUpddate() 
	{
		return upddate;
	}
	
	public void setUpddate(Date upddate) 
	{
		this.upddate = upddate;
	}
	
	public String getUpduser() 
	{
		return upduser;
	}
	
	public void setUpduser(String upduser) 
	{
		this.upduser = upduser;
	}
	
	public Date getFlightDate() 
	{
		return flightDate;
	}
	
	public void setFlightDate(Date flightDate)
	{
		this.flightDate = flightDate;
	}
	
	public String getSeqno() 
	{
		return seqno;		
	}
	
	public void setSeqno(String seqno) 
	{
		this.seqno = seqno;
	}

}