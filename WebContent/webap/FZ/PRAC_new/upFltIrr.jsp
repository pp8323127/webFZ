<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,tool.ReplaceAll,fz.pracP.*,java.net.URLEncoder,ci.db.ConnDB,fz.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
else
{

String purserEmpno = request.getParameter("purserEmpno");
String psrname = request.getParameter("psrname");
String psrsern = request.getParameter("psrsern");
String pur = request.getParameter("pur");
//modify by cs66 at 2005/2/23 �y�����D�Ĥ@�ӧ�쪺���u���ɡA�A���o�L���m�W�ΧǸ�
aircrew.CrewCName cc = new aircrew.CrewCName();

if(!pur.equals(purserEmpno) | sGetUsr.equals(purserEmpno))
{	
/*
	chkUser ck = new chkUser();
	ck.findCrew(sGetUsr);
	psrname = ck.getName();
	psrsern = ck.getSern();
	*/
	fzac.CrewInfo cInfo = new fzac.CrewInfo(purserEmpno);
	if( cInfo.isHasData())
	{
		fzac.CrewInfoObj cObj= cInfo.getCrewInfo();
		psrsern =cObj.getSern();
		//	psrname =cObj.getCname();
		psrname = cc.getCname(purserEmpno);	
	}
}

//���ҬO�_��Purser

/*
if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") )
{	//cs55,cs66�i�s��
	if(  !sGetUsr.equals("purserEmpno")  )
	{	//�D���Z���y�����A���o�ϥΦ��\��
		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��") );
	}
}	
*/		

//String GdYear = "2005";//request.getParameter("GdYear");
//String acno = (String)session.getAttribute("fz.acno");//���p��acno
String acno = request.getParameter("acno");
if("null".equals(acno) || acno == null ) acno = "";
String fltno = request.getParameter("fltno");
String fdate = request.getParameter("fltd");
//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fdate);
String dpt = request.getParameter("dpt");
String arv = request.getParameter("arv");
String sect  = dpt+arv;
String src = request.getParameter("src");
if(src!= null && !"".equals(src))
{
	src="_"+src;
}
else
{
	src = "";
}
String goPage = "edFltIrr"+src+".jsp?isZ="+request.getParameter("isZ")+"&purserEmpno="+purserEmpno+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&acno="+acno+"&GdYear="+GdYear+"&pur="+pur;



//by cs66 2005/04/25 �קKupdate�ɵLitemno
//by cs66 2005/8/25 �קKupdate�ɵLpurser���
if("".equals(purserEmpno) | "".equals(pur))
{
%>
<script>
alert("�s�W��ƥ���!!!\n�Э��s��J!!");
self.location="<%=goPage%>";
</script>
<%	
}
else
{
boolean t = true;
//���oflag
/*
ItemSel id = new ItemSel();
id.getStatement();
String flag = id.getItemFlag(itemno);
id.closeStatement();
*/
//out.print(flag);

//String NewDataInSql = "newuser,newdate";
Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
boolean updStatus = false;
String errMsg = "";
try
{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
conn.setAutoCommit(false);

if("null".equals(sGetUsr) || sGetUsr == null) 
{
	sGetUsr="";
}

//*********************************************************************************
ArrayList itemnoAL = new ArrayList();
ArrayList itemdescAL = new ArrayList();
ArrayList noteAL = new ArrayList();
ArrayList flagAL = new ArrayList();

ArrayList clbAL = new ArrayList();
ArrayList mcrAL = new ArrayList();
ArrayList rcaAL = new ArrayList();
ArrayList emgAL = new ArrayList();


//���B����
if("Yes".equals(request.getParameter("I01_yn")))
{
	itemnoAL.add("I01");
	itemdescAL.add(request.getParameter("I01"));
	noteAL.add(request.getParameter("I01_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�{�ɼu��
if("Yes".equals(request.getParameter("I13_yn")))
{
	itemnoAL.add("I13");
	itemdescAL.add(request.getParameter("I13"));
	noteAL.add(request.getParameter("I13_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//��ɤ����Τu�@�W��
if("Yes".equals(request.getParameter("I08_yn")))
{
	itemnoAL.add("I08");
	itemdescAL.add("�Щ��������");
	noteAL.add(request.getParameter("I08_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}
//*******************************************************************************
//�Z���Ǯ�
String[] chkItem = request.getParameterValues("J_yn_box");
if(!"Yes".equals(request.getParameter("J_yn")) && chkItem != null)
{
	//String str = request.getParameter("J_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		if("pi".equals(chkItem[i].substring(chkItem[i].indexOf("-")+1)))
		{//�ĤG�h
			itemdescAL.add("�Щ��������");
		}
		else//pd
		{//�ĤT�h
			itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1,chkItem[i].indexOf("-")));
		}
		noteAL.add(request.getParameter("J_note"));
		flagAL.add("1");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}

//�ȿ��M��
chkItem = request.getParameterValues("F_yn_box");
if(!"Yes".equals(request.getParameter("F_yn")) && chkItem != null)
{
	//String str = request.getParameter("F_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		if("pi".equals(chkItem[i].substring(chkItem[i].indexOf("-")+1)))
		{//�ĤG�h
			itemdescAL.add("�Щ��������");
		}
		else//pd
		{//�ĤT�h
			itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1,chkItem[i].indexOf("-")));
		}
		noteAL.add(request.getParameter("F_note"));
		flagAL.add("2");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}

//����
chkItem = request.getParameterValues("E02_yn_box");
if(!"Yes".equals(request.getParameter("E02_yn")) && chkItem != null)
{
	//String str = request.getParameter("E02_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1));
		noteAL.add(request.getParameter("E02_note"));
		flagAL.add("2");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}

//�ȿ����
chkItem = request.getParameterValues("E01_yn_box");
if(!"Yes".equals(request.getParameter("E01_yn")) && chkItem != null)
{
	//String str = request.getParameter("E01_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1));
		noteAL.add(request.getParameter("E01_note"));
		flagAL.add("2");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}

//���
chkItem = request.getParameterValues("E03_yn_box");
if(!"Yes".equals(request.getParameter("E03_yn")) && chkItem != null)
{
	//String str = request.getParameter("E03_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1));
		noteAL.add(request.getParameter("E03_note"));
		flagAL.add("2");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}

//������T
chkItem = request.getParameterValues("H04_yn_box");
if(!"Yes".equals(request.getParameter("H04_yn")) && chkItem != null)
{
	//String str = request.getParameter("H04_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1));
		noteAL.add(request.getParameter("H04_note"));
		flagAL.add("2");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}

//�A�Ȭy�{
chkItem = request.getParameterValues("H03_yn_box");
if(!"Yes".equals(request.getParameter("H03_yn")) && chkItem != null)
{
	//String str = request.getParameter("H03_yn");
	for(int i=0;i<chkItem.length;i++)
	{
		String str_itemno = chkItem[i].substring(0,chkItem[i].indexOf("/"));
		itemnoAL.add(str_itemno);
		itemdescAL.add(chkItem[i].substring(chkItem[i].indexOf("/")+1));
		noteAL.add(request.getParameter("H03_note"));
		flagAL.add("2");
		clbAL.add("");
		mcrAL.add("");
		rcaAL.add("");
		emgAL.add("");
	}
}
//******************************************************************************************
//�ȿ��ū�
if(!"Yes".equals(request.getParameter("B04_yn")) && request.getParameter("B04_yn") != null)
{
	String str = request.getParameter("B04_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B04_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B04_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//���q��
if(!"Yes".equals(request.getParameter("B09_yn")) && request.getParameter("B09_yn") != null)
{
	String str = request.getParameter("B09_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B09_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B09_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//���˳�
if(!"Yes".equals(request.getParameter("H01_yn")) && request.getParameter("H01_yn") != null)
{
	String str = request.getParameter("H01_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("H01_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("H01_clb"));
	mcrAL.add("");
	rcaAL.add(request.getParameter("H01_rca"));
	emgAL.add("");
}

//�y�ȯʥ�
if(!"Yes".equals(request.getParameter("B01_yn")) && request.getParameter("B01_yn") != null)
{
	String str = request.getParameter("B01_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B01_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B01_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�v���t��
if(!"Yes".equals(request.getParameter("B03_yn")) && request.getParameter("B03_yn") != null)
{
	String str = request.getParameter("B03_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));
	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B03_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B03_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//PTV�G��
if(!"Yes".equals(request.getParameter("B03_2_yn")) && request.getParameter("B03_2_yn") != null)
{
	String str = request.getParameter("B03_2_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B03_2_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B03_2_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�ȿ��ʥ�
if(!"Yes".equals(request.getParameter("B05_yn")) && request.getParameter("B05_yn") != null)
{
	String str = request.getParameter("B05_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B05_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B05_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�����ʥ�
if(!"Yes".equals(request.getParameter("B05_2_yn")) && request.getParameter("B05_2_yn") != null)
{
	String str = request.getParameter("B05_2_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B05_2_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B05_2_clb"));
	mcrAL.add("");
	rcaAL.add(request.getParameter("B05_2_rca"));
	emgAL.add("");
}


//�p�Яʥ�
if(!"Yes".equals(request.getParameter("B07_yn")) && request.getParameter("B07_yn") != null)
{
	String str = request.getParameter("B07_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B07_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B07_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�~�ⶡ�ʥ�
if(!"Yes".equals(request.getParameter("B06_yn")) && request.getParameter("B06_yn") != null)
{
	String str = request.getParameter("B06_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B06_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B06_clb"));
	mcrAL.add("");
	rcaAL.add(request.getParameter("B06_rca"));
	emgAL.add("");
}

//�~�ⶡ����
if(!"Yes".equals(request.getParameter("B06_2_yn")) && request.getParameter("B06_2_yn") != null)
{
	String str = request.getParameter("B06_2_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B06_2_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B06_2_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}


//Crew Bunk
if(!"Yes".equals(request.getParameter("B11_yn")) && request.getParameter("B11_yn") != null)
{
	String str = request.getParameter("B11_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("B11_note"));
	flagAL.add("2");
	clbAL.add(request.getParameter("B11_clb"));
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�K�|�~
if(!"Yes".equals(request.getParameter("C03_yn")) && request.getParameter("C03_yn") != null)
{
	String str = request.getParameter("C03_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C03_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�U���v��
if(!"Yes".equals(request.getParameter("C01_yn")) && request.getParameter("C01_yn") != null)
{
	String str = request.getParameter("C01_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C01_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�\Ū�Z��
if(!"Yes".equals(request.getParameter("C05_yn")) && request.getParameter("C05_yn") != null)
{
	String str = request.getParameter("C05_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C05_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�E�Y���
if(!"Yes".equals(request.getParameter("C10_yn")) && request.getParameter("C10_yn") != null)
{
	String str = request.getParameter("C10_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C10_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�����˸�
if(!"Yes".equals(request.getParameter("D09_yn")) && request.getParameter("D09_yn") != null)
{
	String str = request.getParameter("D09_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("D09_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//��c
if(!"Yes".equals(request.getParameter("C11_yn")) && request.getParameter("C11_yn") != null)
{
	String str = request.getParameter("C11_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C11_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�d�~�]
if(!"Yes".equals(request.getParameter("C02_yn")) && request.getParameter("C02_yn") != null)
{
	String str = request.getParameter("C02_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C02_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�վ�
if(!"Yes".equals(request.getParameter("C15_yn")) && request.getParameter("C15_yn") != null)
{
	String str = request.getParameter("C15_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C15_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//���f�c\���p��c P.S.K
if(!"Yes".equals(request.getParameter("C07_yn")) && request.getParameter("C07_yn") != null)
{
	String str = request.getParameter("C07_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C07_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//��L�ŪA�Ϋ~
if(!"Yes".equals(request.getParameter("C09_yn")) && request.getParameter("C09_yn") != null)
{
	String str = request.getParameter("C09_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	if("C13".equals(str_itemno))
	{
		itemdescAL.add("�Щ��������");
	}
	else
	{
		itemdescAL.add(str.substring(str.indexOf("/")+1));
	}
	noteAL.add(request.getParameter("C09_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//����
if(!"Yes".equals(request.getParameter("C12_yn")) && request.getParameter("C12_yn") != null)
{
	String str = request.getParameter("C12_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("C12_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�S�O�\
if(!"Yes".equals(request.getParameter("D01_yn")) && request.getParameter("D01_yn") != null)
{
	String str = request.getParameter("D01_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("D01_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add(request.getParameter("D01_mcr"));
	rcaAL.add("");
	emgAL.add("");
}

//FCL�\�I
if(!"Yes".equals(request.getParameter("D10_yn")) && request.getParameter("D10_yn") != null)
{
	String str = request.getParameter("D10_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("D10_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add(request.getParameter("D10_mcr"));
	rcaAL.add("");
	emgAL.add("");
}

//CCL�\�I
if(!"Yes".equals(request.getParameter("D11_yn")) && request.getParameter("D11_yn") != null)
{
	String str = request.getParameter("D11_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("D11_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add(request.getParameter("D11_mcr"));
	rcaAL.add("");
	emgAL.add("");
}

//YCL�\�I
if(!"Yes".equals(request.getParameter("D12_yn")) && request.getParameter("D12_yn") != null)
{
	String str = request.getParameter("D12_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("D12_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add(request.getParameter("D12_mcr"));
	rcaAL.add("");
	emgAL.add("");
}
//�խ��\
if(!"Yes".equals(request.getParameter("D13_yn")) && request.getParameter("D13_yn") != null)
{
	String str = request.getParameter("D13_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("D13_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add(request.getParameter("D13_mcr"));
	rcaAL.add("");
	emgAL.add("");
}

//���ƥ�
if(!"Yes".equals(request.getParameter("M_yn")) && request.getParameter("M_yn") != null)
{
	String str = request.getParameter("M_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));
	itemnoAL.add(str_itemno);
	if("pi".equals(str.substring(str.indexOf("-")+1)))
	{//�ĤG�h
		itemdescAL.add("�Щ��������");
	}
	else//pd
	{//�ĤT�h
		itemdescAL.add(str.substring(str.indexOf("/")+1,str.indexOf("-")));
	}
	noteAL.add(request.getParameter("M_note"));
	flagAL.add("1");
	clbAL.add(request.getParameter("M_clb"));
	mcrAL.add("");
	rcaAL.add(request.getParameter("M_rca"));
	emgAL.add(request.getParameter("M_emg"));
}

//�H�ϥ���k�W
if(!"Yes".equals(request.getParameter("M10_yn")) && request.getParameter("M10_yn") != null)
{
	String str = request.getParameter("M10_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("M10_note"));
	flagAL.add("1");
	clbAL.add(request.getParameter("M10_clb"));
	mcrAL.add("");
	rcaAL.add(request.getParameter("M10_rca"));
	emgAL.add(request.getParameter("M10_emg"));
}

//�D�z�ʦ欰
if(!"Yes".equals(request.getParameter("A13_yn")) && request.getParameter("A13_yn") != null)
{
	String str = request.getParameter("A13_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("A13_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�H�W�欰
if(!"Yes".equals(request.getParameter("A18_yn")) && request.getParameter("A18_yn") != null)
{
	String str = request.getParameter("A18_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("A18_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//����������@�ƥ�
if(!"Yes".equals(request.getParameter("A09_yn")) && request.getParameter("A09_yn") != null)
{
	String str = request.getParameter("A09_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("A09_note"));
	flagAL.add("1");
	clbAL.add(request.getParameter("A09_clb"));
	mcrAL.add("");
	rcaAL.add(request.getParameter("A09_rca"));
	emgAL.add(request.getParameter("A09_emg"));
}

//��L�ȫȬ���
if(!"Yes".equals(request.getParameter("A_yn")) && request.getParameter("A_yn") != null)
{
	String str = request.getParameter("A_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));
	itemnoAL.add(str_itemno);
	if("pi".equals(str.substring(str.indexOf("-")+1)))
	{//�ĤG�h
		itemdescAL.add("�Щ��������");
	}
	else//pd
	{//�ĤT�h
		itemdescAL.add(str.substring(str.indexOf("/")+1,str.indexOf("-")));
	}
	noteAL.add(request.getParameter("A_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//��L�Ϋ�ĳ�ƶ�
if(!"Yes".equals(request.getParameter("H05_yn")) && request.getParameter("H05_yn") != null)
{
	String str = request.getParameter("H05_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("H05_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//��Z�d��
if(!"Yes".equals(request.getParameter("G03_yn")) && request.getParameter("G03_yn") != null)
{
	String str = request.getParameter("G03_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("G03_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//��U
if(!"Yes".equals(request.getParameter("H02_yn")) && request.getParameter("H02_yn") != null)
{
	String str = request.getParameter("H02_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("H02_note"));
	flagAL.add("2");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�խ��ͯf\���A\�N�~�ƥ�
if(!"Yes".equals(request.getParameter("I03_yn")) && request.getParameter("I03_yn") != null)
{
	String str = request.getParameter("I03_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("I03_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�խ�����
if(!"Yes".equals(request.getParameter("I04_yn")) && request.getParameter("I04_yn") != null)
{
	String str = request.getParameter("I04_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("I04_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�խ�����
if(!"Yes".equals(request.getParameter("other_yn")) && request.getParameter("other_yn") != null)
{
	String str = request.getParameter("other_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));
	itemnoAL.add(str_itemno);
	itemdescAL.add("�Щ��������");
	noteAL.add(request.getParameter("other_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//�խ����
if(!"Yes".equals(request.getParameter("I14_yn")) && request.getParameter("I14_yn") != null)
{
	String str = request.getParameter("I14_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("I14_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
}

//���]����
if(!"Yes".equals(request.getParameter("K_yn")) && request.getParameter("K_yn") != null)
{
	String str = request.getParameter("K_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("K_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
	out.println(str+""+str_itemno);
}
//�խ����h
if(!"Yes".equals(request.getParameter("I15_yn")) && request.getParameter("I15_yn") != null)
{
	String str = request.getParameter("I15_yn");
	String str_itemno = str.substring(0,str.indexOf("/"));

	itemnoAL.add(str_itemno);
	itemdescAL.add(str.substring(str.indexOf("/")+1));
	noteAL.add(request.getParameter("I15_note"));
	flagAL.add("1");
	clbAL.add("");
	mcrAL.add("");
	rcaAL.add("");
	emgAL.add("");
	out.println(str+""+str_itemno);
}



//out.println("itemnoAL.size()  "+ itemnoAL.size()+"<br>");

	if(itemnoAL.size()>0)
	{
		//String sql = "INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,itemno,itemdsc,"
		//	+"comments,newdate,newuser,acno,psrname,psrsern,caseclose,flag,clb,mcr) "
		//	+"VALUES(egqcmys.nextval,To_Date(?,'yyyy/mm/dd'),?,?,"
		//	+"?,?,?,sysdate,?,?,?,?,'N',?,?,?)";

		String sql = "INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,itemno,itemdsc,comments,newdate,newuser,acno,psrname,psrsern,caseclose,flag,clb,mcr,rca,emg) VALUES (egqcmys.nextval,To_Date(?,'yyyy/mm/dd'),?,?,?,?,?,sysdate,?,?,?,?,'N',?,?,?,?,?)";

		pstmt = conn.prepareStatement(sql);
		int j=1;
		//out.print(sql);
		for(int i=0; i<itemnoAL.size(); i++)
		{		
			j=1;
			pstmt.setString(j,fdate);
			pstmt.setString(++j,fltno);
			pstmt.setString(++j,sect);
			pstmt.setString(++j,(String)itemnoAL.get(i));
			pstmt.setString(++j,(String)itemdescAL.get(i));
			pstmt.setString(++j,(String)noteAL.get(i));
			pstmt.setString(++j,sGetUsr);
			pstmt.setString(++j,acno);
			pstmt.setString(++j,psrname);
			pstmt.setString(++j,psrsern);
			pstmt.setString(++j,(String)flagAL.get(i));
			pstmt.setString(++j,(String)clbAL.get(i));
			pstmt.setString(++j,(String)mcrAL.get(i));
			pstmt.setString(++j,(String)rcaAL.get(i));
			pstmt.setString(++j,(String)emgAL.get(i));

	//out.println("INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,itemno,itemdsc,comments,newdate,newuser,acno,psrname,psrsern,caseclose,flag) VALUES(egqcmys.nextval,To_Date('"+fdate+"','yyyy/mm/dd'),'"+fltno+"','"+sect+"','"+(String)itemnoAL.get(i)+"','"+(String)itemdescAL.get(i)+"','"+(String)noteAL.get(i)+"',sysdate,'"+sGetUsr+"','"+acno+"','"+psrname+"','"+psrsern+"','N','"+(String)flagAL.get(i)+"')<br>");

			pstmt.executeUpdate();
		}
		//conn.commit();
	}
	updStatus = true;
}
catch(SQLException e)
{
	errMsg = e.toString();
	try {
	//�����~�� rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}	
}catch (Exception e){
	errMsg = e.toString();
	try {
	//�����~�� rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
}
finally
{
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (conn != null) {
		try {
			conn.close();
		} catch (SQLException e) {
				errMsg += e.getMessage();

		}
		conn = null;
	}
}

if(updStatus)
{
	response.sendRedirect(goPage);
}
else
{
%>
<%=errMsg%><br>
<a href="javascript:history.back(-1);">�Э��s��J!!</a>
<%
}
}//if("".equals(purserEmpno) | "".equals(pur))

}//if (session.isNew() || sGetUsr == null) 

%>