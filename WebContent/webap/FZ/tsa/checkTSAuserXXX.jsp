<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.sql.*,ci.auth.*"%>
<%
/*
授權更改備註

yyyymmdd,	單位SITAcode	(HR UnitCd) ,  需求單號 
20060612,	SINDM	(830)			,	SR6273,	使用tsaleft_ed, flight Crew List估能
20060612,	總經理室(010)			,SR6264
20060623,  行服處作業部整備組(2342)		,SR6294,使用Daily check ,flight crew List,,Schedule Query
20060714 ,空服會計（180B）,SR6335,使用 tsaleft_ed: Daily check, Crewlist query, Schedule query
20060810, SYDDM (862) ,SR6390 ,使用Daily check ,flight crew List,,Schedule Query
20061115 ,安管處一級單位（140C）,SR6538,安管處一級單位使用 tsaleft_qc.jsp (flight crew List,,Schedule Query)

*/

	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

String userid = request.getParameter("userid").trim();
String password = request.getParameter("password");

fzAuthP.UserID userID = new fzAuthP.UserID(userid,password);
fzAuthP.CheckAeroMail ckMail   = new fzAuthP.CheckAeroMail();

CheckHRUnit ct = null;
String unitcd = null;
String funitcd = null;
String cname = null;
String goPage = null;
String msg = null;
String indt = null;

// 特殊帳號
if (("123456".equals(userid) && "123456".equals(password)) 
		| ("caa01".equals(userid) && "98765".equals(password) ) ){
		
	   session.setAttribute("cs55.usr",userid);
	   session.setAttribute("fullUCD","fullUCD");
	   session.setAttribute("unidCD","unidCD");
		session.setAttribute("cabin","Y");	
		session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
	   if(userid.equals("123456")){
		goPage = "tsaframe.jsp?mypage=tsaleft.jsp";
	   }
	   else{
			goPage="tsaframe.jsp?mypage=tsaleft_caa.jsp";
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
else if( ("os99".equals(userid) && "cii9999".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
	
    goPage = "tsaframe.jsp?mypage=tsaleft_pub.jsp";
}

if(true){

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
//Step2. 取得自訂群組	
	ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(userid);
	try {
		ga.initData();
	//是否屬於某群組 boolean ga.isBelongThisGroup("群組名稱")
	//所屬群組	ga.getGrpAL();
	} catch (ClassNotFoundException e) {
		System.out.println("checkTSA Error:"+e.toString());
	} catch (SQLException e) {
		System.out.println("checkTSA Error:"+e.toString());
	}	
	
//Step3. 判斷單位及授權
	//Power User
	if(ga.isBelongThisGroup("CSOZEZ")){
		session.setAttribute("cabin",null);			
		//session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
		goPage =	"cspage.jsp";
	}
	
    // CKSML users for APIS-OE data maintenance: CS40 2006/10/03
	else if (userid.equals("635477") | userid.equals("633791")){			
		goPage="tsaframe.jsp?mypage=tsaleft_ml.jsp";
	}

	// 05%, 06% 航務處 ,141D 安全品保管理處, 010 總經理室
	else if ( unitcd.equals("05") 
		| unitcd.equals("06") | unitcd.equals("00") | funitcd.equals("010")){
		
		session.setAttribute("cabin","Y");	
		goPage = "tsaframe.htm";
	}
	
	// 090A 聯合管制處, 092 飛航管制部,093 航機簽派部 ,633 高雄分公司 運務部
	else if(funitcd.equals("093") | funitcd.equals("092") 
			| funitcd.equals("090A") | funitcd.equals("633") ){ 
			
		session.setAttribute("cabin","Y");		
		goPage = "tsaframe.jsp?mypage=tsaleft_od.jsp";

	}	
	
	//190A 空服派遣部, 195B空管,193B 空標,189空訓,181D空服行政,及空服處長室,空一～空四組  196~199
	//193C 空標短程作業組,193B 空標長程作業組
	// ED CII權限設定,排除具組員身份者
	/* 
	 外站判斷是否為空服組員,使用postcd 不等於 292.2921
		635 高雄分公司 空服組 
		811 泰國分公司 空服部 
		837 新加坡分公司 空服部 
		827 越南分公司( for SGNEM)
		850 東京辦事處( for TYOEM)
		8501 東京分公司( for TYOEM)
		180B 空服會計

	*/

	else if( ( !"200".equals(o.getAnalysa())
		&& (funitcd.equals("190A") | funitcd.equals("195B")  | funitcd.equals("193B") 
			  | funitcd.equals("193C") | funitcd.equals("193D") 
			  | funitcd.equals("189")   | funitcd.equals("181D") 
			  | ( funitcd.equals("180A") && null != o.getIndt()) 			  
			  | funitcd.equals("196") | funitcd.equals("197")  | funitcd.equals("198") | funitcd.equals("199")
			   | funitcd.equals("180B")
		   )
		     ) 
			 //TODO 外站 postcd 非292. 2921
		  | 
		 ( (
		  funitcd.equals("635")   | funitcd.equals("811") | funitcd.equals("837")  
			  | funitcd.equals("827")   | funitcd.equals("850") | funitcd.equals("8501") 
		   )
		   && (!"2921".equals(o.getPostcd()) && !"292".equals(o.getPostcd()))
		  )
		   ){		   
		   		session.setAttribute("cabin","N");		
				goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		   		   		
	}	
	/*	20060612,	SINDM	(830),	SR6273,	使用tsaleft_ed, flight Crew List功能	*/
	
	else if(funitcd.equals("830")){
		   		session.setAttribute("cabin","N");		
				goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
	}	
	
	// 20070423 ,安全管理處 桃園機場地區安全管理組( 1442),SR7150 ,tsaleft_qc2.jsp(flight crew List)
	else if("144G".equals(funitcd)){
		session.setAttribute("cabin","Y");			
		goPage = "tsaframe.jsp?mypage=tsaleft_qc2.jsp";
	}
//安全品保部		,飛安部,安管處一級單位, 
/* 	20061115 ,安管處一級單位（140C）,SR6538,安管處一級單位使用 tsaleft_qc.jsp (flight crew List,,Schedule Query) 
	20061227,安全管理處保安部(142F), tsaleft_qc.jsp (flight crew List,,Schedule Query,crew List Query)
*/	else if(funitcd.equals("141D")|funitcd.equals("141F") |funitcd.equals("140C") |  funitcd.equals("142E") ){ 
			
		session.setAttribute("cabin","Y");		
		if(funitcd.equals("142E") ){
		session.setAttribute("OZPUB","Y");//組派公用帳號,crew List Query只能查詢
		}
		
		goPage = "tsaframe.jsp?mypage=tsaleft_qc.jsp";

	}	
	

	/*	20060623,  行服處作業部(2342)		,SR6294,使用Daily check ,flight crew List,Schedule Query 	*/
	/*	20060810,  SYDDM (862)		,SR6390,使用Daily check ,flight crew List,Schedule Query 	*/

	else if(funitcd.equals("2342")  | funitcd.equals("862")){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_kl.jsp";

	}	
		/* 20071030 SR7410  人力處員關部使用 Schedule Query, Crew basic Info */
	else if(funitcd.equals("048A")){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ir.jsp";

	}	
	/*	20060628,  外站(7 or 8)		,add by cs55 	*/

	else if("7".equals(funitcd.substring(0,1)) || "8".equals(funitcd.substring(0,1)) || "9".equals(funitcd.substring(0,1)) ){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";

	}
	
	//空一～空四組及空標的組長,於 MT 中設定群組為 CIIEFEE
	else if(ga.isBelongThisGroup("CIIEFEE")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		
	}	
	
	//車服部使用Crew Car功能
	else if(ga.isBelongThisGroup("CIIUV")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
	} 
		//642241 黃威遠  CP GD 開發
	else if(ga.isBelongThisGroup("CPDCS")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_dcs.jsp";
		
	}	

	//785B 阿布達比分公司 
	else if(funitcd.equals("785B")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";
	} 
//行銷服務處 
	//modify by Betty
	//else if(ga.isBelongThisGroup("CIIKB"))
	//else if (dzp.isPrivilege() == true)
	//{
	//  goPage = "tsaframe.jsp?mypage=tsaleft_kb.jsp";
	//} 		
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
				msg = "You are not authorized!!";
			}
		}
		else
		{		
			msg = "You are not authorized!!";
		}
	}
	
}//其他狀況
else{
	msg = "Login Fail!!";

}

//登入轉頁或錯誤訊息顯示
if(msg == null){

	response.sendRedirect(goPage);

}else{
	session.invalidate();

%>
<DIV style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;text-align:left;padding:10pt ;line-height: 2;	margin-left:auto;margin-right:auto;margin-top:20pt;width: 500pt;">
<%=msg%><br><br>
<a href="index.htm" target="_self"> Login </a><br>

</DIV>



<%

}

%>
