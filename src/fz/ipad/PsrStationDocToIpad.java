package fz.ipad;
import java.io.*;
import java.sql.*;
import java.util.*;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
/**
 * @author cs71 Created on  2006/7/13
 */
public class PsrStationDocToIpad
{
    private String sql = null;
    private ArrayList objAL = new ArrayList();
    private String errorstr = "";
    
    public static void main(String[] args)
    {
        //[DIP_EZ].[dbo].[EZ_PURSER_VIEW2] & [DIP_EZ].[dbo].[XT_ATTACHEDFILE_VIEW]
        
        PsrStationDocToIpad dip = new PsrStationDocToIpad();
        dip.getEZDIPDoc();
        dip.getDIPAttachFile();
//        dip.combinePDF();
        System.out.println(dip.getObjAL().size());
    }
    
    public void getEZDIPDoc()
    { 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;    
        
        try
        {
            MSSQLConn db = new MSSQLConn();
	        db.setDIPConn();	        
	        Class.forName(db.getDriver());
	        conn = DriverManager.getConnection(db.getConnURL(), db.getConnID(),db.getConnPW());	        
	        stmt = conn.createStatement();

	        sql = " select * from [DIP_EZ].[dbo].[EZ_PURSER_VIEW2] where pk = '182' or pk = '549' or pk='557'";
//	        sql = " select * from [DIP_EZ].[dbo].[EZ_PURSER_VIEW2] ";
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                PsrStationDocToIpadObj obj  = new PsrStationDocToIpadObj();
                obj.setPk(rs.getString("pk"));
                obj.setSubject(rs.getString("subject"));
                obj.setContentPK(rs.getString("contentPK"));
                obj.setDateedit(rs.getString("dateedit"));               
                obj.setDateon(rs.getString("dateon"));
                obj.setDateoff(rs.getString("dateoff"));    
                obj.setDefaultlang(rs.getString("defaultlang"));
                obj.setAuthor_empno(rs.getString("author_empno"));
                obj.setAuthor_cname(rs.getString("author_cname"));
                obj.setAuthor_ename(rs.getString("author_ename"));
                obj.setAuthor_ext(rs.getString("author_ext"));
                obj.setPktab(rs.getString("pktab"));
                obj.setTitle(rs.getString("title"));
                obj.setContent(rs.getString("content"));
                obj.setText(rs.getString("text"));
                objAL.add(obj); 
            }
            
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( SQLException e )
        {
            System.out.println("SQL error : "+e.toString());
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
    
    public void getDIPAttachFile()
    { 
//        String folder_path = "C:/ipad/";
        String folder_path = "/apsource/csap/projfz/txtin/ipad/";
        
        File dir = new File(folder_path); 
        String[] children = dir.list(); 
        
        for(int i=0; i<children.length; i++)
        {
            //System.out.println(children[i]);
            File f = new File(folder_path + children[i]); 
            f.delete();     
        }
        
        if(objAL.size()>0)
        {
            Connection conn = null;
	        Statement stmt = null;
	        ResultSet rs = null;    
	       
	        
	        try
	        {	            
	            MSSQLConn db = new MSSQLConn();
		        db.setDIPConn(); 
		        Class.forName(db.getDriver());
		        conn = DriverManager.getConnection(db.getConnURL(), db.getConnID(),db.getConnPW());
		        stmt = conn.createStatement();
		        
	            for(int i=0; i<objAL.size(); i++)
	            {
	                String filepk ="";
		            PsrStationDocToIpadObj obj  = (PsrStationDocToIpadObj) objAL.get(i);		            
		            //System.out.println(obj.getContent());
		            int idx = obj.getContent().indexOf("filepk=");
		            //System.out.println("idx "+idx);
		            if(idx>0)
		            {
		                int idx2 = (obj.getContent().substring(idx)).indexOf(">");
		                if(idx2>0)
		                {
		                    //System.out.println("idx2 "+idx2);
		                //}
		                filepk = obj.getContent().substring(idx,idx+idx2).replaceAll("filepk=|\"","");
		            
			
				        sql = " select * from [DIP_EZ].[dbo].[XT_ATTACHEDFILE_VIEW] where pk ='"+filepk+"' " +
				        	  " and filename like '%.pdf'; ";
//			            System.out.println(sql);
			            rs = stmt.executeQuery(sql);
			
			            if (rs.next())
			            {		                
			                obj.setFilepk(rs.getString("pk"));
			                obj.setFilename(rs.getString("filename"));
			                obj.setContenttype(rs.getString("contenttype"));		
			                OutputStream out = new FileOutputStream(folder_path+obj.getFilename());
			                out.write(rs.getBytes("blob"));
			                out.close();
			            }
		                }
			            rs.close();
		            }//if(idx>0)
		       }//for(int i=0; i<objAL.size(); i++)
	        }
	        catch ( SQLException e )
	        {
	            System.out.println("SQL error : "+e.toString());
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
	        
        }//if objAL.size()>0
    }
    
    public void combinePDF()
    { 
        String filename = "test.pdf";
//      String folder_path = "/apsource/csap/projfz/txtin/ipad/";        
        String folder_path = "C:\\ipad\\";
    	File dir = new File(folder_path); 
    	String[] files = dir.list(); 	
//    	String savepath = "/apsource/csap/projfz/FZ/ipad/test.pdf";
    	String savepath = "C:\\ipad\\test.pdf"; 

    	try    
    	{   
    		Document document = new Document(PageSize.A4);   
    		//PdfCopy copy = new PdfCopy(document,  outputStream); 
    		PdfCopy copy = new PdfCopy(document,  new FileOutputStream(savepath+"/"+filename)); 
    		document.open();   
    		   
    		for(int i=0; i<files.length; i++)   
    		{   
    		    System.out.println(folder_path+files[i]);
    			PdfReader reader = new PdfReader(folder_path+"/"+files[i]);   			   
    			int n = reader.getNumberOfPages();  
    			for(int j=1; j<=n; j++)   
    			{   				
    				document.newPage();    
    				PdfImportedPage page = copy.getImportedPage(reader,j);   
    				copy.addPage(page);   
    			}   
    		} 
    		document.close(); 		
    	} 
    	catch (IOException e) 
    	{   
    		e.printStackTrace();   
    		System.out.println(e.toString());
    	} 
    	catch(DocumentException e) 
    	{   
    		e.printStackTrace();   
    		System.out.println(e.toString());
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
