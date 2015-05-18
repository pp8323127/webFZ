<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,fz.*,java.util.ArrayList"%>
<%!
public class FltObj {
	
	private String	fdate;
	private String	fltno;
	private String	btime;
	private String	etime;

	public String getBtime() {
		return btime;
	}

	public void setBtime(String btime) {
		this.btime = btime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public String getFltno() {
		return fltno;
	}

	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
}
%>
<%
//刪除航班後，顯示刪除後要製作檔案的航班
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

ArrayList fltnoListAL = new ArrayList();
ArrayList fltAL = new ArrayList();
if(null != session.getAttribute("fltnoList")){
 fltnoListAL=(ArrayList)session.getAttribute("fltnoList");//全部的fltList
}

if(null != session.getAttribute("fltAL")){
 fltAL=(ArrayList)session.getAttribute("fltAL");
}

String[] delFltno = request.getParameterValues("delFltno");

for(int i=0;i<fltnoListAL.size();i++){
	for(int index=0;index<delFltno.length;index++){
		int removeIndex = Integer.parseInt(delFltno[index]);
		fltnoListAL.remove(removeIndex);	
	}
}

for(int i=0;i<fltAL.size();i++){
	for(int index=0;index<delFltno.length;index++){
		int removeIndex = Integer.parseInt(delFltno[index]);
		fltAL.remove(removeIndex);	
	}
}




%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Show Flight After del</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>


</head>

<body>
<p>
  <%
//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//*************************************

String requestFdate = request.getParameter("requestFdate").trim();
String y = requestFdate.substring(0,4);
String m = requestFdate.substring(5,7);
String d = requestFdate.substring(8,10);

if(delFltno == null ){
%>
	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>Error!!<br>尚未選擇要刪除何筆資料<br></p>" />
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>BACK</p>" />
	<jsp:param name="linkto" value="javascript:history.back(-1)"/>
	</jsp:forward>
<%
}

String bcolor= null;
if(fltAL.size() !=0){
%>
</p>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0"  >
  <tr >
    <td class="txtblue" >
      <form name="form1" method="post" >
        <div align="center"> 
         <input type="submit" name="Submit" value="Make File"  class="btm" >
        </div>
      </form>
    </td>
  </tr>
</table>
<form name="form2"  target="_self" method="post" onSubmit="return del()">
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
    <td width="9%">
      <div align="center">Crew</div>
    </td>
    <td width="9%">Delete</td>
  </tr>
    <%
	for(int index=0;index<fltAL.size();index++){
			FltObj fObj = (FltObj)fltAL.get(index);
		
		
	
		if (index%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}
  
  %>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=fObj.getFdate()%></td>
    <td class="tablebody"><%=fObj.getFltno()%></td>
    <td class="tablebody"><%=fObj.getBtime()%></td>
    <td class="tablebody"><%=fObj.getEtime()%></td>

    <td class="tablebody"><a href="#" onClick="subwinXY('Show1FltNoMake.jsp?yy=<%=y%>&mm=<%=m%>&dd=<%=d%>&fltno=<%=fObj.getFltno()%>&showMakeFile=N','showFlt','750','500')" ><img src="../images/userlist.gif" border="0"></a></td>
    <td class="tablebody"><input type="checkbox" name="delFltno" value="<%=index%>">  </td>
  </tr>
  <%
  		}

   %>
</table>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >
<tr>
	<td colspan="3">
	  <div align="center">
	    <input type="submit" value="Delete" class="delButon">
	    <br>
	    </div>
	</td>
</tr>
<tr>
  <td width="29%">&nbsp;</td>
  <td width="49%">
    <p class="txtxred">註：此處不提供修改單一航班組員名單， 若欲更動，請<br>
取消此航班，另行於輸入Fltno後顯示的組員名單中增刪。</p>
    </td>
  <td width="22%">&nbsp;</td>
</tr>
</table>
</form>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" >
        <div align="center"> 
         <input type="submit" name="Submit" value="Make File" class="btm" >
        </div>
      </form>
    </td>
  </tr>
</table>
<%
}else{

%>

	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>查無資料，本系統只保留兩個月內的航班資料</p>"/>
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>BACK</p>" />
	<jsp:param name="linkto" value="javascript:history.back(-1)"/>
	</jsp:forward>

<%

}

session.setAttribute("fltnoList",fltnoListAL);


%>

</body>
</html>
