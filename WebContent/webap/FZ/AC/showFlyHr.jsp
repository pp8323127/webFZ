<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>����</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="../style2.css">

<script type="text/javascript" language="javascript" src="../js/color.js"></script>
<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>

</head>
<%
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
if("".equals(request.getParameter("fltno"))){
	fltno = null;
}
if(fdate != null && !"".equals(fdate)){

fzac.FlyingTime ft = new fzac.FlyingTime(fdate, fltno);
ArrayList al = new ArrayList();
try {
	ft.initData();
	al = ft.getDataAL();	
} catch (SQLException e) {
	System.out.print("ShowFlyHr exception: "+e.toString());
} catch (ClassNotFoundException e) {
	System.out.print("ShowFlyHr exception: "+e.toString());
}

//�ˬd�Z��O�_����
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(fdate.substring(0,4), fdate.substring(5,7));

%>

<%
//�Z��O�_����
 if(!pc.isPublished()){
%>
<body>
<p  class="errStyle1"><%=fdate.substring(0,4)+"/"+fdate.substring(5,7)%> �Z��|�����������A���o�d��.</p>
<%
}else 
if(!ci.tool.CheckDate.isValidateDate(fdate)){	//�����T�����
%>
<body>
<div class="errStyle1">Flight Date : <%=fdate%> �D���Ĥ��!!<br>
�Э��s���Flight Date�d�߱���!!</div>
<%
}else if(al == null){
%>
<body>
<div class="errStyle1">No DATA!!</div>

  <%

}else{
//�g�Jlog
fz.writeLog wl = new fz.writeLog();

wl.updLog((String)session.getAttribute("userid"), request.getRemoteAddr(),request.getRemoteHost(), "FZ410");

%>
<body onLoad="stripe('t1')">
<div   align="center" style="font-size:10pt;font-family:Verdana;color:#000000;width:100%;text-align:center ">
  <div align="center"><span>Flying Time Query<br>
      Date:<%=fdate%> &nbsp;&nbsp;&nbsp;
      <%if(fltno != null){out.print("Fltno:"+fltno);}%>
    </span>
      <br><div style="width:60%;text-align:left;color:red;" >
        ����Ƭ��Utrip����
          �A�L�k��ܸ��ɼ�.<br>
        ���Z�����ɡA�ХH��ڴ��Z�ɤ��ӤH�Z���ɸ�Ƭ���.<br>
      </div>
        
</div>
</div>
<table width="60%" border="1" align="center" cellpadding="1" cellspacing="1" id="t1">
<tr class="sel3">
	<td>Fdate<br>(Local)</td>
	<td>Fltno</td>
	<td>Fly Hrs<BR>(HHMM)</td>
	<td>Sector</td>
	<td>Detail</td>
</tr>
<%
	for (int i = 0; i < al.size(); i++) {
	fzac.FlyingTimeObj o = (fzac.FlyingTimeObj) al.get(i);
%>

<tr>
  <td><%=o.getFdateLocal()%></td>
  <td><%=o.getFltno()%></td>
  <td><%=o.getFlyTimeHHMM()%></td>
  <td><%=o.getDpt()+o.getArv()%></td>
  <td><span class="tablebody"><a href="#" onClick="subwinXY('../swap3ac/tripInfo.jsp?tripno=<%=o.getSeries_num()%>','t','600','250')" ><img height="16" src="../img2/doc3.gif" width="16" border="0"></a></span></td>  
</tr>
<%	

//	out.println(o.getFdateLocal() + "\t" + o.getFltno()				+ "\t" + o.getFlyTimeHHMM() + "\t" + o.getSeries_num()+"\t"+o.getDpt()+o.getArv()+"<BR>");
	}
%>

</table>


<%
}



}else{
%>
<body>
<p  class="errStyle1">�t�Φ��L��!!�еy�᭫�s�d��</p>

<%
}
%>

</body>
</html>
