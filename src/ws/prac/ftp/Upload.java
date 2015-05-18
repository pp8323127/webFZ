package ws.prac.ftp;
import java.io.File;
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

import ftp.FtpUtility;
import ftp.updFilePath;

import java.io.*;  
import java.util.*; 

public class Upload {

	/**
	 * @param args
	 * @throws  
	 */

	UploadObj ftp = null;
	
//	public static void main(String[] args)  {
//		// TODO Auto-generated method stub
//		DiskFileUpload upload = new DiskFileUpload();
//		List<FileItem>  item = null;
////		upload.parseRequest(request,
////		        yourMaxMemorySize, yourMaxRequestSize, yourTempDirectory);
//		Upload u = new Upload();
//		u.upload("2013/09/03", "0168", "TPEFSZ", "123456", "654321", "", item);
//		
//	}
	
	public UploadObj upload(String fdate,String fltno,String sect,String acno,String purserEmpno,String src,List<FileItem> items){
		ftp = new UploadObj(); 
		Upload up = new Upload();
		// �ŧi�N�W�Ǥ��ɮש�m����A���� / .... /upload �ؿ��� 
	    //String saveDirectory = application.getRealPath("/")+"/uploadfile/";
		String saveDirectory = "/apsource/csap/projfz/webap/uploadfile/";
	    // �ŧi�Ȧs�ؿ�
	    //String tmpDirectory = application.getRealPath("/")+"/uploadfile/";
		String tmpDirectory = "/apsource/csap/projfz/webap/uploadfile/";
	    // �ŧi����W�Ǥ��ɮ��`�j�p��, ��쬰 byte, -1 ��ܵL����
	    int maxPostSize = 1024 * 1024 * 5; //5M

	    // �ŧi�x�s�ԭz�W���ɮפ��e���ܼ�	
	    String FileDescription = null; 
		// �ŧi�x�s�W���ɮ׸��|���ܼ�
		String FilePath = null;
	    // �ŧi�x�s�W���ɮצW�٪��ܼ�
	    String FileName = null;
	    // �ŧi�x�s�W���ɮפj�p���ܼ�
	    long FileSize = 0;
	    // �ŧi�x�s�W���ɮ׫��A���ܼ�
	    String ContentType = null;
	    // �p��W���ɮפ��Ӽ�
	    int count = 0 ;
		String newFileName = null;
		String rs = null;
		updFilePath fp = null;
		boolean status = false;
		String msg = "";
		if(src!= null && !"".equals(src))
		{
			src="_"+src;
		}
		else
		{
			src = "";
		}

	try {
	    DiskFileUpload upload = new DiskFileUpload();
	    
	    // �]�w�O����s���ƪ��j�p, �W�L�h�g�J�ɮ�, ���]�w�Ȧs�ؿ�, �Ȧs�ɸm��Ȧs�ؿ��U
	    upload.setSizeThreshold(4096);
	    
	    // �]�w�`�W�Ǥj�p����
	    upload.setSizeMax(maxPostSize);
	    
	    // �]�w�Ȧs�ؿ�
	    upload.setRepositoryPath(tmpDirectory);
//	    List /* FileItem */ items = upload.parseRequest(request);

		Iterator<FileItem> iter = items.iterator();
		
	    int tmp = 0;
	    FileItem tmpItem = null;
		while (iter.hasNext()) 
		{ 
	        tmp++;
	        FileItem item =  iter.next();
			
			if (item.isFormField()) {
			// �p�G�O�@�����, ���o�ɮױԭz
			
				FileDescription = item.getString();
				
			} else {
				// �_�h���o�ɮ׸�T
			
				FilePath = item.getName();
				// �]�����P���s�����|�y���ǻ� path + filename, ���ǫh�u�� filename
			   // for wintel platform
				FileName = FilePath.substring(FilePath.lastIndexOf("\\")+1);
				 // for unix-like platform
				FileName = FileName.substring(FileName.lastIndexOf("/")+1); 

				ContentType = item.getContentType();
				FileSize = item.getSize();
				tmpItem = item;        
			}
			
			if(FileSize >1024 * 1024 * 5 ){
				status = false;
				msg = "Error : �ɮפӤj�W�L�W�ǭ���5M !!";
			}else{
			
			// �]���@���ɮ׳��O������, �CŪ��������B�z�@��
			if (tmp == 2 && FileSize != 0)
			{ 
				count ++;


				// �N�ɮ׼g�J�s�ɥؿ�
				//****************file �W�Ǧ�tpeweb03
				File uploadedFile = new File(saveDirectory + FileName);
				tmpItem.write(uploadedFile);
				//*************************************FTP to 202.165.148.99		
//				FtpUtility example = new FtpUtility("202.165.148.99","/EG/","egftp01","cseg#01");			
				FtpUtility example = new FtpUtility("202.165.148.99","/EGTEST/","egtestftp01","egtest#01");
				example.connect();
				example.setDirectory("/EGTEST/");
//				example.setDirectory("/EG/");

				//example.listDirectory();
				//example.getFile("test.htm");
				//example.putBinFile(FilePath, FileName);
				fp = new updFilePath();
				newFileName = fp.getFilename() + FileName.substring(FileName.lastIndexOf(".")); //�����ɦW
				example.putBinFile(saveDirectory + FileName, newFileName);
				example.close();
				//update ORP3/EGTFILE upload file information into DB***************************
				rs = fp.updFile(fdate, fltno, sect, purserEmpno, newFileName, FileDescription);
				
				if(!"0".equals(rs)){
					ftp.setErrMsg("Error : �ɮ��x�s���� !!" + rs);
					ftp.setResultCode("0");
				}
				//**************************************
				//******delete tpeweb03 temp file
				File f = new File(saveDirectory+FileName);
				f.delete();
				
				tmp = 0;
			} else if (tmp == 2 && FileSize == 0) {
				tmp = 0;
			} // end if 
			
			status = true;
			}
			
		} // end while

			
	} catch (FileUploadBase.SizeLimitExceededException se ) {
//		out.println("<p class='txtxred'>Error : �ɮפӤj�W�L�W�ǭ���5M !! </p>");
		ftp.setErrMsg("Error : �ɮפӤj�W�L�W�ǭ���5MB !!");
		status = false;
	} catch ( Exception ex ) {
		//out.println("<p class='txtxred'>Error : �ɮפW�ǥ��� !!<br>" + String.valueOf(ex) + "</p>");
		ftp.setErrMsg("Error : �ɮפW�ǥ��� !!<br>"+ ex.toString());
		status = false;
	}finally{
		/*File f = new File(saveDirectory+FileName);
		if(f.exists()){
			f.delete();
		}*/
	}
	return up.ftp;
	}

	
	
/*
	public void uploadImage(String productId, DataHandler image) {
		System.out.println(image.getContentType());
		try {
			InputStream in = image.getInputStream();
			String imageDir = "c:/tmp";
			FileOutputStream out = new FileOutputStream(new File(imageDir,productId));
			try {
				byte buf[] = new byte[1024];
				for (;;) {
					int noBytesRead = in.read(buf);
					out.write(buf, 0, noBytesRead);
					if (noBytesRead < buf.length) {
						break;
					}
				}
			} finally {
				out.close();
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}*/
/*
	public static boolean uploadFile(String url,int port,String username, String password, String path, String filename, InputStream input) {  
	    boolean success = false;   
	    FTPClient ftp = new FTPClient();   
	    try {   
	        int reply;   
	        ftp.connect(url, port);	      
	        ftp.login(username, password);   
	        reply = ftp.getReplyCode();   
	        if (!FTPReply.isPositiveCompletion(reply)) {   
	            ftp.disconnect();   
	            return success;   
	        }   
	        ftp.changeWorkingDirectory(path);   
	        ftp.storeFile(filename, input);            
	           
	        input.close();   
	        ftp.logout();   
	        success = true;   
	    } catch (IOException e) {
	    	e.printStackTrace();
	        System.out.println(e.toString());   
	    } finally {   
	        if (ftp.isConnected()) {   
	            try {   
	                ftp.disconnect();   
	            } catch (IOException ioe) {   
	            }   
	        }   
	    }   
	    return success;   
	}
	*/
}
