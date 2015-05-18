<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,ci.db.*,da.PTPC.*,java.util.*"%>
<%
//for CRM/SS/FM/ES

String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");
String peak = request.getParameter("peak");
String checkType = request.getParameter("checkType");
session.setAttribute("trnRecord"+checkType,null);

//RetrieveCRMSSFMData rd = new RetrieveCRMSSFMData(fleet,rank);
//Test
RetrieveCRMSSFMData rd = new RetrieveCRMSSFMData(fleet,rank,checkType,"orp3");

//ArrayList al = new ArrayList();
ArrayList al = rd.job();
session.setAttribute("trnRecord"+checkType,al);
/*
if("CRM".equals(checkType)){
	al = rd.jobCRM();
	session.setAttribute("trnRecordCRM",al);
}else if("SS".equals(checkType)){
	al = rd.jobSS();
	session.setAttribute("trnRecordSS",al);
}else if("FM".equals(checkType)){
	al = rd.jobFM();
	session.setAttribute("trnRecordFM",al);
}else if("ES".equals(checkType)){
	al = rd.jobES();
	session.setAttribute("trnRecordES",al);
}

*/




//�����`�H��
NumberOfFleet nf = new NumberOfFleet();
int total = Integer.parseInt(nf.getCount(fleet, rank));

//�w�����V�H��
ExpOfTrn ep = new ExpOfTrn(peak, total);
int expect = ep.getExp();

int dr = Integer.parseInt(rd.getDateRange(-6).substring(0,4) +rd.getDateRange(-6).substring(5,7) );


if(al.size() ==0)	
	out.print("No DATA!!");
else{	

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title><%=checkType%> </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="checkDel.js" language="javascript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

function �@substitute(){//���save buffer�ɡA�a�J�ѼƶǤU�@��
	var t = checkDel('form1','sel');
	document.form1.classes.value="sub";
	
	if(t){
		document.form1.submit();
	}
}

/**�p��Ŀ諸�ƥإB���
 * Ĳ�o�ƥ�G�Ŀ����έӧOcheckbox
 */
function calc(){
	var count=0;
	for(var i=1;i<(<%=al.size()%>+1);i++){
	  var e = document.forms[0].elements[i];
		if(e.checked){
			count++;
		}
	}
	
	if(count > (<%=expect%>)){
		document.getElementById("showTotal").innerHTML="<span class=\"txtred\"><strong>"+count+"</strong></span>";	
	}else{
		document.getElementById("showTotal").innerHTML="<span class=\"txtblue\">"+count+"</span>";	
	}


}
</script>
<style type="text/css">
<!--
.style1 {color: #CCCCCC}
-->
</style>
</head>

<body >

<form name="form1" action="makeList.jsp" method="post" onsubmit="document.form1.classes.value='list';return checkDel('form1','sel');" onreset="calc()">
  <table width="70%"  border="0" cellpadding="1" cellspacing="1" align="center">
    <tr >
      <td>
        <div align="center" ><span class="txtred">
		<%=rd.getFirstDayOfThisYear().substring(0,7)%>&nbsp;&nbsp;
		<%=checkType%> ��ĳ�I�V�W��</span></div>
      </td>
    </tr>
    <tr >
      <td> <span class="fonte_dblue2">Fleet:<span class="txtred"><strong><%=fleet%></strong></span> Rank:<span class="txtred"><strong><%=rank%></strong></span> </span> �`�H�ơG<span class="txtred"><%=total%> </span>&nbsp; �u�`�G<span class="fonte_pink">
        <%
	if("on".equals(peak)){out.print("&nbsp;���u&nbsp;&nbsp;");}else{out.print("&nbsp;�H�u&nbsp;&nbsp;");}
	%>
      </span> �w���ݨ��V�H�ơG<span class="txtred"><%=expect%></span>&nbsp;&nbsp;�ثe��ܤH�ơG<span  id="showTotal">0</span></td>
    </tr>
    <tr >
      <td class="button4">
        <p><span class="txtblue">�ϥܡG</span><span style="color:#FFCCCC">��</span><span class="txtblue"></span><span class="txtblue">���j8��H�W</span> <span style="color:#FDFDCA">��</span><span class="txtblue">���j6~8��</span><span style="color:#CCFFFF">��</span><span class="txtblue">���j6��</span><span style="color:#CCCCCC">��</span><span class="txtblue">���j����6��</span></p>
      </td>
    </tr>
  </table>
  <table width="70%"  border="1" cellpadding="1" cellspacing="1" bordercolor="#CCCCCC" align="center">
  <tr class="tablehead4">
    <td width="10%">All
        <input type="checkbox" name="noSel" onClick="CheckAll('form1','noSel');calc()" id="noSel">
    </td>
    <td width="5%">
      <div align="center">Fleet</div>
    </td>
    <td width="7%">
      <div align="center">Rank</div>
    </td>
    <td width="10%">
      <div align="center">Empno</div>
    </td>
    <td width="15%">
      <div align="center">Name</div>
    </td>
    <td width="22%">EName</td>
    <td width="15%">
      <div align="center">Last_Date</div>
    </td>
    <td width="16%">
      <div align="center">
	  <%
	  if("PC".equals(checkType)){
	  	out.print("CheckType");
	   }else{
	   	out.print("Subject");
	   }
	  %>
	  
	  
	  </div>
    </td>
  </tr>
  <%
String bgColor="#FFFFFF";

	for(int i=0;i<al.size();i++){
		
		CKPLObj ck= (CKPLObj)al.get(i);
		int dr1 = Integer.parseInt(ck.getDate().substring(0,4) +ck.getDate().substring(5,7));
	if(dr1 <dr-2){
		bgColor = "#FFCCCC"; // �j�� 8��
	}else if(dr1  < dr && dr1 >=dr-2){	 //����K��
		bgColor = "#FDFFCA";
	}else if (dr1 == dr){	//����
		bgColor="#CCFFFF";
	}else{
		bgColor = "#CCCCCC";	//�Ǧ�,���줻��
	}

%>
  <tr bgcolor="<%=bgColor%>">
    <td>
      <div align="right">

        <input type="checkbox" value="<%=i%>" name="sel" onClick="calc()"><%=(i+1)%>
       </div>
    </td>
    <td>
      <div align="center"><%=ck.getFleet() %></div>
    </td>
    <td>
      <div align="center"><%=ck.getRank() %></div>
    </td>
    <td>
      <div align="center"><%=ck.getEmpno()%></div>
    </td>
    <td>
      <div align="center"><%=ck.getCname()%></div>
    </td>
    <td><div align="left">&nbsp;<%=ck.getEname() %></div>
</td>
    <td>
      <div align="center"><%=ck.getDate() %></div>
    </td>
    <td>
      <div align="center">
	  <%=ck.getChktype()%></div>
    </td>
  </tr>
  <%

}
%>
</table>
<table width="70%"  border="0" align="center" cellpadding="1" cellspacing="1">

  <tr >
    <td height="38">
      <div align="center" >
        <input name="�e�X" type="submit" class="button4" value="Save List" >
&nbsp;&nbsp;
        <input type="button" class="button3" value="Save Buffer" onClick="substitute()">
&nbsp;&nbsp;
        <input name="���]" type="reset" class="button5" value="ReSelect" >
        <input type="hidden" name="sourcePage" value="<%=checkType%>">
        <input type="hidden" name="fleet" value="<%=fleet%>">
        <input type="hidden" name="rank" value="<%=rank%>">
        <input type="hidden" name="peak" value="<%=peak%>">
        <input type="hidden" name="classes" value="list">
      </div>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</form>

</body>
</html>
<%
}
%>