<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*"%>
<%


response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
response.sendRedirect("../sendredirect.jsp");
} 
//write log
/*
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

writeLog wl = new writeLog();
String wlog = wl.updLog(sGetUsr, userip,userhost, "FZ051");
*/
//String cname = (String) session.getAttribute("cname") ;
session.setAttribute("putSkjObj",null);

String year = request.getParameter("year");
String month = request.getParameter("month");
String bcolor = "";

//檢查班表是否公布
swap3ac.PublishCheck pc =null;
if(request.getParameter("year") != null && request.getParameter("month") != null
	&& !"".equals(request.getParameter("year"))  && !"".equals(request.getParameter("month"))){
		 pc = new swap3ac.PublishCheck(year, month);
 
}

 if(request.getParameter("year") == null | request.getParameter("month") == null
 	| "".equals(request.getParameter("year")) |"".equals(request.getParameter("month"))){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">請選擇年/月</p>
<%
}else if(!pc.isPublished()){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;"><%=year+"/"+month%> 班表尚未正式公布</p>
<%
}else{

swap3ac.CrewSwapSkj csk = new swap3ac.CrewSwapSkj(sGetUsr, "null", year, month);

swap3ac.CrewInfoObj obj = null;
ArrayList dataAL = null;
try {
	csk.SelectData();
	obj = csk.getACrewInfoObj();
	 dataAL = csk.getACrewSkjAL();

	
} catch (SQLException e) {
	//System.out.print(e.toString());
} catch (Exception e) {
//	System.out.print(e.toString());

}
//儲存丟班資訊
fzac.CrewPutSkjObj cpObj2 = new fzac.CrewPutSkjObj();
if(obj != null){
	cpObj2.setCrewInfo(obj);
	cpObj2.setSkjObj(dataAL);
}
//移除已丟出之班表
fzac.RemoveDuplicatePutSkj rp = new fzac.RemoveDuplicatePutSkj(cpObj2);

try {
	rp.job();
	
} catch (SQLException e) {
	//System.out.print(e.toString());
} catch (Exception e) {
	//System.out.print(e.toString());

}
fzac.CrewPutSkjObj cpObj = rp.getCrewSkjObj();

session.setAttribute("putSkjObj",cpObj);
%>
<html>
<head>
<title>Schedule Put</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../menu.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<script language="javascript" type="text/javascript" >
function checkSel(){	
	count = 0;
	for (i=0; i<document.form1.length; i++) {
		if (document.form1.elements[i].checked){
			 count++;
		}
	}
	if(count ==0 ) {
		alert("尚未勾選要丟出的班次!!\nPlease select Schedule!!");
		return false;
	}
	
	else{
		return true;
	}
}


</script>
</head>

<body ><br>
<%
if(obj != null && dataAL.size() > 0){


%>
<table width="60%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="txtblue"><span class="txtxred">          <strong> The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。 </strong>        </span></td>
    </tr>
</table>
<div align="center" class="txttitletop">
  <br><%=year+"/"+month%> Schedule by trip
  <br><span class="txtblue"><%=obj.getCname()%> <%=sGetUsr%> <%=obj.getSern()%> <%=obj.getQual()%> <%=obj.getBase()%></span>
<form name="form1" method="post" action="updput.jsp" onsubmit="return checkSel()">
    <table width="60%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
	  	<td class="tablehead">FltDate</td>
		<td class="tablehead">FltNo</td>
        <td class="tablehead">TripNo</td>
        <td class="tablehead">Detail</td>
        <td class="tablehead">Put</td>
		<td class="tablehead">Commets</td>
      </tr>
      <%
	  for(int i=0;i<dataAL.size();i++){
	  
		swap3ac.CrewSkjObj objX = (swap3ac.CrewSkjObj) dataAL.get(i);
			if (i%2 == 0)			{
				bcolor = "#CCCCCC";
			}else{
				bcolor = "#999999";
			}
%>
      <tr bgcolor="<%=bcolor%>"> 
	  	<td height="24" class="tablebody"><%=objX.getFdate()%></td>
		<td class="tablebody"><%=objX.getDutycode()%></td>
        <td class="tablebody"><%=objX.getTripno()%></td>
		<td> 
          <div align="center"><a href="../swap3ac/tripInfo.jsp?tripno=<%=objX.getTripno()%>" target="_blank"> 
            <img src="../img2/doc2.gif" width="16" height="16" alt="show fly schedule detail" border="0"></a></div>
        </td>
        <td> 
          <div align="center"> 
           
            <input type="checkbox" name="checkput" value="<%=i%>">
          </div>
        </td>
		<td class="tablebody"><input name="comm" type="text" id="comm" value="no comments" size="50" maxlength="100" onfocus="if(this.value==this.defaultValue)this.value=''" onBlur="if(this.value=='')this.value=this.defaultValue"></td>
      </tr>
      <%
	}


%>
    </table>
    <br><input type="Submit" name="Submit" value="Put the Schedule" class="btm">
<input type="hidden" name="year"  value="<%=year%>">
<input type="hidden" name="month"  value="<%=month%>">
<br>
<span class="txtxred">*Comments
字數限制：100英文字或50中文字.</span></form>
</div>
<%
}else{
%>
<div class="errStyle1">NO DATA!<br>
  可能為查無資料,或所有班表均已丟出.
</div><br>

<%

}
%>
<center> <iframe src="showbook.jsp?year=<%=year%>&month=<%=month%>" width="800" height="400" align="middle"></iframe> </center>

</body>
</html>
<%
}
%>