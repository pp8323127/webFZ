package eg.off;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import ci.db.*;
/**
 * @author cs71 Created on  2007/4/12
 */
public class LeaveProgress
{
    public static void main(String[] args)
    {
//        LeaveProgress al = new LeaveProgress("635856", "2007/12/27", "2007/12/27","3","002","SYSTEM");
        LeaveProgress al = new LeaveProgress("635849", "2012/05/02", "2012/05/02","27","","","","SYSTEM");        
        OffsObj obj = al.obj;
        System.out.println("doc "+obj.getDoc_status());
        System.out.println("doc 2 "+al.needDoc());
        System.out.println(al.insLeaveRequest()); 
//        System.out.println(al.delLeaveRequest("000227_2", "SYS"));
        
//        ArrayList objAL = new ArrayList();
//        ColumnObj obj = new ColumnObj();
//        obj.colname = "offtype";
//        obj.value = "3";
//        obj.valuetype = "S";
//        objAL.add(obj);
//        ColumnObj obj1 = new ColumnObj();
//        obj1.colname = "ef_judge_user";        
//        obj1.value = "123456";
//        obj1.valuetype ="S";
//        objAL.add(obj1);
//        ColumnObj obj2 = new ColumnObj();
//        obj2.colname = "ef_judge_tmst";        
//        obj2.value = "sysdate";
//        obj2.valuetype = "D";
//        objAL.add(obj2);
//        ColumnObj obj3 = new ColumnObj();
//        obj3.colname = "sern";        
//        obj3.value = "17409";
//        obj3.valuetype = "N";
//        objAL.add(obj3);
//        System.out.println(al.updLeaveRequest("000241_4", "SYS", objAL));
        
        System.out.println("Done");
    }    
	
	private String warnstr = "";
	private String sql = "";  
	private String sql_lsw = "";
    private String offno = "";
    private OffsObj obj = new OffsObj();
    LeaveRules arc = null;
    SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");        
	//Record Error Log
	//*************************************************************************************
    private String filename = "lsw.txt";	 	
    private String path = "/apsource/csap/projfz/txtin/off/";	
//    private String path = "C://";	
    private FileWriter fwlog = null;
    //****************************************************************************************
    
    public LeaveProgress(String empno, String offsdate, String offedate, String offtype, String duty, String userid)
    { 
        arc = new LeaveRules(empno,offsdate,offedate,offtype,duty,userid);   
        arc.needDoc();        
        this.obj = arc.getObj();  
    }    
    
    public LeaveProgress(String empno, String offsdate, String offedate, String offtype, String occurdate, String relation, String duty, String userid)
    { 
        arc = new LeaveRules(empno,offsdate,offedate,offtype,occurdate, relation,duty,userid);   
        arc.needDoc();        
        this.obj = arc.getObj();  
    }
    
    public String crewLeaveCheck()
    {
        String str = "Y";
        String ifhasSkj = arc.hasSkj();     
        
        //SL  LSW 必須有班表才可以申請
        if("3".equals(obj.getOfftype()) | "27".equals(obj.getOfftype()))
        {
	        str = arc.hasUL();//是否有電話預告,mark UL
//str ="Y";	        
	        if(!"Y".equals(str))
	        {
	            return str;
	        }
        }
        //*****************************************************************************************       
        //BL(公假) MT(會議假)無需檢核
        //無班表時,無需檢核
        if(!"6".equals(obj.getOfftype()) && !"17".equals(obj.getOfftype()) && !"3".equals(obj.getOfftype()) && !"27".equals(obj.getOfftype()) && "Y".equals(ifhasSkj))
        {
	        str = arc.hasUL();//是否有電話預告,mark UL
//str ="Y";	        
	        if(!"Y".equals(str))
	        {
	            return str;
	        }
        }
        
        if("1".equals(obj.getOfftype()) | "2".equals(obj.getOfftype()))
        {
            str = arc.isValidSubmitTime2();//  Crew 是否為可遞單時間
	        if(!"Y".equals(str))
	        {
	            return str;
	        }
        }   
        else if(!"6".equals(obj.getOfftype()) && !"17".equals(obj.getOfftype()) && "Y".equals(ifhasSkj))
        {//有班表才需檢核
	        str = arc.isValidSubmitTime();//  Crew 是否為可遞單時間
//str ="Y";
	        if(!"Y".equals(str))
	        {
	            return str;
	        }
        }     
        //******************************************************************************************
        
        str = arc.isNotDuplicated();//  is re-submit
        if(!"Y".equals(str))
        {
            return str;
        }
        
        if("3".equals(obj.getOfftype()) | "5".equals(obj.getOfftype()) | "12".equals(obj.getOfftype()) | "27".equals(obj.getOfftype()) )
        {
	        str = arc.hasUnHandle();//是否有未處理假單
//str ="Y";		        
	        if(!"Y".equals(str))
	        {
	            return str;
	        }
        }
        
        if(!"6".equals(obj.getOfftype()) && !"17".equals(obj.getOfftype()))
        {        
	        if("1".equals(obj.getOfftype()) | "2".equals(obj.getOfftype()))
	        {
		        //**  the last one to check
		        str = arc.isWithinMaxDays2(); //  檢查請假天數,婚假 8 天, 喪假 依親屬關係而定
		        if(!"Y".equals(str))
		        {
		            return str;
		        }    
	        }
	        else if("27".equals(obj.getOfftype()))//LSW
	        {            
	            //是否全勤
	            str = arc.lswFullAttendanceCheck();
	            if(!"Y".equals(str))
		        {
		            return str;
		        } 
	            
	            //lsw使用天數
	            str = arc.lswQuotaCheck();
	            if(!"Y".equals(str))
		        {
		            return str;
		        } 
	            
	            //是否為控管日
	            str = arc.ifLSWOKDate();
	            if(!"Y".equals(str))
		        {
		            return str;
		        }
	            
	            //是否個人AL天數足夠
	            ALRules ar = new ALRules(obj.getEmpn(),"0",obj.getOffsdate(),obj.getOffedate(),obj.getNewuser()); 
	            str = ar.isALDaysAvailable();
	            if(!"Y".equals(str))
		        {
		            return str;
		        }
	        }
	        else
	        {
	//          **  the last one to check
		        str = arc.isWithinMaxDays(); //  檢查整年請假天數,不可超過整年請假天數 病假 30 天, 事假 14 天
		        if(!"Y".equals(str))
		        {
		            return str;
		        }  
	        }
        }
        
//      check if continuing days > 7
        str = arc.chkContinues();
        if(!"Y".equals(str))
        {
            return str;
        }
        
        this.obj = arc.getObj();  
        return str;
    }   
     
    public String needDoc()
    {
        return obj.getDoc_status();
    }
    
    public String egLeaveCheck_Warning()
    {
        return warnstr;
    }    
    
//  progress Leave request for crew
    public String insLeaveRequest()
    {    
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;	
    	Driver dbDriver = null;
    	
        try
        {
//            EGConnDB cn = new EGConnDB();
////            cn.setORP3EGUser(); 
//            cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());    
	    	
	    	EGConnDB cn = new EGConnDB();          
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);
            
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
				  " doc_status, delete_user, delete_tmst, occur_date, relation) values " +
				  " (?,?,?,?,to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),to_number(?),?,?,'Y',?,?,?," +
				  " sysdate,null,null,?,?,?,'U',null,null,null,null,?,null,null,to_date(?,'yyyy/mm/dd'),?) ";			
			
			pstmt = conn.prepareStatement(sql);			
			int count = 0; 
		    for(int k=0; k<Integer.parseInt(obj.getOffdays()); k++)
		    { 
		        Calendar offdate = new GregorianCalendar();                        
		        offdate.set(Integer.parseInt(obj.getOffsdate().substring(0,4)),Integer.parseInt(obj.getOffsdate().substring(5,7))-1,Integer.parseInt(obj.getOffsdate().substring(8,10)));
		        offdate.add(Calendar.DATE,k);          

			    int j=1;
			    pstmt.setString(j, offno+"_"+(k+1));
				pstmt.setString(++j, obj.getEmpn());
				pstmt.setString(++j, obj.getSern());
				pstmt.setString(++j, obj.getOfftype());
				pstmt.setString(++j, f.format(offdate.getTime()));
				pstmt.setString(++j, f.format(offdate.getTime()));				
				pstmt.setString(++j, "1");
				pstmt.setString(++j, obj.getOffftno());
				pstmt.setString(++j, obj.getStation());
				pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)));
				if(offdate.get(Calendar.MONTH)>=10)	
				{
					pstmt.setString(++j,Integer.toString(offdate.get(Calendar.YEAR)+1));				    
				}
				else
				{
				    
					pstmt.setString(++j, Integer.toString(offdate.get(Calendar.YEAR)) );				
				}

				pstmt.setString(++j, obj.getNewuser());
				pstmt.setString(++j, offno);
				pstmt.setString(++j, obj.getRank());
				pstmt.setString(++j, obj.getReassign());
				pstmt.setString(++j, obj.getDoc_status());
				pstmt.setString(++j, obj.getOccur_date());
				pstmt.setString(++j, obj.getRelation());
				pstmt.addBatch();					
		    }//for(int k=0; k<offdays; k++)
		    pstmt.executeBatch();				
			pstmt.clearBatch();			
			  
		    //申請 LSW 即刻扣除AL *******************************
		    if("27".equals(obj.getOfftype()))
		    {
		        //lsw record
		        fwlog = new FileWriter(path+filename,true);
		        fwlog.write("Empno : "+obj.getEmpn()+" form_num : "+ offno+" offdays : "+ obj.getOffdays()+"\r\n");
		        //記錄扣假前餘假
		        sql_lsw = " select empno, sern, offquota, useddays, To_Char(eff_dt,'yyyy/mm/dd') eff_dt, To_Char(exp_dt,'yyyy/mm/dd') exp_dt " +
		        		  " from egtoffq WHERE empno = '"+obj.getEmpn()+"' and offtype = '0' " +
		 	  		      " and exp_dt = ( SELECT Min(exp_dt) FROM egtoffq  WHERE empno = '"+obj.getEmpn()+"' " +
		 	  		      " AND To_Date('"+obj.getOffsdate()+"','yyyy/mm/dd') BETWEEN eff_dt AND exp_dt AND (offquota-useddays) > 0 )  ";
//		        System.out.println(sql_lsw);
		        rs = stmt.executeQuery(sql_lsw);
				while(rs.next())
				{ 
				    fwlog.write("-----> offquota : "+rs.getString("offquota")+"  useddays : "+rs.getString("useddays")+" duration : "+rs.getString("eff_dt")+" ~ "+rs.getString("exp_dt")+" \r\n");
				}
				rs.close();
		        
		        for(int k=0; k<Integer.parseInt(obj.getOffdays()); k++)
			    { 
			        Calendar offdate = new GregorianCalendar();                        
			        offdate.set(Integer.parseInt(obj.getOffsdate().substring(0,4)),Integer.parseInt(obj.getOffsdate().substring(5,7))-1,Integer.parseInt(obj.getOffsdate().substring(8,10)));
			        offdate.add(Calendar.DATE,k); 
		        
			        String sql27 = " update egtoffq SET useddays = useddays+1 " +
	    	  		   " WHERE empno = '"+obj.getEmpn()+"' and offtype = '0' " +
	    	  		   " and exp_dt = ( SELECT Min(exp_dt) FROM egtoffq  WHERE empno = '"+obj.getEmpn()+"' " +
	    	  		   " AND To_Date('"+f.format(offdate.getTime())+"','yyyy/mm/dd')  " +
	    	  		   " BETWEEN eff_dt AND exp_dt AND (offquota-useddays) > 0 )  ";
			        int updint = stmt.executeUpdate(sql27);       
			        
			        if(updint<=0)
			        {//扣假失敗
			            String sqlfail = " update egtoffs SET remark = 'N' " +
		    	  		   				 " WHERE offno = '"+offno+"_"+(k+1)+"' ";
				        stmt.executeUpdate(sqlfail);       
			        }
			    }//for(int k=0; k<Integer.parseInt(obj.getOffdays()); k++)
		        
		        sql_lsw = " select empno, sern, offquota, useddays, To_Char(eff_dt,'yyyy/mm/dd') eff_dt, To_Char(exp_dt,'yyyy/mm/dd') exp_dt " +
		        		  " from egtoffq WHERE empno = '"+obj.getEmpn()+"' and offtype = '0' " +
			  		      " and exp_dt = ( SELECT Min(exp_dt) FROM egtoffq  WHERE empno = '"+obj.getEmpn()+"' " +
			  		      " AND To_Date('"+obj.getOffedate()+"','yyyy/mm/dd') BETWEEN eff_dt AND exp_dt AND (offquota-useddays) > 0 )  ";
		        rs = stmt.executeQuery(sql_lsw);
				while(rs.next())
				{ 
				    fwlog.write("-----> offquota : "+rs.getString("offquota")+"  useddays : "+rs.getString("useddays")+" duration : "+rs.getString("eff_dt")+" ~ "+rs.getString("exp_dt")+" \r\n");
				}
				rs.close();
				//log close
				fwlog.write("\r\n");
		        fwlog.close();	
		        //************
		    }
		    //即刻扣除AL *******************************	       			
			
//		    //insert hr hrtpgshtnpl *******************************
//		    if("9".equals(obj.getOfftype()))
//		    {
//			    sql = "INSERT INTO HRTPGSHTNPL ( EMPLOYID,SHTDT,STRDT,ENDDT,LVDT,CANDT,TRNSDT,UPTER,UPTDT) " +
//			    	  " VALUES ( "+obj.getEmpn()+",sysdate,to_date('"+obj.getOffsdate()+"','yyyy/mm/dd'), " +
//			    	  " to_date('"+obj.getOffedate()+"','yyyy/mm/dd'), " +
//			    	  " to_date('"+obj.getOffedate()+"','yyyy/mm/dd')-to_date('"+obj.getOffsdate()+"','yyyy/mm/dd'), " +
//			    	  " 0,null,null,null )  ";
//			    stmt.executeUpdate(sql);
//		    }
//		    //insert hr hrtpgshtnpl *******************************			
			conn.commit();	
			return "Y";
        }
        catch (Exception e)
        {
                System.out.println(" insLeaveRequest: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " insLeaveRequest: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(pstmt != null) pstmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
    }   
          
//  Delete leave request
    public String delLeaveRequest(String offno, String deluser)
    {
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	Driver dbDriver = null;
        try
        {
//          EGConnDB cn = new EGConnDB();
//          cn.setORP3EGUser(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());    
	    	
	    	EGConnDB cn = new EGConnDB();          
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);       
            
            conn.setAutoCommit(false);	
            stmt = conn.createStatement();  
			
			sql = " update egtoffs set remark = '*', chguser = '"+deluser+"', chgdate = sysdate, " +
				  //" ef_judge_status = 'N', ef_judge_user = '"+deluser+"', ef_judge_tmst = sysdate, " +
				  " delete_user = '"+deluser+"', delete_tmst = sysdate " +
				  " where (offno = '"+offno+"' or form_num = '"+offno+"') ";			
			stmt.executeUpdate(sql);		
			
//			//insert hr hrtpgshtnpl *******************************
//		    if("9".equals(obj.getOfftype()))
//		    {
//			    sql = " delete from HRTPGSHTNPL where EMPLOYID = '"+obj.getEmpn()+"' " +
//			    	  " and STRDT = to_date('"+obj.getOffsdate()+"','yyyy/mm/dd') " +
//			    	  " and ENDDT = to_date('"+obj.getOffedate()+"','yyyy/mm/dd') ";
//			    stmt.executeUpdate(sql);
//		    }
//		    //insert hr hrtpgshtnpl *******************************		
		    
			conn.commit();	
			return "Y";
        }
        catch (Exception e)
        {
//                System.out.println(" delLeaveRequest: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " delLeaveRequest: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
        
    }
    
//  Update Leave request
    public String updLeaveRequest(String offno, String upduser, ArrayList objAL)
    {
        Connection conn = null;
    	Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	Driver dbDriver = null;
        StringBuffer sqlSB = new StringBuffer();
        try
        {
//            EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUser(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());  
	    	
	    	EGConnDB cn = new EGConnDB();          
            cn.setORP3EGUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);   
            
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
                System.out.println(" updLeaveRequest: "+e.toString());	               
                try { conn.rollback(); } 
    			catch (SQLException e1) { System.out.print(e1.toString()); }
    			return " updLeaveRequest: "+e.toString();
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}
        }
        
    }
}
