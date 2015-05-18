<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,fz.pracP.dispatch.*,java.net.URLEncoder,java.util.ArrayList"%>

<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
String occu = (String)session.getAttribute("occu");

String GdYear = request.getParameter("GdYear");

String addSernList = "";
ArrayList OSernAList = new ArrayList();	//�s�J��Z���쥻���խ�
ArrayList crewObjList = new ArrayList();
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt");
String arv =request.getParameter("arv");
String debugstr = "";

String stdDt = null;
if("".equals(request.getParameter("stdDt")) | null == request.getParameter("stdDt")  | "null".equalsIgnoreCase(request.getParameter("stdDt")) )
{
	stdDt = null;
}
else
{
	stdDt = request.getParameter("stdDt");
}

GetFltInfo ft = new GetFltInfo(fdate, fltno);

//FlightCrewList fcl = new FlightCrewList(ft,dpt+arv);
FlightCrewList fcl = new FlightCrewList(ft,dpt+arv,stdDt);

fzac.CrewInfoObj caObj = null;
fz.prObj.FltObj fltObj 	= null;
fzac.CrewInfoObj purObj = new fzac.CrewInfoObj();
purObj.setGrp(request.getParameter("pgroups"));
purObj.setCname(request.getParameter("purname"));
purObj.setEmpno(request.getParameter("purserEmpno"));
purObj.setSern(request.getParameter("pursern"));
fzac.CrewInfoObj mpObj = new fzac.CrewInfoObj();;//�ժ�

//****************************************************************
//If �u��
FlexibleDispatch fd = new FlexibleDispatch();
boolean iflessdisp = true;
iflessdisp = fd.ifFlexibleDispatch(fdate,fltno, dpt+arv,sGetUsr);
String tempfltno = "";
String tempfleet = fd.getFleetCd();
if(fltno.length()>= 4)
{
	tempfltno = fltno.substring(1,4);
}
else
{
	tempfltno = fltno;
}
//****************************************************************

String bcolor = "";
String errMsg = "";
boolean status = false;
try
{
	fcl.RetrieveData();
	OSernAList = fcl.getCrewSernList();	//�խ��Ǹ��W��
	crewObjList = fcl.getCrewObjList();	//�խ���ƦW��
	session.setAttribute("crewObjList",crewObjList);
	
	caObj =  fcl.getCAObj(); //CA ���
	fltObj= fcl.getFltObj();	//��Z���
	//purObj = fcl.getPurCrewObj();	//Purser���
	mpObj = fcl.getMpCrewObj();//�ժ�
	/*if(mpObj!=null){
	out.println("mpObj");
	mpObj.setCname("XXX");
    mpObj.setEmpno("654987");
    
	out.println(mpObj.getCname());	
	out.println(mpObj.getEmpno());
    }*/
	//20140124 sharon add
	if(null!=crewObjList){
		for(int i=0;i<crewObjList.size();i++)
		{
			fzac.CrewInfoObj o =(fzac.CrewInfoObj)crewObjList.get(i);
			if(o.getEmpno().equals(purObj.getEmpno())){
				crewObjList.remove(i);
			}
		}
	
	}
	
	//=============================
	if(fltObj == null)
	{		
		errMsg="�d�L�ӯ�Z�A�Э��s�d��!!";
	}/*else if("N".equals((String)session.getAttribute("powerUser")) &&!purObj.getEmpno().equals(sGetUsr)){
		
		errMsg="�D���Z���y����"+purObj.getEmpno()+"�A�Э��s��J";
	}*/
	else if(crewObjList == null)
	{
		errMsg = "���Z���ثe�|�L�խ��W��";
	}
	else
	{
		status = true;
	}

	if(caObj == null)
	{
		caObj = new fzac.CrewInfoObj();
		caObj.setEmpno(" ");
		caObj.setCname(" ");
		caObj.setEname(" ");
	}
} 
catch (Exception e) 
{
	errMsg = e.toString();
	out.print("EDCREW "+errMsg);	
}



//�Nsern�ꦨOsernList ,format: '#####','#####'

fz.pracP.ChangeType cht = new fz.pracP.ChangeType();
String OsernList = cht.ArrayListToStirng(OSernAList);		//��l�խ��M��

%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s��ȿ����i</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="checkDel.js" type="text/javascript"></script>
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>
<body >
<%
if(!status)
{
%>
<div class="txtxred" style="text-align:center "><%=errMsg%></div>
<%
}
else
{
	
	if(occu.equals("ZC") | occu.equals("PU")){
		%>
		<div style="text-align:center; background-color: #FFFF66; font-size: 16px; color: #FF0000;"><strong>**Training MC ��gCabin Report.�U��խ��W��Х��R���ۤv���u��,�H�K����**</strong></div>
		<%
	}
%>

<form name="form1" method="post" action="edCrewDel.jsp" target="_self" onSubmit="return del('form1','delSern')">
  <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td colspan="3" valign="middle">
        <div align="center" class="txtred"></div>
      
        <span class="txtblue">Cabin  Report&nbsp;       <strong>&nbsp;</strong></span><span class="txtxred"><strong> Step1.Select Crew List(Add or Delete Crew List) </strong></span></td>
    </tr>
    <tr>
      <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
      <td width="62" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3" valign="middle" class="txtblue">Cabin Manager:<span class="txtred"><%=purObj.getCname()%>&nbsp;<%=purObj.getSern()%>&nbsp;<%=purObj.getEmpno()%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=caObj.getEmpno()+"&nbsp;"+caObj.getCname()+"&nbsp;"+caObj.getEname()%></span></td>
    </tr>
   <%
   if(mpObj != null){
    %>
    <tr>
      <td colspan="3" valign="middle" class="txtblue">MP:<span class="txtred"><%=mpObj.getCname()%>&nbsp;<%=mpObj.getSern()%>&nbsp;<%=mpObj.getEmpno()%></span></td>
    </tr>
 	<%
 	}
  	%>
</table> 
  <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
	 <td width="70">Select</td>
      <td width="123">Name</td>
      <td width="237">EName</td>
      <td width="51">Sern</td>
      <td width="58">Empno</td>
      <td width="31">Occu</td>
    </tr>
	<%
	for(int i=0;i<crewObjList.size();i++)
	{
		fzac.CrewInfoObj o =(fzac.CrewInfoObj)crewObjList.get(i);
		if(i%2 ==0)
		{
			bcolor="#99CCFF";
		}
		else
		{
			bcolor="#FFFFFF";
		}
		
		String tempstr = "";
		//tempstr = "<font color = 'red'>("+o.getDuty_cd()+")</font>";
		if(!"FLY".equals(o.getDuty_cd()))
		{
		 tempstr = "<font color = 'red'>(TVL)</font>";
		}

	%>
  <tr bgcolor="<%=bcolor%>">
   <td valign="middle" class="tablebody">
        <input name="delSern" type="checkbox"  value="<%=o.getSern()%>">
      </td>
      <td align="center" valign="middle" class="tablebody">&nbsp;
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=o.getCname()%> <%=o.getSpCode()%> " name="cname"><%=tempstr%></td>
      <td valign="middle" class="tablebody">
        <div align="left">&nbsp;
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=o.getEname()%>" name="ename"></div>
      </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=o.getSern()%>" name="sern">
	  </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=o.getEmpno()%>" name="empno">
	  </td>
      <td valign="middle" class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="2" value="<%=o.getOccu()%>" name="occu" >
	  </td>
    </tr>
	<%
	}
	
	
	%>
  </table>
<%
if(occu.equals("ZC") | occu.equals("PU")){
		%>
		<div style="text-align:center; background-color: #FFFF66; font-size: 16px; color: #FF0000;"><strong>**Training MC ��gCabin Report.�W��խ��W����R���ۤv���u��,�H�K����**</strong></div>
		<%
	}
%>

  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43" height="53">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=crewObjList.size()%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input type="button" name="Score" value="Score (Next)" onClick="this.disabled=1;preview('form1','edReportScore.jsp')" class="addButton">
        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno2" value="Delete Selected" class="delButon" >
        <span class="txtblue">
		  <input type="hidden" name="dpt" value="<%=dpt%>">
		  <input type="hidden" name="arv" value="<%=arv%>">
		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="stdDt" value="<%=stdDt%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		  <input type="hidden" name="OsernList" value="<%=OsernList%>">
		  <input type="hidden" name="addSernList" value="<%=addSernList%>">
		  <input type="hidden" name="CA" value="<%=caObj.getEmpno()+"&nbsp;"+caObj.getCname()+"&nbsp;"+caObj.getEname()%>">
		  <input type="hidden" name="acno" value="<%=fltObj.getAcno()%>">
  		  <input type="hidden" name="CACName" value="<%=caObj.getCname()%>">
   		  <input type="hidden" name="CAEmpno" value="<%=caObj.getEmpno()%>">
		  <input type="hidden" name="total" value="<%=crewObjList.size()%>">
		  <input type="hidden" name="fleet" value="<%=tempfleet%>">
<%
if (iflessdisp== true)
{
%>
		  <input type="hidden" name="ShowPeople" value="0">
  		  <input type="hidden" name="f" value="0">
   		  <input type="hidden" name="c" value="0">
		  <input type="hidden" name="y" value="0">
<%
}			
else
{
%>
		  <input type="hidden" name="ShowPeople" value="<%=fltObj.getBook_total()%>">
  		  <input type="hidden" name="f" value="<%=fltObj.getActualF()%>">
   		  <input type="hidden" name="c" value="<%=fltObj.getActualC()%>">
		  <input type="hidden" name="y" value="<%=fltObj.getActualY()%>">
<%
}	
%>
		  <input type="hidden" name="purserEmpno" value="<%=purObj.getEmpno()%>">
		  <input type="hidden" name="psrsern" value="<%=purObj.getSern()%>">
		  <input type="hidden" name="psrname" value="<%=purObj.getCname()%>">
		  <input type="hidden" name="pgroups" value="<%=purObj.getGrp()%>">
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
		  <% if(mpObj != null){ %>
		  <input type="hidden" name="mp_empn" value="<%=mpObj.getEmpno()%>">
		  <input type="hidden" name="mpname" value="<%=mpObj.getCname()%>">
		  <%} %>
        </span> </span></td>
      <td width="44">
      </td>
    </tr>
</table>

  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="5%">&nbsp;</td>
      <td width="90%">
        <div align="left" class="txtblue">Insert Crew's Sern�G
          <input type="text" name="addSern" size="5" maxlength="5">
     	   <input type="button" name="Submit2" value="Add"  onClick="checkAdd('form1','addSern','edCrewAdd.jsp')">
        <span class="txttitletop">&nbsp;&nbsp;&nbsp;        </span></div>
      </td>
      <td width="5%">
      </td>
    </tr>
</table>

</form>

<%
}//end of no exeception
%>
</body>
</html>
<SCRIPT type="text/javascript" language="JavaScript">
  addFocus();
  function addFocus()
  {
        //  document.getElementById('addSernSub').focus();
      }
</SCRIPT>

