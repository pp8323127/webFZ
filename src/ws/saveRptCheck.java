package ws;

import java.io.*;
import java.sql.*;
import java.util.*;

/**
 * @author 640790 Created on  2013/8/19
 */
public class saveRptCheck
{
    public static void main(String[] args)
    {
        saveRptCheck src = new saveRptCheck();
//        System.out.println(src.doSaveReportCheck("2013/11/05","0006","TPELAX"));
//        System.out.println(src.paxCountCheck("2013/11/18","0004","TPESFO") );
        System.out.println(src.shiftMPCheck("2013/10/29","0154","TPENGO") );
    }
    
    private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
    private Driver dbDriver = null;
	private String sql ="";
	FileWriter fw = null;
	String path = "/apsource/csap/projfz/txtin/appLogs/";
	 
   public String doSaveReportCheck(String fltd, String fltno, String sect) 
    {        
        ci.db.ConnDB cn = new ci.db.ConnDB();
        
	    try
	    {
	        cn.setORP3EGUserCP();
	    	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	    	con = dbDriver.connect(cn.getConnURL(), null);
	    	
	    	//connect ORT1 EG     
//	        cn.setORP3EGUser();
//	    	cn.setORT1EG();
//	    	Class.forName(cn.getDriver());
//	    	con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());	
	    	
	    	stmt = con.createStatement();  
            
            sql = "select count(*) c from egtcrpt where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"' and flag = 'Y'";
            rs = stmt.executeQuery(sql);
            
            int cnt =0;
            if (rs.next()) 
            {
                cnt = rs.getInt("c");
                //flag=Y 報告已送出
                if(cnt>0)
                {
                    return "報告已送出，即不得更改。";                    
                }                
            }
            
            sql = "SELECT Count(*) c FROM dual WHERE to_date('"+fltd+"','yyyy/mm/dd') > Trunc(SYSDATE,'dd') ";
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) 
            {
                //fltd > sysdate 報告不可編輯
                if(rs.getInt("c")>0)
                {
                    return "報告尚無法編輯。";                    
                }                
            }        
	    } 
	    catch(Exception e) 
	    {
			//System.out.println(e.toString());
	        try{con.rollback();}catch(SQLException se){ return se.toString();}
	        return e.toString();			
		}
		finally 
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}  
	    return "Y";
    }
   
   public String paxCountCheck(String fltd, String fltno, String sect) 
   {        
       ci.db.ConnDB cn = new ci.db.ConnDB();
       
       try
       {
           cn.setORP3EGUserCP();
           dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
           con = dbDriver.connect(cn.getConnURL(), null);
           
           //connect ORT1 EG     
//         cn.setORP3EGUser();
//         cn.setORT1EG();
//         Class.forName(cn.getDriver());
//         con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
           
           stmt = con.createStatement();  
           
           sql = " select book_f, book_c, book_y, book_w, duty1, duty2,duty3,duty4,duty5,duty6,duty7, " +
           		" duty8,duty9,duty10,duty11,duty12,duty13,duty14,duty15,duty16,duty17,duty18," +
           		" duty19,duty20 from egtcflt " +
           		" where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"'";
           rs = stmt.executeQuery(sql);
           
           while (rs.next()) 
           {
               int paxCnt = 0;
               paxCnt = rs.getInt("book_f") + rs.getInt("book_c") + rs.getInt("book_y") + rs.getInt("book_w");    
               int odCnt =0;
               
               for (int od=1; od<=20; od++)
               {
                   if("OD".equals(rs.getString("duty"+od)))
                   {
                       odCnt++;
                   }
               }
               
               if(paxCnt <=0 && odCnt <=0)               
               {
                   return "請輸入實際旅客人數!!\n若為Ferry Flt,請選擇打工組員(Duty code OD).";
               }
               else if(paxCnt <=0 && (odCnt >2 | odCnt<2))
               {
//                   return"請輸入實際旅客人數!!\n若為Ferry Flt,請僅選擇一位打工組員(Duty code OD).";
                   return"請輸入實際旅客人數!!\n若為Ferry Flt,請選擇二位打工組員(Duty code OD).";
               }
           }
       } 
       catch(Exception e) 
       {
           //System.out.println(e.toString());
           try{con.rollback();}catch(SQLException se){ return se.toString();}
           return e.toString();            
       }
       finally 
       {
           try{if(rs != null) rs.close();}catch(SQLException e){}
           try{if(stmt != null) stmt.close();}catch(SQLException e){}
           try{if(con != null) con.close();}catch(SQLException e){}
       }  
       return "Y";
   }
   
   //Check 需填寫輪休記錄的航班是否有MP輪休記錄
   public String shiftMPCheck(String fltd, String fltno, String sect) 
   {        
       ci.db.ConnDB cn = new ci.db.ConnDB();
       
       try
       {
           cn.setORP3EGUserCP();
           dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
           con = dbDriver.connect(cn.getConnURL(), null);
           
           //connect ORT1 EG     
//         cn.setORP3EGUser();
//           cn.setORT1EG();
//           Class.forName(cn.getDriver());
//           con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
           
           stmt = con.createStatement();  
           
           sql = " select shift,mp_empn, sh_mp from egtcflt " +
                " where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"'";
           rs = stmt.executeQuery(sql);
           
//           System.out.println(sql);
           
           while (rs.next()) 
           {
               if("Y".equals(rs.getString("shift")) && (!"".equals(rs.getString("mp_empn")) && rs.getString("mp_empn") != null) && ("".equals(rs.getString("sh_mp")) | rs.getString("sh_mp") == null))
               {
                   return "當班組長需填寫輪休記錄,請由網頁補足再送出報告!!";                   
               }
           }
       } 
       catch(Exception e) 
       {
           //System.out.println(e.toString());
           try{con.rollback();}catch(SQLException se){ return se.toString();}
           return e.toString();            
       }
       finally 
       {
           try{if(rs != null) rs.close();}catch(SQLException e){}
           try{if(stmt != null) stmt.close();}catch(SQLException e){}
           try{if(con != null) con.close();}catch(SQLException e){}
       }  
       return "Y";
   }

   //chk 查核項目是否完成
   public String chkItem(String fltd, String fltno, String sect , String empno){
       ci.db.ConnDB cn = new ci.db.ConnDB();
       String msg = "N";
       try
       {
           cn.setORP3EGUserCP();
           dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
           con = dbDriver.connect(cn.getConnURL(), null);
           
           //connect ORT1 EG     
//         cn.setORP3EGUser();
//           cn.setORT1EG();
//           Class.forName(cn.getDriver());
//           con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
           
           stmt = con.createStatement();  
           
           int cnt = 0;
           sql = " select count(*) c from egtchkrdm t "+//executestatus, evalstatus
           " where fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno='"+fltno+"' and sector = '"+sect+"' and psrempn ='"+empno+"' "+
           " and ( (executestatus = 'N'   and  trim(comments) is null) or (evalstatus <> 'Y'and  trim(comments) is null) )";
           //and evalstatus <> 'Y'
           
           rs = stmt.executeQuery(sql);
           
           if(rs.next()){
               cnt = rs.getInt("c");
           } 
           if(cnt > 0 ){
               msg = "查核項目:勾選未執行,請輸入原因,方可送出.";
           }else{
               msg = "Y";
           }
           
       } 
       catch(Exception e) 
       {
           msg = e.toString();
           //System.out.println(e.toString());
           try{con.rollback();}catch(SQLException se){ return se.toString();}
           return e.toString();            
       }
       finally 
       {
           try{if(rs != null) rs.close();}catch(SQLException e){}
           try{if(stmt != null) stmt.close();}catch(SQLException e){}
           try{if(con != null) con.close();}catch(SQLException e){}
       }  
       return msg;

       
   }
}
