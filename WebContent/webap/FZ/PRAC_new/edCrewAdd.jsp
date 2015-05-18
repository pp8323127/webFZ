<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,java.net.URLEncoder"%>
<%
//座艙長報告--新增組員



String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

ArrayList crewObjList = (ArrayList)session.getAttribute("crewObjList");
String fdate = request.getParameter("fdate");


//取得考績年度
String GdYear =  request.getParameter("GdYear");//fz.pracP.GdYear.getGdYear(fdate);

String CA = request.getParameter("CA");


//顯示旅客總人數
String ShowPeople =request.getParameter("ShowPeople");
String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數

String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();
String acno = request.getParameter("acno").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String addSern = request.getParameter("addSern");

String empno 	= null;
String sern		= null;
String cname	= null;
String ename	= null;
String occu 	= null;

String OsernList= request.getParameter("OsernList");
String addSernList = request.getParameter("addSernList");

String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");
String pgroups    = request.getParameter("pgroups");
String fleet    = request.getParameter("fleet");
String bcolor=null;
String errMsg = "";
boolean status = false;

String ListAfterAdd = "";

//驗證新增的sern為有效的
fzac.CrewInfo cInfo =  new fzac.CrewInfo(addSern);
fzac.CrewInfoObj o = cInfo.getCrewInfo();
if(!cInfo.isHasData()){//無效的序號
	errMsg = "新增的序號無效，請重新輸入";
}else if(OsernList.indexOf(addSern) >-1 ){	//新增的序號原已存在
	
	/*status = true;
	session.setAttribute("crewObjList",crewObjList);
	ListAfterAdd = OsernList;
	*/
	errMsg="此序號已存在，請重新輸入";
}else{
status = true;
//加入新組員後的清單
ListAfterAdd = OsernList+",'"+addSern+"'";

	o.setNewCrew(true);

//新增組員時，中文姓名另外取得
aircrew.CrewCName cc = new aircrew.CrewCName();
o.setCname(cc.getCname(o.getEmpno()));
	crewObjList.add(o);
	session.setAttribute("crewObjList",crewObjList);

}	


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>座艙長報告--新增組員</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="checkDel.js" type="text/javascript"></script>
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>
<body>
<%
if(!status){
%>
<script language="javascript">
	alert("<%=errMsg%>");
	self.location="javascript:history.back(-1);";
</script>
<%
//out.print(errMsg);

}else{
%>
<form name="form1" method="post" action="edCrewDel.jsp" target="_self" onSubmit="return del('form1','delSern')">
    <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="middle">
          <div align="center" class="txtred"></div>
          <span class="txtblue">Cabin's Report&nbsp; &nbsp;</span><span class="txtxred"><strong> Step1.Select Crew List(Add or Delete Crew List) </strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
        <td width="68" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">Cabin:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="280" valign="middle"  class="txtblue">A/C:<span class="txtred"><%=acno%></span></td>
        <td width="231" valign="middle">
          <div align="right"><span class="purple_txt"><strong>GradeYear：<%=GdYear%></strong></span> </div>
        </td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <table width="547"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
  	  <td width="82">Select</td>
      <td width="87">Name</td>
      <td width="226">EName</td>
      <td width="47">Sern</td>
      <td width="50">Empno</td>
      <td width="31">Occu</td>
    </tr>
	<%
for(int i=0;i<crewObjList.size();i++){
	  fzac.CrewInfoObj oi = ( fzac.CrewInfoObj)crewObjList.get(i);
	 
	 	if(oi.isNewCrew()){
			bcolor="#CC99CC";
		}
		else if(i%2 ==0){
			bcolor="#99CCFF";
		}else{
			bcolor="#FFFFFF";
		}

		String tempstr = "";
		if(!"FLY".equals(oi.getDuty_cd()))
		{
		 tempstr = "<font color = 'red'>(TVL)</font>";
		}

		
	%>
  <tr bgcolor="<%=bcolor%>">
   <td valign="middle" class="tablebody">
        <input name="delSern" type="checkbox"  value="<%=oi.getSern()%>">
      </td>
      <td align="center" valign="middle" class="tablebody">&nbsp;
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=oi.getCname()%> <%=oi.getSpCode()%>" name="cname"><%=tempstr%></td>
      <td valign="middle" class="tablebody">
        <div align="left">&nbsp;
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=oi.getEname()%>" name="ename"></div>
      </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=oi.getSern()%>" name="sern">
	  </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=oi.getEmpno()%>" name="empno">
	  </td>
      <td valign="middle" class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="2" value="<%=oi.getOccu()%>" name="occu" >
	  </td>
     

    </tr>
<%
}
%>	
</table>

  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43" height="49">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=crewObjList.size()%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input type="button" name="Score" value="Score (Next)" onClick="this.disabled=1;preview('form1','edReportScore.jsp')" class="addButton">        
        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno2" value="Delete Selected" class="delButon" >
&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="dpt" value="<%=dpt%>">
        <input type="hidden" name="arv" value="<%=arv%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">
        <input type="hidden" name="fdate" value="<%=fdate%>">
        <input type="hidden" name="OsernList" value="<%=ListAfterAdd%>">
 	   <input type="hidden" name="addSernList" value="<%=addSernList%>">
        <input type="hidden" name="CA" value="<%=CA%>">
        <input type="hidden" name="ShowPeople" value="<%=ShowPeople%>">
		<input type="hidden" name="acno" value="<%=acno%>">
  		  <input type="hidden" name="CACName" value="<%=CACName%>">
   		  <input type="hidden" name="CAEmpno" value="<%=CAEmpno%>">
		  <input type="hidden" name="total" value="<%=crewObjList.size()%>">
  		  <input type="hidden" name="f" value="<%=f%>">
   		  <input type="hidden" name="c" value="<%=c%>">
		  <input type="hidden" name="y" value="<%=y%>">
		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
		  <input type="hidden" name="fleet" value="<%=fleet%>">
      </span></td>
      <td width="44">
        <div align="right"><a href="javascript:window.print()"> </a> </div>
      </td>
    </tr>
</table>
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43">&nbsp;</td>
      <td width="789">
        <div align="left" class="txtblue">Insert Crew's Sern：
          <input type="text" name="addSern" size="5" maxlength="5">
     	 <input type="button" name="Submit2" value="Add"  onClick="checkAdd('form1','addSern','edCrewAdd.jsp')">
         <span class="txttitletop">
&nbsp;&nbsp;        </span></div>
      </td>
      <td width="44">
      </td>
    </tr>
</table>

</form>
<%
}
%>
</body>
</html>