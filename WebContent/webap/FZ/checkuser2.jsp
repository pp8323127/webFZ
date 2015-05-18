<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*,fzAuth.*" %>
<%!
	// 由於使用者名單是共享物件且設定為單一instance
	// 故宣告方式不能用<jsp:useBean>的tag

	UserList userlist = UserList.getInstance();
%>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	chkUser cu = new chkUser();
	
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
//session.setAttribute("outside",request.getAttribute("outside"));//從internet進入

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
	// 如果是新的session
	if (session.isNew())
	{
   		// 設定使用者id進入追蹤物件中	
      	usertrace.setUserName(userid);
   
   		// 將使用者追蹤物件加入session內	
   		session.setAttribute("usertrace",usertrace);
   
   		// 將使用者加入使用者名單中
   		userlist.addUser(usertrace.getUserName());
   
   		// 設定session在30分鐘之內沒有活動就使session無效
	    session.setMaxInactiveInterval(1800);
	}
	
	session.setAttribute("password", password);

	//使用全員信箱密碼認證
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
	   session.setAttribute("locked", cu.checkLock(userid));//N : 不鎖定/開放, Y : 鎖定/不開放
	   wl.updLog(userid, userip,userhost, "FZ011B");
		//add by cs66 at 2005/06 ~~TSA FORM: 強制組員需填寫資料才能登入
	   %>
	    <jsp:forward page="fzframe.jsp?forceCheck=Y" /> <!--fzframe.jsp  tsaForm/forceTSA.jsp  fzframe.jsp?forceCheck=Y -->
	   <%

	}
	else if (rs.equals("ED") || rs.equals("O"))
	{
	
		CheckAeroMail ckMail = new CheckAeroMail();
		if (!ckMail.isPassAeroMail()) {	
		String  str = "<p style='color:red' align=center>密碼錯誤,請重新<a href=\"sendredirect.jsp\">登入</a>.<br>";
		str +="為資料安全及保密,即日起ED及辦公室人員,請改用全員電子信箱之密碼登入.<br><br>";
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
			session.setAttribute("locked", "0"); //零
			
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
		session.setAttribute("locked", "0"); //零
		wl.updLog(userid, userip,userhost, "FZ011");
		%>
	    <jsp:forward page="fzframe.jsp" /><!--fzframe.htm -->
	   <%
	   */
	}
	else if("192.168".equals(userip.substring(0,7)) &&(( "TPEOV".equals(userid) || ("TPECO").equals(userid))&& "27123141".equals(password))){//內部ip
		session.setAttribute("userid", userid);
		wl.updLog(userid, userip,userhost, "FZ011B");
		%>
	    <jsp:forward page="fzframe2.jsp" /><!--fzframe.htm -->
	   <%
	}
	else//"You are not authorized !"
	{
	String str = null;
		//add by cs66 2005/07/11 原始驗證ED與Officer 為公用帳號，改為原原認證
	 if (ckHR.isED() |  ckHR.isFZOfficer()) {
		//		check aero mail
		CheckAeroMail ckMail = new CheckAeroMail();
		if (ckMail.isPassAeroMail()) {	//通過全員信箱認證
			session.setAttribute("userid", userid);
			session.setAttribute("auth", "O");//office
			session.setAttribute("locked", "0"); //零
			
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
			str = "<p style='color:red' align=center>密碼錯誤,請重新<a href=\"sendredirect.jsp\">登入</a>.<br>";
			str +="為資料安全及保密,即日起ED及辦公室人員,請改用全員電子信箱之密碼登入.<br><br>";
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
			+"此帳號未被授權登入.<br> 若為新進組員或留停.復職人員，<br>請洽所屬單位申請帳號.</p>";
	}else{	//Please check your Id & password
		str = "<p style='color:red' align=center>Incorrect password.<br>"
		+"If you forget your password,<br>"
		+"use the link of Forget Password in homepage,<br>"
		+"you can get the email of password from aero mail" 
		+"In case of new, suspended or  recurrent staff,<br> "
		+"Please contact with affiliated units to apply  account.  <br>"
		+"<br>密碼不正確!!<br>若忘記密碼,請點選首頁Forget Password,<br>並至全員信箱收取密碼信件.."
		+"<br> 若為新進組員或留停.復職人員，<br>請洽所屬單位申請帳號.</p>";
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