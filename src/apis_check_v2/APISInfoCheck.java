package apis_check;

import java.sql.*;

/**
 * @author CS71 Created on  2010/12/31
 */
public class APISInfoCheck
{
    //fzvvalidemp 為有效在職之組員
    //crew_base_v, crew_rank_v, crew_fleet_v 皆有效者
    private String sql ="";	
    private String returnstr ="";
    StringBuffer sb = new StringBuffer();
    HRInfo hr = new HRInfo();
    public static void main(String[] args)
    {
        APISInfoCheck apis = new APISInfoCheck();
        apis.getIndex();
        apis.checkEngName();
        apis.checkNation();
        apis.checkPassport();
        apis.check2ndDocName();
        apis.check2ndDocNation();
        apis.check2ndDoc();      
        apis.checkCHN();
        apis.checkRAT();      
        apis.checkAddr();
        apis.checkProfile();
        
        //Send Notice
        //******************************************************************************
        Email al = new Email();
        String sender = "tpecsci@cal.aero";
        String receiver = "betty.yu@china-airlines.com";        
//        String receiver ="tpeosci@email.china-airlines.com,tpeedbox@china-airlines.com,634283@china-airlines.com,huei-jen.chou@china-airlines.com,tsui-lien_li@email.china-airlines.com,jane.huang@china-airlines.com,SHI-JER_CHOU@email.china-airlines.com,si-yang.kang@china-airlines.com,day.j.h@china-airlines.com,wenchuan.tu@china-airlines.com,jameshsu@china-airlines.com,chen.kevin@china-airlines.com,ting-ming_chen@email.china-airlines.com,CHIN-SHENG_TIEN@email.china-airlines.com,wen-hsiu.huang@china-airlines.com,hsin-chieh.huang@china-airlines.com,ellen@china-airlines.com,billieliao@china-airlines.com";
        String cc = "640790@cal.aero";
//        String cc = "lee@china-airlines.com,christi@china-airlines.com,davidjen@china-airlines.com,yi-chuan.kang@china-airlines.com,pierce@china-airlines.com,tpecsci@cal.aero";
         
        String mailSubject = "CREW INFO & LICENCE INSUFFICIENT NOTICE";
        StringBuffer mailContent = new StringBuffer();
        mailContent.append("Dear all,\r\n\r\n");
        mailContent.append("以下項目為發送APIS時所需之相關資訊,\r\n");
        mailContent.append("系統將於每日十點自動檢核有效組員之相關資訊,\r\n");
        mailContent.append("Cockpit crew檢核範圍為AirCrews crew_rank & crew_base & crew_fleet 皆有效者,\r\n");
        mailContent.append("Cabin crew檢核範圍為AirCrews crew_base 有效者,\r\n");
        mailContent.append("若檢核項目有遺漏、空值或效期將於四天後失效,\r\n");
        mailContent.append("系統將列出其Empno、Name、Dept.及Base,\r\n");
        mailContent.append("請資料維護人員立即補足,謝謝.\r\n\r\n");
        mailContent.append(apis.getSB());
        System.out.println(al.sendEmail( sender,  receiver, cc, mailSubject, mailContent));
    }
    
    public void getIndex()
    {   
        sb.append("A 代表 English Name\r\n");
        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n");      
        sb.append("B 代表 1st Nation\r\n");
        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n"); 
        sb.append("C 代表 Passport\r\n");
        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n");
        sb.append("D 代表 2nd Document Name\r\n");
        sb.append("  資料來源 : Pilot --> CII.Other Nationality ; Cabin --> EG.2nd Document\r\n");   
        sb.append("E 代表 2nd Document Issue Nation\r\n");
        sb.append("  資料來源 : Pilot --> CII.Other Nationality ; Cabin --> EG.2nd Document\r\n");  
        sb.append("F 代表 2nd Document Validity\r\n");
        sb.append("  資料來源 : Pilot --> CII.Other Nationality ; Cabin --> EG.2nd Document\r\n"); 
        sb.append("G 代表 CHN VISA\r\n");
        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> AirCrews\r\n");   
        sb.append("H 代表 RAT \r\n");
        sb.append("  資料來源 : Pilot --> AirCrews\r\n"); 
        sb.append("I 代表 Resident Address INFO\r\n");
        sb.append("  資料來源 : Pilot --> FCHR ; Cabin --> 組員班表資訊網\r\n"); 
        sb.append("J 代表 Profile\r\n");
        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n");         
        sb.append("**********************************************************\r\n");
        sb.append("\r\n\r\n"); 
    }
 
//  check ename cab -> egtcbas.ename  cop-> crew_v.other_first_name  cop-> crew_v.other_surname
    public String checkEngName()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". English Name Check :\r\n");
//        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n");        
//        sb.append("  以下人員無英文名字資訊\r\n");   
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    
	    	sql = " SELECT empno, cabin FROM ( " +
	    		  " SELECT fz.empno, fz.cabin, other_first_name||' '||other_surname ename FROM fzvvalidemp fz, " +
	    		  " (SELECT staff_num, other_first_name, other_surname FROM fzdb.crew_v  " +
	    		  "  WHERE (other_first_name is not null and other_surname is not null) " +
	    		  "  and staff_num IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'PILOT')) crew_v " +
	    		  " WHERE fz.empno = crew_v.staff_num(+)  AND fz.cabin ='PILOT' " +
	    		  " UNION " +
	    		  " SELECT fz.empno empno, fz.cabin, cbas.ename ename  FROM fzvvalidemp fz, " +
	    		  " (SELECT Trim(empn) empn, ename FROM egtcbas WHERE ename is not null " +
	    		  " AND Trim(empn) IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'CABIN')) cbas " +
	    		  " WHERE fz.empno = cbas.empn(+)  AND cabin ='CABIN') " +
	    		  " WHERE ename IS NULL OR ename ='' ORDER BY cabin, empno ";
//System.out.println("ename = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("A--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	    else
	    	    {
	    	        sb.append("A--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	}
//	        sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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
    
//  check Nation cab -> egtcbas.nation  cop-> crew_v.nationality_cd
    public String checkNation()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". 1st Nation Check :\r\n");
//        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n");   
//        sb.append("  以下人員無國籍資訊\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    
	    	sql = " SELECT empno, cabin FROM ( " +
	    		  " SELECT fz.empno, fz.cabin, crew_v.nationality_cd nation FROM fzvvalidemp fz, " +
	    		  " (SELECT staff_num, nationality_cd FROM fzdb.crew_v  " +
	    		  "  WHERE Length(nationality_cd)=2  AND  nationality_cd IS NOT null " +
	    		  "  and staff_num IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'PILOT')) crew_v " +
	    		  " WHERE fz.empno = crew_v.staff_num(+)  AND fz.cabin ='PILOT' " +
	    		  " UNION " +
	    		  " SELECT fz.empno empno, fz.cabin, cbas.nation nation  FROM fzvvalidemp fz, " +
	    		  " (SELECT Trim(empn) empn, nation FROM egtcbas WHERE nation is not null " +
	    		  " AND Trim(empn) IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'CABIN')) cbas " +
	    		  " WHERE fz.empno = cbas.empn(+)  AND cabin ='CABIN') " +
	    		  " WHERE nation IS NULL OR nation ='' ORDER BY cabin, empno ";
//System.out.println("nation = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("B--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	    else
	    	    {
	    	        sb.append("B--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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

    
    //check passport 四天後到期者 or 沒有護照者
    public String checkPassport()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". Passport Check :\r\n");
//        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n");   
//        sb.append("  以下人員無護照資訊或護照效期已失效\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    
	    	sql = " SELECT empno, cabin FROM ( " +
	    		  " SELECT fz.empno, fz.cabin, pass.passport_num passport_num  FROM fzvvalidemp fz, " +
	    		  " (SELECT staff_num, passport_num FROM fzdb.crew_passport_v  WHERE SYSDATE BETWEEN eff_dt AND exp_dt-4 " +
	    		  " AND staff_num IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'PILOT')) pass " +
	    		  " WHERE fz.empno = pass.staff_num(+)  AND fz.cabin ='PILOT' " +
	    		  " UNION " +
	    		  " SELECT fz.empno empno, fz.cabin, pass.passport_num passport_num  FROM fzvvalidemp fz, " +
	    		  " (SELECT Trim(empn) empn, passport passport_num FROM egtcbas WHERE SYSDATE < passdate-4 " +
	    		  " AND Trim(empn) IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'CABIN')) pass " +
	    		  " WHERE fz.empno = pass.empn(+)  AND cabin ='CABIN') " +
	    		  " WHERE passport_num IS NULL OR passport_num ='' ORDER BY cabin, empno ";
//System.out.println("passport = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("C--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");	    	    
	    	    }
	    	    else
	    	    {
	    	        sb.append("C--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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
 
//  check 2nd Doc Name cab -> egtpass  cop-> dftpass
    public String check2ndDocName()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". 2nd Document Name Check :\r\n");
//        sb.append("  資料來源 : Pilot --> CII.Other Nationality ; Cabin --> EG.2nd Document\r\n");   
//        sb.append("  以下人員第二國籍姓名資訊不完整\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    
	    	sql = " SELECT empno, 'CABIN' cabin FROM egtpass WHERE ename IS null " +
	    		  " union SELECT empno, 'PILOT' cabin FROM dftpass WHERE fname IS NULL OR lname IS NULL ";
//System.out.println("2nd doc name = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("D--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	    else
	    	    {
	    	        sb.append("D--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
	    	
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
    
//  check 2nd Doc Nation cab -> egtpass  cop-> dftpass
    public String check2ndDocNation()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". 2nd Document Issue Nation Check :\r\n");
//        sb.append("  資料來源 : Pilot --> CII.Other Nationality ; Cabin --> EG.2nd Document\r\n");   
//        sb.append("  以下人員第二國籍名稱資訊不正確\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    
	    	sql = " SELECT * FROM (SELECT  empno, 'CABIN' cabin FROM egtpass " +
	    		  " where issue_nation IS NULL OR Length(issue_nation) <>3 union " +
	    		  " SELECT empno, 'PILOT' cabin FROM dftpass WHERE issuectry IS NULL OR Length(issuectry) <>3) " +
	    		  " order by cabin, empno ";
//System.out.println("check2ndDocNation = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("E--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	    else
	    	    {
	    	        sb.append("E--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
	    	
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
    
//  check 2nd Doc cab -> egtpass  cop-> dftpass
    public String check2ndDoc()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". 2nd Document Validity Check :\r\n");
//        sb.append("  資料來源 : Pilot --> CII.Other Nationality ; Cabin --> EG.2nd Document\r\n");   
//        sb.append("  以下人員第二國籍資訊已過期\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	
	    
	    	sql = " SELECT empno, issue_nation, doc_tp FROM egtpass " +
	    		  " WHERE (exp_date IS NULL OR exp_date - 4 < SYSDATE) " +
	    		  " AND empno IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'CABIN') ";
//System.out.println("2nd doc = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    
	    	    sb.append("F--> "+"CABIN "+ rs.getString("empno")+" "+rs.getString("issue_nation")+"  "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno")));	   
	    	   
	    	    
	    	    if("P".equals(rs.getString("doc_tp")))
	    	    {
	    	        sb.append(" PASSPORT 效期已失效\r\n");
	    	    }
	    	    
	    	    if("C".equals(rs.getString("doc_tp")))
	    	    {
	    	        sb.append(" Green Card 效期已失效\r\n");
	    	    }
	    	}
	    	
	    	sql = " SELECT empno, issuectry, doctype FROM dftpass " +
	    		  " WHERE (expdate IS NULL OR expdate - 4 < SYSDATE) " +
	    		  " AND empno IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'PILOT') ";
//System.out.println("2nd doc = "+sql);	    	
		  	rs = stmt.executeQuery(sql);
		  	while (rs.next())
		  	{
		  	    sb.append("F--> "+"PILOT "+ rs.getString("empno")+" "+rs.getString("issuectry")+"  "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno")));   
		  	    if("P".equals(rs.getString("doctype")))
		  	    {
		  	        sb.append(" PASSPORT 效期已失效\r\n");
		  	    }
		  	    
		  	    if("C".equals(rs.getString("doctype")))
		  	    {
		  	        sb.append(" GREEN CARD 效期已失效\r\n");
		  	    }
		  	}
//		  	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
	    	
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
    
    //check 台胞証 crew_licence_v licence_cd = 'CHN'
    //Just check crew_v.nationaility_cd = 'TW'
    public String checkCHN()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". CHN VISA Check :\r\n");
//        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> AirCrews\r\n");   
//        sb.append("  以下人員無台胞証資訊或台胞証效期已失效\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

	    	sql = " SELECT empno, cabin, licence_num FROM ( " +
		  		  " SELECT fz.empno, fz.cabin, chn.licence_num licence_num  FROM fzvvalidemp fz, " +
		  		  " (SELECT staff_num, licence_num FROM fzdb.crew_licence_v  WHERE licence_cd = 'CHN' " +
		  		  "  AND SYSDATE BETWEEN str_dt AND exp_dt-4 " +
		  		  "  AND staff_num IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'PILOT')) chn " +
		  		  " WHERE fz.empno = chn.staff_num(+)  AND fz.cabin ='PILOT' " +
		  		  " and fz.empno IN (SELECT staff_num FROM crew_v WHERE nationality_cd ='TW') " +
		  		  " UNION " +
		  		  " SELECT fz.empno, fz.cabin, chn.licence_num licence_num  FROM fzvvalidemp fz, " +
		  		  " (SELECT staff_num, licence_num FROM fzdb.crew_licence_v  WHERE licence_cd = 'CHN' " +
		  		  "  AND SYSDATE BETWEEN str_dt AND exp_dt-4 " +
		  		  "  AND staff_num IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'CABIN')) chn " +
		  		  " WHERE fz.empno = chn.staff_num(+)  AND fz.cabin ='CABIN' " +
		  		  " and fz.empno IN (SELECT trim(empn) FROM egtcbas WHERE nation ='1') ) " +
		  		  " WHERE licence_num IS NULL OR licence_num ='' " +
		  		  " ORDER BY cabin, empno ";	    	
	    	
//System.out.println("chn = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("G--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getUnitDsc(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	    else
	    	    {
	    	        sb.append("G--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");
	    	    }
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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
    
//  check PILOT RAT
    public String checkRAT()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". RAT Check :\r\n");
//        sb.append("  資料來源 : Pilot --> AirCrews\r\n");   
//        sb.append("  以下人員無RAT資訊或RAT效期已失效\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

	    	sql = " SELECT empno, cabin, licence_num FROM ( " +
		  		  " SELECT fz.empno, fz.cabin, chn.licence_num licence_num  FROM fzvvalidemp fz, " +
		  		  " (SELECT staff_num, licence_num FROM fzdb.crew_licence_v  WHERE licence_cd = 'RAT' " +
		  		  "  AND (exp_dt is not null and SYSDATE <= exp_dt-4) " +
		  		  "  AND licence_num is not null " +
		  		  "  AND staff_num IN (SELECT empno FROM fzvvalidemp WHERE cabin = 'PILOT')) chn " +
		  		  " WHERE fz.empno = chn.staff_num(+)  AND fz.cabin ='PILOT' " +
		  		  " and fz.empno in (select staff_num from crew_rank_v where rank_cd in ('CA','RP','FO'))) " +
		  		  " WHERE licence_num IS NULL OR licence_num ='' " +
		  		  " ORDER BY cabin, empno ";	    	
	    	
//System.out.println("rat = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    sb.append("H--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");	    	    
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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
    
//  check dfttsa.address
    public String checkAddr()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". Resident Address INFO Check :\r\n");
//        sb.append("  資料來源 : Pilot --> FCHR ; Cabin --> 組員班表資訊網\r\n");   
//        sb.append("  以下人員無出生地/居住地址資訊或出生地/居住地址資訊不完整\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

	    	sql = " SELECT * FROM fzvvalidemp WHERE empno NOT IN " +
  		  		  " (SELECT empno FROM dfttsa WHERE resicity IS NOT NULL AND Length(resicity) =3 " +
  		  		  " and birthcity is not null AND resiaddr1 IS NOT null AND resiaddr2 IS NOT null " +
  		  		  " AND resiaddr4 IS NOT null AND resiaddr5 IS NOT NULL ) " +
  		  		  " order by cabin, empno";
//System.out.println("addr = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    sb.append("I--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");    	    
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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
    
//  check crew profile
    public String checkProfile()
    {   
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
//        sb.append(seq+". Profile Check :\r\n");
//        sb.append("  資料來源 : Pilot --> AirCrews ; Cabin --> EG\r\n"); 
//        sb.append("  以下人員性別、生日、出生地資訊不完整\r\n");        
        
       try
       {
	        DBConn cn = new DBConn();
	        cn.setORP3FZUser();
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
	    	stmt = conn.createStatement();	

	    	sql = " SELECT * FROM fzvvalidemp WHERE empno NOT IN ( SELECT Trim(empn) empno FROM egtcbas " +
	    		  " WHERE birth IS NOT NULL AND sex IS NOT null AND bplace_en IS NOT NULL AND Length(bplace_en)=3 " +
	    		  " UNION SELECT staff_num empno FROM crew_v WHERE birth_dt IS NOT NULL AND sex IS NOT NULL " +
	    		  " AND birth_country IS NOT NULL AND Length(birth_country)=3 ) " +
		  		  " ORDER BY cabin, empno ";	   
	    	
//System.out.println("profile = "+sql);	    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    if("CABIN".equals(rs.getString("cabin")))
	    	    {
	    	        sb.append("J--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");	    	    
	    	    }
	    	    else
	    	    {
	    	        sb.append("J--> "+rs.getString("cabin")+"  "+rs.getString("empno")+" "+hr.getCname(rs.getString("empno"))+" "+hr.getRank(rs.getString("empno"))+" "+hr.getFleet(rs.getString("empno"))+" "+hr.getBase(rs.getString("empno"))+"\r\n");    
	    	    }
	    	  
	    	}
//	    	sb.append("**********************************************************\r\n");  
//	    	sb.append("\r\n");
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
    
    public StringBuffer getSB()
    {
        return sb;
    }
      
}
