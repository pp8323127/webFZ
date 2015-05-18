<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*,java.net.URLEncoder,java.util.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String loginID = (String)session.getAttribute("userid");
String QueryID = null;
if("".equals(request.getParameter("userid")) 
	|| null ==request.getParameter("userid") ){	//無傳入userid,查詢自己的紀錄
		if(loginID != null)
			QueryID =  loginID;
}else{
	QueryID = request.getParameter("userid");
}



String year = request.getParameter("year");

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql ="select formno,acname,aempno,rcname,checkuser,"
	+"rempno,chg_all,nvl(ed_check,'&nbsp;') ed_check,nvl(comments,'&nbsp;') comments,"
	+"to_char(newdate,'yyyy/mm/dd hh24:mi') newdate,"
	+"nvl(to_char(checkdate,'yyyy/mm/dd hh24:mi'),'&nbsp;') checkdate from fztform "
	+"where (aempno = '"+ QueryID+"' or rempno='"+ QueryID+"') "
	+"and  to_char(newdate,'yyyy') =";

ArrayList formnoAL = new ArrayList();
ArrayList aCnameAL = new ArrayList();
ArrayList aEmpnoAL  = new ArrayList();
ArrayList rCnameAL  = new ArrayList();
ArrayList rEmpnoAL = new ArrayList();
ArrayList edCheckAL  = new ArrayList();
ArrayList commentsAL  = new ArrayList();
ArrayList newDateAL  = new ArrayList();
ArrayList checkDateAL  = new ArrayList();
ArrayList chgAllAL  = new ArrayList();
String bcolor=null;
ConnDB cn = new ConnDB();

try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL() ,null);
stmt = conn.createStatement();

//cn.setORP3FZUser();
/*cn.setORT1FZ();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
stmt = conn.createStatement();
*/


if("".equals(year) || null == year){
	sql = sql +" to_char(sysdate,'yyyy') order by formno";

}else{
	sql = sql +"'"+year+"' order by formno";
}




rs = stmt.executeQuery(sql);
while(rs.next()){

		formnoAL.add(rs.getString("formno"));
		aCnameAL.add(rs.getString("acname"));
		aEmpnoAL.add(rs.getString("aempno"));
		rCnameAL.add(rs.getString("rcname"));
		rEmpnoAL.add(rs.getString("rempno"));		
		edCheckAL.add(rs.getString("ed_check"));
		commentsAL .add(rs.getString("comments"));
		newDateAL.add(rs.getString("newdate"));
		checkDateAL.add(rs.getString("checkdate"));
		chgAllAL.add(rs.getString("chg_all"));	



}


}catch (SQLException e){
  	  out.print(e.toString());

}catch (Exception e){
  	  out.print(e.toString());

}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<html>
<head>
<title>申請單記錄</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="javascript" type="text/javascript" src="../js/color.js"></script>
<style type="text/css">
body{
	font-family:Courier New,Verdana;
	font-size:10pt;
	
}
table td{
border:1pt solid #CCCCCC;font-size:10pt; text-align:center}

.selected  {	
	background-color: #60A3BF;
	color:#FFFFFF;
	font-weight: bold;
	text-align:center

}
</style>
</head>



 <%
 if(formnoAL.size() > 0){
 %>
<body onLoad="stripe('t1')">
  <div align="center"  style="color:#464883;font-size:16px;font-weight:bold">申請單記錄  </div>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" id="t1">
      <tr class="selected"> 
        <td width="9%" class="selected">No</td>
        <td width="6%" class="selected">ChgAll</td>
        <td width="10%" class="selected">Applicant</td>
        <td width="9%" class="selected">Aname</td>
        <td width="8%" class="selected">Replacer</td>
        <td width="9%" class="selected">Rname</td>
        <td width="4%" class="selected">ED</td>
        <td width="12%" class="selected">Check Date</td>
        <td width="11%" class="selected">Apply Date </td>
        <td width="16%"> ED Comments </td>
        <td width="6%">Detail</td>
      </tr>
      <%
for(int i =0;i<formnoAL.size();i++){

%>
      <tr > 
	  <td><%=formnoAL.get(i)%></td>
	  <td><%=chgAllAL.get(i)%></td>
      <td><%=aEmpnoAL.get(i)%></td>
      <td><%=aCnameAL.get(i)%></td>
	  <td><%=rEmpnoAL.get(i)%></td>
	  <td><%=rCnameAL.get(i)%></td>
      <td><%=edCheckAL.get(i)%></td>
      <td><%=checkDateAL.get(i)%></td>
      <td><%=newDateAL.get(i)%></td>
      <td><%=commentsAL.get(i)%></td>

	  
	  
        <td> 
          <div align="center"><a href="showForm.jsp?formno=<%=formnoAL.get(i)%>" target="_blank"> 
            <img src="../images/red.gif" width="15" height="15" border="0" alt="Detail"></a></div>
        </td>
      </tr>
      <%
	}

%>
</table>
  <div align="center">
    <p><span  style="color:#464883">資料庫每兩小時更新一次，若ED已核准申請單，而班表尚未更新，請耐心稍候。</span>
		<span style="color:#FF0000 "><br>
		相同申請單，請勿重複遞單！！</span>
 </p>
</div>

    <%
}else{
%>
<body >
      <div  style="color:#FF0000;text-align:center ">無申請單記錄</div>
    <%
}
%>

</body>
</html>
