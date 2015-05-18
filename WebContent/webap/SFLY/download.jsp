<%@ page language="java" import="com.jspsmart.upload.*"%><jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" /><%
	String filename = request.getParameter("filename");
	String realpath = application.getRealPath("/")+"/SFLY/file/"+filename;

	try{
	// Initialization
	mySmartUpload.initialize(pageContext);
	
	//Set COntent Disposition = "arrachment;"（注意要有分號），則不管檔案形式一定會下載
	mySmartUpload.setContentDisposition("attachment;");
	// Download file with different filename
//	mySmartUpload.downloadFile(realpath,"","sample.txt");
	mySmartUpload.downloadFile(realpath);
	
	}catch(java.io.FileNotFoundException fe)
	{
		out.print("File is not exist");
	}catch(Exception e)
	{
		out.println(e.toString());
	}
	// With a physical path
	// mySmartUpload.downloadFile("c:\\temp\\sample.zip")
	
	// With options
	// mySmartUpload.downloadFile("/upload/sample.zip","application/x-zip-compressed","downloaded.zip")
%>