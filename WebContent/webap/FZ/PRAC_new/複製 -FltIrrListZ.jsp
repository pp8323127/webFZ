<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,
				java.net.URLEncoder,
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

//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fyy+"/"+fmm);


String fltno = request.getParameter("fltno");//.replace('Z', ' ').trim();

//Add by Betty on 2009/11/27
String isZ ="";
if(fltno.substring(fltno.length()-1).equals("Z"))
{
//�̫�@�X��Z�ɡA���ˬddelay�Z�����X
	isZ = "Y";
}
//*************************************************************

//���o���
fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo(fyy+"/"+fmm+"/"+fdd, fltno,true);
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


<body>
<%
if(!ft.isHasData()){
%>
<div class="errStyle1" >NO DATA!!</div>
<%
}
else if(dataAL.size() ==1 )
{//�Ȧ��@�Z�ɡAcheck�O�_�����Z���y����
	fz.prObj.FltObj obj = (fz.prObj.FltObj)dataAL.get(0);
	 fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fyy+"/"+fmm+"/"+fdd, obj.getFltno(),
								  obj.getDpt()+obj.getArv(),obj.getPurEmpno());

		try 
		{
			cflt.RetrieveData();
		} 
		catch (SQLException e) {} catch (Exception e) {}


	if(!sGetUsr.equals(obj.getPurEmpno()) &&!"Y".equals(isPowerUser)){//�D���Z���y����,��Dpoweruser
		
	%>
	<div class="errStyle1" >�D���Z���y����,���o���g���i!!</div>
	<%
	}else if(cflt.isHasFltData() && !cflt.isUpd()){

	%>
		<div class="errStyle1" >���i�w�e�X�A���o�A�ק�!!</div>
	<%
														
    }
	else
	{
		response.sendRedirect("edFltIrr.jsp?isZ=Y&fdate="+fyy+"/"+fmm+"/"+fdd+"&fltno="+obj.getFltno()+"&dpt="+obj.getDpt()+"&arv="+obj.getArv()+"&GdYear="+GdYear+"&acno="+obj.getAcno()+"&pur="+obj.getPurEmpno());

	}
}
//Betty add 
else
{//����Z��
//*********************************************************
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
<table width="60%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="11%" height="15" class="tablehead3">FDate      <br>
      </td>
    <td width="9%" class="tablehead3">Fltno</td>
    <td width="7%" class="tablehead3">Dpt</td>
    <td width="8%" class="tablehead3">Arv</td>
    <td width="16%" class="tablehead3">Start Time<br> 
      </td>
    <td width="16%" class="tablehead3">End Time </td>
    <td width="11%" class="tablehead3">Acno</td>
	<td width="9%" class="tablehead3">PurName</td>
    <td width="13%" class="tablehead3">Flt<br>
      Irregularity</td>
	</tr>
<%
for(int i=0;i<dataAL.size();i++)
{
	fz.prObj.FltObj obj = (fz.prObj.FltObj)dataAL.get(i);
	fzac.CrewInfoObj purCrewObj =obj.getPurCrewObj();
	if(i %2 ==1)
	{
		bgColor="#CCFFFF";
	}
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
    <td align="center" valign="middle" class="tablebody"><div align="center"><a href="edFltIrr.jsp?isZ=<%=isZ%>&fdate=<%=obj.getStdD()%>&fltno=<%=gf.getFltnoWithSuffix()%>&dpt=<%=obj.getDpt()%>&arv=<%=obj.getArv()%>&GdYear=<%=GdYear%>&acno=<%=obj.getAcno()%>&pur=<%=obj.getPurEmpno()%>" target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a></div></td>
	</tr>
  <%
	}

%>
</table>


</div>
<%
//*********************************************************************
}
%>
</body>
</html>
<%
}//end of has session value
%>