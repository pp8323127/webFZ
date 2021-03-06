<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
}

String fltd  =   request.getParameter("sdate");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor="#0066FF";

List sernnoAL = new ArrayList();
List fltnoAL = new ArrayList();
List fltdAL = new ArrayList();
List tripAL = new ArrayList();
List acnoAL = new ArrayList();
List fleetAL = new ArrayList();
List purAL = new ArrayList();
ArrayList getTrip = new ArrayList();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>View eidt Cabin Safey check List Info</title>
<link href= "style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {
	font-family: Arial, Helvetica, sans-serif;
	color: #000000;
	font-size: 14px;
}
.style5 {color: #FFFFFF}
.style6 {color: #FFFFFF; font-size: 14px; }
.style7 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<br>
<%
	sql = "select ti.*, To_char(fltd,'yyyy/mm/dd') fltd2, trim(cb.empn)||'('||trim(cb.sern)||')'||cb.cname pur from egtstti ti, egtcbas cb where trim(cb.sern) = ti.pursern and fltd = To_date('"+fltd+"','yyyy/mm/dd') and  instempno = '"+userid+"' order by fltd desc";

	if("640790".equals(userid) || "643937".equals(userid))
	{
		sql = "select ti.*, To_char(fltd,'yyyy/mm/dd') fltd2, trim(cb.empn)||'('||trim(cb.sern)||')'||cb.cname pur from egtstti ti, egtcbas cb where trim(cb.sern) = ti.pursern and fltd = To_date('"+fltd+"','yyyy/mm/dd') order by fltd desc";
	}

	rs= stmt.executeQuery(sql); 
	
	while(rs.next())
	{
		sernnoAL.add(rs.getString("sernno"));
		fltnoAL.add(rs.getString("fltno"));
		fltdAL.add(rs.getString("fltd2"));
		acnoAL.add(rs.getString("acno"));
		fleetAL.add(rs.getString("fleet"));
		tripAL.add(rs.getString("trip"));
		purAL.add(rs.getString("pur"));
    }
	//out.print(sernnoAL.size()+"<BR>");
	if (sernnoAL.size() > 0) 
	{
		%>
		<table width="60%" border="0" align="center" class="table_no_border">
		<tr>
			<td class="txtblue"><div align="center">&nbsp;<span class="style7">Please click the LINK to modify the data!
	      </span></div></td>
		</tr>
		</table>
		<br>
		
        <table width="80%" border="0" align="center" class="tablebody">
		<tr bgcolor="<%=bgColor%>" class="tablehead">
		  	<td width="10%" class="table_head"><div align='center' class="style6">#</div></td>
  			<td width="20%" class="table_head"><div align='center' class="style6">Flight Date</div></td>
  			<td width="15%" class="table_head"><div align="center" class="style6">Flight NO.</div></td> 
  			<td width="20%" class="table_head"><div align="center" class="style6">Trip</div></td> 
  			<td width="35%" class="table_head"><div align="center" class="style6">CM</div></td> 
		</tr>
		<%
			
			for(int i=0;i<sernnoAL.size();i++)
			{
				if(i%2 ==0)
					bgColor="#C6C2ED";
				else
					bgColor="#F2B9F1";		  
		%>
			<tr bgcolor="<%=bgColor%>">
				<td  Align="Center"><%=i+1%></td>
				<td  Align="Center"><%=fltdAL.get(i)%></td>
				<td  Align="Center"><%=fltnoAL.get(i)%></td>
				<td  Align="Center"><%=tripAL.get(i)%></td>
				<td  Align="Center"><a href="editListData.jsp?sernno=<%=sernnoAL.get(i)%>"><%=purAL.get(i)%></a></td>
			</tr>
		<%
			}//for(int i=0;i<sernnoAL.size();i++)
		%>
		</table>
			</form>
		</body>
		</html>
<%
	}
	else
	{
		%>
		<script language="javascript" type="text/javascript">
		alert("查無航班記錄,請新增航班資訊!!");
		window.history.back(-1);
		</script>
		<%		
	}	
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>