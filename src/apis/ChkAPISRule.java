package apis;

import java.sql.*;
import java.util.*;
/**
 * @author cs71 Created on  2006/8/31
 */
public class ChkAPISRule
{

    Statement stmt = null;
    ResultSet rs = null;
    Connection conn = null;
    Driver dbDriver = null;
    String sql =  "";
    String sql2 =  "";
    String returnstr = "";
    int count = 0;
    int total = 0;
    ArrayList empnAL = new ArrayList();
    ArrayList gctpAL = new ArrayList();
    ArrayList objAL = new ArrayList();
    ArrayList actlobjAL = new ArrayList();
    
    public static void main(String[] args)
    {
        ChkAPISRule apis = new ChkAPISRule("2007/03/07","2007/03/08","ALL");
        apis.apisResult();
        System.out.println(apis.getObjAL().size());
        System.out.println(apis.getCount());
    }
    
    public ChkAPISRule(String sdt, String edt, String type)
    {
        ChkAPIS3 c = new ChkAPIS3();
        c.ChkApisEmpty(sdt, edt, type);
        objAL = c.getObjAL();   
        total = c.getCount();
        sql2 = c.getSql();
        returnstr = c.getStr();
        greenCardRequired();      
    }
    
     public void greenCardRequired()
    {
         //PermanentGreenCard --> P
         //TemporaryGreenCard --> T
         //Do not need check  --> N  
        
        try
        {
            DB2Conn cn = new DB2Conn();
            
//            cn.setORP3EGUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());            
            
    		cn.setEGUserCP();
    		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    		conn = dbDriver.connect(cn.getConnURL(), null);         
    		
			stmt = conn.createStatement();
	    	
	    	sql = " SELECT empno, CASE WHEN (doc_tp = 'C' AND exp_date IS NULL) THEN 'P' " +
	    		  " WHEN (doc_tp = 'C' AND exp_date IS NOT null) THEN 'T' ELSE 'N' END gctp FROM ( " +
	    		  " SELECT Trim(c.empn) empno, p.doc_tp doc_tp, p.exp_date exp_date FROM egtcbas c, " +
	    		  " egtpass p WHERE Trim(c.empn) = p.empno (+) )";
    	
	    	rs = stmt.executeQuery(sql);
	    	while (rs.next())
	    	{
	    	    empnAL.add(rs.getString("empno"));
	    	    gctpAL.add(rs.getString("gctp").trim());
	    	} 
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
     
     public void apisResult()
     {         
         for(int i=0; i<objAL.size(); i++)
         {
             APISObj obj = (APISObj) objAL.get(i);
             //check if carrier......travel status is empty
             if( "".equals(obj.getCarrier()) | obj.getCarrier() == null	| 
                 "".equals(obj.getFltno()) | obj.getFltno() == null	|
                 "".equals(obj.getFdate()) | obj.getFdate() == null	|
                 "".equals(obj.getLname()) | obj.getLname() == null	|
                 "".equals(obj.getFname()) | obj.getFname() == null	|
                 "".equals(obj.getNation()) | obj.getNation() == null	|
                 "".equals(obj.getBirth()) | obj.getBirth() == null	|
                 "".equals(obj.getGender()) | obj.getGender() == null	|
                 "".equals(obj.getPassport()) | obj.getPassport() == null	|
                 "".equals(obj.getDoctype()) | obj.getDoctype() == null	|
                 "".equals(obj.getPasscountry()) | obj.getPasscountry() == null	|
                 "".equals(obj.getPassexp()) | obj.getPassexp() == null	|
                 "".equals(obj.getDepart()) | obj.getDepart() == null	|
                 "".equals(obj.getDest()) | obj.getDest() == null	|
                 "".equals(obj.getOccu()) | obj.getOccu() == null	|
                 "".equals(obj.getBirthcity()) | obj.getBirthcity() == null	|
                 "".equals(obj.getBirthcountry()) | obj.getBirthcountry() == null	|
                 "".equals(obj.getResicountry()) | obj.getResicountry() == null	|
                 "".equals(obj.getTvlstatus()) | obj.getTvlstatus() == null	)
             {
                 actlobjAL.add(obj);                 
             }
             else
             {
                 if("CR2".equals(obj.getTvlstatus()))
                 {
                     //if 美加航線
                     if("ANC,ATL,BNA,BOS,CVG,DEN,DFW,GUM,HNL,HOU,JFK,LAS,LAX,MIA,NYC,ORD,ORL,PDX,SEA,SFO,TPA,YVR,YTO,YYZ,YMX,ROR".indexOf(obj.getDest()) >= 0 | 
                     	"ANC,ATL,BNA,BOS,CVG,DEN,DFW,GUM,HNL,HOU,JFK,LAS,LAX,MIA,NYC,ORD,ORL,PDX,SEA,SFO,TPA,YVR,YTO,YYZ,YMX,ROR".indexOf(obj.getDepart()) >= 0 )
                     {        
                         //PermanentGreenCard and one of three certXXX is empty	
                         if("P".equals(getGctp(obj.getEmpno())) && ( "".equals(obj.getCertno()) | obj.getCertno() == null | 
                            "".equals(obj.getCertctry()) | obj.getCertctry() == null |
                            "".equals(obj.getCertdoctype()) | obj.getCertdoctype() == null ) )
                         {
                             actlobjAL.add(obj);  
                         }
                         
                        //TempararyGreenCard and one of four certXXX is empty	
                         if("T".equals(getGctp(obj.getEmpno())) && ( "".equals(obj.getCertno()) | obj.getCertno() == null | 
                                 "".equals(obj.getCertctry()) | obj.getCertctry() == null |
                                 "".equals(obj.getCertdoctype()) | obj.getCertdoctype() == null	|
                                 "".equals(obj.getCertexp()) | obj.getCertexp() == null ) )
                         {
                             actlobjAL.add(obj);  
                         }
                     }
                 }//end of if("CR2".equals(obj.getTvlstatus()))
                 
                 //CR1 check 4 certXXXs
                 if("CR1".equals(obj.getTvlstatus()) && ( "".equals(obj.getCertno()) | obj.getCertno() == null | 
                    "".equals(obj.getCertctry()) | obj.getCertctry() == null |
                    "".equals(obj.getCertdoctype()) | obj.getCertdoctype() == null	|
                    "".equals(obj.getCertexp()) | obj.getCertexp() == null ))
                 {
                     actlobjAL.add(obj); 
                 }                 
             }             
         }
     }
     
     
     public String getGctp(String empno) 
     {
         int idx = 0;
         String gctp = "N";
         idx = empnAL.indexOf(empno);
         if ( idx != -1 ) 
         {
             gctp = (String) gctpAL.get(idx);
         }         
         return gctp;
     }
    
   
    public ArrayList getObjAL()
    {
        return actlobjAL;
    }
    
    public String getStr()
    {
        return returnstr;
    }
    
    public String getSql()
    {
        return sql2;
    }
    
    public int getCount()
    {
        return total;
    }
}
