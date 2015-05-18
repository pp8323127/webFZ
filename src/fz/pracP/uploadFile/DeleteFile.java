package fz.pracP.uploadFile;

import java.io.*;

import org.apache.commons.net.ftp.*;

/**
 * DeleteFile 刪除 ftp server 上之檔案
 * 
 * SYSTEM: 網路座艙長報告(EG) 上傳檔案功能
 * 
 * @author cs66
 * @version 1.0 2006/3/17
 * 
 * Copyright: Copyright (c) 2006
 */
public class DeleteFile {

    //    public static void main(String[] args) {
    //        DeleteFile df = new DeleteFile("200600001.jpg");
    //        try {
    //            df.DoDelete();
    //        } catch (IOException e) {
    //            e.printStackTrace();
    //        }
    //
    //        if ( df.isFileIsExist() ) {
    //            if ( df.isDelSuccess() ) {
    //                System.out.println("刪除成功!!");
    //            } else {
    //                System.out.println("檔案刪除失敗!!");
    //            }
    //        } else {
    //            System.out.println("檔案不存在!!");
    //        }
    //    }

    private String uploadFileName;
    private boolean delSuccess = false;
    private boolean fileIsExist = false;
    private String url = "/EG/";
//    private String url = "/EGTEST/";

    public DeleteFile(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public void DoDelete() throws IOException {
        FTPClient ftp = new FTPClient();

        try {
            int reply;

            ftp.connect("202.165.148.99");//cabincrew.china-airlines.com
            ftp.login("egftp01", "cseg#01");
            ftp.cwd("/EG/");
//            ftp.login("egtestftp01" ,"egtest#01");
//            ftp.cwd("/EGTEST/");
//            ftp.cwd(url);
            String[] fileList = ftp.listNames();

            boolean isMatch = false;
            for ( int i = 0; i < fileList.length; i++) {

                if ( uploadFileName.equals(fileList[i]) ) {
                    isMatch = true;
                    break;
                }
            }

            if ( isMatch ) {
                setFileIsExist(true);
                ftp.deleteFile(uploadFileName);
                setDelSuccess(true);
            }
            reply = ftp.getReplyCode();
            if ( !FTPReply.isPositiveCompletion(reply) ) {
                ftp.disconnect();
            }

            ftp.logout();
        } finally {
            if ( ftp.isConnected() ) {
                try {
                    ftp.disconnect();
                } catch (IOException ioe) {

                }
            }

        }
    }
    public void DoZCDelete() throws IOException {
        FTPClient ftp = new FTPClient();

        try {
            int reply;

            ftp.connect("202.165.148.99");//cabincrew.china-airlines.com
            ftp.login("egftp01", "cseg#01");
            ftp.cwd("/EG/PR/");
//            ftp.login("egtestftp01" ,"egtest#01");
//            ftp.cwd("/EGTEST/PR/");
            
//            ftp.cwd(url+"PR/");
            String[] fileList = ftp.listNames();

            boolean isMatch = false;
            for ( int i = 0; i < fileList.length; i++) {

                if ( uploadFileName.equals(fileList[i]) ) {
                    isMatch = true;
                    break;
                }
            }

            if ( isMatch ) {
                setFileIsExist(true);
                ftp.deleteFile(uploadFileName);
                setDelSuccess(true);
            }
            reply = ftp.getReplyCode();
            if ( !FTPReply.isPositiveCompletion(reply) ) {
                ftp.disconnect();
            }

            ftp.logout();
        } finally {
            if ( ftp.isConnected() ) {
                try {
                    ftp.disconnect();
                } catch (IOException ioe) {

                }
            }

        }
    }
    public boolean isDelSuccess() {
        return delSuccess;
    }

    private void setDelSuccess(boolean delStatus) {
        this.delSuccess = delStatus;
    }

    public boolean isFileIsExist() {
        return fileIsExist;
    }

    private void setFileIsExist(boolean fileIsExist) {
        this.fileIsExist = fileIsExist;
    }
}