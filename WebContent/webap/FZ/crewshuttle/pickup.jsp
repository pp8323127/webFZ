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
			alert("請選擇異動項目!!");	
			document.form1.send.disabled=0;
			return false;
		}

		if(str3 == "" | str3 == null)
		{
			alert("請選擇生效日!!");	
			document.form1.send.disabled=0;
			return false;
		}


		if((str2 == "" | str2 == null) && (str == "Y" | str == "C"))
		{
			alert("請填入接車地點!!");	
			document.form1.send.disabled=0;
			return false;
		}

		if((str == "Y" | str == "N") && str3 != "<%=pickyyyy%>/<%=pickmm%>/01" )
		{
			alert("更改接車/不接車狀態，於次月一日起生效!!");	
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
			alert("更改接車地點，『生效日』不得少於三個工作天(不包含例假日)!!")	;
			document.form1.send.disabled=0;
			return false;
		}
		//**********************************************************
	
		var str4 = "";
		if(str == "Y")
		{
			str4 = "確認 "+str3+" 起申請接車?";
		}
		else if(str == "C")
		{
			str4 = "確認 "+str3+" 起更改接車地點?";
		}
		else
		{
			str4 = "確認 "+str3+" 起取消接車?";
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
	<caption class="txttitletop">接車異動申請</caption>
    <tr class="center bgBlue2"> 
      <td  width="30%">員工號</td>
      <td  width="30%">序號</td>
      <td  width="40%">姓名</td>
    </tr>
	<tr class="txtblue" align="center"> 
      <td>&nbsp;<%=empno%></td>
      <td>&nbsp;<%=sern%></td>
      <td>&nbsp;<%=cname%></td>
    </tr>
	<tr class="center bgBlue2"> 
      <td>異動項目</td>
      <td>生效日</td>
	  <td>接車地點</td>    </tr>
    <tr class="txtblue" align="center"> 
	  <td>
	    <select name="pkstatus" id="pkstatus">
<%
		GregorianCalendar cal1 = new GregorianCalendar();

		int day = cal1.get(Calendar.DATE);
		if(day>=1 && day<=25)
		{//每月1~25開放申請下個月接車/不接車			
%>
			<option value="Y">申請接車</option>
			<option value="N">取消接車</option>
			<option value="C" selected>更改接車地點</option>
<%
		}
		else
		{
%>
			<option value="C" selected>更改接車地點</option>
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
      <td colspan="3">連絡電話</td>
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
      <td colspan = "3">已申請異動記錄</td>
    </tr>
    <tr  class="center bgBlue2" align="center"> 
      <td>異動項目</td>
	  <td>生效日</td>
	  <td>接車地點</td>
    </tr>
<%
	for(int i=0; i<objAL.size(); i++)
	{
		String status_str = "";
		CrewPickupObj obj = (CrewPickupObj) objAL.get(i);
		if("Y".equals(obj.getPk_status()))	
		{
			status_str ="接車";
		}
		else if("N".equals(obj.getPk_status()))	
		{
			status_str ="不接車";
		}
		else
		{
			status_str ="更改接車地點";
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
  <input name="send" id="send" type="submit" class="txtblue" value="送出申請">   
</form>

<table width="80%" border="0" cellspacing="0" cellpadding="0">
<tr><td class="txtxred">1. 更改接車地點『生效日』不得少於三個工作天(不包含例假日)。</td></tr>
<tr><td class="txtxred">2. 更改接車/不接車狀態，需於每月26號(不含)前提出申請，並於次月一日起生效。</td></tr>
<tr><td class="txtxred">3. 若上列顯示之連絡電話已異動，電話號碼異動請依人事異動程序辦理。</td></tr>
<tr><td class="txtxred">4. 提出申請後，請務必於飛行前一日與建民租車(2712-7130)再確認。</td></tr>
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
