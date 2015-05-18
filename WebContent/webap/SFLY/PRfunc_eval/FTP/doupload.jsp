<%@ page contentType="text/html;charset=big5" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="ftp.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<% 
	String filename = request.getParameter("filename");
	//out.println(fdate+","+fltno+","+dpt+arv+","+purserEmpno);
	// 宣告將上傳之檔案放置到伺服器的 / .... /upload 目錄中 
	String saveDirectory = application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";
	// 宣告暫存目錄
	String tmpDirectory = application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";
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

try 
{
    DiskFileUpload upload = new DiskFileUpload();
    
    // 設定記憶體存放資料的大小, 超過則寫入檔案, 有設定暫存目錄, 暫存檔置於暫存目錄下
    upload.setSizeThreshold(4096);
    
    // 設定總上傳大小限制
    upload.setSizeMax(maxPostSize);
    
    // 設定暫存目錄
    upload.setRepositoryPath(tmpDirectory);
    List /* FileItem */ items = upload.parseRequest(request);

	Iterator iter = items.iterator();
	
    int tmp = 0;
    FileItem tmpItem = null;
	if (iter.hasNext()) 
	{ 
        tmp++;
        FileItem item = (FileItem) iter.next();
		
		if (item.isFormField()) 
		{
		// 如果是一般欄位, 取得檔案敘述		
			FileDescription = item.getString();			
		} 
		else 
		{
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
		
		if(FileSize >1024 * 1024 * 5 )
		{
			status = false;
			msg = "Error : 檔案太大超過上傳限制5M !!";
		}
		else
		{
			// 將檔案寫入存檔目錄
			//****************file 上傳至tpeweb03
			File uploadedFile = new File(saveDirectory + FileName);
			tmpItem.write(uploadedFile);
			//*************************************FTP to 202.165.148.99
			FtpUtility example = new  FtpUtility("hdqweb03",saveDirectory,"lccfz","fz1234");
			example.connect();		
			example.setDirectory(saveDirectory);
			//example.listDirectory();
			//example.getFile("test.htm");
			//example.putBinFile(FilePath, FileName);
			example.putBinFile(saveDirectory + FileName, FileName);			
        	example.renameFile(FileName,filename+".jpg");
			example.close();
			status = true;
			//**************************************
			//File f = new File(saveDirectory+FileName);
			//f.delete();
			//out.print(FileName.substring(0,((FileName.indexOf(".")))));
		}
	}
} 
catch (FileUploadBase.SizeLimitExceededException se ) 
{
//	out.println("<p class='txtxred'>Error : 檔案太大超過上傳限制5M !! </p>");
	msg = "Error : 檔案太大超過上傳限制5MB !!";
} 
catch ( Exception ex ) 
{
	//out.println("<p class='txtxred'>Error : 檔案上傳失敗 !!<br>" + String.valueOf(ex) + "</p>");
	msg = "Error : 檔案上傳失敗 !!<br>"+ ex.toString();
}
finally
{
	/*File f = new File(saveDirectory+FileName);
	if(f.exists()){
		f.delete();
	}*/
}

if(status == false)
{
	out.print(msg);
}
else
{
%>
<script language="JavaScript" type="text/JavaScript">	    
	window.opener.document.form1.img<%=filename%>B.src="FTP/file/<%=filename%>.jpg";
	self.close();	
</script>
<%
}
%> 

