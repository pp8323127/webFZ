<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=big5" language="java" import="eg.off.*, eg.*"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 
String gdyear = request.getParameter("offyear");
String msg = request.getParameter("msg");
String bc = "";
int undeduct = 0;
boolean hasdelete = false;
boolean show = false;
//***************************************
OffRecordList orl = new OffRecordList();
orl.getOffRecord(userid,"ALL",gdyear);
ArrayList objAL = new ArrayList();
objAL = orl.getObjAL();
undeduct = orl.getALUndeduct(userid);
//***************************************
ALPeriod oys = new ALPeriod();      
oys.getALPeriod(userid);
ArrayList alperiodAL = oys.getObjAL();
//***************************************
EGInfo egi = new EGInfo(userid);
ArrayList objAL2 = new ArrayList();
objAL2 = egi.getObjAL();
EgInfoObj obj2 = new EgInfoObj();
if(objAL2.size()>0)
{
	obj2 = (EgInfoObj) objAL2.get(0);
}       
//***************************************
OffType offtype = new OffType();
offtype.offData();
//***************************************
%>
<html>
<head>
<title>View offsheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
  <p><font face="Comic Sans MS" color="#000099"> Offsheet Record</font></p>
  <table width="80%" border="0">
    <tr> </tr>
  </table>
  <table width="75%" border="1">
    <tr> 
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Dept</b></font></td>
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Name</b></font></td>
	  <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>EmpNo</b></font></td>
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>SerNo</b></font></td>
	</tr> 
	<tr class="txtblue"> 
      <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getDeptno()%></b> </font></td>     
      <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getCname()%></b></font></td>
	  <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getEmpn()%></b> </font></td>      
	  <td width="25%" align= "center"><font face="Arial, Helvetica, sans-serif" size="2"><b><%=obj2.getSern()%></b></font></td>
    </tr>
    <tr> 
      <td width="25%" class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>AL effective Date</b></font></td>
	  <td width="75%" colspan ="3" rowspan="4" valign="top">
		  <table width="100%" border="0">
		  <tr>
			<td width="46%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>AL/XL valid period</b></font></td>
			<td width="27%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Initial Days</b></font></td>
			<td width="27%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Usage Days</b></font></td>
		  </tr>
		 <%
			for(int i=0; i<alperiodAL.size(); i++)
			{
				String tempbgcolor = "";
				if(i%2==0)
				{
					tempbgcolor = "#FFFFFF";
				}
				else
				{
					tempbgcolor = "#CCCCCC";
				}
				ALPeriodObj obj = (ALPeriodObj) alperiodAL.get(i);
		 %>
		       <tr align="center" bgcolor="<%=tempbgcolor%>" class="txtblue">
		        <td>(<%=offtype.getOffDesc(obj.getOfftype()).offtype%>)<%=obj.getEff_dt()%> ~ <%=obj.getExp_dt()%></td>
				<td><%=obj.getOffquota()%></td>
				<td><%=obj.getUseddays()%></td>
	        </tr>
		 <%
			}
		 %>	  
	    </table>
	  </td>
	</tr> 
    <tr valign="top" class="txtxred"> 
      <td width="25%" align= "center" valign="middle"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj2.getAldate()%></font></b></td>     
    </tr>
    <tr valign="top" class="txtblue"> 
	  <td width="25%"  class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>未扣除特休假總天數</b></font></td>
   </tr>
    <tr valign="top" class="txtxred"> 
      <td width="25%" align= "center" valign="middle"><font face="Arial, Helvetica, sans-serif" size="2"><%=undeduct%></font></b></td>     
    </tr>
  </table> 
<br>
<form name="form1" method="post" ONSUBMIT="return f_submit();" action="delal.jsp">
  <table width="75%" border="1" cellpadding="0" cellspacing="0">
    <tr bgcolor="#CCCCCC"> 
      <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">OffNo</font></strong></div>
      </td>
      <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Offtype</font></strong></div>
      </td>
      <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Offsdate</font></strong></div>
      </td>
      <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Offedate</font></strong></div>
      </td>
      <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Days</font></strong></div>
      </td>
      <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">ApplyDate</font></strong></div>
      </td>
	  <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Remark</font></strong></div>
      </td>
	  <td class="tablehead"> 
        <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Del</font></strong></div>
      </td>
    </tr>
<%
if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
		OffsObj obj = (OffsObj) objAL.get(i);
		if ("N".equals(obj.getRemark()))
		{
			bc = "#BFCFFF";
		}	
		else if ("*".equals(obj.getRemark()))
		{
			bc = "#FFCCFF";
		}	
		else
		{
			bc = "#FFFFFF";
		}
		 //判斷display data
		 //*****************************************************
		show = false;

		if("0".equals(obj.getOfftype()) | "8".equals(obj.getOfftype()) | "15".equals(obj.getOfftype()) | "16".equals(obj.getOfftype()) | "27".equals(obj.getOfftype()) )
		{
			show = true;
		}
		else //if("b".equals(display_offtype) or "c".equals(display_offtype))
		{			
			show = false;			
		}
	    //*****************************************************
	if(show == true)
	{
%>
    <tr bgcolor = "<%=bc%>" class="txtblue"> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getOffno()%></font></div>
      </td>
<%
		OffTypeObj offtypeobj = offtype.getOffDesc(obj.getOfftype());
%>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=offtypeobj.offtype%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getOffsdate()%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getOffedate()%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getOffdays()%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getNewdate()%></font></div>
      </td>
	  <%
	  if ("*".equals(obj.getRemark()))
	  {
	  	bc = "#FF0000";
	  }
	  else 
	 {
	  	bc = "#0000CC";
	  }
	  %>
	  <td> 
        <div align="center"><font color="<%=bc%>" size="2" face="Arial, Helvetica, sans-serif"><strong><%=obj.getRemark()%></strong></font></div>
      </td>
	  <%
	 if ("N".equals(obj.getRemark()) && ("0".equals(obj.getOfftype()) | "16".equals(obj.getOfftype()) | "27".equals(obj.getOfftype()) | "15".equals(obj.getOfftype())))
	  {
		 hasdelete = true;
	  %>
		  <td> 
			<div align="center"><font face="Arial, Helvetica, sans-serif" size="2">
			  <input name="checkdel" type="checkbox" id="checkdel" value="<%=obj.getOffsdate()%><%=obj.getOffedate()%><%=obj.getOffno()%>">
			</font></div>
	    </td>
	  <%
	  }
	  else
	  {
	  %>
		  <td>&nbsp;</td>
	  <%
	  }
	  %>
    </tr>
<%
		} //if show == true
	}//for(int i=0; i<objAL.size(); i++)
}//if(objAL.size()>0)

%>
  </table>
<%
if(hasdelete == true)
{
%>
  <p>
    <input type="submit" name="Submit" value="送出刪除假單">
    <input name="gdyear" type="hidden" id="gdyear" value="<%=gdyear%>">
  </p>
<%
}
%>
  </form>
  <p class="red9"><strong><%= msg%></strong></p>
  <table width="75%"  border="0">
  <tr>
  <td><font color="#0000CC" size="2"><strong>Remark</strong> : <font color="#FF0000"><strong>* </strong></font>--&gt;已刪除假單、<strong>Y</strong> --&gt; 已扣除假單、<strong>N </strong>--&gt; 未扣除假單</font></td>
  </tr>
  <tr>
  <td><font color="#FF0000" size="2"><strong>重要提示:</strong><br>
  * 特休假將於休假生效日當天扣除。<br>
  * 欲取消每月1日至10日之特休假,需提前2個月10日(含10日)以前申請。<br>
  * 欲取消每月11日以後之特休假,需提前1個月10日(含10日)以前申請。<br>
  <strong>如有任何問題請洽空服行政。</strong></font></td>
  </tr>
<%--   
  <tr>
  <td><font color="#0000CC" size="2"><%= msg%></font></td>
  </tr> 
 --%>
  </table>

</div>
</body>
</html>
<script language=javascript>
function f_submit()
{  
	 document.getElementById('Submit').disabled=1;
	 if(confirm("Cancel AL/XL request ?"))
	 {
		return true;
	 }
	 else
	 {
		document.getElementById("Submit").disabled=0;
		return false;
	 }
}
</script>
