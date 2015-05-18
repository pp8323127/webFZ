package fz.projectinvestigate;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/9/25
 */
public class PRProjTemplate
{
	ArrayList objAL = new ArrayList();	
	
    public static void main(String[] args)
    {
        PRProjTemplate pjt = new PRProjTemplate();
        pjt.getTemplate();
        System.out.println(pjt.getObjAL().size());
        System.out.println("Done");
    }    
    
    public void getTemplate() 
    {   
        Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;	
    	String sql = null;
    	Driver dbDriver = null;       	
       
        try
        {  
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
			
            sql = " SELECT tc.*, fi.itemdesc FROM egtpjtc tc, EGTPSFI fi " +
			      " WHERE tc.item_no = fi.itemno  AND fi.kin = 'B' order by comment_no ";
//			System.out.println(sql);
			rs = stmt.executeQuery(sql);

			while(rs.next())
			{
			    PRProjTemplateObj obj = new PRProjTemplateObj();
			    obj.setComment_no(rs.getString("comment_no"));
			    obj.setItem_no(rs.getString("item_no"));
			    obj.setItem_desc(rs.getString("itemdesc"));
			    obj.setComment_desc(rs.getString("comment_desc"));			
			    objAL.add(obj);
			}
        }
        catch (Exception e)
        {               
               System.out.println(e.toString());
        } 
        finally
        {
            try{if(rs != null) rs.close();}catch (Exception e){}
        	try{if(stmt != null) stmt.close();}catch (Exception e){}
        	try{if(conn != null) conn.close();}catch (Exception e){}        	
        }
   } 
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
}
