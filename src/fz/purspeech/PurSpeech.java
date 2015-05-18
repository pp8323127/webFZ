package fz.purspeech;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2006/10/23
 */
public class PurSpeech
{
    Driver dbDriver = null;
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = "";
    ArrayList quesAL = new ArrayList();
    ArrayList subjAL = new ArrayList();
    ArrayList replyAL = new ArrayList();
    
    public static void main(String[] args)
    {
        PurSpeech ps = new PurSpeech();
        ps.getAllSubj();
//        ps.getReply("200603");
        System.out.println(ps.getSubjExpl("200603"));
        System.out.println(ps.getSubj("200603"));
        System.out.print("Done");
    }
    
    public void getAllSubj()
    {
        try
        {
            ConnDB cn = new ConnDB();
//	        cn.setORP3EGUser();        
//	        java.lang.Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//	        stmt = conn.createStatement();
	   
	        cn.setORP3EGUserCP();
	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        conn = dbDriver.connect(cn.getConnURL(), null);
	        stmt = conn.createStatement();
	
	        sql = "SELECT formno, subject, explain FROM egtpsph order by formno desc";
	        rs = stmt.executeQuery(sql);
	        
	        while (rs.next())
	        {
	            PurSpeechSubjObj obj = new PurSpeechSubjObj();
	            obj.setFormno(rs.getString("formno"));
	            obj.setSubj(rs.getString("subject"));
	            obj.setDesc(rs.getString("explain"));     
	            subjAL.add(obj);
	        }     
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        }
        finally
        {
        	try{if(rs != null) rs.close();}catch(SQLException e){}
        	try{if(stmt != null) stmt.close();}catch(SQLException e){}
        	try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public ArrayList getSubjAL()
    {
        return subjAL;
    }
    
    public void getReply(String formno)
    {
        try
        {
            ConnDB cn = new ConnDB();
//	        cn.setORP3EGUser();        
//	        java.lang.Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//	        stmt = conn.createStatement();
	   
	        cn.setORP3EGUserCP();
	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        conn = dbDriver.connect(cn.getConnURL(), null);
	        stmt = conn.createStatement();
	        
	        sql = " SELECT itemno FROM egtpspq WHERE formno = '"+formno+"'";
	        rs = stmt.executeQuery(sql);
	        while (rs.next())
	        {
	            quesAL.add(rs.getString("itemno"));	        
	        }         
	
	        sql = " SELECT pa.formno formno, pa.itemno itemno, pq.ques ques, pa.empno empno, " +
	        	  " decode(pa.itemdsc,'none','µL',pa.itemdsc) itemdsc, " +
	        	  " decode(pa.itemdsc2,'none',' ',pa.itemdsc2) itemdsc2, nvl(pa.reply,' ') reply " +
	        	  " FROM egtpspa  pa, egtpspq pq, egtpspo po " +
	        	  " where pa.formno = '"+formno+"' AND pa.formno = pq.formno " +
	        	  " AND pa.itemno = pq.itemno AND po.formno = pa.formno AND po.empno = pa.empno " +
	        	  " order by pa.empno ";
	        
	        rs = stmt.executeQuery(sql);
	        
	        EGPurInfo eg = new EGPurInfo();	        
	        while (rs.next())
	        {
	            PurSpeechObj obj = new PurSpeechObj();
	            obj.setFormno(rs.getString("formno"));
	            obj.setItemno(rs.getString("itemno"));
	            obj.setQues(rs.getString("ques"));
	            obj.setEmpno(rs.getString("empno"));
	            obj.setCname(eg.getCname(rs.getString("empno")));
	            obj.setEname(eg.getEname(rs.getString("empno")));
	            obj.setSern(eg.getSern(rs.getString("empno")));
	            obj.setSection(eg.getSection(rs.getString("empno")));	    
	            obj.setItemdsc(rs.getString("itemdsc"));	            
	            obj.setItemdsc2(rs.getString("itemdsc2"));
	            obj.setReply(rs.getString("reply"));
	            replyAL.add(obj);
	        }      
        }
        catch(Exception e)
        {
        	System.out.print(e.toString());
        }
        finally
        {
        	try{if(rs != null) rs.close();}catch(SQLException e){}
        	try{if(stmt != null) stmt.close();}catch(SQLException e){}
        	try{if(conn != null) conn.close();}catch(SQLException e){}
        }
    }
    
    public ArrayList getReplyAL()
    {
        return replyAL;
    }
    
    public ArrayList getQuesAL()
    {
        return quesAL;
    }
    
    public String getSubj(String formno)
    {
        String tempsubj ="";
        for(int j=0; j< subjAL.size(); j++)
        {
            PurSpeechSubjObj obj = (PurSpeechSubjObj) subjAL.get(j);
            if(obj.getFormno().equals(formno))
            {
                tempsubj = obj.getSubj();
            }
        }
        return tempsubj;
    }
    
    public String getSubjExpl(String formno)
    {
        String tempexpl ="";
        for(int j=0; j< subjAL.size(); j++)
        {
            PurSpeechSubjObj obj = (PurSpeechSubjObj) subjAL.get(j);
            if(obj.getFormno().equals(formno))
            {
                tempexpl = obj.getDesc();
            }
        }
        return tempexpl;
    }
}
