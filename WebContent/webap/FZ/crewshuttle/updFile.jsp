<%@ page contentType="text/html;charset=big5" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="ftp.FtpUtility" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<% 
	// 宣告將上傳之檔案放置到伺服器的 / .... /upload 目錄中 
    String saveDirectory = application.getRealPath("/")+"/FZ/crewshuttle/userfile/";
    // 宣告暫存目錄
    String tmpDirectory = application.getRealPath("/")+"/FZ/crewshuttle/tempfile/";
    // 宣告限制上傳之檔案總大小為, 單位為 byte, -1 表示無限制
    int maxPostSize = 1024 * 1024 * 3; //3M
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
			//out.print("FilePath : "+FilePath+"<BR>");
		// 因為不同的瀏覽器會造成傳遞 path + filename, 有些則只有 filename


		  try 
		  {
				// for wintel platform
				FileName = FilePath.substring(FilePath.lastIndexOf("\\")+1);
				// for unix-like platform
				FileName = FileName.substring(FileName.lastIndexOf("/")+1); 
				//set session variable
				session.setAttribute("filename", FileName);
		  } 
		  catch ( Exception ex ) 
		  {
			out.println(ex);
		  }
			ContentType = item.getContentType();
			FileSize = item.getSize();
			tmpItem = item;        
        }
	}

   // 將檔案寫入存檔目錄
   try 
   {
   		//****************file 上傳至tpesunap01
		File uploadedFile = new File(saveDirectory + FileName);
        tmpItem.write(uploadedFile);
	    //*************************************FTP 
   		FtpUtility example = new FtpUtility("tpeweb03",application.getRealPath("/")+"/FZ/crewshuttle/userfile/","lccfz","fz1234");
		example.connect();
		example.setDirectory(application.getRealPath("/")+"/FZ/crewshuttle/userfile/");
		//example.listDirectory();
		//example.getFile("test.htm");
		//example.putBinFile(FilePath, FileName);
		example.putBinFile(saveDirectory + FileName, FileName);
		example.close();
		//**************************************
		File f = new File(saveDirectory+FileName);
		//f.delete();
		//out.print(FileName.substring(0,((FileName.indexOf(".")))));
   } 
   catch ( Exception ex ) 
   {
       out.println(ex);
   }
%> 
<html>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="crewcar.css" rel="stylesheet" type="text/css">
<script src="js/showDate.js"></script>
<style type="text/css">
<!--
.style1 {color: #0000FF}
.style2 {
	color: #FF9900;
	font-weight: bold;
}
-->
</style>
<body onLoad="showYMD('form1','sel_year','sel_mon','sel_dd')">
<form name="form1" method="post" action="chkintime.jsp" > 
<table width="100%"  border="0">
  <tr>
    <td bgcolor="#FFFFCC"><div align="center"><span class="style2">上傳檔案完成 </span></div></td>
  </tr>
</table>
<p align="center" class="style1"><BR>
<BR>
<BR>
<BR>
</p>
<p align="center" class="style1"> STEP 2 : 選擇入檔日期 </p>
<p align="center" class="style1"><b>
<select name="sel_year">
  <%
	java.util.Date now = new Date();
	int syear	=	now.getYear() + 1900;
	for (int i=2003; i<=syear+1; i++) 
	{    
  %>
	 <option value="<%=i%>"><%=i%></option>
  <%
	}
  %>
</select>
年
<select name="sel_mon">
  <%
	for (int j=1; j<13; j++) 
	{    
	  if (j<10 )
		{
  %>	 
			<option value="0<%=j%>">0<%=j%></option>
  <%
		}
		else
		{
  %>
		  	<option value="<%=j%>"><%=j%></option>
  <%

		}
	}
  %>
</select>
月
<select name="sel_dd">
  <%
	for (int j=1; j<32; j++) 
	{    
	  if (j<10 )
		{
  %>	 
			<option value="0<%=j%>">0<%=j%></option>
  <%
		}
		else
		{
  %>
		  	<option value="<%=j%>"><%=j%></option>
  <%

		}
	}
  %>
</select>
日
</b></p>
<p align="center"> 
  <input type="submit" class="btm" value="檔案資料匯入"> 
</p>
</form>
</body>
</html>
