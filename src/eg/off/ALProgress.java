package eg.off;

import java.sql.*;
import java.text.*;
import java.util.*;
import ci.db.*;
/**
 * @author cs71 Created on  2007/4/12
 * cs80 2013/01/08
 */
public class ALProgress
{
    public static void main(String[] args)
    {
        ALProgress al = new ALProgress("633020","0","2013/03/12","2013/03/13","SYS");       
        System.out.println(al.crewALCheck());

//        OffsObj obj = new OffsObj();
//        obj.setOffsdate("2008/02/01");
//        obj.setOffedate("2008/02/06");
//        obj.setEmpn("635856");
//        obj.setRemark("Y");
//        obj.setOffdays("6");
//        al.delALRequestEG("H12345", "Sys", obj);
        //System.out.println(al.crewALCheck());
        //System.out.println(al.insALRequest()); 
//        System.out.println(al.delALRequest("000227_2", "SYS"));
        
//        ArrayList objAL = new ArrayList();
//        ColumnObj obj = new ColumnObj();
//        obj.colname = "offtype";
//        obj.value = "0";
//        objAL.add(obj);
//        ColumnObj obj1 = new ColumnObj();
//        obj1.colname = "reassign";        
//        obj1.value = "N";
//        objAL.add(obj1);
//        System.out.println(al.updALRequest("000227_4", "SYS", objAL));
    }    
 
	
	private String sql = null;  
    private String offno = "";
    private String offtype = "";   
    private String warnstr = "";
    private ALRulesObj obj = new ALRulesObj();
    SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
    ALRules ar = null;
    
    public ALProgress(String empno, String offtype, String offsdate, String offedate, String userid)
    {        
        ar = new ALRules(empno, offtype, offsdate, offedate, userid);
        this.obj = ar.getALObj();  
    }
    
    
    public String crewALCheck()
    {
        String str = "Y";
        //SR2176 取消此規定
//        str = ar.isBelow30Days();//是否大於30天
//        if(!"Y".equals(str))
//        {
//            return str;
//        }
        
        str = ar.isAvailabledPeriod();//  是否於可遞單期間
        if(!"Y".equals(str))
        {
            return str;
        }
        str = ar.isNotDuplicated();//  is re-submit
        if(!"Y".equals(str))
        {
            return str;
        }
        str = ar.isALDaysAvailable();//if personal AL enough
        if(!"Y".equals(str))
        {
            return str;
        }
        //2013/01/07
        str =ar.isALOverSixDays();//是否超過6天或連續請AL超過六天
        if(!"Y".equals(str))
        {
            return str;
        }
        
        //**  the last one to check
        //若為生日當天,則無需檢查
        if(ar.isBirthday()==false)
        {
	        str = ar.isQuotaAvailable(); //  is quota full   
	        if(!"Y".equals(str))
	        {
	            return str;
	        }
        }
                
        this.obj = ar.getALObj();  
        return str;
    }   
    
    public String egALCheck()
    {
        String str = "Y";

        ar.isBelow30Days();
        ar.isAvailabledPeriod();
                
        str = ar.isNotDuplicated();//  is re-submit
        if(!"Y".equals(str))
        {
            return str;
        }
        
        str = ar.isALDaysAvailable();//if personal AL enough
        if(!"Y".equals(str))
        {
            return str;
        }
        //2013/01/07
        str =ar.isALOverSixDays();//是否超過6天或連續請AL超過六天
        if(!"Y".equals(str))
        {
            return str;
        }
        
        //**  the last one to check       
        if(ar.isBirthday()==false)
        {
	        if(!"Y".equals(ar.isQuotaAvailable()))
	        {
	            warnstr = warnstr +" * "+ ar.isQuotaAvailable() ;
	        }
        }
        
        this.obj = ar.getALObj();  
        return str;
    }   
    
    public String egALCheck_Warning()
    {
        return warnstr;
    }
    
    public String ifTrainInPreviousMonth()
    {
        return ar.trainMonthChk();
    }
    
    //progress AL request for crew
    public String insALRequest()
    {
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;	
    	String logstr = "";
    	
        try
        {
//            EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUser(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());  
	    	
	    	ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			conn.setAutoCommit(false);	 
            stmt = conn.createStatement();  
			
			sql = " select LPAD(egqofno.nextval, 7, '0') offno from dual";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{ 
			    offno = rs.getString("offno");
			}
			rs.close();
			
			sql = " insert into egtoffs (offno, empn, sern, offtype, offsdate, offedate, offdays, offftno, " +
				  " station, remark, offyear, gradeyear, newuser, newdate, chguser, chgdate, form_num, leaverank," +
				  " reassign, ef_judge_status, ef_judge_user, ef_judge_tmst, ed_inform_user, ed_inform_tmst, " +
				  " doc_status, delete_user, delete_tmst) values " +
				  " (?,?,?,?,to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),to_number(?),null,?,'N',?,?,?," +
				  " sysdate,null,null,?,?,'N','Y',null,null,null,null,'U',null,null) ";
//			
			pstmt = conn.prepareStatement(sql);			
			int count = 0; 
		    for(int k=0; k<obj.getOffdays(); k++)
		    {
		        Calendar offdate = new GregorianCalendar();                        
		        offdate.set(Integer.parseInt(obj.getOffsdate().substring(0,4)),Integer.parseInt(obj.getOffsdate().substring(5,7))-1,Integer.parseInt(obj.getOffsdate().substring(8,10)));
		        offdate.add(Calendar.DATE,k);          

			    int j=1;
			    pstmt.setString(j, offno+"_"+(k+1));
				pstmt.setString(++j, obj.getEmpno());
				pstmt.setString(++j, obj.getSern());
				pstmt.setString(++j, obj.getOfftype());
				pstmt.setString(++j, f.format(offdate.getTime()));
				pstmt.setString(++j, f.format(offdate.getTime()));				
				pstmt.setString(++j, "1");
				pstmt.setString(++j, obj.getBase());
				pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)));
				pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)) );	
//				if(offdate.get(Calendar.MONTH)>=10)	
//				{
//					pstmt.setString(++j,Integer.toString(offdate.get(Calendar.YEAR)+1));				    
//				}
//				else
//				{
//				    
//					pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)) );				
//				}

				pstmt.setString(++j, obj.getUserid());
				pstmt.setString(++j, offno);
				pstmt.setString(++j, obj.getJobtype());
				pstmt.addBatch();	
		    }//for(int k=0; k<offdays; k++)

			pstmt.executeBatch();				
			pstmt.clearBatch();
			conn.commit();	
			return "Y";
        }
        catch (Exception e)
        {
                System.out.println(" insALRequest: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " insALRequest: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(pstmt != null) pstmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
        
    }
    
//  progress AL request for eg office
    public String insALRequestEG(String offno)
    {
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
        this.offno = offno;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
			conn.setAutoCommit(false);	           
			
			sql = " insert into egtoffs (offno, empn, sern, offtype, offsdate, offedate, offdays, offftno, " +
				  " station, remark, offyear, gradeyear, newuser, newdate, chguser, chgdate, form_num, leaverank," +
				  " reassign, ef_judge_status, ef_judge_user, ef_judge_tmst, ed_inform_user, ed_inform_tmst, " +
				  " doc_status, delete_user, delete_tmst) values " +
				  " (?,?,?,?,to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),to_number(?),null,?,'N',?,?,?," +
				  " sysdate,null,null,?,?,'N','Y',null,null,null,null,'U',null,null) ";
//			
			pstmt = conn.prepareStatement(sql);			
			int count = 0; 
		    for(int k=0; k<obj.getOffdays(); k++)
		    {
		        Calendar offdate = new GregorianCalendar();                        
		        offdate.set(Integer.parseInt(obj.getOffsdate().substring(0,4)),Integer.parseInt(obj.getOffsdate().substring(5,7))-1,Integer.parseInt(obj.getOffsdate().substring(8,10)));
		        offdate.add(Calendar.DATE,k);          

			    int j=1;
			    pstmt.setString(j, offno+"_"+(k+1));
				pstmt.setString(++j, obj.getEmpno());
				pstmt.setString(++j, obj.getSern());
				pstmt.setString(++j, obj.getOfftype());
				pstmt.setString(++j, f.format(offdate.getTime()));
				pstmt.setString(++j, f.format(offdate.getTime()));				
				pstmt.setString(++j, "1");
				pstmt.setString(++j, obj.getBase());
				pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)));
				pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)) );				
//				if(offdate.get(Calendar.MONTH)>=10)	
//				{
//					pstmt.setString(++j,Integer.toString(offdate.get(Calendar.YEAR)+1));				    
//				}
//				else
//				{
//				    
//					pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)) );				
//				}

				pstmt.setString(++j, obj.getUserid());
				pstmt.setString(++j, offno);
				pstmt.setString(++j, obj.getJobtype());
				pstmt.addBatch();	
		    }//for(int k=0; k<offdays; k++)

			pstmt.executeBatch();				
			pstmt.clearBatch();
			conn.commit();	
			return "Y";
        }
        catch (Exception e)
        {
                System.out.println(" insALRequestEG: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " insALRequestEG: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}        
        	try{if(pstmt != null) pstmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
        
    }
        
//  Delete AL request
    public String delALRequest(String offno, String deluser)
    {
        String str = ar.isAvailableCancelAL(offno);
        if(!"Y".equals(str) && !"X".equals(str))
        {
            return str;
        }
        else
        {        
            Connection conn = null;
        	Statement stmt = null;
        	PreparedStatement pstmt = null;
        	ResultSet rs = null;
        	String alrelease_str="";
        	if("X".equals(str))
        	{
        	    alrelease_str ="Y";
        	}
        	
	        try
	        {
//	            EGConnDB cn = new EGConnDB();
//	            cn.setORP3EGUser(); 
//		    	java.lang.Class.forName(cn.getDriver());
//		    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
	            ConnectionHelper ch = new ConnectionHelper();
	            conn = ch.getConnection();
	            conn.setAutoCommit(false);	
	            stmt = conn.createStatement();  
				
				sql = " update egtoffs set remark = '*', chguser = '"+deluser+"', chgdate = sysdate, " +
					  " delete_user = '"+deluser+"', delete_tmst = sysdate, alrelease = '"+alrelease_str+"' " +
					  " where (offno = '"+offno+"' or form_num = '"+offno+"') ";			
				stmt.executeUpdate(sql);			
				conn.commit();	
				return "Y";
	        }
	        catch (Exception e)
	        {
	                System.out.println(" delALRequest: "+e.toString());	               
	                try { conn.rollback(); } 
	    			catch (SQLException e1) { System.out.print(e1.toString()); }
	    			return " delALRequest: "+e.toString();
	        } 
	        finally
	        {
	            try{if(rs != null) rs.close();}catch (Exception e){}
	        	try{if(stmt != null) stmt.close();}catch (Exception e){}
	        	try{if(conn != null) conn.close();}catch (Exception e){}
	        }
        }        
    }
    
//  Delete AL request
    public String delALRequestEG(String offno, String deluser, OffsObj obj)
    {      
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            conn.setAutoCommit(false);	
            stmt = conn.createStatement();  
            
            if("Y".equals(obj.getRemark()))
            {
                for(int x=0; x<Integer.parseInt(obj.getOffdays()); x++)
                {                     
                    Calendar checkoffdate = new GregorianCalendar();                        
                    checkoffdate.set(Integer.parseInt((obj.getOffsdate()).substring(0,4)),Integer.parseInt((obj.getOffsdate()).substring(5,7))-1,Integer.parseInt((obj.getOffsdate()).substring(8,10)));
                    checkoffdate.add(Calendar.DATE,x);
                    String tempdate = new SimpleDateFormat("yyyy/MM/dd").format(checkoffdate.getTime());
                    
                    //refund al 
                    sql = " update egtoffq SET useddays = useddays-1 " +
//                    	  " WHERE empno = '"+obj.getEmpn()+"' and offtype = '0' " +
                    	  " WHERE empno = '"+obj.getEmpn()+"' and offtype = '"+obj.getOfftype()+"' " +
                    	  " and eff_dt = ( SELECT Max(eff_dt) FROM egtoffq  WHERE empno = '"+obj.getEmpn()+"' " +
                    	  //" and exp_dt = ( SELECT Max(exp_dt) FROM egtoffq  WHERE empno = '"+obj.getEmpn()+"' " +
                    	  " AND To_Date('"+tempdate+"','yyyy/mm/dd')  " +
                    	  " BETWEEN eff_dt AND exp_dt AND useddays > 0 )  ";
//                    System.out.println("**********************************");
//                    System.out.println(sql);
//                    System.out.println("**********************************");
                    stmt.executeUpdate(sql);
                }                
            }
			
			sql = " update egtoffs set remark = '*', chguser = '"+deluser+"', chgdate = sysdate, " +
				  " delete_user = '"+deluser+"', delete_tmst = sysdate" +
				  " where (offno = '"+offno+"' or form_num = '"+offno+"') ";			
			stmt.executeUpdate(sql);			
			conn.commit();	
			return "Y";
        }
        catch (Exception e)
        {
                System.out.println(" delALRequestEG: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " delALRequestEG: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }  
    }

    
//  Update AL request
    public String updALRequest(String offno, String upduser, ArrayList objAL)
    {
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
        StringBuffer sqlSB = new StringBuffer();
        try
        {
//            EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUser(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());          
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            conn.setAutoCommit(false);	
            stmt = conn.createStatement();  
			
            if(objAL.size()>0)
            {
				sqlSB.append(" update egtoffs set chguser = '"+upduser+"', chgdate = sysdate "); 
				for(int i=0; i<objAL.size(); i++)
				{
				    ColumnObj obj = (ColumnObj) objAL.get(i);	
				    if("S".equals(obj.valuetype)) //String
				    {
				        sqlSB.append(" , "+obj.colname +" = '"+ obj.value+"'");	
				    }
				    else if ("N".equals(obj.valuetype))//Number
				    {
				        sqlSB.append(" , "+obj.colname +" = to_number('"+ obj.value+"')");	
				    }
				    else if ("D".equals(obj.valuetype))//Date
				    {
				        sqlSB.append(" , "+obj.colname +" = "+ obj.value );	
				    }
				}
				
				sqlSB.append(" where (offno = '"+offno+"' or form_num = '"+offno+"') ");	
            }
            
//            System.out.println(sqlSB.toString());
			stmt.executeUpdate(sqlSB.toString());			
			conn.commit();	
			return "Y";
        }
        catch (Exception e)
        {
                System.out.println(" updALRequest: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " updALRequest: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
        
    }
}
