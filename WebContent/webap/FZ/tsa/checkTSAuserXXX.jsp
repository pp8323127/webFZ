<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.sql.*,ci.auth.*"%>
<%
/*
���v���Ƶ�

yyyymmdd,	���SITAcode	(HR UnitCd) ,  �ݨD�渹 
20060612,	SINDM	(830)			,	SR6273,	�ϥ�tsaleft_ed, flight Crew List����
20060612,	�`�g�z��(010)			,SR6264
20060623,  ��A�B�@�~����Ʋ�(2342)		,SR6294,�ϥ�Daily check ,flight crew List,,Schedule Query
20060714 ,�ŪA�|�p�]180B�^,SR6335,�ϥ� tsaleft_ed: Daily check, Crewlist query, Schedule query
20060810, SYDDM (862) ,SR6390 ,�ϥ�Daily check ,flight crew List,,Schedule Query
20061115 ,�w�޳B�@�ų��]140C�^,SR6538,�w�޳B�@�ų��ϥ� tsaleft_qc.jsp (flight crew List,,Schedule Query)

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

// �S��b��
if (("123456".equals(userid) && "123456".equals(password)) 
		| ("caa01".equals(userid) && "98765".equals(password) ) ){
		
	   session.setAttribute("cs55.usr",userid);
	   session.setAttribute("fullUCD","fullUCD");
	   session.setAttribute("unidCD","unidCD");
		session.setAttribute("cabin","Y");	
		session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
	   if(userid.equals("123456")){
		goPage = "tsaframe.jsp?mypage=tsaleft.jsp";
	   }
	   else{
			goPage="tsaframe.jsp?mypage=tsaleft_caa.jsp";
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
else if( ("os99".equals(userid) && "cii9999".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
	
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
//Step2. ���o�ۭq�s��	
	ci.auth.GroupsAuth ga = new ci.auth.GroupsAuth(userid);
	try {
		ga.initData();
	//�O�_�ݩ�Y�s�� boolean ga.isBelongThisGroup("�s�զW��")
	//���ݸs��	ga.getGrpAL();
	} catch (ClassNotFoundException e) {
		System.out.println("checkTSA Error:"+e.toString());
	} catch (SQLException e) {
		System.out.println("checkTSA Error:"+e.toString());
	}	
	
//Step3. �P�_���α��v
	//Power User
	if(ga.isBelongThisGroup("CSOZEZ")){
		session.setAttribute("cabin",null);			
		//session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
		goPage =	"cspage.jsp";
	}
	
    // CKSML users for APIS-OE data maintenance: CS40 2006/10/03
	else if (userid.equals("635477") | userid.equals("633791")){			
		goPage="tsaframe.jsp?mypage=tsaleft_ml.jsp";
	}

	// 05%, 06% ��ȳB ,141D �w���~�O�޲z�B, 010 �`�g�z��
	else if ( unitcd.equals("05") 
		| unitcd.equals("06") | unitcd.equals("00") | funitcd.equals("010")){
		
		session.setAttribute("cabin","Y");	
		goPage = "tsaframe.htm";
	}
	
	// 090A �p�X�ި�B, 092 ����ި,093 ���ñ���� ,633 ���������q �B�ȳ�
	else if(funitcd.equals("093") | funitcd.equals("092") 
			| funitcd.equals("090A") | funitcd.equals("633") ){ 
			
		session.setAttribute("cabin","Y");		
		goPage = "tsaframe.jsp?mypage=tsaleft_od.jsp";

	}	
	
	//190A �ŪA������, 195B�ź�,193B �ż�,189�ŰV,181D�ŪA��F,�ΪŪA�B����,�Ť@��ť|��  196~199
	//193C �żеu�{�@�~��,193B �żЪ��{�@�~��
	// ED CII�v���]�w,�ư���խ�������
	/* 
	 �~���P�_�O�_���ŪA�խ�,�ϥ�postcd ������ 292.2921
		635 ���������q �ŪA�� 
		811 ��������q �ŪA�� 
		837 �s�[�Y�����q �ŪA�� 
		827 �V�n�����q( for SGNEM)
		850 �F�ʿ�ƳB( for TYOEM)
		8501 �F�ʤ����q( for TYOEM)
		180B �ŪA�|�p

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
			 //TODO �~�� postcd �D292. 2921
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
	/*	20060612,	SINDM	(830),	SR6273,	�ϥ�tsaleft_ed, flight Crew List�\��	*/
	
	else if(funitcd.equals("830")){
		   		session.setAttribute("cabin","N");		
				goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
	}	
	
	// 20070423 ,�w���޲z�B �������a�Ϧw���޲z��( 1442),SR7150 ,tsaleft_qc2.jsp(flight crew List)
	else if("144G".equals(funitcd)){
		session.setAttribute("cabin","Y");			
		goPage = "tsaframe.jsp?mypage=tsaleft_qc2.jsp";
	}
//�w���~�O��		,���w��,�w�޳B�@�ų��, 
/* 	20061115 ,�w�޳B�@�ų��]140C�^,SR6538,�w�޳B�@�ų��ϥ� tsaleft_qc.jsp (flight crew List,,Schedule Query) 
	20061227,�w���޲z�B�O�w��(142F), tsaleft_qc.jsp (flight crew List,,Schedule Query,crew List Query)
*/	else if(funitcd.equals("141D")|funitcd.equals("141F") |funitcd.equals("140C") |  funitcd.equals("142E") ){ 
			
		session.setAttribute("cabin","Y");		
		if(funitcd.equals("142E") ){
		session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
		}
		
		goPage = "tsaframe.jsp?mypage=tsaleft_qc.jsp";

	}	
	

	/*	20060623,  ��A�B�@�~��(2342)		,SR6294,�ϥ�Daily check ,flight crew List,Schedule Query 	*/
	/*	20060810,  SYDDM (862)		,SR6390,�ϥ�Daily check ,flight crew List,Schedule Query 	*/

	else if(funitcd.equals("2342")  | funitcd.equals("862")){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_kl.jsp";

	}	
		/* 20071030 SR7410  �H�O�B�������ϥ� Schedule Query, Crew basic Info */
	else if(funitcd.equals("048A")){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ir.jsp";

	}	
	/*	20060628,  �~��(7 or 8)		,add by cs55 	*/

	else if("7".equals(funitcd.substring(0,1)) || "8".equals(funitcd.substring(0,1)) || "9".equals(funitcd.substring(0,1)) ){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";

	}
	
	//�Ť@��ť|�դΪżЪ��ժ�,�� MT ���]�w�s�լ� CIIEFEE
	else if(ga.isBelongThisGroup("CIIEFEE")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		
	}	
	
	//���A���ϥ�Crew Car�\��
	else if(ga.isBelongThisGroup("CIIUV")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
	} 
		//642241 ���»�  CP GD �}�o
	else if(ga.isBelongThisGroup("CPDCS")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_dcs.jsp";
		
	}	

	//785B �����F������q 
	else if(funitcd.equals("785B")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";
	} 
//��P�A�ȳB 
	//modify by Betty
	//else if(ga.isBelongThisGroup("CIIKB"))
	//else if (dzp.isPrivilege() == true)
	//{
	//  goPage = "tsaframe.jsp?mypage=tsaleft_kb.jsp";
	//} 		
	else
	{//�L�v���i�J
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
	
}//��L���p
else{
	msg = "Login Fail!!";

}

//�n�J�୶�ο��~�T�����
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
