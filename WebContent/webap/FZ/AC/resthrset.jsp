<%@ page contentType="text/html; charset=big5" language="java" errorPage="" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//特殊航班休時設定
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (sGetUsr == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String userid =(String) session.getAttribute("userid") ; 
String tempbgcolor = "";
swap3ac.ApplyCheck ack = new swap3ac.ApplyCheck();
ArrayList resthrAL = ack.getRestHour("","","TPE");
%>

<html>
<head>
<title>設定特殊航班休時</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../js/showDate.js"></script>
<script src="../js/checkBlank.js"></script>
<script src="../js/checkDel.js"></script>
<script language="JavaScript" src="calendar2.js" ></script>

<script language="javascript" type="text/javascript">
function f_submit()
{
	if(checkBlank('form2','condi_val','請輸入設定值!!')==false) 
	{
		return false;
	}

	if(checkBlank('form2','resthr','請輸入休時!!')==false) 
	{
		return false;
	}
	return true;
}
</script>

</head>
<body>
<div align="center">
<%
if(resthrAL.size() > 0)
{
%>
</div>
  <table width="75%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="8" class="tablehead3">
        <div align="center">特殊航班休時設定</div>
      </td>
    </tr>
 <tr>
      <td bgcolor="#CCCCCC"  class="tablebody">#</td>
      <td bgcolor="#CCCCCC"  class="tablebody">設定條件</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">設定值</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">休時</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">失效日期</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">新增人員</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">新增時間</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">刪除</td>
    </tr>
        <div align="center">
<%
		for(int i=0;i< resthrAL.size();i++)
		{
			if(i%2==0)
			{
				tempbgcolor = "#FFFFFF";
			}
			else
			{
				tempbgcolor = "#CCCCCC";
			}

			swap3ac.RestHourObj obj = (swap3ac.RestHourObj)resthrAL.get(i);
%>
 <tr bgcolor="<%=tempbgcolor%>">
   <td class="tablebody"><%=(i+1)%></td>
   <td class="tablebody"><%=obj.getCondi_col()%></td>
   <td class="tablebody"><%=obj.getCondi_val()%></td>
   <td class="tablebody"><%=obj.getResthr()%></td>
   <td class="tablebody">&nbsp;<%=obj.getExpdt()%></td>
   <td class="tablebody"><%=obj.getNewuser()%></td>
   <td class="tablebody"><%=obj.getNewdate()%></td>
   <td class="tablebody"><input name="Submit2" type="button" class="btm" value="確認刪除" onClick="javascript:self.location='delResthr.jsp?idx=<%=obj.getSeq()%>'">
   </td>
      </tr>	  
        <%
		}
	%>  
        </div>
  </table>
<%
}
else
{
	out.print("<p class=\"txtblue\" align=\"center\">目前並無特殊航班休時設定!!!!</p><hr width=\"75%\" align=\"center\">");
}
%>

<hr width="75%" align="center" noshade>


<form action="addResthr.jsp"  method="post" name="form2" id="form2" onSubmit="return f_submit(); ">
  <table width="75%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="4" class="tablehead3">
        <div align="center">新增特殊航班休時</div>
      </td>
    </tr>   
	<tr>
		<td bgcolor="#CCCCCC"  class="tablebody">設定條件</td>
		<td bgcolor="#CCCCCC"  class="tablebody">設定值</td>
		<td bgcolor="#CCCCCC"  class="tablebody">休時</td>
		<td bgcolor="#CCCCCC"  class="tablebody">失效日期</td>
    </tr>
	<tr>
	  <td  class="tablebody">
        <select name="condi_col">
			<option value="ARV PORT">ARV PORT</option>
			<option value="DUTYCODE">DUTYCODE</option>
		</select>
      </td>
	  <td  class="tablebody">
		<input type="text" size="5" maxlength="5" name="condi_val" value="" onkeyup="javascript:this.value=this.value.toUpperCase();" >
	  </td>
	  <td  class="tablebody">
		<input type="text" size="10" maxlength="10" name="resthr" value="">
	  </td>
      <td  class="tablebody">
	    <span class="txtblue">
        <input type="text" size="10" maxlength="10" name="edate" id="edate" onclick="cal.popup();">
        <img height="16" src="img/cal.gif" width="16" onclick="cal.popup();">
		</span>
	  </td>
    </tr>
    <tr>
      <td colspan="4"  class="tablebody">
        <div align="center"> &nbsp;&nbsp;
            <input name="Submit" type="submit" class="btm" value="確認新增">
        </div>
      </td>
    </tr>
  </table>
</form>
<div align="center" class="txtxred">*若需修改休時設定，請先將該筆資料刪除後再新增。<br>
*失效日期留空則代表永久適用。
</div>
</body>
</html>
<script language="JavaScript">
var cal = new calendar2(document.forms['form2'].elements['edate']);
cal.year_scroll = true;
cal.time_comp = false;
</script>
