package apis;

import java.sql.*;
import java.util.*;
/**
 * @author cs71 Created on  2006/8/31
 */
public class ChkAPIS2
{

    Statement stmt = null;
    ResultSet rs = null;
    Connection conn = null;
    Driver dbDriver = null;
    String sql =  "";
    String sql2 =  "";
    ArrayList objAL = new ArrayList();
    String returnstr = "";
    int count = 0;
    
    public static void main(String[] args)
    {
        System.out.println("Start");
        ChkAPIS2 c = new ChkAPIS2();
        c.ChkApisEmpty("2007/03/07","2007/03/08","ALL");
        ArrayList objAL = new ArrayList();
        objAL = c.getObjAL();        
        System.out.println(c.getStr());
        
//        APISObj obj = (APISObj) objAL.get(0);
//        System.out.println(obj.getBirthcountry());
//        
        System.out.println(c.getObjAL().size());
        System.out.println("Done");
    }
    
     public void ChkApisEmpty(String sdt, String edt, String type)
    {
         String sdate ="";
         String edate = "";
         
         sdate = sdt.substring(2,4)+""+sdt.substring(5,7)+""+sdt.substring(8,10);
         edate = edt.substring(2,4)+""+edt.substring(5,7)+""+edt.substring(8,10);

        
        try
        {
	    	//set connect to DB2
	        DB2Conn cn = new DB2Conn();
//	        cn.setDB2User();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = conn.createStatement();	
  	
	    	cn.setDB2UserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
	    	
	    	if("ALL".equals(type))
	    	{    	    
		    	sql = " select rtrim(ltrim(carrier)) carrier,rtrim(ltrim(fltno)) fltno, rtrim(ltrim(fdate)) fdate," +
		    		  " rtrim(ltrim(empno)) empno, rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname," +
		    		  " rtrim(ltrim(depart)) depart, rtrim(ltrim(dest)) dest, rtrim(ltrim(tvlstatus)) tvlstatus," +
		    		  " rtrim(ltrim(birth)) birth, rtrim(ltrim(birthcity)) birthcity, rtrim(ltrim(birthcountry)) birthcountry, " +
		    		  " rtrim(ltrim(resicountry)) resicountry, rtrim(ltrim(passport)) passport, " +
		    		  " rtrim(ltrim(passcountry)) passcountry, rtrim(ltrim(doctype)) doctype, rtrim(ltrim(passexp)) passexp," +
		    		  " rtrim(ltrim(certno)) certno, rtrim(ltrim(certctry)) certctry, rtrim(ltrim(certdoctype)) certdoctype," +
		    		  " rtrim(ltrim(certexp)) certexp from CAL.DFTAPIS where (" +
		    		  " dest in ('ANC','ATL','BNA','BOS','CVG', " +
		    		  " 'DEN','DFW','GUM','HNL','HOU','JFK','LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA'," +
		    		  " 'SFO','TPA', 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN') " +
		    		  " or depart in ('ANC','ATL','BNA','BOS','CVG','DEN'," +
		    		  " 'DFW','GUM','HNL','HOU','JFK', 'LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA','SFO','TPA', " +
		    		  " 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN')) " +
		    		  " and fdate between '"+sdate+"' and '"+edate+"' and tvlstatus <> 'CR2' " +
		    		  " and (rtrim(ltrim(empno)) = '' or rtrim(ltrim(lname)) = '' " +
		    		  " or rtrim(ltrim(fname)) = '' or rtrim(ltrim(tvlstatus)) = '' or rtrim(ltrim(birth)) = '' " +
		    		  " or rtrim(ltrim(birthcity)) = '' or rtrim(ltrim(birthcountry)) = '' " +
		    		  " or rtrim(ltrim(resicountry)) = '' or rtrim(ltrim(passport)) = '' " +
		    		  " or rtrim(ltrim(passcountry)) = '' or rtrim(ltrim(doctype)) = '' " +
		    		  " or rtrim(ltrim(passexp)) = '' or rtrim(ltrim(certno)) = '' or rtrim(ltrim(certctry)) = '' " +
		    		  " or rtrim(ltrim(certdoctype)) = '' or rtrim(ltrim(certexp)) = '')  union all " +
		    		  " select rtrim(ltrim(carrier)) carrier,rtrim(ltrim(fltno)) fltno, rtrim(ltrim(fdate)) fdate," +
		    		  " rtrim(ltrim(empno)) empno, rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname," +
		    		  " rtrim(ltrim(depart)) depart, rtrim(ltrim(dest)) dest, rtrim(ltrim(tvlstatus)) tvlstatus," +
		    		  " rtrim(ltrim(birth)) birth, rtrim(ltrim(birthcity)) birthcity, rtrim(ltrim(birthcountry)) birthcountry, " +
		    		  " rtrim(ltrim(resicountry)) resicountry, rtrim(ltrim(passport)) passport, " +
		    		  " rtrim(ltrim(passcountry)) passcountry, rtrim(ltrim(doctype)) doctype, rtrim(ltrim(passexp)) passexp," +
		    		  " rtrim(ltrim(certno)) certno, rtrim(ltrim(certctry)) certctry, rtrim(ltrim(certdoctype)) certdoctype," +
		    		  " rtrim(ltrim(certexp)) certexp from CAL.DFTAPIS where (" +
		    		  " dest in ('ANC','ATL','BNA','BOS','CVG'," +
		    		  " 'DEN','DFW','GUM','HNL','HOU','JFK','LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA'," +
		    		  " 'SFO','TPA', 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN') " +
		    		  " or depart in ('ANC','ATL','BNA','BOS','CVG','DEN'," +
		    		  " 'DFW','GUM','HNL','HOU','JFK', 'LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA','SFO','TPA', " +
		    		  " 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN')) " +
		    		  " and fdate between '"+sdate+"' and '"+edate+"' and tvlstatus = 'CR2' " +
		    		  " and (rtrim(ltrim(empno)) = '' or rtrim(ltrim(lname)) = '' " +
		    		  " or rtrim(ltrim(fname)) = '' or rtrim(ltrim(tvlstatus)) = '' or rtrim(ltrim(birth)) = '' " +
		    		  " or rtrim(ltrim(birthcity)) = '' or rtrim(ltrim(birthcountry)) = '' " +
		    		  " or rtrim(ltrim(resicountry)) = '' or rtrim(ltrim(passport)) = '' " +
		    		  " or rtrim(ltrim(passcountry)) = '' or rtrim(ltrim(doctype)) = '' " +
		    		  " or rtrim(ltrim(passexp)) = '') order by tvlstatus, fdate, fltno, empno " ;
		    	
	    	    sql2 = " select count(*) c from cal.dftapis where ( " +
		    		  " dest in ('ANC','ATL','BNA','BOS','CVG'," +
		    		  " 'DEN','DFW','GUM','HNL','HOU','JFK','LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA'," +
		    		  " 'SFO','TPA', 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN') " +
		    		  " or depart in ('ANC','ATL','BNA','BOS','CVG','DEN'," +
		    		  " 'DFW','GUM','HNL','HOU','JFK', 'LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA','SFO','TPA', " +
		    		  " 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN')) " +
		    		  " and fdate between '"+sdate+"' and '"+edate+"' ";	    	    
	    	}
	    	else
	    	{
	    	    if("CR2".equals(type))
	    	    {
			    	sql = " select rtrim(ltrim(carrier)) carrier,rtrim(ltrim(fltno)) fltno, rtrim(ltrim(fdate)) fdate," +
			    		  " rtrim(ltrim(empno)) empno, rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname," +
			    		  " rtrim(ltrim(depart)) depart, rtrim(ltrim(dest)) dest, rtrim(ltrim(tvlstatus)) tvlstatus," +
			    		  " rtrim(ltrim(birth)) birth, rtrim(ltrim(birthcity)) birthcity, rtrim(ltrim(birthcountry)) birthcountry, " +
			    		  " rtrim(ltrim(resicountry)) resicountry, rtrim(ltrim(passport)) passport, " +
			    		  " rtrim(ltrim(passcountry)) passcountry, rtrim(ltrim(doctype)) doctype, rtrim(ltrim(passexp)) passexp," +
			    		  " rtrim(ltrim(certno)) certno, rtrim(ltrim(certctry)) certctry, rtrim(ltrim(certdoctype)) certdoctype," +
			    		  " rtrim(ltrim(certexp)) certexp from cal.dftapis where (" +
			    		  " dest in ('ANC','ATL','BNA','BOS','CVG'," +
			    		  " 'DEN','DFW','GUM','HNL','HOU','JFK','LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA'," +
			    		  " 'SFO','TPA', 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
			    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
			    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
			    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN') " +
			    		  " or depart in ('ANC','ATL','BNA','BOS','CVG','DEN'," +
			    		  " 'DFW','GUM','HNL','HOU','JFK', 'LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA','SFO','TPA', " +
			    		  " 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
			    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
			    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
			    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN')) " +
			    		  " and tvlstatus = '"+type+"' and fdate between '"+sdate+"' " +
			    		  " and '"+edate+"' and (rtrim(ltrim(empno)) = '' or rtrim(ltrim(lname)) = '' " +
			    		  " or rtrim(ltrim(fname)) = '' or rtrim(ltrim(tvlstatus)) = '' or rtrim(ltrim(birth)) = '' " +
			    		  " or rtrim(ltrim(birthcity)) = '' or rtrim(ltrim(birthcountry)) = '' " +
			    		  " or rtrim(ltrim(resicountry)) = '' or rtrim(ltrim(passport)) = '' " +
			    		  " or rtrim(ltrim(passcountry)) = '' or rtrim(ltrim(doctype)) = '' " +
			    		  " or rtrim(ltrim(passexp)) = '' ) " +
			    		  " order by tvlstatus, fdate,fltno,empno ";
	    		}
	    	    else
	    	    {
	    	        sql = " select rtrim(ltrim(carrier)) carrier,rtrim(ltrim(fltno)) fltno, rtrim(ltrim(fdate)) fdate," +
			    		  " rtrim(ltrim(empno)) empno, rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname," +
			    		  " rtrim(ltrim(depart)) depart, rtrim(ltrim(dest)) dest, rtrim(ltrim(tvlstatus)) tvlstatus," +
			    		  " rtrim(ltrim(birth)) birth, rtrim(ltrim(birthcity)) birthcity, rtrim(ltrim(birthcountry)) birthcountry, " +
			    		  " rtrim(ltrim(resicountry)) resicountry, rtrim(ltrim(passport)) passport, " +
			    		  " rtrim(ltrim(passcountry)) passcountry, rtrim(ltrim(doctype)) doctype, rtrim(ltrim(passexp)) passexp," +
			    		  " rtrim(ltrim(certno)) certno, rtrim(ltrim(certctry)) certctry, rtrim(ltrim(certdoctype)) certdoctype," +
			    		  " rtrim(ltrim(certexp)) certexp from cal.dftapis where (" +
			    		  " dest in ('ANC','ATL','BNA','BOS','CVG'," +
			    		  " 'DEN','DFW','GUM','HNL','HOU','JFK','LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA'," +
			    		  " 'SFO','TPA', 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
			    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
			    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
			    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN') " +
			    		  " or depart in ('ANC','ATL','BNA','BOS','CVG','DEN'," +
			    		  " 'DFW','GUM','HNL','HOU','JFK', 'LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA','SFO','TPA', " +
			    		  " 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
			    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
			    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
			    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN')) " +
			    		  " and tvlstatus = '"+type+"' and fdate between '"+sdate+"' " +
			    		  " and '"+edate+"' and (rtrim(ltrim(empno)) = '' or rtrim(ltrim(lname)) = '' " +
			    		  " or rtrim(ltrim(fname)) = '' or rtrim(ltrim(tvlstatus)) = '' or rtrim(ltrim(birth)) = '' " +
			    		  " or rtrim(ltrim(birthcity)) = '' or rtrim(ltrim(birthcountry)) = '' " +
			    		  " or rtrim(ltrim(resicountry)) = '' or rtrim(ltrim(passport)) = '' " +
			    		  " or rtrim(ltrim(passcountry)) = '' or rtrim(ltrim(doctype)) = '' " +
			    		  " or rtrim(ltrim(passexp)) = '' or rtrim(ltrim(certno)) = '' or rtrim(ltrim(certctry)) = '' " +
			    		  " or rtrim(ltrim(certdoctype)) = '' or rtrim(ltrim(certexp)) = '') " +
			    		  " order by tvlstatus, fdate,fltno,empno ";  
	    	    }
		    	
		    	sql2 = " select count(*) c from cal.dftapis where (" +
		    		  " dest in ('ANC','ATL','BNA','BOS','CVG'," +
		    		  " 'DEN','DFW','GUM','HNL','HOU','JFK','LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA'," +
		    		  " 'SFO','TPA', 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN') " +
		    		  " or depart in ('ANC','ATL','BNA','BOS','CVG','DEN'," +
		    		  " 'DFW','GUM','HNL','HOU','JFK', 'LAS','LAX','MIA','NYC','ORD','ORL','PDX','SEA','SFO','TPA', " +
		    		  " 'YVR','YTO','YYZ','YMX','AKJ','AOJ','AXT','CTS','FKS','FUK','GAJ','HIJ','HKD','HNA','HND'," +
		    		  " 'IWJ','IZO','KCZ','KIJ','KIX','KKJ','KMI','KMJ','KMQ','KOJ','KUH','MMB','MMJ','MMY','MYJ'," +
		    		  " 'NGO','NGS','NRT','NTQ','OBO','OIT','OKA','OKI','OKJ','ONJ','SDJ','TAK','TKS','TOY','TTJ'," +
		    		  " 'UBJ','YGJ','BFI','EWR','FAI','IAH','PAE','PTY','MGA','MAJ','TRW','SPN','ICN')) " +
		    		  " and tvlstatus = '"+type+"' and fdate between '"+sdate+"' " +
		    		  " and '"+edate+"' ";
	    	}
//System.out.println(sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    APISObj obj = new APISObj();
	    	    obj.setCarrier(rs.getString("carrier"));
	    	    obj.setFltno(rs.getString("fltno"));
	    	    obj.setFdate(rs.getString("fdate"));
	    	    obj.setEmpno(rs.getString("empno"));
	    	    obj.setLname(rs.getString("lname"));
	    	    obj.setFname(rs.getString("fname"));
	    	    obj.setDepart(rs.getString("depart"));
	    	    obj.setDest(rs.getString("dest"));
	    	    obj.setTvlstatus(rs.getString("tvlstatus"));
	    	    obj.setBirth(rs.getString("birth"));
	    	    obj.setBirthcity(rs.getString("birthcity"));
	    	    obj.setBirthcountry(rs.getString("birthcountry"));
	    	    obj.setResicountry(rs.getString("resicountry"));
	    	    obj.setPassport(rs.getString("passport"));
	    	    obj.setPasscountry(rs.getString("passcountry"));
	    	    obj.setDoctype(rs.getString("doctype"));
	    	    obj.setPassexp(rs.getString("passexp"));
	    	    obj.setCertno(rs.getString("certno"));
	    	    obj.setCertctry(rs.getString("certctry"));
	    	    obj.setCertdoctype(rs.getString("certdoctype"));
	    	    obj.setCertexp(rs.getString("certexp"));	    	    
	    	    objAL.add(obj);	    	    
	    	}
	    	
	    	rs = null;
	    	rs = stmt.executeQuery(sql2);
	    	if (rs.next())
	    	{
	    	  count = rs.getInt("c");  
	    	}
	    	returnstr = "Y";
        }
		catch (Exception e)
		{
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}    
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return returnstr;
    }
    
    public String getSql()
    {
        return sql;
    }
    
    public int getCount()
    {
        return count;
    }
}
