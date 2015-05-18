<%@ page contentType="text/html;charset=big5" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="ftp.FtpUtility" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<% 
	// �ŧi�N�W�Ǥ��ɮש�m����A���� / .... /upload �ؿ��� 
    String saveDirectory = application.getRealPath("/")+"/FZ/crewshuttle/userfile/";
    // �ŧi�Ȧs�ؿ�
    String tmpDirectory = application.getRealPath("/")+"/FZ/crewshuttle/tempfile/";
    // �ŧi����W�Ǥ��ɮ��`�j�p��, ��쬰 byte, -1 ��ܵL����
    int maxPostSize = 1024 * 1024 * 3; //3M
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
			//out.print("FilePath : "+FilePath+"<BR>");
		// �]�����P���s�����|�y���ǻ� path + filename, ���ǫh�u�� filename


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

   // �N�ɮ׼g�J�s�ɥؿ�
   try 
   {
   		//****************file �W�Ǧ�tpesunap01
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
    <td bgcolor="#FFFFCC"><div align="center"><span class="style2">�W���ɮק��� </span></div></td>
  </tr>
</table>
<p align="center" class="style1"><BR>
<BR>
<BR>
<BR>
</p>
<p align="center" class="style1"> STEP 2 : ��ܤJ�ɤ�� </p>
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
�~
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
��
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
��
</b></p>
<p align="center"> 
  <input type="submit" class="btm" value="�ɮ׸�ƶפJ"> 
</p>
</form>
</body>
</html>
