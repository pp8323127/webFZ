package ws;

import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;
import java.io.*;
import java.util.*;
import java.util.zip.ZipInputStream ;
import ftp.*;
//import org.apache.commons.fileupload.*;


public class UnZipBean 
{    
    public static void main(String[] args)
    {
//        String zipFile = "c:\\zip\\test.zip"; 
//        String fnm = "c:\\zip\\test2.zip"; 
//        String targetDirectory = "c:\\zip";            
//        
//        UnZipBean uzb = new UnZipBean(zipFile, targetDirectory);          
//        byte[] file_btye = uzb.readZipFile(zipFile);
//        uzb.writeByteToZip(fnm,file_btye);
//        System.out.println("byte array len "+file_btye.length);
//        boolean succ = uzb.unzip();  
//        if (succ) 
//        {
//            System.out.println(uzb.getZipFile() + " UnZipped");
//        }
//        
//        String[] fileAL = null;
//        fileAL = uzb.getFileAL();        
//        
//        for(int i=0; i<fileAL.length; i++)
//        {
//            System.out.println(fileAL[i]);            
//        }
        String targetDirectory = "E:\\";
//        String zipFile =  "E:\\2013106TPEHIJ0112.zip";
        String zipFile = "E:\\ebill.zip";
        UnZipBean uzb = new UnZipBean(zipFile, targetDirectory);          
        byte[] file_btye = uzb.readZipFile(zipFile);
        System.out.println("byte array len "+file_btye.length);

        
    }
    
    public static final int EOF = -1; 
    static final int BUFFER = 2048;
    private String zipFile;
    private String targetDirectory;
    private ZipFile zf;
//    ArrayList fileAL = new ArrayList();    
    String[] fileAL = null;
    
    public UnZipBean() 
    {
    }  
    
    public UnZipBean(String zipFile, String targetDirectory) 
    {
        this.zipFile = zipFile;
        this.targetDirectory = targetDirectory;
    }  
    
    public void setZipFile(String zipFile) 
    {
        this.zipFile = zipFile;
    }
    public String getZipFile() 
    {
        return zipFile;
    }
    public void setTargetDirectory(String targetDirectory) 
    {
        this.targetDirectory = targetDirectory;
    }  
    
    public String getTargetDirectory() 
    {
        return targetDirectory;
    }

    public boolean unzip() 
    { 
        boolean done = false;
        int idx = 0;
        if (zipFile != null) 
        { 
            try 
            {
                zf = new ZipFile(zipFile);                
                Enumeration enumeration = zf.entries();
                while (enumeration.hasMoreElements()) 
                {
                    ZipEntry target = (ZipEntry)enumeration.nextElement(); 
//                    System.out.println(target.getName());
                    saveEntry(target);
//                    fileAL.add((String)target.getName());
                    fileAL[idx] = (String)target.getName();
                    idx++;
                    //System.out.println(". unpacked");
                }
                done = true;
            } 
            catch (FileNotFoundException e)
            {
                System.out.println("zipfile not found"+e.getMessage()); 
            }
            catch (ZipException e)
            {
                System.out.println("zip error..."+e.getMessage());
            }
            catch (IOException e)
            {
            System.out.println("IO error..."+e.getMessage());
            }
            finally 
            {
                try 
                {
                    zf.close();
                } 
                catch (IOException e) 
                { 
                    System.out.println("IO error...Can't close zip file"+e.getMessage()); 
                } 
            } 
        }
        return done;
    }

    private void saveEntry(ZipEntry target)throws ZipException, IOException 
    {
         try 
         {  
            File file = new File(targetDirectory + File.separator + target.getName());
            if (target.isDirectory()) 
            {
                file.mkdirs(); 
            }
            else 
            {
                InputStream is = zf.getInputStream(target); 
                BufferedInputStream bis = new BufferedInputStream(is);
                File dir = new File(file.getParent());
                dir.mkdirs();
                FileOutputStream fos = new FileOutputStream(file);
                BufferedOutputStream bos = new BufferedOutputStream(fos);
                int c;
                byte[] data = new byte[BUFFER];
                while((c = bis.read(data, 0, BUFFER)) != EOF) 
                { 
                    bos.write(data, 0, c);
                }
                bos.flush();
                bos.close();
                fos.close();
             } 
        }
        catch (ZipException e) 
        {
            throw e; 
        }
        catch (IOException e) 
        {
            throw e;
        }
    }
    
   //byte[] to zip
    public void writeByteToZip(String fnm, byte[] file_byte)
    { 
//        File file = new File("c:\\zip\\test2.zip"); 
        File file = new File(fnm); 
        FileOutputStream fos = null;
        try 
        { 
            fos = new FileOutputStream(file); 
            // Writes bytes from the specified byte array to this file output stream? 
            //fos.write(readZipFile("c:\\zip\\test.zip")); 
            fos.write(file_byte);
        }
        catch (FileNotFoundException e) 
        { 
            System.out.println("File not found" + e); 
        } 
        catch (IOException ioe) 
        { 
            System.out.println("Exception while writing file " + ioe); 
        } 
        finally 
        { 
            // close the streams using close method 
            try 
            { 
                if (fos != null) 
                {
                    fos.close(); 
                } 
            } 
            catch (IOException ioe) 
            { 
                 System.out.println("Error while closing stream: " + ioe); 
            } 
        }
    } 
    
    //zip to byte[]
    public byte[] readZipFile(String zipFnm)
    // read in fnm, returning it as a single string
    {    
       FileInputStream fileInputStream=null;
    
       File file = new File(zipFnm);
    
       byte[] bFile = new byte[(int) file.length()];
    
       try
       {
         //convert file into array of bytes
         fileInputStream = new FileInputStream(zipFnm);
         fileInputStream.read(bFile);
         fileInputStream.close();
       }
       catch(Exception e)
       {
         e.printStackTrace();
       }
       return bFile;
    }  

    public String[] getFileAL()
    {
        return fileAL;
    }

    public void setFileAL(String[] fileAL)
    {
        this.fileAL = fileAL;
    }
    
    
} 
