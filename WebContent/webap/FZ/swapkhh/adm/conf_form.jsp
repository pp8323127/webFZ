<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
//String username = (String) session.getAttribute("cname") ; 

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	//response.sendRedirect("/webfz/FZAC/sendredirect.jsp");
} 

String conf = request.getParameter("conf");//Y : agress, N : reject
String cdate = request.getParameter("cdate");//A : apply date, C : check date
String sDate = request.getParameter("sdate");
String eDate = request.getParameter("edate");
String empno = request.getParameter("empno").trim();
StringBuffer sql = new StringBuffer();
StringBuffer reportTitle  = new StringBuffer();
/*
sql.append("SELECT f.*,To_char(f.checkDate,'yyyy/mm/dd hh24:mi') cdate,");
sql.append("To_char(f.newDate,'yyyy/mm/dd hh24:mi') ndate ");
sql.append("FROM fztformf f WHERE station='KHH' ");



if ("A".equals(conf)) 
{
	sql.append(" AND ed_check is not null ");
	reportTitle.append(" 核准/退回 ");
} 
else 
{
	sql.append(" AND ed_check ='" + conf + "' ");

	if ("Y".equals(conf)) 
	{
		reportTitle.append(" 核准 ");
	} 
	else 
	{
		reportTitle.append(" 退回 ");
	}
}
reportTitle.append("申請單記錄");

if ("A".equals(cdate)) 
{
	sql.append("AND newdate BETWEEN To_Date('" + sDate + " 0000','yyyy/mm/dd hh24mi') ");
	sql.append("AND To_Date('" + eDate+ " 2359','yyyy/mm/dd hh24mi') ");
	reportTitle.insert(0, " 申請日期： " + sDate + "~" + eDate + " ");

} 
else if ("C".equals(cdate)) 
{
	sql.append("AND checkdate BETWEEN To_Date('" + sDate+ " 0000','yyyy/mm/dd hh24mi') ");
	sql.append("AND To_Date('" + eDate	+ " 2359','yyyy/mm/dd hh24mi') ");
	reportTitle.insert(0, " 處理日期： " + sDate + "~" + eDate + " ");
}

if (!"".equals(empno) && null != empno) 
{
	sql.append(" AND (aempno='" + empno + "' or rempno='" + empno + "') ");
}

sql.append(" ORDER by FORMNO");
*/

if ("A".equals(conf)) 
{
	reportTitle.append(" 核准/退回 申請單記錄");
} 
else 
{
	if ("Y".equals(conf)) 
	{
		reportTitle.append(" 核准 申請單記錄");
	} 
	else 
	{
		reportTitle.append(" 退回 申請單記錄");
	}
}

if ("A".equals(cdate)) 
{
	reportTitle.insert(0, " 申請日期： " + sDate + "~" + eDate + " ");

} 
else if ("C".equals(cdate)) 
{
	reportTitle.insert(0, " 處理日期： " + sDate + "~" + eDate + " ");
}

//***************************************************************************************
sql.append("SELECT * from (");

sql.append("SELECT f.*,To_char(f.checkDate,'yyyy/mm/dd hh24:mi') cdate,");
sql.append("To_char(f.newDate,'yyyy/mm/dd hh24:mi') ndate,'Y' acount, '0' acomm, 'Y' rcount, '0' rcomm, 'A' formtype ");
sql.append("FROM fztformf f WHERE station='KHH' ");

if ("A".equals(conf)) 
{
	sql.append(" AND ed_check is not null ");
} 
else 
{
	sql.append(" AND ed_check ='" + conf + "' ");
}

if ("A".equals(cdate)) 
{
	sql.append("AND newdate BETWEEN To_Date('" + sDate + " 0000','yyyy/mm/dd hh24mi') ");
	sql.append("AND To_Date('" + eDate+ " 2359','yyyy/mm/dd hh24mi') ");
} 
else if ("C".equals(cdate)) 
{
	sql.append("AND checkdate BETWEEN To_Date('" + sDate+ " 0000','yyyy/mm/dd hh24mi') ");
	sql.append("AND To_Date('" + eDate	+ " 2359','yyyy/mm/dd hh24mi') ");
}

if (!"".equals(empno) && null != empno) 
{
	sql.append(" AND (aempno='" + empno + "' or rempno='" + empno + "') ");
}
//******************************************************************************
sql.append(" union all ");
sql.append("SELECT f.*,To_char(f.checkDate,'yyyy/mm/dd hh24:mi') cdate,");
sql.append("To_char(f.newDate,'yyyy/mm/dd hh24:mi') ndate, 'B' formtype ");
sql.append("FROM fztbformf f WHERE station='KHH' ");

if ("A".equals(conf)) 
{
	sql.append(" AND ed_check is not null ");
} 
else 
{
	sql.append(" AND ed_check ='" + conf + "' ");
}

if ("A".equals(cdate)) 
{
	sql.append("AND newdate BETWEEN To_Date('" + sDate + " 0000','yyyy/mm/dd hh24mi') ");
	sql.append("AND To_Date('" + eDate+ " 2359','yyyy/mm/dd hh24mi') ");

} 
else if ("C".equals(cdate)) 
{
	sql.append("AND checkdate BETWEEN To_Date('" + sDate+ " 0000','yyyy/mm/dd hh24mi') ");
	sql.append("AND To_Date('" + eDate	+ " 2359','yyyy/mm/dd hh24mi') ");
}

if (!"".equals(empno) && null != empno) 
{
	sql.append(" AND (aempno='" + empno + "' or rempno='" + empno + "') ");
}

sql.append(" ) ORDER by FORMNO");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();

String errMsg = "";
boolean status = false;
ArrayList dataAL = null;

try {

	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
//out.println(sql.toString());
	pstmt = conn.prepareStatement(sql.toString());
	rs = pstmt.executeQuery();
	while (rs.next()) 
	{
		if (dataAL == null) 
		{
			dataAL = new ArrayList();
		}
		swap3ackhh.SwapFormObj obj = new swap3ackhh.SwapFormObj();
		obj.setFormno(rs.getString("formno"));
		obj.setAEmpno(rs.getString("aempno"));
		obj.setACname(rs.getString("acname"));
		obj.setAGrps(rs.getString("agroups"));
		obj.setREmpno(rs.getString("rempno"));
		obj.setRCname(rs.getString("rcname"));
		obj.setRGrps(rs.getString("rgroups"));
		obj.setNewdate(rs.getString("ndate"));
		obj.setCheckdate(rs.getString("cdate"));
		obj.setEd_check(rs.getString("ed_check"));
		obj.setCheckuser(rs.getString("checkuser"));
		obj.setComments(rs.getString("comments"));
		obj.setFormtype(rs.getString("formtype"));
		obj.setChg_all(rs.getString("chg_all"));
		dataAL.add(obj);
	}
	rs.close();
	pstmt.close();
	conn.close();
	status = true;
} catch (Exception e) {
	errMsg = e.toString();
} finally {
	if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {}
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {}
	if (conn != null)
		try {
			conn.close();
		} catch (SQLException e) {}
}
String bcolor="";

%>
<html>
<head>
<title>Apply Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">
<link rel="stylesheet" href="../style/errStyle.css" type="text/css">

<script language="javascript" src="../../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function showForm(formNo,formtype)
{
	document.getElementById("formno").value = formNo;
	subwin('../blank.htm','showform');

	if(formtype=="A")
	{
		document.form1.action="../showForm.jsp";
	}
	else
	{
		document.form1.action="../../credit/swapkhh/showBForm.jsp";
	}
	document.form1.submit();

	
}
</script>
</head>

<body >
<form name="form1" method="post" action="" target="showform" >
<input type="hidden" name="formno" id="formno">
</form>
<%
if(!status){
out.print("ERROR:"+errMsg);
}
else
{
	if(dataAL == null)
	{
%>
<div class="errStyle1">查詢條件無已處理申請單.<br>
尚未處理之申請單，請至「申請單處理」查詢.
</div>
<%
}
else
{

%>
<div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="93%" align="center" class="r" ><%=reportTitle.toString()%></td>
      <td width="7%"> 
        <div align="right"><a href="javascript:window.print()"> <img src="../print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="100%" cellspacing="1" cellpadding="1" style="border-collapse:collapse;border:1pt double #00248F " >
    <tr class="tableh5">
	  <td >No</td>
	  <td >Empno</td>
	  <td >Applicant</td>
	  <td >Group</td>
	  <td >Empno</td> 
      <td >Substitute</td>
	  <td >Group</td>
      <td >ED</td>
	  <td >CheckDate</td>
	  <td >CheckUser</td>
      <td >ApplyDate </td>
      <td >EDComments </td>
	  <td >View</td>
    </tr>
    <%
		for(int i=0;i<dataAL.size();i++)
	  {
			swap3ackhh.SwapFormObj obj = (swap3ackhh.SwapFormObj)dataAL.get(i);		
			if (i%2 == 0)
			{
				bcolor = "#FFFFFF";
			}
			else
			{
				bcolor = "#DAE9F8";
			}
%>
    <tr bgcolor="<%=bcolor%>"> 
      <td ><%=obj.getFormtype()%><%=obj.getFormno()%></td>
	  <td ><%=obj.getAEmpno()%></td>
	  <td ><%=obj.getACname()%></td>
	  <td ><%=obj.getAGrps()%></td>
      <td ><%=obj.getREmpno()%></td>
	  <td ><%=obj.getRCname()%></td>
	  <td ><%=obj.getRGrps()%></td>
      <td ><%=obj.getEd_check()%></td>
      <td ><%=obj.getCheckdate()%></td>
	  <td ><%=obj.getCheckuser()%></td>
      <td ><%=obj.getNewdate()%></td>
      <td ><div align="left"><%=obj.getComments()%></div></td>
	  <!--<td>
        <div align="center"><a href="#" onClick="subwin('../showForm.jsp?formno=<%=obj.getFormno()%>','showform')"> <img src="img/view.gif" border="0" alt="Detail"></a></div>
	  </td>-->
	  <td>
        <a href="javascript:showForm('<%=obj.getFormno()%>','<%=obj.getFormtype()%>');" ><img src="img/view.gif" border="0" width="16" height="16" alt="檢視換班單詳細資料" title="檢視換班單詳細資料"></a></td>

    </tr>
    <%
	}

	%>

  </table>
<span class="r">Total Records : <%=dataAL.size()%></span>


</div>
<%
	
	
	}
}

%>

</body>
</html>
