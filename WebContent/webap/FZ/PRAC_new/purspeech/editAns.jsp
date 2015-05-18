<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String formno = (String) request.getParameter("formno") ; 
String itemno = (String) request.getParameter("itemno") ; 
String editor = (String) request.getParameter("editor") ; 
String itemdsc = (String) request.getParameter("item1") ; 
String itemdsc2 = (String) request.getParameter("item2") ; 
String sql = "";
String bgColor="";
String reply = "";
String ques = "";
String isFirst = "Y";

//editor="635855";
//out.print(userid+"/"+itemno+"/"+editor+"/"+itemdsc+"/"+itemdsc2+"<BR>");

ArrayList itemNoAL = new ArrayList();
ArrayList itemDscAL = new ArrayList();
itemNoAL.add("");
itemDscAL.add("");


if (userid == null) {		
	response.sendRedirect("../sendredirect.jsp");
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

try{
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

//get Question
sql = "select ques from egtpspq where formno = '" + formno + "' and itemno = '"+itemno+"' ";

rs = stmt.executeQuery(sql);
if(rs.next())
{
	ques = rs.getString("ques");
}
else
{
	ques = "";
}

// get reply
if (itemdsc.equals("none"))
{
	sql = "select reply from egtpspa where formno = '" + formno + "' and itemno = '"+itemno+"' and empno = '"+editor+"'";
}
else
{
	if (itemdsc2.equals("none"))
	{
		sql = "select reply from egtpspa where formno = '" + formno + "' and itemno = '"+itemno+"' and empno = '"+editor+"' and itemdsc = '"+itemdsc+"' ";
	}
	else
	{
		sql = "select reply from egtpspa where formno = '" + formno + "' and itemno = '"+itemno+"' and empno = '"+editor+"' and itemdsc = '"+itemdsc+"' and itemdsc2 = '"+itemdsc2+"' ";
	}
}

rs = stmt.executeQuery(sql);
if (rs.next())
{
	reply = rs.getString("reply");
	isFirst = "N"; //update
}
else
{
	reply = "";
	isFirst = "Y"; //insert
}

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit opinions </title>
<link href="../style3.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function draft()
{
		document.form1.action="updAns.jsp?status=draft";
		document.form1.submit();
}

function done()
{
	var colValue = eval("document.form1.reply.value");
	if(colValue =="")
	{
		alert("The field could not be empty !!");
		document.form1.reply.focus();
		return false;
	}

	flag = confirm("<%=formno.substring(0,4)%>年<%=formno.substring(4,6)%>月 討論主題發言單已完成，確定送出嗎?");
	
	if (flag) 
	{
		document.form1.action="updAns.jsp?status=done";
		document.form1.submit();
	}
	else
	{
		return false;
	}
}
</script>
</head>

<body>
<form name="form1" method="post" action="">
<input name="editor" type="hidden" id="editor" value="<%=editor%>">
<input name="formno" type="hidden" id="formno" value="<%=formno%>">
<input name="itemno" type="hidden" id="itemno" value="<%=itemno%>">
<input name="itemdsc" type="hidden" id="itemdsc" value="<%=itemdsc%>">
<input name="itemdsc2" type="hidden" id="itemdsc" value="<%=itemdsc2%>">
<input name="isFirst" type="hidden" id="isFirst" value="<%=isFirst%>">
<div align="center">
<br>
  <table width="60%" border="0" align="center">
    <tr>
      <td  bgcolor="#CCCCCC" class= "txtblue" align="left" ><strong><%=ques%>
        <%
	  if (!itemdsc.equals("none"))
	  {//display classification
		if(itemdsc2.equals("none"))
		  {
	  %>
&nbsp;( <%=itemdsc%> )
	  <%
		  }
		  else
		  {
	  %>
&nbsp;( <%=itemdsc%> - <%=itemdsc2%> )
	  <%
		  }
	  }
	  %>
            </strong> </td>
	</tr>
	<tr>
      <td>
          <div align="left">
            <textarea name="reply" cols="60" rows="15"><%=reply%></textarea> 
          </div>
      </td>
    </tr>
    <tr>
      <td  align="center">
	  <input type="button"  value="儲存草稿/Save" onclick="draft()"> &nbsp;
	  <input type="button" value="上一頁/Previous page" onclick="javascript:window.history.back()">
	  <!--<input type="button"  value="完成送出" onclick="done()"> &nbsp;-->
	  <!--<input name="reset" type="reset"  value="回復"> &nbsp;-->
	  <!--<input type="button" name="close" value="關閉視窗/Close"  onclick="window.close()">-->
	  </td>
	</tr>
	<tr>
      <td>
          <div align="center" class="txtxred">
		    <table width="90%" border="0" align="center" class="txtxred">
			  <tr>
			    <td align="left" > 
					A.輸入限制: 英文3000字，中文1500字。         
				</td>
			  </tr>
			</table>
          </div>
      </td>
    </tr>
	<tr>
      <td>
          <div align="center" class="txtxred">	
		    <table width="90%" border="0" align="center" class="txtxred">
			  <tr>
			    <td align="left"> 
				B.為安全考量，系統設定30分鐘內若無任何動作，將自動登出系統。
				</td>
			  </tr>
			  <tr>
			    <td align="left"> 
				&nbsp;&nbsp;&nbsp;&nbsp;若輸入的內容很多，建議步驟如下：
				</td>
			  </tr>
			  <tr>
			    <td align="left">
				&nbsp;&nbsp;1.先於自己電腦上，開啟「記事本」(notepad)或Word等文書編輯
				</td>
			  </tr>
			  <tr>
			    <td align="left"> 
		  		&nbsp;&nbsp;&nbsp;&nbsp;軟體，將文字內容輸入完畢。
				</td>
			  </tr>
			  <tr>
			    <td align="left"> 
				&nbsp;&nbsp;2.輸入完畢，選擇上方工具列之「編輯」->「全選」
				</td>
			  </tr>
			  <tr>
			    <td align="left"> 
		    	&nbsp;&nbsp;3.再選擇上方工具列之「編輯」->「複製」
				</td>
			  </tr>
			  <tr>
			    <td align="left">
			    &nbsp;&nbsp;4.登入組員班表資訊網，進入Purser Report -> 座艙長發言單功能		  			
				</td>
			  </tr>
			  <tr>
			    <td align="left"> 
				&nbsp;&nbsp;5.於報告中欲輸入文字的地方，按滑鼠右鍵，選擇「貼上」，並點選
				</td>
			  </tr>
			  <tr>
			    <td align="left"> 
				&nbsp;&nbsp;&nbsp;&nbsp;Save按鈕即可。            
				</td>
			  </tr>
			</table>
          </div>
      </td>
    </tr>
  </table>
</div>
</body>
</form>
</html>
