<%@ page contentType="text/html; charset=big5" pageEncoding="big5"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>

<%
//String userid = (String)session.getAttribute("userid");
//out.print("userid="+userid+"<br>");
String userid = "sys";
if(userid == null){
   response.sendRedirect("recQuery.jsp");
}else{
   ArrayList objAL = (ArrayList)session.getAttribute("objAL");
   StringBuffer str = new StringBuffer();
   str.append("Seq,Dept,Sern,Empno,Cname,Ename,Recurrent Date,Jobitem,Status\r\n");
   for(int i=0; i<objAL.size(); i ++){
	   RecObj obj = (RecObj) objAL.get(i);
	   str.append(String.valueOf(i+1)+","+obj.getDept()+","+obj.getSern()+","+ obj.getEmpno()+","+obj.getCname()+","+obj.getEname()+","+obj.getRecrdate()+"," +obj.getJobno()+","+obj.getStatus()+"\r\n");
   }//for
   ByteArrayOutputStream baos = new ByteArrayOutputStream();
   ServletOutputStream outStream = null;
   try{
	   response.reset();
	   response.setHeader("Expires", "0");
	   response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
	   response.setHeader("Pragma", "public");
	   // setting the content type
	   response.setContentType("application/csv");
	   response.setHeader("Content-Disposition","attachment; filename=recurrentCrew.CSV");
	   response.setContentType("text/csv; charset=big5");

	   // the contentlength is needed for MSIE!!!
	   //response.setContentLength(str.length());
	   // write ByteArrayOutputStream to the ServletOutputStream
	   //outStream = response.getOutputStream();
	   //outStream.write(str.toString().getBytes());
	   out.write(str.toString());		
   }catch (IOException e) {
	   e.printStackTrace();
	   out.print(e.toString());
   }finally{
	   try{	
	      if (outStream != null){
		      outStream.flush();
		      outStream.close();			
	      }//if
	   }catch (IOException e){ e.printStackTrace(); }
   }//try
}//if
%>