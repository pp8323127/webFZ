package eg.crewbasic;

import java.sql.*;
import java.util.ArrayList;

import ci.db.*;


public class AirToEG {

	/**
	 * @author cs80
	 */
	
	private Connection conn = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;	
	private String sql = null;
	private String sql2 = null;
	private String returnstr = "";
	ArrayList objAL = new ArrayList();
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		AirToEG visa = new AirToEG();
		visa.AirCrewPassPortToEG();
		String passprot = visa.returnstr;
		visa.AirCrewVisaToEG();
		String Usa = visa.returnstr;
		System.out.println("done");
		
	}
	public void AirCrewPassPortToEG(){//Passport
	    Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;    
        Driver dbDriver = null;
        int count = 0;
		 try
	        {      
		         EGConnDB cn = new EGConnDB();  
	            cn.setORP3EGUser();
//	            cn.setORT1EG(); //test
	    		java.lang.Class.forName(cn.getDriver());
	    		conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
	    		stmt = conn.createStatement();
			

             
             stmt = conn.createStatement();
				
	    		sql2 =  " UPDATE egdb.egtcbas cb set " +
	    				" cb.passport = ?, " +//PPT no
	    				" cb.Docissdate_app = to_date (?,'yyyy/mm/dd'), " +  //PPT Issue Date
	    				" cb.passdate = to_date (?,'yyyy/mm/dd') " +//PPT Expiry Date     to_date('2019/12/01','yyyy/mm/dd')
	    				//",cb.visadate = to_date(?,'yyyy/mm/dd') " +//USA Visa Expiry     to_date('2019/12/01','yyyy/mm/dd')
	    				" WHERE trim(empn) =  ? ";
	    		
//	    		System.out.println(sql2);
	    		pstmt = conn.prepareStatement(sql2);
	    		
	    		sql = " SELECT STAFF_NUM,PASSPORT_NUM,to_char(EFF_DT,'yyyy/mm/dd') EFF_DT,to_char(EXP_DT,'yyyy/mm/dd') EXP_DT " +
	    			  " FROM egdb.crew_passport_v ,egdb.egtcbas cb " +
	    			  " WHERE exp_dt is not null " +  //" -- = '641561'" +AND ctry_Cd = 'TW' 
	    			  " AND STAFF_NUM IN (SELECT Trim(empn) FROM egdb.egtcbas where status in ('1','2')) " +
	    			  " AND STAFF_NUM = Trim(cb.empn) " +
	    			  " AND (PASSPORT_NUM <> cb.passport " +
	    			  "     or to_char(EFF_DT, 'yyyy/mm/dd')  <> to_char(cb.docissdate_app, 'yyyy/mm/dd')  " +
	    			  "     or to_char(EXP_DT, 'yyyy/mm/dd')  <> to_char(cb.passdate, 'yyyy/mm/dd')  " +
	    			  "		or cb.passport is null or cb.docissdate_app is null or cb.passdate is null ) ";
	    				
//	    		System.out.println(sql);
	    		rs = stmt.executeQuery(sql);    		
//	    		int count = 0;
	    		 while (rs.next()) 
	             {
//	    			 count++;
//	    			 System.out.println(count+":");
//	    			 System.out.println(rs.getString("PASSPORT_NUM"));
//	    		     System.out.println(rs.getString("EFF_DT").substring(0,10).replace("-", "/"));
//	    		     System.out.println(rs.getString("EXP_DT").substring(0,10).replace("-", "/"));	    		     
//	    		     System.out.println(rs.getString("STAFF_NUM"));	    		     
	    		     
	    		      pstmt.setString(1, rs.getString("PASSPORT_NUM"));
		              pstmt.setString(2, rs.getString("EFF_DT").substring(0,10).replaceAll("-", "/"));
		              pstmt.setString(3, rs.getString("EXP_DT").substring(0,10).replaceAll("-", "/"));  
		              pstmt.setString(4, rs.getString("STAFF_NUM"));
		              pstmt.executeUpdate();
	    		 } 
	    		 returnstr = "Y";
	        }
		 	catch (SQLException e) 
	        {
	            System.out.print(e.toString());
	            returnstr = e.toString();
	        }
	        catch (Exception e)
	        {
	        	System.out.print(e.toString());
	        	returnstr = e.toString();
	        }
	        finally
	        {	
	        	
	            try{if(rs != null) rs.close();}catch (Exception e){}
	        	try{if(stmt != null) stmt.close();}catch (Exception e){}
	        	try{if(pstmt != null) pstmt.close();}catch (Exception e){}
	        	try{if(conn != null) conn.close();}catch (Exception e){}        	
	        }	
		
	}
	
	public void AirCrewVisaToEG(){//Visa
	    Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;    
        Driver dbDriver = null;
        int count = 0;
		try
        {      
		    EGConnDB cn = new EGConnDB();  	
		    cn.setORP3EGUser();
//            cn.setORT1EG(); //test
    		java.lang.Class.forName(cn.getDriver());
    		conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
    		stmt = conn.createStatement();	
		    
    		sql2 =  " UPDATE egdb.egtcbas cb set " +
    				" cb.visadate = to_date(?,'yyyy/mm/dd') " +//USA Visa Expiry     to_date('2019/12/01','yyyy/mm/dd')
    				" WHERE trim(empn) =  ? ";
    		
//    		System.out.println(sql2);
    		pstmt = conn.prepareStatement(sql2);
    		
    		sql = " SELECT STAFF_NUM,VISA_TYPE,to_char(ISSUE_DT,'yyyy/mm/dd') ISSUE_DT ,to_char(EXP_DT,'yyyy/mm/dd') EXP_DT  " +
    			  " FROM egdb.crew_visa_v ,egdb.egtcbas cb " +
    			  " WHERE VISA_TYPE = 'USD' AND CTRY_CD = 'US' AND exp_dt is not null " +	//" AND  STAFF_NUM = '633020' " +
    			  " AND STAFF_NUM IN (SELECT Trim(empn) FROM egdb.egtcbas where status in ('1','2'))" + 
    			  " AND STAFF_NUM = Trim(cb.empn)" +
    			  " AND (to_char(EXP_DT, 'yyyy/mm/dd') <> to_char(cb.VISADATE, 'yyyy/mm/dd') " +
    			  "      or cb.VISADATE is null ) ";  				
    				    		
//    		System.out.println(sql);
    		rs = stmt.executeQuery(sql);    		
//    		int count = 0;
    		 while (rs.next()) 
             {
//    			 count++;
//    			 System.out.println(count+":");
//    		     System.out.println(rs.getString("EXP_DT").substring(0,10).replace("-", "/"));
//    		     System.out.println(rs.getString("STAFF_NUM"));	    	
    		     
	              pstmt.setString(1, rs.getString("EXP_DT").substring(0,10).replaceAll("-", "/"));  
	              pstmt.setString(2, rs.getString("STAFF_NUM"));
	              pstmt.executeUpdate();   	              
    		 } 
    		 returnstr = "Y";
        }
		catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnstr = e.toString();
        }
        catch (Exception e)
        {
        	System.out.print(e.toString());
        	returnstr = e.toString();
        }
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(pstmt != null) pstmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }	
		
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public String getSql2() {
		return sql2;
	}
	public void setSql2(String sql2) {
		this.sql2 = sql2;
	}
	public String getReturnstr() {
		return returnstr;
	}
	public void setReturnstr(String returnstr) {
		this.returnstr = returnstr;
	}

}
