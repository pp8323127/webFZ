<%@page import="java.io.IOException"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@ page contentType="text/html; charset=big5" pageEncoding="big5"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>

<%
String filename = (String) request.getParameter("filename") ; 
String ht = (String) request.getParameter("ht") ; 
String key = (String) request.getParameter("key") ; 
Hashtable dataHT = (Hashtable)session.getAttribute(ht);
String apistxt = (String)dataHT.get(key);	

ByteArrayOutputStream baos = new ByteArrayOutputStream();
ServletOutputStream outStream = null;
try 
{
	response.reset();
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
	response.setHeader("Pragma", "public");

	// setting the content type
	response.setContentType("application/text");
	response.setHeader("Content-Disposition","attachment; filename="+filename);
	response.setContentType("text/html; charset=big5");
	out.write(apistxt);		
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