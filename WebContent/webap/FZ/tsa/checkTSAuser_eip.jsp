<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="fz.*,java.sql.*,ci.auth.*,fzAuthP.CheckAccPwd,java.net.*" %>

<%
String loginIP = request.getRemoteAddr() ;
String RemoteClient = request.getRemoteHost() ;
String msg = null;
String userid = request.getParameter("userid").trim();
String password = request.getParameter("password");
String goPage = null;

String userid_eip = request.getParameter("Empn");
String pk_eip = request.getParameter("PK");
String hostip = InetAddress.getLocalHost().getHostAddress();
String clientip = request.getRemoteAddr(); 
String rr = null;

//�Yuserid ����, ������ EIP ���� login
if (userid == null | "".equals(userid)) {
	userid = userid_eip;
}//if

// �¦W��
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
     { msg = "Your IP is : " + loginIP + " �����q�����ϥ�<br>This website INTRAnet use only"; }
%>
<%
/*
-----------------------------------------------------------------------------------------------------
���v���Ƶ�

yyyymmdd	���SITAcode	(HR UnitCd) ,  �ݨD�渹 
20060612	SINDM	(830)			,	SR6273,	�ϥ�tsaleft_ed, flight Crew List�\��
20060612	�`�g�z��(010)			,SR6264
20060623  ��A�B�@�~����Ʋ�(2342)		,SR6294,�ϥ�Daily check ,flight crew List,,Schedule Query
20060714 �ŪA�|�p�]180B�^,SR6335,�ϥ� tsaleft_ed: Daily check, Crewlist query, Schedule query
20060810 SYDDM (862) ,SR6390 ,�ϥ�Daily check ,flight crew List,,Schedule Query
20061115 �w�޳B�@�ų��]140C�^,SR6538,�w�޳B�@�ų��ϥ� tsaleft_qc.jsp (flight crew List,,Schedule Query)
20061227 �w���޲z�B�O�w��(142F), tsaleft_qc.jsp (flight crew List,,Schedule Query)
20070503 �w���޲z�B�O�w��(142F)����ܧ� ���~�w���޲z�B ��ūO�w��(142E)
20070507 SR7183
			141D �w���޲z�B ����w����   =>�ܧ� 141H   ���~�w���޲z�B ����w����		
			141F �w���޲z�B �w���~�O��    =>�ܧ� 1411   ���~�w���޲z�B �w���~�O��		
			142F �w���޲z�B �O�w��	        =>�ܧ� 142E  ���~�w���޲z�B ��ūO�w�� 	 
			140C �w���޲z�B	                =>�ܧ� 140E  ���~�w���޲z�B
			1412 //2010/11/01 new
20070515 ����ܧ�,�w���޲z�B �������a�Ϧw���޲z��(1442 )�אּ ���~�w���޲z�B �����O�w�� 144G			
20071030 SR7410  �H�O�B�������ϥ� Schedule Query, Crew basic Info 
20100405 cs27  OV manager : 631027 support CAA in CAL-office , she must hard code to OZ division
20100709 cs27 add 143E ���~�w���޲z�B
20101203 CS27 V20101201 add 26xx �f�B�B (2606 �f�B������ �w��)
-----------------------------------------------------------------------------------------------------
CIIs
 tsaleft_od.jsp 
 user : 090A �p�X�ި�B, 092 ����ި,093 ���ñ���� ,633 ���������q �B�ȳ�
-----------------------------------------------------------------------------------------------------
*/
/*	20060628,  �~��(7 or 8)		,add by cs55 	*/


	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);

//@@@@@@@@@@@@@@@@@@@@@@@@@ 2009-3/27 CS40
// EZ�S���b��: �����H�c�����ɨϥ�
if (("ez00".equals(userid) && "27123141".equals(password)) || ("EZRICK".equals(userid) && "27123141".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","190A");
	session.setAttribute("unidCD","06");	
	session.setAttribute("cabin","Y");
	session.setAttribute("EZPUB","Y");
    goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
// OZ�S���b��: �����H�c�����ɨϥ�
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

// �S���b��
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
// �S���b��
else if( ("999136".equals(userid) && "661019".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","067D");
	session.setAttribute("unidCD","06");		
	
	session.setAttribute("cabin","Y");	
    goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
}
// �S���b��os99 �լ����αb��,
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
// �S���b��chn99 �j���诸���αb��,
else if( ("chn99".equals(userid) && "chn9999".equals(password)) ){
	session.setAttribute("cs55.usr",userid);
	session.setAttribute("fullUCD","");
	session.setAttribute("unidCD","");		

	session.setAttribute("cabin","Y");	
	session.setAttribute("CHNPUB","Y");//�j���诸���αb��, ²�骩crew List�u��d��
	
	goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
}

// �S���b��
//rick: TPEEG PA Raw score teacher
//FENG: ���M�� PA Raw score teacher
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
// �U�αK�X for test user authentication right "fz27123141"
//  bypass email server check      cs27 2009/12/31 added
//else if ( ckMail.isPassAeroMail() || password.equals("fz27123141") )  //else if(true)  //20070225 modify for temp resolve webloic/webfz  problem
else if (password.equals("fz27123141") || "0".equals(rr = ckMail.chkUserEIP(userid, password, pk_eip, userid_eip, hostip, clientip)) ) {
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
		
		//if (userid.equals("631027")) { funitcd = "064" ; unitcd="06" ; } ;  //2010/05/04 add , set as OT member
		if (userid.equals("631026")) { funitcd = "064" ; unitcd="06" ; } ;  //2011/03/04  modify by cs57

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
		//System.out.println("checkTSA Error:"+e.toString());
	} catch (SQLException e) {
		//System.out.println("checkTSA Error:"+e.toString());
	}catch  (Exception e){
	    System.out.println("checkTSA Error:"+e.toString());
	}//try	
	
	
	//SR7048
	//�����H���] postcd�ĥ|�X��CDEFGH�^
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
		
		
		
	

//Step3. �P�_���α��v
	//Power User           --- CS team ---
	if(ga.isBelongThisGroup("CSOZEZ"))
	{
		session.setAttribute("cabin",null);
		session.setAttribute("userid",userid);
		//session.setAttribute("OZPUB","Y");  //�լ����αb��,crew List Query�u��d��
		goPage =	"cspage.jsp";
	}
	
	// 2010-10-20 ���ƫ�(642674)����Flt plan �[�J CAT II/III
	else if (userid.equals("642674")){			
		goPage="tsaframe.jsp?mypage=tsaleft_catii.jsp";
	}
	
    // CKSML users for APIS-OE data maintenance: CS40 2006/10/03
	// 2009-11-17 Add 630574, remove 634665/642194
	else if (userid.equals("635477") | userid.equals("630574") | userid.equals("634054") | userid.equals("634601")){			
		goPage="tsaframe.jsp?mypage=tsaleft_ml.jsp";
	}
	//�]��
	else if ("630041".equals(userid))
	{			
		goPage="tsaframe.jsp?mypage=tsaleft_pub.jsp";
	}	
	// 096 TPELD/LM; 2606 TPEFF
	else if(funitcd.equals("096") | funitcd.equals("2606") |unitcd.equals("26")){   //v20101201			
		goPage="tsaframe.jsp?mypage=tsaleft_ld.jsp";
	}

	// 05%, 06% ��ȳB ,141H �w���~�O�޲z�B, 010 �`�g�z��
	else if ( unitcd.equals("05") 
		| unitcd.equals("06") | unitcd.equals("00") | funitcd.equals("010")){
		
		/* 20070302 add by cs66*/
		//�ư����v( o.getAnalysa() = 100),�������H���] postcd�ĥ|�X��CDEFGH�^�ݥi�ϥ�
		//String postCdLastChar = o.getPostcd().substring(o.getPostcd().length()-1);
		//2011-10-17 ��V�����Q��(626912, unitcd=0643)
		if("100".equals(o.getAnalysa()) | "626912".equals(userid)) {
			if( "C".equals(postCdLastChar)  	| "D".equals(postCdLastChar)   
				  | "E".equals(postCdLastChar)  | "F".equals(postCdLastChar) 
				  | "G".equals(postCdLastChar)  | "H".equals(postCdLastChar)
				  | "0643".equals(o.getUnitcd())
			   ){	
				//�����H���i�ϥ� , 0643:��V���Юv

				session.setAttribute("cabin","Y");	
				goPage = "tsaframe.htm";

			
			}else{
				//���v���o�ϥ�
				msg = "You are not authorized!! (check01 - Crew but not manager) ";
			}
					
		
		}
		else
		{		
		
			session.setAttribute("cabin","Y");	
			goPage = "tsaframe.htm";
		
		}
	}
	
	// 090A �p�X�ި�B, 092 ����ި,093 ���ñ���� ,633 ���������q �B�ȳ�
	else if(funitcd.equals("093") | funitcd.equals("092") 
			| funitcd.equals("090A") | funitcd.equals("633") ){ 
			
		session.setAttribute("cabin","Y");		
		goPage = "tsaframe.jsp?mypage=tsaleft_od.jsp";

	}	
	
	//190A �ŪA������, 195B�ź�,193B �ż�,189�ŰV,181D �ŪA��F,�ΪŪA�B����,�Ť@��ť|��  196~199
	//***193C �żеu�{�@�~��(expired 2008/12)
	//193B �żЪ��{�@�~��
	//193E �żеu�{�@�~��,193F �żЪ��{�@�~��
	// ED CII�v���]�w,�ư���խ�������
	/* 
	 �~���P�_�O�_���ŪA�խ�,�ϥ�postcd ������ 292.2921
		635 ���������q �ŪA�� 
		811 ��������q �ŪA�� 
		837 �s�[�Y�����q �ŪA�� 
		827 �V�n�����q( for SGNEM)
		850 �F�ʿ�ƳB( for TYOEM)
		8501 �F�ʤ����q( for TYOEM), 8508
		180B �ŪA�|�p
        790A KIXEM
	*/
	/*
	20080214 ���ŪA��F�եN���A��181D�אּ 1811, 1812, 1813
	20081204(CS40) ���żХN���A�� 193C, 193D �אּ 193B, 193E, 193F, 189(support)
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
			 //TODO �~�� postcd �D292. 2921
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
	/*	20060612,	SINDM	(830),	SR6273,	�ϥ�tsaleft_ed, flight Crew List�\��	*/
	
	else if(funitcd.equals("830"))
	{
		   		session.setAttribute("cabin","N");		
				goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
	}	
// 20070423 ,�w���޲z�B �������a�Ϧw���޲z��( 1442),SR7150 ,tsaleft_qc2.jsp(flight crew List)
// 20070515 ,����ܧ�,1442 �אּ 144G
	else if("144G".equals(funitcd)){
		session.setAttribute("cabin","Y");			
		goPage = "tsaframe.jsp?mypage=tsaleft_qc2.jsp";
	}
	

//�w���~�O��		,���w��,�w�޳B�@�ų��,
/* 	20061115 ,�w�޳B�@�ų��]140C�^,SR6538,�w�޳B�@�ų��ϥ� tsaleft_qc.jsp (flight crew List,,Schedule Query) 
	20061227,�w���޲z�B�O�w��(142F), tsaleft_qc.jsp (flight crew List,,Schedule Query,crew List Query)
	20070503,�w���޲z�B�O�w��(142F)����ܧ� ���~�w���޲z�B ��ūO�w��(142E)
	
	20070507, SR7183
			141D �w���޲z�B ����w����   =>�ܧ� 141H   ���~�w���޲z�B ����w����		
			141F �w���޲z�B �w���~�O��    =>�ܧ� 1411   ���~�w���޲z�B �w���~�O��		
			142F �w���޲z�B �O�w��	        =>�ܧ� 142E  ���~�w���޲z�B ��ūO�w�� 	 
			140C �w���޲z�B	                        =>�ܧ� 140E  ���~�w���޲z�B
			141I �w���޲z�B ��Ŧw����        //2010/05/04 add
			142H / 142I  20101103 new

*/
	else if ( funitcd.equals("142G") | funitcd.equals("142H") | funitcd.equals("141H") | funitcd.equals("1411") | funitcd.equals("140E") |
		      funitcd.equals("142E") | funitcd.equals("141G") | funitcd.equals("141I") | funitcd.equals("143E") |
			  funitcd.equals("1412") | funitcd.equals("142H") | funitcd.equals("142I") //20101103 new
                )
        {	
		session.setAttribute("cabin","Y");		
		if(funitcd.equals("142E") ){
		session.setAttribute("OZPUB","Y");//�լ����αb��,crew List Query�u��d��
		}
		goPage = "tsaframe.jsp?mypage=tsaleft_qc.jsp";

	}	
	

	/*	20060623,  ��A�B�@�~��(2342)		,SR6294,�ϥ�Daily check ,flight crew List,Schedule Query 	*/
	/*	20060810,  SYDDM (862)		,SR6390,�ϥ�Daily check ,flight crew List,Schedule Query 	*/

	else if(funitcd.equals("2341")  | funitcd.equals("862"))
	{		
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_kl.jsp";

	}	
	/* 20071030 SR7410  �H�O�B�������ϥ� Schedule Query, Crew basic Info */
	else if(funitcd.equals("048A") ){ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ir.jsp";

	}	
	
	/*	20060628,  �~��(7 or 8)		,add by cs55 	*/
	else if("7".equals(funitcd.substring(0,1)) || "8".equals(funitcd.substring(0,1)) || "9".equals(funitcd.substring(0,1))) 
	{ 
			
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";

	}

	//642241 ���»�  CP GD �}�o
	else if(ga.isBelongThisGroup("CPDCS")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_dcs.jsp";
		
	}	
	
	//�Ť@��ť|�դΪżЪ��ժ�,�� MT ���]�w�s�լ� CIIEFEE
	else if(ga.isBelongThisGroup("CIIEFEE")){
	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
		
	}	
	
	//PA Raw Score Teacher: 624866�ХɫC,626791���դ�,629648�V����,
	//���E�� 630172, �d�߬� 630533, ��ɭs 630756, �\�Q�D 631451, ������ 631480
    //�� MT ���]�w�s�լ� EGPARAW
	else if(ga.isBelongThisGroup("EGPARAW")){	
		session.setAttribute("cabin","N");		
		goPage = "tsaframe.jsp?mypage=tsaleft_paraw.jsp";
		
	}
	
	//���A���ϥ�Crew Car�\��
	else if(ga.isBelongThisGroup("CIIUV")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_uv.jsp";
	} 	
	//785B �����F������q 
	else if(funitcd.equals("785B")){
	  goPage = "tsaframe.jsp?mypage=tsaleft_auh.jsp";
	} 
 	
	//141E �����B�A�ȫ~�O�� ... CS40 2008/02 
	else if(funitcd.equals("141E"))
	{
	  goPage = "tsaframe.jsp?mypage=tsaleft_qi.jsp";
	} 
	
	// 230 ��A�B�B�� ... CS40 2009/3/13 
	else if( (funitcd.equals("230")) && ("280C".equals(o.getPostcd()))){
	  goPage = "tsaframe.jsp?mypage=tsaleft_kz.jsp";
	} 

    //��P�A�ȳB 
	//modify by Betty
	//else if(ga.isBelongThisGroup("CIIKB"))
	//else if (dzp.isPrivilege() == true)
	//{
	//  goPage = "tsaframe.jsp?mypage=tsaleft_kb.jsp";
	//} 		
	//260 & 2606  �f�A �f�B������
	else if ( unitcd.equals("26") ) { 
	  goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
	} 
	
	// �a�A�B 24�}�Y
	else if (unitcd.equals("24") ) {
	  goPage = "tsaframe.jsp?mypage=tsaleft_chn.jsp";
	}
	
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
				msg = "You are not authorized!! (check02). unitcd=" + unitcd + ", funitcd="+funitcd;				
			}
		}
		else
		{		
			msg = "You are not authorized!! (check03)";
		}
	}
	
}
//else if(!ckMail.isPassAeroMail())
else if ( "0" != (rr = ckMail.chkUserEIP(userid, password, pk_eip, userid_eip, hostip, clientip)) )

{//���q�LEIP�{��
	if("EDUser".equals(userid))
	{
	    //out.print("~~~aha1");
		PageAuth dzp2 = new PageAuth(userid, funitcd, "CIIED0001");
		CheckAccPwd ck = new CheckAccPwd(userid,password);
		boolean hasCorrectAcc = ck.hasAccount();
		if (dzp2.isPrivilege() == true && hasCorrectAcc == true)
		{
		    
			session.setAttribute("cs55.usr",userid);
			//goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp"+"<BR>"+rr;
			goPage = "tsaframe.jsp?mypage=tsaleft_ed.jsp";
			
		}
		else
		{		    
			msg = "Incorrect password!!"+"<BR>"+rr;
		}
	}
	else
	{
		msg = "Incorrect password!!"+"<BR>"+rr;
	}
}
//��L���p
else
{
	msg = "Login Fail!!"+"<BR>"+rr;
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
//�n�J�୶�ο��~�T�����
if(msg == null){
//�g�Jlog,CII�n�J���\
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
//�g�Jlog,CII�n�J����
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
