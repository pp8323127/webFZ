<%@ page contentType="text/html;charset=big5" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="ftp.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<% 
	String fdate = request.getParameter("fdate");
	String fltno = request.getParameter("fltno");
	String dpt = request.getParameter("dpt");
	String arv = request.getParameter("arv");
	String acno = request.getParameter("acno");
	String purserEmpno = request.getParameter("purserEmpno");
	//out.println(fdate+","+fltno+","+dpt+arv+","+purserEmpno);
	// �ŧi�N�W�Ǥ��ɮש�m����A���� / .... /upload �ؿ��� 
    String saveDirectory = application.getRealPath("/")+"/uploadfile/";
    // �ŧi�Ȧs�ؿ�
    String tmpDirectory = application.getRealPath("/")+"/uploadfile/";
    // �ŧi����W�Ǥ��ɮ��`�j�p��, ��쬰 byte, -1 ��ܵL����
    int maxPostSize = 1024 * 1024 * 5; //5M
%> 
<%
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
	
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../../errStyle.css">
<body>
<div align="center">
<p>
<%	
try {
    DiskFileUpload upload = new DiskFileUpload();
    
    // �]�w�O����s���ƪ��j�p, �W�L�h�g�J�ɮ�, ���]�w�Ȧs�ؿ�, �Ȧs�ɸm��Ȧs�ؿ��U
    upload.setSizeThreshold(4096);
    
    // �]�w�`�W�Ǥj�p����
    upload.setSizeMax(maxPostSize);
    
    // �]�w�Ȧs�ؿ�
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
			FtpUtility example = new FtpUtility("202.165.148.99","/EG/","egftp01","cseg#01");
			example.connect();
			example.setDirectory("/EG/");
			//example.listDirectory();
			//example.getFile("test.htm");
			//example.putBinFile(FilePath, FileName);
			fp = new updFilePath();
			newFileName = fp.getFilename() + FileName.substring(FileName.lastIndexOf(".")); //�����ɦW
			example.putBinFile(saveDirectory + FileName, newFileName);
			example.close();
			//update ORP3/EGTFILE upload file information into DB***************************
			rs = fp.updFile(fdate, fltno, dpt+arv, purserEmpno, newFileName, FileDescription);
			
			if(!"0".equals(rs)){
				out.println("<p class='txtxred'>Error : �ɮ��x�s���� !!<br>" + rs + "</p>");
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
		}//end of file size limited
	} // end while
	

} catch (FileUploadBase.SizeLimitExceededException se ) {
//	out.println("<p class='txtxred'>Error : �ɮפӤj�W�L�W�ǭ���5M !! </p>");
	msg = "Error : �ɮפӤj�W�L�W�ǭ���5M !!";
} catch ( Exception ex ) {
	//out.println("<p class='txtxred'>Error : �ɮפW�ǥ��� !!<br>" + String.valueOf(ex) + "</p>");
	msg = "Error : �ɮפW�ǥ��� !!<br>"+ ex.toString();
}

if(status){
%>

	<script language="JavaScript" type="text/JavaScript">
	alert("�ɮפW�Ǧ��\!!");
	window.opener.location.href="../edFltIrr.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&pur=<%=purserEmpno%>";

	self.close();
	
	</script>

<%
}else{
%>
	<p class='errStyle1'><%=msg%></p>

	   <input type="button" name="Submit" value="���s�W��" onClick="self.location='uploadfile.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>'">&nbsp;&nbsp;
  <input type="button" name="Submit" value="Close" onClick="self.close()">
<%


}
%> 

</div>
</body>
</html>
