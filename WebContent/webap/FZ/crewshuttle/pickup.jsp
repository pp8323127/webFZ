<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="eg.pickup.*,java.util.*,java.text.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 
else
{
	Calendar d1 = new GregorianCalendar();
	String yyyy = "";
	String mm = "";
	String pickyyyy = "";
	String pickmm = "";
	SimpleDateFormat f = new SimpleDateFormat("yyyy");
	SimpleDateFormat f2 = new SimpleDateFormat("MM");
	yyyy = f.format(d1.getTime());
	mm = f2.format(d1.getTime());
    d1.add(Calendar.MONTH, 1);
	pickyyyy = f.format(d1.getTime());
	pickmm = f2.format(d1.getTime());

	CrewPickup cpk = new CrewPickup();
    //cpk.getPickupData(userid,yyyy+mm);
	cpk.getPickupData(userid,"");
	ArrayList objAL = new ArrayList();
    objAL = cpk.getObjAL();   	

	eg.EGInfo egi = new eg.EGInfo(userid);
    eg.EgInfoObj egiobj = egi.getEGInfoObj(userid); 
	String empno = egiobj.getEmpn();
	String sern = egiobj.getSern();
	String cname = egiobj.getCname();
%>
<html>
<head>
<title>Pickup/un-pickup apply</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="JavaScript" src="calendar2.js" ></script>
<link rel="stylesheet" type="text/css" href="../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../style/lightColor.css">
<style type="text/css">
<!--
.style1 {font-size: 18px}
-->
</style>
<script type="text/javascript" language="javascript">
	function f_submit()
	{
		document.form1.send.disabled=0;
		var str = document.getElementById('pkstatus').value;
		var str2 = document.getElementById('pkplace').value;
		var str3 = document.getElementById('activedate').value;

		if(str == "" | str == null)
		{
			alert("�п�ܲ��ʶ���!!");	
			document.form1.send.disabled=0;
			return false;
		}

		if(str3 == "" | str3 == null)
		{
			alert("�п�ܥͮĤ�!!");	
			document.form1.send.disabled=0;
			return false;
		}


		if((str2 == "" | str2 == null) && (str == "Y" | str == "C"))
		{
			alert("�ж�J�����a�I!!");	
			document.form1.send.disabled=0;
			return false;
		}

		if((str == "Y" | str == "N") && str3 != "<%=pickyyyy%>/<%=pickmm%>/01" )
		{
			alert("��ﱵ��/���������A�A�󦸤�@��_�ͮ�!!");	
			document.form1.send.disabled=0;
			return false;
		}

		today = new Date();
		//alert("getYear "+Number(str3.substring(0,4)) );
		//alert("getMonth "+Number(str3.substring(5,7)) );
		//alert("getDate "+Number(str3.substring(8,10)) );
		xday = new Date(Number(str3.substring(0,4)),Number(str3.substring(5,7))-1,Number(str3.substring(8,10)));//Date(2011,9,1)
		dayms = 24*60*60*1000;
		diff = Math.floor((xday.getTime()-today.getTime())/dayms)+1;

		if(str == "C" && diff < 4)
		{
			alert("��ﱵ���a�I�A�y�ͮĤ�z���o�֩�T�Ӥu�@��(���]�t�Ұ���)!!")	;
			document.form1.send.disabled=0;
			return false;
		}
		//**********************************************************
	
		var str4 = "";
		if(str == "Y")
		{
			str4 = "�T�{ "+str3+" �_�ӽб���?";
		}
		else if(str == "C")
		{
			str4 = "�T�{ "+str3+" �_��ﱵ���a�I?";
		}
		else
		{
			str4 = "�T�{ "+str3+" �_��������?";
		}

		if(confirm(str4))
		{
			return true;
		}
		else
		{
			document.form1.send.disabled=0;
			return false;
		}
	}
</script>
</head>
<body>
<center>
<form name="form1" action="updpickup.jsp" method="post" target="_self" onsubmit="return f_submit();">
	<table width="80%" border="1" cellspacing="0" cellpadding="0">
	<caption class="txttitletop">�������ʥӽ�</caption>
    <tr class="center bgBlue2"> 
      <td  width="30%">���u��</td>
      <td  width="30%">�Ǹ�</td>
      <td  width="40%">�m�W</td>
    </tr>
	<tr class="txtblue" align="center"> 
      <td>&nbsp;<%=empno%></td>
      <td>&nbsp;<%=sern%></td>
      <td>&nbsp;<%=cname%></td>
    </tr>
	<tr class="center bgBlue2"> 
      <td>���ʶ���</td>
      <td>�ͮĤ�</td>
	  <td>�����a�I</td>    </tr>
    <tr class="txtblue" align="center"> 
	  <td>
	    <select name="pkstatus" id="pkstatus">
<%
		GregorianCalendar cal1 = new GregorianCalendar();

		int day = cal1.get(Calendar.DATE);
		if(day>=1 && day<=25)
		{//�C��1~25�}��ӽФU�Ӥ뱵��/������			
%>
			<option value="Y">�ӽб���</option>
			<option value="N">��������</option>
			<option value="C" selected>��ﱵ���a�I</option>
<%
		}
		else
		{
%>
			<option value="C" selected>��ﱵ���a�I</option>
<%
		}
%>
		 </select>
	  </td>
      <td>
	  <input name="activedate" id="activedate" type="text" class="text" value="<%=pickyyyy%>/<%=pickmm%>/01" size="10" maxlength="10">
	  <img name="activedateimg" id="activedateimg" src="../images/p2.gif"width="22" height="22" onClick ="cal1.popup();">
      </td>
      <td><textarea NAME="pkplace" id="pkplace" ROWS="3" COLS="40" wrap="virtual"></textarea></td>
    </tr>
	<tr class="center bgBlue2"> 
      <td colspan="3">�s���q��</td>
	</tr>
	<tr align="center"> 
      <td colspan="3">
<%
	 if(!"".equals(egiobj.getPhone1()) && egiobj.getPhone1() != null)
	 {
		out.print(egiobj.getPhone1()+"<br>");
	 }

	 if(!"".equals(egiobj.getPhone2()) && egiobj.getPhone2() != null)
	 {
		out.print(egiobj.getPhone2()+"<br>");
	 }

	 if(!"".equals(egiobj.getPhone3()) && egiobj.getPhone3() != null)
	 {
		out.print(egiobj.getPhone3()+"<br>");
	 }

	 if(!"".equals(egiobj.getPhone4()) && egiobj.getPhone4() != null)
	 {
		out.print(egiobj.getPhone4()+"<br>");
	 }

	 //if(!"".equals(egiobj.getSmsphone()) && egiobj.getSmsphone() != null)
	 //{
	 //	out.print(egiobj.getSmsphone()+"<br>");
	 //}
%>
	  </td>
	</tr>
<%
if(objAL.size()>0)
{
%>
    <tr  class="center bgBlue2" align="center"> 
      <td colspan = "3">�w�ӽв��ʰO��</td>
    </tr>
    <tr  class="center bgBlue2" align="center"> 
      <td>���ʶ���</td>
	  <td>�ͮĤ�</td>
	  <td>�����a�I</td>
    </tr>
<%
	for(int i=0; i<objAL.size(); i++)
	{
		String status_str = "";
		CrewPickupObj obj = (CrewPickupObj) objAL.get(i);
		if("Y".equals(obj.getPk_status()))	
		{
			status_str ="����";
		}
		else if("N".equals(obj.getPk_status()))	
		{
			status_str ="������";
		}
		else
		{
			status_str ="��ﱵ���a�I";
		}	
%>
	<tr align="center"> 
      <td class="txtblue">&nbsp;<%=status_str%></td>
      <td class="txtblue">&nbsp;<%=obj.getActivedate()%></td>
      <td align="left" class="txtblue">&nbsp;<%=obj.getPk_place()%></td>
    </tr>
<%		
	}
}
%>
  </table>
  <br>
  <input name="send" id="send" type="submit" class="txtblue" value="�e�X�ӽ�">   
</form>

<table width="80%" border="0" cellspacing="0" cellpadding="0">
<tr><td class="txtxred">1. ��ﱵ���a�I�y�ͮĤ�z���o�֩�T�Ӥu�@��(���]�t�Ұ���)�C</td></tr>
<tr><td class="txtxred">2. ��ﱵ��/���������A�A�ݩ�C��26��(���t)�e���X�ӽСA�é󦸤�@��_�ͮġC</td></tr>
<tr><td class="txtxred">3. �Y�W�C��ܤ��s���q�ܤw���ʡA�q�ܸ��X���ʽШ̤H�Ʋ��ʵ{�ǿ�z�C</td></tr>
<tr><td class="txtxred">4. ���X�ӽЫ�A�аȥ��󭸦�e�@��P�إ�����(2712-7130)�A�T�{�C</td></tr>
</table>
</center>
</body>
</html>
<%
}	
%>

<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['activedate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
</script>
