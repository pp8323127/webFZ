<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
}

String sernno	=	request.getParameter("sernno"); 
String pursern  =   "";
String purserName  = "";
String inspector  = "";
String acno  =   "";
String fleet =   "";
String fdate_y  =   "";
String fdate_m  =   "";
String fdate_d  =   "";
String fltd = "";

String siNo = null;
String fiNo = null;
String rmNo = null;
String siDsc = null;
String fiDsc = null;
String rmDsc = null;
String fiFlag = null;
int count=1;
int subcount=1;

Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;
Statement stmt3 = null;
Statement stmt4 = null;
Statement stmtRm = null;

ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;
ResultSet rsRm = null;

String sql = null;
String sql2 = null;
String sql3 = null;
String sql4 = null;
String sqlRm = null;

String[] selectItem = null;
String remark = null;
String dtFlag = null;
String itemnoRm =null;
String sector = "";
String allFltno = "";
String qa		=   null;
String comm     =   null;
String process  = null;

ConnDB cn = new ConnDB();

ArrayList fItemNoAL = new ArrayList();     //egtstfi
ArrayList fItemDscAL = new ArrayList();
ArrayList sItemNoAL = new ArrayList();      //egtstsi
ArrayList sItemDscAL = new ArrayList();
Driver dbDriver = null;

try
{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

sql = " SELECT ti.sernno, to_char(ti.fltd,'yyyy/mm/dd') fltd2, To_Char(ti.fltd,'yyyy') fy,  To_Char(ti.fltd,'mm') fm, To_Char(ti.fltd,'dd') fd, ti.fltno, ti.trip, ti.fleet, ti.acno, Trim(cb.empn) empno, ti.pursern pursern, cb.cname purname, hr.cname hrinstname FROM egtstti  ti, egtcbas cb, hrvegemploy hr WHERE sernno =  '"+sernno+"' AND ti.pursern = Trim(cb.sern) AND hr.employid = ti.instempno ";
rs = stmt.executeQuery(sql); 
	 	
 while(rs.next())
 {
	inspector = rs.getString("hrinstname");
	purserName = rs.getString("purname");
	sector = rs.getString("trip");
	allFltno = rs.getString("fltno");
	fleet = rs.getString("fltno");
	acno = rs.getString("acno");
	fdate_y = rs.getString("fy"); 
	fdate_m = rs.getString("fm"); 
	fdate_d = rs.getString("fd"); 
	fltd = rs.getString("fltd2"); 
}  

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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Modify List Data</title>
<link href="style.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style1 {color: #FF0000}
.style3 {color: #000000}
.style4 {line-height: 13.5pt; font-family: "Verdana"; font-size: 12px;}
.style5 {color: #000000; font-size: 12px; }
-->
</style>
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
</head>

<body>

<form name="form1" method="post" action="editListData_update.jsp" onSubmit="">
 
  <div align="center">
	<input name="sernno" type="hidden" value="<%=sernno%>">
	<input name="dtFlag" type="hidden" value="<%=dtFlag%>">					
	<input name="remark" type="hidden" value="<%=remark%>">		
	<input name="qa" type="hidden" value="<%=qa%>">
	<input name="comm" type="hidden" value="<%=comm%>">
	<input name="process" type="hidden" value="<%=process%>">
	
    <div align="center"><span class="txttitletop">Cabin Safety Check List <span class="style1"><MARQUEE BEHAVIOR=ALTERNATE>
    (Modify)
    </MARQUEE>
</span></span></div>
    <table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="fortable"> 
  <tr class="txtblue">
 	<td width="62%" ><div align="left" class="style3"><strong><span class="style5">Flight</span>：</strong><%=allFltno%> <strong><span class="style5"> 　Sector：</span></strong><%=sector%> </div></td>
    <td width="38%" ><div align="left" class="style3"><span class="style6">Date：</span><%=fdate_y%> Y <%=fdate_m%>M <%=fdate_d%> D</div></td>
  </tr> 
  <tr class="txtblue">
 	<td width="62%" ><div align="left" class="style3"><span class="style6">A/C：</span><%=fleet%>　(<%=acno%>)　　　　<span class="style6">CM：</span><%=purserName%></div></td>
    <td width="38%" ><div align="left" class="style3"><span class="style6">Inspector：</span><%=inspector%></div></td>
  </tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="0" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td height="5" colspan="2"><div align="center"><strong>Item</strong></div></td>
    <td width="4%" height="5"><div align="center"><strong>Yes</strong></div></td>
<%
if(cal2.before(cal1))
{
%>
    <td width="4%" height="5"><div align="center"><strong>No</strong></div></td>
<%
}
else
{
%>
    <td width="4%" height="5"><div align="center"><strong>NDIP</strong></div></td>
<%
}
%>
    <td width="4%" height="5"><div align="center"><strong>N/A</strong></div></td>
    <td width="25%" height="5"><div align="center"><strong>Remark</strong></div></td>
    <td width="10%"><strong>Attribute</strong></td>
  </tr>
<%
String temp ="";
stmt  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt2  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt3  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt4  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmtRm  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
sql = "select * from egtstfi where flag='Y' "+ 
       "AND itemno IN (SELECT kin  FROM egtstsi  WHERE  itemno IN (SELECT itemno  FROM egtstdt WHERE sernno='"+sernno+"') and sflag= 'Y' ) "+ 
	   "order by itemno";
rs = stmt.executeQuery(sql); 
	  	  
			  if(rs != null)
			  {

	  			while(rs.next())
				{		
				fiNo = rs.getString("itemno");
	  			fiDsc = rs.getString("itemDsc");
				fiFlag = rs.getString("flag");
				
%>
	  			<tr class="txtblue">
   				  <td colspan="7"><div align="left" class="style3"><strong>&nbsp;<%=count%>.<%=fiDsc%></strong></div></td>
	            </tr>  
				<% 
				sql2 = "select itemno, itemdsc from egtstsi where kin='"+fiNo+"' and sflag= 'Y' AND itemno IN (SELECT itemno FROM egtstdt WHERE sernno='"+sernno+"') order by itemdsc  ";
				rs2 = stmt2.executeQuery(sql2); 
					  
				if(rs2 != null)
			  	{
					    
	  				while(rs2.next())
					{ 
						siNo = rs2.getString("itemno");
	  				    siDsc = rs2.getString("itemdsc");
						String siNo2 = count +"."+ subcount;   //screen display the itemno of egtstsi 
						
						sql3 = "select s.sernno sernno, s.itemno itemno, flag, NVL(remark, 'N/A') remark, itemno_rm , selectitem sel from egtstdt s,egtstsi i where i.itemno = s.itemno"
						+" and s.sernno ='"+sernno+"' and s.itemno = '"+siNo+"'";
				        rs3 = stmt3.executeQuery(sql3);
						//out.println(sql3);
						dtFlag = "";
						remark = "";
						itemnoRm = "000";									
						
						while(rs3.next())
						{	
							dtFlag = rs3.getString("flag");
						    remark = rs3.getString("remark");
							itemnoRm = rs3.getString("itemno_rm");
							temp = rs3.getString("sel");
                            if(temp != null && !"".equals(temp)){
                                selectItem = temp.split("[*]");
                            }
						}
						
						%>
						
	  					<tr class="txtblue">
    						<td width="3%"><div align="center" class="style3"><%=siNo2%></div></td>
   							<td width="50%"><div align="left" class="style3">&nbsp;<%=siDsc%></div></td>
    						<td width="4%">
   						      <div align="center" class="style3">
   						        <input <%=((dtFlag.toString().equals(("1").toString()))?"CHECKED":"")%> name="<%=siNo%>" type="radio" value="1">
		                  	  </div></td>
   						    <td width="4%">
					          <div align="center" class="style3">
					            <input <%=((dtFlag.toString().equals(("2").toString()))?"CHECKED":"")%> name="<%=siNo%>" type="radio" value="2">
		                      </div></td>
    						<td width="4%">
   						      <div align="center" class="style3">
   						        <input <%=((dtFlag.toString().equals(("0").toString()))?"CHECKED":"")%> name="<%=siNo%>" type="radio" value="0">
		                      </div></td>
    						<td width="25%">
						      <div align="left" class="style3">
						        <input name="<%=siNo.replace(".", "_")%>remark" type="text" value="<%=remark%>" size="30%" maxlength="25">
						        <%
								  if(null!=selectItem && selectItem.length>0){
								  	for(int jj=0;jj<selectItem.length;jj++){
								  %>
								  <br><input type="checkbox" name="select<%=siNo.replace(".", "_")%>" value="<%=selectItem[jj]%>" onclick="compose_note('select<%=siNo.replace(".", "_")%>','<%=siNo.replace(".", "_")%>remark')"><%=selectItem[jj]%>
								  <%
								  	}
								  }
								 %>
							</div>
							</td>
	                        <td width="10%"><div align="left"><span class="style3">
                            <select name="<%=siNo%>rm" id="<%=siNo%>rm">
                              <%
							  sqlRm = "select * from egtstrm order by itemno ";
							  rsRm = stmtRm.executeQuery(sqlRm);
							  if (rsRm != null)
			  				{
								while (rsRm.next())
				    			{ 
					     		rmNo = rsRm.getString("itemno");
						 		rmDsc = rsRm.getString("itemdsc");
						 
							  	%>
                              <option value="<%=rmNo%>" <%=((rmNo.toString().equals(itemnoRm))?"SELECTED":"")%>><%=rmDsc%></option>
                              <%
							    }
							}
							%>
                            </select>
</span></div></td>
  					   </tr>  
						
						<%
						subcount++;
						}
					}
					subcount=1;
					count++;
				}
			  }
%>		
</table>
<%
sql4 = "select  NVL(qa, '　') qa, NVL(comm, '　') comm, NVL(process, '　') process from egtstti where sernno = '"+ sernno+ "'";
rs4 = stmt4.executeQuery(sql4); 
while(rs4.next())
{
	qa = rs4.getString("qa");
	comm = rs4.getString("comm");
	process= rs4.getString("process");
}  

if(cal2.before(cal1))
{
%>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="fortable"> 
  <tr class="tablehead3">
    <td height="5" colspan="5"><div align="left"><strong>&nbsp;Q&amp;A </strong></div>
    </td>
  </tr>
  <tr class="tablebody">
    <td height="5" colspan="5" bgcolor="#FFFFFF" class="txtblue">
          <div align="left" class="style3">
            <textarea name="<%=sernno%>qa" cols="90%" rows="5" class="style4" id="qa"><%=qa%></textarea> 
      </div></td>
  </tr>
</table>
<%
}	  
%>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="fortable"> 
  <tr class="tablehead3">
  <tr class="tablehead3"><td height="5" colspan="5"><div align="left"><strong>&nbsp;Comment and Suggestion</strong></div>
      </td>
  </tr>
    <tr class="tablebody">
    <td height="5" colspan="5" bgcolor="#FFFFFF" class="txtblue">
        <div align="left" class="style3">
          <textarea name="<%=sernno%>comm" cols="90%" rows="5" class="style4" id="comm"><%=comm%></textarea>
        </div></td>
  </tr>
</table>
<%
if(cal2.before(cal1))
{
%>
<table width="90%"  border="1" align="center" cellpadding="0" cellspacing="0" class="fortable"> 
  <tr class="tablebody">
    <td width="6%" height="1" bgcolor="#FFFFFF"><div align="center" class="style11 style12 style1">收文
    </div></td>
    <td width="40%" bgcolor="#FFFFFF"><div align="center" class="style11 style12 style1">擬辦</div></td>
    <td width="24%" bgcolor="#FFFFFF"><div align="center" class="style13 style1">複核</div></td>
    <td width="24%" bgcolor="#FFFFFF"><div align="center" class="style13 style1">批示</div></td>
    <td width="6%" bgcolor="#FFFFFF"><div align="center" class="style13 style1">複閱</div></td>
  </tr>
  <tr class="txtblue">
        <td width="6%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
        <td height="150" bgcolor="#FFFFFF" class="txtblue">
          <div align="left" class="txtblue style3">
            <textarea name="<%=sernno%>process" cols="40%" rows="8" id="process"><%=process%></textarea>
	      </div></td>
        <td width="24%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="24%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="6%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
   </tr>
	<!--  <tr>
	    <td height="5" colspan="5">
		<div align="center">
    		<input name="Submit" type="submit" class="fortable" value="Update">　　
    		<input type="reset" name="Submit" value="Reset"></div>
	  </td></tr>-->
</table>
<%
}	
%>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_no_border">
  <!--<tr>
	<td width="30%"><font face="標楷體">&nbsp;表單編號:F-EZ006</font></td>
	<td width="50%">&nbsp;</td>
 	<td width="20%" align="right"><font face="標楷體">&nbsp;版本:AA&nbsp;&nbsp;</font></td>
  </tr>-->
</table>
<table align="center" class="table_no_border">
	  <tr>
	    <td width="153" colspan="6">
   		    <div align="center">
   		        <input type="submit" name="Submit" value="Modify">　　
   		        <input type="reset" name="Submit" value="Reset">
          </div></td></tr>
</table>
</form>				
<%

}
catch(Exception e){
	out.print(e.toString());
}
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(rs3 != null) rs3.close();}catch(SQLException e){}	
	try{if(rs4 != null) rs4.close();}catch(SQLException e){}
	try{if(rsRm != null) rsRm.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(stmt3 != null) stmt3.close();}catch(SQLException e){}	
	try{if(stmt4 != null) stmt4.close();}catch(SQLException e){}	
	try{if(stmtRm != null) stmtRm.close();}catch(SQLException e){}		
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
</body>
</html>
