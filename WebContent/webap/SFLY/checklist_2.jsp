<%@page import="ws.prac.SFLY.MP.*"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}
String fltno = request.getParameter("fltno");
String acno  = request.getParameter("acno");
String fleet = request.getParameter("fleet");
String fltd  = request.getParameter("fltd");
String sector = request.getParameter("sector");
String pursern  = request.getParameter("pursern");

MPsflySafetyChkItemRObj sChkItem = null;
MPsflyRptFun sfly = new MPsflyRptFun();
sfly.CabinSafetyItem(fltd, sector, fltno, userid);
sChkItem = sfly.SChkItem;
String purserName  = null;
String inspector  = null;

String fdate_y  =  null;
String fdate_m  =  null;
String fdate_d  =  null;
//out.println(fltd);
if(fltd!=null && !"".equals(fltd)){
	fdate_y  =   fltd.substring(0,4);
	fdate_m  =   fltd.substring(5,7);
	fdate_d  =   fltd.substring(8,10);
}

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sqlPName = null;
String sqlIName = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

sqlPName = "select EMPN, SERN, CNAME from egdb.egtcbas where SERN = '"+ pursern+ "' ";
rs = stmt.executeQuery(sqlPName); 
while(rs.next())
{
	purserName = rs.getString("cname");
}  


sqlIName = "select EMPN, CNAME from egdb.egtcbas where EMPN = '"+ userid+ "' ";
rs = stmt.executeQuery(sqlIName);
while(rs.next())
{
	inspector = rs.getString("cname");
}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>check list</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function load(w1,w2){
	parent.topFrame.location.href=w1;
	parent.mainFrame.location.href=w2;
}

function compose_note(colname,remark)
{
	var c_value = "";
	for (var i=0; i < eval("document.form1."+colname+".length"); i++)
	{
		if (eval("document.form1."+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form1."+colname+"[i].value") ;
		}
	}

	//alert(c_value);
	document.getElementById(remark).value = c_value ;
}
</script>
<style type="text/css">
<!--
.style2 {color: #000000}
.style5 {font-size: 12px}
.style6 {color: #FF0000}
-->
</style>
</head>

<body>

<form name="form1" method="post" action="checklist_insert.jsp" onSubmit="">
 
  <div align="center">
    <input name="fltno" type="hidden" value="<%=fltno%>">
    <input name="trip" type="hidden" value="<%=sector%>">
    <input name="fltd" type="hidden" value="<%=fltd%>">
    <input name="Y" type="Hidden" value="<%=fdate_y%>">
    <input name="M" type="Hidden" value="<%=fdate_m%>">
    <input name="D" type="Hidden" value="<%=fdate_d%>">
    <input name="fleet" type="Hidden" value="<%=fleet%>">
    <input name="acno" type="hidden" value="<%=acno%>">
    <input name="purname" type="Hidden" value="<%=purserName%>">
    <input name="pursern" type="Hidden" value="<%=pursern%>">
    <input name="instname" type="Hidden" value="<%=inspector%>">
    <input name="instempno" type="Hidden" value="<%=userid%>">
    <input name="upduser" type="Hidden" value="<%=userid%>">
    

    <div align="center"><span class="txttitletop">Cabin Safety Check List </span> 
  </div>
  <table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="fortable"> 
  <tr class="tablebody">
 	<td width="62%" class="txtblue" ><div align="left" class="style2"><span class="style6">Flight</span>：<%=fltno%> <span class="style6"> 　Sector：</span><%=sector%> </div></td>
    <td width="38%" class="txtblue" ><div align="left" class="style2"><span class="style6">Date：</span><%=fdate_y%> Y <%=fdate_m%>M <%=fdate_d%> D</div></td>
  </tr> 
  <tr class="tablebody">
 	<td width="62%" class="txtblue" ><div align="left" class="style2"><span class="style6">A/C：</span><%=fleet%>　(<%=acno%>)　　　　<span class="style6">CM：</span><%=purserName%></div></td>
    <td width="38%" ><div align="left"><span class="style6">Inspector：</span><span class="txtblue"><%=inspector%></span></div></td>
  </tr> 
</table>
 <%
GregorianCalendar cal1 = new GregorianCalendar();
GregorianCalendar cal2 = new GregorianCalendar();

//2009/07/20 後項目異動
cal1.set(Calendar.YEAR,2009);
cal1.set(Calendar.MONTH,7-1);
cal1.set(Calendar.DATE,20);

//Fltdt
cal2.set(Calendar.YEAR,Integer.parseInt(fdate_y));
cal2.set(Calendar.MONTH,Integer.parseInt(fdate_m)-1);
cal2.set(Calendar.DATE,Integer.parseInt(fdate_d));
%>

  <table width="90%" border="1" align="center" cellpadding="0" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td height="5" colspan="2"><div align="center"><strong>Item</strong></div></td>
    <td width="4%" height="5"><div align="center"><strong>Yes</strong></div></td>
<%
if(cal2.before(cal1))
{
%>
    <td width="3%" height="5"><div align="center"><strong>No</strong></div></td>
<%
}
else
{
%>
    <td width="3%" height="5"><div align="center"><strong>NDIP</strong></div></td>
<%
}
%>
    <td width="4%" height="5"><div align="center"><strong>N/A</strong></div></td>
    <td width="30%" height="5"><div align="center"><strong>Remark</strong></div></td>
    <td width="6%"><strong>Attribute</strong></td>
  </tr>
<%
if(sChkItem != null && sChkItem.getQueArr() != null){
	for(int i=0 ;i<sChkItem.getQueArr().length;i++){
	MPsflySafetyChkQueObj obj = sChkItem.getQueArr()[i];
%>	
	<tr class="tablebody">
		<td colspan="7"><div align="left" class="txtblue style2"><strong>&nbsp;<%=obj.getItemno()%>.<%=obj.getItemDsc()%></strong></div></td>
	</tr>

<%
	if(obj.getSubQueArr() != null){
		for(int j=0 ;j<obj.getSubQueArr().length;j++){
			MPsflySafetyChkQsubObj subObj = obj.getSubQueArr()[j];   
			%>
			<tr class="tablebody">
				<td width="3%" class="txtblue"><div align="center" class="style2"><%=subObj.getItemnoRv()%></div></td>
				<td width="50%" class="txtblue"><div align="left" class="style2">&nbsp;<%=subObj.getItemdsc()%></div></td>
 				<td width="4%">
					<div align="center">
					<input name="<%=subObj.getItemno()%>" type="radio" value="1" checked>
                </div></td>
				<td width="3%">
		        	<div align="center">
		            <input name="<%=subObj.getItemno()%>" type="radio" value="2">
                </div></td>
 				<td width="4%">
					<div align="center">
					<input name="<%=subObj.getItemno()%>" type="radio" value="0">
                </div></td>
 				<td width="30%">
			      <div align="left">
			        <input name="<%=subObj.getItemno()%>remark" type="text" value="" size="30%" maxlength="25">
			        <%
					  if(null!=subObj.getSelectItem() && subObj.getSelectItem().length>0){
					  	for(int jj=0;jj<subObj.getSelectItem().length;jj++){
					  %>
					  <br><input type="checkbox" name="select<%=i%><%=j%>" value="<%=subObj.getSelectItem()[jj]%>" onclick="compose_note('select<%=i%><%=j%>','<%=subObj.getItemno()%>remark')"><%=subObj.getSelectItem()[jj]%>
					  <%
					  	}
					  }
					 %>
               	</div></td>
                <td width="6%" class="txtblue"><div align="left" class="style2" >
                	<select name="<%=subObj.getItemno()%>rm" class="style5">
			 		<%
			 		for(int k=0 ;k<sChkItem.getAttributeArr().length;k++){
			 			MPsflySafetyChkAttObj attObj = sChkItem.getAttributeArr()[k]; 
			  		%>
              			<option value="<%=attObj.getItemNo()%>"><%=attObj.getItemdsc()%></option>
			  		<%
			  		}
			 		%>
                    </select>
                 </div></td>
  			</tr>  
			<%
			
			}//for(int j=0 ;j<obj.getSubQueArr().length;j++){
		}//if(obj.getSubQueArr() != null){
	}//for(int i=0 ;i<sChkItem.getQueArr().length;i++){
}//if(sChkItem != null && sChkItem.getQueArr() != null){				
%>
<tr>
<td colspan="7">
	<div align="right">
 		    <input type="submit" name="Submit" value="Submit">　　
 		    <input type="reset" name="Submit" value="Reset">
&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="txtred" onClick="load('gotoEmptySILReport.jsp?fltno=<%=fltno%>&fdate_y=<%=fdate_y%>&fdate_m=<%=fdate_m%>&fdate_d=<%=fdate_d%>&purserName=<%=purserName%>&inspector=<%=inspector%>','emptyCheckList.jsp?fltno=<%=fltno%>&sector=<%=sector%>&fdate_y=<%=fdate_y%>&fdate_m=<%=fdate_m%>&fdate_d=<%=fdate_d%>&fleet=<%=fleet%>&acno=<%=acno%>&purserName=<%=purserName%>&inspector=<%=inspector%>')"> PPRODUCE AN EMPTY CHECK LIST&nbsp;</a>
		  </div></td></tr>
</table>	
</form>				
<%


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

</body>
</html>
