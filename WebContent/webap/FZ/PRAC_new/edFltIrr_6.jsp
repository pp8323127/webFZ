<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//�s�W�B�R��Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	//response.sendRedirect("../sendredirect.jsp");
}

boolean hasRecord = false;
boolean isZ = false;

if(!"".equals(request.getParameter("isZ")) && null != request.getParameter("isZ"))
{
	isZ = true;
}


//String GdYear = "2005";//request.getParameter("GdYear");
String fdate = request.getParameter("fdate"); //2005/07/07
//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno = request.getParameter("fltno"); //003
String dpt = request.getParameter("dpt"); //SFO
String arv = request.getParameter("arv"); //TPE
String acno = request.getParameter("acno"); //18201
session.setAttribute("fz.acno",acno);
//out.print("acno="+acno);
//String GdYear = request.getParameter("GdYear");

//String itemNo = null;
String itemNoDsc = null;//�j�����ԭz
String itemDsc = null;//�Ӷ����ԭz
String comm	= null;
String yearsern = null;//�y����
String clb  = "";
String mcr="";
String rca  = "";
String emg="";

int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

//modify by cs66 2005/2/23�A�]�e��FltIrrList�w���ҡA���B���A���ҬO�_���y�����A
String purserEmpno  = request.getParameter("pur");
/*
chkUser ck = new chkUser();
ck.findCrew(sGetUsr);
//�n�J�̪�empno,sern,name,group
String psrsern	= ck.getSern();
String psrname	= ck.getName();
String pgroups = ck.getGroup();
*/

//���o�y�������
String psrsern	 = null;
String psrname	 = null;
String pgroups = null;
fzac.CrewInfo cInfo = new fzac.CrewInfo(purserEmpno);
aircrew.CrewCName cc = new aircrew.CrewCName();
if( cInfo.isHasData())
{
	fzac.CrewInfoObj cObj= cInfo.getCrewInfo();
	psrsern =cObj.getSern();
//	psrname =cObj.getCname();
	psrname = cc.getCname(purserEmpno);
	pgroups =cObj.getGrp();
}

//�n���Ǯɸ�T
fz.pracP.BordingOnTime borot = new fz.pracP.BordingOnTime(fdate,fltno,dpt+arv,purserEmpno);
try 
{
	borot.SelectData();
//	System.out.println("�O�_��flight��ơG" + borot.isHasFlightInfo());
//	System.out.println("�O�_���n����ơG" + borot.isHasBdotInfo());

} 
catch (SQLException e) 
{
	System.out.print(e.toString());
	//out.print(e.toString());
} 
catch (Exception e) 
{
	System.out.print(e.toString());
	//out.print(e.toString());
}

String sql = null;
String upd = null;
try
{
String pbuser = (String)session.getAttribute("pbuser");

//���ҬO�_��Purser
//�i�ϥΪ�:cs55,cs66,cs27,cs40,cs71,cs73
//�s�W630166 ->�N���R�A.....EF�H��

if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") && !sGetUsr.equals("633007") && !sGetUsr.equals("634319") && !sGetUsr.equals("640790") && !sGetUsr.equals("627018") && !sGetUsr.equals("627536") && !sGetUsr.equals("630208") && !sGetUsr.equals("629019") && !sGetUsr.equals("625384") && !sGetUsr.equals("630166") && !sGetUsr.equals("628997") && !"Y".equals(pbuser))
{
	//modify by cs66 at 2005/2/21 
	/*
	purserEmpno  �� sql select�X�Ӫ��Ĥ@�ӫDS�ΫDI ��purser empno
	pur ���W�@���ǨӪ�purser empno
	�S���p�|�X�{�A�ӯZpurser�A�ëDselect�X�Ӫ����u���A
	�]�W�@���|��ܨ�Ӯy�����A�ҥH�Y�ǤJ�����u�����n�J�̡A�h�i�s�覹�����i
	
	*/
	//if(  !sGetUsr.equals(purserEmpno) &&!sGetUsr.equals(pur) ){	
	if(!sGetUsr.equals(purserEmpno))
	{
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��") );		
	}
}		

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

//���ҳ��i�O�_�w�g�e�X
  sql = "select nvl(upd,'Y') upd from egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') "+
	 "and fltno = '"+fltno+"' and sect = '"+dpt+arv+"' ";
	 
	myResultSet = stmt.executeQuery(sql); 
	
	if(myResultSet.next())
	{
		upd = myResultSet.getString("upd");
		if (upd.equals("N"))
		{ //���i�w�e�X���i�ק�
						
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
			response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("���i�w�e�X�A���o�ק�"));
		}
	}

	sql = "select dt.* ,pi.itemdsc dsc from egtcmdt dt, egtcmpi pi where dt.itemno = pi.itemno and  fltno='"+fltno+"' and fltd=to_date('"+fdate+"','yyyy/mm/dd') and sect='"+dpt+arv+"'";

	myResultSet = stmt.executeQuery(sql);
	if(myResultSet.next())
	{
		myResultSet.last();
		count = myResultSet.getRow();//���o����
		myResultSet.beforeFirst();
	}

if(count >0)
{
	hasRecord = true;	
}
%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�˵��ηs�W��L�ƶ�View &amp; Add Flt Irregularity</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="checkDel.js" type="text/javascript"></script>
<script src="../../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">

//TODO�b���B����n���Ǯɸ�T������J
function sendReport()
{	
	<%
	if(hasRecord)
	{
	
		out.print("document.form1.Submit.disabled=1;");
	}

	String submitPage = "upReportSave.jsp?src=6";
	if(isZ)
	{
		submitPage= "upReportSaveZ.jsp?src=6";
	}
	%>
	document.form2.Submit.disabled=1;
	document.form2.SendReport.disabled=1;
	document.form2.action="<%=submitPage%>";
	document.form2.submit();
	//return true;
}

/*function showspan(key,status)
{
	if(status==1)
	{
		document.getElementById(key+"_span").style.display="none";
	}
	else
	{
		document.getElementById(key+"_span").style.display="";
	}
}*/

function showspan(key,status)
{
	if(status==1)
	{
		document.getElementById(key+"_span").style.display="none";
		document.getElementById("A_span2").style.display="none";
		document.getElementById("A_span3").style.display="none";
		document.getElementById("A_span4").style.display="none";
	}
	else
	{
		var span2_show = false;
		var span3_show = false;
		var span4_show = false;

		document.getElementById(key+"_span").style.display="";

		for (var i=0; i < eval("document.form2.A_yn.length"); i++)
		{
			if (eval("document.form2.A_yn[i].checked"))
			{				
				//alert(eval("document.form2.A_yn[i].value"));
				if(eval("document.form2.A_yn[i].value") == "A03/MVC-pi" )
				{
					span2_show = false;
					span3_show = true;
					span4_show = false;
				}
				else if(eval("document.form2.A_yn[i].value") == "A10/�ȫȥͯf/���A-pi" )
				{
					span2_show = false;
					span3_show = false;
					span4_show = true;
				}
				else 
				{
					span2_show = true;
					span3_show = false;
					span4_show = false;
				}
			}
		}

		if(span2_show == true)
		{
			document.getElementById("A_span2").style.display="";
			document.getElementById("A_span3").style.display="none";
			document.getElementById("A_span4").style.display="none";
		}
		else if(span3_show == true)
		{
			document.getElementById("A_span2").style.display="none";
			document.getElementById("A_span3").style.display="";
			document.getElementById("A_span4").style.display="none";
		}
		else if(span4_show == true)
		{
			document.getElementById("A_span2").style.display="none";
			document.getElementById("A_span3").style.display="none";
			document.getElementById("A_span4").style.display="";
		}
		

		document.getElementById("A_note").value="";
		for (var i=0; i < eval("document.form2.A_str.length"); i++)
		{
			document.form2.A_str[i].checked=false;
		}

		document.form2.A10_rca.checked=false;
		document.form2.A10_emg.checked=false;
	}
}

function compose_note(colname)
{
	var c_value = "";
	for (var i=0; i < eval("document.form2."+colname+"_str.length"); i++)
	{
		if (eval("document.form2."+colname+"_str[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form2."+colname+"_str[i].value") ;
		}
	}

	//alert(c_value);
	document.getElementById(colname+"_note").value = c_value;
}


</script>
</head>
<body>
<!--***************************************************************************-->
<div align="center">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="#CCFFFF" >
<tr>
  <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=fdate%></span></td>
  <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=fltno%></span></td>
  <td width="25%" class="txtblue">Sector:<span class="txtxred"><%=dpt%><%=arv%></span></td>
  <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=acno%></span></td>
</tr>
</table>
<p>
<!--****************************************************************************-->
<form name="form1" onSubmit="return del('form1');" action="delFltIrr.jsp">
	<input name="src" id="src" type="hidden" value="6" >
<%
//����Ƥ~show
if(hasRecord)
{
%>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
<tr class="tablehead2">
      <td width="5%">&nbsp;</td>
      <td colspan="2">Item</td>
      <td width="45%">Comments</td>
      <td width="5%">CLB</td>
 	  <td width="5%">Meal<br>Check</td>
      <td width="5%">�^��<br>����<br>�խ�</td>
      <td width="5%">�ϥ�<br>���<br>�]��</td>
  </tr>
	<%
	while(myResultSet.next())
	{
		clb="";
		mcr="";
		rca="";
		emg="";
		
		itemNoDsc 	= myResultSet.getString("dsc");
		itemDsc 	= myResultSet.getString("itemdsc");
		comm		= myResultSet.getString("comments");
		yearsern 	= myResultSet.getString("yearsern");
		if("Y".equals(myResultSet.getString("clb"))){	clb="YES";}else if("N".equals(myResultSet.getString("clb"))){clb="NO";}
		if("Y".equals(myResultSet.getString("mcr"))){	mcr="YES";}else if("N".equals(myResultSet.getString("mcr"))){mcr="NO";}

		if("Y".equals(myResultSet.getString("rca"))){	rca="YES";}else if("N".equals(myResultSet.getString("rca"))){rca="NO";}
		if("Y".equals(myResultSet.getString("emg"))){	emg="YES";}else if("N".equals(myResultSet.getString("emg"))){emg="NO";}

	%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" value="<%=yearsern%>" name="delItem"></td>
      <td width="10%" class="fortable txtblue" align="left" >
	  <img src="../images/pencil.gif" width="15" height="15">
	  <a href="#" onClick="subwinXY('edFltIrr2.jsp?isZ=<%=request.getParameter("isZ")%>&yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>&pur=<%=purserEmpno%>&src=6','','700','350')"><u><%=itemNoDsc%></u></a></td>
      <td width="16%" class="fortable txtblue" ><%=itemDsc%></td>
      <td class="fortable txtblue"><%=comm%></td>
      <td class="fortable txtblue">&nbsp;<%=clb%> </td>
      <td class="fortable txtblue">&nbsp;<%=mcr%> </td>
      <td class="fortable txtblue">&nbsp;<%=rca%> </td>
      <td class="fortable txtblue">&nbsp;<%=emg%> </td>
    </tr>
	<%
	}
	%>
</table>
  <div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
  <br> <span class="purple_txt"><strong>*Click Item to Edit(�I��Item�Y�i�i�J�s��comments)<br>
  </strong></span>
  </div>
  <%
  }	  //End of if have record
  %>
	      <input type="hidden" name="fdate" value="<%=fdate%>">
          <input type="hidden" name="fltno" value="<%=fltno%>">	
		  <input type="hidden" name="acno" value="<%=acno%>">	
          <input type="hidden" name="dpt" value="<%=dpt%>">		
		  <input type="hidden" name="arv" value="<%=arv%>">	
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
 		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		  <input type="hidden" name="psrname" value="<%=psrname%>">	
 		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="pur" value="<%=purserEmpno%>">
		  <input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">

</form>
<%
ArrayList filename = new ArrayList();
ArrayList filedsc = new ArrayList();
count = 0;

myResultSet = stmt.executeQuery("select filename, filedsc from egtfile where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+dpt+arv+"'");
while(myResultSet.next()){
	filename.add(myResultSet.getString("filename"));
	filedsc.add(myResultSet.getString("filedsc"));
	count++;
}
if(count > 0){
%>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="13%">&nbsp;</td>
    <td width="51%">FileName</td>
    <td width="36%">Description</td>
  </tr>
  <%
  for(int i=0; i < filename.size(); i++){
  %>
  <tr>
    <td class="fortable txtblue">
      <div align="center">
        <input type="button" value="DELETE" onClick="if(confirm('�T�w�n�R���ɮסG<%=filename.get(i)%> ?')){self.location='FTP/delFile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&uploadFileName=<%=filename.get(i)%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&src=6';this.disabled=1;}else{return false;}" style="background-color:#BFE4FF;color:#00487D;font-family:Verdana ">
      </div>
    </td>
    <td class="fortable txtblue"><a href="http://cabincrew.china-airlines.com/prpt/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
    <td class="fortable txtblue"><%=filedsc.get(i)%></td>
  </tr>
  <%
  }
  %>
</table>
<%
}
%>
<div align="center">
  <input name="upload" type="button" class="addButton" value="Upload(�W���ɮ�)" onClick="subwinXY('FTP/uploadfile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&src=6','delUpload','700','350')">
  <br>
</div>
<!--****************************************************************************-->
<form name="form2" method="post" action="upFltIrr.jsp" onSubmit="return checkCharacter()">
<input type="hidden" name="src" value="6">
<div align="center">
<fieldset style="width:90%; ">
<legend class="txttitletop">���`���i</legend>
<P>
<table width="95%" cellpadding="2" cellspacing="2" border="0">
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="5%" align="center" valign="middle" class="txtxred" rowspan="2">��<br>��<br>��<br>��<br> | <br>�j<br>��<br>��<br>��<br>�i</td>

    <td width="15%" align="center" valign="middle">���ƥ�</td>
<%
	PRreportTool prt1 = new PRreportTool();
	prt1.getCMPDItemdsc2("M") ;
	ArrayList prt1AL = prt1.getObjAL();
	int split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="M_yn" type="radio" value="Yes" onClick="showspan('M','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt1AL.size(); i++)
	{
		PRreportToolObj obj = (PRreportToolObj) prt1AL.get(i); 
		if(!"M10".equals(obj.getPi_itemno()))
		{
			++split_idx;
%>
			<td width="25%"><input name="M_yn" type="radio" value="<%=obj.getPi_itemno()%>/<%=obj.getPi_itemdsc()%>-<%=obj.getLevel()%>" onClick="showspan('M','2')"><%=obj.getPi_itemdsc()%></td>
<%
			if(split_idx%4==0)
			{
				out.println("</tr><tr>");
			}
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="M_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="M_note" id="M_note">
		</td></tr>
		<tr><td colspan="4">
		�w�xCLB : <input name="M_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="M_clb" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		�O�_�^������խ� : <input name="M_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="M_rca" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		�O�_�ϥκ��˳� : <input name="M_emg" type="radio" value="N">No&nbsp;&nbsp;
		<input name="M_emg" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">�H�ϥ���k�W</td>
<%
	PRreportTool prt2 = new PRreportTool();
	prt2.getCMPDItemdsc("M10") ;
	ArrayList prt2AL = prt2.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="M10_yn" type="radio" value="Yes" onClick="showspan('M10','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt2AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="M10_yn" type="radio" value="M10/<%=prt2AL.get(i)%>" onClick="showspan('M10','2')"><%=prt2AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="M10_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="M10_note" id="M10_note">
		</td></tr>
		<tr><td colspan="4">
		�w�xCLB : <input name="M10_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="M10_clb" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		�O�_�^������խ� : <input name="M10_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="M10_rca" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		�O�_�ϥκ��˳� : <input name="M10_emg" type="radio" value="N">No&nbsp;&nbsp;
		<input name="M10_emg" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#CCFFFF" class="txtblue">
  <td colspan="3"> <div align="center" class="txtxred">���a��,�ߧY�^���ŪA�B�줽��;�y�������i����ƥ�o��24�p�ɤ�ú��</div></td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="5%" align="center" valign="middle" rowspan="4" class="txtxred">��<br>�t<br>��<br>��</td>
    <td width="15%" align="center" valign="middle">�D�z�ʦ欰</td>
<%
	PRreportTool prt3 = new PRreportTool();
	prt3.getCMPDItemdsc("A13") ;
	ArrayList prt3AL = prt3.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="A13_yn" type="radio" value="Yes" onClick="showspan('A13','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt3AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="A13_yn" type="radio" value="A13/<%=prt3AL.get(i)%>" onClick="showspan('A13','2')"><%=prt3AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}

%>
		</tr>
		</table>
		<span style="display:none " id="A13_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="A13_note" id="A13_note">
		</td></tr>
		<tr><td colspan="4">
		      <input type="checkbox" name="A13_str" value="�ȫȵn����" onclick="compose_note('A13')">�ȫȵn���� 
		      <input type="checkbox" name="A13_str" value="����Ʀ��" onclick="compose_note('A13')">����Ʀ��
		      <input type="checkbox" name="A13_str" value="��{��" onclick="compose_note('A13')">��{��<br>
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">�H�W�欰</td>
<%
	PRreportTool prt4 = new PRreportTool();
	prt4.getCMPDItemdsc("A18") ;
	ArrayList prt4AL = prt4.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="A18_yn" type="radio" value="Yes" onClick="showspan('A18','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt4AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="A18_yn" type="radio" value="A18/<%=prt4AL.get(i)%>" onClick="showspan('A18','2')"><%=prt4AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="A18_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="A18_note" id="A18_note">
		</td></tr>
		<tr><td colspan="4">
		      <input type="checkbox" name="A18_str" value="�ȫȵn����" onclick="compose_note('A18')">�ȫȵn���� 
		      <input type="checkbox" name="A18_str" value="����Ʀ��" onclick="compose_note('A18')">����Ʀ��
		      <input type="checkbox" name="A18_str" value="��{��" onclick="compose_note('A18')">��{��<br>
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">����������@�ƥ�</td>
<%
	PRreportTool prt5 = new PRreportTool();
	prt5.getCMPDItemdsc("A09") ;
	ArrayList prt5AL = prt5.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="A09_yn" type="radio" value="Yes" onClick="showspan('A09','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt5AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="A09_yn" type="radio" value="A09/<%=prt5AL.get(i)%>" onClick="showspan('A09','2')"><%=prt5AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td><td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="A09_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="A09_note" id="A09_note">
		</td></tr>
		<tr><td colspan="4">
		<input type="checkbox" name="A09_str" value="�ϥΫ�Ͻc" onclick="compose_note('A09')">�ϥΫ�Ͻc 
		<input type="checkbox" name="A09_str" value="�ߨD���W���@�H����U" onclick="compose_note('A09')">�ߨD���W���@�H����U
		<input type="checkbox" name="A09_str" value="���߫�Ϥp��" onclick="compose_note('A09')">���߫�Ϥp��<br>
		<input type="checkbox" name="A09_str" value="��Call Medlink" onclick="compose_note('A09')">��Call Medlink
		<input type="checkbox" name="A09_str" value="Call Medlink ���Q" onclick="compose_note('A09')">Call Medlink ���Q
		<input type="checkbox" name="A09_str" value="Call Medlink �x��" onclick="compose_note('A09')">Call Medlink �x��
		<input type="checkbox" name="A09_str" value="Call Medlink ����" onclick="compose_note('A09')">Call Medlink ����
		</td></tr>
		<!--<tr><td colspan="4">
		�w�xCLB : <input name="A09_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="A09_clb" type="radio" value="Y">Yes
		</td></tr>-->
		<tr><td colspan="4">
		�O�_�^������խ� : <input name="A09_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="A09_rca" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		�O�_�ϥκ��˳� : <input name="A09_emg" type="radio" value="N">No&nbsp;&nbsp;
		<input name="A09_emg" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">�ȫȬ���</td>
<%
	PRreportTool prt6 = new PRreportTool();
	prt6.getCMPDItemdsc2("A") ;
	ArrayList prt6AL = prt6.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>		
		<td width="25%"><input name="A_yn" type="radio" value="Yes" onClick="showspan('A','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt6AL.size(); i++)
	{
		PRreportToolObj obj = (PRreportToolObj) prt6AL.get(i); 
		if(!"A13".equals(obj.getPi_itemno()) && !"A18".equals(obj.getPi_itemno()) && !"A09".equals(obj.getPi_itemno()) && !"A17".equals(obj.getPi_itemno()))
		{
			++split_idx;
	%>
			<td width="25%"><input name="A_yn" type="radio"  value="<%=obj.getPi_itemno()%>/<%=obj.getPi_itemdsc()%>-<%=obj.getLevel()%>" onClick="showspan('A','2')"><%=obj.getPi_itemdsc()%></td>
	<%
			if(split_idx%4==0)
			{
				out.println("</tr><tr>");
			}
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="A_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="A_note" id="A_note">
		</td></tr>
		</table>
		</span>
		<span style="display:none " id="A_span2" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		      <input type="checkbox" name="A_str" value="�ȫȵn����" onclick="compose_note('A')">�ȫȵn���� 
		      <input type="checkbox" name="A_str" value="����Ʀ��" onclick="compose_note('A')">����Ʀ��
		      <input type="checkbox" name="A_str" value="��{��" onclick="compose_note('A')">��{��<br>
		</td></tr>
		</table>
		</span>
		<!--MVC A03-->
		<span style="display:none " id="A_span3" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		      <input type="checkbox" name="A_str" value="��Z�P�N" onclick="compose_note('A')">��Z�P�N 
		      <input type="checkbox" name="A_str" value="�����Ʃy" onclick="compose_note('A')">�����Ʃy<br>
		</td></tr>
		</table>
		</span>
		<!--�ȫȥͯf/���A A10-->
		<span style="display:none " id="A_span4" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		<input type="checkbox" name="A_str" value="�ϥΫ�Ͻc" onclick="compose_note('A')">�ϥΫ�Ͻc 
		<input type="checkbox" name="A_str" value="�ߨD���W���@�H����U" onclick="compose_note('A')">�ߨD���W���@�H����U
		<input type="checkbox" name="A_str" value="���߫�Ϥp��" onclick="compose_note('A')">���߫�Ϥp��<br>
		<input type="checkbox" name="A_str" value="��Call Medlink" onclick="compose_note('A')">��Call Medlink
		<input type="checkbox" name="A_str" value="Call Medlink ���Q" onclick="compose_note('A')">Call Medlink ���Q
		<input type="checkbox" name="A_str" value="Call Medlink �x��" onclick="compose_note('A')">Call Medlink �x��
		<input type="checkbox" name="A_str" value="Call Medlink ����" onclick="compose_note('A')">Call Medlink ����
		</td></tr>
				<tr><td colspan="4">
		�O�_�^������խ� : <input name="A10_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="A10_rca" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		�O�_�ϥκ��˳� : <input name="A10_emg" type="radio" value="N">No&nbsp;&nbsp;
		<input name="A10_emg" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="5%" align="center" valign="middle" rowspan="3" class="txtxred">&nbsp;</td>
    <td width="15%" align="center" valign="middle">��L�Ϋ�ĳ</td>
    <%
	PRreportTool prt7 = new PRreportTool();
	prt7.getCMPDItemdsc("H05") ;
	ArrayList prt7AL = prt7.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="H05_yn" type="radio" value="Yes" onClick="showspan('H05','1')" checked><span class="txtxred">���`</span></td>
<%
	//for(int i=0; i<prt7AL.size(); i++)
	for(int i=prt7AL.size()-1; i>=0; i--)
	{
		++split_idx;
%>
		<td width="25%"><input name="H05_yn" type="radio" value="H05/<%=prt7AL.get(i)%>" onClick="showspan('H05','2')"><%=prt7AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="H05_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="H05_note" id="H05_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">��Z�d��</td>
<%
	PRreportTool prt8 = new PRreportTool();
	prt8.getCMPDItemdsc("G03") ;
	ArrayList prt8AL = prt8.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="G03_yn" type="radio" value="Yes" onClick="showspan('G03','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt8AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="G03_yn" type="radio" value="G03/<%=prt8AL.get(i)%>" onClick="showspan('G03','2')"><%=prt8AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="G03_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="G03_note" id="G03_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">��U</td>
<%
	PRreportTool prt9 = new PRreportTool();
	prt9.getCMPDItemdsc("H02") ;
	ArrayList prt9AL = prt9.getObjAL();
	split_idx = 1;
%>
	<td width="80%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="H02_yn" type="radio" value="Yes" onClick="showspan('H02','1')" checked><span class="txtxred">���`</span></td>
<%
	for(int i=0; i<prt9AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="H02_yn" type="radio" value="H02/<%=prt9AL.get(i)%>" onClick="showspan('H02','2')"><%=prt9AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="H02_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="H02_note" id="H02_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
</table>
</fieldset>

<!--*****************************************************************************-->
  <div align="center">
    <input type="submit" name="Submit" value="Save (�s�W)" class="addButton" >&nbsp;&nbsp;&nbsp;
	<input name="SendReport" type="button" class="addButton" value="Next(�U�@�B)" onClick="sendReport()">&nbsp;&nbsp;&nbsp;
	<input name="reset" type="reset" value="Reset (�M�����g)">
	<!--ZC-->
<%
	eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
    zcrt.getZCFltListForPR(fdate,fltno,dpt+arv,purserEmpno);
	ArrayList zcAL = zcrt.getObjAL();
	if(zcAL.size()>0)
	{
		eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
		if("Y".equals(zcobj.getIfsent()))
		{//�w�e�X	  
%>
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="viewzc" value="PR Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=purserEmpno%>','zcreport','height=600, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
<%
		}//�w�e�Xif("Y".equals(zcobj.getIfsent()))
	}//if(zcAL.size()>0)			
%>
	<!--ZC-->
        <input type="hidden" name="fltd" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">		
        <input type="hidden" name="dpt" value="<%=dpt%>">		
		<input type="hidden" name="arv" value="<%=arv%>">	
 		<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		<input type="hidden" name="psrname" value="<%=psrname%>">	
 		<input type="hidden" name="psrsern" value="<%=psrsern%>">	
		
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="acno" value="<%=acno%>">	
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="ispart2" value="Y">	
		<input type="hidden" name="pur" value="<%=purserEmpno%>">
		<input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">
		<br>
  <span class="txtxred">Input Note max length English 4000 words�BChinese 2000 words</span> </div>
</form>
<p align="center">&nbsp;</p>
</body>
</html>
<%

}
catch (Exception e)
{
	 out.print(e.toString());
	 //  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>