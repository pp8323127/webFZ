<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}

String trip1	=	request.getParameter("trip1");
String trip2	=	request.getParameter("trip2");
String trip3	=	request.getParameter("trip3");
String trip4	=	request.getParameter("trip4");
String trip5	=	request.getParameter("trip5");

String fltno_1	=	request.getParameter("fltno_1");
String fltno_2	=	request.getParameter("fltno_2");
String fltno_3	=	request.getParameter("fltno_3");
String fltno_4	=	request.getParameter("fltno_4");

String pursern  =   request.getParameter("pursern");
String purserName  = null;
String inspector  = null;
String acno  =   request.getParameter("acno");
String fleet =   request.getParameter("fleet");

String fltd  =   request.getParameter("sdate");
String fdate_y  =   fltd.substring(0,4);
String fdate_m  =   fltd.substring(5,7);
String fdate_d  =   fltd.substring(8,10);

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor="#0066FF";

List sernnoAL = new ArrayList();
List fltnoAL = new ArrayList();
List fltdAL = new ArrayList();


ArrayList getTrip = new ArrayList();
getTrip.add(request.getParameter("trip1"));
getTrip.add(request.getParameter("trip2"));
getTrip.add(request.getParameter("trip3"));
getTrip.add(request.getParameter("trip4"));
getTrip.add(request.getParameter("trip5"));
String sector = "";
for(int i=0;i<getTrip.size();i++)
{
	if(getTrip.get(i).equals(""))
	{
		break;
	}
	if(i==0)
		sector = (String)getTrip.get(i);
	else
		sector +="/"+getTrip.get(i);
}

ArrayList getFltno = new ArrayList();
getFltno.add(request.getParameter("fltno_1"));
getFltno.add(request.getParameter("fltno_2"));
getFltno.add(request.getParameter("fltno_3"));
getFltno.add(request.getParameter("fltno_4"));
String allFltno = "";
for(int i=0;i<getFltno.size();i++)
{
	if(getFltno.get(i).equals(""))
	{
		break;
	}
	if(i==0)
		allFltno = (String)getFltno.get(i);
	else
		allFltno +="/"+getFltno.get(i);
}
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	sql = "select sernno, fltno, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where pursern = '"+pursern+"' and fleet ='"+fleet+"' and acno = '"+ acno+"' and To_char(fltd,'yyyy/mm/dd') ='"+fltd+"' and trip = '"+sector+"' and fltno= '"+allFltno+"' order by fltd desc";

//out.print("sql="+sql+"<br>");	

	rs= stmt.executeQuery(sql); 
	
	while(rs.next())
	{
		sernnoAL.add(rs.getString("sernno"));
		fltnoAL.add(rs.getString("fltno"));
		fltdAL.add(rs.getString("fltd"));
    }
	//out.print(sernnoAL.size()+"<BR>");
	if (sernnoAL.size() != 0) 
	{
		%>
		<table width="60%" border="0" align="center" class="table_no_border">
		<tr>
			<td class="txtblue"><div align="center">&nbsp;<span class="style7">Please click the LINK to modify the data!
	      </span></div></td>
		</tr>
</table>
		<br>
	
      <table width="60%" border="0" align="center" class="tablebody">
		<tr bgcolor="<%=bgColor%>" class="tablehead">
  			<td width="30%" class="table_head"><div align='center' class="style6">Flight Date</div></td>
  			<td width="60%" class="table_head"><div align="center" class="style6">Flight NO.</div></td> 
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
  			<td  Align="Center"><%=fltdAL.get(i)%></td>
 			<td  Align="Center"><a href="editListData.jsp?sernno=<%=sernnoAL.get(i)%>&trip1=<%=trip1%>&trip2=<%=trip2%>&trip3=<%=trip3%>&trip4=<%=trip4%>&trip5=<%=trip5%>&fltno_1=<%=fltno_1%>&fltno_2=<%=fltno_2%>&fltno_3=<%=fltno_3%>&fltno_4=<%=fltno_4%>&pursern=<%=pursern%>&acno=<%=acno%>&fleet=<%=fleet%>&fdate_y=<%=fdate_y%>&fdate_m=<%=fdate_m%>&fdate_d=<%=fdate_d%>"><%=fltnoAL.get(i)%></a></td>
		</tr>
		<%
			}
		}
		else
		{
			%>
				<jsp:forward page="checklist.jsp" />
			<%		
		}	
	%>
</table>
	</form>
</body>
</html>
<%
}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>