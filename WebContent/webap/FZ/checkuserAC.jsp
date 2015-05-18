<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*,fzAuthP.*,java.sql.*,java.net.*" %>
<%!
	// 由於使用者名單是共享物件且設定為單一instance
	// 故宣告方式不能用<jsp:useBean>的tag

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
case 11:	//PowerUser 登入成功
   session.setAttribute("cname", "ADM");
   session.setAttribute("sern", "99999");
   session.setAttribute("occu", "FA"); 
   session.setAttribute("base", "TPE");
   session.setAttribute("auth", "C");
   session.setAttribute("locked", "N");
	powerUser = "Y";
	
	break;
case 12:		//Crew 登入成功
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
   
    //設定session 20130417				
	//***遞AL時應剔除重複登入帳號***//
	chkUserSession sess = new chkUserSession();
	session.setAttribute("sessStatus",sess.setUserSess(userid)) ;
	//out.println(session.getAttribute("sessStatus"));		
	break;
	
case 13:		//ED 登入成功
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //零
	session.setAttribute("occu","ED");	
	break;

case 14:	//Officer
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //零
	session.setAttribute("occu","O");
	break;

case 15:	//簽派暫時帳號
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //零
	session.setAttribute("occu","ED");	
	break;

case 180:	//FZ處長辦公室
	session.setAttribute("auth", "O");//office
	session.setAttribute("locked", "0"); //零
	session.setAttribute("occu","180A");	
	break;
		
case 2:		// Crew or PowerUser 密碼錯誤
	msg = "Incorrect password.Your password is case sensitive. "
			+"If you forget your password,"
			+"use the link of Forget Password in homepage,"
			+"you can get the email of password from aero mail" 
			+"In case of new, suspended or  recurrent staff,<br><br> "
			+"密碼不正確!!請注意密碼區分大小寫.忘記密碼,請點選首頁Forget Password,並至全員信箱收取密碼信件.";
	break;
	
case 3:		//密碼錯誤(ED or FZOfficer use Aero Mail)
	msg ="Password Error!!"
		+"ED & Office user please use your ** EIP ** password to login the system.<br><br>"
		+"密碼錯誤!!ED及辦公室人員,請使用 ** EIP ** 之密碼登入";
	break;
	
case 4:		//有權限但無帳號
	msg = " This account is invalid,if you are authoried,in case of new, suspended or  recurrent staff, "
		+"Please contact with affiliated units to apply  account."
		+"cockpit crew please contact with OV (EXT.6496) to create account.<br><br>"
		+"此帳號不存在.新進組員，請洽所屬單位申請帳號.前艙組員請請洽航務資策部(EXT.6496)";
	break;

case 5:		//缺少帳號密碼
	msg ="The System is busy.Please retry login with your ID & Password.<br><br>" 
		+"目前線上人數過多,系統忙碌中<br>請重新輸入帳號密碼,稍後再試";
	break;

case 6:		//未被授權
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
		         +"此帳號未被授權,無法登入.";
			break;
		}
	}
	else
	{
		msg	="This account is not authorized.<br><br>"
			+"此帳號未被授權,無法登入.";
		break;
	}			
	//*******************************************************************

	//msg	="This account is not authorized.<br><br>此帳號未被授權,無法登入.";
	//break;
case 7:		//登入失敗
	msg = "Login Fail!!<br><br>登入失敗";
	break;
case 8:
	msg = "非簽派人員，不得使用此帳號登入!!";
	break;
default:	//登入失敗
	msg = "Login Fail!!<br><br>登入失敗";
	break;
}


//追蹤特定組員
fz.TraceLog tl = null;
if("638893".equals(userid) | "638844".equals(userid) 	
	|"640085".equals(userid) | "640603".equals(userid) 
	| "640729".equals(userid) )
{	
	tl = new fz.TraceLog(userid,request.getRemoteAddr(),password);		
}


//authCase = 11,12,13
//if( authCase /10 >0 && authCase != 15){//登入成功
if( authCase > 10 && authCase < 14)
{//登入成功
			session.setAttribute("userid", userid);
			session.setAttribute("powerUser",powerUser); 
			session.setMaxInactiveInterval(1800);
		
		//加入user list
			UserTrace usertrace = new UserTrace();
			usertrace.setUserName(userid);					// 設定使用者id進入追蹤物件中	
			session.setAttribute("usertrace",usertrace);	// 將使用者追蹤物件加入session內		
			userlist.addUser(usertrace.getUserName());		// 將使用者加入使用者名單中
			
		//加入Log
			fz.writeLog wl = new fz.writeLog();   
			wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011");
			

			 
		//追蹤特定組員	 
			if(tl != null)
			{
				tl.writeLog(true);
			}
			

    //分辨組員屬於前艙或後艙,前艙組員登入後僅能顯示SIM Check功能,SR6503	 
	fzac.CrewInfo ci = new fzac.CrewInfo(userid);
	fzac.CrewInfoObj ciObj = ci.getCrewInfo();
	/*
	if (ci.isHasData() && "Y".equals( ciObj.getFd_ind()) ){  //前艙組員
		session.setAttribute("cs55.usr",userid);
		 response.sendRedirect("fzframeACCockpit.jsp");
	}else{
	
			//Crew需填寫TSA
			 if(authCase == 12){
				 response.sendRedirect("fzframeAC.jsp?forceCheck=Y");
			 }else{
				 response.sendRedirect("fzframeAC.jsp");
			 }
	}
	*/
// SR6600	
	if (ci.isHasData() && "Y".equals( ciObj.getFd_ind()) )
	{//前艙組員
		session.setAttribute("cs55.usr",userid);
		session.setAttribute("COCKPITCREW","Y");
	}
	//SR6536 助理座艙長 ZC身份判斷
	else if (ci.isHasData() && "N".equals( ciObj.getFd_ind()) )
	{//後艙組員
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
		//Crew需填寫TSA
	 if(authCase == 12)
	 {
		 //若為EIP SSO
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
	session.setAttribute("locked", "0"); //零
	session.setMaxInactiveInterval(1800);
	
	//加入user list
	UserTrace usertrace = new UserTrace();
	usertrace.setUserName(userid);					// 設定使用者id進入追蹤物件中	
	session.setAttribute("usertrace",usertrace);	// 將使用者追蹤物件加入session內		
	userlist.addUser(usertrace.getUserName());		// 將使用者加入使用者名單中

	//取得所屬群組	
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
	
	//KHH 換班管理人員
	
	 if(fzUser.isBelongGroup("KHHEFFZ") )
	 {
	   session.setAttribute("KHHEFFZ","Y");   

		//加入Log
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
{ //簽派暫時帳號edtemp,密碼為簽派人員的員工號
//登入成功

	session.setAttribute("userid", password);
	session.setAttribute("powerUser",powerUser); 
	session.setMaxInactiveInterval(1800);

//加入Log
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");	
	response.sendRedirect("fzframeAC.jsp");
} 
else if( authCase == 16)
{ //簽派共用帳號EDUser
//登入成功

	session.setAttribute("userid", userid);
	session.setAttribute("password",password); 
	session.setMaxInactiveInterval(1800);

//加入Log
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");	
	response.sendRedirect("fzframeAC.jsp");
} 
else if( authCase == 180)
{ //FZ處長辦公室
//登入成功

	session.setAttribute("userid", userid);
	session.setAttribute("password",password); 
	session.setMaxInactiveInterval(1800);

//加入Log
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");	
	response.sendRedirect("fzframeAC.jsp");
} 
//新增帳號權限
else if("192.168".equals(request.getRemoteAddr().substring(0,7)) 
		&& "TPEOV".equals(userid)
		&& "27123141".equals(password))
{//內部ip
		session.setAttribute("userid", userid);
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");
		response.sendRedirect("fzframe2.jsp");
} //缺少session value;
else if(authCase == 5)
{
	session.invalidate();	
	response.sendRedirect("login.htm");	
}
//人力處長 吳治富
//marked by cs66 2007/12/18
/*
else if("630741".equals(userid)){
	UserID uid = new UserID(userid,password);
	CheckFZUser ckUser = new CheckFZUser();
	if(ckUser.isFZUser()){
		session.setAttribute("userid", userid);
		session.setAttribute("occu","O");
		session.setAttribute("locked", "0"); //零
		session.setAttribute("base", "ADM");
		session.setAttribute("sern", "99999");
		session.setAttribute("cname", "Officer");		
		session.setAttribute("auth", "O");//office
		session.setAttribute("locked", "0"); //零

			
		//加入Log
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
	//取得所屬群組	
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
	
	//KHH 換班管理人員
	
	 if(fzUser.isBelongGroup("KHHEFFZ") && chkMail.isPassAeroMail() )
	 //if(fzUser.isBelongGroup("KHHEFFZ") && ckEIP.isPassEIP() )
	 {
	   session.setAttribute("userid", userid);  
	   session.setAttribute("KHHEFFZ","Y");
	   
	   session.setAttribute("cname", "KHHEF");
	   session.setAttribute("auth", "O");//office
	   session.setAttribute("locked", "0"); //零
	   session.setAttribute("occu","KHH");	

		//加入Log
	   fz.writeLog wl = new fz.writeLog();   
	   wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011K");
	   response.sendRedirect("fzFrameKHH.jsp");
	}
	else
	{	//Login Failed	
		//寫入login fail log
			ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/failLog.txt");
			wl2.WriteFileWithTime(userid+"\t"+request.getRemoteAddr()+"\tLogin Failed\t"+password);
		
		//追蹤特定組員	 
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

