<%@ page contentType="text/html;charset=big5" language="java" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="ftp.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<% 
	String filename = request.getParameter("filename");
	//out.println(fdate+","+fltno+","+dpt+arv+","+purserEmpno);
	// �ŧi�N�W�Ǥ��ɮש�m����A���� / .... /upload �ؿ��� 
	String saveDirectory = application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";
	// �ŧi�Ȧs�ؿ�
	String tmpDirectory = application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";
    // �ŧi����W�Ǥ��ɮ��`�j�p��, ��쬰 byte, -1 ��ܵL����
    int maxPostSize = 1024 * 1024 * 5; //5M

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

try 
{
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
	if (iter.hasNext()) 
	{ 
        tmp++;
        FileItem item = (FileItem) iter.next();
		
		if (item.isFormField()) 
		{
		// �p�G�O�@�����, ���o�ɮױԭz		
			FileDescription = item.getString();			
		} 
		else 
		{
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
		
		if(FileSize >1024 * 1024 * 5 )
		{
			status = false;
			msg = "Error : �ɮפӤj�W�L�W�ǭ���5M !!";
		}
		else
		{
			// �N�ɮ׼g�J�s�ɥؿ�
			//****************file �W�Ǧ�tpeweb03
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
//	out.println("<p class='txtxred'>Error : �ɮפӤj�W�L�W�ǭ���5M !! </p>");
	msg = "Error : �ɮפӤj�W�L�W�ǭ���5MB !!";
} 
catch ( Exception ex ) 
{
	//out.println("<p class='txtxred'>Error : �ɮפW�ǥ��� !!<br>" + String.valueOf(ex) + "</p>");
	msg = "Error : �ɮפW�ǥ��� !!<br>"+ ex.toString();
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

