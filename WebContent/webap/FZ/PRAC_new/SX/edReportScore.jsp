<%@page contentType="text/html; charset=" language="java" %>
<%@page import="fz.*,java.sql.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String fdate 	= request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();

String CA 		= request.getParameter("CA").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數

String acno 	= request.getParameter("acno").trim();
String fleet 	= request.getParameter("fleet");

String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");


String[] sern	= request.getParameterValues("sern");
String[] scoreShow	= {"X","1","2","3","4","5","6","7","8","9","10"};
String[] score	= {"0","1","2","3","4","5","6","7","8","9","10"};
String[] occu 	= request.getParameterValues("occu");

String bcolor="";
//String fontcolor = "";




//purser的empno,sern,name,group
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");
String pgroups    = request.getParameter("pgroups");


//out.print(purserEmpno+"<HR>"+psrsern+"<HR>"+psrname+"<HR>"+pgroups+"<HR>");


%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=">
<title>編輯座艙長報告</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="changeAction.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
function disableSubmit()
{
	var temp_f = document.form1.f.value;
	var temp_c = document.form1.c.value;
	var temp_y = document.form1.y.value;
	var temp_inf = document.form1.inf.value;
	var temp_ttl = parseInt(temp_f)+parseInt(temp_c)+parseInt(temp_y)+parseInt(temp_inf);
	var odnum = 0;
	for(var i=0; i<document.form1.duty.length; i++)
	{
		if(document.form1.duty[i].value =="OD")
		{
			odnum++;
		}
	}

	if(parseInt(temp_ttl) <=0 && odnum <=0)
	{
		 alert("請輸入實際旅客人數!!\n若為Ferry Flt,請選擇打工組員(Duty code OD).");
		 document.form1.f.focus();
		 return false;
	}
	else
	{
		document.form1.GiveComments.disabled=1;
		return true;
	}
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
		var temp_f = document.form1.f.value;
		var temp_c = document.form1.c.value;
		var temp_y = document.form1.y.value;
		var temp_inf = document.form1.inf.value;
		document.form1.ttl.value = parseInt(temp_f)+parseInt(temp_c)+parseInt(temp_y)+parseInt(temp_inf);
		return true;
	}
}


</script>
</head>
<body onload="javascript:alert('每一航段往返，可有不同PA 組員；單程可啟用至三名。')">
<%
//modify by cs66 at 2005/02/17 檢查組員人數
if(empno.length >20){
%>
<script language="javascript">
	alert("組員人數超過20人，請刪除ACM組員");
	self.location = "javascript:history.back(-2)";
</script>
<%

}else{


%>
  <form name="form1" method="post" action="edReportComm.jsp" target="_self" onSubmit="return disableSubmit()">
    <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="middle">
          <div align="center" class="txtred"></div>
          <span class="txtblue">Purser's Report&nbsp; &nbsp;</span><span class="purple_txt"><strong> Step2.To score each crew and modify number of passengers</strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span>&nbsp;Fleet:<span class="txtred"><%=fleet%></span> </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">Purser:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="381" valign="middle"  class="txtblue">A/C:<span class="txtred">
          <input type="text" name="acno" value="<%=acno%>" size="5" maxlength="5">
        </span></td>
        <td width="142" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> F:
            <input type="text" name="f" size="3"  value="<%=f%>" onkeyup="return checkNUM('f')" >
C:
<input type="text" name="c" size="3" value="<%=c%>"   onkeyup="return checkNUM('c')" >
Y:
<input type="text" name="y" size="3" value="<%=y%>"   onkeyup="return checkNUM('y')" >
INF:
<input type="text" name="inf" size="3"  value="0" onkeyup="return checkNUM('inf')" >
&nbsp; Pax:<input type="text" class="txtred" name="ttl" id="ttl" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=ShowPeople%>" readonly></td>
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="86">Name</td>
      <td width="212">EName</td>
      <td width="47">Sern</td>
      <td width="68">Empno</td>
      <td width="49">Duty</td>
      <td width="39">Score</td>
      <td width="75">最佳服務</td>
    </tr>
	<%


for(int i=0;i<empno.length;i++){

		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}		
%>
  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=cname[i]%>" name="cname" tabindex="999">
	  </td>
      <td class="tablebody">
        <div align="left">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename[i]%>" name="ename" tabindex="999">
        </div>
      </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern[i]%>" name="sern"  tabindex="999"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno" tabindex="999"> </td>
      <td class="tablebody">
	  	<select name="duty"  tabindex="<%=(1+i)%>">
			<jsp:include page="purDuty.htm"/>
		</select>
	  </td>
      <td class="tablebody">
        <select name="score"  tabindex="<%=(51+i)%>">
          <%  	  	for(int j=0;j<=10;j++){	  %>
          <option value="<%=score[j]%>"><%=scoreShow[j]%></option>
          <%		}	  					  %>
        </select>
</td>
      <td class="tablebody">
        <input type="checkbox" name="gs" value="<%=empno[i]+sern[i]%>">
      </td>
  </tr>
  <%
	}
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="10">&nbsp;</td>
      <td width="148">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td width="353"><span class="txttitletop">
        <input name="GiveComments" type="submit" class="addButton" value="Save ( Next ) " tabindex="<%=(total+2)%>">
        &nbsp;&nbsp;&nbsp;
        
&nbsp;&nbsp;&nbsp;
<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
&nbsp;&nbsp;&nbsp;  
<input type="reset" name="reset" value="Reset">
<span class="txtblue">
		  <input type="hidden" name="dpt" value="<%=dpt%>">
		  <input type="hidden" name="arv" value="<%=arv%>">
		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		  <input type="hidden" name="CA" value="<%=CA%>">
		  <input type="hidden" name="ShowPeople" value="<%=ShowPeople%>">
  		<input type="hidden" name="CACName" value="<%=CACName%>">
   		<input type="hidden" name="CAEmpno" value="<%=CAEmpno%>"> 
		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="total" value="<%=total%>">
<input type="hidden" name="GdYear" value="<%=GdYear%>">		
<input type="hidden" name="fleet" value="<%=fleet%>">		
   		</span></td>
			<!--ZC-->
		<%
			eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
			zcrt.getZCFltListForPR(fdate,fltno,dpt+arv,purserEmpno);
			ArrayList zcAL = zcrt.getObjAL();
			if(zcAL.size()>0)
			{
				eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
				if("Y".equals(zcobj.getIfsent()))
				{//已送出
			  
		%>
			  <td>
				<input type="button" name="viewzc" value="ZC Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=purserEmpno%>','zcreport','height=800, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
			  </td>
		<%
				}//已送出if("Y".equals(zcobj.getIfsent()))
			}//if(zcAL.size()>0)			
		%>
			<!--ZC-->
    </tr>
</table>
</form>
<%
}
%>
</body>
</html>
