<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,fz.*,java.util.ArrayList,fz.esms.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//顯示當日非航班的duty（ex:s1...）名單已編輯過.
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

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

try{
String classType = request.getParameter("classType");
String requestFdate = request.getParameter("requestFdate");
ArrayList fltAL = (ArrayList)session.getAttribute("fltAL");
ArrayList crewList = (ArrayList)session.getAttribute("crewList");//上一頁的crewList

//out.print("fltAL.size() = "+fltAL.size()+"<BR>crewList.size() = "+crewList.size()+"<BR>" );
String[] delEmpno = null;
String addEmpno = null;
boolean duplicateEmp = false;
String bcolor=null;


if( null != request.getParameterValues("delEmpno")){//刪除
	 delEmpno= request.getParameterValues("delEmpno");
 	for ( int i = 0; i < delEmpno.length; i++) {//移除刪掉的員工號
	
		crewList.remove(Integer.parseInt(delEmpno[i]));
	
	}
	session.setAttribute("crewList",crewList);	//移除刪掉的員工號，並存回session值

}else{	//新增
	addEmpno = request.getParameter("addEmpno");
	
	for(int i=0;i<crewList.size();i++){	//檢查新增的組員是否已重複
		CrewListObj obj =(CrewListObj)crewList.get(i);
		if(obj.getEmpno().equals(addEmpno)){
			duplicateEmp = true;
		}
	}	
}


//新增組員時，查詢其資料並於crewList中新增

if(!duplicateEmp){	//新增的組員並未重複，才抓資料
	String sql  = "select c.empno empno,c.name cname,c.ename ename,c.occu occu,eg.smsphone smsphone "+
					"from fztcrew c,egtcbas eg "+
					"where c.empno = Trim(eg.empn) "+
					"and c.empno ='"+addEmpno+"'";
	
	
					
	Driver dbDriver = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
	
	dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
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
	
	}catch(SQLException e){
		out.print(e.toString());
	} catch(Exception e){
		out.print(e.toString());
	}finally{
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	}
	


}

if(fltAL.size() != 0){
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
} //end of fltAL.size() !=0

if(crewList.size() >0 ){//非全日,且有組員名單


%>

<hr>

<div align="center" class="txtblue">組員名單
</div>
<form name="form1" method="post"  onSubmit="return checkSelect('form1','delEmpno')">

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


}catch(ClassCastException e){
	out.print(e.toString());
	
}catch(Exception e){
		out.print(e.toString());
}


%>
</body>
</html>

