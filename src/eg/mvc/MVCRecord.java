package eg.mvc;
import java.sql.*;
import java.util.*;

import tool.*;
import ci.db.*;
/**
 * @author cs71 Created on  2006/7/13
 */
public class MVCRecord
{
    private String sql = null;
    private ArrayList objAL = new ArrayList();
    private ArrayList alcsobjAL = new ArrayList();
    private String errorstr = "";
    private String returnstr = "";  
    
    public static void main(String[] args)
    {
//    SELECT [cardnum],[lastname],[fstname1],[fstname2],[chinname],[title],[titlec],[gender],[type],[code],[desc],[typedesc]
//    FROM [cal.itvbzaa]        
        MVCRecord mvc = new MVCRecord();
        String cardnum = mvc.getCardnum("SYS","*CI0018/25OCT/TPE");
        //String cardnum = mvc.getCardnum("SYS","*CI0018/25OCT/TPE");
//        String cardnum = mvc.getCardnum2("SYS","*CI0018/25OCT/TPE");
//        String cardnum = mvc.getCardnum("SYS","*CI0004/01APR/SFO");         
               
        if(!"".equals(cardnum))
        {
            mvc.getMVCData(cardnum);
        }
//      ArrayList objAL = mvc.getObjAL();
        System.out.println(" mvc.getObjAL().size() "+mvc.getObjAL().size());
//        
//        for(int i=0; i<mvc.getObjAL().size(); i++)
//        {
//            MVCObj obj = (MVCObj) mvc.getObjAL().get(i);
//            System.out.println("getCardnum     "+obj.getCardnum());
//            System.out.println("getCname       "+obj.getCname());
//            System.out.println("getCabin_class "+obj.getCabin_class());
//            System.out.println("getSeatno      "+obj.getSeatno());
//        }
    }
    
    public String getCardnum(String userid, String flt_info)
    {
        String cardnum="";
        String hostResponse="";
//      set ConnectionUtility --> DEFAULT_SERVER_PORT Live -> 4036; Test -> 4038;  
//        String alcs_session = "TPEZZ300";//live
//        String alcs_sine_code ="BSIA6356TM/PD";//live
        String alcs_sine_code ="BSIA8155CS/PD";//live
        
//        String  alcs_session = "MVCPNR01";//test
//        String alcs_sine_code ="BSIA6666CI/GS";//test
        
        ArrayList objAL_local = new ArrayList();       
        
        ConnectionUtility myConnector = new ConnectionUtility();
        myConnector.setUser(userid);
        myConnector.setsession();
        myConnector.setdoconnect();
        myConnector.setdata("UR");
        myConnector.setdata("BSA");
        myConnector.setdata(alcs_sine_code);
        myConnector.setdata("UC");
//        myConnector.setdata("*CI0512/22MAR/PEK");
        myConnector.setdata(flt_info);
        myConnector.setdata("@P/VC");  
        hostResponse = myConnector.getdata();
        
//        System.out.println(hostResponse);
        
        if(hostResponse.length()>0)
        {
            //get customer num
        	
            String cus_num = "";
	        splitString p = new splitString();
	        ArrayList strAL = p.doSplit2(hostResponse,"\n");        
	        for(int i=0; i < strAL.size(); i++)
	        { 
	            if(((String)strAL.get(i)).indexOf(">")<0)
	            {
	                objAL_local.add(strAL.get(i));
	            }
//	            System.out.println(strAL.get(i));                
	        } 
	        
//System.out.println("$$"+hostResponse);
	        int page = 0;
	        while(hostResponse.indexOf("END NAMES")<0 && hostResponse.indexOf("FULL FLT ASSIGNMENT REQUIRED")<0)
	        {
	            myConnector.setdata("MD");  
	            hostResponse = myConnector.getdata();
//System.out.println("## "+hostResponse);
	            strAL.clear();
	            strAL = p.doSplit2(hostResponse,"\n");    
	            
	            for(int i=0; i < strAL.size(); i++)
	            {
                    if(((String)strAL.get(i)).indexOf(">")<0)
    	            {
                        objAL_local.add(strAL.get(i));
//System.out.println("@@ "+strAL.get(i));
    	            }	    
	            } 
	          //FLIGHT OFFLINE FROM THIS STN exception 2013/04/01新增 
	        	page ++;
	        	if(page > 10){
	        		break;
	        	}
	        }       
        }
        //connection close
        myConnector.endDoconnect();
        
        Hashtable cardnumHT = new Hashtable();
        for(int i=1; i<objAL_local.size(); i++)
        {            
            if(((String) objAL_local.get(i)).indexOf(".") >=0 | ((String) objAL_local.get(i)).indexOf("END NAMES") >=0)
            {
//                System.out.println("** "+(String) objAL_local.get(i));
                    cardnumHT.put(objAL_local.get(i-1),"");
            }
//            System.out.println(objAL.get(i));           
        }
        
        Set keyset = cardnumHT.keySet();
	    Iterator i = keyset.iterator();
	    boolean iffirst = true;
        while(i.hasNext())
    	{
            String key = String.valueOf(i.next()).replaceAll(" ","");
            if(iffirst == true)
            {
                cardnum = "'"+key+"'";   
                iffirst = false;
            }
            else
            {
                cardnum = cardnum+",'"+key+"'";    	    
            }
//System.out.println("cardnum "+ cardnum);            
    	}
    
        return cardnum;
    }
    
    public void getMVCData(String cardnum)
    { 
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try
        {
            DB2Conn cn = new DB2Conn();
//	        cn.setDB2TUser();
//            cn.setDB2PUser();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = conn.createStatement();	
  	
	    	cn.setDB2UserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
            
//          ******************************************************************************   
     		sql = " select * from cal.itvbzaa  where cardnum in ("+cardnum+") and type <> 'M' and type <> 'V' order by cardnum, type, code ";
//     		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
//            System.out.println(sql); 
//            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
            rs = stmt.executeQuery(sql);
            MVCObj emptyobj = new MVCObj();
            objAL.add(emptyobj);
            while (rs.next())
            {
                MVCObj obj = new MVCObj();
                obj.setCardnum(rs.getString("cardnum"));
                obj.setCname(rs.getString("chinname"));
                obj.setEname(rs.getString("lastname")+", "+rs.getString("fstname1"));
                obj.setEname2(rs.getString("fstname2"));
                obj.setCompany_cname(rs.getString("corpnamc"));
                obj.setCompany_ename(rs.getString("corpname"));
                obj.setCard_type(rs.getString("cardtype"));
                obj.setTitle(rs.getString("title"));
                obj.setTitle_desc(rs.getString("titlec"));
                obj.setGender(rs.getString("gender"));
                obj.setType(rs.getString("type"));
                obj.setType_desc(rs.getString("typedesc"));
                obj.setCode(rs.getString("code"));
                obj.setCode_desc(rs.getString("desc"));
                obj.setBrthdt(rs.getString("brthdt"));
                obj.setNote(rs.getString("note"));
                objAL.add(obj);
            }
            objAL.add(emptyobj);
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@SQL error : "+e.toString());
            errorstr = e.toString();
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }        
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public String getCardnum2(String userid, String flt_info)
    {
        String cardnum="";
        String hostResponse="";
//      set ConnectionUtility --> DEFAULT_SERVER_PORT Live -> 4036; Test -> 4038;  
//        String alcs_session = "TPEZZ300";//live
//        String alcs_sine_code ="BSIA6356TM/PD";//live
        String alcs_sine_code ="BSIA8155CS/PD";//live
        
//        String  alcs_session = "MVCPNR01";//test
//        String alcs_sine_code ="BSIA6666CI/GS";//test
        
        ArrayList objAL_local = new ArrayList();       
        
        ConnectionUtility myConnector = new ConnectionUtility();
        myConnector.setUser(userid);
        myConnector.setsession();
        myConnector.setdoconnect();
        myConnector.setdata("UR");
        myConnector.setdata("BSA");
        myConnector.setdata(alcs_sine_code);
        myConnector.setdata("UC");
//        myConnector.setdata("*CI0512/22MAR/PEK");
        myConnector.setdata(flt_info);
        myConnector.setdata("@P/VC");  
        hostResponse = myConnector.getdata();
        
//        System.out.println(hostResponse);
        int page = 0;
        if(hostResponse.length()>0)
        {
            //get customer num
            String cus_num = "";
	        splitString p = new splitString();
	        ArrayList strAL = p.doSplit2(hostResponse,"\n");        
	        for(int i=0; i < strAL.size(); i++)
	        { 
	            if(((String)strAL.get(i)).indexOf(">")<0)
	            {
	                objAL_local.add(strAL.get(i));
	            }        
	        } 
       
	        while(hostResponse.indexOf("END NAMES")<0 && hostResponse.indexOf("FULL FLT ASSIGNMENT REQUIRED")<0)
	        {
	            myConnector.setdata("MD");  
	            hostResponse = myConnector.getdata();
//System.out.println("## "+hostResponse);
	            strAL.clear();
	            strAL = p.doSplit2(hostResponse,"\n");    
	            
	            for(int i=0; i < strAL.size(); i++)
	            {
                    if(((String)strAL.get(i)).indexOf(">")<0)
    	            {
                        objAL_local.add(strAL.get(i));
    	            }	    
	            } 
	            //FLIGHT OFFLINE FROM THIS STN exception 2013/04/01新增 
	            page ++;
	            if(page > 10){
	            	break;
	            }
	        }       
	        
        }
        //connection close
        myConnector.endDoconnect();
                
        int line = 1;
        MVCObj obj = null;
        for(int i=1; i<objAL_local.size(); i++)
        { 
            if(((String) objAL_local.get(i)).indexOf(".") >=0 )
            {
                line = 1;
                obj = new MVCObj();
                String temp_str = (String) objAL_local.get(i);
                obj.setCabin_class(temp_str.substring(19,21));
                obj.setSeatno(temp_str.substring(28,32)); 
//              System.out.println(temp_str);
//              System.out.println(temp_str.substring(19,21));
//              System.out.println(temp_str.substring(28,32));
            }
            line ++;
            
            if(line==5)
            {
                obj.setCardnum(((String)objAL_local.get(i)).replaceAll(" ",""));
                alcsobjAL.add(obj);            
            }
//            System.out.println(objAL.get(i));           
        }//for(int i=1; i<objAL_local.size(); i++)
        
//        System.out.println("objAL.size() = "+objAL.size());
//        for(int q=0; q<objAL.size(); q ++)
//        {
//            MVCObj obja = (MVCObj) objAL.get(q);
//            System.out.println(obja.getSeatno()+" * "+ obja.getCabin_class()+" * "+obja.getCardnum());
//        }        
        
        for(int q=0; q<alcsobjAL.size(); q ++)
    	{            
            MVCObj obja = (MVCObj) alcsobjAL.get(q);
            if(q == 0)
            {
                cardnum = "'"+obja.getCardnum()+"'";  
            }
            else
            {
                cardnum = cardnum+",'"+obja.getCardnum()+"'";    	    
            }
//System.out.println("cardnum "+ cardnum);            
    	}
        
        return cardnum;
    }
    
    public void getMVCData2(String cardnum)
    { 
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try
        {
            DB2Conn cn = new DB2Conn();
//	        cn.setDB2TUser();
//            cn.setDB2PUser();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//	    	stmt = conn.createStatement();	
  	
	    	cn.setDB2UserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
            
//          ******************************************************************************   
     		sql = " select * from cal.itvbzaa  where cardnum in ("+cardnum+") and type <> 'M' and type <> 'V' order by cardnum, type, code ";
//     		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
//            System.out.println(sql); 
//            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
            rs = stmt.executeQuery(sql);
            MVCObj emptyobj = new MVCObj();
            objAL.add(emptyobj);
            while (rs.next())
            {
                MVCObj obj = new MVCObj();
                obj.setCardnum(rs.getString("cardnum"));
                obj.setCname(rs.getString("chinname"));
                obj.setEname(rs.getString("lastname")+", "+rs.getString("fstname1"));
                obj.setEname2(rs.getString("fstname2"));
                obj.setCompany_cname(rs.getString("corpnamc"));
                obj.setCompany_ename(rs.getString("corpname"));
                obj.setCard_type(rs.getString("cardtype"));
                obj.setTitle(rs.getString("title"));
                obj.setTitle_desc(rs.getString("titlec"));
                obj.setGender(rs.getString("gender"));
                obj.setType(rs.getString("type"));
                obj.setType_desc(rs.getString("typedesc"));
                obj.setCode(rs.getString("code"));
                obj.setCode_desc(rs.getString("desc"));
                obj.setBrthdt(rs.getString("brthdt"));
                obj.setNote(rs.getString("note"));
                //2012/10/24 新增艙等及座位號碼
                for(int q=0; q<alcsobjAL.size(); q ++)
            	{            
                    MVCObj obja = (MVCObj) alcsobjAL.get(q);
                    if(obja.getCardnum().equals(obj.getCardnum()))
                    {
                        obj.setSeatno(obja.getSeatno());
                        obj.setCabin_class(obja.getCabin_class());
                    }
            	}     
                //*************************************************
                objAL.add(obj);
            }
            objAL.add(emptyobj);
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@SQL error : "+e.toString());
            errorstr = e.toString();
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }        
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
       
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public String getStr()
    {
        return errorstr;
    }
    
    public String getSql()
    {
        return sql;
    }
}
