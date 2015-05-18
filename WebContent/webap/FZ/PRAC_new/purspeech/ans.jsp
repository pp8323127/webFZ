<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,ci.db.*"%>
<%@ page import=" java.net.URLEncoder"%>
<%
String formno = (String) request.getParameter("formno") ; 
String itemno = (String) request.getParameter("itemno") ; 
String userid = (String) session.getAttribute("userid") ;
//String cname = (String) request.getParameter("cname") ;
String sern = (String) request.getParameter("sern") ; 
String editor = (String) request.getParameter("editor") ; 
int count = 0;

if (userid == null) 
{		
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
String sql = null;
StringBuffer selText = new StringBuffer();

try
{
/*
cn.setORT1EG();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
stmt = conn.createStatement();
*/
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
selText.append("var item1 = new Array();\r\n");
selText.append("var item2 = new Array();\r\n ");
			
//sql = "select itemdsc,seqno from egtpspi order by seqno";
sql = "SELECT itemdsc,seqno FROM egtpspi where formnoi = '"+formno+itemno+"' order by seqno";
rs = stmt.executeQuery(sql);

rs.last();
count = rs.getRow();//取得筆數
rs.beforeFirst();

//no subitem
if(count > 0)
{
	int i=0;
	while(rs.next())
	{
		selText.append("item1[" + i + "]=new Array(\""
		+ rs.getString("seqno") + "\",\""
		+ rs.getString("itemdsc") + "\");\r\n");

		selText.append("item2["+i+"]=new Array();\r\n");
		i++;
	}

	sql ="select a.itemdsc itemdsc,nvl(a.seqno,'') seqno,b.itemdsc2  itemdsc2 from egtpspi a, egtpspi2 b where a.seqno=b.seqno (+) and formnoi='"+formno+itemno+"' order by a.seqno";
	i=0;
	int prevSeqno = 0;
	rs = stmt.executeQuery(sql);
	rs.last();
	int totalRowCount = rs.getRow();	//取得資料總筆數
	rs.beforeFirst();
	int j = 0;	
	while(rs.next())
	{
	
	int rowCount = rs.getRow();

		if(totalRowCount == 1 || rs.getRow() == 1){//只有一筆時,or 第一筆
			if(null == rs.getString("itemdsc2")  ){
					selText.append("item2["+(rowCount-1)+"]["+i+"]=\"none\";\r\n");
				
			}else{
					selText.append("item2["+(rowCount-1)+"]["+i+"]=\""+rs.getString("itemdsc2")+"\";\r\n");
			}
			
		}/*
		//TODO
		else if(rs.getRow() == 1  ){//第一筆
		
			if(null == rs.getString("itemdsc2")  ){
				selText.append("item2["+(rowCount-1)+"]["+i+"]=\"none\";\r\n");
			}else{
				selText.append("item2["+(rowCount-1)+"]["+i+"]=\""+rs.getString("itemdsc2")+"\";\r\n");
			}
		}*/
		else{	
			if(rs.getInt("seqno") != prevSeqno){
					i=0;
					j=j+1;
			}else{
			
			}
				
				   
			if(null == rs.getString("itemdsc2")  )
			{
				
				selText.append("item2["+j+"]["+i+"]=\"none\";\r\n");
			}
			else
			{
								
		 	selText.append("item2["+j+"]["+i+"]=\""+rs.getString("itemdsc2")+"\";\r\n");
			
			}   
		}
		 prevSeqno = rs.getInt("seqno");
		i++;
	}

}
else
{
	response.sendRedirect("editAns.jsp?formno="+formno+"&itemno="+itemno+"&editor="+editor+"&item1=none&item2=none");	
}//if(count >0)


}
catch (Exception e)
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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit opinions</title>
<link href ="../style2.css" rel="stylesheet" type="text/css">
<script src="../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">   

// 通常，當資料選項的變動性不大時，都會直接寫成 .js 檔含入即可。
<%=selText.toString()%>


// 載入 master 選單，同時初始化 detail 選單內容
function loadMaster( master, detail ) {
	master.options.length = item1.length;
	
	for( i = 0; i < item1.length; i++ ) {
		master.options[ i ] = new Option( item1[i][1], item1[i][1] );  // Option( text , value );    
	}
	master.selectedIndex = 0;
	doNewMaster( master, detail );    
	
}    
// 當 master 選單異動時，變更 detail 選單內容
function doNewMaster( master, detail )
{
	detail.options.length = item2[ master.selectedIndex ].length;     
	for( i = 0; i < item2[master.selectedIndex ].length; i++ ) { 
		detail.options[i] = new Option( item2[ master.selectedIndex ][ i ],item2[ master.selectedIndex ][ i ] );      
	}
}

</script>

<style type="text/css">
<!--
.style8 {
	font-family: "Verdana";
	font-size: 12px;
	line-height: 13.5pt;
	color: #000000;
}
.style10 {color: #FFFFFF; font-size: 12px; }
-->
</style>
</head>


<body onload="loadMaster( document.getElementById( 'item1' ), document.getElementById( 'item2' ) );">    
<div>
<table width="95%"  border="0" cellpadding="0" cellspacing="0">
<tr bgcolor="#CCCCCC" align="center">
<td class="txtblue">
<form name="form1" method="post" action="editAns.jsp">
&nbsp;&nbsp;
<span class="txtblue"> 請選擇主分類 : &nbsp;</span>
<select name="item1" id="item1" onChange="doNewMaster( document.getElementById( 'item1' ),document.getElementById( 'item2' ) );">
</select>
&nbsp;&nbsp;
<span class="txtblue"> 子分類 : &nbsp;</span>
<select name="item2" id="item2"> </select>   
&nbsp;&nbsp;
<input name="Submit" type="submit" value=" Next "> &nbsp;&nbsp;
<input type="button" value="上一頁/Previous page" onclick="javascript:window.history.back()">
</td>
</tr>
</table>
<input name="editor" type="hidden" id="editor" value="<%=editor%>">
<input name="formno" type="hidden" id="formno" value="<%=formno%>">
<input name="itemno" type="hidden" id="sern" value="<%=itemno%>">
</form>
</div>
</body>