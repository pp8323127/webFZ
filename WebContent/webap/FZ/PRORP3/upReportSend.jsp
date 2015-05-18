<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,
				fz.pr.orp3.*,
				ci.db.ConnDB,
				java.net.URLEncoder,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//�y�������i--�e�X���i
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(�e�X���i)</title>
<link href="style2.css" rel="stylesheet" type="text/css">
</head>

<body>
<div align="center">
<%
String fdate = request.getParameter("fdate");
//���o���Z�~��
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

//String GdYear = "2005";//request.getParameter("GdYear");
//out.print(GdYear);

String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");

String fltno = request.getParameter("fltno").trim();
String sect = request.getParameter("dpt").trim()+request.getParameter("arv").trim();

String[] empno 	= request.getParameterValues("empno");
String empList = "";
	for (int i = 0; i < empno.length; i++) {				
		if(i==0){
			empList = "'"+ empno[i]+"'";
		}
		else{
			  empList += ",'"+empno[i]+"'";
		}
	}
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
int ct = 0;
boolean t = false;


try{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
String sql = "update egtcflt set upd='N', reject=null, reject_dt=null where fltd=to_date('"+ fdate +
			 "','yyyy/mm/dd') and fltno='"+ fltno +"' and sect ='"+ sect +"'" ;

stmt.executeUpdate(sql);

//�P�_egtcrpt�O�_���O��, ��-->update, �L-->insert
rs = stmt.executeQuery("select count(*) ct from egtcrpt where fltd=to_date('"+ fdate +"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ");
if(rs != null){
	while(rs.next()){
		ct = rs.getInt("ct");
	}
}
//out.println(ct);
if(ct == 0){
	sql = "insert into egtcrpt values(to_date('"+ fdate +"','yyyy/mm/dd'),'"+fltno+"','"+sect+"','"+sGetUsr+"','"+sGetUsr+"',sysdate,'Y',null,null,null,null)";
}
else{
	sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate "+
		   "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"',caseclose='N' ";
}
//out.println(sql);
stmt.executeUpdate(sql);	  
%>
  <span class="purple_txt"><strong>���i�w���\�e�X!!!<br>
  <br>
Send Report Success!!
<br>
<br>
</strong></span><span class="red12"><strong>���i�@�g�e�X�A�Y���o���C
</strong></span></div>
</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
	  out.print(e.toString());
		 // response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));
}
finally
{
	
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<script>
alert("���i�w�g�e�X!!");
</script>