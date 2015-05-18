package fz.ipad;

import java.io.*;
import java.util.*;
import java.util.regex.*;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.*;
import org.apache.commons.lang.*;

/**
 * @author CS71 Created on  2012/10/8
 */
public class PRGetEbook
{
    int i = 0;
    ArrayList fileAL = new ArrayList();
    ArrayList dirAL = new ArrayList();
    public static void main(String[] args)
    {
        PRGetEbook prgeb = new PRGetEbook();
//        File file = new File("E://workspace/FZ/src/eg");
//        File file = new File("//TPECSAP04/mpur");
//        
//        prgeb.readFiles(file);
//        ArrayList fileAL = new ArrayList();
//        fileAL = prgeb.getFileAL();
//        System.out.println(fileAL.size());
//        
//        for(int i=0; i<fileAL.size(); i++)
//        {
//            System.out.println(fileAL.get(i));
//        }
//      import org.apache.commons.io.FileUtils;
        
//        prgeb.getURLSrc("http://ocskj.china-airlines.com/live/mpur/EZ/"); 
        prgeb.parseDir("http://ocskj.china-airlines.com/live/mpur/") ;
        for(int i=0; i<prgeb.getDirAL().size(); i++ )
        {
//            prgeb.parseFile("http://ocskj.china-airlines.com/live/mpur/"+(String)prgeb.getDirAL().get(i), (String)prgeb.getDirAL().get(i)) ;
            prgeb.parseFile2("http://ocskj.china-airlines.com/live/mpur/"+(String)prgeb.getDirAL().get(i), (String)prgeb.getDirAL().get(i)) ;
//            System.out.println((String)prgeb.getDirAL().get(i));
            for(int j=0; j<prgeb.getFileAL().size(); j++ )
            {
                PRGetEbookObj obj = (PRGetEbookObj) prgeb.getFileAL().get(j);
                //System.out.println("prgeb.getDirAL() "+ prgeb.getDirAL() + " obj.getFolder() "+ obj.getFolder());
                if(((String)prgeb.getDirAL().get(i)).equals(obj.getFolder()))
                {
                    System.out.println(obj.getFolder());                
	                System.out.println("     "+obj.getFile_info());                
	                System.out.println("     "+obj.getFilename());
	                System.out.println("     "+obj.getUrl());
                }
//                System.out.print("http://ocskj.china-airlines.com/live/mpur/"+(String)prgeb.getDirAL().get(i));
//                System.out.println("/"+prgeb.getFileAL().get(j));
            }
        }
        System.out.println("Done");
    }
    
    public void readFiles(File file) 
    {        
        if (file.isDirectory())
		{
//            System.out.println(file.getName()+"***"+file.getPath());
            fileAL.add(file.getName()+"***"+file.getPath());
			File[] files = file.listFiles();	
			for (int index = 0; index < files.length; index++) 
			{			   	    
				readFiles(files[index]);
			}
		} 
		else if (file.isFile()) 
		{
			
			String content = null;
			try 
			{
//			    System.out.println(file.getName()+"***"+file.getPath());
			    fileAL.add(file.getName()+"***"+file.getPath());
				//	開始讀取文件
				//content = FileUtils.readFileToString(file, "big5");				
				//	處理文件內容
				//System.out.println(content);

			} 
			catch (Exception e) 
		    {
				System.out.println("ERROR:\nFILEPATH" + file.getName()+" "+e.toString());
//				e.printStackTrace();
			} 
			finally 
		    {
				//file.delete();
			}
		}
	}   
    
    public String getURLSrc(String www) 
    {   
        GetMethod redirect = null;
        String content = "";
		
		try 
		{
			HttpClient client = new HttpClient();
			redirect = new GetMethod(www);			
			client.executeMethod(redirect);			
			content = StringUtils.trimToNull(redirect.getResponseBodyAsString());
//			content = redirect.getResponseBodyAsString();
			content = new String(content.getBytes("ISO-8859-1"),"BIG5");
//			System.out.println(content);
		} 
		catch (Exception e) 
		{
			System.out.println("ERROR : "+e.toString());
			e.printStackTrace();

		} 
		finally 
		{
			redirect.releaseConnection();
		}		
		return content;
	}
    
    public void parseDir(String www) 
    {
        String htmlContent = getURLSrc(www); 
        Pattern pTable = Pattern.compile("<A(.+?)</A>", Pattern.MULTILINE);
        Matcher mTable = null;
        
        try 
        {
			mTable = pTable.matcher(htmlContent);			
			while (mTable.find())
			{
				htmlContent = mTable.group(1);				
				if(htmlContent.indexOf("live/mpur/")>0)
				{				    
				    dirAL.add(htmlContent.substring(htmlContent.indexOf(">")+1));
				}				
			}
		} 
        catch (Exception e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("ERROR : "+e.toString());
		}
	}   
    
    public void parseFile(String www, String dir) 
    {
        String htmlContent = getURLSrc(www); 
        Pattern pTable = Pattern.compile("<A(.+?)</A>", Pattern.MULTILINE);
        Matcher mTable = null;
        fileAL.clear();
        
        try 
        {
			mTable = pTable.matcher(htmlContent);			
			while (mTable.find())
			{
				htmlContent = mTable.group(1);				
				if(htmlContent.indexOf("live/mpur/"+dir+"/")>0)
				{
				    fileAL.add(htmlContent.substring(htmlContent.indexOf(">")+1));
				}				
			}
			
			for(int f=0; f < fileAL.size(); f++)
			{
//			    System.out.println(fileAL.get(f));
			}
		} 
        catch (Exception e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("ERROR : "+e.toString());
		}
	}     
    
    public void parseFile2(String www, String dir) 
    {
        
        String htmlContent = getURLSrc(www); 
        
//        System.out.println("##");
//        System.out.println(htmlContent);
//        System.out.println("**");
        
        tool.splitString p = new tool.splitString();
        ArrayList  strAL = p.doSplit2(htmlContent,"<br>");
//        System.out.println("DIR -- > "+dir);
        for(int i=2; i < strAL.size(); i++)
        {
            if(((String)strAL.get(i)).indexOf("live/mpur/"+dir+"/")>0)
            {
//                System.out.println("## "+i+" --> "+((String)strAL.get(i)).replaceAll("br>|     ",""));
                PRGetEbookObj obj = new PRGetEbookObj();
                String str = ((String)strAL.get(i)).replaceAll("br>|     ","");
                obj.setFolder(dir);
                obj.setFile_info(str.substring(0,str.indexOf("<A")));
                obj.setUrl(str.substring(str.indexOf("<A")));                
                obj.setFilename(str.substring(str.indexOf(">")+1,str.indexOf("</A>")));
                
//                System.out.println("DIR --> "+obj.getFolder());
//                System.out.println(obj.getFile_info());
//                System.out.println(obj.getUrl());
//                System.out.println(obj.getFilename());
//                System.out.println("****************");                
                fileAL.add(obj); 
            }
        }        
	} 

    public ArrayList getDirAL()
    {
        return dirAL;
    }
    public void setDirAL(ArrayList dirAL)
    {
        this.dirAL = dirAL;
    }    
    
    public ArrayList getFileAL()
	{
	    return fileAL;
	} 
}
