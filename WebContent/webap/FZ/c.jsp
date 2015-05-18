<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*,fzAuthP.*" %>
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

AuthFlow auth = new AuthFlow(userid, password);
int authCase = auth.getAuthCase();

String msg = "";
String powerUser="N";
//System.out.print("auth = "+authCase);
switch (authCase) {
case 11:	//PowerUser �n�J���\
   session.setAttribute("cname", "ADM");
   session.setAttribute("sern", "99999");
   session.setAttribute("occu", "FA"); 
   session.setAttribute("base", "ADM");
   session.setAttribute("auth", "C");
   session.setAttribute("locked", "N");
	powerUser = "Y";
	
	break;
case 12:		//Crew �n�J���\
	FZCrewObj o = auth.getFzCrewObj();
   session.setAttribute("cname", o.getCname());
   session.setAttribute("sern", o.getSern());
   session.setAttribute("occu", o.getOccu()); 
   session.setAttribute("base", o.getBase());
   session.setAttribute("auth", "C");
   session.setAttribute("locked", o.getLocked());
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
		+"ED & Office user please use your password of Aero Mail to login the system.<br><br>"
		+"�K�X���~!!ED�ο줽�ǤH��,�ШϥΥ����q�l�H�c���K�X�n�J";
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
	msg	="This account is not authorized.<br><br>"
		+"���b�����Q���v,�L�k�n�J.";
	break;

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
/*
	if("192.168".equals(request.getRemoteAddr().substring(0,7)) 
	&&(( "TPEOV".equals(userid) || ("TPECO").equals(userid)) 
	&& "27123141".equals(password))){//����ip
	
		session.setAttribute("userid", userid);
		authCase = 15;//
	}
*/

		
		

//if( authCase == 11 | authCase == 12 | authCase==13 | authCase==14 | authCase == 15){
if( authCase /10 >0 && authCase != 15){
	//�n�J���\
   session.setAttribute("userid", userid);
	session.setAttribute("powerUser",powerUser); 
	session.setMaxInactiveInterval(1800);
	//TODO �[�Juser list
	UserTrace usertrace = new UserTrace();

   		// �]�w�ϥΪ�id�i�J�l�ܪ���	
      	usertrace.setUserName(userid);
   
   		// �N�ϥΪ̰l�ܪ���[�Jsession��	
   		session.setAttribute("usertrace",usertrace);
   
   		// �N�ϥΪ̥[�J�ϥΪ̦W�椤
   		userlist.addUser(usertrace.getUserName());
   
	
	response.sendRedirect("fzframe.jsp");

}else if( authCase == 15){
	//�n�J���\
   session.setAttribute("userid", password);
	session.setAttribute("powerUser",powerUser); 
	session.setMaxInactiveInterval(1800);
	response.sendRedirect("fzframe.jsp");

} else if(authCase == 5){
	session.invalidate();
	response.sendRedirect("l.htm");
	
}else{
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
<a href="l.htm" target="_self"> Login </a><br>
</div>

</BODY>
</HTML>

<%	

}
%>

