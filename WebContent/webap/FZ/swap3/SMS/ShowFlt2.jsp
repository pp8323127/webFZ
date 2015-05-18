<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,fz.*,java.util.ArrayList,fz.esms.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
//顯示當日非航班的duty（ex:s1...）
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

//為避免抓到之前的session,先清除
session.setAttribute("fltnoList",null);
session.setAttribute("fltAL",null);
session.setAttribute("crewList",null);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Show flt</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>
<script language="JavaScript"  src="../js/changeAction.js" type="text/JavaScript"></script>
<script language="JavaScript"   type="text/JavaScript">
function addEmp(){
	if(document.form1.addEmpno.value =="") {

		alert('Please insert Empno');
		document.form1.addEmpno.focus();
		return false;
	}else{
		preview('form1','ShowFlt2AE.jsp');
		return true;
	}
}

</script>
</head>

<body>
<p></p>
  <%
//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//*************************************
String y = request.getParameter("yy");
String m = request.getParameter("mm");
String d = request.getParameter("dd");
String requestFdate = y+"/"+m+"/"+d;


String fdate 	= null;
String fltno 	= null;
String dpt		= null;
String arv 		= null;
String btime 	= null;
String etime 	= null;
boolean isAllDay = false;

/*
String sql = "select DISTINCT fdate, dutycode fltno, dpt, arv,btime,etime FROM "+ct.getTable()+
			 " where dpt='TPE' AND fdate='"+requestFdate+"' "+
			 " AND substr(trim(dutycode),1,1) in ('0','1','2','3','4','5','6','7','8','9','S') "+
			 " ORDER BY fdate,btime,dutycode";
			 */
//out.print(sql);
String sql=null;
if(null == request.getParameter("classType") | "".equals(request.getParameter("classType"))){
sql = "select DISTINCT fdate, dutycode ,btime,etime  FROM "+ct.getTable()
		+" where fdate='"+requestFdate+"'  AND trim(dpt) IS NULL "
		+"AND trim(btime) IS NOT NULL  AND dutycode <> 'AL' AND dutycode <> 'SL' "
		+"ORDER BY "
		+"  CASE  WHEN SubStr(dutycode,1,1)='S' "
	    +" THEN ''    ELSE dutycode     end  DESC";
isAllDay = true;		

}else{
	String classType = request.getParameter("classType").toUpperCase();
sql = "select DISTINCT fdate, dutycode ,btime,etime  FROM "+ct.getTable()
		+" where fdate='"+requestFdate+"' AND dutycode = '"+classType+"' ";
}




Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
String bcolor=null;
ArrayList fltnoList = new ArrayList();//將fltno存入ArrayList
ArrayList fltAL = new ArrayList();
ArrayList crewList = new ArrayList();//將組員名單存入ArrayList


try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();
rs = stmt.executeQuery(sql);

while(rs.next()){
	 FltObj  obj = new FltObj();
	obj.setFdate(rs.getString("fdate"));
	obj.setFltno(rs.getString("dutycode"));
	obj.setBtime(rs.getString("btime"));
	obj.setEtime(rs.getString("etime"));

	fltnoList.add(fltno);
	fltAL.add(obj);
}
session.setAttribute("fltnoList",fltnoList);
session.setAttribute("fltAL",fltAL);
}
catch (Exception e)
{
	  t = true;
	  out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

if(!isAllDay){
sql = "select a.empno empno,b.NAME cname, a.dutycode fltno,a.fdate,"
	+" b.occu occu, eg.smsphone "
	+" FROM "+ct.getTable()+" a, fztcrew b,egtcbas eg "
	+" where a.empno=b.empno and a.empno=Trim(eg.empn) and  b.occu in('FA','FS','PR') "
	+" and a.fdate='"+requestFdate+"' and trim(a.dutycode)='"
	+request.getParameter("classType").toUpperCase()
	+"'  order by b.occu desc,a.empno";

try{
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();


rs = stmt.executeQuery(sql);
while(rs.next()){
	CrewListObj obj = new CrewListObj();
	obj.setCrewName(rs.getString("cname"));
	obj.setEmpno(rs.getString("empno"));
	obj.setOccu(rs.getString("occu"));
	obj.setSmsPhone(rs.getString("smsphone"));
	crewList.add(obj);
	
}
session.setAttribute("crewList",crewList);

}catch (SQLException e){
	  t = true;
	  out.print(e.toString());
}catch (Exception e){
	  t = true;
	  out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
//out.print("isAllDay = "+isAllDay+"<BR>crewList.size() = "+crewList.size());
}

if(fltAL.size() == 0){

%>
	<p style='text-align:center'><span class="txtxred">查無資料!!</span><span class="txtblue"><br>
  可能為無此課程代號:<span class="txtxred"><%=request.getParameter("classType")%></span><br>
  或超過系統保存班表之兩個月期限。</span></p>
	<p style='text-align:center'><a href="javascript:history.back(-1)">BACK</a></p>
<%	

}else if(fltAL.size() != 0 && !isAllDay && crewList.size() == 0){//非全日,且無組員名單

%>

	<p style='text-align:center'><span class="txtblue">課程代號:<span class="txtxred"><%=request.getParameter("classType")%></span>無後艙組員資料!!<br>
    本系統僅提供製作後艙組員手機號碼名單</span>.<br><br>
<a href="javascript:history.back(-1)">BACK</a></p>

<%

}else if(fltAL.size() != 0){
%>

<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="17%">
      <div align="center">Date(Taipei)</div>
    </td>
    <td width="10%">
      <div align="center">Flt</div>
    </td>
    <td width="15%">BTime</td>
    <td width="15%">ETime</td>
  </tr>
  <%
	for(int i=0;i<fltAL.size();i++){
			FltObj fObj = (FltObj)fltAL.get(i);

		if (i%2 == 0){
			bcolor = "#FFFFFF";
		}
		else{
			bcolor = "#99CCFF";
		}
  
  %>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=fObj.getFdate()%></td>
    <td class="tablebody"><%=fObj.getFltno()%></td>
    <td class="tablebody"><%=fObj.getBtime()%></td>
    <td class="tablebody"><%=fObj.getEtime()%></td>
  </tr>

<%
		}


%>


</table>
<%
}

if(!isAllDay && crewList.size() >0 ){//非全日,且有組員名單


%>

<hr>

<div align="center" class="txtblue">組員名單
</div>
<form name="form1" method="post" action="ShowFlt2AE.jsp"  onSubmit="return checkSelect('form1','delEmpno')">

<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="1" class="fortable">
  <tr class="tablehead3">
    <td width="11%">
      <div align="center">Date</div>
    </td>
    <td width="14%">
      <div align="center">Flt</div>
    </td>
    <td width="13%">
      <div align="center">Crew</div>
    </td>
    <td width="21%">Empno</td>
    <td width="8%">
      <div align="center">Occu</div>
    </td>
    <td width="22%">
      <div align="center">MobilPhone</div>
    </td>
    <td width="11%">Delete</td>
  </tr>
  <%
  for(int i=0;i<crewList.size();i++){
	CrewListObj obj = (CrewListObj)crewList.get(i);

		if (i%2 == 0){
			bcolor = "#FFFFFF";
		}
		else{
			bcolor = "#99CCFF";
		}
	
  %>
  <tr class="tablebody" bgcolor="<%=bcolor%>">
    <td>
      <div align="center"><%=requestFdate%></div>
    </td>
    <td>
      <div align="center"><%=request.getParameter("classType")%></div>
    </td>
    <td>
      <div align="center"><%=(String)obj.getCrewName()%></div>
    </td>
    <td>
      <div align="center"><%=(String)obj.getEmpno()%></div>
    </td>
    <td>
      <div align="center"><%=(String)obj.getOccu()%></div>
    </td>
    <td>
      <div align="center"><%=(String)obj.getSmsPhone()%></div>
    </td>
    <td>
      <input name="delEmpno" type="checkbox"  value="<%=i%>">
    </td>
  </tr>
  <%
  }
  %>
  <tr >
    <td colspan="7">
      <div align="center">
	  <input type="hidden" name="requestFdate" value="<%=requestFdate%>">
	  <input type="hidden" name="classType" value="<%=request.getParameter("classType")%>">
        <input type="submit" value="Delete" class="delButon">
      </div>
    </td>
  </tr>
</table> 
<br>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >

  <tr>
    <td>
      
        <span class="txtblue">新增組員，請輸入員工號（Add Empno）：</span>
        <input type="text" name="addEmpno" size="6" maxlength="6">
        <input type="button" name="addEmpSubmit" value="Add" onClick="return addEmp()" >
      
    </td>
  </tr>
  <tr >
    <td class="txtblue" >

        <div align="center">
          <input type="button" name="makeFile" value="Make File" onclick="preview('form1','SMSMakeFile2AE.jsp')">
&nbsp;&nbsp;&nbsp;&nbsp;        </div>

    </td>
  </tr>
</table>
</form>

<%
}//end of 非全日,且有組員名單





%>
</body>
</html>

