<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.ConnDB,java.net.URLEncoder,fz.*,java.util.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String yy = request.getParameter("yy");
String mm = request.getParameter("mm");

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

ConnDB cn = new ConnDB();

try{
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
	  out.print(e.toString() + sql);
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
//1.����cflt,��JarrayList
try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
		
//TODO ���sql
if(sGetUsr.equals("640073") || sGetUsr.equals("638716")){	//���ե�sql
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'&nbsp;') reject "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"AND      Last_Day(To_Date('"+yy+mm+"','yyyymm'))";
}
else{	//�H�U����������sql
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'&nbsp;') reject "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"AND      Last_Day(To_Date('"+yy+mm+"01 2359','yyyymmdd hh24mi'))  AND psrempn='"+sGetUsr+"'";
}

rs = stmt.executeQuery(sql);
if(rs!= null){
	while (rs.next()) {
		scheAL.add(rs.getString("fdate").trim() + "," + rs.getString("fltno").trim()
				+ "," + rs.getString("sect").trim());
		updAL.add(rs.getString("upd"));
		reject.add(rs.getString("reject"));
		rowCount ++;
	}
}
}
catch (Exception e)
{
	
	  out.print(e.toString() + sql);
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
try{
//��ORP3 �Ӥ�duty��Pusrser���Z��

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

//			Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();

if("640073".equals(sGetUsr) || "638716".equals(sGetUsr) ){	//���եΡA�]�w���u����627536

	sql = "SELECT fdate,dutycode fltno,dpt,arv FROM "+ct.getTable()+
	" WHERE empno='627536' AND substr(fdate,1,7) = '"+yy+"/"+mm+"'  "+
	"AND SubStr(Trim(qual),1,1) ='P' and spcode not in ('I','S') and dh <> 'Y' AND dpt <> ' '";

}else{
	sql = "SELECT fdate,dutycode fltno,dpt,arv FROM "+ct.getTable()+
	" WHERE empno='"+sGetUsr+"' AND substr(fdate,1,7) = '"+yy+"/"+mm+"' "+
	"AND SubStr(Trim(qual),1,1) ='P' and spcode not in ('I','S') and dh <> 'Y' AND dpt <> ' '";
}

//out.println(sql);
rs = stmt.executeQuery(sql);
rowCount = 0;
if(rs.next()){//��X��Ƶ���
	rs.last();
	rowCount = rs.getRow();
	rs.beforeFirst();
}

if(rowCount ==0 ){
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	out.print("�d�L���<br>No DATA!!");
	
}
else{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�y�������i --���v���</title>
<link href="style2.css" rel="stylesheet" type="text/css">
</head>
<body>
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
    <td width="16%">Fdate</td>
    <td width="15%">Fltno</td>
    <td width="15%">Sect</td>
    <td width="30%">Modifiable Status </td>
    <td width="24%">View/Edit</td>
  </tr>
  <%
	if(rs != null){
		while(rs.next()){

		fdate 	= rs.getString("fdate");
		dd	= fdate.substring(8);
		fltno 	= rs.getString("fltno").trim();
		sect = rs.getString("dpt").trim()+rs.getString("arv").trim();

		matchStr = fdate+","+fltno+","+sect;

		if(!scheAL.isEmpty()){
			for (int i = 0; i < scheAL.size(); i++) {
				if(((String)scheAL.get(i)).equals(matchStr)  ){
					flag="Y";//�w�s��L���i
					upd = (String)updAL.get(i);
					rj = (String)reject.get(i);
					if(rj.equals("Y")) rj = "Reject";
					break;
				}
				else{
					flag = "N";
					upd  = "N";
					rj = "&nbsp;";
				}
			}
		}else{
			flag="N";
				
		}
	if(flag.equals("Y")){	//�w�s��L���i
		if("Y".equals(upd) ){	//���i���i�ק�
			updStr="<font color=blue>YES(�i�ק�)"+rj+"</font>";
		}else{	//���i�w�e�X�A���i�ק�
			updStr="NO(���i�ק�)";
		}
		
		
	}else{	//�|���s��L���i
		updStr = "<font color=red>NONE(�|���s��)</font>";
	}
	

  	if((rs.getRow())%2 == 0){
		bgColor = "#CCCCCC";
	}else{
		bgColor = "#FFFFFF";
	}
	
  %>
  <tr class="tablebody" bgcolor="<%=bgColor%>">
    <td height="28" class="tablebody"><%=fdate %></td>
    <td class="tablebody"><%=fltno %></td>
    <td class="tablebody"><%=sect %></td>
    <td class="tablebody"><%=updStr%></td>
    <td class="tablebody">
	<%
	
 //1.�w�s��L���i�A���|���e�X�A��2.�|���s��L���i-->�s���ܽs�誺�e��
	if(( "Y".equals(flag) && "Y".equals(upd))|| "N".equals(flag) ){
	
		//11~12��A���Z��U�@�~�ת�
		if(fdate.substring(5,7).equals("11") ||fdate.substring(5,7).equals("12")){	
			GdYear =(Integer.toString((Integer.parseInt(fdate.substring(0,4))+1) ));
		}
		else{
			GdYear = fdate.substring(0,4);
		}
	%>
	<a href="FltIrrList.jsp?fyy=<%=yy%>&fmm=<%=mm%>&fdd=<%=dd%>&fltno=<%=fltno%>&GdYear=<%=GdYear%>" target="_self">
	<font color="#990000"><u>Edit</u></font></a>
	<%
	}
	//�w�s��L���i�B�w�e�X�A���i�A�s��-->�s��report�e��
	else if( ("Y".equals(flag) && "N".equals(upd)) ){

	%>
	<a href="PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>" target="_blank">
	<font color="#FF33CC"><u>View</u></font></a>
	<%
	}
	%>
	</td>
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
	
	  out.print(e.toString() + sql);
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
