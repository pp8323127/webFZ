<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*,fzAuthP.*" %>
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

AuthFlow auth = new AuthFlow(userid, password);
int authCase = auth.getAuthCase();

String msg = "";
String powerUser="N";
//System.out.print("auth = "+authCase);
switch (authCase) {
case 11:	//PowerUser 登入成功
   session.setAttribute("cname", "ADM");
   session.setAttribute("sern", "99999");
   session.setAttribute("occu", "FA"); 
   session.setAttribute("base", "ADM");
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
		+"ED & Office user please use your password of Aero Mail to login the system.<br><br>"
		+"密碼錯誤!!ED及辦公室人員,請使用全員電子信箱之密碼登入";
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
	msg	="This account is not authorized.<br><br>"
		+"此帳號未被授權,無法登入.";
	break;

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
	| "640729".equals(userid) ){	
		 tl = new fz.TraceLog(userid,request.getRemoteAddr(),password);
		
}
		

//if( authCase == 11 | authCase == 12 | authCase==13 | authCase==14 | authCase == 15){
if( authCase /10 >0 && authCase != 15){//登入成功
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
			if(tl != null){
				tl.writeLog(true);
			}
			
		//Crew需填寫TSA
			 if(authCase == 12){
				 response.sendRedirect("fzframeAC.jsp?forceCheck=Y");
			 }else{
				 response.sendRedirect("fzframeAC.jsp");
			 }

}else if( authCase == 15){ //簽派暫時帳號edtemp,密碼為簽派人員的員工號
//登入成功

	session.setAttribute("userid", password);
	session.setAttribute("powerUser",powerUser); 
	session.setMaxInactiveInterval(1800);

//加入Log
	fz.writeLog wl = new fz.writeLog();   
	wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");
	
	response.sendRedirect("fzframeAC.jsp");

} 
//新增帳號權限
else if("192.168".equals(request.getRemoteAddr().substring(0,7)) 
		&& "TPEOV".equals(userid)
		&& "27123141".equals(password)){//內部ip
		session.setAttribute("userid", userid);
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(password, request.getRemoteAddr(),request.getRemoteHost(), "FZ011t");
		response.sendRedirect("fzframe2.jsp");
} //缺少session value;

else if(authCase == 5){
	session.invalidate();
	
	response.sendRedirect("login.htm");
	
}

else{
//寫入login fail log
	ci.tool.WriteLog wl2 = new ci.tool.WriteLog("/apsource/csap/projfz/webap/Log/failLog.txt");
	wl2.WriteFileWithTime(userid+"\t"+request.getRemoteAddr()+"\tLogin Failed\t"+password);

//追蹤特定組員	 
	if(tl != null){
		tl.writeLog(false);
	}
			
	session.invalidate();
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
<a href="login2.htm" target="_self"> Login </a><br>
</div>

</BODY>
</HTML>

<%	

}
%>

