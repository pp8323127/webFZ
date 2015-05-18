<%@ page language="java" import="com.jspsmart.upload.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
	String filename = request.getParameter("filename");
	String realpath = application.getRealPath("/")+"/FZ/mcl/bcas/"+filename;
	
	//out.println(realpath);
		
	try{
	    mySmartUpload.initialize(pageContext); // Initialization	      
	    mySmartUpload.downloadFile(realpath); // Download file
	}catch(java.io.FileNotFoundException fe){
		out.println("Error: File does not exist! " + fe.toString());
	}catch(Exception e){
		out.println("Error: " + e.toString());
	}//try

	// With a physical path
	// mySmartUpload.downloadFile("c:\\temp\\sample.zip")
	
	// With options
	// mySmartUpload.downloadFile("/upload/sample.zip","application/x-zip-compressed","downloaded.zip")
%>