package fz.gd;

import java.sql.*;
import java.util.*;
import apis.DB2Conn;
/**
 * @author cs71 Created on  2006/8/31
 */
public class DB2APIS
{

    Statement stmt = null;
    ResultSet rs = null;
    Connection conn = null;
    Driver dbDriver = null;
    String sql =  "";
    ArrayList objAL = new ArrayList();
    String returnstr = "";
    String carrier = "";
    String fltno = "";
    String fdate = ""; 
    String dpt = "";
    
    public static void main(String[] args)
    {
        System.out.println("Start");
//        DB2APIS c = new DB2APIS("CI","2007/05/30","065","TPE");
        DB2APIS c = new DB2APIS();
        ArrayList objAL = new ArrayList();
        c.getGDFromDB2("0687","2007/06/11","TPE");
        objAL = c.getObjAL(); 
        System.out.println(objAL.size());
        System.out.println(c.getStr());     
        System.out.println("Done");
    }
    
    public DB2APIS(String carrier, String fltno, String fdate, String dpt)
    {
        this.carrier = carrier;
        this.fltno = fltno;
        this.fdate = fdate;
        this.dpt = dpt;
        
        WebGd we = new WebGd();
	    //we.getWebEgData(carrier,fdate,fltno,dpt);    
	    objAL = we.getObjAL();
    }
    
    public DB2APIS()
    {        
    }
    
    
     public void getGDFromDB2(String fltno, String fdate, String dpt)
    {
         String sdate ="";         
         sdate = fdate.substring(2,4)+""+fdate.substring(5,7)+""+fdate.substring(8,10);
        
        try
        {
	    	//set connect to DB2
	        DB2Conn cn = new DB2Conn();
	        cn.setDB2User();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
  	
//	    	cn.setDB2UserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);
//			stmt = conn.createStatement();
	    		        	    
	    	sql = " select rtrim(ltrim(fltno)) fltno, rtrim(ltrim(empno)) empno, " +
	    		  " rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname, rtrim(ltrim(birth)) birth, " +
	    		  " rtrim(ltrim(nation)) nation, rtrim(ltrim(passport)) passport, rtrim(ltrim(gender)) gender, " +
	    		  " rtrim(ltrim(gdorder)) gdorder, rtrim(ltrim(occu)) occu, rtrim(ltrim(meal)) meal, " +
	    		  " rtrim(ltrim(dh)) dh, rtrim(ltrim(depart)) depart, rtrim(ltrim(dest)) dest, " +
	    		  " rtrim(ltrim(passexp)) passexp, rtrim(ltrim(fdate)) fdate " +
	    		  " from cal.dftapis where (fltno = '"+fltno+"' or fltno = '0"+fltno+"') " +
	    		  " and (rtrim(ltrim(occu)) = 'FE' or rtrim(ltrim(occu)) = 'OE' or rtrim(ltrim(occu)) = 'PO' " +
	    		  " or rtrim(ltrim(occu)) = 'LD' or rtrim(ltrim(occu)) = 'EM') " +
	    		  " and rtrim(ltrim(fdate)) = '"+sdate+"' and rtrim(ltrim(depart)) = '"+dpt+"' " ;	    	
	    	  
System.out.println(sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    WebGdObj obj = new WebGdObj();
			    obj.setEmpno("empno");
			    obj.setRank(rs.getString("occu"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setFdd("");
			    obj.setArv(rs.getString("depart"));
			    obj.setDpt(rs.getString("dest"));
			    obj.setCop_duty_cd("");
			    obj.setDuty_cd("");
			    obj.setArln_cd("");
			    obj.setFleet("");
			    obj.setOffset("");
			    obj.setOffsetorder(rs.getString("gdorder"));
			    obj.setListseq("");
			    obj.setMeal_type(rs.getString("meal"));
			    obj.setFdate(rs.getString("fdate"));
			    obj.setBirthdt(rs.getString("birth"));
			    obj.setLicno(rs.getString("passport"));
			    obj.setLicexp(rs.getString("passexp"));
			    obj.setSex(rs.getString("gender"));
			    obj.setWest_ename(rs.getString("lname")+"/"+rs.getString("fname"));
			    obj.setWest_passno(rs.getString("passport"));
			    obj.setWest_expdt(rs.getString("passexp"));
			    obj.setWest_nation(rs.getString("nation"));
			    obj.setNonwest_ename(rs.getString("lname")+"/"+rs.getString("fname"));
			    obj.setNonwest_passno(rs.getString("passport"));
			    obj.setNonwest_expdt(rs.getString("passexp"));
			    obj.setNonwest_nation(rs.getString("nation"));
			    objAL.add(obj);
	    	}
	    	
	    	objAL = sortAL(objAL);
	    	returnstr = "Y";
        }
		catch (Exception e)
		{
		    System.out.println(e.toString());
		    returnstr = "DB2 Error : "+e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}    
    }
     
     
     public ArrayList sortAL(ArrayList al)
     {
         ArrayList tempal = new ArrayList();
         ArrayList returnal = new ArrayList();
         
         for(int i =0; i < al.size(); i++)
         {
             WebGdObj obj= (WebGdObj) al.get(i);
             tempal.add(obj.getOffsetorder()+obj.getEmpno());            
         }
         Collections.sort(tempal);
         
         for(int i =0; i < tempal.size(); i++)
         {
             for(int j =0; j < al.size(); j++)
             {
                 WebGdObj obj= (WebGdObj) al.get(j);
                 String str = obj.getOffsetorder()+obj.getEmpno();                
                 if(str.equals(tempal.get(i)))
                 {
                     returnal.add(obj);
                     j=al.size();
                 }
             }
         }
         
         return returnal;    
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
}
