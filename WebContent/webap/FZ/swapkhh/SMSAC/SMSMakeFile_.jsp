<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="swap3ackhh.smsacP.*"%>
<%
String userid = (String)session.getAttribute("userid");

if(userid == null){
	//response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{
String param ="1";	//預設為1 =手機號碼檔, 2= 自訂簡訊號碼檔(有班號及姓名)
if( request.getParameter("f") != null && !"".equals( request.getParameter("f"))){
	param =  request.getParameter("f");
}

	ArrayList dataAL = (ArrayList)session.getAttribute("smsObj");
	StringBuffer str = new StringBuffer();

for (int i = 0; i < dataAL.size(); i++) {
	SMSFlightObj sobj = (SMSFlightObj) dataAL.get(i);
	ArrayList al = sobj.getCrewPhoneList();
	for (int idx = 0; idx < al.size(); idx++) {
		CrewPhoneListObj o = (CrewPhoneListObj) al.get(idx);

	// 判斷mphone是否為10位數字
	int count = 0;
	for (int j = 0; j < o.getMphone().length(); j++) {
		char cc = o.getMphone().charAt(j);
		if ("0123456789".indexOf(cc) >= 0) {
			count++;
		}
	}
	if (count != 10) {
		dataAL.remove(i);
		i--;
	}
	}
}	
	

	
for(int i=0; i<dataAL.size(); i ++){
	SMSFlightObj sobj = (SMSFlightObj) dataAL.get(i);
	ArrayList al = sobj.getCrewPhoneList();
	for (int idx = 0; idx < al.size(); idx++) {
		CrewPhoneListObj o = (CrewPhoneListObj) al.get(idx);
			
		str.append(o.getMphone());		
		if("2".equals(param)){
			str.append(",");
			str.append(o.getCname());
			str.append(",");
			str.append(sobj.getFltno());						
		}	
		
		str.append("\r\n");						
	}
		


}
ByteArrayOutputStream baos = new ByteArrayOutputStream();
ServletOutputStream outStream = null;
try 
{
	response.reset();
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
	response.setHeader("Pragma", "public");
	// setting the content type
	response.setContentType("application/txt");
	if("1".equals(param)){
		response.setHeader("Content-Disposition","attachment; filename=sms1.txt");
	}else{
		response.setHeader("Content-Disposition","attachment; filename=sms2.txt");
	}
	
	// the contentlength is needed for MSIE!!!
	//response.setContentLength(str.length());
	// write ByteArrayOutputStream to the ServletOutputStream
	outStream = response.getOutputStream();
	outStream.write(str.toString().getBytes());
} 
catch (IOException e) 
{
	
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
		out.print(e.toString());
	}
}
	
}	
%>