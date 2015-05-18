package fz.pracP.dispatch;

import java.sql.*;
import ci.db.*;
/**
 * @author cs71 Created on  2008/12/1
 */
public class FlexibleDispatch
{

    public static void main(String[] args)
    {
//        System.out.println(Math.round(257*0.4));
//        System.out.println((int)Math.floor(257*0.4));
        FlexibleDispatch fd = new FlexibleDispatch();
//        fd.getLong_range("2010/04/21","0072","DELTPE", "631958") ;
//    	String tempstr = fd.getLongRang();
//    	System.out.println(tempstr);
//        System.out.println(" 是否彈派 "+fd.ifFlexibleDispatch("2010/04/18","0903","TPEHKG","625302"));
//        System.out.println(fd.getFlexibleNum("0903", "744", "TPEHKG", 245)); 
//        System.out.println(fd.getPRCabinCrewNum("2010/04/18","0903","TPEHKG"));
//        fd.getLong_range("2010/04/18","0903","TPEHKG","625302") ;
//        System.out.println(fd.getI13Count("2010/04/18","0903","TPEHKG"));
//        System.out.println(fd.getACMCount("2010/04/18","0903","TPEHKG"));
//        System.out.println(fd.isFerry("2010/04/18","0903","TPEHKG"));
//        System.out.println(fd.getFleetCd());
//        fd.getLong_range("2010/04/18","0903","TPEHKG","625302");
//        System.out.println(fd.getLongRang());
//        System.out.println(fd.getDa13_Fleet_cd("2010/04/18","0903","TPEHKG") );
        
        
//        System.out.println(fd.getAOCICabinCrewNum("2010/04/18","0903","TPEHKG"));
////      get pax ?H??
//    	int pax_count = fd.getPaxCount("2010/04/18","0903","TPEHKG"); 
//    	System.out.println("pax_count "+pax_count);
////    	//get ?u???H??
//    	int disp_count = fd.getFlexibleNum("0903", "744", pax_count) ;
//    	System.out.println("disp_count "+disp_count);
////    	//get ACM ?H??
//    	int acm_count = fd.getACMCount("2010/04/18","0903","TPEHKG") ;
//    	System.out.println("acm_count "+acm_count);
//    	boolean iflessdisp_pass ; 
//    	if(disp_count == acm_count | pax_count <=0 )
//    	{
//    		iflessdisp_pass = true;
//    	}
        System.out.println(fd.getDa13_Fleet_cd("2012/10/06","0112","TPEHIJ"));
        System.out.println("Done");
    }
    
    private String long_range = "N";
    private String fleet_cd = "";   
    
    public boolean ifFlexibleDispatch(String fltd, String fltno, String sect, String empno)   
    {
        String tempfltno = "";
        String tempfleet = "";
        if(fltno.length()>= 4)
        {
        	tempfltno = fltno.substring(1,4);
        }
        else
        {
        	tempfltno = fltno;
        }

        getLong_range(fltd, fltno, sect, empno);    
        
        if("Y".equals(getLongRang()))
        {//長班不實施
        	return false;
        }   
//        else if (!fltno.equals("0025") && !fltno.equals("0026") && !fltno.equals("0027") && !fltno.equals("0028") && fltno.substring(0,2).equals("00"))
//        {//越洋班不實施
//            return false;
//        }
        else if (("73A".equals(getFleetCd()) | "738".equals(getFleetCd())) && (sect.indexOf("GUM") >= 0 | sect.indexOf("ROR") >= 0 | sect.indexOf("KUA") >= 0 | sect.indexOf("HKT") >= 0))
        {//越洋班不實施 SR2050
            return false;
        }
        else if ("TPEKHH".equals(sect) | "KHHTPE".equals(sect) | "KHHTSA".equals(sect) | "TSAKHH".equals(sect))
        {//國內接駁線不實施 SR2050
            return false;
        }
//        else if ("73A".equals(getFleetCd()))
//        {
//            return false;
//        }
//        else  if ("738".equals(getFleetCd()) && ( "791".equals(tempfltno) | "792".equals(tempfltno) | "112".equals(tempfltno) | "113".equals(tempfltno) | "731".equals(tempfltno) | "732".equals(tempfltno) | "751".equals(tempfltno) | "752".equals(tempfltno) | "721".equals(tempfltno) | "722".equals(tempfltno)))
//        {
//            return false;
//        }
//        else if ("N".equals(getLongRang()) && ("HKG".equals(sect.substring(0,3)) | "HKG".equals(sect.substring(3))))
//        {// SR9019
//            return false;
//        }
        
        else 
        {
            if(isFerry(fltd, fltno, sect) == true)
            {
                return false;
            }
            
            int aocicrewnum = getAOCICabinCrewNum(fltd, fltno, sect) ;
            int prcrewnum = getPRCabinCrewNum(fltd, fltno, sect) ;
            int crewnum = 0;
            if(prcrewnum == 0)
            {
                crewnum = aocicrewnum;
            }
            else
            {
                crewnum = prcrewnum + 1;
            }
            
//          if(("744".equals(getFleetCd()) | "74A".equals(getFleetCd()) | "74B".equals(getFleetCd())) && crewnum <= 13)
            if(("744".equals(getFleetCd()) | "74A".equals(getFleetCd()) | "74B".equals(getFleetCd()) | "74C".equals(getFleetCd())) && crewnum < 13)
            {
                return false;
            }
//            else if(("33A".equals(getFleetCd()) | "333".equals(getFleetCd()) | "343".equals(getFleetCd())) && crewnum <= 9)
            else if(("33A".equals(getFleetCd()) | "333".equals(getFleetCd()) | "343".equals(getFleetCd())) && crewnum < 9)
            {
                return false;
            }  
            
//            else if("738".equals(getFleetCd()) && ("ROR".equals(sect.substring(0,3)) | "GUM".equals(sect.substring(0,3)) | "KUA".equals(sect.substring(0,3)) | "OBO".equals(sect.substring(0,3)) | "ROR".equals(sect.substring(3)) | "GUM".equals(sect.substring(3)) | "KUA".equals(sect.substring(3)) | "OBO".equals(sect.substring(3))) && crewnum <= 6)
//            {
//                return false;
//            }
            else if(("73A".equals(getFleetCd()) | "738".equals(getFleetCd())) && crewnum <= 5)
            {
                return false;
            }                  
        }       
        return true;
	}
    
    public boolean ifFlexibleDispatch2 (String fltd, String fltno, String sect, String empno)   
    {//For display 彈派參考表
        String tempfltno = "";
        String tempfleet = "";
        if(fltno.length()>= 4)
        {
        	tempfltno = fltno.substring(1,4);
        }
        else
        {
        	tempfltno = fltno;
        }

        getLong_range(fltd, fltno, sect, empno);         
        if("Y".equals(getLongRang()))
        {//長班不實施
        	return false;
        }   
//        else if (!fltno.equals("0025") && !fltno.equals("0026") && !fltno.equals("0027") && !fltno.equals("0028") && fltno.substring(0,2).equals("00"))
//        {//越洋班不實施
//            return false;
//        }
        else if (("73A".equals(getFleetCd()) | "738".equals(getFleetCd())) && (sect.indexOf("GUM") >= 0 | sect.indexOf("ROR") >= 0 | sect.indexOf("KUA") >= 0 | sect.indexOf("HKT") >= 0))
        {//越洋班不實施 SR2050
            return false;
        }
        else if ("TPEKHH".equals(sect) | "KHHTPE".equals(sect) | "KHHTSA".equals(sect) | "TSAKHH".equals(sect))
        {//國內接駁線不實施 SR2050
            return false;
        }
//        else if ("73A".equals(getFleetCd()))
//        {
//            return false;
//        }
//        else  if ("738".equals(getFleetCd()) && ( "791".equals(tempfltno) | "792".equals(tempfltno) | "112".equals(tempfltno) | "113".equals(tempfltno) | "731".equals(tempfltno) | "732".equals(tempfltno) | "751".equals(tempfltno) | "752".equals(tempfltno) | "721".equals(tempfltno) | "722".equals(tempfltno)))
//        {
//            return false;
//        }
//        else if ("N".equals(getLongRang()) && ("HKG".equals(sect.substring(0,3)) | "HKG".equals(sect.substring(3))))
//        {// SR9019
//            return false;
//        }
        else 
        {
            if(isFerry(fltd, fltno, sect) == true)
            {
                return false;
            }
            
            int aocicrewnum = getAOCICabinCrewNum(fltd, fltno, sect) ;
            int prcrewnum = getPRCabinCrewNum(fltd, fltno, sect) ;
            int crewnum = 0;
            if(prcrewnum == 0)
            {
                crewnum = aocicrewnum;
            }
            else
            {
                crewnum = prcrewnum ;
            }
            
            if(("744".equals(getFleetCd()) | "74A".equals(getFleetCd()) | "74B".equals(getFleetCd()) | "74C".equals(getFleetCd())) && crewnum < 13)
            {
                return false;
            }
            else if(("33A".equals(getFleetCd()) | "333".equals(getFleetCd()) | "343".equals(getFleetCd())) && crewnum < 9)
            {
                return false;
            }   
//            else if("738".equals(getFleetCd()) && ("ROR".equals(sect.substring(0,3)) | "GUM".equals(sect.substring(0,3)) | "KUA".equals(sect.substring(0,3)) | "OBO".equals(sect.substring(0,3)) | "ROR".equals(sect.substring(3)) | "GUM".equals(sect.substring(3)) | "KUA".equals(sect.substring(3)) | "OBO".equals(sect.substring(3))) && crewnum <= 6)
//            {
//                return false;
//            }
            else if(("73A".equals(getFleetCd()) | "738".equals(getFleetCd())) && crewnum <= 5)
            {
                return false;
            }                  
        }       
        return true;
	}
    
    public void getLong_range(String fltd, String fltno, String sect, String empno ) 
    {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		
		try 
		{
		    ConnDB cn = new ConnDB();
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//			 cn.setAOCIPROD();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = " select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno," +
				  " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, " +
				  " dps.duty_cd dutycd, dps.port_a dpt,dps.port_b arv,r.acting_rank qual, " +
				  " dps.fleet_cd fleet_cd, lr.long_range long_range " +
				  " from duty_prd_seg_v dps, roster_v r, series_v lr " +
				  " where dps.series_num=r.series_num AND dps.series_num = lr.series_num " +
				  " and dps.delete_ind = 'N' AND  r.delete_ind='N' and dps.flt_num = '"+fltno+"' " +
				  " and dps.act_str_dt_tm_gmt BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi')+1 " +
				  " AND dps.port_a = '"+sect.substring(0,3)+"' " +
				  " AND dps.port_b = '"+sect.substring(3)+"' AND dps.duty_cd in ('FLY','TVL') " +
				  " AND r.staff_num ='"+empno+"'";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while (rs.next()) 
			{
			    long_range = rs.getString("long_range");   
			    fleet_cd = rs.getString("fleet_cd");   				
			}
			
			//2010/01/25 新增********************************************************
			String temp_da13_fleet = getDa13_Fleet_cd(fltd, fltno, sect);
			
			if(!temp_da13_fleet.equals(fleet_cd) && !"".equals(temp_da13_fleet))
			{
			    fleet_cd = temp_da13_fleet;
			}
			//**********************************************************************
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
	}
    
    public String getDa13_Fleet_cd(String fltd, String fltno, String sect) 
    {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		String da13_fleet_cd = "";
		
		try 
		{
		    ConnDB cn = new ConnDB();
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);
//		    stmt = conn.createStatement();

			 cn.setAOCIPRODFZUser();
			 java.lang.Class.forName(cn.getDriver());
			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
			 stmt = conn.createStatement();
			
			sql = " SELECT da13_actp FROM v_ittda13_ci WHERE da13_fltno = '"+fltno+"' " +
				  " AND da13_fm_sector = '"+sect.substring(0,3)+"' AND da13_to_sector = '"+sect.substring(3)+"' " +
				  " AND da13_scdate_u+(8/24) BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') ";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while (rs.next()) 
			{			   
			    da13_fleet_cd = rs.getString("da13_actp");   				
			}
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		return da13_fleet_cd;
	}
    
    public int getAOCICabinCrewNum(String fltd, String fltno, String sect) 
    {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		int num = 0;
		
		try 
		{
		    ConnDB cn = new ConnDB();
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//			 cn.setAOCIPRODFZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = "  select Count(*) c " +
//	 r.staff_num, to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno, 
//   to_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt,  dps.duty_cd dutycd, dps.port_a dpt,dps.port_b arv,
//   r.acting_rank qual,  dps.fleet_cd fleet_cd 
				 " from duty_prd_seg_v dps, roster_v r " +
				 " where dps.series_num=r.series_num " +
				 " and dps.flt_num = '"+fltno+"' and dps.delete_ind = 'N' AND  r.delete_ind='N' " +
				 " and dps.act_str_dt_tm_gmt BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
				 " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') " +
				 " AND dps.port_a = '"+sect.substring(0,3)+"'  AND dps.port_b = '"+sect.substring(3)+"' " +
				 " AND dps.duty_cd = 'FLY' AND dps.fd_ind = 'N' " +
				 " and ( r.special_indicator not in ('P','I','S','T') OR r.special_indicator IS NULL )";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			if (rs.next()) 
			{
			    num = rs.getInt("c");
			}			
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());		   
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		
		return num;
	}
    
    public int getPRCabinCrewNum(String fltd, String fltno, String sect) 
    {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		int num = 0;
		
		try 
		{
		    ConnDB cn = new ConnDB();
		    cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//		     cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = "  SELECT * FROM egtcflt WHERE fltd =To_Date('"+fltd+"','yyyy/mm/dd')  " +
			      " AND fltno = '"+fltno+"' AND sect = '"+sect+"'";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) 
			{
			    for(int i = 1; i <=20; i++)
			    {
			        if(rs.getString("empn"+i) != null && !"".equals(rs.getString("empn"+i)) && !"000000".equals(rs.getString("empn"+i)))
			        {
			            num++;
			        }
			    }
			}			
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());		   
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		
		return num;
	}
    
    public String getLongRang() 
    {
        return long_range;
    }
    
    public String getFleetCd() 
    {
        return fleet_cd;
    }
    
    public int getConfig(String fleet) 
    {
        int cfg =0;
        
        if("74A".equals(fleet))
        {
            cfg = 411;
        }
        else if("744".equals(fleet))
        {
            cfg = 397;
        }
        else if("74B".equals(fleet))
        {
            cfg = 390;
        }
        else if("74C".equals(fleet))
        {
            cfg = 375;
        }
        else if("343".equals(fleet))
        {
            cfg = 276;
        }
        else if("34B".equals(fleet)|"AB6".equals(fleet))
        {
            cfg = 265;
        }
        else if("738".equals(fleet))
        {
            cfg = 158;
        }
        else if("333".equals(fleet))
        {
            cfg = 313;
        }
        else if("33A".equals(fleet))
        {
            cfg = 307;
        }
        else if("73A".equals(fleet))
        {
            cfg = 168;
        }        
        
        return cfg;
    }

    public int getFlexibleNum(String fltno, String fleet, int passengernum) 
    {
        int num =0;
        int cfg = getConfig(fleet); 
               
        if(("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd())) && ((int)Math.floor(cfg*0.6) > passengernum))
        {
            num = 1;
        }
        else if( (int)Math.floor(cfg*0.4) > passengernum)
        {
            num = 2;
        }
        else if( (int)Math.floor(cfg*0.6) > passengernum)
        {
            num = 1;
        }

        return num;
    }
    
    public int getFlexibleNum_20120206(String fltno, String fleet, String sect, int passengernum) 
    {
        int num =0;
        int cfg = getConfig(fleet); 
        String tempfltno = "0"+fltno.substring(1,4);  
        sect = sect.substring(0,3)+"/"+sect.substring(3);
        //System.out.println(sect);
        
        // PVG  上海 PEK  北京 CAN  廣州 CTU  成都 NKG  南京 XMN 廈門 SHE   瀋陽
        // CSX  長沙 SZX  深圳 XIY  西安 HGH  杭州 NGB  寧波 CGO 鄭州  

        if((sect.indexOf("OKA") >= 0 | sect.indexOf("MNL") >= 0 | sect.indexOf("PVG") >= 0 | sect.indexOf("PEK") >= 0 | sect.indexOf("CAN") >= 0 | sect.indexOf("CTU") >= 0 | sect.indexOf("KMG") >= 0 | sect.indexOf("CKG") >= 0 | sect.indexOf("NKG") >= 0 | sect.indexOf("XMN") >= 0 | sect.indexOf("SHE") >= 0 | sect.indexOf("CSX") >= 0 | sect.indexOf("SZX") >= 0 | sect.indexOf("NGB") >= 0 | sect.indexOf("HGH") >= 0 | sect.indexOf("CGO") >= 0 | sect.indexOf("XIY") >= 0 | sect.indexOf("SHA") >= 0 | sect.indexOf("DLC") >= 0 | sect.indexOf("TAO") >= 0 | sect.indexOf("FOC") >= 0 | sect.indexOf("WNZ") >= 0 | sect.indexOf("YNZ") >= 0 | sect.indexOf("KHN") >= 0 | sect.indexOf("SYX") >= 0 | sect.indexOf("HAK") >= 0 | sect.indexOf("WUH") >= 0 | sect.indexOf("WUX") >= 0 | sect.indexOf("HIJ") >= 0) | (sect.indexOf("HKG") >= 0 && (!"641".equals(fltno.substring(1,4)) && !"642".equals(fltno.substring(1,4)) && !"643".equals(fltno.substring(1,4)) && !"644".equals(fltno.substring(1,4)) && !"763".equals(fltno.substring(1,4)) && !"764".equals(fltno.substring(1,4)) && !"831".equals(fltno.substring(1,4)) &&  !"679".equals(fltno.substring(1,4)) && !"680".equals(fltno.substring(1,4)) )) ) 
        {
            //2010/01/18  改回
            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            //2009/09/14  修改
//            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()) | "0605".equals(fltno) | "0606".equals(fltno))
            {
                if ((int)Math.floor(cfg*0.6) > passengernum)
                {
                    num = 1;
                }
            } 
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 3;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.8) > passengernum)
            {
                num = 1;
            }
        }
        else
        {
            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            {
                if ((int)Math.floor(cfg*0.6) > passengernum)
                {
                    num = 1;
                }
            } 
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 1;
            }                 
        }       
   
        return num;
    }
    
    public int getFlexibleNum_SR2050(String fltno, String fleet, String sect, int passengernum) 
    {
        int num =0;
        int cfg = getConfig(fleet); 
        String tempfltno = "0"+fltno.substring(1,4);  
        sect = sect.substring(0,3)+"/"+sect.substring(3);
        //System.out.println(sect);
        
        // PVG  上海 PEK  北京 CAN  廣州 CTU  成都 NKG  南京 XMN 廈門 SHE   瀋陽
        // CSX  長沙 SZX  深圳 XIY  西安 HGH  杭州 NGB  寧波 CGO 鄭州  

        if(sect.indexOf("OKA") >= 0) 
        {
            //2010/01/18  改回
            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            //2009/09/14  修改
//            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()) | "0605".equals(fltno) | "0606".equals(fltno))
            {
                if ((int)Math.floor(cfg*0.6) > passengernum)
                {
                    num = 1;
                }
            } 
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 3;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.8) > passengernum)
            {
                num = 1;
            }
        } 
        else if((sect.indexOf("MNL") >= 0 | sect.indexOf("PVG") >= 0 | sect.indexOf("PEK") >= 0 | sect.indexOf("CAN") >= 0 | sect.indexOf("CTU") >= 0 | sect.indexOf("KMG") >= 0 | sect.indexOf("CKG") >= 0 | sect.indexOf("NKG") >= 0 | sect.indexOf("XMN") >= 0 | sect.indexOf("SHE") >= 0 | sect.indexOf("CSX") >= 0 | sect.indexOf("SZX") >= 0 | sect.indexOf("NGB") >= 0 | sect.indexOf("HGH") >= 0 | sect.indexOf("CGO") >= 0 | sect.indexOf("XIY") >= 0 | sect.indexOf("SHA") >= 0 | sect.indexOf("DLC") >= 0 | sect.indexOf("TAO") >= 0 | sect.indexOf("FOC") >= 0 | sect.indexOf("WNZ") >= 0 | sect.indexOf("YNZ") >= 0 | sect.indexOf("KHN") >= 0 | sect.indexOf("SYX") >= 0 | sect.indexOf("HAK") >= 0 | sect.indexOf("WUH") >= 0 | sect.indexOf("WUX") >= 0 | sect.indexOf("HIJ") >= 0) | (sect.indexOf("HKG") >= 0 && (!"641".equals(fltno.substring(1,4)) && !"642".equals(fltno.substring(1,4)) && !"643".equals(fltno.substring(1,4)) && !"644".equals(fltno.substring(1,4)) && !"763".equals(fltno.substring(1,4)) && !"764".equals(fltno.substring(1,4)) && !"831".equals(fltno.substring(1,4)) &&  !"679".equals(fltno.substring(1,4)) && !"680".equals(fltno.substring(1,4)) )) ) 
        {
            //2010/01/18  改回
            //if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            //2009/09/14  修改
//            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()) | "0605".equals(fltno) | "0606".equals(fltno))
            //2012/02/06  修改
            if("74A".equals(getFleetCd()) | "74B".equals(getFleetCd()) |  "744".equals(getFleetCd()))
            {//大陸、香港以744機型派飛時，維持旅客人數低於80%開始彈派。
                if ((int)Math.floor(cfg*0.8) > passengernum)
                {
                    num = 1;
                }
            } //大陸、香港、馬尼拉，旅客人數低於60%才開始彈派。
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 1;
            }
        }
        else
        {
            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            {
                if ((int)Math.floor(cfg*0.6) > passengernum)
                {
                    num = 1;
                }
            } 
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 1;
            }                 
        }

        return num;
    }
    
    //SR2050
    public int getFlexibleNum(String fltno, String fleet, String sect, int passengernum) 
    {
        int num =0;
        int cfg = getConfig(fleet); 
        String tempfltno = "0"+fltno.substring(1,4);  
        sect = sect.substring(0,3)+"/"+sect.substring(3);
        //System.out.println(sect);
        
        // PVG  上海 PEK  北京 CAN  廣州 CTU  成都 NKG  南京 XMN 廈門 SHE   瀋陽
        // CSX  長沙 SZX  深圳 XIY  西安 HGH  杭州 NGB  寧波 CGO 鄭州  

        if(sect.indexOf("OKA") >= 0) 
        {
            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            {
                if ((int)Math.floor(cfg*0.6) > passengernum)
                {
                    num = 1;
                }
            } 
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 3;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.8) > passengernum)
            {
                num = 1;
            }
        }
        else if(((sect.indexOf("PVG") >= 0 | sect.indexOf("PEK") >= 0 | sect.indexOf("CAN") >= 0 | sect.indexOf("CTU") >= 0 | sect.indexOf("KMG") >= 0 | sect.indexOf("CKG") >= 0 | sect.indexOf("NKG") >= 0 | sect.indexOf("XMN") >= 0 | sect.indexOf("SHE") >= 0 | sect.indexOf("CSX") >= 0 | sect.indexOf("SZX") >= 0 | sect.indexOf("NGB") >= 0 | sect.indexOf("HGH") >= 0 | sect.indexOf("CGO") >= 0 | sect.indexOf("XIY") >= 0 | sect.indexOf("SHA") >= 0 | sect.indexOf("DLC") >= 0 | sect.indexOf("TAO") >= 0 | sect.indexOf("FOC") >= 0 | sect.indexOf("WNZ") >= 0 | sect.indexOf("YNZ") >= 0 | sect.indexOf("KHN") >= 0 | sect.indexOf("SYX") >= 0 | sect.indexOf("HAK") >= 0 | sect.indexOf("WUH") >= 0 | sect.indexOf("WUX") >= 0 | sect.indexOf("HIJ") >= 0) | (sect.indexOf("HKG") >= 0 && (!"641".equals(fltno.substring(1,4)) && !"642".equals(fltno.substring(1,4)) && !"643".equals(fltno.substring(1,4)) && !"644".equals(fltno.substring(1,4)) && !"763".equals(fltno.substring(1,4)) && !"764".equals(fltno.substring(1,4)) && !"831".equals(fltno.substring(1,4)) &&  !"679".equals(fltno.substring(1,4)) && !"680".equals(fltno.substring(1,4)) ))) && ("74A".equals(getFleetCd()) | "74B".equals(getFleetCd()) |  "744".equals(getFleetCd()) | "343".equals(getFleetCd()) | "34A".equals(getFleetCd()) |  "34B".equals(getFleetCd()))) 
        {//大陸、香港線,不包含transfer flt 且 以74*/34*機型派飛時            
            if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 3;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.8) > passengernum)
            {
                num = 1;
            }
        }
        else
        {//others
            //以73*機型派飛時
            if("73A".equals(getFleetCd()) | "738".equals(getFleetCd()) |  "73B".equals(getFleetCd()))
            {
                if ((int)Math.floor(cfg*0.6) > passengernum)
                {
                    num = 1;
                }
            } 
            else  if( (int)Math.floor(cfg*0.4) > passengernum)
            {
                num = 2;
            }
            else if( (int)Math.floor(cfg*0.6) > passengernum)
            {
                num = 1;
            }                 
        }

        return num;
    }
    
    public int getI13Count(String fltd, String fltno, String sect) 
    {
        int i13count =0; 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		
		try 
		{
		    ConnDB cn = new ConnDB();
		    cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//		     cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = " select Count(*) c from egtcmdt where fltno='"+fltno+"' " +
				  " and fltd=to_date('"+fltd+"','yyyy/mm/dd') and sect='"+sect+"' " +
				  " AND itemno in ('I13','I01') ";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while (rs.next()) 
			{
			    i13count = rs.getInt("c");			
			}
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		return i13count;
	}
    
    public int getACMCount(String fltd, String fltno, String sect) 
    {
        int acmcount =0; 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		
		try 
		{
		    ConnDB cn = new ConnDB();
		    cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//		     cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = " select * from egtcflt where fltno='"+fltno+"' " +
				  " and fltd=to_date('"+fltd+"','yyyy/mm/dd') and sect='"+sect+"' ";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while (rs.next()) 
			{
			    for(int i=1; i<=20; i++)
			    {
			        
			        //20120308 空管email 取消ACM 改以統計DFA
//			        if("ACM".equals(rs.getString("duty"+i)))
//			        {
//			            acmcount ++;
//			        }
			        
			        if("DFA".equals(rs.getString("duty"+i)))
			        {
			            acmcount ++;
			        }
			    }
			    
			}
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		return acmcount;
	}
    
    public int getPaxCount(String fltd, String fltno, String sect) 
    {
        int paxcount =0; 
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		
		try 
		{
		    ConnDB cn = new ConnDB();
		    cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//		     cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = " select Nvl(pxac,0) pxac from egtcflt where fltno='"+fltno+"' " +
				  " and fltd=to_date('"+fltd+"','yyyy/mm/dd') and sect='"+sect+"' ";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while (rs.next()) 
			{
			    paxcount = rs.getInt("pxac");			
			}
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		return paxcount;
	}
    
    public boolean isFerry(String fltd, String fltno, String sect) 
    {
        boolean isferry = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;		
		Driver dbDriver = null;
		
		try 
		{
		    ConnDB cn = new ConnDB();
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
		    stmt = conn.createStatement();

//			 cn.setAOCIPRODFZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//			 stmt = conn.createStatement();
			
			sql = " select Count(*) c from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num " +
				  " and dps.delete_ind = 'N' AND  r.delete_ind='N' and (dps.flt_num = '"+fltno+"' or dps.flt_num = SubStr('"+fltno+"',1,4) )" +
				  " and (dps.act_str_dt_tm_gmt BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi') " +
				  " or dps.str_dt_tm_loc BETWEEN to_date('"+fltd+" 00:00','yyyy/mm/dd hh24:mi') " +
				  " AND To_Date('"+fltd+" 23:59','yyyy/mm/dd hh24:mi')) " +
				  " AND dps.port_a = '"+sect.substring(0,3)+"' " +
				  " AND dps.port_b = '"+sect.substring(3)+"' AND dps.duty_cd='FLY' AND  r.acting_rank='PR' ";

//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			if (rs.next()) 
			{
			    int c = rs.getInt("c");
			    if(c<=0)
			    {
			        isferry = true;
			    }
			}
	    } 
		catch (Exception e) 
	    {
		    System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
		return isferry;
	}
}
