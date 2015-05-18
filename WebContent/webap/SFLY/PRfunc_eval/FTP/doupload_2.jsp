<%@ page contentType="text/html;charset=big5" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="ftp.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

	String sernno = request.getParameter("sernno");
	String type = request.getParameter("type");
	String seq = request.getParameter("seq");
	String itemno = request.getParameter("itemno");
	
	String fdate = request.getParameter("fdate");
	String fltno = request.getParameter("fltno");
	String trip = request.getParameter("trip");
	//out.println(fdate+","+fltno+","+dpt+arv+","+purserEmpno);
	// 宣告將上傳之檔案放置到伺服器的 / .... /upload 目錄中 
    //String saveDirectory = application.getRealPath("/")+"/uploadfile/";
	String saveDirectory = "/apsource/csap/projfz/webap/uploadfile/";
    // 宣告暫存目錄
    //String tmpDirectory = application.getRealPath("/")+"/uploadfile/";
	String tmpDirectory = "/apsource/csap/projfz/webap/uploadfile/";
    // 宣告限制上傳之檔案總大小為, 單位為 byte, -1 表示無限制
    int maxPostSize = 1024 * 1024 * 5; //5M
%> 
<%
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
	MPFilePath fp = null;
	boolean status = false;
	String msg = "";
	String src = request.getParameter("src");
	if(src!= null && !"".equals(src))
	{
		src="_"+src;
	}
	else
	{
		src = "";
	}

%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<body>
<div align="center">
<%	
try {
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
	while (iter.hasNext()) 
	{ 
        tmp++;
        FileItem item = (FileItem) iter.next();
		
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
			FtpUtility example = new FtpUtility("202.165.148.99","/EG/MP/","egftp01","cseg#01");			
//			FtpUtility example = new FtpUtility("202.165.148.99","/EGTEST/MP/","egtestftp01","egtest#01");
			example.connect();
//			example.setDirectory("/EGTEST/MP/");
			example.setDirectory("/EG/MP/");

			//example.listDirectory();
			//example.getFile("test.htm");
			//example.putBinFile(FilePath, FileName);
			fp = new MPFilePath();
			newFileName = fp.getFilename() + FileName.substring(FileName.lastIndexOf(".")); //取副檔名
			example.putBinFile(saveDirectory + FileName, newFileName);
			example.close();
			//update ORP3/EGTFILE upload file information into DB***************************
			rs = fp.updFile(sernno, fdate, fltno, trip, userid, newFileName, "", type, itemno);
			//(fdate, fltno, dpt+arv, purserEmpno, newFileName, FileDescription);
			
			if(!"0".equals(rs)){
				out.println("<p class='txtxred'>Error : 檔案儲存失敗 !!<br>" + rs + "</p>");
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
//	out.println("<p class='txtxred'>Error : 檔案太大超過上傳限制5M !! </p>");
	msg = "Error : 檔案太大超過上傳限制5MB !!";
	status = false;
} catch ( Exception ex ) {
	//out.println("<p class='txtxred'>Error : 檔案上傳失敗 !!<br>" + String.valueOf(ex) + "</p>");
	msg = "Error : 檔案上傳失敗 !!<br>"+ ex.toString();
	status = false;
}finally{
	/*File f = new File(saveDirectory+FileName);
	if(f.exists()){
		f.delete();
	}*/
}


if(status)
{
//String isZ = "";
//if(!"".equals(request.getParameter("isZ")) && null != request.getParameter("isZ"))
//{
//	isZ = request.getParameter("isZ");
//}

%>

	<script language="JavaScript" type="text/JavaScript">
	alert("檔案上傳成功!!");
	opener.location.reload(true);
	self.close();
	
	</script>

<%
}
else
{
%>
	<p class='errStyle1'><%=msg%></p>
     
	 <input type="button" name="Submit" value="重新上傳" onClick="self.location='uploadfile.jsp?sernno=<%=sernno%>&type=<%=type%>&seq=<%=seq%>&itemno=<%=itemno%>&fdate=<%=fdate%>&fltno=<%=fltno%>&trip=<%=trip%>;">&nbsp;&nbsp;
<input type="button" name="Submit" value="Close" onClick="self.close()">
<%


}
%> 

</div>
</body>
</html>
