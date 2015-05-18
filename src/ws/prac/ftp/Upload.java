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
		// 宣告將上傳之檔案放置到伺服器的 / .... /upload 目錄中 
	    //String saveDirectory = application.getRealPath("/")+"/uploadfile/";
		String saveDirectory = "/apsource/csap/projfz/webap/uploadfile/";
	    // 宣告暫存目錄
	    //String tmpDirectory = application.getRealPath("/")+"/uploadfile/";
		String tmpDirectory = "/apsource/csap/projfz/webap/uploadfile/";
	    // 宣告限制上傳之檔案總大小為, 單位為 byte, -1 表示無限制
	    int maxPostSize = 1024 * 1024 * 5; //5M

	    // 宣告儲存敘述上傳檔案內容的變數	
	    String FileDescription = null; 
		// 宣告儲存上傳檔案路徑的變數
		String FilePath = null;
	    // 宣告儲存上傳檔案名稱的變數
	    String FileName = null;
	    // 宣告儲存上傳檔案大小的變數
	    long FileSize = 0;
	    // 宣告儲存上傳檔案型態的變數
	    String ContentType = null;
	    // 計算上傳檔案之個數
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
	    
	    // 設定記憶體存放資料的大小, 超過則寫入檔案, 有設定暫存目錄, 暫存檔置於暫存目錄下
	    upload.setSizeThreshold(4096);
	    
	    // 設定總上傳大小限制
	    upload.setSizeMax(maxPostSize);
	    
	    // 設定暫存目錄
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
			// 如果是一般欄位, 取得檔案敘述
			
				FileDescription = item.getString();
				
			} else {
				// 否則取得檔案資訊
			
				FilePath = item.getName();
				// 因為不同的瀏覽器會造成傳遞 path + filename, 有些則只有 filename
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
				msg = "Error : 檔案太大超過上傳限制5M !!";
			}else{
			
			// 因為一個檔案都是兩個欄位, 每讀取兩個欄位處理一次
			if (tmp == 2 && FileSize != 0)
			{ 
				count ++;


				// 將檔案寫入存檔目錄
				//****************file 上傳至tpeweb03
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
				newFileName = fp.getFilename() + FileName.substring(FileName.lastIndexOf(".")); //取副檔名
				example.putBinFile(saveDirectory + FileName, newFileName);
				example.close();
				//update ORP3/EGTFILE upload file information into DB***************************
				rs = fp.updFile(fdate, fltno, sect, purserEmpno, newFileName, FileDescription);
				
				if(!"0".equals(rs)){
					ftp.setErrMsg("Error : 檔案儲存失敗 !!" + rs);
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
//		out.println("<p class='txtxred'>Error : 檔案太大超過上傳限制5M !! </p>");
		ftp.setErrMsg("Error : 檔案太大超過上傳限制5MB !!");
		status = false;
	} catch ( Exception ex ) {
		//out.println("<p class='txtxred'>Error : 檔案上傳失敗 !!<br>" + String.valueOf(ex) + "</p>");
		ftp.setErrMsg("Error : 檔案上傳失敗 !!<br>"+ ex.toString());
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
