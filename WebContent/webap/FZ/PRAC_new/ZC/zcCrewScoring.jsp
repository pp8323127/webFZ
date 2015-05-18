<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.util.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	String addSernList = "";
	ArrayList OSernAList = new ArrayList();	
	ArrayList crewListobjAL = new ArrayList();
	String bcolor="";
	crewListobjAL = obj.getZccrewObjAL();
%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>編輯助理座艙長報告</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script src="../changeAction.js" type="text/javascript"></script>
<script src="../subWindow.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
function disableSubmit()
{
		document.form1.GiveComments.disabled=1;
		document.form1.delButton.disabled=1;
		document.form1.delcrew.disabled=1;
		document.form2.Submit_new.disabled=1;
		return true;
}
function checkNUM(col){
	eval("data = document.form1."+col+".value.match(/[^0-9]/g);");
	if(data)
	{
		alert("本欄位只能輸入半形數字");
		eval("document.form1."+col+".value='';");
		return false;
	}
	else
	{
		return true;
	}
}

function zcedCrewAddChk()
{
	var newcrew = document.form2.newcrew.value;
	if(newcrew == null | "" == newcrew )
	{
		alert("請輸入新增組員工號!!");
		return false;
	}
	else
	{
		document.form1.GiveComments.disabled=1;
		document.form1.delButton.disabled=1; 
		document.form1.delcrew.disabled=1;
		document.form2.Submit_new.disabled=1;
		
		return true;
	}
}

function setDuty(subidx,colname)
{
	var duty = eval("document.form1."+colname+".value");
	window.open("zcsetAttribute.jsp?idx=<%=idx%>&attri=duty&subidx="+subidx+"&para1="+duty,'XX',"left=2800,top=800,width=10,height=10,scrollbars=no");
}

function setScore(subidx,colname)
{
	var score = eval("document.form1."+colname+".value");
	window.open("zcsetAttribute.jsp?idx=<%=idx%>&attri=score&subidx="+subidx+"&para1="+score,'XX',"left=800,top=800,width=10,height=10,scrollbars=no");
}

function setBp(subidx,colname)
{
	flag = eval("document.form1."+colname+".checked");
	var bp = "";
	if(flag)
	{
		bp = "Y";
	}
	window.open("zcsetAttribute.jsp?idx=<%=idx%>&attri=bp&subidx="+subidx+"&para1="+bp,'XX',"left=800,top=800,width=10,height=10,scrollbars=no");
}

function setDel(subidx,colname)
{
	window.open("zcsetAttribute.jsp?idx=<%=idx%>&attri=del&para1=Y&subidx="+subidx,'XX',"left=800,top=800,width=10,height=10,scrollbars=no");
}

function goRefresh()
{
	location.replace("zcCrewScoring.jsp?idx=<%=idx%>");
}

function comfirmDel()
{
	if(confirm("刪除報表，會將此份報表所有資料清除。\n確定要刪除？"))
	{		
		location.replace("zcdelReport.jsp?idx=<%=idx%>");
	}
	else
	{
		return;
	}
}

</script>
</head>
<body>
  <form name="form1" method="post" action="zcedReportComm.jsp" target="_self" onSubmit="return disableSubmit()">
    <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="middle">
          <div align="center" class="txtred"></div>
          <span class="txtblue">PR Report&nbsp; &nbsp;</span>
		  <span class="purple_txt"><strong> Step2.Grading for each crew </strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=obj.getFdate()%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=obj.getFlt_num()%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=obj.getPort()%></span>&nbsp;Acno:<span class="txtred"><%=obj.getAcno()%></span></td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">CM:<span class="txtred"><%=obj.getPsrname()%>&nbsp;<%=obj.getPsrsern()%>&nbsp;<%=obj.getPsrempn()%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=obj.getCpname()%></span></td>
		<td align="center">&nbsp;&nbsp;&nbsp;  
		<input type="button" value="Delete Report" class="delButon" onClick="return comfirmDel()" name="delButton"> </td></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">PR:<span class="txtred"><%=obj.getZcname()%>&nbsp;<%=obj.getZcsern()%>&nbsp;<%=obj.getZcempn()%></span></div>
        </td>
        <td valign="middle">&nbsp;</td>
      </tr>
    </table>
    <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td align="center">Delete</td>
      <td >Name</td>
      <td >Sern</td>
      <td >Empno</td>
      <td >Duty</td>
      <td >Score</td>
      <td >最佳服務</td>
    </tr>
	<%
	  int crewcount = 0;
	for(int i=0;i<crewListobjAL.size();i++)
	{
		ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);
		if(!"Y".equals(zccrewobj.getIfcheck()))
		{
			crewcount ++;
			if (crewcount%2 == 0)
			{
				bcolor = "#99CCFF";
			}
			else
			{
				bcolor = "#FFFFFF";
			}		

%>
  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody" width="50"><input type="checkbox" name="del_<%=i%>" onclick="setDel('<%=i%>','del_<%=i%>')"></td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=zccrewobj.getCname()%>" name="cname" tabindex="999">
	  </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=zccrewobj.getSern()%>" name="sern"  tabindex="999"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=zccrewobj.getEmpno()%>" name="empno" tabindex="999"> </td>
      <td class="tablebody">
	  	<select name="duty_<%=i%>" onchange="setDuty('<%=i%>','duty_<%=i%>')">
			<option value="<%=zccrewobj.getDuty()%>"><%=zccrewobj.getDuty()%></option>
			<jsp:include page="../purDuty.htm"/>
		</select>
	  </td>
      <td class="tablebody">
        <select name="score_<%=i%>" onchange="setScore('<%=i%>','score_<%=i%>')">
		<option value="<%=zccrewobj.getScore()%>"><%=zccrewobj.getScore()%></option>
<%  	  	
			for(int j=0;j<=10;j++)
			{	  
%>
				<option value="<%=j%>"><%=j%></option>
<%		
	        }	  					  
%>
        </select>
	  </td>
	  <%
	  	//若有最佳服務，則checked 
		String ifcheck = "";
		if("Y".equals(zccrewobj.getBest_performance()))
		{
			ifcheck ="checked";
		}
	  %>
	 <td class="tablebody"><input type="checkbox" name="bp_<%=i%>" onclick="setBp('<%=i%>','bp_<%=i%>')" <%=ifcheck%>></td>
  </tr>
<%
		}//if(!"".equals(zccrewobj.getIfcheck()) && zccrewobj.getIfcheck() != null)
	}//for(int i=0;i<crewListobjAL.size();i++)
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
	  <td><input type="button" name = "delcrew" value="Delete Crew" class="delButon" onClick="goRefresh();"></td>
      <td width="100">
        <div align="center" class="txtblue">Total:<%=crewcount%></div>
      </td>
      <td align="center"><span class="txttitletop">
        <input name="GiveComments" type="submit" class="addButton" value="Save ( Next )">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
		&nbsp;&nbsp;&nbsp;  
		<input type="reset" name="reset" value="Reset">
		<input type="hidden" name="idx" value="<%=idx%>">		
	    </td>
	  </tr>
   </table>
</form>
<hr>
<form name="form2" method="post" action="zcedCrewAdd.jsp" target="_self" onSubmit="return zcedCrewAddChk();">
<input type="hidden" name="idx" value="<%=idx%>">		
<table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
  <td width="5%">&nbsp;</td>
  <td width="90%">
	<div align="left" class="txtblue">輸入新增組員員工號：
	  <input type="text" name="newcrew" size="6" maxlength="6">
	   <input type="submit" name="Submit_new" value="Add crew">
	<span class="txttitletop">&nbsp;&nbsp;&nbsp;        </span></div>
  </td>
  <td width="5%">
  </td>
</tr>
</table>
</form>
</body>
</html>
<%
}	
%>