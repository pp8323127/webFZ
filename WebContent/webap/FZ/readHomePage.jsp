<%@ page contentType="application/msword" %><%@ page import="java.io.*" %><%
   response.setHeader("Content-disposition","inline; filename=../cbnremarks.doc");
   
   FileInputStream fis=new FileInputStream("/apsource/csap/projfz/webap/cbnremarks.doc");
   
   OutputStream os=response.getOutputStream();
   
   int byteRead;
   
   while(-1 != (byteRead = fis.read())) {
   
     os.write(byteRead);
     
   }
   os.close();
   if (fis != null)
      fis.close();
%>