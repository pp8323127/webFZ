<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
session.setAttribute("smsObj",null);
String y = request.getParameter("yy");
String m = request.getParameter("mm");
String d = request.getParameter("dd");
String requestFdate = y+"/"+m+"/"+d;
String bcolor = "";

String showMakeFile = request.getParameter("showMakeFile");
String requestFltno = null;

String classType = null;

if(!"".equals(request.getParameter("fltno")) && null != request.getParameter("fltno")){
	requestFltno = request.getParameter("fltno").trim();

}

if(!"".equals(request.getParameter("classType")) && null != request.getParameter("classType")){
	classType = request.getParameter("classType");
}

ArrayList al  = null;
//上課或待命
if( null != classType){
	swap3ackhh.smsacP.CrewPhoneListDuty cflt = new swap3ackhh.smsacP.CrewPhoneListDuty(y, m,d, classType);
	try {
		cflt.initData();
		al= cflt.getDataAL();
		requestFltno = cflt.getDutyCd();

	} catch (SQLException e) {
		System.out.print(e.toString());
	} catch (Exception e) {
		System.out.print(e.toString());
	}					
	
}
//單一航班
else{

	swap3ackhh.smsacP.CrewPhoneListSingleFlt cflt = new swap3ackhh.smsacP.CrewPhoneListSingleFlt(y, m,d, requestFltno);
	
	try {
		cflt.initData();

		al= cflt.getDataAL();
		requestFltno = cflt.getFltno();

	} catch (SQLException e) {
		System.out.print(e.toString());
	} catch (Exception e) {
		System.out.print(e.toString());
	}					

}

if(al != null){
	session.setAttribute("smsObj",al);	
}			
			
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Show flt</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>

<body>
<%
if(al == null){
out.print("<div class=\"errStyle1\">NO DATA!!<br><br>查詢上課或待命組員，請輸入完整任務代碼<br><br></div>");
}else{

%>
<form action="Show1FltAE.jsp" method="post" name="form1" target="_self" onSubmit="return del()">
  <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr class="tablehead3">
      <td width="13%">
        <div align="center">Date(Taipei)</div>
      </td>
      <td width="10%">
        <div align="center">Flt</div>
      </td>
      <td width="15%">
        <div align="center">Crew</div>
      </td>
      <td width="16%">Empno</td>
      <td width="11%">
        <div align="center">Occu</div>
      </td>
      <td width="18%">
        <div align="center">MobilPhone</div>
      </td>
      <td width="17%">Delete</td>
    </tr>
    <%
	for (int i = 0; i < al.size(); i++) {
		swap3ackhh.smsacP.CrewPhoneListObj o = (swap3ackhh.smsacP.CrewPhoneListObj) al.get(i);
 
		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}
  
  %>
    <tr bgcolor="<%=bcolor%>">
      <td   class="tablebody"><%=y+"/"+m+"/"+d%></td>
      <td class="tablebody"><%=requestFltno%></td>
      <td class="tablebody"><%=o.getCname()%></td>
      <td class="tablebody"><%=o.getEmpno()%></td>
      <td class="tablebody"><%=o.getRank()%></td>
      <td class="tablebody">&nbsp;<%=o.getMphone()%></td>
      <td class="tablebody">
        <input name="delEmpno" type="checkbox"  value="<%=o.getEmpno()%>">
      </td>
    </tr>
    <%
  		}

  
  %>
  </table>
  <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td colspan="3">
        <div align="center">
          <input type="submit" value="Delete" class="delButon">
          <br>
        </div>
      </td>
    </tr>
    <tr>
      <td width="29%">&nbsp;</td>
      <td width="49%">
        <p class="txtxred">註：製作手機號碼檔案時，系統會自動排除無手機號碼，<br>
          或非國內手機號碼等無法傳送情況，不需自行刪除。</p>
      </td>
      <td width="22%">&nbsp;</td>
    </tr>
  </table>
 
  <input type="hidden" name="requestFdate" value="<%=requestFdate%>">
  <input type="hidden" name="requestFltno" value="<%=requestFltno%>">
  <input type="hidden" name="showMakeFile" value="Y">
</form>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >
      <p>Total：<%=al.size()%></p>
    </td>
  </tr>
  <tr >
    <td class="txtblue" >
      <form name="form2" action="Show1FltAEAdd.jsp?" method="post" target="_self" onSubmit="return checkEmpno()">
        新增組員，請輸入員工號（Add Empno）：
          <input type="text" name="addEmpno" size="6" maxlength="6">
          <input name="addEmpSubmit" type="submit" value="Add">
		  <input type="hidden" name="requestFdate" value="<%=requestFdate%>">
		  <input type="hidden" name="requestFltno" value="<%=requestFltno%>">
		   <input type="hidden" name="showMakeFile" value="Y">
      </form>
    </td>
  </tr>
  <%
if(showMakeFile.equals("Y")){
%>
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" action="SMSFile2.jsp">
        <div align="center">
          <input type="submit" name="Submit" value="Make File" >
        <input type="hidden" name="requestFdate" value="<%=requestFdate%>">
		  <input type="hidden" name="requestFltno" value="<%=requestFltno%>">
      </div>
				  </form>
    </td>
  </tr>
  <%
}
else{

%>
  <tr >
    <td class="txtblue" >
      <div align="center">
        <input type="button" name="closeWindow" value="Close" onClick="self.close()" >
      </div>
    </td>
  </tr>
  <%
}
%>
</table>
<%
}
%>
</body>
</html>
