<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="df.overTime.ac.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login
String bcolor = "";
if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
} 

TransferFlt flt = new TransferFlt();
String str = flt.getTransferFlt();
ArrayList objAL = new ArrayList();
objAL = flt.getObjAL();
//out.println(str+"  str<br>");

%>
<html>
<head>
<title>Transfer Flt List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">	
function dosubmit()
{
	var sector = document.form1.sector.value;

	if(sector.length==0)
	{
		alert("請輸入航點!!");
		return false;
	}
	document.form1.Submit.disabled=1;
		return true;
}

</script>
</head>
 <table width="180"  border="1" align="center" cellpadding="0" cellspacing="1">
<tr>
  <td colspan="3" class="tablehead3"><div align="center">越洋線航點</div></td>
</tr>
 <tr>
 	  <td  class="tablebody" bgcolor="#CCCCCC">&nbsp;</td>
      <td  class="tablebody" bgcolor="#CCCCCC">航點</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">新增日期</td>
 </tr>
<%
if("Y".equals(str))
{
%>
<div align="center">
    <%
	for(int i=0; i<objAL.size(); i++)
	{
		if(i%2==1)
	    {
			bcolor = "#FFFFFF";
		}
		else
		{
			bcolor = "#99CCFF";
		}

		TransferFltObj obj = (TransferFltObj)objAL.get(i);
	%>
	 <tr bgcolor="<%=bcolor%>" class="txtblue" align="center">
	   <td><%=i+1%></td>
	   <td><%=obj.getSector()%></td>
	   <td><%=obj.getUpddt()%></td>
    </tr>	  
    <%
	}
	%>  
   </div>
<%
if(objAL.size() <=0)
{
%>
    <tr>
      <td colspan="3" ><div align="center">
	  	  No data found!!
      </div></td>
    </tr>
<%
}
%>
</table>
<p>
<hr>
<p>
<%
}			  
%>
<form method="post" name="form1" id="form1" target = "_blank" action="instransflt.jsp"  onsubmit = " return dosubmit();">
  <table width="180"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td class="tablehead3"><div align="center">新增航點</div></td>
    </tr>
	<tr>
      <td  class="tablebody" bgcolor="#CCCCCC">航點</td>
	</tr>
	<tr class="tablebody">
	   <td><input name="sector" type="text" size="10" maxlength="3" onkeyup ="javascript:this.value=this.value.toUpperCase();"></td>
	</tr>
    <tr>
      <td colspan="1"  class="tablebody">
          <input name="Submit" type="submit" class="btm" value="New">
	  </td>
    </tr>
  </table>
</form>
<br>
</body>
</html>