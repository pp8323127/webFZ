package eg.css;

import java.util.*;

/**
 * @author cs71 Created on  2009/7/29
 */
public class CpsCssObj
{
   private String caseno = "";
   private String reasonno = "";
   private String rid = "";
   private String rname = "";
   private String rsern = "";
   private String rgroup = "";
   private String rdetail = "";
   private String inpdate = "";
   private String rnunit = "";
   private String lastupd = "";
   private String lastupddate = "";
   private String status = "";
   private String description = "";
   private String investigation = "";
   private String flight_date = "";
   private String flight_no = "";
   private String aircraft_type = "";
   private String aircraft_no = "";
   private String origin = "";
   private String destination = "";
   private String subject = "";   
   private String fltd = "";   
   private String fltno = "";   
   private String sect = "";    
   private String psrempn = "";   
   private String station = "";   
   private int caseCnt = 0;   
   private String rdetail2 = "";   
   private String action_taken ="";
   
   private String purempno = "";
   private String purname = "";
   private String pursern = "";
   
   private String close_date = "";
   private String category ="";
   private String dept ="";
   private String item=""; 
   private String detail = "";
   
   ArrayList casenoAL = new ArrayList();      
   ArrayList filelinkAL = new ArrayList();    
   
	public String getAction_taken()
    {
        return action_taken;
    }
    public void setAction_taken(String action_taken)
    {
        this.action_taken = action_taken;
    }
    public String getCategory()
	{
	    return category;
	}
	public void setCategory(String category)
	{
	    this.category = category;
	}
	public String getDept()
	{
	    return dept;
	}
	public void setDept(String dept)
	{
	    this.dept = dept;
	}
	public String getDetail()
	{
	    return detail;
	}
	public void setDetail(String detail)
	{
	    this.detail = detail;
	}
	public String getItem()
	{
	    return item;
	}
	public void setItem(String item)
	{
	    this.item = item;
	}
	public String getClose_date()
	{
	    return close_date;
	}
	public void setClose_date(String close_date)
	{
	    this.close_date = close_date;
	}
	public String getPurempno()
	{
	    return purempno;
	}
	public void setPurempno(String purempno)
	{
	    this.purempno = purempno;
	}
	public String getPurname()
	{
	    return purname;
	}
	public void setPurname(String purname)
	{
	    this.purname = purname;
	}
	public String getPursern()
	{
	    return pursern;
	}
	public void setPursern(String pursern)
	{
	    this.pursern = pursern;
	}
	
	public ArrayList getFilelinkAL()
	{
	    return filelinkAL;
	}
	public void setFilelinkAL(ArrayList filelinkAL)
	{
	    this.filelinkAL = filelinkAL;
	}
	public String getRdetail2()
	{
	    return rdetail2;
	}
	public void setRdetail2(String rdetail2)
	{
	    this.rdetail2 = rdetail2;
	}
	public String getStation()
	{
	    return station;
	}
	public void setStation(String station)
	{
	    this.station = station;
	}
	public int getCaseCnt()
	{
	    return caseCnt;
	}
	public void setCaseCnt(int caseCnt)
	{
	    this.caseCnt = caseCnt;
	}
	public ArrayList getCasenoAL()
	{
	    return casenoAL;
	}
	public void setCasenoAL(ArrayList casenoAL)
	{
	    this.casenoAL = casenoAL;
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
	public String getPsrempn()
	{
	    return psrempn;
	}
	public void setPsrempn(String psrempn)
	{
	    this.psrempn = psrempn;
	}
	public String getSect()
	{
	    return sect;
	}
	public void setSect(String sect)
	{
	    this.sect = sect;
	}
	public String getAircraft_no()
	{
	    return aircraft_no;
	}
	public void setAircraft_no(String aircraft_no)
	{
	    this.aircraft_no = aircraft_no;
	}
	public String getAircraft_type()
	{
	    return aircraft_type;
	}
	public void setAircraft_type(String aircraft_type)
	{
	    this.aircraft_type = aircraft_type;
	}
	public String getCaseno()
	{
	    return caseno;
	}
	public void setCaseno(String caseno)
	{
	    this.caseno = caseno;
	}
	public String getDescription()
	{
	    return description;
	}
	public void setDescription(String description)
	{
	    this.description = description;
	}
	public String getDestination()
	{
	    return destination;
	}
	public void setDestination(String destination)
	{
	    this.destination = destination;
	}
	public String getFlight_date()
	{
	    return flight_date;
	}
	public void setFlight_date(String flight_date)
	{
	    this.flight_date = flight_date;
	}
	public String getFlight_no()
	{
	    return flight_no;
	}
	public void setFlight_no(String flight_no)
	{
	    this.flight_no = flight_no;
	}
	public String getInpdate()
	{
	    return inpdate;
	}
	public void setInpdate(String inpdate)
	{
	    this.inpdate = inpdate;
	}
	public String getInvestigation()
	{
	    return investigation;
	}
	public void setInvestigation(String investigation)
	{
	    this.investigation = investigation;
	}
	public String getLastupd()
	{
	    return lastupd;
	}
	public void setLastupd(String lastupd)
	{
	    this.lastupd = lastupd;
	}
	public String getLastupddate()
	{
	    return lastupddate;
	}
	public void setLastupddate(String lastupddate)
	{
	    this.lastupddate = lastupddate;
	}
	public String getOrigin()
	{
	    return origin;
	}
	public void setOrigin(String origin)
	{
	    this.origin = origin;
	}
	public String getRdetail()
	{
	    return rdetail;
	}
	public void setRdetail(String rdetail)
	{
	    this.rdetail = rdetail;
	}
	public String getReasonno()
	{
	    return reasonno;
	}
	public void setReasonno(String reasonno)
	{
	    this.reasonno = reasonno;
	}
	public String getRgroup()
	{
	    return rgroup;
	}
	public void setRgroup(String rgroup)
	{
	    this.rgroup = rgroup;
	}
	public String getRid()
	{
	    return rid;
	}
	public void setRid(String rid)
	{
	    this.rid = rid;
	}
	public String getRname()
	{
	    return rname;
	}
	public void setRname(String rname)
	{
	    this.rname = rname;
	}
	public String getRnunit()
	{
	    return rnunit;
	}
	public void setRnunit(String rnunit)
	{
	    this.rnunit = rnunit;
	}
	public String getRsern()
	{
	    return rsern;
	}
	public void setRsern(String rsern)
	{
	    this.rsern = rsern;
	}
	public String getStatus()
	{
	    return status;
	}
	public void setStatus(String status)
	{
	    this.status = status;
	}
	public String getSubject()
	{
	    return subject;
	}
	public void setSubject(String subject)
	{
	    this.subject = subject;
	}
}
