<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.gd.*,java.util.*" %>
<%


String userid = (String)session.getAttribute("userid");



if (session.isNew() || userid == null) {	
	 //	response.sendRedirect("../sendredirect.jsp");
	 out.print("網頁已過期，請重新登入");
}else{ 


String yyyy = (String) request.getParameter("yy") ; 
String mm = (String) request.getParameter("mm") ; 
String dd = (String) request.getParameter("dd") ; 
String fltno = (String) request.getParameter("fltno") ; 
String sect = (String) request.getParameter("sect") ; 


//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yyyy,mm);

if( !pc.isPublished()){
//非航務、空服簽派者，才檢查班表是否公佈
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=yyyy+"/"+mm%>班表尚未正式公佈!!
</div>
<%

}else{



PreWebGd we = new PreWebGd();
we.getWebEgData(yyyy+"/"+mm+"/"+dd,fltno,sect);
ArrayList objAL = new ArrayList();
objAL= we.getObjAL();
String str = we.getStr();
String sql = we.getSql();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>PreCheck Flight Crew List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../../style/loadingStatus.css">

<style type="text/css">
body{font-size: 10pt;font-family:Verdana, Arial, Helvetica, sans-serif;padding-top:3em;}
.pointer{cursor:pointer;}
.default{cursor:default;}
</style>
</head>
<body>

<form name="form1" method="post" action="CrewListForPur.jsp" target="_self">
	<input type="hidden"  id="yy" name="yy" value="<%=yyyy%>">
	<input type="hidden"  id="mm" name="mm" value="<%=mm%>">
	<input type="hidden"  id="dd" name="dd" value="<%=dd%>">
	<input type="hidden"  id="fltno" name="fltno" value="<%=fltno%>">
	<input type="hidden"  id="sect" name="sect" >
	<input type="hidden"  id="ftime" name="ftime">
</form>
<script language="javascript" type="text/javascript">
function showCrewList(sect,ftime)
{
	document.getElementById("sect").value = sect;
	document.getElementById("ftime").value = ftime;
	document.getElementById("showMessage").className="showStatus2";
	document.form1.submit();
}


/*
if(top.topFrame.document.getElementById("s1")!= null)
{
	top.topFrame.document.getElementById("s1").disabled=false;
}

if(top.topFrame.document.getElementById("showMessage") != null)
{
	top.topFrame.document.getElementById("showMessage").className="hiddenStatus";
}
*/

if(opener.window.document.getElementById("s1")!= null)
{
	opener.window.document.getElementById("s1").disabled=false;
}

if(opener.window.document.getElementById("showMessage") != null)
{
	opener.window.document.getElementById("showMessage").className="hiddenStatus";
}


</script>
<%

if(objAL.size()>1 | objAL.size()<1)
{	
	if(!"Y".equals(str) || objAL.size() < 1)
	{
		if(!"Y".equals(str))
		{
	%>
		<div class="errStyle1"><%=str%></div>
		<%
		}
		else
		{
	%>
		<div class="errStyle1">No Data Found!!</div>
	    <%
		}
	}
	else
	{
	%>

	
	    <table width="510" border="0" align="center" cellpadding="1" cellspacing="1" style="empty-cells:show;border-collapse:collapse; " >
          <caption style="line-height:2; ">
		  <span style="color:#0000FF; ">Flight Date:<%=yyyy+"/"+mm+"/"+dd%>, Fltno:<%=fltno%> 共有以下 <%=objAL.size()%> 班,</span>
		  <br>
  請依照相關資訊，點選欲查詢的航班
          </caption>
		   <tr style="background-color:#6983AF;color:#FFFFFF;text-align:center; ">
            <td width="70" height="23" >View</td>
            <td width="100" >Flt date</td>            
            <td width="100">FltNo</td>
            <td width="120" >Sector</td>
			<td width="120" >Flt time</td>
          </tr>
          <%
		for(int i=0; i<objAL.size(); i++)
		{
			WebGdObj obj = (WebGdObj) objAL.get(i);
			String bgColor="";
			if (i%2 == 0){
			bgColor = "#FFFFFF";
		}else{
			bgColor = "rgb(231,243,255)";
		}
	
	
		%>
          <tr  bgcolor="<%=bgColor%>"  align="center"  onMouseOver="this.style.background='rgb(255,255,222)';this.className='pointer';" onMouseOut="this.style.background='<%=bgColor%>';this.className='default';" onClick="showCrewList('<%=obj.getDpt()%><%=obj.getArv()%>','<%=obj.getFdate().substring(11)%>');" >
            <td height="34" ><a href="javascript:showCrewList('<%=obj.getDpt()%><%=obj.getArv()%>','<%=obj.getFdate().substring(11)%>');" title="View Flight Crew List"><img src="../images/blue_view.gif" width="16" height="16" border="0"></a></td>
            <td ><%=obj.getFdate().substring(0,10)%></td>            
            <td ><%=obj.getFltno()%></td>
            <td style="color:#0000FF;font-weight:bold; "><%=obj.getDpt()%><%=obj.getArv()%></td>
			<td style="color:#0000FF;font-weight:bold; "  ><%=obj.getFdate().substring(11)%> </td>
          </tr>
          <%
		}//for(int i=0; i<objAL.size(); i++)
%>
</table>
	<div id="showMessage" class="hiddenStatus"><img src="../images/ajax-loader1.gif" width="15" height="15">Loading....</div>

	    <%
	}
}
else
{
	WebGdObj obj = (WebGdObj) objAL.get(0);
	
%>
<div id="showMessage" class="hiddenStatus"><img src="../images/ajax-loader1.gif" width="15" height="15">Loading....</div>

	<script language="JavaScript">
	showCrewList("<%=obj.getDpt()%><%=obj.getArv()%>","<%=obj.getFdate().substring(11)%>");
	</script>
<%
}
%>
</body>
</html>
<%
}
}
%>