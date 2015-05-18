package ftp;

import java.net.*;

public class FtpUtility implements FtpObserver{
    FtpBean ftp;
    long num_of_bytes = 0;
    private String ip;
    private String account;
    private String pass;
    private String directory;
    
    public FtpUtility(String ip,String directory,String account,String pass)throws SocketException{
        ftp = new FtpBean();
        ftp.setSocketTimeout(120000);
        this.ip = ip;
        this.account = account;
        this.pass = pass;
        this.directory = directory;
    }
    public FtpUtility(String ip,String account,String pass)throws SocketException{
        ftp = new FtpBean();
        ftp.setSocketTimeout(120000);
        this.ip = ip;
        this.account = account;
        this.pass = pass;
        //this.directory = "/";
    }
    public void connect() throws Exception{
        ftp.ftpConnect(ip, account, pass);
    }
    
    public void setPassiveMode(boolean passive){
    	ftp.setPassiveModeTransfer(passive);
    }
    // Get the file.
    public void putBinFile(String localFile,String saveFile){
        try{
            ftp.putBinaryFile(localFile,saveFile, this);
        } catch(Exception e){
            //System.out.println(e);
            e.printStackTrace();
        }
    }
    // Close connection
    public void close() throws Exception {
        ftp.close();
    }

    // Go to directory pub and list its content.修改重點 要return FtpListResult
    public FtpListResult listDirectory() throws Exception {
        FtpListResult ftplrs = null;
        ftplrs = ftp.getDirectoryContent();
        return ftplrs;
    }
    public void setDirectory(String xDirectory) throws Exception{
	ftp.setDirectory(xDirectory);
    }
    public void getFile(String fileName) throws Exception{
        ftp.getBinaryFile(fileName, fileName, this);
    }
    public void deleteFile(String fileName) throws Exception{
        ftp.fileDelete(fileName);
    }
    public void renameFile(String fileName,String newFileName) throws Exception{
        ftp.fileRename(fileName,newFileName);
    }
    // Implemented for FtpObserver interface.
    // To monitor download progress.
    public void byteRead(int bytes){
        //num_of_bytes += bytes;
        //System.out.println(num_of_bytes + " of bytes read already.");
    }

    // Needed to implements by FtpObserver interface.
    public void byteWrite(int bytes){
    	//num_of_bytes += bytes;
        //System.out.println(num_of_bytes + " of bytes write already.");
    }
    public String getDirectory() throws Exception{
    	return ftp.getDirectory();
    }
    // Main
    public static void main(String[] args){
        try{
        	FtpUtility example = new FtpUtility("10.16.50.31","/host-rpt/jcs/jc772/","co01","HA235");
        	example.connect();
        	example.setDirectory("/host-rpt/jcs/jc772/");
        	//example.listDirectory();
        	//example.getFile("test.htm");
        	example.putBinFile("c:\\test.txt","test.txt");
        	example.close();
        }
        catch(Exception e){
        	System.out.println(e);
        }
    }
}
