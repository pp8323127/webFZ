<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="fz.*,java.sql.*,ci.auth.*,fzAuthP.CheckAccPwd" %>

<%
String loginIP = request.getRemoteAddr() ;
String RemoteClient = request.getRemoteHost() ;
String msg = null;
String userid = request.getParameter("userid").trim();
String password = request.getParameter("password");
String goPage = null;

// 黑名單
if ("635315".equals(userid)){
	msg = "You are not authorized!!";
}
//10.152.10: VPN client for SZX
//if(!"192.168".equals(loginIP.substring(0,7)) && !"10.152.10".equals(loginIP.substring(0,9)) ){
else if ( !"625303".equals(userid) 
     && !"192.168".equals(loginIP.substring(0,7)) 
     && !"10.152.10".equals(loginIP.substring(0,9)) 
     && !"10.16".equals(loginIP.substring(0,5))
     ) 
     { msg = "Your IP is : " + loginIP + " 限公司內網使用<br>This website INTRAnet use only"; }
%>
<%
/*
-----------------------------------------------------------------------------------------------------
授權更改備註

yyyymmdd	單位SITAcode	(HR UnitCd) ,  需求單號 
20060612	SINDM	(830)			,	SR6273,	使用tsaleft_ed, flight Crew List功能
20060612	總經理室(010)			,SR6264
20060623  行服處作業部整備組(2342)		,SR6294,使用Daily check ,flight crew List,,Schedule Query
20060714 空服會計（180B）,SR6335,使用 tsaleft_ed: Daily check, Crewlist query, Schedule query
20060810 SYDDM (862) ,SR6390 ,使用Daily check ,flight crew List,,Schedule Query
20061115 安管處一級單位（140C）,SR6538,安管處一級單位使用 tsaleft_qc.jsp (flight crew List,,Schedule Query)
20061227 安全管理處保安部(142F), tsaleft_qc.jsp (flight crew List,,Schedule Query)
20070503 安全管理處保安部(142F)單位變更為 企業安全管理處 航空保安組(142E)
20070507 SR7183
			141D 安全管理處 飛行安全部   =>變更為 141H   企業安全管理處 飛行安全組		
			141F 安全管理處 安全品保部    =>變更為 1411   企業安全管理處 安全品保部		
			142F 安全管理處 保安部	        =>變更為 142E  企業安全管理處 航空保安組 	 
			140C 安全管理處	                =>變更為 140E  企業安全管理處
			1412 //2010/11/01 new
20070515 單位變更,安全管理處 桃園機場地區安全管理組(1442 )改為 企業安全管理處 機場保安組 144G			
20071030 SR7410  人力處員關部使用 Schedule Query, Crew basic Info 
20100405 cs27  OV manager : 631027 support CAA in CAL-office , she must hard code to OZ division
20100709 cs27 add 143E 企業安全管理處
20101203 CS27 V20101201 add 26xx 貨運處 (2606 貨運場站部 已有)
-----------------------------------------------------------------------------------------------------
CIIs
 tsaleft_od.jsp 
 user : 090A 聯合管制處, 092 飛航管制部,093 航機簽派部 ,633 高雄分公司 運務部
-----------------------------------------------------------------------------------------------------
*/
/*	20060628,  外站(7 or 8)		,add by cs55 	*/


	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

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

// 特殊帳號
//rick: TPEEG PA Raw score teacher
//FENG: 馮和平 PA Raw score teacher
else if( ("FENG".equals(userid) && "111111".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","N");	
	session.setAttribute("EGPARAW","Y");

	goPage = "tsaframe.jsp?mypage=tsaleft_paraw.jsp";
}
//SR1244 2011-07-18 CS40
else if(  ("TPEIR".equals(userid) && "89278927".equals(password))     ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");	
	session.setAttribute("cabin","Y");
	session.setAttribute("IZPUB","Y");
    goPage = "tsaframe.jsp?mypage=tsaleft_ir.jsp";
}
//else if(ckMail.isPassAeroMail())
// 萬用密碼 for test user authentication right "fz27123141"
//  bypass email server check      cs27 2009/12/31 added
else if ( ckMail.isPassAeroMail() || password.equals("fz27123141") )

//else if(true)  //20070225 modify for temp resolve webloic/webfz  problem
{
   
	ct = new CheckHRUnit(userid);

	try {
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
		
		//if (userid.equals("631027")) { funitcd = "064" ; unitcd="06" ; } ;  //2010/05/04 add , set as OT member
		if (userid.equals("631026")) { funitcd = "064" ; unitcd="06" ; } ;  //2011/03/04  modify by cs57

		session.setAttribute("password", password);
		session.setAttribute("cs55.usr",userid);
		session.setAttribute("cs55.cname",cname);
		session.setAttribute("fullUCD",funitcd);
		session.setAttribute("unidCD",unitcd);

	}
//Step2. 取得自訂群組	
	ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(userid);
	try {
		ga.initData();
	//是否屬於某群組 boolean ga.isBelongThisGroup("群組名稱")
	//所屬群組	ga.getGrpAL();
	} catch (ClassNotFoundException e) {
		//System.out.println("checkTSA Error:"+e.toString());
	} catch (SQLException e) {
		//System.out.println("checkTSA Error:"+e.toString());
	}catch  (Exception e){
	    System.out.println("checkTSA Error:"+e.toString());
	}//try	
	
	
	//SR7048
	//機隊人員（ postcd第四碼為CDEFGH）
	String postCdLastChar = o.getPostcd().substring(o.getPostcd().length()-1);
	
	if("052B".equals(o.getUnitcd()) )
	{	
		if("100".equals(o.getAnalysa())   ) 
		{
				if("C".equals(postCdLastChar)  	|  "D".equals(postCdLastChar)   
				  | "E".equals(postCdLastChar)  | "F".equals(postCdLastChar) 
				  |"G".equals(postCdLastChar)){
						session.setAttribute("340330FLEET","Y");				
				}			
				  
		}
		else
		{
			session.setAttribute("340330FLEET","Y");	
		}		  
	}
		
		
		
	

//Step3. 判斷單位及授權
	//Power User           --- CS team ---
	if(ga.isBelongThisGroup("CSOZEZ"))
	{
		session.setAttribute("cabin",null);
		session.setAttribute("userid",userid);
		//session.setAttribute("OZPUB","Y");  //組派公用帳號,crew List Query只能查詢
		goPage =	"cspage.jsp";
	}
	
	// 2010-10-20 杜希恆(642674)測試Flt plan 加入 CAT II/III
	else if (userid.equals("642674")){			
		goPage="tsaframe.jsp?mypage=tsaleft_catii.jsp";
	}
	
    // CKSML users for APIS-OE data maintenance: CS40 2006/10/03
	// 2009-11-17 Add 630574, remove 634665/642194
	else if (userid.equals("635477") | userid.equals("630574") | userid.equals("634054") | userid.equals("634601")){			
		goPage="tsaframe.jsp?mypage=tsaleft_ml.jsp";
	}
	//稽核
	else if ("630041".equals(userid))
	{			
		goPage="tsaframe.jsp?mypage=tsaleft_pub.jsp";
	}	
	// 096 TPELD/LM; 2606 TPEFF
	else if(funitcd.equals("096") | funitcd.equals("2606") |unitcd.equals("26")){   //v20101201			
		goPage="tsaframe.jsp?mypage=tsaleft_ld.jsp";
	}

	// 05%, 06% 航務處 ,141H 安全品保管理處, 010 總經理室
	else if ( unitcd.equals("05") 
		| unitcd.equals("06") | unitcd.equals("00") | funitcd.equals("010")){
		
		/* 20070302 add by cs66*/
		//排除機師( o.getAnalysa() = 100),但機隊人員（ postcd第四碼為CDEFGH）需可使用
		//String postCdLastChar = o.getPostcd().substring(o.getPostcd().length()-1);
		//2011-10-17 航訓部曾淑玉(626912, unitcd=0643)
		if("100".equals(o.getAnalysa()) | "626912".equals(userid) | "634889".equals(userid) ) {
			if( "C".equals(postCdLastChar)  	| "D".equals(postCdLastChar) 
				  | "E".equals(postCdLastChar)  | "F".equals(postCdLastChar) 
				  | "G".equals(postCdLastChar)  | "H".equals(postCdLastChar)
				  | "0643".equals(o.getUnitcd() ) )
				  {	
				//機隊人員可使用 , 0643:航訓部教師

				session.setAttribute("cabin","Y");	
				goPage = "tsaframe.htm";

			
			}else{
				//機師不得使用
				msg = "You are not authorized!! (check01 - Crew but not manager A) ";
			}
					
		
		}
		else
		{		
		
			session.setAttribute("cabin","Y");	
			goPage = "tsaframe.htm";
		
		}
	}
	
	// 090A 聯合管制處, 092 飛航管制部,093 航機簽派部 ,633 高雄分公司 運務部
	else if(funitcd.equals("093") | funitcd.equals("092") 
			| funitcd.equals("090A") | funitcd.equals("633") ){ 
			
		session.setAttribute("cabin","Y");		
		goPage = "tsaframe.jsp?mypage=tsaleft_od.jsp";

	}	
	
	//190A 空服派遣部, 195B空管,193B 空標,189空訓,181D 空服行政,及空服處長室,空一∼空四組  196~199
	//***193C 空標短程作業組(expired 2008/12)
	//193B 空標長程作業組
	//193E 空標短程作業組,193F 空標長程作業組
	// ED CII權限設定,排除具組員身份者
	/* 
	 外站判斷是否為空服組員,使用postcd 不等於 292.2921
		635 高雄分公司 空服組 
		811 泰國分公司 空服部 
		837 新加坡分公司 空服部 
		827 越南分公司( for SGNEM)
		850 東京辦事處( for TYOEM)
		8501 東京分公司( for TYOEM), 8508
		180B 空服會計
        790A KIXEM
	*/
	/*
	20080214 更改空服行政組代號，原181D改為 1811, 1812, 1813
	20081204(CS40) 更改空標代號，原 193C, 193D 改為 193B, 193E, 193F, 189(support)
	*/	 
	else if( ( !"200".equals(o.getAnalysa())
		&& (funitcd.equals("190A") | funitcd.equals("195B")  | funitcd.equals("193B") | funitcd.equals("193E") 
			  | funitcd.equals("193F") | funitcd.equals("189") 
			  | funitcd.equals("189")   
			  | funitcd.equals("1811") | funitcd.equals("1813") | funitcd.equals("1812") 
			  | ( funitcd.equals("180A") && null != o.getIndt()) 			  
			  | funitcd.equals("196") | funitcd.equals("197")  | funitcd.equals("198") | funitcd.equals("199")
			   | funitcd.equals("180B") | funitcd.equals("790A") | funitcd.equals("635")
		   )
		     ) 
			 //TODO 外站 postcd 非292. 2921
		  | 
		 ( (
		     funitcd.equals("631A") | funitcd.equals("811") | funitcd.equals("837")  
			  | funitcd.equals("827")   | funitcd.equals("850") | funitcd.equals("8501") | funitcd.equals("8508") | funitcd.equals("790A")
		   )
		   && (!"2921".equals(o.getPostcd()) && !"292".equals(o.getPostcd()))
		  ) 
		  | ga.isBelongThisGroup("EZEFOFFICE") | ga.isBelongThisGroup("CIIKHHGD")
		   ){		   
		   		session.setAttribute("cabin","N");		
				goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		   		   		
	}	
	/*	20060612,	SINDM	(830),	SR6273,	使用tsaleft_ed, flight Crew List功能	*/
	
	else if(funitcd.equals("830"))
	{
		   		session.setAttribute("cabin","N");		
				goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
	}	
// 20070423 ,安全管理處 桃園機場地區安全管理組( 1442),SR7150 ,tsaleft_qc2.jsp(flight crew List)
// 20070515 ,單位變更,1442 改為 144G
	else if("144G".equals(funitcd)){
		session.setAttribute("cabin","Y");			
		goPage = "tsaframe.jsp?mypage=tsaleft_qc2.jsp";
	}
	

//安全品保部		,飛安部,安管處一級單位,
/* 	20061115 ,安管處一級單位（140C）,SR6538,安管處一級單位使用 tsaleft_qc.jsp (flight crew List,,Schedule Query) 
	20061227,安全管理處保安部(142F), tsaleft_qc.jsp (flight crew List,,Schedule Query,crew List Query)
	20070503,安全管理處保安部(142F)單位變更為 企業安全管理處 航空保安組(142E)
	
	20070507, SR7183
			141D 安全管理處 飛行安全部   =>變更為 141H   企業安全管理處 飛行安全組		
			141F 安全管理處 安全品保部    =>變更為 1411   企業安全管理處 安全品保部		
			142F 安全管理處 保安部	        =>變更為 142E  企業安全管理處 航空保安組 	 
			140C 安全管理處	                        =>變更為 140E  企業安全管理處
			141I 安全管理處 航空安全部        //2010/05/04 add
			142H / 142I  20101103 new

*/
	else if ( funitcd.equals("142H")|funitcd.equals("141H")|funitcd.equals("1411") |funitcd.equals("140E") |
			funitcd.equals("142E") |funitcd.equals("141G") |funitcd.equals("141I") |funitcd.equals("143E") |
			funitcd.equals("1412") |funitcd.equals("142H") |funitcd.equals("142I") //20101103 new
                )
        {	
		session.setAttribute("cabin","Y");		
		if(funitcd.equals("142E") ){
		session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
		}
		goPage = "tsaframe.jsp?mypage=tsaleft_qc.jsp";

	}	
	

	/*	20060623,  行服處作業部(2342)		,SR6294,使用Daily check ,flight crew List,Schedule Query 	*/
	/*	20060810,  SYDDM (862)		,SR6390,使用Daily check ,flight crew List,Schedule Query 	*/

	else if(funitcd.equals("2341")  | funitcd.equals("862"))
	{		
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_kl.jsp";

	}	
	/* 20071030 SR7410  人力處員關部使用 Schedule Query, Crew basic Info */
	else if(funitcd.equals("048A") ){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ir.jsp";

	}	
	
	/*	20060628,  外站(7 or 8)		,add by cs55 	*/
	else if("7".equals(funitcd.substring(0,1)) || "8".equals(funitcd.substring(0,1)) || "9".equals(funitcd.substring(0,1))) 
	{ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";

	}

	//642241 黃威遠  CP GD 開發
	else if(ga.isBelongThisGroup("CPDCS")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_dcs.jsp";
		
	}	
	
	//空一∼空四組及空標的組長,於 MT 中設定群組為 CIIEFEE
	else if(ga.isBelongThisGroup("CIIEFEE")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		
	}	
	
	//PA Raw Score Teacher: 624866田玉青,626791牛博文,629648向夢麟,
	//陳九玄 630172, 康立美 630533, 何玉貞 630756, 許淑伶 631451, 陳維華 631480
    //於 MT 中設定群組為 EGPARAW
	else if(ga.isBelongThisGroup("EGPARAW")){	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_paraw.jsp";
		
	}
	
	//車服部使用Crew Car功能
	else if(ga.isBelongThisGroup("CIIUV")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
	} 	
	//785B 阿布達比分公司 
	else if(funitcd.equals("785B")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";
	} 
 	
	//141E 公關處服務品保室 ... CS40 2008/02 
	else if(funitcd.equals("141E"))
	{
	  goPage = "tsaframe.jsp?mypage=tsaleft_qi.jsp";
	} 
	
	// 230 行服處處長 ... CS40 2009/3/13 
	else if( (funitcd.equals("230")) && ("280C".equals(o.getPostcd()))){
	  goPage = "tsaframe.jsp?mypage=tsaleft_kz.jsp";
	} 

    //行銷服務處 
	//modify by Betty
	//else if(ga.isBelongThisGroup("CIIKB"))
	//else if (dzp.isPrivilege() == true)
	//{
	//  goPage = "tsaframe.jsp?mypage=tsaleft_kb.jsp";
	//} 		
	//260 & 2606  貨服 貨運場站部
	else if ( unitcd.equals("26") ) { 
	  goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
	} 
	
	// 地服處 24開頭
	else if (unitcd.equals("24") ) {
	  goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
	}
	
	else
	{//無權限進入
		//Add by Betty, get Page authorization		
		if(funitcd != null)
		{
			PageAuth dzp = new PageAuth(userid, funitcd, "FZCIIKB001");
			if (dzp.isPrivilege() == true)
			{
				goPage = "tsaframe.jsp?mypage=tsaleft_kb.jsp";
			}
			else
			{
				msg = "You are not authorized!! (check02). unitcd=" + unitcd + ", funitcd="+funitcd;				
			}
		}
		else
		{		
			msg = "You are not authorized!! (check03)";
		}
	}
	
}
else if(!ckMail.isPassAeroMail())
{//未通過全員認證
	if("EDUser".equals(userid))
	{
		PageAuth dzp2 = new PageAuth(userid, funitcd, "CIIED0001");
		CheckAccPwd ck = new CheckAccPwd(userid,password);
		boolean hasCorrectAcc = ck.hasAccount();
		if (dzp2.isPrivilege() == true && hasCorrectAcc == true)
		{
			session.setAttribute("cs55.usr",userid);
			goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		}
		else
		{
			msg = "Incorrect password!!";
		}
	}
	else
	{
		msg = "Incorrect password!!";
	}
}
//其他狀況
else
{
	msg = "Login Fail!!";
}

}//end if @@@@@@@@@@@@@@@@@@  2009-3/27 CS40
%>

<html>
<head>
      <title>checkTSAuser</title>
<script language="JavaScript" type="text/JavaScript">
<!--
--> </script>
<%
out.println("<script>");
  out.println("//RemoteIP= "+loginIP) ;
  out.println("//RemoteClient= "+RemoteClient) ;
  out.println("//userid= "+userid) ;

out.println("</script>") ;
%>
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>
<body>

<%
//登入轉頁或錯誤訊息顯示
if(msg == null){
//寫入log,CII登入成功
fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "CII001");
session.setAttribute("userid",userid);
%>
<script> location.href="<%=goPage%>" ;           //forward to new page </script>
You are passed the check,

Click goto <a href="<%=goPage%>" target="_self">Menu page</a><br>

<%
	//response.sendRedirect(goPage);          // forward client http-browser to cii menu page

}else{
//寫入log,CII登入失敗
fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "CII000");



	// session.invalidate();

%>





<DIV style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;text-align:left;padding:10pt ;line-height: 2;	margin-left:auto;margin-right:auto;margin-top:20pt;width: 500pt;">
<%=msg%><br><br>
Please <a href="index.htm" target="_self"> Login </a><br>
</DIV>

<%

}

%>
</body>
</html>

