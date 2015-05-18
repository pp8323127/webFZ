<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*,fzAuthP.*,java.sql.*,java.net.*" %>
<%!
	// �ѩ�ϥΪ̦W��O�@�ɪ���B�]�w����@instance
	// �G�ŧi�覡�����<jsp:useBean>��tag

	UserList userlist = UserList.getInstance();
%>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

String userid = (String)session.getAttribute("userid");
String password =  (String)session.getAttribute("password");
String userid_eip = (String) request.getParameter("Empn");
String pk_eip = (String) request.getParameter("PK");
String hostip = InetAddress.getLocalHost().getHostAddress();
String clientip = request.getRemoteAddr(); 
AuthFlow auth = null;

if(userid_eip != null && !"".equals(userid_eip))
{
	auth = new AuthFlow(pk_eip, userid_eip, hostip, clientip);	
	userid = userid_eip;
	session.setAttribute("userid",userid);
	session.setAttribute("password",password);
}
else
{
	auth = new AuthFlow(userid, password);
}

int authCase = auth.getAuthCase();

if("640790".equals(userid))
{
//authCase =14;
//userid = "630166";
//userid = "811027";
}

String msg = "";
String powerUser="N";
if("640790".equals(userid))
{
//System.out.print("auth = "+authCase);
}

switch (authCase) 
{
case 11:	//PowerUser �n�J���\
   session.setAttribute("cname", "ADM");
   session.setAttribute("sern", "99999");
   session.setAttribute("occu", "FA"); 
   session.setAttribute("base", "TPE");
   session.setAttribute("auth", "C");
   session.setAttribute("locked", "N");
	powerUser = "Y";
	
	break;
case 12:		//Crew �n�J���\
	FZCrewObj o = auth.getFzCrewObj();
   session.setAttribute("cname", o.getCname());
   session.setAttribute("sern", o.getSern());
   if(o.getOccu() == null){
   session.setAttribute("occu","CA");
   }else{
   session.setAttribute("occu", o.getOccu()); 
   }
   
   session.setAttribute("base", o.getBase());
   session.setAttribute("auth", "C");
   session.setAttribute("locked", o.getLocked());
   
    //�]�wsession 20130417				
	//***��AL�����簣���Ƶn�J�b��***//
	chkUserSession sess = new chkUserSession();
	session.setAttribute("sessStatus",sess.setUserSess(userid)) ;
	//out.println(session.getAttribute("sessStatus"));		
	break;
	
case 13:		//ED �n�J���\
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //�s
	session.setAttribute("occu","ED");	
	break;

case 14:	//Officer
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //�s
	session.setAttribute("occu","O");
	break;

case 15:	//ñ���Ȯɱb��
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //�s
	session.setAttribute("occu","ED");	
	break;

case 180:	//FZ�B���줽��
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //�s
	session.setAttribute("occu","180A");	
	break;
		
case 2:		// Crew or PowerUser �K�X���~
	msg = "Incorrect password.Your password is case sensitive. "
			+"If you forget your password,"
			+"use the link of Forget Password in homepage,"
			+"you can get the email of password from aero mail" 
			+"In case of new, suspended or  recurrent staff,<br><br> "
			+"�K�X�����T!!�Ъ`�N�K�X�Ϥ��j�p�g.�ѰO�K�X,���I�ﭺ��Forget Password,�æܥ����H�c�����K�X�H��.";
	break;
	
case 3:		//�K�X���~(ED or FZOfficer use Aero Mail)
	msg ="Password Error!!"
		+"ED & Office user please use your ** EIP ** password to login the system.<br><br>"
		+"�K�X���~!!ED�ο줽�ǤH��,�Шϥ� ** EIP ** ���K�X�n�J";
	break;
	
case 4:		//���v�����L�b��
	msg = " This account is invalid,if you are authoried,in case of new, suspended or  recurrent staff, "
		+"Please contact with affiliated units to apply  account."
		+"cockpit crew please contact with OV (EXT.6496) to create account.<br><br>"
		+"���b�����s�b.�s�i�խ��A�Ь����ݳ��ӽбb��.�e���խ��нЬ���ȸ굦��(EXT.6496)";
	break;

case 5:		//�ʤֱb���K�X
	msg ="The System is busy.Please retry login with your ID & Password.<br><br>" 
		+"�ثe�u�W�H�ƹL�h,�t�Φ��L��<br>�Э��s��J�b���K�X,�y��A��";
	break;

case 6:		//���Q���v
	//*******************************************************************
	if("EDUser".equals(userid))
	{
		ci.auth.PageAuth dzp2 = new ci.auth.PageAuth(userid, "", "CIIED0001");
		fzAuthP.CheckAccPwd ck = new fzAuthP.CheckAccPwd(userid,password);
		boolean hasCorrectAcc = ck.hasAccount();
		if (dzp2.isPrivilege() == true && hasCorrectAcc == true)
		{
			authCase = 16;
		}
		else
		{
			msg	="This account is not authorized.<br><br>"
		         +"���b�����Q���v,�L�k�n�J.";
			break;
		}
	}
	else
	{
		msg	="This account is not authorized.<br><br>"
			+"���b�����Q���v,�L�k�n�J.";
		break;
	}			
	//*******************************************************************

	//msg	="This account is not authorized.<br><br>���b�����Q���v,�L�k�n�J.";
	//break;
case 7:		//�n�J����
	msg = "Login Fail!!<br><br>�n�J����";
	break;
case 8:
	msg = "�Dñ���H���A���o�ϥΦ��b���n�J!!";
	break;
default:	//�n�J����
	msg = "Login Fail!!<br><br>�n�J����";
	break;
}


//�l�ܯS�w�խ�
fz.TraceLog tl = null;
if("638893".equals(userid) | "638844".equals(userid) 	
	|"640085".equals(userid) | "640603".equals(userid) 
	| "640729".equals(userid) )
{	
	tl = new fz.TraceLog(userid,request.getRemoteAddr(),password);		
}


//authCase = 11,12,13
//if( authCase /10 >0 && authCase != 15){//�n�J���\
if( authCase > 10 && authCase < 14)
{//�n�J���\
			session.setAttribute("userid", userid);
			session.setAttribute("powerUser",powerUser); 
			session.setMaxInactiveInterval(1800);
		
		//�[�Juser list
			UserTrace usertrace = new UserTrace();
			usertrace.setUserName(userid);					// �]�w�ϥΪ�id�i�J�l�ܪ���	
			session.setAttribute("usertrace",usertrace);	// �N�ϥΪ̰l�ܪ���[�Jsession��		
			userlist.addUser(usertrace.getUserName());		// �N�ϥΪ̥[�J�ϥΪ̦W�椤
			
		//�[�JLog
			fz.writeLog wl = new fz.writeLog();   
			wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011");
			

			 
		//�l�ܯS�w�խ�	 
			if(tl != null)
			{
				tl.writeLog(true);
			}
			

    //����խ��ݩ�e���Ϋ῵,�e���խ��n�J��ȯ����SIM Check�\��,SR6503	 
	fzac.CrewInfo ci = new fzac.CrewInfo(userid);
	fzac.CrewInfoObj ciObj = ci.getCrewInfo();
	/*
	if (ci.isHasData() && "Y".equals( ciObj.getFd_ind()) ){  //�e���խ�
		session.setAttribute("cs55.usr",userid);
		 response.sendRedirect("fzframeACCockpit.jsp");
	}else{
	
			//Crew�ݶ�gTSA
			 if(authCase == 12){
				 response.sendRedirect("fzframeAC.jsp?forceCheck=Y");
			 }else{
				 response.sendRedirect("fzframeAC.jsp");
			 }
	}
	*/
// SR6600	
	if (ci.isHasData() && "Y".equals( ciObj.getFd_ind()) )
	{//�e���խ�
		session.setAttribute("cs55.usr",userid);
		session.setAttribute("COCKPITCREW","Y");
	}
	//SR6536 �U�z�y���� ZC�����P�_
	else if (ci.isHasData() && "N".equals( ciObj.getFd_ind()) )
	{//�῵�խ�
		fzAuthP.UserID uid = new fzAuthP.UserID (userid,password);
		fzAuthP.CheckEG chkEG = new fzAuthP.CheckEG();
		if(chkEG.isEGCrew() )
		{
			fzAuthP.EGObj egObj =  chkEG.getEgObj();
			if("95".equals(egObj.getJobno()))
			{
				session.setAttribute("ZC","Y");
				session.setAttribute("groups",egObj.getGroup());
			}			
			session.setAttribute("EGStatus",egObj.getStatus());			
		}
	}	
		//Crew�ݶ�gTSA
	 if(authCase == 12)
	 {
		 //�Y��EIP SSO
		 if(userid_eip != null && !"".equals(userid_eip))
		 {
			response.sendRedirect("fzframeAC.jsp");
		 }
		 else
		 {
			response.sendRedirect("fzframeAC.jsp?forceCheck=Y");
		 }
	 }
	 else
	 {
		 response.sendRedirect("fzframeAC.jsp");
	 }
}
else if(authCase == 14)
{	// Officer
	session.setAttribute("userid", userid);
	session.setAttribute("occu","U");
	session.setAttribute("base", "");
	session.setAttribute("sern", "");
	session.setAttribute("cname", "Officer");		
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //�s
	session.setMaxInactiveInterval(1800);
	
	//�[�Juser list
	UserTrace usertrace = new UserTrace();
	usertrace.setUserName(userid);					// �]�w�ϥΪ�id�i�J�l�ܪ���	
	session.setAttribute("usertrace",usertrace);	// �N�ϥΪ̰l�ܪ���[�Jsession��		
	userlist.addUser(usertrace.getUserName());		// �N�ϥΪ̥[�J�ϥΪ̦W�椤

	//���o���ݸs��	
	fzAuthP.UserID usrid = new fzAuthP.UserID(userid,password);
	fzac.FZUsersGroup fzUser = new fzac.FZUsersGroup(userid);
	ArrayList fzUserGroup = null;
	try 
	{
		fzUser.SelectData();
		fzUserGroup =fzUser.getGroupAL(); 			
	} 
	catch (SQLException e) 
	{
	} 
	catch (Exception e) 
	{}
	
	//KHH ���Z�޲z�H��
	
	 if(fzUser.isBelongGroup("KHHEFFZ") )
	 {
	   session.setAttribute("KHHEFFZ","Y");   

		//�[�JLog
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011K");
	    response.sendRedirect("fzFrameKHH.jsp");			
	}
	else
	{	
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011");
		response.sendRedirect("fzframeAC.jsp");
	}		
}
else if( authCase == 15)
{ //ñ���Ȯɱb��edtemp,�K�X��ñ���H�������u��
//�n�J���\

	session.setAttribute("userid", password);
	session.setAttribute("powerUser",powerUser); 
	session.setMaxInactiveInterval(1800);

//�[�JLog
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");	
	response.sendRedirect("fzframeAC.jsp");
} 
else if( authCase == 16)
{ //ñ���@�αb��EDUser
//�n�J���\

	session.setAttribute("userid", userid);
	session.setAttribute("password",password); 
	session.setMaxInactiveInterval(1800);

//�[�JLog
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");	
	response.sendRedirect("fzframeAC.jsp");
} 
else if( authCase == 180)
{ //FZ�B���줽��
//�n�J���\

	session.setAttribute("userid", userid);
	session.setAttribute("password",password); 
	session.setMaxInactiveInterval(1800);

//�[�JLog
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");	
	response.sendRedirect("fzframeAC.jsp");
} 
//�s�W�b���v��
else if("192.168".equals(request.getRemoteAddr().substring(0,7)) 
		&& "TPEOV".equals(userid)
		&& "27123141".equals(password))
{//����ip
		session.setAttribute("userid", userid);
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");
		response.sendRedirect("fzframe2.jsp");
} //�ʤ�session value;
else if(authCase == 5)
{
	session.invalidate();	
	response.sendRedirect("login.htm");	
}
//�H�O�B�� �d�v�I
//marked by cs66 2007/12/18
/*
else if("630741".equals(userid)){
	UserID uid = new UserID(userid,password);
	CheckFZUser ckUser = new CheckFZUser();
	if(ckUser.isFZUser()){
		session.setAttribute("userid", userid);
		session.setAttribute("occu","O");
		session.setAttribute("locked", "0"); //�s
		session.setAttribute("base", "ADM");
		session.setAttribute("sern", "99999");
		session.setAttribute("cname", "Officer");		
		session.setAttribute("auth", "O");//office
		session.setAttribute("locked", "0"); //�s

			
		//�[�JLog
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011");
		response.sendRedirect("fzframeAC.jsp");	
		 
	}else{
		session.invalidate();
		out.print("login failed!!");
	}
}
*/
else
{
	//���o���ݸs��	
	fzAuthP.UserID usrid = new fzAuthP.UserID(userid,password);
	fzAuthP.CheckAeroMail chkMail = new fzAuthP.CheckAeroMail();
	//fzAuthP.CheckEIP ckEIP = new fzAuthP.CheckEIP(userid,password);	    
	fzac.FZUsersGroup fzUser = new fzac.FZUsersGroup(userid);
	ArrayList fzUserGroup = null;
	try 
	{
		fzUser.SelectData();
		fzUserGroup =fzUser.getGroupAL(); 			
	} 
	catch (SQLException e) 
	{
	} 
	catch (Exception e) 
	{}
	
	//KHH ���Z�޲z�H��
	
	 if(fzUser.isBelongGroup("KHHEFFZ") && chkMail.isPassAeroMail() )
	 //if(fzUser.isBelongGroup("KHHEFFZ") && ckEIP.isPassEIP() )
	 {
	   session.setAttribute("userid", userid);  
	   session.setAttribute("KHHEFFZ","Y");
	   
	   session.setAttribute("cname", "KHHEF");
	   session.setAttribute("auth", "O");//office
	   session.setAttribute("locked", "0"); //�s
	   session.setAttribute("occu","KHH");	

		//�[�JLog
	   fz.writeLog wl = new fz.writeLog();   
	   wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011K");
	   response.sendRedirect("fzFrameKHH.jsp");
	}
	else
	{	//Login Failed	
		//�g�Jlogin fail log
			ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/failLog.txt");
			wl2.WriteFileWithTime(userid+"\t"+request.getRemoteAddr()+"\tLogin Failed\t"+password);
		
		//�l�ܯS�w�խ�	 
			if(tl != null)
			{
				tl.writeLog(false);
			}					
			session.invalidate();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<TITLE> Login Fail </TITLE>
<link rel="stylesheet" type="text/css" href="errStyle.css">
</HEAD>
<BODY>
<div class="errStyle2">
<%=msg%><br><br>
<a href="login.htm" target="_self"> Login </a><br>
</div>

</BODY>
</HTML>

<%	

}
%>

