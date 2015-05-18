<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,
				java.net.URLEncoder,
				java.util.*,
				ci.db.*,
				ci.tool.*,
				fz.pracP.*,
				fz.prObj.*"
%>
<html>
<head> 
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style2.css" rel="stylesheet" type="text/css">
<link href="errStyle.css"  rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">

</script>
</head>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} else{

//�ˬd�O�_��Power user(�}�o�H��.groupId=CSOZEZ)
String  isPowerUser = (String)session.getAttribute("powerUser"); 
String bgColor = "#FFFFFF";


String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String fdd = request.getParameter("fdd");
//String mydate = fyy+"/"+fmm + "/" + fdd;
//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fyy+"/"+fmm + "/" + fdd);
boolean futureFlt = false;

//modify by Betty on 2009/11/27
String fltno = request.getParameter("fltno").replace('Z', ' ').trim();
//String fltno = request.getParameter("fltno").trim();

//�P�_��ܪ���Z�O�_������fly , �O-->�u�iPrint , ���O-->�iEdit & Print
//cs66 2006/2/20
GregorianCalendar curDate = new GregorianCalendar();
GregorianCalendar skjDate = new GregorianCalendar();
skjDate.set(Integer.parseInt(fyy) ,Integer.parseInt(fmm)-1,Integer.parseInt(fdd));

if(skjDate.after(curDate))
{ // �b�ثe�������,���o�s��
	futureFlt = true;
}


//���o���
fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo(fyy+"/"+fmm + "/" + fdd, fltno);
ArrayList dataAL = null;
try {
	ft.RetrieveData();
	dataAL = ft.getDataAL();

} catch (SQLException e) {
	System.out.println(e.toString());
} catch (Exception e) {
	System.out.println(e.toString());
}


%>


<body >
<%
if(!ft.isHasData())
{
%>
<div class="errStyle1" >NO DATA!!</div>
<%
}
else if(dataAL.size() ==1 )
{//�Ȧ��@�Z�ɡAcheck�O�_�����Z���y����
	fz.prObj.FltObj obj = (fz.prObj.FltObj)dataAL.get(0);
	 fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fyy+"/"+fmm+"/"+fdd, obj.getFltno(),
							  obj.getDpt()+obj.getArv(),obj.getPurEmpno());

		try {
			cflt.RetrieveData();
		} catch (SQLException e) {} catch (Exception e) {   }
		
	//���odelay�Z�����X
	fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fyy+fmm+fdd, fltno,obj.getDpt()+obj.getArv(),obj.getStdDt());

		

	if(!sGetUsr.equals(obj.getPurEmpno()) &&!"Y".equals(isPowerUser)){//�D���Z���y����,��Dpoweruser
		
	%>
	<div class="errStyle1" >�D���Z���ȿ��g�z,���o���g���i!!</div>
	<%
	}else if(cflt.isHasFltData() && !cflt.isUpd()){

	%>
		<div class="errStyle1" >���i�w�e�X�A���o�A�ק�!!</div>
	<%
														
    }else{

%>
<div align="center" class="txttitletop">
<table width="60%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="90%"> 
        <div align="center" class="txttitletop"> <%=fyy+fmm+fdd%>&nbsp; Fltno: <%=fltno%></div>
      </td>
    </tr>
    <tr>
      <td class="txtxred">
        <div align="right">�Z��ɶ����_��������a�ɶ� </div>
      </td>
    </tr>
  </table>
<table width="81%" border="0" cellpadding="0" cellspacing="0">
  <tr class="tablehead3">
    <td width="10%" height="15">FDate      <br>
      </td>
    <td width="9%">Fltno</td>
    <td width="7%">Dpt</td>
    <td width="8%">Arv</td>
    <td width="16%">Start Time<br> 
      </td>
    <td width="16%">End Time </td>
    <td width="11%">Acno</td>
	<td width="9%">CM_Name</td>
    <td width="9%">Flt<br>      Irregularity</td>
	<td width="5%" >Print</td>
	</tr>


<%
//�u���@����Ʈ�
	fz.prObj.FltObj obj1 = (fz.prObj.FltObj)dataAL.get(0);
	fzac.CrewInfoObj purCrewObj =obj.getPurCrewObj();

//���o�y��������m�W
aircrew.CrewCName cc = new aircrew.CrewCName();
purCrewObj.setCname(cc.getCname(obj.getPurEmpno()));		


%>
  <tr bgcolor="#FFFFFF">
    <td class="tablebody"><%=obj1.getStdD()%></td>
    <td class="tablebody"><%=gf.getFltnoWithSuffix()%></td>
    <td class="tablebody"><%=obj1.getDpt()%></td>
    <td class="tablebody"><%=obj1.getArv()%></td>
    <td class="tablebody"><%=obj1.getStdDt()%></td>
    <td class="tablebody"><%=obj1.getEndDt()%></td>
    <td class="tablebody"><%=obj1.getAcno()%></td>
	<td class="tablebody"><%=purCrewObj.getCname()%></td>
	 <td align="center" valign="middle" class="tablebody"><div align="center">
	<%
	if(!futureFlt)
	{
	%>	
   <a href="checkflt.jsp?fdate=<%=obj1.getStdD()%>&fltno=<%=gf.getFltnoWithSuffix()%>&dpt=<%=obj1.getDpt()%>&arv=<%=obj1.getArv()%>&pxac=<%=obj1.getPxac()%>&book_total=<%=obj1.getBook_total()%>&acno=<%=obj1.getAcno()%>&f=<%=obj1.getActualF()%>&c=<%=obj1.getActualC()%>&y=<%=obj1.getActualY()%>&GdYear=<%=GdYear%>&purserEmpno=<%=obj1.getPurEmpno()%>&purname=<%=URLEncoder.encode(purCrewObj.getCname())%>&pursern=<%=purCrewObj.getSern()%>&pgroups=<%=purCrewObj.getGrp()%>" target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a>
	<%
	}
	else
	{
		out.print("X");
	}
	%>
	</div></td>
<td align="center" valign="middle" class="tablebody"><div align="center">
<a href="printrpt.jsp?fdate=<%=obj1.getStdD()%>&fltno=<%=gf.getFltnoWithSuffix()%>&dpt=<%=obj1.getDpt()%>&arv=<%=obj1.getArv()%>&pxac=<%=obj1.getPxac()%>&book_total=<%=obj1.getBook_total()%>&acno=<%=obj1.getAcno()%>&f=<%=obj1.getActualF()%>&c=<%=obj1.getActualC()%>&y=<%=obj1.getActualY()%>&GdYear=<%=GdYear%>" target="_self"><img src="../images/print.gif"  border="0" alt="Print Report"></a></div></td>	
	</tr>
</table>

<table width="72%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td class="txtblue"><br>
      Click <img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report">to Edit Report<br> 
      Click <img src="../images/print.gif"  border="0" alt="Print Report"> to print blank report with crew list. </td>
  </tr>
</table>
</div>
<%

	
	}

}else{//���ⵧ�H�W���
%>
<div align="center" class="txttitletop">

<table width="60%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="90%"> 
        <div align="center" class="txttitletop"> <%=fyy+fmm+fdd%>&nbsp; Fltno: <%=fltno%></div>
      </td>
    </tr>
    <tr>
      <td class="txtxred">
        <div align="right">�Z��ɶ����_��������a�ɶ� </div>
      </td>
    </tr>
  </table>
<table width="81%" border="0" cellpadding="0" cellspacing="0">
  <tr class="tablehead3">
    <td width="10%" height="15">FDate      <br>
      </td>
    <td width="9%">Fltno</td>
    <td width="7%">Dpt</td>
    <td width="8%">Arv</td>
    <td width="16%">Start Time<br> 
      </td>
    <td width="16%">End Time </td>
    <td width="11%">Acno</td>
	<td width="9%">CM_Name</td>
    <td width="9%">Flt<br>      Irregularity</td>
	<td width="5%" >Print</td>
	</tr>


<%
for(int i=0;i<dataAL.size();i++){
	fz.prObj.FltObj obj = (fz.prObj.FltObj)dataAL.get(i);
	fzac.CrewInfoObj purCrewObj =obj.getPurCrewObj();
	if(i %2 ==1){
		bgColor="#CCFFFF";
	}
//���o�y��������m�W
aircrew.CrewCName cc = new aircrew.CrewCName();
purCrewObj.setCname(cc.getCname(obj.getPurEmpno()));		

	//���odelay�Z�����X
	fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fyy+fmm+fdd, fltno, obj.getDpt()+obj.getArv(),
			obj.getStdDt());


%>
  <tr bgcolor="<%=bgColor%>">
    <td class="tablebody"><%=obj.getStdD()%></td>
    <td class="tablebody"><%=gf.getFltnoWithSuffix()%></td>
    <td class="tablebody"><%=obj.getDpt()%></td>
    <td class="tablebody"><%=obj.getArv()%></td>
    <td class="tablebody"><%=obj.getStdDt()%></td>
    <td class="tablebody"><%=obj.getEndDt()%></td>
    <td class="tablebody"><%=obj.getAcno()%></td>
	<td class="tablebody"><%=purCrewObj.getCname()%></td>
	 <td align="center" valign="middle" class="tablebody"><div align="center">
	<%
	if(!futureFlt){
	%>

	
   <a href="checkflt.jsp?fdate=<%=obj.getStdD()%>&fltno=<%=gf.getFltnoWithSuffix()%>&dpt=<%=obj.getDpt()%>&arv=<%=obj.getArv()%>&pxac=<%=obj.getPxac()%>&book_total=<%=obj.getBook_total()%>&acno=<%=obj.getAcno()%>&f=<%=obj.getActualF()%>&c=<%=obj.getActualC()%>&y=<%=obj.getActualY()%>&GdYear=<%=GdYear%>&purserEmpno=<%=obj.getPurEmpno()%>&purname=<%=URLEncoder.encode(purCrewObj.getCname())%>&pursern=<%=purCrewObj.getSern()%>&pgroups=<%=purCrewObj.getGrp()%>&stdDt=<%=obj.getStdDt()%>" target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a>
	<%
	}
	else{
		out.print("X");
	}
	%>
	</div></td>
<td align="center" valign="middle" class="tablebody"><div align="center">
<a href="printrpt.jsp?fdate=<%=obj.getStdD()%>&fltno=<%=gf.getFltnoWithSuffix()%>&dpt=<%=obj.getDpt()%>&arv=<%=obj.getArv()%>&pxac=<%=obj.getPxac()%>&book_total=<%=obj.getBook_total()%>&acno=<%=obj.getAcno()%>&f=<%=obj.getActualF()%>&c=<%=obj.getActualC()%>&y=<%=obj.getActualY()%>&GdYear=<%=GdYear%>" target="_self"><img src="../images/print.gif"  border="0" alt="Print Report"></a></div></td>	
	</tr>
	
  <%
	}

%>
</table>


<table width="72%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td class="txtblue"><br>
      Click <img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report">to Edit Report<br> 
      Click <img src="../images/print.gif"  border="0" alt="Print Report"> to print blank report with crew list. </td>
  </tr>
</table>
</div>
<%
}//end of has data
%>

</body>
</html>
<%
}//end of has session value
%>