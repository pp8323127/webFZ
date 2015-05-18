<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder,fz.*,java.util.*, fz.psfly.*,fz.projectinvestigate.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String yy = request.getParameter("yy");
String mm = request.getParameter("mm");

//�ˬd�Z��O�_����
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yy, mm);

if(!pc.isPublished()){
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=yy+"/"+mm%>�Z��|���������G!!
</div>
<%
}
else
{
String psrCName = null;
String psrEname = null;
String psrSern = null;

String fdate 	= null;
String fltno 	= null;//��Ʈw����X�Ӫ�fltno
String sect 	= null;
String flag = null;	//Y: �����i N:�L���i
String upd = null;	//Y:���i�i�A�s�� N:���i���i�A�s��
String updStr = null;
String dd = null;
String GdYear = null;
String bgColor = null;
String matchStr = "";
String rj = null;
ArrayList scheAL = new ArrayList();	//�x�s���i in egtcflt
ArrayList updAL = new ArrayList();//�x�s���i�����A(Y: �i�s��AN: ���i�s��)
ArrayList reject = new ArrayList(); //���i�O�_�Q�h�^

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String scheSql = null;
int rowCount = 0;
ArrayList fdateAL = new ArrayList();
ArrayList fltnoAL = new ArrayList();
ArrayList sectAL = new ArrayList();
ArrayList acnoAL = new ArrayList();

ConnDB cn = new ConnDB();
ConnAOCI cna = new ConnAOCI();
try
{
	//����y�������ӤH���(orp3..fztcrew)
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
	sql = "select name cname,ename,box from fztcrew where empno='"+ sGetUsr+"'";
	rs = stmt.executeQuery(sql);
	
	if(rs.next()){
		psrCName = rs.getString("cname");
		psrEname = rs.getString("ename");
		psrSern = rs.getString("box");
	}
}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

//1.����cflt,��JarrayList
try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
		
//TODO ���sql
if(sGetUsr.equals("640073") || sGetUsr.equals("638716"))
{	//���ե�sql
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'&nbsp;') reject "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"AND      Last_Day(To_Date('"+yy+mm+"','yyyymm'))";
}
else
{	//�H�U����������sql
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,acno,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'&nbsp;') reject "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"AND      Last_Day(To_Date('"+yy+mm+"01 2359','yyyymmdd hh24mi'))  AND psrempn='"+sGetUsr+"'";
}

rs = stmt.executeQuery(sql);
if(rs!= null)
{
	while (rs.next()) 
	{
		scheAL.add(rs.getString("fdate").trim() + "," + rs.getString("fltno").trim()+ "," + rs.getString("sect").trim());
		updAL.add(rs.getString("upd"));
		reject.add(rs.getString("reject"));
		fdateAL.add(rs.getString("fdate").trim());
		fltnoAL.add(rs.getString("fltno"));
		sectAL.add(rs.getString("sect"));
		acnoAL.add(rs.getString("acno"));
		rowCount ++;
	}
}
}
catch (Exception e)
{
	
	  out.print("error 1 : "+e.toString() + sql);
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

try
{
//��AOCIPROD  �Ӥ�duty��Pusrser���Z��

cna.setAOCIFZUser();
java.lang.Class.forName(cna.getDriver());
conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(),
	cna.getConnPW());
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);


if("640790".equals(sGetUsr) || "638716".equals(sGetUsr) )
{	//���եΡA�]�w���u����627536

	sql = "select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt,"
		+"dps.duty_cd dutycd, dps.port_a dpt,dps.port_b arv,r.acting_rank qual "
	   +"from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num "
	   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	   +"and r.staff_num ='627536' AND dps.act_str_dt_tm_gmt BETWEEN  "
	   +"to_date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') AND "
	   +"Last_Day( To_Date('"+yy+mm+"01 23:59','yyyymmdd hh24:mi')) "
	   +"AND dps.duty_cd='FLY' AND  r.acting_rank='PR' order by str_dt_tm_gmt";

}
else
{
/*
	sql = "SELECT fdate,dutycode fltno,dpt,arv FROM "+ct.getTable()+
	" WHERE empno='"+sGetUsr+"' AND substr(fdate,1,7) = '"+yy+"/"+mm+"' "+
	"AND SubStr(Trim(qual),1,1) ='P' and spcode not in ('I','S') and dh <> 'Y' AND dpt <> ' '";
	*/
	sql = "select dps.duty_cd,to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt,"
		+"dps.port_a dpt,dps.port_b arv,r.acting_rank qual "
	   +"from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num "
	   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	   +"and r.staff_num ='"+sGetUsr+"' AND dps.act_str_dt_tm_gmt BETWEEN  "
	   +"to_date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') AND "
	   +"Last_Day( To_Date('"+yy+mm+"01 23:59','yyyymmdd hh24:mi')) "
	   +"AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') AND  r.acting_rank='PR' order by str_dt_tm_gmt";
}

//out.println(sql);
rs = stmt.executeQuery(sql);
rowCount = 0;
if(rs.next())
{//��X��Ƶ���
	rs.last();
	rowCount = rs.getRow();
	rs.beforeFirst();
}

if(rowCount ==0 )
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	out.print("�d�L���<br>No DATA!!");
	
}
else
{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�y�������i --���v���</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function viewCrewList(year,month,day,fltno,sect){
	document.getElementById("yy").value = year;
	document.getElementById("mm").value = month;
	document.getElementById("dd").value = day;
	document.getElementById("fltno").value = fltno;
	document.getElementById("sect").value = sect;
	subwinXY('../blank.htm','crewList','1000','800');
	document.form1.target="crewList";
	document.form1.submit();
}
</script>

</head>
<body onLoad="showAlt()">
<form method="post" name="form1" action="preCrewList.jsp">
	<input type="hidden" name="yy">
	<input type="hidden" name="mm">
	<input type="hidden" name="dd">
	<input type="hidden" name="fltno">
	<input type="hidden" name="sect">
</form>
<div align="center">
  <span class="txttitletop">Pursers' Report List --<%=yy+"/"+mm%> </span> 
  <table border="0" width="72%" align="center" cellpadding="2" cellspacing="0">
   <tr >
    <td width="16%" height="23" class="txtblue" >Empno:<%=sGetUsr%></td>
    <td width="24%" class="txtblue">Name:<%=psrCName%></td>
    <td width="29%"  class="txtblue">EName:<%=psrEname%></td>
    <td width="31%"  class="txtblue">Sern:<%=psrSern%></td>
  </tr>
 </table> 
<table width="72%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="15%">Fdate</td>
    <td width="10%">Fltno</td>
    <td width="10%">Sect</td>
    <td width="20%">Modifiable Status </td>
    <td width="13%">View/Edit</td>
	<td width="12%">Crew List</td>
	<td width="10%">PSfly</td>
	<td width="10%">Proj</td>
  </tr>
  <%
	if(rs != null)
	{
		while(rs.next())
		{
		boolean isZ = false;
		fdate 	= rs.getString("fdate");
		dd	= fdate.substring(8);
		
	//���odelay�Z�����X GetFltnoWithSuffix(String flightDate, String fltno, String sector,String actualDepatureDateTime)
	
	fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate.substring(0,4)+fdate.substring(5,7)+fdate.substring(8),		 rs.getString("fltno"), rs.getString("dpt")+rs.getString("arv"),rs.getString("stdDt"));

	if(rs.getString("fltno").substring(rs.getString("fltno").length()-1).equals("Z"))
	{
	//�̫�@�X��Z�ɡA���ˬddelay�Z�����X
		isZ = true;
	}	

	//fltno 	= rs.getString("fltno").trim();
	fltno = gf.getFltnoWithSuffix();
	sect = rs.getString("dpt").trim()+rs.getString("arv").trim();
	matchStr = fdate+","+fltno+","+sect;

	if(!scheAL.isEmpty())
	{
		for (int i = 0; i < scheAL.size(); i++) 
		{
			if(((String)scheAL.get(i)).equals(matchStr)  )
			{
				flag="Y";//�w�s��L���i
				upd = (String)updAL.get(i);					
				rj = (String)reject.get(i);
				//match���ܡC��qEG��X�Ӫ����set null
				updAL.set(i,null);
				reject.set(i,null);
				fdateAL.set(i,null);
				fltnoAL.set(i,null);
				sectAL.set(i,null);
				acnoAL.set(i,null);
				
				if("Y".equals(rj)) rj = "Reject";
				break;
			}
			else
			{
				flag = "N";
				upd  = "N";
				rj = "&nbsp;";
			}
		}
	}
	else
	{
		flag="N";//�٥��s��
	}

	if("Y".equals(flag))
	{	//�w�s��L���i
		if("Y".equals(upd) )
		{	//���i���i�ק�
			updStr="<font color=blue>YES(�i�ק�)"+rj+"</font>";
		}
		else
		{	//���i�w�e�X�A���i�ק�
			updStr="NO(���i�ק�)";
		}
	}
	else
	{	//�|���s��L���i
		updStr = "<font color=red>NONE(�|���s��)</font>";
	}
	

  	if((rs.getRow())%2 == 0)
	{
		bgColor = "#CCCCCC";
	}
	else
	{
		bgColor = "#FFFFFF";
	}
	
  %>
  <tr class="tablebody" bgcolor="<%=bgColor%>">
    <td height="28" class="tablebody"><%=fdate %></td>
    <td class="tablebody">
	<%
	if(isZ)
	 {
	//�s�h�s��
		out.print(rs.getString("fltno")	);
	}
	else
	{
		out.print(fltno);
	}

	if("TVL".equals(rs.getString("duty_cd")))
	{
		out.print("&nbsp;<span style=\"color:#FF0000;\">TVL</span>");
	}
	
	%>
	</td>
    <td class="tablebody" ><%=sect %></td>
    <td class="tablebody"><%=updStr%></td>
    <td class="tablebody">
	<%
	
 //1.�w�s��L���i�A���|���e�X�A��2.�|���s��L���i-->�s���ܽs�誺�e��
	if(( "Y".equals(flag) && "Y".equals(upd))|| "N".equals(flag) )
	{	
		//11~12��A���Z��U�@�~�ת�
		if(fdate.substring(5,7).equals("11") ||fdate.substring(5,7).equals("12"))
		{	
			GdYear =(Integer.toString((Integer.parseInt(fdate.substring(0,4))+1) ));
		}
		else
		{
			GdYear = fdate.substring(0,4);
		}
		String tempAlertOfTVL = "";
		if("TVL".equals(rs.getString("duty_cd")))
		{
			tempAlertOfTVL=" onClick='javascript:alert(\"�D���Z��Duty�y����,�ФŶi�J�s����i!!\");' ";
		}

		if(isZ)
		{
	%>
		<a href="FltIrrListZ.jsp?fyy=<%=fdate.substring(0,4)%>&fmm=<%=fdate.substring(5,7)%>&fdd=<%=dd%>&fltno=<%=rs.getString("fltno")%>&GdYear=<%=GdYear%>" <%=tempAlertOfTVL%> target="_self">
	<%		
		}
		else
		{
	%>
		<a href="FltIrrList.jsp?fyy=<%=fdate.substring(0,4)%>&fmm=<%=fdate.substring(5,7)%>&fdd=<%=dd%>&fltno=<%=fltno%>&GdYear=<%=GdYear%>" target="_self" <%=tempAlertOfTVL%>>
		<%
		}//end of fltno is not Z 
	%>
		<img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="Edit Report" alt="Edit Report"></a>
	<%
	}//if(( "Y".equals(flag) && "Y".equals(upd))|| "N".equals(flag) )
	//�w�s��L���i�B�w�e�X�A���i�A�s��-->�s��report�e��
	else if( ("Y".equals(flag) && "N".equals(upd)) )
	{
	%>
	<a href="PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>" target="_blank">
	<img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="View Report" alt="View Report"></a><br>	
	<%
	}
	%>	
	</td>
	<td class="tablebody"><a href="javascript:viewCrewList('<%=fdate.substring(0,4)%>','<%=fdate.substring(5,7)%>','<%=fdate.substring(8)%>','<%=fltno%>','<%=sect%>');"><img src="../images/format-justify-fill.png" width="16" height="16" border="0" alt="Print Crew List" title="Print Crew List"></a>
	</td>
	<!--�ۧڷ���-->
	<td class="tablebody">
<%
	//�O�_�ݶ�ۧڷ���
	boolean needfill = false;
	PRSFlyIssue psf = new PRSFlyIssue();
    psf.getPsflyTopic_no(fdate, fltno, sect.substring(0,3), sect.substring(3),sGetUsr,"","") ;
	//out.println(fdate+"  "+fltno+"  "+sect.substring(0,3)+"  "+sect.substring(3)+"  "+sGetUsr);
	if(psf.getTopic_noAL().size()>0)
	{
		needfill = true;
	}


	//�w�s��L���i�B�w�e�X�A���i�A�s��  flag �N���L���i
	if("Y".equals(flag) && "N".equals(upd)) 	
	{
		if(needfill==true)
		{
%>
		 <a href="PSFLY/viewPSFLY.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View PSFLY">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(upd))
	{
		if(needfill==true)
		{
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
%>
		 <a href="PSFLY/edPSFLY.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit PSFLY">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else if("N".equals(flag))
	{
		if(needfill==true)
		{
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
%>
		 <a href="PSFLY/prePSFLY.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="PSFLY Requested">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>
	</td>
	<!--�M�׽լd-->
	<td class="tablebody">
<%
	//�O�_�ݶ�M�׽լd
	boolean pjneedfill = false;
	PRPJIssue pj = new PRPJIssue();
    pj.getPRProj_no(fdate, fltno, sect.substring(0,3), sect.substring(3),sGetUsr,"","") ;
	//out.println(fdate+"  "+fltno+"  "+sect.substring(0,3)+"  "+sect.substring(3)+"  "+sGetUsr);
	if(pj.getProj_noAL().size()>0)
	{
		pjneedfill = true;
	}


	//�w�s��L���i�B�w�e�X�A���i�A�s��  flag �N���L���i
	if("Y".equals(flag) && "N".equals(upd)) 	
	{
		if(pjneedfill==true)
		{
%>
		 <a href="ProjInvestigation/viewProj.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View ProjInvestigation">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(upd))
	{
		if(pjneedfill==true)
		{
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}

%>
		 <a href="ProjInvestigation/edProj.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit ProjInvestigation">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else if("N".equals(flag))
	{
		if(pjneedfill==true)
		{
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
%>
		 <a href="ProjInvestigation/preProj.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="ProjInvestigation Requested">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>
	</td>
  </tr>
<%
		}
	}
	//**************************************************************************
	for(int i=0;i<fdateAL.size();i++)
	{
		updStr = "";
		GdYear="";
		if(fdateAL.get(i) != null)
		{		
			if("Y".equals(updAL.get(i)) )
			{	//���i���i�ק�
				updStr="<font color=blue>YES(�i�ק�)"+rj+"</font>";
			}
			else
			{	//���i�w�e�X�A���i�ק�
				updStr="NO(���i�ק�)";
			}
		
		//11~12��A���Z��U�@�~�ת�
		if(((String)fdateAL.get(i)  ).substring(5,7).equals("11") ||((String)fdateAL.get(i)  ).substring(5,7).equals("12"))
		{	
			GdYear =(Integer.toString((Integer.parseInt(((String)fdateAL.get(i)  ).substring(0,4))+1) ));
		}
		else
		{
			GdYear = ((String)fdateAL.get(i)  ).substring(0,4);
		}
%>
  <tr class="tablebody" bgcolor="#FFFFCC" >
    <td height="28" class="tablebody"><%=fdateAL.get(i)  %></td>
    <td class="tablebody"><%=fltnoAL.get(i) %></td>
    <td class="tablebody"><%=sectAL.get(i)  %></td>
    <td class="tablebody"><%=updStr%></td>
    <td class="tablebody">
	
	<%
	if("Y".equals(updAL.get(i)) )
	{//���i���i�ק�
	%>
	<a href="edFltIrr.jsp?fdate=<%=fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&dpt=<%=((String)sectAL.get(i)).substring(0,3)%>&arv=<%=((String)sectAL.get(i)).substring(3)%>&GdYear=<%=GdYear%>&acno=<%=acnoAL.get(i)%>&pur=<%=sGetUsr%>" target="_self">
	<img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="Edit Report" alt="Edit Report"></a>
	<%	
	}
	else
	{//view
%>
	<a href="PURreport_print.jsp?fdate=<%=fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&section=<%=sectAL.get(i)%>" target="_blank">
	<img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="View Report" alt="View Report"></a><br>
<%	
	}
%>
</td>
<td class="tablebody"><a href="javascript:viewCrewList('<%=((String)fdateAL.get(i)).substring(0,4)%>','<%=((String)fdateAL.get(i)).substring(5,7)%>','<%=((String)fdateAL.get(i)).substring(8)%>','<%=fltnoAL.get(i)%>','<%=sectAL.get(i)%>');"><img src="../images/format-justify-fill.png" width="16" height="16" border="0" alt="Print Crew List" title="Print Crew List"></a></td>
<!--Add-->
	<!--�ۧڷ���-->
	<td>
<%
	//�O�_�ݶ�ۧڷ���
	boolean needfill = false;
	PRSFlyIssue psf = new PRSFlyIssue();
	if (fdateAL.size()>0)
	{				
		psf.getPsflyTopic_no((String)fdateAL.get(i), (String)fltnoAL.get(i), ((String)sectAL.get(i)).substring(0,3), ((String)sectAL.get(i)).substring(3),sGetUsr,"","") ;
		//psf.getPsflyTopic_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
		//out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
		if(psf.getTopic_noAL().size()>0)
		{
			needfill = true;
		}
    }
	//�w�s��L���i�B�w�e�X�A���i�A�s��  flag �N���L���i
	if("Y".equals(flag) && "N".equals(updAL.get(i))) 	
	{
		if(needfill==true)
		{
%>
		 <a href="PSFLY/viewPSFLY.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View PSFLY">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(updAL.get(i))) 
	{
		if(needfill==true)
		{
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
%>
		 <a href="PSFLY/edPSFLY.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit PSFLY">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else
	{
		if(needfill==true)
		{
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
%>
		 <a href="PSFLY/prePSFLY.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="PSFLY Requested">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>
	</td>
<!--Add-->
<!--Add-->
	<!--�M�׽լd-->
	<td class="tablebody">
<%
	//�O�_�ݶ�M�׽լd
	boolean pjneedfill = false;
	PRPJIssue pj = new PRPJIssue();
	if (fdateAL.size()>0)
	{				
		pj.getPRProj_no((String)fdateAL.get(i), (String)fltnoAL.get(i), ((String)sectAL.get(i)).substring(0,3), ((String)sectAL.get(i)).substring(3),sGetUsr,"","") ;
		//pj.getPRProj_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
		//out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
		if(pj.getProj_noAL().size()>0)
		{
			pjneedfill = true;
		}
    }
	//�w�s��L���i�B�w�e�X�A���i�A�s��  flag �N���L���i
	if("Y".equals(flag) && "N".equals(updAL.get(i))) 	
	{
		if(pjneedfill==true)
		{
%>
		 <a href="ProjInvestigation/viewProj.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View ProjInvestigation">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(updAL.get(i))) 
	{
		if(pjneedfill==true)
		{
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
%>
		 <a href="ProjInvestigation/edProj.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit ProjInvestigation">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else
	{
		if(pjneedfill==true)
		{
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
%>
		 <a href="ProjInvestigation/preProj.jsp?prj = <%=proj_no%>&sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="ProjInvestigation Requested">
		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>
	</td>
<!--Add-->
  </tr>
<%		
		}
	}
%>  
</table>

</div>
</body>
</html>
<%
}//end of else(���L��ơ^
}
catch (Exception e)
{
	
	  out.print("error 2 : "+ e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

}
%>
