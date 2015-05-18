<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.net.URLEncoder,java.util.GregorianCalendar"%>
<%
//座艙長報告--刪除組員
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String fdate = request.getParameter("fdate");

//String newMessage = "";
//String GdYear = "2005";//request.getParameter("GdYear");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String CA = request.getParameter("CA");
String CACName = request.getParameter("CACName");
String CAEmpno = request.getParameter("CAEmpno");

String ShowPeople =request.getParameter("ShowPeople");
String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數


String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();
String acno = request.getParameter("acno").trim();

String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");
String pgroups    = request.getParameter("pgroups");
String fleet    = request.getParameter("fleet");

String bcolor=null;
String errMsg = "";
boolean status = false;

//String addSernList = request.getParameter("addSernList");
String addSern = request.getParameter("addSern");
String OsernList= request.getParameter("OsernList");
String[] delSern = request.getParameterValues("delSern");
String addSernList = "";
String ListAfterDel = null;
ArrayList crewObjList = (ArrayList)session.getAttribute("crewObjList");

if(delSern == null){

	errMsg ="尚未選擇要刪除的項目，請重新選擇"; 
}else{
status= true;
	//刪除組員
	for(int i=0;i<crewObjList.size();i++){
		fzac.CrewInfoObj o =(fzac.CrewInfoObj)crewObjList.get(i);
		for(int j=0;j<delSern.length;j++){
			if(o.getSern().equals(delSern[j])){
				crewObjList.remove(i);
				if(i != 0){
					i--;
				}
			}
		}
	}
	
	session.setAttribute("crewObjList",crewObjList);
	ArrayList sL = new ArrayList();
	for(int i=0;i<crewObjList.size();i++){
		fzac.CrewInfoObj o =(fzac.CrewInfoObj)crewObjList.get(i);
		sL.add(o.getSern());//刪除後的序號名單
	}
	//將sern串成OsernList ,format: '#####','#####'
	
	fz.pracP.ChangeType cht = new fz.pracP.ChangeType();
	ListAfterDel = cht.ArrayListToStirng(sL);		


}






%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>座艙長報告--刪除組員</title>
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
        <span class="txtblue">Purser's Report&nbsp; &nbsp;</span><span class="txtxred"><strong> Step1.Select Crew List(Add or Delete Crew List) </strong></span></td>
    </tr>
    <tr>
      <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
      <td valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2" valign="middle" class="txtblue">Purser:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></td>
      <td valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td valign="middle"  class="txtblue">A/C:<span class="txtred"><%=acno%></span></td>
      <td valign="middle">
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
		if("TVL".equals(oi.getDuty_cd()))
		{
		 tempstr = "(TVL)";
		}
		
	%>
  <tr bgcolor="<%=bcolor%>">
   <td valign="middle" class="tablebody">
        <input name="delSern" type="checkbox"  value="<%=oi.getSern()%>">
      </td>
      <td align="center" valign="middle" class="tablebody">&nbsp;
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=oi.getCname()%> <%=oi.getSpCode()%> <%=tempstr%>" name="cname"></td>
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
      <td width="43" height="51">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=crewObjList.size()%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input name="Score" type="button" class="addButton" onClick="this.disabled=1;preview('form1','edReportScore.jsp')" value="Score (Next)">        
        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno" value="Delete Selected" class="delButon" >
        <input type="hidden" name="dpt" value="<%=dpt%>">
        <input type="hidden" name="arv" value="<%=arv%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">
        <input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="addSernList" value="<%=addSernList%>">		
        <input type="hidden" name="OsernList" value="<%=ListAfterDel%>">
        <input type="hidden" name="CA" value="<%=CA%>">
        <input type="hidden" name="acno" value="<%=acno%>">
  		<input type="hidden" name="CACName" value="<%=CACName%>">
   		<input type="hidden" name="CAEmpno" value="<%=CAEmpno%>">
		<input type="hidden" name="total" value="<%=crewObjList.size()%>">		
        <input type="hidden" name="ShowPeople" value="<%=ShowPeople%>">
  		  <input type="hidden" name="f" value="<%=f%>">
   		  <input type="hidden" name="c" value="<%=c%>">
		  <input type="hidden" name="y" value="<%=y%>">
        <input type="hidden" name="fleet" value="<%=fleet%>">
		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
	      <input type="hidden" name="GdYear" value="<%=GdYear%>">
		  <input type="hidden" name="fleet" value="<%=fleet%>">

  		</span></td>
      <td width="44">
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
         <span class="txttitletop">&nbsp;&nbsp;&nbsp;
         <input type="reset" name="reset" value="Reset">
        </span></div>
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

