<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*,fzAuth.*" %>
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
//session.setAttribute("outside",request.getAttribute("outside"));//�qinternet�i�J

//write log
String userip = (String)session.getAttribute("userip");//request.getParameter("userip");//request.getRemoteAddr();
String userhost =(String)session.getAttribute("userhost");//request.getParameter("userhost");//request.getRemoteHost();
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

	//�ϥΥ����H�c�K�X�{��
	UserID uid = new UserID(userid,password);
	
	//		check HR
	CheckHR ckHR = new CheckHR();
		
	if (rs.equals("C"))
	{
	   session.setAttribute("userid", userid);
	   session.setAttribute("cname", cu.getName());
	   session.setAttribute("sern", cu.getSern());
	   session.setAttribute("occu", cu.getOccu()); //FA, FS, PR......CA, FO, FE....
	   session.setAttribute("base", cu.getBase());
	   session.setAttribute("auth", "C");//crew
	   session.setAttribute("locked", cu.checkLock(userid));//N : ����w/�}��, Y : ��w/���}��
	   wl.updLog(userid, userip,userhost, "FZ011B");
		//add by cs66 at 2005/06 ~~TSA FORM: �j��խ��ݶ�g��Ƥ~��n�J
	   %>
	    <jsp:forward page="fzframe.jsp?forceCheck=Y" /> <!--fzframe.jsp  tsaForm/forceTSA.jsp  fzframe.jsp?forceCheck=Y -->
	   <%

	}
	else if (rs.equals("ED") || rs.equals("O"))
	{
	
		CheckAeroMail ckMail = new CheckAeroMail();
		if (!ckMail.isPassAeroMail()) {	
		String  str = "<p style='color:red' align=center>�K�X���~,�Э��s<a href=\"sendredirect.jsp\">�n�J</a>.<br>";
		str +="����Ʀw���ΫO�K,�Y��_ED�ο줽�ǤH��,�Ч�Υ����q�l�H�c���K�X�n�J.<br><br>";
		str +="Password Error!!,Please <a href=\"sendredirect.jsp\">relogin</a>.<br>";
		str +="ED & Office user please use your password of Aero Mail to login the system.<br></P>";
	
			%> 
			<jsp:forward page="errorpage.jsp"> 
			<jsp:param name="messagestring" value="<%=str%>" />
			</jsp:forward>
			<%				

		}else{
			session.setAttribute("userid", userid);
			session.setAttribute("auth", "O");//office
			session.setAttribute("locked", "0"); //�s
			
			if(ckHR.isED()){
				session.setAttribute("occu","ED");
			}else{	
				session.setAttribute("occu","O");
			}
			
			wl.updLog(userid, userip,userhost, "FZ011B");
			%>
			<jsp:forward page="fzframe.jsp" /><!--fzframe.htm -->
		   <%

		}
	
	/*
		session.setAttribute("userid", userid);
		session.setAttribute("occu", rs);
		session.setAttribute("auth", "O");//office
		session.setAttribute("locked", "0"); //�s
		wl.updLog(userid, userip,userhost, "FZ011");
		%>
	    <jsp:forward page="fzframe.jsp" /><!--fzframe.htm -->
	   <%
	   */
	}
	else if("192.168".equals(userip.substring(0,7)) &&(( "TPEOV".equals(userid) || ("TPECO").equals(userid))&& "27123141".equals(password))){//����ip
		session.setAttribute("userid", userid);
		wl.updLog(userid, userip,userhost, "FZ011B");
		%>
	    <jsp:forward page="fzframe2.jsp" /><!--fzframe.htm -->
	   <%
	}
	else//"You are not authorized !"
	{
	String str = null;
		//add by cs66 2005/07/11 ��l����ED�POfficer �����αb���A�אּ���{��
	 if (ckHR.isED() |  ckHR.isFZOfficer()) {
		//		check aero mail
		CheckAeroMail ckMail = new CheckAeroMail();
		if (ckMail.isPassAeroMail()) {	//�q�L�����H�c�{��
			session.setAttribute("userid", userid);
			session.setAttribute("auth", "O");//office
			session.setAttribute("locked", "0"); //�s
			
			if(ckHR.isED()){
				session.setAttribute("occu","ED");
			}else{	
				session.setAttribute("occu","O");
			}
			
			wl.updLog(userid, userip,userhost, "FZ011B");
			%>
			<jsp:forward page="fzframe.jsp" /><!--fzframe.htm -->
		   <%
	
		}else {
			str = "<p style='color:red' align=center>�K�X���~,�Э��s<a href=\"sendredirect.jsp\">�n�J</a>.<br>";
			str +="����Ʀw���ΫO�K,�Y��_ED�ο줽�ǤH��,�Ч�Υ����q�l�H�c���K�X�n�J.<br><br>";
			str +="Password Error!!,Please <a href=\"sendredirect.jsp\">relogin</a>.<br>";
			str +="ED & Office user please use your password of Aero Mail to login the system.<br></P>";


	
		%> 
		<jsp:forward page="errorpage.jsp"> 
		<jsp:param name="messagestring" value="<%=str%>" />
		</jsp:forward>
		<%	
		
		}

	
	}// end of ED & OFFICE User

	else if("Y".equals(rs.substring(0,1))){	//"You are not authorized !"
		str = "<p style='color:red' align=center>You have not been authorized.<br> "
			+"In case of new, suspended or  recurrent staff,<br> "
			+"Please contact with affiliated units to apply  account.  <br>"
			+"���b�����Q���v�n�J.<br> �Y���s�i�խ��ίd��.�_¾�H���A<br>�Ь����ݳ��ӽбb��.</p>";
	}else{	//Please check your Id & password
		str = "<p style='color:red' align=center>Incorrect password.<br>"
		+"If you forget your password,<br>"
		+"use the link of Forget Password in homepage,<br>"
		+"you can get the email of password from aero mail" 
		+"In case of new, suspended or  recurrent staff,<br> "
		+"Please contact with affiliated units to apply  account.  <br>"
		+"<br>�K�X�����T!!<br>�Y�ѰO�K�X,���I�ﭺ��Forget Password,<br>�æܥ����H�c�����K�X�H��.."
		+"<br> �Y���s�i�խ��ίd��.�_¾�H���A<br>�Ь����ݳ��ӽбb��.</p>";
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