package fz.gd;

import apis.*;
import ci.db.ConnDB;
import java.sql.*;
import java.util.*;

public class WebGd
{

	public static void main(String []args)
	{
//	    String dd = "2007/11/06 2340";
//	    System.out.println(dd.substring(0,4));
//	    System.out.println(dd.substring(5,7));
//	    System.out.println(dd.substring(8,10));
//	    System.out.println(dd.substring(5));
	    
	    WebGd we = new WebGd();
	    we.getWebEgData("CI","2008/12/29","0601","TPE","1100");
//	    System.out.println(we.getObjAL().size());
	    //we.getGDFromDB2("6887","2007/12/12","TPE");
	    //ArrayList al = we.getObjAL();
	    //we.tool_AL_print(al);
	    System.out.println("Done");
		
	}
	
	Connection conn = null;
	Driver dbDriver = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql  = "";
	String error = "";
	String returnstr = "";	
	ArrayList objAL = new ArrayList();
	WebGdObj objInfo = new WebGdObj();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("ddMMMyy", Locale.US);
    //*****************************************************
    public void getWebEgData(String arln_cd, String fdate, String fltno, String dpt, String takeofftime)
	{
		try
		{
		    ConnDB cn = new ConnDB();
		    
          cn.setORP3FZUser();
          java.lang.Class.forName(cn.getDriver());
          conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,cn.getConnPW());
          stmt = conn.createStatement();      
          
//	  		cn.setORP3FZUserCP();
//	  		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//	  		conn = dbDriver.connect(cn.getConnURL(), null);
//	  		stmt = conn.createStatement(); 
//          
			sql = " SELECT * FROM ( " +
				  " 	select r.staff_num, " +
				  " 	decode(cr.rank_cd,'FC','ZC', cr.rank_cd) act_rank, " +
				  " 	dps.flt_num flt_num, " +
				  " 	to_char(dps.str_dt_tm_gmt,'dd') fdd, dps.act_port_b act_port_b, " +
				  " 	dps.act_port_a act_port_a, " +
				  "     decode(decode(dps.cop_duty_cd,'JPS','JCM',dps.cop_duty_cd),null,' ','',' ','('||decode(dps.cop_duty_cd,'JPS','JCM',dps.cop_duty_cd)||')') cop_duty_cd, " +
				  " 	dps.duty_cd duty_cd, NVL(dps.arln_cd,'CI') arln_cd, dps.fleet_cd fleet_cd, " +
				  " 	CASE WHEN dps.cop_duty_cd='ACM' " +
				  "      	 THEN Decode(cr.rank_cd,'CA',600000+cv.empl_dt - To_Date('19650101','yyyymmdd'), " +
				  "      	                        'RP',630000+cv.empl_dt - To_Date('19650101','yyyymmdd'), " +
				  "     	                        'FO',660000+cv.empl_dt - To_Date('19650101','yyyymmdd'),990000) " +
				  "     	 WHEN dps.cop_duty_cd='ECM' " +
				  "    	     THEN Decode(cr.rank_cd,'CA',700000+cv.empl_dt - To_Date('19650101','yyyymmdd'), " +
				  "                             	'RP',730000+cv.empl_dt - To_Date('19650101','yyyymmdd'), " +
				  "                             	'FO',760000+cv.empl_dt - To_Date('19650101','yyyymmdd'),990000) " +
				  "      	WHEN dps.cop_duty_cd='JPS' " +
				  "      	THEN Decode(cr.rank_cd, 'CA',800000+cv.empl_dt - To_Date('19650101','yyyymmdd'), " +
				  "                             	'RP',830000+cv.empl_dt - To_Date('19650101','yyyymmdd'), " +
				  "                             	'FO',860000+cv.empl_dt - To_Date('19650101','yyyymmdd'),990000) " +
				  " 	ELSE Decode (cr.rank_cd, " +
				  "      'CA',110000+To_Number(nvl(ck.listseq,0)), 'RP',120000+To_Number(nvl(ck.listseq,0)), " +
				  "      'FO',130000+To_Number(nvl(ck.listseq,0)), 'FE',130000+To_Number(nvl(ck.listseq,0)), " +
				  "      'FD',130000+To_Number(nvl(ck.listseq,0)), 'PR',140000, 'MF',160000, 'MC',160000, " +
				  "      'MY',160000, 'FF',170000, 'FC',150000, 'FY',170000,990000) END offsetorder, " +
				  " 	ck.listseq listseq, cv.empl_dt - To_Date('19650101','yyyymmdd') offset, " +
				  " 	decode(cm.meal_type,null,' ','',' ',cm.meal_type) meal_type, " +
				  " 	dps.str_dt_tm_loc fdate, lc.licence_num lcno, lc.exp_dt lcexp, " +
				  "     Decode(dps.fd_ind,'Y',pa1.ename, pb1.ename) west_ename, " +
				  "     Decode(dps.fd_ind,'Y',pa1.passno, pb1.passno) west_passno, " +
				  "	    Decode(dps.fd_ind,'Y',pa1.exp_date, pb1.exp_date) west_expdt, " +
				  "     Decode(dps.fd_ind,'Y',trim(pa1.nation), trim(pb1.nation)) west_nation, " +
				  "     Decode(dps.fd_ind,'Y',pa2.ename, pb2.ename) nonwest_ename, " +
				  "     Decode(dps.fd_ind,'Y',pa2.passno, pb2.passno) nonwest_passno, " +
				  "     Decode(dps.fd_ind,'Y',pa2.exp_date, pb2.exp_date) nonwest_expdt, " +
				  "     Decode(dps.fd_ind,'Y',trim(pa2.nation), trim(pb2.nation)) nonwest_nation, " +
				  "     Decode(dps.fd_ind,'Y',pa2.sex, pb2.sex) sex, " +
				  "     Decode(dps.fd_ind,'Y',pa2.birthdt, pb2.birthdt) birthdt " +
				  " from  fzdb.roster_v r, fzdb.duty_prd_seg_v dps, fzdb.crew_v cv, " +
				  " 	(SELECT listseq, empno FROM fztckpl c, fzdb.duty_prd_seg_v dps, fzdb.roster_v r " +
				  "  	WHERE c.empno = r.staff_num AND r.series_num = dps.series_num and r.delete_ind='N' " +
				  " 	AND dps.delete_ind='N' " +
				  " 	and dps.str_dt_tm_loc = To_Date('"+fdate+" "+takeofftime+"','yyyy/mm/dd hh24mi') " +
				  " 	and (dps.flt_num = '"+fltno+"' OR dps.flt_num='0"+fltno+"') AND dps.act_port_a = '"+dpt+"' " +
				  " 	AND SubStr(dps.fleet_cd,1,2) = SubStr(c.ac_type,1,2) ) ck, " +
				  " 	(SELECT * FROM fzdb.crew_rank_v " +
				  " 	WHERE (exp_dt IS NULL OR exp_dt>=sysdate) AND eff_dt <=SYSDATE) cr, " +
				  " 	( SELECT m1.staff_num staff_num, decode(m1.meal_type,NULL,' ','',' ','('||m1.meal_type||')') meal_type " +
				  "      FROM fzdb.crew_special_meals_v m1, (SELECT staff_num, Max(meal_type) meal_type, Max(eff_fm_dt) eff_fm_dt " +
				  "           FROM fzdb.crew_special_meals_v WHERE eff_fm_dt <=SYSDATE " +
				  "           AND (eff_to_dt IS NULL OR eff_to_dt>=sysdate)  GROUP BY staff_num) m2  " +
				  "           WHERE m1.staff_num = m2.staff_num AND m1.eff_fm_dt <=SYSDATE " +
				  "           AND m1.eff_fm_dt = m2.eff_fm_dt AND m1.meal_type = m2.meal_type AND (m1.eff_to_dt IS NULL OR m1.eff_to_dt>=sysdate) ) cm, " +
				  "    (SELECT staff_num, licence_num, To_Char(exp_dt,'yymmdd') exp_dt FROM fzdb.crew_licence_v " +
				  "     WHERE licence_cd = 'CHN' and str_dt <= SYSDATE AND (exp_dt IS NULL OR exp_dt >= sysdate) ) lc, " +
				  "    (SELECT empno, REPLACE(REPLACE(ename,',','/'),'-',' ') ename,  " +
				  "     REPLACE(REPLACE(pass_no,' ',''),'-','') passno,  exp_date, SubStr(issue_nation,1,2) nation  " +
				  "     FROM egtpass  WHERE doc_tp = 'P' AND issue_date <= SYSDATE AND exp_date >=SYSDATE ) pb1, " +
				  "    (SELECT Trim(empn) empno, REPLACE(REPLACE(ename,' ','/'),'-',' ') ename, " +
				  "     REPLACE(REPLACE(passport,' ',''),'-','') passno,  passdate exp_date, " +
				  "     Decode(nation,1,'TW',2,'JP',3,'SG',4,'TH',5,'TH',6 ,'MY',7,'IN',8,'VN','N/A') nation, " +
				  "     To_Char(birth,'yymmdd') birthdt, sex FROM egtcbas) pb2, " +
				  "    (SELECT empno, lname||'/'||fname ename, REPLACE(REPLACE(passno,' ',''),'-',' ') passno, " +
				  "     expdate exp_date, SubStr(issuectry,1,2) nation  FROM dftpass ) pa1, " +
				  "    (SELECT cv.staff_num empno, other_surname||'/'||REPLACE(other_first_name,'-',' ') ename, " +
				  "     REPLACE(REPLACE(passport_num,' ',''),'-','') passno, exp_dt exp_date, nationality_cd nation, " +
				  "     To_Char(birth_dt,'yymmdd') birthdt, sex FROM fzdb.crew_v cv, fzdb.crew_passport_v cp " +
				  "     WHERE cv.staff_num = cp.staff_num(+)) pa2 " +
				  " where r.series_num = dps.series_num  AND r.staff_num = cr.staff_num (+)  " +
				  "     AND r.staff_num = cv.staff_num (+) AND r.staff_num = ck.empno (+) " +
				  "     AND r.staff_num = cm.staff_num (+) " +
				  "     AND r.staff_num = lc.staff_num (+) " +
				  "     AND r.staff_num = pb1.empno (+) AND r.staff_num = pb2.empno (+) " +
				  "     AND r.staff_num = pa1.empno (+) AND r.staff_num = pa2.empno (+) " +
				  "     and r.delete_ind='N' AND dps.delete_ind='N' " +
				  "     and dps.duty_cd in ('FLY','TVL') " +
				  "     and dps.str_dt_tm_loc = To_Date('"+fdate+" "+takeofftime+"','yyyy/mm/dd hh24mi') " +
				  "     and (dps.flt_num = '"+fltno+"' OR dps.flt_num='0"+fltno+"') AND dps.act_port_a = '"+dpt+"' " +
				  " ) ORDER BY  offsetorder, staff_num ";
			
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
			    WebGdObj obj = new WebGdObj();
			    obj.setEmpno(rs.getString("staff_num"));
			    obj.setRank(rs.getString("act_rank"));
			    obj.setFltno(rs.getString("flt_num"));
			    obj.setFdd(rs.getString("fdd"));
			    obj.setArv(rs.getString("act_port_b"));
			    obj.setDpt(rs.getString("act_port_a"));
			    obj.setCop_duty_cd(rs.getString("cop_duty_cd"));
			    obj.setDuty_cd(rs.getString("duty_cd"));
			    obj.setArln_cd(rs.getString("arln_cd"));
			    obj.setFleet(rs.getString("fleet_cd"));
			    obj.setOffset(rs.getString("offset"));
			    obj.setOffsetorder(rs.getString("offsetorder"));
			    obj.setListseq(rs.getString("listseq"));
			    obj.setMeal_type(rs.getString("meal_type"));
			    String tempFdate = formatter.format(rs.getDate("fdate")).toUpperCase();
			    obj.setFdate(tempFdate);
			    obj.setBirthdt(rs.getString("birthdt"));
			    obj.setLicno(rs.getString("lcno"));
			    obj.setLicexp(rs.getString("lcexp"));
			    obj.setSex(rs.getString("sex"));
			    obj.setWest_ename(rs.getString("west_ename"));
			    obj.setWest_passno(rs.getString("west_passno"));
			    obj.setWest_expdt(rs.getString("west_expdt"));
			    obj.setWest_nation(rs.getString("west_nation"));
			    obj.setNonwest_ename(rs.getString("nonwest_ename"));
			    obj.setNonwest_passno(rs.getString("nonwest_passno"));
			    obj.setNonwest_expdt(rs.getString("nonwest_expdt"));
			    obj.setNonwest_nation(rs.getString("nonwest_nation"));		
			    //Get general Info from ORA
			    objInfo = obj;
			    objAL.add(obj);
			}
			
			returnstr = "Y";			
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
			returnstr = "ORA Error : " + e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}
	}
    
    public void getGDFromDB2(String fltno, String fdate, String dpt)
    {
         String sdate ="";         
         sdate = fdate.substring(2,4)+""+fdate.substring(5,7)+""+fdate.substring(8,10);

        
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
	    		        	    
	    	sql = " select rtrim(ltrim(fltno)) fltno, rtrim(ltrim(empno)) empno, " +
	    		  " rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname, rtrim(ltrim(birth)) birth, " +
	    		  " rtrim(ltrim(nation)) nation, rtrim(ltrim(passport)) passport, rtrim(ltrim(gender)) gender, " +
	    		  " rtrim(ltrim(gdorder)) gdorder, rtrim(ltrim(occu)) occu, rtrim(ltrim(meal)) meal, " +
	    		  " rtrim(ltrim(dh)) dh, rtrim(ltrim(depart)) depart, rtrim(ltrim(dest)) dest, " +
	    		  " rtrim(ltrim(passexp)) passexp, rtrim(ltrim(fdate)) fdate " +
	    		  " from CAL.DFTAPIS where (fltno = '"+fltno+"' or fltno = '0"+fltno+"') " +
	    		  " and (rtrim(ltrim(occu)) = 'FE' or rtrim(ltrim(occu)) = 'OE' or rtrim(ltrim(occu)) = 'PO' " +
	    		  " or rtrim(ltrim(occu)) = 'LD' or rtrim(ltrim(occu)) = 'EM') " +
	    		  " and rtrim(ltrim(fdate)) = '"+sdate+"' and rtrim(ltrim(depart)) = '"+dpt+"' " ;	    	
	    	
//System.out.println(sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    WebGdObj obj = new WebGdObj();
			    obj.setEmpno(rs.getString("empno"));
			    obj.setRank(rs.getString("occu"));
			    obj.setFltno(rs.getString("fltno"));
			    obj.setFdd("");
			    obj.setArv(rs.getString("dest"));
			    obj.setDpt(rs.getString("depart"));
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
	    	
	    	returnstr = "Y";
        }
		catch (Exception e)
		{
		    System.out.println("DB2 Error : "+e.toString());
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
    	objAL = sortAL(objAL);
        return objAL;
    }
    
    public WebGdObj getObjInfo()
    {
        return objInfo;
    }
    
    public String getStr()
    {
        return returnstr;
    }
    
    public String getSql()
    {
        return sql;
    }
    
    
    public void tool_AL_print(ArrayList al)
    {
        for(int i =0; i < al.size(); i++)
        {
            WebGdObj obj= (WebGdObj) al.get(i);
            System.out.println(obj.getEmpno());
        }
      
    }
}
