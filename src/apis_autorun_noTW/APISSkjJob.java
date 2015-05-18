package apis_autorun;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;
/**
 * @author cs71 Created on  2006/8/31
 */
public class APISSkjJob
{   
    ArrayList apisfltAL = new ArrayList();
    ArrayList objAL = new ArrayList();
    String returnstr = "";
    String errorstr = "";
    String sql =  "";    
    
    public static void main(String[] args)
    {
        System.out.println("Start");
        String tday = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String path = "C:///APIS/";
        String filename = "apislog_"+tday+".txt";		    
    	FileWriter fwlog = null;
        
        try
        {
	        APISSkjJob c = new APISSkjJob();
	        c.getAPISFlt();
	        ArrayList apisfltAL = new ArrayList();
	        apisfltAL = c.getAPISFltAL();
	        //get Country
	        PortCity pc = new PortCity();
	        pc.getPortCityData();
	        
	        if(apisfltAL.size()>0)
	        {
		        for(int i=0; i<apisfltAL.size(); i++)
		        {
		            APISObj obj = (APISObj) apisfltAL.get(i);
		            ArrayList apisdetailAL = new ArrayList();
		            Hashtable myHT  = new Hashtable();
		            Hashtable myHT2  = new Hashtable();
		            c.getAPISFltDetail_Aircrews(obj.getStdtpe(),obj.getFltno(),obj.getDpt(),obj.getArv());
		            c.getAPISFltDetail_DB2(obj.getFdate(),obj.getFltno(),obj.getDpt(),obj.getArv(),obj.getStr_port_local(),obj.getEnd_port_local(),obj.getStdtpe(),obj.getFly_status());
		            apisdetailAL = c.getObjAL();
		            
		            if(apisdetailAL.size()>0)
		            {
//			            //get apis un/edifact txt, send apis
		                PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
		   	         	PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
		   	         	
			   	         if("UK".equals(portobj1.getCtry()))
				         {
			   	             myHT = c.getUKDptAPISTxtHT(obj,apisdetailAL);
				         }
			   	         else if("NEW ZEALAND".equals(portobj1.getCtry()))
				         {
			   	             myHT = c.getNZDptAPISTxtHT(obj,apisdetailAL);
				         }
			   	         else if("CHINA".equals(portobj1.getCtry()))
				         {
			   	             myHT = c.getCNDptAPISTxtHT(obj,apisdetailAL);
				         }
			   	         else if("TAIWAN".equals(portobj1.getCtry()))
				         {
			   	             myHT = c.getTWDptAPISTxtHT(obj,apisdetailAL);
				         }
			   	         else
			   	         {
			   	             myHT = c.getDptAPISTxtHT(obj,apisdetailAL);
			   	         }
			   	         
			   	         if("UK".equals(portobj2.getCtry()))
				         {
			   	             myHT2 = c.getUKArvAPISTxtHT(obj,apisdetailAL); 
				         }
			   	         else if("NEW ZEALAND".equals(portobj2.getCtry()))
				         {
			   	             myHT2 = c.getNZArvAPISTxtHT(obj,apisdetailAL); 
				         }	
			   	         else if("CHINA".equals(portobj2.getCtry()))
				         {
			   	             myHT2 = c.getCNArvAPISTxtHT(obj,apisdetailAL); 
				         }
			   	         else if("TAIWAN".equals(portobj2.getCtry()))
				         {
			   	             myHT2 = c.getTWArvAPISTxtHT(obj,apisdetailAL); 
				         }
			   	         else
			   	         {
			   	             myHT2 = c.getArvAPISTxtHT(obj,apisdetailAL); 
			   	         }		
			            
			            if(myHT.size()>0)
			            {
			                //System.out.println("myHT.size "+ myHT.size());
			                Set keyset = myHT.keySet();
					        Iterator itr = keyset.iterator();
					        int idx = 0;
					        while(itr.hasNext())
					    	{
					            idx++;
					    	    String key = String.valueOf(itr.next());
					    	    String value = (String)myHT.get(key);	
					    	    //*************************************
					    	    //Telex path
					    	    FileWriter fw =  new FileWriter(path+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+idx+".TXT",false);
					    	    fw.write(value);
					    	    fw.flush();
							    fw.close();
							    //*************************************
					    	} 	
			            }
            
			            if(myHT2.size()>0)
			            {
					        //System.out.println("myHT2.size "+ myHT2.size());
			                Set keyset = myHT2.keySet();
					        Iterator itr = keyset.iterator();
					        int idx = 0;
					        while(itr.hasNext())
					    	{
					            idx++;
					    	    String key = String.valueOf(itr.next());
					    	    String value = (String)myHT2.get(key);
					    	    //*************************************
					    	    //Telex path
					    	    FileWriter fw =  new FileWriter(path+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_ARV"+idx+".TXT",false);
					    	    fw.write(value);
					    	    fw.flush();
							    fw.close();
							    //*************************************
					    	} 	
			            }
	            
			            if(myHT.size()>0 | myHT2.size()>0)
			            {               
			                //write fztselg
			                String sendtmst = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new java.util.Date());
						                
			                for(int d=0; d<apisdetailAL.size(); d++)
			                {	    
			                    APISObj detailobj = (APISObj) apisdetailAL.get(d);
			                    detailobj.setTmst(sendtmst);
			                    c.writeSentLog(detailobj,"640790","MANU");
			                }
			            }
		            }//if(apisdetailAL.size()>0)
		           
		        }// for(int i=0; i<apisfltAL.size(); i++)
	        }
	        else
	        {
	            
	        }
	    }
	    catch (Exception e)
		{
		    System.out.println(e.toString());
			
		}
        System.out.println("Done");
    }
    
    //Schedule routine job to get Flt
    public String getAPISFlt()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

	    	sql = " SELECT flt_num fltno,  fdate,  dpt, arv, carrier, " +
	    		  " to_char(str_port_local,'yyyy/mm/dd hh24:mi') str_port_local , " +
	    		  " to_char(end_port_local,'yyyy/mm/dd hh24:mi') end_port_local , " +
	    		  " to_char(stdtpe,'yyyy/mm/dd hh24:mi') stdtpe , " +
	    		  " CASE WHEN stdtpe > SYSDATE THEN 'BEF' ELSE 'AFT' end fly_status " +
	    		  " FROM fzdb.fzvac_soflcrew6d, fztcity  " +
//	    		  " WHERE stdtpe BETWEEN SYSDATE-(0.5/24) AND  SYSDATE+(0.5/24) " +
	    		  " WHERE stdtpe BETWEEN SYSDATE-(0.5/24) AND  SYSDATE+(1.55/24) " +//93分鐘=78+15
//	    		  " WHERE stdtpe BETWEEN SYSDATE-1 AND  SYSDATE+1 " +
	    		  " AND  (dpt=scity OR arv = scity) " +
//	    		  " and flt_num in ('5382')" +
//	    		  " AND ctry IN ('USA','CHINA','CANADA','JAPAN','KOREA','INDIA','UK') " +
	    		  " AND ctry IN ('USA','CHINA','CANADA','JAPAN','KOREA','INDIA','NEW ZEALAND') " +
	    		  " GROUP BY  flt_num, fdate, dpt,arv, carrier, str_port_local, end_port_local, stdtpe,  " +
	    		  " CASE WHEN stdtpe > SYSDATE THEN 'BEF' ELSE 'AFT' end ORDER BY  stdtpe "; 
//System.out.println("apis flt = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    APISObj obj = new APISObj();	    	   
	    	    obj.setFltno(rs.getString("fltno"));
	    	    obj.setFdate(rs.getString("fdate"));
	    	    obj.setDpt(rs.getString("dpt"));
	    	    obj.setArv(rs.getString("arv"));
	    	    obj.setCarrier(rs.getString("carrier"));
	    	    obj.setStr_port_local(rs.getString("str_port_local"));
	    	    obj.setEnd_port_local(rs.getString("end_port_local"));
	    	    obj.setStdtpe(rs.getString("stdtpe"));
	    	    obj.setFly_status(rs.getString("fly_status").trim());
	    	    //**********************************************
	    	    //Get DA13 data	    	    
	    	    //obj.setDa13AL(getAPISFltDetail_DA13(obj.getFltno(),obj.getStdtpe()));	
	    	    //AirCrews.str_dt_tm_loc mapping Airops.da13_etdl  modified in 2010/12/13 
	    	    obj.setDa13AL(getAPISFltDetail_DA13(obj.getFltno(),obj.getStr_port_local()));	
	    	    //**********************************************
	    	    apisfltAL.add(obj);	    	    
	    	}
	    	returnstr = "Y";
       }
		catch (Exception e)
		{
		    System.out.println(e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}    
		return returnstr;
   }    
     
    //stdtpe = fdatetime 2010/05/13 01:01
     public void getAPISFltDetail_Aircrews(String fdatetime, String fltno, String dpt, String arv)
     {   
         Statement stmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         objAL.clear();
         
        try
        {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
//	        cn.setORT1FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

	    	sql = " SELECT staff_num empno,  carrier,  flt_num fltno,  fdate,  lname, nvl(fname,' ') fname, nation, birth, passport, passport2, " +
	    		  " gender,  dpt, arv, occu, to_char(str_port_local,'yyyy/mm/dd hh24:mi') str_port_local , " +
	    		  " to_char(end_port_local,'yyyy/mm/dd hh24:mi') end_port_local , " +
	    		  " to_char(stdtpe,'yyyy/mm/dd hh24:mi') stdtpe, resicountry, birthcountry, " +
	    		  " nvl(birthcity,' ') birthcity, tvlstatus, passcountry, passcountry2, passexp, passexp2, Nvl(certno,'') certno, Nvl(certctry,'') certctry, " +
	    		  " Nvl(certtype,'') certtype, Nvl(certexp,'') certexp, " +
	    		  " CASE WHEN stdtpe > SYSDATE THEN 'BEF' ELSE 'AFT' end fly_status, " +
	    		  " trim(resiaddr1) resiaddr1, trim(resiaddr2) resiaddr2, " +
	    		  " trim(resiaddr3) resiaddr3, trim(resiaddr4) resiaddr4, trim(resiaddr5) resiaddr5 " +
	    		  " FROM fzdb.fzvac_soflcrew6d " +
	    		  " WHERE stdtpe = To_Date('"+fdatetime+"','yyyy/mm/dd hh24:mi') " +
	    		  " AND flt_num ='"+fltno+"' AND dpt = '"+dpt+"' AND arv = '"+arv+"' ORDER BY  stdtpe ";

//System.out.println("aircrews sql = "+ sql);	    	
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
	    	    obj.setDpt(rs.getString("dpt"));
	    	    obj.setArv(rs.getString("arv"));
	    	    obj.setNation(rs.getString("nation"));
	    	    obj.setBirth(rs.getString("birth"));
	    	    obj.setPassport(rs.getString("passport"));
	    	    obj.setPassport2(rs.getString("passport2"));
	    	    obj.setGender(rs.getString("gender"));
	    	    obj.setOccu(rs.getString("occu"));
	    	    obj.setStr_port_local(rs.getString("str_port_local"));
	    	    obj.setEnd_port_local(rs.getString("end_port_local"));
	    	    obj.setStdtpe(rs.getString("stdtpe"));
	    	    obj.setResicountry(rs.getString("resicountry"));
	    	    obj.setBirthcountry(rs.getString("birthcountry"));
	    	    obj.setBirthcity(rs.getString("birthcity"));
	    	    obj.setTvlstatus(rs.getString("tvlstatus"));
	    	    obj.setPasscountry(rs.getString("passcountry"));
	    	    obj.setPasscountry2(rs.getString("passcountry2"));
	    	    obj.setPassexp(rs.getString("passexp"));
	    	    obj.setPassexp2(rs.getString("passexp2"));
	    	    obj.setCertno(rs.getString("certno"));
	    	    obj.setCertctry(rs.getString("certctry"));
	    	    obj.setCerttype(rs.getString("certtype"));
	    	    obj.setCertexp(rs.getString("certexp"));	    
	    	    obj.setFly_status(rs.getString("fly_status").trim());
	    	    obj.setResiaddr1(rs.getString("resiaddr1"));
	    	    obj.setResiaddr2(rs.getString("resiaddr2"));
	    	    obj.setResiaddr3(rs.getString("resiaddr3"));
	    	    obj.setResiaddr4(rs.getString("resiaddr4"));
	    	    obj.setResiaddr5(rs.getString("resiaddr5"));
	    	    objAL.add(obj);	    	    
	    	}
	    	returnstr = "Y";
        }
		catch (Exception e)
		{
		    System.out.println(e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}    
    }
     
     //stdtpe = fdatetime 2010/05/13 01:01
     //fdate formate : yymmdd
     public void getAPISFltDetail_DB2(String fdate, String fltno, String dpt, String arv, String str_port_local, String end_port_local, String stdtpe, String fly_status)
     {   
         Statement stmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         
        try
        {
	    	//set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setDB2PUser();
//	        cn.setDB2TUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();

	    	sql = " SELECT rtrim(ltrim(carrier)) carrier,  rtrim(ltrim(fltno)) fltno, " +
		  		  " substr(rtrim(ltrim(fdate)),3) fdate,  rtrim(ltrim(lname)) lname, rtrim(ltrim(fname)) fname, " +
		  		  " rtrim(ltrim(nation)) nation, substr(rtrim(ltrim(birth)),3) birth, rtrim(ltrim(passport)) passport, rtrim(ltrim(document2)) passport2," +
		  		  " rtrim(ltrim(gender)) gender, rtrim(ltrim(depart)) dpt, rtrim(ltrim(dest)) arv, " +
		  		  " rtrim(ltrim(resicountry)) resicountry, rtrim(ltrim(birthcountry)) birthcountry, " +
		  		  " rtrim(ltrim(birthcity)) birthcity, rtrim(ltrim(tvlstatus)) tvlstatus, " +
		  		  " substr(rtrim(ltrim(passexp)),3) passexp, substr(rtrim(ltrim(docexp2)),3) passexp2, rtrim(ltrim(issue)) passcountry, rtrim(ltrim(dociss2)) passcountry2, " +
		  		  " rtrim(ltrim(document2)) certno, rtrim(ltrim(dociss2)) certctry, " +
		  		  " rtrim(ltrim(doctype2)) certtype, rtrim(ltrim(docexp2)) certexp, " +
		  		  " rtrim(ltrim(resiaddr1)) resiaddr1, rtrim(ltrim(resiaddr2)) resiaddr2, " +
		  		  " rtrim(ltrim(resiaddr3)) resiaddr3, rtrim(ltrim(resiaddr4)) resiaddr4, rtrim(ltrim(resiaddr5)) resiaddr5 " +
		  		  " FROM cal.dctapid " +
	    		  " WHERE fdate = '20"+fdate+"' " +
	    		  " AND fltno ='"+fltno+"' AND depart = '"+dpt+"' AND dest = '"+arv+"' ORDER BY  fdate ";

//System.out.println(" DB2 sql = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    APISObj obj = new APISObj();
	    	    obj.setCarrier(rs.getString("carrier"));
	    	    obj.setFltno(rs.getString("fltno"));
	    	    obj.setFdate(rs.getString("fdate"));
//	    	    obj.setEmpno(rs.getString("empno"));
	    	    obj.setLname(rs.getString("lname"));
	    	    obj.setFname(rs.getString("fname"));
	    	    obj.setDpt(rs.getString("dpt"));
	    	    obj.setArv(rs.getString("arv"));
	    	    obj.setNation(rs.getString("nation"));
	    	    obj.setBirth(rs.getString("birth"));
	    	    obj.setPassport(rs.getString("passport"));
	    	    obj.setPassport2(rs.getString("passport2"));
	    	    obj.setGender(rs.getString("gender"));
	    	    obj.setOccu("CGO");	    	    
	    	    obj.setStr_port_local(str_port_local);
	    	    obj.setEnd_port_local(end_port_local);
	    	    obj.setStdtpe(stdtpe);
	    	    obj.setResicountry(rs.getString("resicountry"));
	    	    obj.setBirthcountry(rs.getString("birthcountry"));
	    	    obj.setBirthcity(rs.getString("birthcity"));
	    	    obj.setTvlstatus(rs.getString("tvlstatus"));
	    	    obj.setPasscountry(rs.getString("passcountry"));
	    	    obj.setPasscountry2(rs.getString("passcountry2"));
	    	    obj.setPassexp(rs.getString("passexp"));
	    	    obj.setPassexp2(rs.getString("passexp2"));
	    	    obj.setCertno(rs.getString("certno"));
	    	    obj.setCertctry(rs.getString("certctry"));
	    	    obj.setCerttype(rs.getString("certtype"));
	    	    obj.setCertexp(rs.getString("certexp"));	    
	    	    obj.setFly_status(fly_status);
	    	    obj.setCargo_passenger(true);
	    	    obj.setResiaddr1(rs.getString("resiaddr1"));
	    	    obj.setResiaddr2(rs.getString("resiaddr2"));
	    	    obj.setResiaddr3(rs.getString("resiaddr3"));
	    	    obj.setResiaddr4(rs.getString("resiaddr4"));
	    	    obj.setResiaddr5(rs.getString("resiaddr5"));
	    	    
	    	    objAL.add(obj);	    	    
	    	}
	    	returnstr = "Y";
	    	
	    	String db2sql = " update CAL.dctapid set dcs='Y', dtime=current timestamp " +
	    		  " where fdate = '20"+fdate+"' AND fltno ='"+fltno+"' AND depart = '"+dpt+"' " +
	    		  " AND dest = '"+arv+"'";
	    	stmt.executeUpdate(db2sql);
//	    	int upd_cnt = stmt.executeUpdate(db2sql);
//	    	System.out.println(upd_cnt);
        }
		catch (Exception e)
		{
		    System.out.println(e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}    
    }
     
     //stdtpe = fdatetime 2010/05/13 01:01
     //public ArrayList getAPISFltDetail_DA13(String fltno, String stdtpe)
     //str_port_local = fdatetime 2010/05/13 01:01
     public ArrayList getAPISFltDetail_DA13(String fltno, String str_port_local)
     {   
         Statement stmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         ArrayList da13AL = new ArrayList();
        try
        {
//          set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

//	    	sql = " select da13_acno, da13_leg_seq_nr, da13_fltno, da13_op_suffix, da13_fm_sector, da13_to_sector, da13_actp, " +
//	    		  " NVL(to_char(da13_atdl,'yyyy/mm/dd hh24:mi'), to_char(da13_etdl,'yyyy/mm/dd hh24:mi')) da13_atdl, " +
//	    		  " NVL(to_char(da13_atal,'yyyy/mm/dd hh24:mi'), to_char(da13_etal,'yyyy/mm/dd hh24:mi')) da13_atal " +
//	    		  " from v_ittda13_ci " +
//	    		  " where da13_cond NOT IN ('CF','DL','OF') " +
//	    		  " and LPAD(da13_fltno||trim(da13_op_suffix),5,'0')= LPad('"+fltno+"',5,'0') " +
//	    		  " and da13_scdate_u in ( select da13_scdate_u " +
//	    		  " from v_ittda13_ci " +
//	    		  " where LPAD(da13_fltno||trim(da13_op_suffix),5,'0')=LPad('"+fltno+"',5,'0') " +
//	    		  " and da13_stdu+8/24 =to_date('"+stdtpe+"','yyyy/mm/dd hh24:mi') ) " +
//	    		  " order by da13_leg_seq_nr asc";
	    	
	    	sql = " select da13_acno, da13_leg_seq_nr, da13_fltno, da13_op_suffix, da13_fm_sector, da13_to_sector, da13_actp, " +
		  		  " to_char(da13_etdl,'yyyy/mm/dd hh24:mi') da13_etdl, " +
		  		  " to_char(da13_etal,'yyyy/mm/dd hh24:mi') da13_etal " +
		  		  " from v_ittda13_ci " +
		  		  " where da13_cond NOT IN ('CF','DL','OF') " +
		  		  " and LPAD(da13_fltno||trim(da13_op_suffix),5,'0')= LPad('"+fltno+"',5,'0') " +
		  		  " and da13_scdate_u in ( select da13_scdate_u " +
		  		  " from v_ittda13_ci " +
		  		  " where DA13_SCDATE_U between to_date('"+str_port_local+"','yyyy/mm/dd hh24:mi') -30 AND  to_date('"+str_port_local+"','yyyy/mm/dd hh24:mi') +5 " +
		  		  " and LPAD(da13_fltno||trim(da13_op_suffix),5,'0')=LPad('"+fltno+"',5,'0') " +
		  		  " and da13_etdl = to_date('"+str_port_local+"','yyyy/mm/dd hh24:mi') ) " +
		  		  " order by da13_leg_seq_nr asc";

//System.out.println("DA13 sql =  "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    DA13Obj obj = new DA13Obj();
	    	    obj.setDa13_acno(rs.getString("da13_acno"));
	    	    obj.setDa13_leg_seq_nr(rs.getString("da13_leg_seq_nr"));
	    	    obj.setDa13_fltno(rs.getString("da13_fltno"));
	    	    obj.setDa13_op_suffix(rs.getString("da13_op_suffix"));
	    	    obj.setDa13_fm_sector(rs.getString("da13_fm_sector"));
	    	    obj.setDa13_to_sector(rs.getString("da13_to_sector"));	    	    
	    	    obj.setDa13_fltno(rs.getString("da13_fltno"));
	    	    obj.setDa13_atdl(rs.getString("da13_etdl"));
	    	    obj.setDa13_atal(rs.getString("da13_etal"));
	    	    obj.setDa13_actp(rs.getString("da13_actp"));
	    	    da13AL.add(obj);	    	    
	    	}	    	
        }
		catch (Exception e)
		{
		    System.out.println("error 2 "+e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		}    
		return da13AL;
    }
     
     //record sent log
     //snedtype AUTO/MANU
     //userid SYSTEM/empno
     public void writeSentLog(APISObj logobj,String userid, String sendtype)
     {   
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         
        try
        {
//          set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
//	        cn.setORT1FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());	
	    	
	    	sql = " insert into fztselg (stdtpe,fdate,carrier,fltno,dpt,arv,empno,lname,fname, birth," +
	    		  " occu,newuser,tmst,sendtype) values (to_date(?,'yyyy/mm/dd hh24:mi'),?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy/mm/dd hh24:mi:ss'),?)";
	    	
//System.out.println(sql);	    	
			pstmt = conn.prepareStatement(sql);			
			int j=1;
		    pstmt.setString(j, logobj.getStdtpe());
			pstmt.setString(++j, logobj.getFdate());
			pstmt.setString(++j, logobj.getCarrier());
			pstmt.setString(++j, logobj.getFltno());
			pstmt.setString(++j, logobj.getDpt());
			pstmt.setString(++j, logobj.getArv());				
			pstmt.setString(++j, logobj.getEmpno());
			pstmt.setString(++j, logobj.getLname());
			pstmt.setString(++j, logobj.getFname());
			pstmt.setString(++j, logobj.getBirth());
			pstmt.setString(++j, logobj.getOccu());	
			pstmt.setString(++j, userid);
			pstmt.setString(++j, logobj.getTmst());	
			pstmt.setString(++j, sendtype);   
			//System.out.println("insert into fztselg (stdtpe,fdate,carrier,fltno,dpt,arv,empno,lname,fname, birth,occu,newuser,tmst,sendtype) values (to_date("+logobj.getStdtpe()+",'yyyy/mm/dd hh24:mi'),'"+logobj.getFdate()+"','"+logobj.getCarrier()+"','"+logobj.getFltno()+"','"+logobj.getDpt()+"','"+logobj.getArv()+"','"+logobj.getEmpno()+"','"+logobj.getLname()+"','"+logobj.getFname()+"','"+logobj.getBirth()+"','"+logobj.getOccu()+"','"+userid+"',to_date('"+logobj.getTmst()+"','yyyy/mm/dd hh24:mi:ss'),'"+sendtype+"')");
  	
			pstmt.executeUpdate();
        }
		catch (Exception e)
		{
//		    System.out.println(logobj.getStdtpe()+" * "+logobj.getFdate()+" * "+logobj.getCarrier()+" * "+logobj.getFltno()+" * "+logobj.getDpt()+" * "+logobj.getArv()+" * "+logobj.getFname()+" * "+logobj.getLname());
		    System.out.println(" error 1 "+e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		} 
    }
     
     //record check log
     public void writeCheckLog(APISObj logobj)
     {   
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         
        try
        {
//          set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
//	        cn.setORT1FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());

	    	sql = " insert into fztcklg (stdtpe,fdate,carrier,fltno,dpt,arv,tmst,msg) values (to_date(?,'yyyy/mm/dd hh24:mi'),?,?,?,?,?,sysdate,?)";
//	    	System.out.println(logobj.getStdtpe()+" * "+logobj.getFdate()+" * "+logobj.getCarrier()+" * "+logobj.getFltno()+" * "+logobj.getDpt()+" * "+logobj.getArv()+" * "+logobj.getMsgSB().toString()+" * ");
//System.out.println(sql);	    	
			pstmt = conn.prepareStatement(sql);			
			int j=1;
		    pstmt.setString(j, logobj.getStdtpe());
			pstmt.setString(++j, logobj.getFdate());
			pstmt.setString(++j, logobj.getCarrier());
			pstmt.setString(++j, logobj.getFltno());
			pstmt.setString(++j, logobj.getDpt());
			pstmt.setString(++j, logobj.getArv());
			pstmt.setString(++j, logobj.getMsgSB().toString());
			 
			pstmt.executeUpdate();
        }
		catch (Exception e)
		{
		    System.out.println(e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		} 
    }
     
     public int checkIfSent(ArrayList apisdetailAL)
     {   
         Statement stmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         int sent_cnt = 0;
         
        try
        {
//          set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
//	        cn.setORT1FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement(); 
	    	
	    	APISObj obj = (APISObj) apisdetailAL.get(0);
	    	//System.out.println(obj.getStdtpe()+"  **  "+obj.getFltno()+"  **  "+obj.getDpt()+"  **  "+obj.getFly_status()+"\r\n");

	    	if("BEF".equals(obj.getFly_status()))
	    	{
	    	    sql = " SELECT count(*) c FROM fztselg WHERE stdtpe = To_Date('"+obj.getStdtpe()+"','yyyy/mm/dd hh24:mi') " +
	    	    	  " AND fltno ='"+obj.getFltno()+"' AND dpt = '"+obj.getDpt()+"' AND newuser = 'SYSTEM' " +
	    	    	  " AND sendtype = 'AUTO' AND stdtpe >= tmst ";
	    	}
	    	else //if("AFT".equals(obj.getFly_status()))
	    	{
	    	    sql = " SELECT count(*) c FROM fztselg WHERE stdtpe = To_Date('"+obj.getStdtpe()+"','yyyy/mm/dd hh24:mi') " +
		  	    	  " AND fltno ='"+obj.getFltno()+"' AND dpt = '"+obj.getDpt()+"' AND newuser = 'SYSTEM' " +
		  	    	  " AND sendtype = 'AUTO' AND stdtpe < tmst "; 	    
	    	}
	    	
//	    	System.out.println(sql);	    	
  			rs = stmt.executeQuery(sql);
		  	if (rs.next())
		  	{
		  	    sent_cnt = rs.getInt("c");	    
		  	}	    	
        }
		catch (Exception e)
		{
		    System.out.println(e.toString());
			returnstr = e.toString();
			sent_cnt = -1;
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		} 
		return sent_cnt;
    }
     
     public Hashtable checkUnMatch(ArrayList apisdetailAL)
     {   
         Statement stmt = null;
         ResultSet rs = null;
         Connection conn = null;
         Driver dbDriver = null;
         int sent_cnt = 0;
         Hashtable myHT = new Hashtable(); 
         
        try
        {
//          set connect to DB2
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
//	        cn.setORT1FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement(); 
	    	
	    	for(int i =0; i<apisdetailAL.size(); i++)
	    	{
	    	    APISObj obj = (APISObj) apisdetailAL.get(i);
	    	    if("CGO".equals(obj.getOccu()))
	    	    {//CGO has no empno, lname||fname for instead
	    	        myHT.put(obj.getLname()+obj.getFname(),obj);  
	    	    }
	    	    else
	    	    {
	    	        myHT.put(obj.getEmpno(),obj);    
	    	    }
	    	}  	
	    	
	    	APISObj tobj = (APISObj) apisdetailAL.get(0);
//    	    sql = " SELECT * FROM fztselg WHERE stdtpe = To_Date('"+tobj.getStdtpe()+"','yyyy/mm/dd hh24:mi') " +
//    	    	  " AND fltno ='"+tobj.getFltno()+"' AND dpt = '"+tobj.getDpt()+"' and empno is not null " +
//    	    	  " and tmst = (select max(tmst) from fztselg WHERE stdtpe = To_Date('"+tobj.getStdtpe()+"','yyyy/mm/dd hh24:mi') " +
//    	    	  " AND fltno ='"+tobj.getFltno()+"' AND dpt = '"+tobj.getDpt()+"') ";	    
    	    
    	    sql = " SELECT * FROM fztselg WHERE stdtpe = To_Date('"+tobj.getStdtpe()+"','yyyy/mm/dd hh24:mi') " +
		    	  " AND fltno ='"+tobj.getFltno()+"' AND dpt = '"+tobj.getDpt()+"' " +
		    	  " and tmst = (select max(tmst) from fztselg WHERE stdtpe = To_Date('"+tobj.getStdtpe()+"','yyyy/mm/dd hh24:mi') " +
		    	  " AND fltno ='"+tobj.getFltno()+"' AND dpt = '"+tobj.getDpt()+"') ";	
	    	
//System.out.println("fztselg = "+sql);	    	
  			rs = stmt.executeQuery(sql);
		  	while (rs.next())
		  	{
		  	    String tempempno = rs.getString("empno");    
		  	    String tempname = rs.getString("lname")+rs.getString("fname");    
//		  	    if(myHT.get(tempempno) == null | "".equals(myHT.get(tempempno)))
//		  	    {
//		  	        //not match Sent log crew not in aircrews
//		  	        //aircrews 無 log 有 
//		  	        APISObj nobj = new APISObj();
//		  	        nobj.setEmpno(tempempno);
//		  	        nobj.setOccu(rs.getString("occu"));
//		  	        nobj.setArv(rs.getString("arv"));		
//		  	        nobj.setDpt(rs.getString("dpt"));
//		  	        nobj.setCarrier(rs.getString("carrier"));
//		  	        nobj.setEnd_port_local(tobj.getEnd_port_local());
//		  	        nobj.setFdate(tobj.getFdate());
//		  	        nobj.setFltno(tobj.getFltno());
//		  	        nobj.setStdtpe(tobj.getStdtpe());
//		  	        nobj.setStr_port_local(tobj.getStr_port_local());
//		  	        nobj.setRemark("A");		  	        
//		  	        myHT.put(tempempno,nobj);		  	        
//		  	    }
//		  	    else
//		  	    {
//		  	        //match
//		  	        APISObj nobj = (APISObj) myHT.get(tempempno);
//		  	        nobj.setRemark("Y");
//		  	        myHT.put(tempempno,nobj);
//		  	    }
		  	    //****************************************************************
		  	    if( (myHT.get(tempempno) == null | "".equals(myHT.get(tempempno))) && (myHT.get(tempname) == null | "".equals(myHT.get(tempname))))
		  	    {
		  	        //not match Sent log crew not in aircrews and DB2
		  	        //aircrews 無 log 有 
		  	        APISObj nobj = new APISObj();
		  	        nobj.setEmpno(tempempno);
		  	        nobj.setOccu(rs.getString("occu"));
		  	        nobj.setArv(rs.getString("arv"));		
		  	        nobj.setDpt(rs.getString("dpt"));
		  	        nobj.setCarrier(rs.getString("carrier"));
		  	        nobj.setEnd_port_local(tobj.getEnd_port_local());
		  	        nobj.setFdate(tobj.getFdate());
		  	        nobj.setFltno(tobj.getFltno());
		  	        nobj.setStdtpe(tobj.getStdtpe());
		  	        nobj.setStr_port_local(tobj.getStr_port_local());
		  	        nobj.setRemark("A");		  	        
		  	        myHT.put(tempempno,nobj);		  	        
		  	    }
		  	    else
		  	    {
		  	        //match
		  	        if("CGO".equals(rs.getString("occu")))
		  	        {
		  	            APISObj nobj = (APISObj) myHT.get(tempname);
			  	        nobj.setRemark("Y");
			  	        myHT.put(tempname,nobj);		  	            
		  	        }
		  	        else
		  	        {
			  	        APISObj nobj = (APISObj) myHT.get(tempempno);
			  	        nobj.setRemark("Y");
			  	        myHT.put(tempempno,nobj);
		  	        }
		  	    }
		  	}	    	
        }
		catch (Exception e)
		{
		    System.out.println(e.toString());
			returnstr = e.toString();
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
		} 
		return myHT;
    }
     
     public Hashtable getDptAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (outbound)   
//         System.out.println("apisdetailAL.size() = "+apisdetailAL.size());
         errorstr = "";
         Hashtable txtHT = new Hashtable();      

		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {  
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
			 main_ctry = portobj1.getCtry();
	         
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //大陸:BJSHGCA(海關)、PEKKN1E(邊防)  CHINA
			 //印尼:CGKBCXH  INDONESIA
			 //美國：DCAUCCR USA
			 //加拿大：YOWAAXH CANADA
			 //韓國：SELTSXA  KOREA
			 //印度：FABINXS  INDIA         
	         
	         //Departure
//	         if("CHINA".equals(portobj1.getCtry()))
//	         {
//	             qd_str = " BJSHGCA PEKKN1E TPEWGCI";
//	             ischina = true;
//	         }
//	         else if("INDONESIA".equals(portobj1.getCtry()))
//	         {
//	             qd_str = " CGKBCXH TPEWGCI";
//	         }
	         if("USA".equals(portobj1.getCtry()))
	         {
	             qd_str = " DCAUCCR TPEWGCI";
	         }
	         else if("CANADA".equals(portobj1.getCtry()))
	         {
	             qd_str = " YOWAAXH TPEWGCI";
	         }         
	         else if("KOREA".equals(portobj1.getCtry()))
	         {
	             qd_str = " SELTSXA TPEWGCI";
	         }
	         else if("INDIA".equals(portobj1.getCtry()))
	         {
	             qd_str = " FABINXS TPEWGCI";
	         }      
	        
	         //****************************************************************
	         //判斷是否為美國內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************
	//         //判斷是否為入境
	//         DA13Obj isemboardobj = (DA13Obj) da13objAL.get(0);
	//         if("TPE".equals(isemboardobj.getDa13_fm_sector()) | "KHH".equals(isemboardobj.getDa13_fm_sector()) | "TSA".equals(isemboardobj.getDa13_fm_sector()))
	//         {
	//             isemboard = true;
	//         }
	         
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(da13objAL.size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             		                        
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:(.? )"+"");

			             txtSB.append("UNB(UNOA:4(TPETTCI:"+obj.getCarrier()+"(USCSAPIS:ZZ("+time1+"("+time2+"((APIS)"+"");
			             txtSB.append("UNG(PAXLST(CHINA? AIRLINES:"+obj.getCarrier()+"(USCSAPIS:ZZ("+time1+"("+time2+"(UN(D:02B)"+"");
				         txtSB.append("UNH(PAX001(PAXLST:D:02B:UN:IATA("+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"("+page_str+")"+"");

				         
				         txtSB.append("BGM(250("+bgm_str+")"+"");
				         txtSB.append("NAD(MS(((ATTN? "+obj.getDpt()+"KK"+obj.getCarrier()+")"+"");
				         txtSB.append("COM(011-8863-398-3989:TE(011-8863-399-8194:FX)"+"");
				         txtSB.append("TDT(20("+obj.getCarrier()+tempfltno+")"+"");
				         line_cnt =5;         
				         
				         if(da13objAL.size()>0)
				         {
				             boolean gotDR = false;
				             for(int d=0; d<da13objAL.size(); d++)
				             {
				                 //set R D A
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && dpt.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 //若為入境航班,最後一個非主體國dpt站  XXXX->main_ctry
				                 //若為出境航班,最後一個主體國dpt站	
				                 if(da13objAL.size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }			
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj3.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }
				                 }
				             }
		             
				             if(gotDR == false)
		                     {//like TPE--ANC--JFK
		                         for(int d=obj.getDa13AL().size()-1; d>=0; d--)
		                         {
		                             DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
		                             PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
					                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }				                 
					             }
		                     }
				             //******************************************************************************************
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {			                     
				                     if(getDA == false)
				                     {
					                     txtSB.append("LOC(92("+da13obj.getDa13_fm_sector()+")"+"");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC(92("+da13obj.getDa13_to_sector()+")"+"");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }			                   
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC(125("+da13obj.getDa13_fm_sector()+")"+"");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC(87("+da13obj.getDa13_to_sector()+")"+"");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }			                    
				                     getDA = true;			                     
				                 }			                 
				             }
				         }//if(obj.getDa13AL().size()>0)				         
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
//				             if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5

				             txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
				             //不送address
//			             	if(apisdetailobj.getResiaddr3()==null | "".equals(apisdetailobj.getResiaddr3()))
//			             	{
//			             	   txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+"("+apisdetailobj.getResiaddr1().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr2().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"(("+apisdetailobj.getResiaddr4().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[.]","?.").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr5().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
//			             	}
//			             	else
//			             	{
//			                   txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+"("+apisdetailobj.getResiaddr1().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr2().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr3().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[.]","?.").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr4().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr5().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
//			             	}
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
//				             }
					         txtSB.append("ATT(2(("+apisdetailobj.getGender()+")"+"");
					         txtSB.append("DTM(329:"+apisdetailobj.getBirth()+")"+"");
					         txtSB.append("LOC(22("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(174("+apisdetailobj.getResicountry()+")"+"");
					         txtSB.append("LOC(178("+apisdetailobj.getDpt()+")"+"");
					         txtSB.append("LOC(179("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(180("+apisdetailobj.getBirthcountry()+"(:::"+apisdetailobj.getBirthcity().trim().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
					         txtSB.append("EMP(1("+apisdetailobj.getTvlstatus()+":110:111)"+"");
					         txtSB.append("NAT(2("+apisdetailobj.getPasscountry()+")"+"");
					         txtSB.append("RFF(AVF:CCRR11)"+"");
					         txtSB.append("DOC(P:110:111("+apisdetailobj.getPassport().replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
					         txtSB.append("DTM(36:"+apisdetailobj.getPassexp()+")"+"");
					         txtSB.append("LOC(91("+apisdetailobj.getPasscountry()+")"+"");
					         line_cnt = line_cnt +14;
					         if(apisdetailobj.getCertno() != null && !"".equals(apisdetailobj.getCertno()))
					         {
						         txtSB.append("DOC("+apisdetailobj.getCerttype()+":110:111("+apisdetailobj.getCertno()+")"+"");
						         txtSB.append("DTM(36:"+apisdetailobj.getCertexp()+")"+"");
						         txtSB.append("LOC(91("+apisdetailobj.getCertctry()+")"+"");
						         line_cnt = line_cnt +3;
					         }
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT(41:"+apisdetailAL.size()+")"+"");//crew count   
				         txtSB.append("UNT("+df.format((line_cnt+2))+"(PAX001)"+"");//UNH~UNT 行數
				         txtSB.append("UNE(1("+time2+")"+"");//系統時間
				         txtSB.append("UNZ(1("+time2+")"+"");//系統時間
				         
//				         System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());	
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)	         
	         }//if(!"".equals(qd_str))      
	         errorstr = "Y";
         }
         catch (Exception e)
 		{
 			System.out.println("Error ## "+e.toString()); 		
 			errorstr = "Error ## "+e.toString();
 		} 
 		finally
 		{
 		    
 		}
         
         return txtHT;         
     }
     
     public Hashtable getArvAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (inbound) 
         errorstr = "";
         Hashtable txtHT = new Hashtable();  
         String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());        
	         main_ctry = portobj2.getCtry();
	        
	      
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //大陸:BJSHGCA(海關)、PEKKN1E(邊防)  CHINA
			 //印尼:CGKBCXH  INDONESIA
			 //美國：DCAUCCR USA
			 //加拿大：YOWAAXH CANADA
			 //日本：TYONAXH  JAPAN (入境才需要/出境無需要)
			 //韓國：SELTSXA  KOREA
			 //印度：FABINXS  INDIA         
	         
	         //Arrival
//			   if("CHINA".equals(portobj2.getCtry()))
//			   {
//			       qd_str = " BJSHGCA PEKKN1E TPEWGCI";
//			       ischina = true;
//			   }
//			   else if("INDONESIA".equals(portobj2.getCtry()))
//			   {
//			       qd_str = " CGKBCXH TPEWGCI";
//			   }
			   if("USA".equals(portobj2.getCtry()))
			   {
			       qd_str = " DCAUCCR TPEWGCI";
			   }
			   else if("CANADA".equals(portobj2.getCtry()))
			   {
			       qd_str = " YOWAAXH TPEWGCI";
			   }
			   else if("JAPAN".equals(portobj2.getCtry()))
			   {
			       qd_str = " TYONAXH TPEWGCI";
			   }
			   else if("KOREA".equals(portobj2.getCtry()))
			   {
			       qd_str = " SELTSXA TPEWGCI";
			   }
			   else if("INDIA".equals(portobj2.getCtry()))
			   {
			       qd_str = " FABINXS TPEWGCI";
			   }
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************        
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
				         txtSB.append("UNA:(.? )"+"");
				         
			             txtSB.append("UNB(UNOA:4(TPETTCI:"+obj.getCarrier()+"(USCSAPIS:ZZ("+time1+"("+time2+"((APIS)"+"");
			             txtSB.append("UNG(PAXLST(CHINA? AIRLINES:"+obj.getCarrier()+"(USCSAPIS:ZZ("+time1+"("+time2+"(UN(D:02B)"+"");
				         txtSB.append("UNH(PAX001(PAXLST:D:02B:UN:IATA("+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"("+page_str+")"+"");

				         txtSB.append("BGM(250("+bgm_str+")"+"");
				         txtSB.append("NAD(MS(((ATTN? "+obj.getDpt()+"KK"+obj.getCarrier()+")"+"");
				         txtSB.append("COM(011-8863-398-3989:TE(011-8863-399-8194:FX)"+"");
				         txtSB.append("TDT(20("+obj.getCarrier()+tempfltno+")"+"");
				         line_cnt =5;         
				         
				         if(obj.getDa13AL().size()>0)
				         {
				             boolean getR = false;
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && arv.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 			        
				                 if(obj.getDa13AL().size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
				                     else if(!portobj3.getCtry().equals(portobj4.getCtry()) && getR == true && portobj3.getCtry().equals(main_ctry))
				                     {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                     getR = true;
					                 }
				                 }
				                 	                 
				             }
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {
				                     if(getDA == false)
				                     {				                     
					                     txtSB.append("LOC(92("+da13obj.getDa13_fm_sector()+")"+"");
					                     line_cnt++;
					                     
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
					                     
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC(92("+da13obj.getDa13_to_sector()+")"+"");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC(125("+da13obj.getDa13_fm_sector()+")"+"");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC(87("+da13obj.getDa13_to_sector()+")"+"");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }			           
				                     getDA = true;
				                 }
				             }
				         }//if(obj.getDa13AL().size()>0)
//				         else
//				         {
//	System.out.println("arv getDa13AL().size()<0");			             
//				         }
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
					         
//					         if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5

				             //不送address
				             txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
       
	//			             	if(apisdetailobj.getResiaddr3()==null | "".equals(apisdetailobj.getResiaddr3()))
	//			             	{
	//			             	   txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+"("+apisdetailobj.getResiaddr1().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr2().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"(("+apisdetailobj.getResiaddr4().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[.]","?.").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr5().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
	//			             	}
	//			             	else
	//			             	{
	//			                   txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+"("+apisdetailobj.getResiaddr1().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr2().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr3().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[.]","?.").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr4().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+"("+apisdetailobj.getResiaddr5().replaceAll("[?]","??").replaceAll("[.]","?.").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
	//			             	}
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
//				             }
					         txtSB.append("ATT(2(("+apisdetailobj.getGender()+")"+"");
					         txtSB.append("DTM(329:"+apisdetailobj.getBirth()+")"+"");
					         txtSB.append("LOC(22("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(174("+apisdetailobj.getResicountry()+")"+"");
					         txtSB.append("LOC(178("+apisdetailobj.getDpt()+")"+"");
					         txtSB.append("LOC(179("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(180("+apisdetailobj.getBirthcountry()+"(:::"+apisdetailobj.getBirthcity().trim().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
					         txtSB.append("EMP(1("+apisdetailobj.getTvlstatus()+":110:111)"+"");
					         txtSB.append("NAT(2("+apisdetailobj.getPasscountry()+")"+"");
					         txtSB.append("RFF(AVF:CCRR11)"+"");
					         txtSB.append("DOC(P:110:111("+apisdetailobj.getPassport().replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
					         txtSB.append("DTM(36:"+apisdetailobj.getPassexp()+")"+"");
					         txtSB.append("LOC(91("+apisdetailobj.getPasscountry()+")"+"");
					         line_cnt = line_cnt +14;
					         if(apisdetailobj.getCertno() != null && !"".equals(apisdetailobj.getCertno()))
					         {
						         txtSB.append("DOC("+apisdetailobj.getCerttype()+":110:111("+apisdetailobj.getCertno()+")"+"");
						         txtSB.append("DTM(36:"+apisdetailobj.getCertexp()+")"+"");
						         txtSB.append("LOC(91("+apisdetailobj.getCertctry()+")"+"");
						         line_cnt = line_cnt +3;
					         }
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT(41:"+apisdetailAL.size()+")"+"");//crew count  
				         txtSB.append("UNT("+df.format((line_cnt+2))+"(PAX001)"+"");//UNH~UNT 行數
				         txtSB.append("UNE(1("+time2+")"+"");//系統時間
				         txtSB.append("UNZ(1("+time2+")"+"");//系統時間
				         
	//			         System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());		
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
	         }//if(!"".equals(qd_str)) 
	         errorstr = "Y";
	     }
	     catch (Exception e)
		{
			System.out.println("Error ## "+e.toString()); 	
			errorstr = "Error ## "+e.toString();
		} 
		finally
		{
		    
		}
        return txtHT;         
     }
     
     public Hashtable getCNDptAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (outbound)   
//         System.out.println("apisdetailAL.size() = "+apisdetailAL.size());
         errorstr = "";
         Hashtable txtHT = new Hashtable();      

		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {  
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
			 main_ctry = portobj1.getCtry();
	         
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //大陸:BJSHGCA(海關)、PEKKN1E(邊防)  CHINA
			 //印尼:CGKBCXH  INDONESIA
			 //美國：DCAUCCR USA
			 //加拿大：YOWAAXH CANADA
			 //韓國：SELTSXA  KOREA
			 //印度：FABINXS  INDIA         
	         
	         //Departure
	         if("CHINA".equals(portobj1.getCtry()))
	         {
	             qd_str = " BJSHGCA PEKKN1E TPEWGCI";
	         }
	        
	         //****************************************************************
	         //判斷是否為美國內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************
	//         //判斷是否為入境
	//         DA13Obj isemboardobj = (DA13Obj) da13objAL.get(0);
	//         if("TPE".equals(isemboardobj.getDa13_fm_sector()) | "KHH".equals(isemboardobj.getDa13_fm_sector()) | "TSA".equals(isemboardobj.getDa13_fm_sector()))
	//         {
	//             isemboard = true;
	//         }
	         
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(da13objAL.size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             		                        
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:(.? )"+"");
				             
				         txtSB.append("UNB(UNOA:4(TPETTCI:ZZ(CNADAPIS:ZZ("+time1+"("+time2+"((APIS)"+"");
						 txtSB.append("UNG(PAXLST(CHINA AIRLINES:ZZ(CNADAPIS:ZZ("+time1+"("+time2+"(UN(D:02B)"+"");
				         txtSB.append("UNH(PAX001(PAXLST:D:02B:UN:IATA("+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"C("+page_str+")"+"");

				         
				         txtSB.append("BGM(250("+bgm_str+")"+"");
						 txtSB.append("NAD(MS(((ATTN "+obj.getDpt()+"KK"+obj.getCarrier()+")"+"");
				         txtSB.append("COM(011-8863-398-3989:TE(011-8863-399-8194:FX)"+"");
//				         txtSB.append("TDT(20("+obj.getCarrier()+tempfltno+"((("+obj.getCarrier()+")"+"");
				         txtSB.append("TDT(20("+obj.getCarrier()+tempfltno+")"+"");
				         line_cnt =5;         
				         
				         if(da13objAL.size()>0)
				         {
				             boolean gotDR = false;
				             for(int d=0; d<da13objAL.size(); d++)
				             {
				                 //set R D A
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && dpt.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 //若為入境航班,最後一個非主體國dpt站  XXXX->main_ctry
				                 //若為出境航班,最後一個主體國dpt站	
				                 if(da13objAL.size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }			
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj3.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }
				                 }
				             }
		             
				             if(gotDR == false)
		                     {//like TPE--ANC--JFK
		                         for(int d=obj.getDa13AL().size()-1; d>=0; d--)
		                         {
		                             DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
		                             PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
					                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }				                 
					             }
		                     }
				             //******************************************************************************************
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {			                     
				                     if(getDA == false)
				                     {
					                     txtSB.append("LOC(92("+da13obj.getDa13_fm_sector()+")"+"");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC(92("+da13obj.getDa13_to_sector()+")"+"");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }			                   
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC(125("+da13obj.getDa13_fm_sector()+")"+"");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC(87("+da13obj.getDa13_to_sector()+")"+"");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }			                    
				                     getDA = true;			                     
				                 }			                 
				             }
				         }//if(obj.getDa13AL().size()>0)
				         
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
//				             if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5

				             //txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
							 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
//				             }
					         txtSB.append("ATT(2(("+apisdetailobj.getGender()+")"+"");
					         txtSB.append("DTM(329:"+apisdetailobj.getBirth()+")"+"");
					         txtSB.append("LOC(22("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(174("+apisdetailobj.getResicountry()+")"+"");
					         txtSB.append("LOC(178("+apisdetailobj.getDpt()+")"+"");
					         txtSB.append("LOC(179("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(180("+apisdetailobj.getBirthcountry()+"(:::"+apisdetailobj.getBirthcity().trim().replaceAll("[?]","??").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
					         txtSB.append("EMP(1("+apisdetailobj.getTvlstatus()+":110:111)"+"");
					         txtSB.append("NAT(2("+apisdetailobj.getPasscountry()+")"+"");
					         txtSB.append("RFF(AVF:CCRR11)"+"");
					         txtSB.append("DOC(P:110:111("+apisdetailobj.getPassport().replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
					         txtSB.append("DTM(36:"+apisdetailobj.getPassexp()+")"+"");
					         txtSB.append("LOC(91("+apisdetailobj.getPasscountry()+")"+"");
					         line_cnt = line_cnt +14;
//					         if(apisdetailobj.getCertno() != null && !"".equals(apisdetailobj.getCertno()))
//					         {
//						         txtSB.append("DOC("+apisdetailobj.getCerttype()+":110:111("+apisdetailobj.getCertno()+")"+"");
//						         txtSB.append("DTM(36:"+apisdetailobj.getCertexp()+")"+"");
//						         txtSB.append("LOC(91("+apisdetailobj.getCertctry()+")"+"");
//						         line_cnt = line_cnt +3;
//					         }
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT(41:"+apisdetailAL.size()+")"+"");//crew count
				         txtSB.append("UNT("+(line_cnt+2)+"(PAX001)"+"");//UNH~UNT 行數
				         txtSB.append("UNE(1("+time2+")"+"");//系統時間
				         txtSB.append("UNZ(1("+time2+")"+"");//系統時間
				         
//				         System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());	
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)	         
	         }//if(!"".equals(qd_str))      
	         errorstr = "Y";
         }
         catch (Exception e)
 		{
 			System.out.println("Error ## "+e.toString()); 		
 			errorstr = "Error ## "+e.toString();
 		} 
 		finally
 		{
 		    
 		}
         
         return txtHT;         
     }
     
     public Hashtable getCNArvAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (inbound) 
         errorstr = "";
         Hashtable txtHT = new Hashtable();  
         String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());        
	         main_ctry = portobj2.getCtry();
	        
	      
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //大陸:BJSHGCA(海關)、PEKKN1E(邊防)  CHINA
			 //印尼:CGKBCXH  INDONESIA
			 //美國：DCAUCCR USA
			 //加拿大：YOWAAXH CANADA
			 //日本：TYONAXH  JAPAN (入境才需要/出境無需要)
			 //韓國：SELTSXA  KOREA
			 //印度：FABINXS  INDIA         
	         
	         //Arrival
			   if("CHINA".equals(portobj2.getCtry()))
			   {
			       qd_str = " BJSHGCA PEKKN1E TPEWGCI";
			   }
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
//	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()) | "5".equals(obj.getFltno().substring(0,1)) | "6".equals(obj.getFltno().substring(0,1)))
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************        
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
				         txtSB.append("UNA:(.? )"+"");
						 txtSB.append("UNB(UNOA:4(TPETTCI:ZZ(CNADAPIS:ZZ("+time1+"("+time2+"((APIS)"+"");
						 txtSB.append("UNG(PAXLST(CHINA AIRLINES:ZZ(CNADAPIS:ZZ("+time1+"("+time2+"(UN(D:02B)"+"");
						 txtSB.append("UNH(PAX001(PAXLST:D:02B:UN:IATA("+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"C("+page_str+")"+"");

				         txtSB.append("BGM(250("+bgm_str+")"+"");
				         txtSB.append("NAD(MS(((ATTN "+obj.getDpt()+"KK"+obj.getCarrier()+")"+"");
				         txtSB.append("COM(011-8863-398-3989:TE(011-8863-399-8194:FX)"+"");
//				         txtSB.append("TDT(20("+obj.getCarrier()+tempfltno+"((("+obj.getCarrier()+")"+"");
				         txtSB.append("TDT(20("+obj.getCarrier()+tempfltno+")"+"");
				         line_cnt =5;         
				         
				         if(obj.getDa13AL().size()>0)
				         {
				             boolean getR = false;
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && arv.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 			        
				                 if(obj.getDa13AL().size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
				                     else if(!portobj3.getCtry().equals(portobj4.getCtry()) && getR == true && portobj3.getCtry().equals(main_ctry))
				                     {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                     getR = true;
					                 }
				                 }
				                 	                 
				             }
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {
				                     if(getDA == false)
				                     {				                     
					                     txtSB.append("LOC(92("+da13obj.getDa13_fm_sector()+")"+"");
					                     line_cnt++;
					                     
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
					                     
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC(92("+da13obj.getDa13_to_sector()+")"+"");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM(189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC(125("+da13obj.getDa13_fm_sector()+")"+"");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC(87("+da13obj.getDa13_to_sector()+")"+"");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM(232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201)"+"");
				                             line_cnt++;
				                         }				                         
				                     }			           
				                     getDA = true;
				                 }
				             }
				         }//if(obj.getDa13AL().size()>0)
//				         else
//				         {
//	System.out.println("arv getDa13AL().size()<0");			             
//				         }
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
					         
//					         if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5

				             txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");

//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
//				             }
					         txtSB.append("ATT(2(("+apisdetailobj.getGender()+")"+"");
					         txtSB.append("DTM(329:"+apisdetailobj.getBirth()+")"+"");
					         txtSB.append("LOC(22("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(174("+apisdetailobj.getResicountry()+")"+"");
					         txtSB.append("LOC(178("+apisdetailobj.getDpt()+")"+"");
					         txtSB.append("LOC(179("+apisdetailobj.getArv()+")"+"");
					         txtSB.append("LOC(180("+apisdetailobj.getBirthcountry()+"(:::"+apisdetailobj.getBirthcity().trim().replaceAll("[?]","??").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"");
					         txtSB.append("EMP(1("+apisdetailobj.getTvlstatus()+":110:111)"+"");
					         txtSB.append("NAT(2("+apisdetailobj.getPasscountry()+")"+"");
					         txtSB.append("RFF(AVF:CCRR11)"+"");
					         txtSB.append("DOC(P:110:111("+apisdetailobj.getPassport().replaceAll("[(]","?(").replaceAll("[)]","?)")+")"+"");
					         txtSB.append("DTM(36:"+apisdetailobj.getPassexp()+")"+"");
					         txtSB.append("LOC(91("+apisdetailobj.getPasscountry()+")"+"");
					         line_cnt = line_cnt +14;
//					         if(apisdetailobj.getCertno() != null && !"".equals(apisdetailobj.getCertno()))
//					         {
//						         txtSB.append("DOC("+apisdetailobj.getCerttype()+":110:111("+apisdetailobj.getCertno()+")"+"");
//						         txtSB.append("DTM(36:"+apisdetailobj.getCertexp()+")"+"");
//						         txtSB.append("LOC(91("+apisdetailobj.getCertctry()+")"+"");
//						         line_cnt = line_cnt +3;
//					         }
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT(41:"+apisdetailAL.size()+")"+"");//crew count  
				         txtSB.append("UNT("+(line_cnt+2)+"(PAX001)"+"");//UNH~UNT 行數
				         txtSB.append("UNE(1("+time2+")"+"");//系統時間
				         txtSB.append("UNZ(1("+time2+")"+"");//系統時間
				         
	//			         System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());		
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
	         }//if(!"".equals(qd_str)) 
	         errorstr = "Y";
	     }
	     catch (Exception e)
		{
			System.out.println("Error ## "+e.toString()); 	
			errorstr = "Error ## "+e.toString();
		} 
		finally
		{
		    
		}
        return txtHT;         
     }
//*****************************************************************************************     
     public Hashtable getUKDptAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (outbound)   
//         System.out.println("apisdetailAL.size() = "+apisdetailAL.size());
		 errorstr = "";
         Hashtable txtHT = new Hashtable();      
		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {  
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	//     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
			 main_ctry = portobj1.getCtry();
	         
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address			 
	         //英國 :UK
	         
	         //Departure
	         if("UK".equals(portobj1.getCtry()))
	         {
	             qd_str = " LONHT7X TPEWGCI";//test
//	             qd_str = " LONHO7X TPEWGCI";//live
	         }
	        
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()) | "5".equals(obj.getFltno().substring(0,1)) | "6".equals(obj.getFltno().substring(0,1)))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************
	//         //判斷是否為入境
	//         DA13Obj isemboardobj = (DA13Obj) da13objAL.get(0);
	//         if("TPE".equals(isemboardobj.getDa13_fm_sector()) | "KHH".equals(isemboardobj.getDa13_fm_sector()) | "TSA".equals(isemboardobj.getDa13_fm_sector()))
	//         {
	//             isemboard = true;
	//         }
	         
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
	             //qd_str = " TPECSCI";// 測試Telex
		         //****************************************************************     
		         if(da13objAL.size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             		                        
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:+.?*'"+"\r\n");

			             txtSB.append("UNB+UNOA:4+TPETTCI:ZZZ+UKBAUS:ZZZ+"+time1+"+"+time2+"++UKBAOP'"+"\r\n");
			             txtSB.append("UNG+PAXLST+CHINA AIRLINES+UKBAOP"+time1+"+"+time2+"+UN+D:06B'"+"\r\n");
				         txtSB.append("UNH+PAX001+PAXLST:D:06B:UN:IATA+"+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"+"+page_str+"'"+"\r\n");
				         if("BEF".equals(obj.getFly_status()))
				         {
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         else
				         {//AFT
				             txtSB.append("BGM+250+CLOB'"+"\r\n");
				         }
				         txtSB.append("NAD+MS+++ATTN "+obj.getDpt()+"XT"+obj.getCarrier()+"'"+"\r\n");
				         txtSB.append("COM+011-8863-398-3989:TE+011-8863-399-8194:FX'"+"\r\n");
				         txtSB.append("TDT+20+"+obj.getCarrier()+tempfltno+"+++"+obj.getCarrier()+"'"+"\r\n");
				         line_cnt =5;         
				         
				         if(da13objAL.size()>0)
				         {
				             boolean gotDR = false;
				             for(int d=0; d<da13objAL.size(); d++)
				             {
				                 //set R D A
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && dpt.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 //若為入境航班,最後一個非主體國dpt站  XXXX->main_ctry
				                 //若為出境航班,最後一個主體國dpt站	
				                 if(da13objAL.size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }			
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj3.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }
				                 }
				             }
		             
				             if(gotDR == false)
		                     {//like TPE--ANC--JFK
		                         for(int d=obj.getDa13AL().size()-1; d>=0; d--)
		                         {
		                             DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
		                             PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
					                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }				                 
					             }
		                     }
				             //******************************************************************************************
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {			                     
				                     if(getDA == false)
				                     {
					                     txtSB.append("LOC+92+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC+92+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }			                   
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC+125+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC+87+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }			                    
				                     getDA = true;			                     
				                 }			                 
				             }
				         }//if(obj.getDa13AL().size()>0)
				         
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
//				             if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5
				             	txtSB.append("NAD+FM+++"+apisdetailobj.getLname()+":"+apisdetailobj.getFname()+"'"+"\r\n");
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"\r\n");
//				             }
					         txtSB.append("ATT+2++"+apisdetailobj.getGender()+"'"+"\r\n");
					         txtSB.append("DTM+329:"+apisdetailobj.getBirth()+"'"+"\r\n");
					         txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         txtSB.append("RFF+AVF:CCRR11'"+"\r\n");
					         txtSB.append("DOC+P+"+apisdetailobj.getPassport()+"'"+"\r\n");
					         txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					         txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         line_cnt = line_cnt +8;					         
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT+41:"+apisdetailAL.size()+"'"+"\r\n");//crew count         
				         txtSB.append("UNT+"+df.format((line_cnt+2))+"+PAX001'"+"\r\n");//UNH~UNT 行數
				         txtSB.append("UNE+1+"+time2+"'"+"\r\n");//系統時間
				         txtSB.append("UNZ+1+"+time2+"'"+"\r\n");//系統時間
				         
//				         System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());	
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)	         
	         }//if(!"".equals(qd_str))  
			 errorstr = "Y";
         }
         catch (Exception e)
 		{
 			System.out.println("Error ## "+e.toString()); 		
			errorstr = "Error ## "+e.toString();
 		} 
 		finally
 		{
 		    
 		}
         
         return txtHT;         
     }
     
     public Hashtable getUKArvAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (inbound) 
	     errorstr = "";
         Hashtable txtHT = new Hashtable();  
         String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());        
	         main_ctry = portobj2.getCtry();
	        
	      
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //英國：UK        
	         
	         //Arrival
			   if("UK".equals(portobj2.getCtry()))
			   {
			       qd_str = " LONHT7X TPEWGCI";//test
//		             qd_str = " LONHO7X TPEWGCI";//live
			   }
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()) | "5".equals(obj.getFltno().substring(0,1)) | "6".equals(obj.getFltno().substring(0,1)))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************        
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
	             //qd_str = " TPECSCI";// 測試Telex
		         //****************************************************************     
		         if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
				         txtSB.append("UNA:+.?*'"+"\r\n");				         
				        
			             txtSB.append("UNB+UNOA:4+TPETTCI:ZZZ+UKBAUS:ZZZ+"+time1+"+"+time2+"++UKBAOP'"+"\r\n");
			             txtSB.append("UNG+PAXLST+CHINA AIRLINES+UKBAOP+"+time1+"+"+time2+"+UN+D:06B'"+"\r\n");
				         txtSB.append("UNH+PAX001+PAXLST:D:06B:UN:IATA+"+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"+"+page_str+"'"+"\r\n");

				         if("BEF".equals(obj.getFly_status()))
				         {
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         else
				         {//AFT
				             txtSB.append("BGM+250+CLOB'"+"\r\n");
				         }				         
				         
				         txtSB.append("NAD+MS+++ATTN "+obj.getDpt()+"XT"+obj.getCarrier()+"'"+"\r\n");
				         txtSB.append("COM+011-8863-398-3989:TE+011-8863-399-8194:FX'"+"\r\n");
				         txtSB.append("TDT+20+"+obj.getCarrier()+tempfltno+"+++"+obj.getCarrier()+"'"+"\r\n");
				         line_cnt =5;         
				         
				         if(obj.getDa13AL().size()>0)
				         {
				             boolean getR = false;
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && arv.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 			        
				                 if(obj.getDa13AL().size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
				                     else if(!portobj3.getCtry().equals(portobj4.getCtry()) && getR == true && portobj3.getCtry().equals(main_ctry))
				                     {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                     getR = true;
					                 }
				                 }
				                 	                 
				             }
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {
				                     if(getDA == false)
				                     {				                     
					                     txtSB.append("LOC+92+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
					                     
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC+92+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC+125+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC+87+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }			           
				                     getDA = true;
				                 }
				             }
				         }//if(obj.getDa13AL().size()>0)
//				         else
//				         {
//	System.out.println("arv getDa13AL().size()<0");			             
//				         }
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
					         
//					         if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5
				             	   txtSB.append("NAD+FM+++"+apisdetailobj.getLname()+":"+apisdetailobj.getFname()+"'"+"\r\n");			             	
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+"'"+"\r\n");
//				             }
					         txtSB.append("ATT+2++"+apisdetailobj.getGender()+"'"+"\r\n");
					         txtSB.append("DTM+329:"+apisdetailobj.getBirth()+"'"+"\r\n");					         
					         txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         txtSB.append("RFF+AVF:CCRR11'"+"\r\n");
					         txtSB.append("DOC+P+"+apisdetailobj.getPassport()+"'"+"\r\n");
					         txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					         txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         line_cnt = line_cnt +8;
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT+41:"+apisdetailAL.size()+"'"+"\r\n");//crew count         
				         txtSB.append("UNT+"+df.format((line_cnt+2))+"+PAX001'"+"\r\n");//UNH~UNT 行數
				         txtSB.append("UNE+1+"+time2+"'"+"\r\n");//系統時間
				         txtSB.append("UNZ+1+"+time2+"'"+"\r\n");//系統時間
				         
	//			         System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());		
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
	         }//if(!"".equals(qd_str)) 
			 errorstr = "Y";
	     }
	     catch (Exception e)
		{
			System.out.println("Error ## "+e.toString()); 		
			errorstr = "Error ## "+e.toString();
		} 
		finally
		{
		    
		}
        return txtHT;         
     }
     
     
//   New Zealand
     //*************************************************************************************
     public Hashtable getNZDptAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (outbound)   
//         System.out.println("apisdetailAL.size() = "+apisdetailAL.size());
	     errorstr = "";
         Hashtable txtHT = new Hashtable();      
		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {  
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	//     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
			 main_ctry = portobj1.getCtry();
	         
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address			 
	         //紐西蘭:NEW ZEALAND	         
	         //Departure
	         if("NEW ZEALAND".equals(portobj1.getCtry()))
	         {
//	             qd_str = " WLGCS8X TPEWGCI";//test
	             qd_str = " WLGCS8X TPEWGCI";//live
	         }
	        
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()) | "5".equals(obj.getFltno().substring(0,1)) | "6".equals(obj.getFltno().substring(0,1)))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************
	//         //判斷是否為入境
	//         DA13Obj isemboardobj = (DA13Obj) da13objAL.get(0);
	//         if("TPE".equals(isemboardobj.getDa13_fm_sector()) | "KHH".equals(isemboardobj.getDa13_fm_sector()) | "TSA".equals(isemboardobj.getDa13_fm_sector()))
	//         {
	//             isemboard = true;
	//         }
	         
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(da13objAL.size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             		                        
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:+.?*'"+"\r\n");

			             txtSB.append("UNB+UNOA:4+TPETT"+obj.getCarrier()+":"+obj.getCarrier()+"+NZCSPROD:NZ+"+time1+"+"+time2+"++APIS'"+"\r\n");
			             txtSB.append("UNG+PAXLST+CHINA AIRLINES:"+obj.getCarrier()+"+NZCSPROD:NZ+"+time1+"+"+time2+"+UN+D:02B'"+"\r\n");
				         txtSB.append("UNH+PAX001+PAXLST:D:02B:UN:IATA+"+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"+"+page_str+"'"+"\r\n");
				         if("BEF".equals(obj.getFly_status()))
				         {
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         else
				         {//AFT
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         txtSB.append("NAD+MS+++ATTN "+obj.getDpt()+"KK"+obj.getCarrier()+"'"+"\r\n");
				         txtSB.append("COM+011-8863-398-3989:TE+011-8863-399-8194:FX'"+"\r\n");
				         txtSB.append("TDT+20+"+obj.getCarrier()+tempfltno+"'"+"\r\n");
				         line_cnt =5;         
				         
				         if(da13objAL.size()>0)
				         {
				             boolean gotDR = false;
				             for(int d=0; d<da13objAL.size(); d++)
				             {
				                 //set R D A
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && dpt.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 //若為入境航班,最後一個非主體國dpt站  XXXX->main_ctry
				                 //若為出境航班,最後一個主體國dpt站	
				                 if(da13objAL.size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }			
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj3.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }
				                 }
				             }
		             
				             if(gotDR == false)
		                     {//like TPE--ANC--JFK
		                         for(int d=obj.getDa13AL().size()-1; d>=0; d--)
		                         {
		                             DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
		                             PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
					                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }				                 
					             }
		                     }
				             //******************************************************************************************
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {			                     
//				                     if(getDA == false)
//				                     {				                         
//					                     txtSB.append("LOC+92+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
//					                     line_cnt++;
//					                     for(int c=0; c<obj.getDa13AL().size(); c++)
//					                     {
//					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
//					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }
//					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }				                         
//					                     }
//				                     }
//				                     else
//				                     {//getDA == true
//					                     txtSB.append("LOC+92+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
//					                     line_cnt++;
//					                     for(int c=0; c<obj.getDa13AL().size(); c++)
//					                     {
//					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
//					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }
//					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }				                         
//					                     }
//				                     }			                   
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC+125+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         
				                         boolean ifalk = false;
				                         if("AKL".equals(tempobj.getDa13_fm_sector()) || "AKL".equals(tempobj.getDa13_to_sector()))
				                         {
				                             ifalk = true;
				                         }
				                         PortCityObj portobj5 = pc.getPortCityObj(tempobj.getDa13_fm_sector());
				                         PortCityObj portobj6 = pc.getPortCityObj(tempobj.getDa13_to_sector());
				                         if("NEW ZEALAND".equals(portobj5.getCtry()) || "NEW ZEALAND".equals(portobj6.getCtry()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()) && ifalk == true)
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()) && ifalk == true)
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC+87+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         boolean ifalk = false;
				                         if("AKL".equals(tempobj.getDa13_fm_sector()) || "AKL".equals(tempobj.getDa13_to_sector()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         PortCityObj portobj5 = pc.getPortCityObj(tempobj.getDa13_fm_sector());
				                         PortCityObj portobj6 = pc.getPortCityObj(tempobj.getDa13_to_sector());
				                         if("NEW ZEALAND".equals(portobj5.getCtry()) || "NEW ZEALAND".equals(portobj6.getCtry()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()) && ifalk == true)
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()) && ifalk == true)
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }			                    
				                     getDA = true;			                     
				                 }			                 
				             }
				         }//if(obj.getDa13AL().size()>0)
				         
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
//				             if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5
				             txtSB.append("NAD+FM+++"+apisdetailobj.getLname()+":"+apisdetailobj.getFname()+"'"+"\r\n");
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+")"+"\r\n");
//				             }
					         txtSB.append("ATT+2++"+apisdetailobj.getGender()+"'"+"\r\n");
					         txtSB.append("DTM+329:"+apisdetailobj.getBirth()+"'"+"\r\n");
					         txtSB.append("LOC+22+"+apisdetailobj.getArv()+"'"+"\r\n");
					         txtSB.append("LOC+178+"+apisdetailobj.getDpt()+"'"+"\r\n");
					         txtSB.append("LOC+179+"+apisdetailobj.getArv()+"'"+"\r\n");
					         txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         txtSB.append("RFF+AVF:CCRR11'"+"\r\n");
					         txtSB.append("DOC+P:110:111+"+apisdetailobj.getPassport()+"'"+"\r\n");
//					         txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
//					         txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         txtSB.append("DTM+36:      '"+"\r\n");
					         txtSB.append("LOC+91+   '"+"\r\n");
					         line_cnt = line_cnt +11;					         
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT+42:"+apisdetailAL.size()+"'"+"\r\n");//crew count 
				         txtSB.append("UNT+"+df.format((line_cnt+2))+"+PAX001'"+"\r\n");//UNH~UNT 行數
				         txtSB.append("UNE+1+"+time2+"'"+"\r\n");//系統時間
				         txtSB.append("UNZ+1+"+time2+"'"+"\r\n");//系統時間
				         
//System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());	
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)	         
	         }//if(!"".equals(qd_str))      
			 errorstr = "Y";
         }
         catch (Exception e)
 		{
 			System.out.println("Error ## "+e.toString()); 	
			errorstr = "Error ## "+e.toString();
 		} 
 		finally
 		{
 		    
 		}
         
         return txtHT;         
     }
     
     //New Zealand
     //*********************************************************************************************
     public Hashtable getNZArvAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (inbound) 
	     errorstr = "";
         Hashtable txtHT = new Hashtable();  
		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");         
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());        
	         main_ctry = portobj2.getCtry();
	        
	      
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //紐西蘭：NEW ZEALAND       
	         
	         //Arrival
			   if("NEW ZEALAND".equals(portobj2.getCtry()))
			   {
//			       qd_str = " WLGCS8X TPEWGCI";//test
		           qd_str = " WLGCS8X TPEWGCI";//live
			   }
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()) | "5".equals(obj.getFltno().substring(0,1)) | "6".equals(obj.getFltno().substring(0,1)))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************        
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:+.?*'"+"\r\n");				         
				        
			             txtSB.append("UNB+UNOA:4+TPETTCI:CI+NZCSPROD:NZ+"+time1+"+"+time2+"++APIS'"+"\r\n");
			             txtSB.append("UNG+PAXLST+CHINA AIRLINES:CI+NZCSPROD:NZ+"+time1+"+"+time2+"+UN+D:02B'"+"\r\n");
				         txtSB.append("UNH+PAX001+PAXLST:D:02B:UN:IATA+"+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"+"+page_str+"'"+"\r\n");

				         if("BEF".equals(obj.getFly_status()))
				         {
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         else
				         {//AFT
				             txtSB.append("BGM+250'"+"\r\n");
				         }				         
				         
				         txtSB.append("NAD+MS+++ATTN "+obj.getDpt()+"KK"+obj.getCarrier()+"'"+"\r\n");
				         txtSB.append("COM+011-8863-398-3989:TE+011-8863-399-8194:FX'"+"\r\n");
				         txtSB.append("TDT+20+"+obj.getCarrier()+tempfltno+"'"+"\r\n");
				         line_cnt =5;         
				         
				         if(obj.getDa13AL().size()>0)
				         {
				             boolean getR = false;
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && arv.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 			        
				                 if(obj.getDa13AL().size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
				                     else if(!portobj3.getCtry().equals(portobj4.getCtry()) && getR == true && portobj3.getCtry().equals(main_ctry))
				                     {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                     getR = true;
					                 }
				                 }
				                 	                 
				             }
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {
//				                     if(getDA == false)
//				                     {				                     
//					                     txtSB.append("LOC+92+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
//					                     line_cnt++;
//					                     
//					                     for(int c=0; c<obj.getDa13AL().size(); c++)
//					                     {
//					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
//					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }
//					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }				                         
//					                     }
//					                     
//				                     }
//				                     else
//				                     {//getDA == true
//					                     txtSB.append("LOC+92+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
//					                     line_cnt++;
//					                     for(int c=0; c<obj.getDa13AL().size(); c++)
//					                     {
//					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
//					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }
//					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
//					                         {
//					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
//					                             line_cnt++;
//					                         }				                         
//					                     }
//				                     }
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC+125+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         boolean ifalk = false;
				                         if("AKL".equals(tempobj.getDa13_fm_sector()) || "AKL".equals(tempobj.getDa13_to_sector()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         PortCityObj portobj5 = pc.getPortCityObj(tempobj.getDa13_fm_sector());
				                         PortCityObj portobj6 = pc.getPortCityObj(tempobj.getDa13_to_sector());
				                         if("NEW ZEALAND".equals(portobj5.getCtry()) || "NEW ZEALAND".equals(portobj6.getCtry()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()) && ifalk==true)
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()) && ifalk==true)
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC+87+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         
				                         boolean ifalk = false;
				                         if("AKL".equals(tempobj.getDa13_fm_sector()) || "AKL".equals(tempobj.getDa13_to_sector()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         PortCityObj portobj5 = pc.getPortCityObj(tempobj.getDa13_fm_sector());
				                         PortCityObj portobj6 = pc.getPortCityObj(tempobj.getDa13_to_sector());
				                         if("NEW ZEALAND".equals(portobj5.getCtry()) || "NEW ZEALAND".equals(portobj6.getCtry()))
				                         {
				                             ifalk = true;
				                         }
				                         
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()) && ifalk==true)
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()) && ifalk==true)
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }			           
				                     getDA = true;
				                 }
				             }
				         }//if(obj.getDa13AL().size()>0)
//				         else
//				         {
//	System.out.println("arv getDa13AL().size()<0");			             
//				         }
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
					         
//					         if(apisdetailobj.isCargo_passenger()==true)
//				             {//cargo passenger include resiaddr1~5
				             txtSB.append("NAD+FM+++"+apisdetailobj.getLname()+":"+apisdetailobj.getFname()+"'"+"\r\n");			             	
//				             }
//				             else
//				             {
//				                 txtSB.append("NAD(FM((("+apisdetailobj.getLname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+":"+apisdetailobj.getFname().replaceAll("[?]","??").replaceAll(" ","? ").replaceAll("[(]","?(").replaceAll("[)]","?)").replaceAll("[.]","?.")+"'"+"\r\n");
//				             }
			             	 txtSB.append("ATT+2++"+apisdetailobj.getGender()+"'"+"\r\n");
					         txtSB.append("DTM+329:"+apisdetailobj.getBirth()+"'"+"\r\n");
					         txtSB.append("LOC+22+"+apisdetailobj.getArv()+"'"+"\r\n");
					         txtSB.append("LOC+178+"+apisdetailobj.getDpt()+"'"+"\r\n");
					         txtSB.append("LOC+179+"+apisdetailobj.getArv()+"'"+"\r\n");
					         txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         txtSB.append("RFF+AVF:CCRR11'"+"\r\n");
					         txtSB.append("DOC+P:110:111+"+apisdetailobj.getPassport()+"'"+"\r\n");
							//txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
							//txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         txtSB.append("DTM+36:      '"+"\r\n");
					         txtSB.append("LOC+91+   '"+"\r\n");
					         line_cnt = line_cnt +11;
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT+42:"+apisdetailAL.size()+"'"+"\r\n");//crew count   
				         txtSB.append("UNT+"+df.format((line_cnt+2))+"+PAX001'"+"\r\n");//UNH~UNT 行數
				         txtSB.append("UNE+1+"+time2+"'"+"\r\n");//系統時間
				         txtSB.append("UNZ+1+"+time2+"'"+"\r\n");//系統時間
				         
//System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());		
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
	         }//if(!"".equals(qd_str)) 
			 errorstr = "Y";
	     }
	     catch (Exception e)
		{
			System.out.println("Error ## "+e.toString()); 		
			errorstr = "Error ## "+e.toString();
		} 
		finally
		{
		    
		}
        return txtHT;         
     }
     
     //TAIWAN
     //*************************************************************************************
     public Hashtable getTWDptAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (outbound)   
//         System.out.println("apisdetailAL.size() = "+apisdetailAL.size());
         errorstr = "";
         Hashtable txtHT = new Hashtable();      
		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {  
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");       
	         String time3 = new SimpleDateFormat("yyMMddHHmmss").format(new java.util.Date());
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	//     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());  
			 main_ctry = portobj1.getCtry();
	         
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address			 
	         //台灣:TAIWAN	         
	         //Departure
	         if("TAIWAN".equals(portobj1.getCtry()))
	         {
	             //qd_str = " TPEWGCI TPEWGCI";//test
//	             qd_str = " TPEWGCI TPEWGCI";//live
	         }
	        
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************
	//         //判斷是否為入境
	//         DA13Obj isemboardobj = (DA13Obj) da13objAL.get(0);
	//         if("TPE".equals(isemboardobj.getDa13_fm_sector()) | "KHH".equals(isemboardobj.getDa13_fm_sector()) | "TSA".equals(isemboardobj.getDa13_fm_sector()))
	//         {
	//             isemboard = true;
	//         }
	         
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(da13objAL.size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             		                        
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:+.?'"+"\r\n");

			             txtSB.append("UNB+UNOA:4+TPETT"+obj.getCarrier()+":ZZ+TWAPIS:ZZ+"+time1+"+"+time2+"++APIS'"+"\r\n");
			             txtSB.append("UNG+PAXLST+CHINA AIRLINES:ZZ+TWAPIS:ZZ+"+time1+"+"+time2+"+UN+D:02B'"+"\r\n");
				         txtSB.append("UNH+PAX001+PAXLST:D:02B:UN:IATA+"+obj.getCarrier()+time3+"+"+page_str+"'"+"\r\n");
				         if("BEF".equals(obj.getFly_status()))
				         {
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         else
				         {//AFT
				             txtSB.append("BGM+250'"+"\r\n");
				         }
//				         txtSB.append("NAD+MS+++ATTN "+obj.getDpt()+"KK"+obj.getCarrier()+"'"+"\r\n");
				         txtSB.append("NAD+MS+++PILOT DAILY COUNTER'"+"\r\n");
				         txtSB.append("COM+011-8863-398-3989:TE+011-8863-399-8194:FX'"+"\r\n");
				         txtSB.append("TDT+20+"+obj.getCarrier()+tempfltno+"'"+"\r\n");
				         line_cnt =5;  
				         
				         if(da13objAL.size()>0)
				         {
				             boolean gotDR = false;
				             for(int d=0; d<da13objAL.size(); d++)
				             {
				                 //set R D A
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && dpt.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 //若為入境航班,最後一個非主體國dpt站  XXXX->main_ctry
				                 //若為出境航班,最後一個主體國dpt站	
				                 if(da13objAL.size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }			
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj3.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }
				                 }
				             }
		             
				             if(gotDR == false)
		                     {//like TPE--ANC--JFK
		                         for(int d=obj.getDa13AL().size()-1; d>=0; d--)
		                         {
		                             DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
		                             PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
					                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }				                 
					             }
		                     }
				             //******************************************************************************************
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {			                     
				                     if(getDA == false)
				                     {
					                     txtSB.append("LOC+92+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC+92+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }			                   
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC+125+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC+87+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }			                    
				                     getDA = true;			                     
				                 }			                 
				             }
				         }//if(obj.getDa13AL().size()>0)
				         
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
				             txtSB.append("NAD+FM+++"+apisdetailobj.getLname()+":"+apisdetailobj.getFname()+":+++++'"+"\r\n");		             
					         txtSB.append("ATT+2++"+apisdetailobj.getGender()+"'"+"\r\n");
					         txtSB.append("DTM+329:"+apisdetailobj.getBirth()+"'"+"\r\n");
					         txtSB.append("LOC+178+"+obj.getDpt()+"'"+"\r\n");	
					         txtSB.append("LOC+179+"+obj.getArv()+"'"+"\r\n");
					         //if CHN FLT nation=TW or TWN then T 台胞証  nation=CHN D 通行証 other passport  
					         if("CHINA".equals(portobj2.getCtry()))
					         {//前往大陸
					             if("TWN".equals(apisdetailobj.getNation()) | "TW".equals(apisdetailobj.getNation()))
					             {//台灣國籍需持台胞証
					                 txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					                 txtSB.append("DOC+T+"+apisdetailobj.getPassport()+"'"+"\r\n");
					                 txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					                 txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					             }
					             else if("CHN".equals(apisdetailobj.getNation()))
					             {//大陸國籍需持通行証
					                 txtSB.append("NAT+2+"+apisdetailobj.getPasscountry2()+"'"+"\r\n");
					                 txtSB.append("DOC+D+"+apisdetailobj.getPassport2()+"'"+"\r\n");
					                 txtSB.append("DTM+36:"+apisdetailobj.getPassexp2()+"'"+"\r\n");
					                 txtSB.append("LOC+91+"+apisdetailobj.getPasscountry2()+"'"+"\r\n");
					             }
					             else
					             {//台灣及大陸國籍以外需持護照
					                 txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					                 txtSB.append("DOC+P+"+apisdetailobj.getPassport()+"'"+"\r\n");
					                 txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					                 txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					             }					              
					         }
					         else
					         {//前往大陸以外地區需持護照
					             txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					             txtSB.append("DOC+P+"+apisdetailobj.getPassport()+"'"+"\r\n");
					             txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					             txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         }
					         					         
					         line_cnt = line_cnt +9;					         
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT+41:"+apisdetailAL.size()+"'"+"\r\n");//crew count         
				         txtSB.append("UNT+"+(line_cnt+2)+"+PAX001'"+"\r\n");//UNH~UNT 行數
				         txtSB.append("UNE+1+"+time2+"'"+"\r\n");//系統時間
				         txtSB.append("UNZ+1+"+time2+"'"+"\r\n");//系統時間
				         
//System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());	
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)	         
	         }//if(!"".equals(qd_str))      
	         errorstr = "Y";
         }
         catch (Exception e)
 		{
 			System.out.println("Error ## "+e.toString()); 	
 			errorstr = "Error ## "+e.toString();
 		} 
 		finally
 		{
 		    
 		}
         
         return txtHT;         
     }
     
     //TAIWAN
     //*********************************************************************************************
     public Hashtable getTWArvAPISTxtHT(APISObj obj, ArrayList apisdetailAL)
     {//Dpt~Arv (inbound) 
         errorstr = "";
         Hashtable txtHT = new Hashtable();  
		 String tempfltno = obj.getFltno();
         tempfltno = tempfltno.replaceAll("Z","");
         if(tempfltno.length()<4)
         {
             tempfltno="0"+tempfltno;
         }

         try
         {
	         PortCity pc = new PortCity();
	         pc.getPortCityData();      
	         
	         String time1 = new SimpleDateFormat("yyMMdd:HHmm").format(new java.util.Date());
	         String time2 = time1.replaceAll(":","");       
	         String time3 = new SimpleDateFormat("yyMMddHHmmss").format(new java.util.Date());
	     	 DecimalFormat df = new DecimalFormat("000000");
	     	 boolean isdomestic = false;
	     	 boolean iscargo = false;
	     	 boolean isemboard = false;
	     	 String qd_str = "";
	     	 String main_ctry = "";
	     	 PortCityObj portobj1 = pc.getPortCityObj(obj.getDpt());
	         PortCityObj portobj2 = pc.getPortCityObj(obj.getArv());        
	         main_ctry = portobj2.getCtry();
	        
	      
	         ArrayList da13objAL = new ArrayList();
	         da13objAL = obj.getDa13AL();
	     	 //發報address
			 //紐西蘭：NEW ZEALAND       
	         
	         //Arrival
			   if("TAIWAN".equals(portobj2.getCtry()))
			   {
			       //qd_str = " TPEWGCI TPEWGCI";//test
//		             qd_str = " TPEWGCI TPEWGCI";//live
			   }
	         //****************************************************************
	         //判斷是否為內陸航程           
	         if( portobj1.getCtry() != null && portobj2.getCtry() != null)
	         {
		         if(portobj1.getCtry().equals(portobj2.getCtry()))
		         {
		             isdomestic = true;
		         }
		     }
	         //****************************************************************
	         //判斷是否為貨機         
	         if(da13objAL.size()>0)
	         {
	             DA13Obj da13obj = (DA13Obj) da13objAL.get(0) ;
	             if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	             {
	                 iscargo = true;
	             }
	         }
	     	 //****************************************************************         
	//       pax & domestic ==> E 
	//       pax & not domestic ==> C
	//       Cgo& domestic ==> F 
	//       Cgo& not domestic ==> B
	         String bgm_str = "";
	         if(iscargo==false && isdomestic == true)
	         {
	             bgm_str="E";
	         }
	         if(iscargo==false && isdomestic == false)
	         {
	             bgm_str="C";
	         }
	         if(iscargo==true && isdomestic == true)
	         {
	             bgm_str="F";
	         }
	         if(iscargo==true && isdomestic == false)
	         {
	             bgm_str="B";
	         }
	         //****************************************************************        
	         //若Telex address 為空,則不發送APIS電報
	         //****************************************************************     
	         if(!"".equals(qd_str))
	         {         
		         //****************************************************************     
		         if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
		         {//有mapping 到 DA13且有組員資訊
		             int telex_page_start = 1;             
		             int telex_page_end = apisdetailAL.size()/6;
		             if(apisdetailAL.size()%6 >0)
		             {
		                 telex_page_end++;
		             }
		             
		             int current_idx = 0;
		//System.out.println("crew_cnt"+apisdetailAL.size()+" ** "+ telex_page_start +"  ** "+telex_page_end);             
			         for(int t=telex_page_start; t <=telex_page_end; t++)
			         {         
			             StringBuffer txtSB = new StringBuffer(); 
			             int line_cnt = 0;
			             String page_str = "0"+t;
			             
		                 if(t==1 && telex_page_end>1)
		                 {
		                     page_str = page_str+":C";
		                 }		             
			             
			             if(t==telex_page_end && telex_page_end>1 )
			             {
			                 page_str = page_str+":F";	             
			             }
			             
				         txtSB.append("QK"+qd_str+"\r\n");
				         txtSB.append("."+obj.getDpt()+"TT"+obj.getCarrier()+"\r\n");
				         txtSB.append("UNA:+.?'"+"\r\n");

			             txtSB.append("UNB+UNOA:4+TPETT"+obj.getCarrier()+":ZZ+TWAPIS:ZZ+"+time1+"+"+time2+"++APIS'"+"\r\n");
			             txtSB.append("UNG+PAXLST+CHINA AIRLINES:ZZ+TWAPIS:ZZ+"+time1+"+"+time2+"+UN+D:02B'"+"\r\n");
				         //txtSB.append("UNH+PAX001+PAXLST:D:02B:UN:IATA+"+obj.getCarrier()+tempfltno+"/"+obj.getEnd_port_local().replaceAll("/","").replaceAll(":","").replaceAll(" ","/").substring(2)+"+"+page_str+"'"+"\r\n");
				         txtSB.append("UNH+PAX001+PAXLST:D:02B:UN:IATA+"+obj.getCarrier()+time3+"+"+page_str+"'"+"\r\n");
				         if("BEF".equals(obj.getFly_status()))
				         {
				             txtSB.append("BGM+250'"+"\r\n");
				         }
				         else
				         {//AFT
				             txtSB.append("BGM+250'"+"\r\n");
				         }
//				         txtSB.append("NAD+MS+++ATTN "+obj.getDpt()+"KK"+obj.getCarrier()+"'"+"\r\n");
				         txtSB.append("NAD+MS+++PILOT DAILY COUNTER'"+"\r\n");
				         txtSB.append("COM+011-8863-398-3989:TE+011-8863-399-8194:FX'"+"\r\n");
				         txtSB.append("TDT+20+"+obj.getCarrier()+tempfltno+"'"+"\r\n");
				         line_cnt =5;  
				         
				         if(da13objAL.size()>0)
				         {
				             boolean gotDR = false;
				             for(int d=0; d<da13objAL.size(); d++)
				             {
				                 //set R D A
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
				                 //若dpt.ctry != arv.ctry && dpt.ctry == main_ctry 
				                 //此為國家交界,APIS 先D 後A
				                 PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
				                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());			                 
				                 //若為入境航班,最後一個非主體國dpt站  XXXX->main_ctry
				                 //若為出境航班,最後一個主體國dpt站	
				                 if(da13objAL.size()<=1)
				                 {
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && (portobj3.getCtry().equals(main_ctry) | portobj4.getCtry().equals(main_ctry)))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");
					                 }			
				                 }
				                 else
				                 {//multi leg
				                     if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj3.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }
				                 }
				             }
		             
				             if(gotDR == false)
		                     {//like TPE--ANC--JFK
		                         for(int d=obj.getDa13AL().size()-1; d>=0; d--)
		                         {
		                             DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);
		                             PortCityObj portobj3 = pc.getPortCityObj(da13obj.getDa13_fm_sector());
					                 PortCityObj portobj4 = pc.getPortCityObj(da13obj.getDa13_to_sector());
					                 if(!portobj3.getCtry().equals(portobj4.getCtry()) && portobj4.getCtry().equals(main_ctry))
					                 {
					                     da13obj.setDpt_status_type("D");
					                     da13obj.setArv_status_type("A");
					                     gotDR = true;
					                 }//			                     
					                 else
					                 {
					                     da13obj.setDpt_status_type("R");
					                     da13obj.setArv_status_type("R");				                     
					                 }				                 
					             }
		                     }
				             //******************************************************************************************
				             
				             boolean getDA = false;//tool variable
				             for(int d=0; d<obj.getDa13AL().size(); d++)
				             {
				                 //set D A R
				                 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(d);	
				                 if("R".equals(da13obj.getDpt_status_type()))
				                 {			                     
				                     if(getDA == false)
				                     {
					                     txtSB.append("LOC+92+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }
				                     else
				                     {//getDA == true
					                     txtSB.append("LOC+92+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
					                     line_cnt++;
					                     for(int c=0; c<obj.getDa13AL().size(); c++)
					                     {
					                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
					                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }
					                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
					                         {
					                             txtSB.append("DTM+189:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
					                             line_cnt++;
					                         }				                         
					                     }
				                     }			                   
				                 }
				                 else
				                 {//"D".equals(da13obj.getDpt_status_type())
				                     txtSB.append("LOC+125+"+da13obj.getDa13_fm_sector()+"'"+"\r\n");
				                     line_cnt++;
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_fm_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }
				                     
				                     txtSB.append("LOC+87+"+da13obj.getDa13_to_sector()+"'"+"\r\n");
				                     line_cnt++;
				                   
				                     for(int c=0; c<obj.getDa13AL().size(); c++)
				                     {
				                         DA13Obj tempobj = (DA13Obj) obj.getDa13AL().get(c);
				                         if(tempobj.getDa13_fm_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+189:"+tempobj.getDa13_atdl().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }
				                         if(tempobj.getDa13_to_sector().equals(da13obj.getDa13_to_sector()))
				                         {
				                             txtSB.append("DTM+232:"+tempobj.getDa13_atal().replaceAll("/","").replaceAll(":","").replaceAll(" ","").substring(2)+":201'"+"\r\n");
				                             line_cnt++;
				                         }				                         
				                     }			                    
				                     getDA = true;			                     
				                 }			                 
				             }
				         }//if(obj.getDa13AL().size()>0)
				         
				//       ****************************     
				         //display crews' record
				         int crew_cnt = 0;
				         for(int i=current_idx; i<apisdetailAL.size(); i++)
				         {
				             APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
				             txtSB.append("NAD+FM+++"+apisdetailobj.getLname()+":"+apisdetailobj.getFname()+":+++++'"+"\r\n");		             
					         txtSB.append("ATT+2++"+apisdetailobj.getGender()+"'"+"\r\n");
					         txtSB.append("DTM+329:"+apisdetailobj.getBirth()+"'"+"\r\n");
					         txtSB.append("LOC+22+"+obj.getArv()+"'"+"\r\n");
					         txtSB.append("LOC+178+"+obj.getDpt()+"'"+"\r\n");	
					         txtSB.append("LOC+179+"+obj.getArv()+"'"+"\r\n");
					         //if CHN FLT nation=TW or TWN then T passport  nation=CHN D 通行証 others passport  
					         if("CHINA".equals(portobj1.getCtry()))
					         {//來自大陸
					             if("TWN".equals(apisdetailobj.getNation()) | "TW".equals(apisdetailobj.getNation()))
					             {//台灣國籍入境需持護照
					                 txtSB.append("NAT+2+"+apisdetailobj.getPasscountry2()+"'"+"\r\n");
					                 txtSB.append("DOC+P+"+apisdetailobj.getPassport2()+"'"+"\r\n");
					                 txtSB.append("DTM+36:"+apisdetailobj.getPassexp2()+"'"+"\r\n");
					                 txtSB.append("LOC+91+"+apisdetailobj.getPasscountry2()+"'"+"\r\n");
					             }
					             else if("CHN".equals(apisdetailobj.getNation()))
					             {//大陸國籍入境需持通行証
					                 txtSB.append("NAT+2+"+apisdetailobj.getPasscountry2()+"'"+"\r\n");
					                 txtSB.append("DOC+D+"+apisdetailobj.getPassport2()+"'"+"\r\n");
					                 txtSB.append("DTM+36:"+apisdetailobj.getPassexp2()+"'"+"\r\n");
					                 txtSB.append("LOC+91+"+apisdetailobj.getPasscountry2()+"'"+"\r\n");
					             }
					             else
					             {//台灣及大陸國籍以外入境需持護照
					                 txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					                 txtSB.append("DOC+P+"+apisdetailobj.getPassport()+"'"+"\r\n");
					                 txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					                 txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					             }					              
					         }
					         else
					         {//來自大陸以外地區需持護照
					             txtSB.append("NAT+2+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					             txtSB.append("DOC+P+"+apisdetailobj.getPassport()+"'"+"\r\n");
					             txtSB.append("DTM+36:"+apisdetailobj.getPassexp()+"'"+"\r\n");
					             txtSB.append("LOC+91+"+apisdetailobj.getPasscountry()+"'"+"\r\n");
					         }
					         					         
					         line_cnt = line_cnt +10;					         
					         crew_cnt ++;
					         current_idx++;
					         if(crew_cnt>=6)
					         {
					             crew_cnt = 0;
					             break;
					         }
				         }
				         txtSB.append("CNT+41:"+apisdetailAL.size()+"'"+"\r\n");//crew count  
				         txtSB.append("UNT+"+(line_cnt+2)+"+PAX001'"+"\r\n");//UNH~UNT 行數
				         txtSB.append("UNE+1+"+time2+"'"+"\r\n");//系統時間
				         txtSB.append("UNZ+1+"+time2+"'"+"\r\n");//系統時間
				         
//System.out.println(txtSB.toString());
				         txtHT.put(Integer.toString(t),txtSB.toString());		
			         }//for(int txt=telex_page_start; txt <=telex_page_end; txt++)
		         }//if(obj.getDa13AL().size()>0 && apisdetailAL.size()>0)
	         }//if(!"".equals(qd_str)) 
	         errorstr = "Y";
	     }
	     catch (Exception e)
		{
			System.out.println("Error ## "+e.toString()); 		
			errorstr = "Error ## "+e.toString();
		} 
		finally
		{
		    
		}
        return txtHT;         
     }
     
     public ArrayList getAPISFltAL()
     {
         return apisfltAL;
     }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return returnstr;
    }
    
    public String getErrorStr()
    {
        return errorstr;
    }
    
    public String getSql()
    {
        return sql;
    }
    
}
