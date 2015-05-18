<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*,javax.naming.*,com.lowagie.text.*"%>


<%
//StringBuffer sb = (StringBuffer)session.getAttribute("sb");
//ByteArrayOutputStream baos = new ByteArrayOutputStream();
//ServletOutputStream outStream = null;
OutputStream outputStream = null;
try 
{
	/*response.reset();
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
	response.setHeader("Pragma", "public");

	setting the content type
	response.setContentType("application/csv");
	response.setContentType("application/pdf");
	response.setHeader("Content-Disposition","attachment; filename=report.pdf");
	response.setContentType("text/html; charset=big5");
	out.write(sb.toString());	*/

	response.reset();
	response.setContentType("application/pdf");
	response.setHeader("Content-Disposition", "attachment; filename=xxx.pdf");

	outputStream = response.getOutputStream();

	Document document = new Document();
	PdfWriter.GetInstance(document,  outputStream);
	document.Open();
	string strHTML = "<B>I Love ASP.Net!</B>";
	HTMLWorker htmlWorker = new HTMLWorker(document);
	htmlWorker.Parse(new StringReader(strHTML));
	document.Close();

	if (outputStream!= null) 
	{
		outputStream.flush();
		outputStream.close();
		outputStream= null;
	}
}
/*
catch (IOException e) 
{
	//e.printStackTrace();
	//out.print(e.toString());
} */
catch (Exception e) 
{
	//e.printStackTrace();
	out.print(e.toString());
} 
finally 
{		
	/*
	if(outStream != null)
	{
		outStream.flush();
		outStream.close();			
	}*/
}
%>