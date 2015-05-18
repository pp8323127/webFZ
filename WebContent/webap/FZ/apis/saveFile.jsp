<%@ page contentType ="text/html" language="java" import="com.jspsmart.upload.*"%><jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" /><%
	String filename = request.getParameter("filename");
	//String realpath = application.getRealPath("/")+"/file/"+filename;
	String realpath = application.getRealPath("/")+"/FZ/apis/"+filename;

	try{
	// Initialization
	mySmartUpload.initialize(pageContext);

    // �]�wcontentDisposition?null�T�O���U���U�����, �קK�s�����۰ʥ��}���ɮ�
	//mySmartUpload.setContentDisposition(null); 
	
	//Set Content Disposition = "attachment;"�]�`�N�n�������^�A�h�����ɮקΦ��@�w�|�U��
	mySmartUpload.setContentDisposition("attachment;");

	// Download file with different filename
    // mySmartUpload.downloadFile(realpath,"","sample.txt");    
	mySmartUpload.downloadFile(realpath); // problem here: Unable to connect to server?	
	}catch(java.io.FileNotFoundException fe){
		out.print(realpath+", File is not exist");
	}catch(Exception e)	{
		out.println(e.toString());
	}
	// With a physical path
	// mySmartUpload.downloadFile("c:\\temp\\sample.zip")
	
	// With options
	// mySmartUpload.downloadFile("/upload/sample.zip","application/x-zip-compressed","downloaded.zip")

%>
