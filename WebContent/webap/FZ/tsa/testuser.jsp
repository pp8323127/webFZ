<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="fz.*,java.sql.*,ci.auth.*,fzAuthP.CheckAccPwd" %>
<%
String msg = null;
String loginIP = null ;
try {
loginIP = request.getRemoteAddr();
} catch (Exception e) {}

//10.152.10: VPN client for SZX
if(!"192.168".equals(loginIP.substring(0,7)) && !"10.152.10".equals(loginIP.substring(0,9)) ){
	msg = "���t�Υu�ϥΩ󤽥q����<br>This website use in Intranet only";
}


/*	20060628,  �~��(7 or 8)		,add by cs55 	*/
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

String userid = null ; //request.getParameter("userid").trim();
String password = null ; //request.getParameter("password");
String goPage = null;

userid= "633007" ;
password= "ku1q2w" ;

//@@@@@@@@@@@@@@@@@@@@@@@@@ 2009-3/27 CS40
// EZ�S��b��: �����H�c����ɨϥ�
if (("ez00".equals(userid) && "27123141".equals(password)) || ("EZRICK".equals(userid) && "27123141".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","190A");
	session.setAttribute("unidCD","06");	
	session.setAttribute("cabin","Y");
	session.setAttribute("EZPUB","Y");
    goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";	
// OZ�S��b��: �����H�c����ɨϥ�
}else if ("oz00".equals(userid) && "27123141".equals(password)){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","068D");
	session.setAttribute("unidCD","06");	
	session.setAttribute("cabin","N");
	session.setAttribute("OZPUB","Y");
    goPage = "tsaframe.jsp?mypage=tsaleft.jsp";
}else{
//@@@@@@@@@@@@@@@@@@@@@  2009-3/27 CS40

fzAuthP.UserID userID = new fzAuthP.UserID(userid,password);
fzAuthP.CheckAeroMail ckMail   = new fzAuthP.CheckAeroMail();
CheckHRUnit ct = null;
String unitcd = null;
String funitcd = null;
String cname = null;

String indt = null;

String sCHRUver = null ;

// �S��b��
if (("123456".equals(userid) && "123456".equals(password)) 
		| ("caa01".equals(userid) && "98765".equals(password) ) )
{
		
	   session.setAttribute("cs55.usr",userid);
	   session.setAttribute("fullUCD","fullUCD");
	   session.setAttribute("unidCD","unidCD");
		session.setAttribute("cabin","Y");	
		session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
	   if(userid.equals("123456")){
		goPage = "tsaframe.jsp?mypage=tsaleft.jsp";
	   }
	   else{
			goPage="tsaframe.jsp?mypage=tsaleft_oz2.jsp";
	   }
}
// �S��b��
else if( ("999136".equals(userid) && "661019".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","067D");
	session.setAttribute("unidCD","06");		
	
	session.setAttribute("cabin","Y");	
    goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
}
// �S��b��os99 �լ����αb��,
else if( ("os99".equals(userid) && "cii9999".equals(password)) )
{
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
	
    //goPage = "tsaframe.jsp?mypage=tsaleft_pub.jsp";
	goPage = "tsaframe.jsp?mypage=tsaleft_oz2.jsp";
}
// �S��b��chn99 �j���诸���αb��,
else if( ("chn99".equals(userid) && "chn9999".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("CHNPUB","Y");//�j���诸���αb��, ²�骩crew List�u��d��
	
	goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
}

// �S��b��rick: TPEEG PA Raw score teacher
else if( ("RICK".equals(userid) && "111111".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","N");	
	session.setAttribute("EGPARAW","Y");

	goPage = "tsaframe.jsp?mypage=tsaleft_paraw.jsp";
}

else if(ckMail.isPassAeroMail())
//else if(true)  //20070225 modify for temp resolve webloic/webfz  problem
{

	ct = new CheckHRUnit(userid);
	try {
		sCHRUver = ct.getVersion() ;
		ct.RetrieveData();
		
	} catch (SQLException e) {
		System.out.println("checkTSA Error:"+e.toString());
	} catch (ClassNotFoundException e) {
		System.out.println("checkTSA Error:"+e.toString());
	} catch (Exception e) {
		System.out.println("checkTSA Error:"+e.toString());
	}
	
	//SR7048:    �Ϣ��������Ϣ����� �����޲z�H��
	session.setAttribute("340330FLEET","N");

	HRObj o = null;

//Step1. ���o�H�Ƹ��	
	if (ct.isHR() && ct.isDutyEmp()) {	//���H�Ƹ�� & �b¾���u
		o= ct.getHrObj();
		funitcd = o.getUnitcd();	//���ݳ��
		unitcd = o.getUnitcd().substring(0,2);	//���ݳ��code�e��X
		cname = o.getCname();	//����m�W
		indt = o.getIndt();//�i���q��
		
		session.setAttribute("password", password);
		session.setAttribute("cs55.usr",userid);
		session.setAttribute("cs55.cname",cname);
		session.setAttribute("fullUCD",funitcd);
		session.setAttribute("unidCD",unitcd);		
		
	}

	
	

}

	out.println("<script>");
	out.println("//userid= "+userid);
	out.println("//ckMail.isPassAeroMail()= "+ckMail.isPassAeroMail());

	out.println("//sCHRUver= "+sCHRUver);
	out.println("//unitcd= "+unitcd);
	out.println("//cname= "+cname);
	out.println("</script>");


%>

<%

}

%>
<html>
<head>
</head>
<body>	
Test
</body>
</html>