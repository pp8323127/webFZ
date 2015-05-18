package ws.prac.ftp;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.activation.DataHandler;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import sun.net.TelnetInputStream;
import sun.net.ftp.FtpClient;
import ws.UnZipBean;

import ftp.FtpUtility;
import ftp.updFilePath;

import java.io.*;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class FtpDownLoad {

    /**
     * @param args
     * @throws
     */

    byte[] ftp = null;

    public byte[] getFtp() {
        return ftp;
    }


    public void setFtp(byte[] ftp) {
        this.ftp = ftp;
    }


    public static void main(String[] args) {
        // // TODO Auto-generated method stub
        FtpDownLoad d = new FtpDownLoad();
        String fileName = "201300005.jpg/201300006.jpg/";
        String zipName = "20131006TPEHIJ0112";
        //分開測試
//        String fileDirectory = "/apsource/csap/projfz/webap/uploadfile/app/"; 
//        fileDirectory = "E://ftp";
//        System.out.println(d.dLoadFtpFile(fileName,fileDirectory));
//        System.out.println(d.fileToZip(zipName,fileDirectory));
        
        //final
        System.out.println(d.getFtpFileByte(fileName , zipName));      
//        System.out.println(d.getFtp());
        for(int i=0; i<d.getFtp().length; i++)
          {
              System.out.print(d.getFtp()[i]);            
          }
        System.out.print("done");
    }

    
    public String getFtpFileByte(String fileName ,String zipName){// zipName :ex:20131006TPEHIJ0112.zip
        FtpDownLoad d = new FtpDownLoad();
        byte[] file_btye = null;
        String r = "";
        //ftp download file to app
        String fileDirectory = "/apsource/csap/projfz/webap/uploadfile/app/"; 
//        fileDirectory = "E://ftp//"; //本機
        //zip ftp to uploadfile
        String zipFileDirectory = "/apsource/csap/projfz/webap/uploadfile/";
//        zipFileDirectory = "E://"; //本機
        //zip path  +.zip
        String zipFile = zipFileDirectory + zipName+".zip";
        
        String setp1 = d.dLoadFtpFile(fileName,fileDirectory);
        String setp2 = ""; 
         
        try{
        if ("Y".equals(setp1))
        {
            setp2 = d.fileToZip(zipFile,fileDirectory);
            if ("Y".equals(setp2))
            {
                
                //delete file 
                
                //取 zip byte.
                UnZipBean uzb = new UnZipBean(zipFile, zipFileDirectory);
                file_btye = uzb.readZipFile(zipFile);
                if (file_btye != null)
                {
                    setFtp(file_btye); 
                    r = "change byte done.";
                }
                else
                {
                    r = "change byte failed.";
                }
                
            }
            else
            {
                r = "zip file failed ,setp2" + setp2;
            }
        }
        else
        {
            r = "no file download ,setp1" + setp1;
        }
        }catch(Exception e){
            r = e.toString();
        }
        
        return r;
        
    } 
    
    // ftp file download
    public String dLoadFtpFile(String fileName,String fileDirectory) {

        //test
        String ftpurl = "/EGTEST/";
        String server = "202.165.148.99";
        String username = "egtestftp01";
        String password = "egtest#01";
        
        //Live
//      String ftpurl = "/EG/";
//      String server = "202.165.148.99";
//      String username = "egftp01";
//      String password = "cseg#01";
        String r = "N";
        String localurl ="";
        try {
            String[] sFileName = fileName.split("/");
//            System.out.println(sFileName.length);
            for(int i=0 ; i<sFileName.length ;i++){
                localurl = fileDirectory + sFileName[i];//再拼湊出本地路徑
    //            System.out.println(localurl);            
                
                FtpClient ftpClient = new FtpClient();
                ftpClient.openServer(server);
                ftpClient.login(username, password);
                if (ftpurl.length() != 0)
                {
                    ftpClient.cd(ftpurl);
                }
                ftpClient.binary();
                TelnetInputStream is = ftpClient.get(sFileName[i]);

                File file_out = new File(localurl);
                file_out.createNewFile();

                FileOutputStream os = new FileOutputStream(file_out);
                byte[] bytes = new byte[1024];
                int c;
                while ((c = is.read(bytes)) != -1)
                {
                    os.write(bytes, 0, c);
                }
                is.close();
                os.close();
                ftpClient.closeServer();
                r = "Y";               
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            r = ex.toString();
        }    
        return r;
    }

    // zip file
    public String fileToZip(String zipFile,String fileDirectory) {
        String tofilePath = zipFile;    
        
//        System.out.println("toFloerName" + tofilePath);
        String r = "N";
        try {
            List fileList = getSubFiles(new File(fileDirectory)); // 所有要打包的內容
            ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(tofilePath));

            ZipEntry ze = null;
            byte[] buf = new byte[1024];
            int readLen = 0;
            for (int i = 0; i < fileList.size(); i++) {
                File file = (File) fileList.get(i);
                ze = new ZipEntry(file.getName());
                ze.setSize(file.length());
                ze.setTime(file.lastModified());
                zos.putNextEntry(ze);
                InputStream is = new BufferedInputStream(new FileInputStream(file));
                while ((readLen = is.read(buf, 0, 1024)) != -1) {
                    zos.write(buf, 0, readLen);
                }
                is.close();
            }
            zos.close();
//             System.out.println("完成");
            r = "Y";
        } catch (Exception ex) {
            ex.printStackTrace();
            r = ex.toString();
        }
        return r;
    }

    /**
     * @param baseDir
     *            File
     * @return 包含java.io.File的List
     */
    private static List<File> getSubFiles(File baseDir) {
        List<File> ret = new ArrayList<File>();
        File[] tmp = baseDir.listFiles();
        for (int i = 0; i < tmp.length; i++) {
            if (tmp[i].isFile())
                ret.add(tmp[i]);
            if (tmp[i].isDirectory())
                ret.addAll(getSubFiles(tmp[i]));
        }
        return ret;
    }

}
