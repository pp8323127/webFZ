<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*,java.net.URLEncoder,java.util.*"%>
<%!
public class RealSwapRdObj {
	private String formno;
	private String year;
	private String month;
	private String aEmpno;
	private String aCount;
	private String aComm;
	private String rEmpno;
	private String rCount;
	private String rComm;
	private String chgUser;
	private String chgDate;
	
	public String getAComm() {
		return aComm;
	}
	public void setAComm(String comm) {
		aComm = comm;
	}
	public String getACount() {
		return aCount;
	}
	public void setACount(String count) {
		aCount = count;
	}
	public String getAEmpno() {
		return aEmpno;
	}
	public void setAEmpno(String empno) {
		aEmpno = empno;
	}
	public String getChgDate() {
		return chgDate;
	}
	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}
	public String getChgUser() {
		return chgUser;
	}
	public void setChgUser(String chgUser) {
		this.chgUser = chgUser;
	}
	public String getFormno() {
		return formno;
	}
	public void setFormno(String formno) {
		this.formno = formno;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}

	public String getRComm() {
		return rComm;
	}
	public void setRComm(String comm) {
		rComm = comm;
	}
	public String getRCount() {
		return rCount;
	}
	public void setRCount(String count) {
		rCount = count;
	}
	public String getREmpno() {
		return rEmpno;
	}
	public void setREmpno(String empno) {
		rEmpno = empno;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

}

%>
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
ci.db.ConnDB cn = new ci.db.ConnDB();
ArrayList dataAL = new ArrayList();
try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL() ,null);
stmt = conn.createStatement();

String sql ="select formno,acname,aempno,rcname,checkuser,"
	+"rempno,chg_all,nvl(ed_check,'&nbsp;') ed_check,nvl(comments,'&nbsp;') comments,"
	+"to_char(newdate,'yyyy/mm/dd hh24:mi') newdate,"
	+"nvl(to_char(checkdate,'yyyy/mm/dd hh24:mi'),'&nbsp;') checkdate from fztformf "
	+"where station='KHH' and  (aempno = '"+ QueryID+"' or rempno='"+ QueryID+"') "
	+"and  to_char(newdate,'yyyy') =";


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
rs.close();
sql="";

sql = "SELECT To_Char(r.chgdate,'yyyy/mm/dd') chgDate1,r.* FROM fztrformf r WHERE station='KHH' and  yyyy=";
	if("".equals(year) || null == year){
		sql = sql +" to_char(sysdate,'yyyy') ";

	}else{
		sql = sql +" '"+year+"' ";
	}
sql +=" AND ( aempno ='"+loginID+"' OR rempno = '"+loginID+"') order by formno";


	rs = stmt.executeQuery(sql);
	


	
while(rs.next()){
	RealSwapRdObj obj = new RealSwapRdObj();
	obj.setAComm(rs.getString("acomm"));
	obj.setACount(rs.getString("aCount"));
	obj.setAEmpno(rs.getString("aempno"));
	obj.setChgDate(rs.getString("chgDate1"));
	obj.setChgUser(rs.getString("chguser"));
	obj.setFormno(rs.getString("formno"));
	obj.setMonth(rs.getString("mm"));
	obj.setRComm(rs.getString("rcomm"));
	obj.setRCount(rs.getString("rcount"));
	obj.setREmpno(rs.getString("rempno"));
	obj.setYear(rs.getString("yyyy"));

	dataAL.add(obj);
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
aircrew.CrewCName cc = new aircrew.CrewCName();
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
.tableh {	background-color:#CC6633;
	color:#FFFFCC;
	font-weight:bold;
}
</style>
</head>



 <%
 if(formnoAL.size() > 0){
 %>
<body onLoad="stripe('t1')">
  <div align="center"  style="color:#464883;font-size:16px;font-weight:bold"><% if(!"".equals(year) &&  null != year){out.print(year);}%>
  電子換班單記錄  </div>
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
    <p><!-- <span  style="color:#464883">資料庫每兩小時更新一次，若ED已核准申請單，而班表尚未更新，請耐心稍候。</span> -->
		<span style="color:#FF0000 "><br>
		相同申請單，請勿重複遞單！！</span>
 </p>
</div>

    <%
}else{
%>
<body >
      <div  style="color:#FF0000;text-align:center ">無電子申請單記錄</div>
    <%
}
%>
    <div align="center">
      <%
if(dataAL.size() != 0){
%>
<hr>
實體換班記錄
    </div>
<table width="100%"  border="1" align="center" cellpadding="1" cellspacing="0">
  <tr class="tableh">
    
    <td width="12%" >Formno</td>
    <td width="10%" >換班年月</td>
    <td width="9%" >申請者</td>
    <td width="14%" >姓名</td>
    <td width="11%" >次數計算</td>
    <td width="11%" >被換者</td>
    <td width="13%" >姓名</td>
    <td width="20%" >次數計算</td>
  </tr>
  <%
  for(int i=0;i<dataAL.size();i++){
	  RealSwapRdObj obj = (RealSwapRdObj)dataAL.get(i);
  %>
  <tr>
    <td ><%=obj.getFormno()%></td>
    <td ><%=obj.getYear()+"/"+obj.getMonth()%></td>
    <td ><%=obj.getAEmpno()%></td>
    <td ><%=cc.getCname(obj.getAEmpno())%></td>
    <td ><%=obj.getACount()%></td>
    <td ><%=obj.getREmpno()%></td>
    <td ><%=cc.getCname(obj.getREmpno())%></td>
    <td ><%=obj.getRCount()%></td>
  </tr>
  <%
  }
  %>
</table>
<%
}
%>
</body>
</html>
