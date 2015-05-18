<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String  requestFdate =request.getParameter("requestFdate");
String requestFltno = request.getParameter("requestFltno").trim();
String showMakeFile  = request.getParameter("showMakeFile");
String addEmpno =  request.getParameter("addEmpno");
String bcolor= null;
ArrayList dataAL = (ArrayList) session.getAttribute("smsObj");
ArrayList al  = null;

String[] idxS = request.getParameterValues("delEmpno");

if(!"".equals(request.getParameterValues("delEmpno")) 
	&& null != 	request.getParameterValues("delEmpno")){
	
	
	//移除刪去的組員
	
	for(int i=0;i<dataAL.size();i++){
		swap3ackhh.smsacP.CrewPhoneListObj o = (swap3ackhh.smsacP.CrewPhoneListObj) dataAL.get(i);
		for(int j=0;j<idxS.length;j++){
			
			if(o.getEmpno().equals(idxS[j])){
				dataAL.remove(i);
				if(i != 0){
					i--;
				}
			}
			
		}
	}
	

	al = dataAL;

}

if(addEmpno != null && !"".equals(addEmpno)){
	swap3ackhh.smsacP.AddCrewPhoneData ap = new swap3ackhh.smsacP.AddCrewPhoneData(addEmpno,dataAL);
	
	
	try {
		ap.initData();
		al = ap.getDataAL();
	
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


</head>
<%
if(al == null){
out.print("no data");
}else{

%>
<body>
<form action="Show1FltAE.jsp?requestFdate=<%=requestFdate%>&requestFltno=<%=requestFltno%>&showMakeFile=Y" method="post" name="form1" target="_self" onSubmit="return del()">
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
  
  	if(o.isNewCrew()){
	 bcolor="#CC99CC";
	}
  %>
    <tr bgcolor="<%=bcolor%>">
      <td   class="tablebody"><%=requestFdate%></td>
      <td class="tablebody"><%=requestFltno%></td>
      <td class="tablebody"><%=o.getCname()%></td>
      <td class="tablebody"><%=o.getEmpno()%></td>
      <td class="tablebody"><%=o.getRank()%></td>
      <td class="tablebody">&nbsp;<%=o.getMphone()%><% if(o.isNewCrew()){%> <span class="txtxred">New!!</span>	 <%}%></td>
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
      <form name="form2" action="Show1FltAEAdd.jsp" method="post" target="_self" onSubmit="return checkEmpno()">
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
      <form name="form3" method="post" action="SMSFile.jsp">
        <div align="center">
          <input type="submit" name="Submit" value="Make File" >
        <input type="hidden" name="requestFdate" value="<%=requestFdate%>">
          <input type="hidden" name="requestFltno" value="<%=requestFltno%>">
      </div>         </form>
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
