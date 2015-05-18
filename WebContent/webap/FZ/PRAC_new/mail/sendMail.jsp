<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.*,java.util.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//String userbase = (String) session.getAttribute("userbase") ; 
//String chiefcd = (String) session.getAttribute("Chiefcd") ; 
//String usergroup = (String) session.getAttribute("usergroup") ; 
//String unitcd = (String) session.getAttribute("Unitcd") ; 
String[] sel = request.getParameterValues("sel");
String rid = (String) request.getParameter("rid");
String user = (String) request.getParameter("user");
String ccStr = (String) request.getParameter("cc");
//out.print("rid="+rid+"<br>");
if(rid == null)
{	
	String userid = (String) session.getAttribute("userid") ; //get user id if already login
	if (session.isNew() || userid == null) {
	response.sendRedirect("../../logout.jsp");
	}
}
else
{ 
	String to = "";
	boolean flag = false;
	if(null != ccStr  && !"".equals(ccStr)){
		String[] ccArr = ccStr.split(",");
		for(int i=0;i<ccArr.length;i++){
//			out.println(ccArr[i].substring(6));
			if(!ccArr[i].substring(6).equals("@cal.aero")){		
				flag = false;
				%>
					<script language="javascript" type="text/javascript">
					alert('副本收件人格式錯誤,請確認!');
					history.go(-1);
					</script>				 
				<%
			}else{
				flag = true;
			}
		}
	}
	
	if(sel.length > 0 && flag){
		for(int i=0;i<sel.length;i++){
			to += sel[i]+"@cal.aero,";
		}		
		
//		out.println("Crew Mail List"+to+",user"+user);		
		//String to = (String) request.getParameter("to");
		//String empno = (String) request.getParameter("empno") ; 
		
		String subject = (String) request.getParameter("subject") ; 
		String message = (String) request.getParameter("message") ; 	

		tool.Email al = new tool.Email();
		String sender = user+"@cal.aero";//"TPEEFCI@email.china-airlines.com";//EF
		//	to = "643937@cal.aero";
		String receiver = to;
		String cc = ccStr;//user+"@cal.aero,"+
		String mailSubject = subject;
		StringBuffer mailContent = new StringBuffer();
		//mailContent.append(message);
		//al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);

		//*************************************************************
		%>
		<!-- -->
			<script language="javascript" type="text/javascript">
			alert('Email Sent!');
			history.go(-1);
			</script>
		 
		<%
	}else{
		%>
		
			<script language="javascript" type="text/javascript">
			alert('Email failed!');
			history.go(-1);
			</script>
		 
		<%
	}
	
	
	

}
%>