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
	msg = "此系統只使用於公司內部<br>This website use in Intranet only";
}


/*	20060628,  外站(7 or 8)		,add by cs55 	*/
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

String userid = null ; //request.getParameter("userid").trim();
String password = null ; //request.getParameter("password");
String goPage = null;

userid= "633007" ;
password= "ku1q2w" ;

//@@@@@@@@@@@@@@@@@@@@@@@@@ 2009-3/27 CS40
// EZ特殊帳號: 全員信箱當機時使用
if (("ez00".equals(userid) && "27123141".equals(password)) || ("EZRICK".equals(userid) && "27123141".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","190A");
	session.setAttribute("unidCD","06");	
	session.setAttribute("cabin","Y");
	session.setAttribute("EZPUB","Y");
    goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";	
// OZ特殊帳號: 全員信箱當機時使用
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

// 特殊帳號
if (("123456".equals(userid) && "123456".equals(password)) 
		| ("caa01".equals(userid) && "98765".equals(password) ) )
{
		
	   session.setAttribute("cs55.usr",userid);
	   session.setAttribute("fullUCD","fullUCD");
	   session.setAttribute("unidCD","unidCD");
		session.setAttribute("cabin","Y");	
		session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
	   if(userid.equals("123456")){
		goPage = "tsaframe.jsp?mypage=tsaleft.jsp";
	   }
	   else{
			goPage="tsaframe.jsp?mypage=tsaleft_oz2.jsp";
	   }
}
// 特殊帳號
else if( ("999136".equals(userid) && "661019".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","067D");
	session.setAttribute("unidCD","06");		
	
	session.setAttribute("cabin","Y");	
    goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
}
// 特殊帳號os99 組派公用帳號,
else if( ("os99".equals(userid) && "cii9999".equals(password)) )
{
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
	
    //goPage = "tsaframe.jsp?mypage=tsaleft_pub.jsp";
	goPage = "tsaframe.jsp?mypage=tsaleft_oz2.jsp";
}
// 特殊帳號chn99 大陸航站公用帳號,
else if( ("chn99".equals(userid) && "chn9999".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("CHNPUB","Y");//大陸航站公用帳號, 簡體版crew List只能查詢
	
	goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
}

// 特殊帳號rick: TPEEG PA Raw score teacher
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
	
	//SR7048:    Ａ３４０／Ａ３３０ 機隊管理人員
	session.setAttribute("340330FLEET","N");

	HRObj o = null;

//Step1. 取得人事資料	
	if (ct.isHR() && ct.isDutyEmp()) {	//有人事資料 & 在職員工
		o= ct.getHrObj();
		funitcd = o.getUnitcd();	//所屬單位
		unitcd = o.getUnitcd().substring(0,2);	//所屬單位code前兩碼
		cname = o.getCname();	//中文姓名
		indt = o.getIndt();//進公司日
		
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