<%@ page contentType="text/html; charset=big5" pageEncoding="big5" language="java"  import="java.io.*,java.util.*,fz.ipad.*,java.text.*,com.lowagie.text.*,com.lowagie.text.pdf.*"%>

<%
PsrStationDocToIpad dip = new PsrStationDocToIpad();
dip.getEZDIPDoc();
dip.getDIPAttachFile();

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
GregorianCalendar cal1 = new GregorianCalendar();       
String file_name = formatter.format(cal1.getTime());

response.reset();
response.setContentType("application/pdf");
response.setHeader("Content-Disposition", "attachment; filename=PurserStation_"+file_name+".pdf");
OutputStream outputStream = response.getOutputStream();

String folder_path = "/apsource/csap/projfz/txtin/ipad/";    
File dir = new File(folder_path); 
String[] files = dir.list(); 	

try    
{   
	Document doc = new Document(PageSize.A4);   
	PdfCopy copy = new PdfCopy(doc, outputStream); 
	PdfReader reader;
	doc.open();   
	   
	for(int i=0; i<files.length; i++)   
	{   
		reader = new PdfReader(folder_path+files[i]);   			   
		int n = reader.getNumberOfPages();   

		for(int j=1; j<=n; j++)   
		{   				
			doc.newPage();    
			PdfImportedPage p = copy.getImportedPage(reader,j);   
			copy.addPage(p);   
		}
	} 
	doc.close(); 		
} 
catch (IOException e) 
{   
	e.printStackTrace();   
	out.println(e.toString());
} 
catch(DocumentException e) 
{   
	e.printStackTrace();   
	out.println(e.toString());
}
finally 
{		
	if (outputStream!= null) 
	{
		outputStream.flush();
		outputStream.close();
		outputStream= null;
	}
}

%>