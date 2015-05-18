<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*,ci.tool.*" %>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 

String formno = request.getParameter("fyy")+request.getParameter("fmm");
String empno = request.getParameter("empno");
String cname = "";
String sern  = "";
String subject = "";
String explain  = "";
String hasSubj = "";
String isDone = "N";
String editing = "N";
String status = "<img src='../../images/ball2.gif' width='18' height='18' border='0' valign='bottom'>首次編輯";

java.util.Date runDate1 = Calendar.getInstance().getTime();
String yyyy  = new SimpleDateFormat("yyyy").format(runDate1);
String mm = new SimpleDateFormat("MM").format(runDate1);
String dd = new SimpleDateFormat("dd").format(runDate1);
String sql 		= "";

if (empno != null)
{//when office view
	userid=empno;
}

/*
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
*/

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

ReplaceAllFor1_3 repstr = new ReplaceAllFor1_3();

try
{
//cn.setORP3EGUser();
/*
cn.setORT1EG();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
stmt = conn.createStatement();
*/
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

//****************************************************************
//Check if the userid exists
sql = "SELECT cname, sern FROM egtcbas where empn = '"+userid+"'";
rs = stmt.executeQuery(sql);
if (rs.next()) 
{
	cname = rs.getString("cname");
	sern = rs.getString("sern");
}
else
{
	//CS user login
	cname = "CSTEAM";
	sern = "666666";
	userid = "635855";
}
//****************************************************************
//Check if new the subject
sql = "SELECT subject, explain FROM egtpsph where formno = '"+formno+"'";

rs = stmt.executeQuery(sql);
if (rs.next()) 
{
	subject = rs.getString("subject");
	explain = rs.getString("explain");
	hasSubj = "Y";
}
else
{
	hasSubj = "N";
}
//****************************************************************
//getQuestions
ArrayList quesNoAL = new ArrayList();
ArrayList quesAL = new ArrayList();

sql = "SELECT itemno, ques FROM egtpspq where formno = '"+formno+"' order by itemno asc";

rs = stmt.executeQuery(sql);

while (rs.next()) 
{
	quesNoAL.add(rs.getString("itemno"));
	quesAL.add(rs.getString("ques"));
}

//****************************************************************
//Check if editing
ArrayList itemnoAL = new ArrayList();
ArrayList itemdscAL = new ArrayList();
ArrayList replyAL = new ArrayList();
itemnoAL.add("");
itemdscAL.add("");
replyAL.add("");

sql = "SELECT itemno, decode(itemdsc,'none','無',itemdsc) itemdsc, decode(itemdsc2,'none',' ',itemdsc2) itemdsc2, reply FROM egtpspa where formno = '"+formno+"' and empno = '"+userid+"' order by empno";

rs = stmt.executeQuery(sql);

while (rs.next()) 
{
	itemnoAL.add(rs.getString("itemno"));
	itemdscAL.add(rs.getString("itemdsc") + " " + rs.getString("itemdsc2"));
	replyAL.add(rs.getString("reply"));
}

if(itemnoAL.size()>1)
{
	editing = "Y";
	status = "<img src='../../images/ball2.gif' width='18' height='18' border='0' valign='bottom'>尚未送出";
}
//****************************************************************
//Check if Done
sql = "SELECT To_Char(senddate,'yyyymmdd') AS senddate, Count(*) as c FROM egtpspo WHERE formno = '"+formno+"' and empno = '"+userid+"' GROUP BY senddate";

rs = stmt.executeQuery(sql);
if (rs.next()) 
{
	if(rs.getInt("c") > 0 )
	{
		String senddate = rs.getString("senddate");
		isDone = "Y";
		status = "";
		yyyy = senddate.substring(0,4);
		mm = senddate.substring(4,6);
		dd = senddate.substring(6);
	}
}

//****************************************************************
//out.print ("cname  = " + cname + "<br>");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="../style3.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function done()
{
	flag = confirm("<%=formno.substring(0,4)%>年<%=formno.substring(4,6)%>月 討論主題發言單已完成，確定送出嗎?");
	
	if (flag) 
	{
		document.form1.action="doneAns.jsp";
		document.form1.submit();
	}
	else
	{
		return false;
	}
}

function subwinXY(w,wname,wx,wy)
{	//設定開始視窗的長寬，開啟位置在螢幕中央，自訂開啟大小
	//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
}
</script>
<style type="text/css">
<!--
.style1 {font-family: Arial, Helvetica, sans-serif}
.style2 {color: #0000FF}
-->
</style>
</head>
<body>
  <%
if (hasSubj.equals("Y"))
{
%>
  <div align="center">
    <h2><span class="style1">座艙長會議<%=formno.substring(0,4)%>年<%=formno.substring(4,6)%>月份討論主題  發言單</span><br>
    </h2>
  </div>
<table width="95%"  border="0" align="center" >
  <tr>
	<td align="right" valign='bottom' class="txtxred"><%=status%>
	</td>
  </tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr valign="middle" bgcolor="#CCCCCC">
    <th height="32"><div align="left">發言人:&nbsp;<%=cname%></div></th>
    <th><div align="left">序號:&nbsp;<%=sern%></div></th>
    <th><div align="right">日期:&nbsp;<%=yyyy%>年<%=mm%>月<%=dd%>日</div></th>
  </tr>
  <tr>
    <td colspan="3"><br>
    <strong>本月主題 :</strong><br>  
		&nbsp;&nbsp;&nbsp;
		<table width="95%"  border="0" align="center">
		<tr align="left">
		<td><%=subject%></td>
		</tr>
		</table>
		<br>
	</td>
  </tr>
  <tr>
   <td colspan="3"><br><strong>背景說明 :</strong><br>
		&nbsp;&nbsp;&nbsp;
		<table width="95%"  border="0" align="center">
		<tr align="left">
		<td><%=explain.replaceAll("\r\n","<br>")%></td>
		</tr>
		</table>
		<br>
   </td>
  </tr>
  <tr>
   <td colspan="3"><br><strong>討論點 :</strong><br>     
        &nbsp;&nbsp;&nbsp;
		<table width="95%"  border="0" align="center">
		<tr align="left">
		<td>
		<%
		if (isDone.equals("Y"))
		{//Done
			for(int k=0; k<quesNoAL.size(); k++)
			{//Display Questiona
		%>
				<strong><%=Integer.parseInt(quesNoAL.get(k).toString())%>. <%=quesAL.get(k)%></strong>
				<table border="0">
		<%
				for(int i=0; i<itemnoAL.size(); i++)
				{//
					if (replyAL.get(i)!= null)
					{				
						if(quesNoAL.get(k).toString().equals(itemnoAL.get(i).toString()))
						{
		%>
							<tr>
							<td width="60" align="right" valign="top">分類 : </td>
							<td align="left"><span class="style2"><%=itemdscAL.get(i)%></span></td>
							</tr>
							<tr>
							<td align="right" valign="top">意見 : </td>
							<td align="left"><%=repstr.replace(replyAL.get(i).toString(),"\r\n","<br>")%></td>
							</tr>
		<%
						}
					}
				}
		%>
		    </table>
				<br>
		<%
			}
		}
		else if (editing.equals("Y"))
		{// editing
			for(int k=0; k<quesNoAL.size(); k++)
			{
		%>
				<strong><%=Integer.parseInt(quesNoAL.get(k).toString())%>. <!--<a href="#" onclick="subwinXY('ans.jsp?cname=<%=cname%>&sern=<%=sern%>&formno=<%=formno%>&itemno=<%=quesNoAL.get(k).toString()%>&editor=<%=userid%>','ans','500','400')"><u><%=quesAL.get(k)%></u></a>--></strong>				
				<a href="ans.jsp?sern=<%=sern%>&formno=<%=formno%>&itemno=<%=quesNoAL.get(k).toString()%>&editor=<%=userid%>"><u><%=quesAL.get(k)%></u></a>
				<table border="0">
		<%
				for(int i=0; i<itemnoAL.size(); i++)
				{//
					if (replyAL.get(i) != null)
					{				
						if(quesNoAL.get(k).toString().equals(itemnoAL.get(i).toString()))
						{
		%>
							<tr>
							<td width="60" align="right" valign="top">分類 : </td>
							<td align="left"><span class="style2"><%=itemdscAL.get(i)%></span></td>
							</tr>
							<tr>
							<td align="right" valign="top">意見 : </td>
							<td align="left"><%=repstr.replace(replyAL.get(i).toString(),"\r\n","<br>")%></td>
							</tr>
		<%
						}
					}
				}
		%>
			  </table><br>
		<%
			}
		}	
		else
		{//first edit
			for(int k=0; k<quesNoAL.size(); k++)
			{
		%>
			<strong><%=Integer.parseInt(quesNoAL.get(k).toString())%>. <!--<a href="#" onclick="subwinXY('ans.jsp?cname=<%=cname%>&sern=<%=sern%>&formno=<%=formno%>&itemno=<%=quesNoAL.get(k).toString()%>&editor=<%=userid%>','ans','500','400')"><u><%=quesAL.get(k)%></u></a>-->
			<a href="ans.jsp?sern=<%=sern%>&formno=<%=formno%>&itemno=<%=quesNoAL.get(k).toString()%>&editor=<%=userid%>"><u><%=quesAL.get(k)%></u></a>
			</strong><br>
                <%
			}
		}
		%>
</td>
		</tr>
		</table>
   </td>
  </tr>
</table>
	<%
    // display when editing
	if (editing.equals("Y") && isDone.equals("N"))
	{
	%>
	<form name="form1" method="post" action="">
	  <div align="center">
	<input name="editor" type="hidden" id="editor" value="<%=userid%>">
	<input name="formno" type="hidden" id="formno" value="<%=formno%>">
	<input type="button" value="完成送出" onclick="done()"> 
	&nbsp;
	  </div>
	</form>
	<%	 
	}
}
else
{
%>
<div align="center" class="txtred2" color="red">
尚無 <%=formno.substring(0,4)%>年<%=formno.substring(4,6)%>月討論主題 </div>
<%
}	
%>
</body>
</html>
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
