<%@page import="java.io.IOException"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@ page contentType="text/html; charset=big5" pageEncoding="big5"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>

<%
StringBuffer sb1 = (StringBuffer)session.getAttribute("sb1");
ByteArrayOutputStream baos = new ByteArrayOutputStream();
ServletOutputStream outStream = null;
try 
{
	response.reset();
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
	response.setHeader("Pragma", "public");
	// setting the content type
	response.setContentType("application/html");
	response.setHeader("Content-Disposition","attachment; filename=report.html");
	response.setContentType("text/html; charset=big5");
	out.write(sb1.toString());		
} 
catch (IOException e) 
{
	e.printStackTrace();
	out.print(e.toString());
} 
finally 
{
	try 
	{	
		if(outStream != null){
			outStream.flush();
			outStream.close();			
		}
	} 
	catch (IOException e) 
	{
		e.printStackTrace();
	}
}
%>