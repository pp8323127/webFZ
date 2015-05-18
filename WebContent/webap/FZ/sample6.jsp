<%@ page language="java" import="com.jspsmart.upload.*"%><jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" /><%
	String filename = request.getParameter("filename");
	String realpath = application.getRealPath("/")+"/"+filename;
	try{
	// Initialization
	mySmartUpload.initialize(pageContext);
	
	// Download file
	mySmartUpload.downloadFile(realpath);
	}catch(java.io.FileNotFoundException fe)
	{
		%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="檔案不存在<br>File is not exist" />
		</jsp:forward>
	    <%
	}catch(Exception e)
	{
		out.println(e.toString());
	}
	// With a physical path
	// mySmartUpload.downloadFile("c:\\temp\\sample.zip")
	
	// With options
	// mySmartUpload.downloadFile("/upload/sample.zip","application/x-zip-compressed","downloaded.zip")
%>