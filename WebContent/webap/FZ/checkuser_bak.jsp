<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*" %>
<%!
	// �ѩ�ϥΪ̦W��O�@�ɪ���B�]�w����@instance
	// �G�ŧi�覡�����<jsp:useBean>��tag

	UserList userlist = UserList.getInstance();
%>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	chkUser cu = new chkUser();
	
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");

//write log
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();
String rs = null;
try {
	writeLog wl = new writeLog();

    rs = cu.getAuth(userid, password); 
	//Retrun "ED"(TPEED), "C"(flight crew & crew), "O"(OZ,EZ,KHHEF,TYO,SINEF,BKKEF)
	//"You are not authorization !"
	UserTrace usertrace = new UserTrace();
	// �p�G�O�s��session
	if (session.isNew())
	{
   		// �]�w�ϥΪ�id�i�J�l�ܪ���	
      	usertrace.setUserName(userid);
   
   		// �N�ϥΪ̰l�ܪ���[�Jsession��	
   		session.setAttribute("usertrace",usertrace);
   
   		// �N�ϥΪ̥[�J�ϥΪ̦W�椤
   		userlist.addUser(usertrace.getUserName());
   
   		// �]�wsession�b30���������S�����ʴN��session�L��
	    session.setMaxInactiveInterval(1800);
	}
	
	session.setAttribute("password", password);
	if (rs.equals("C"))
	{
	   session.setAttribute("userid", userid);
	   session.setAttribute("cname", cu.getName());
	   session.setAttribute("sern", cu.getSern());
	   session.setAttribute("occu", cu.getOccu()); //FA, FS, PR......CA, FO, FE....
	   session.setAttribute("base", cu.getBase());
	   session.setAttribute("auth", "C");//crew
	   session.setAttribute("locked", cu.checkLock(userid));//N : ����w/�}��, Y : ��w/���}��
	   wl.updLog(userid, userip,userhost, "FZ011");
		//add by cs66 at 2005/06 ~~TSA FORM: �j��խ��ݶ�g��Ƥ~��n�J
	   %>
	    <jsp:forward page="tsaForm/forceTSA.jsp" /> <!--fzframe.jsp -->
	   <%

	}
	else if (rs.equals("ED") || rs.equals("O"))
	{
		session.setAttribute("userid", userid);
		session.setAttribute("occu", rs);
		session.setAttribute("auth", "O");//office
		session.setAttribute("locked", "0"); //�s
		wl.updLog(userid, userip,userhost, "FZ011");
		%>
	    <jsp:forward page="fzframe.jsp" /><!--fzframe.htm -->
	   <%
	}
	else if("192.168".equals(userip.substring(0,7)) &&(( "TPEOV".equals(userid) || ("TPECO").equals(userid))&& "27123141".equals(password))){//����ip
		session.setAttribute("userid", userid);
		wl.updLog(userid, userip,userhost, "FZ011");
		%>
	    <jsp:forward page="fzframe2.jsp" /><!--fzframe.htm -->
	   <%
	}
	else//"You are not authorized !"
	{
	String str = null;
	if("Y".equals(rs.substring(0,1))){	//"You are not authorized !"
		str = "<p style='color:red' align=center>You have not been authorized.<br> "
			+"In case of new, suspended or  recurrent staff,<br> "
			+"Please contact with affiliated units to apply  account.  <br>"
			+"���b�����Q���v�n�J.<br> �Y���s�i�խ��ίd��.�_¾�H���A<br>�Ь����ݳ��ӽбb��.</p>";
	}else{	//Please check your Id & password
		str = "<p style='color:red' align=center>Incorrect password.<br>"
		+"If you forget your password,<br>"
		+"use the link of Forget Password in homepage,<br>"
		+"you can get the email of password from aero mail" 
		+"<br>�K�X�����T!!<br>�Y�ѰO�K�X,���I�ﭺ��Forget Password,<br>�æܥ����H�c�����K�X�H��..</p>";
	}
		%> 
		<jsp:forward page="errorpage.jsp"> 
		<jsp:param name="messagestring" value="<%=str%>" />
		</jsp:forward>
		<%
	}
} catch(Exception e)
{
	    %> 
		<jsp:forward page="errorpage.jsp"> 
		<jsp:param name="messagestring" value="<%=rs%>" />
		</jsp:forward>
		<%
}
%>