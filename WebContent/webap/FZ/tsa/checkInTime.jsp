<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//crew check in time edit screen
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
 <%
} 

String chk = request.getParameter("chk"); 
Connection conn = null;
Driver dbDriver = null;
ResultSet rs = null;
PreparedStatement pstmt = null;

String[] fltno = null;
String[] smin = null;
String[] chguser = null;
String[] chgdate = null;
String[] fltno_d = null;
ArrayList fltno_r = new ArrayList();
ArrayList smin_r = new ArrayList();
ArrayList chguser_r = new ArrayList();
ArrayList chgdate_r = new ArrayList();
String kf = "";
String fltno_i = null;
String smin_i = null;

// DS
ConnDB cn = new ConnDB();

try{
	//dbDriver = (Driver) Class.forName("ci.db.PoolDriver").newInstance();
	//conn = dbDriver.connect("CAL.FZDS02", null);
	
	//DataSource
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn  = dbDriver.connect(cn.getConnURL(), null);
	
	
	String sql = null;
	//If data change do update or insert data first
	if(chk != null){
		if(chk.equals("U")){ //Update
			fltno = request.getParameterValues("fltno"); 
			smin = request.getParameterValues("smin"); 
			fltno_d = request.getParameterValues("checkdel"); 
			sql = "update fztchki set smin=? where fltno=?";
			pstmt = conn.prepareStatement(sql);
			for(int i=0; i<fltno.length; i++){
				pstmt.setInt(1,Integer.parseInt(smin[i])); 
				pstmt.setString(2,fltno[i]); 
				pstmt.addBatch();
			}
			pstmt.executeBatch(); 
			pstmt.clearBatch();
			if(fltno_d != null){
				for(int i=0; i<fltno_d.length; i++){
					kf = kf + "'"+fltno_d[i]+"',";
				}
				kf = kf.substring(0, kf.length() - 1);
				sql = "delete fztchki where fltno in ("+kf+")";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
			}
		}
		else{ //Insert
			fltno_i = request.getParameter("fltno");
			smin_i = request.getParameter("smin"); 
			sql = "insert into fztchki values(lpad(?,4,'0'),?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,fltno_i);
			pstmt.setInt(2,Integer.parseInt(smin_i));
			pstmt.setString(3,sGetUsr);
			pstmt.executeUpdate();
		}
	}
	
	sql = "select * from fztchki order by 1";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery(); 
	if(rs != null){
		while(rs.next()){
			fltno_r.add(rs.getString("fltno"));
			smin_r.add(rs.getString("smin"));
			chguser_r.add(rs.getString("chguser"));
			chgdate_r.add(rs.getString("chgdate"));
		}
	}
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<html>
<head>
<title>組員報到資訊維護</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form  method="post" name="form1" action="checkInTime.jsp">
  <table width="50%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="5" class="tablehead3"><div align="center">組員報到時間維護</div></td>
    </tr>
    <tr>
      <td  class="tablebody" bgcolor="#CCCCCC">Fltno</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">Time(min.)</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">ChgUser</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">ChgDate</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">刪除</td>
    </tr>
<%
for(int i=0; i < fltno_r.size(); i++){
%>
   <tr>
   	  <td class="tablebody"><%=fltno_r.get(i)%><input name="fltno" type="hidden" value="<%=fltno_r.get(i)%>"></td>
	  <td class="tablebody"><input name="smin" type="text" id="smin" value="<%=smin_r.get(i)%>" size="5" maxlength="3">
      </td>
	  <td class="tablebody"><%=chguser_r.get(i)%></td>
	  <td class="tablebody"><%=chgdate_r.get(i)%></td>
      <td class="tablebody"><input name="checkdel" type="checkbox" value="<%=fltno_r.get(i)%>"></td>
   </tr>	
<%
}
%>   
   <tr>
      <td colspan="5"  class="tablebody"><div align="center">
          <input name="Submit2" type="submit" class="btm" value="確認儲存">
          <input name="chk" type="hidden" id="chk" value="U">
      </div>
      </td>
   </tr>
  </table>
</form>
<br>
<form action="checkInTime.jsp"  method="post" name="form2">
  <table width="50%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3"><div align="center">新增組員報到時間</div></td>
    </tr>
	<tr>
      <td  class="tablebody" bgcolor="#CCCCCC">Fltno</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">Time(<span class="txtxred">表定時間減幾分鐘報到</span>)</td>
	</tr>
    <tr>
      <td class="tablebody">
	  <input name="fltno" type="text" size="5" maxlength="4">
	  </td>
	  <td class="tablebody">
	  <input name="smin" type="text" size="5" maxlength="3">
	  min.
	  </td>
    </tr>	  
    <tr>
      <td colspan="2"  class="tablebody"><div align="center">  
        <input name="Submit" type="submit" class="btm" value="確認新增">
		<input name="chk" type="hidden" id="chk" value="I">
      </div></td>
    </tr>
  </table>
</form>
</body>
</html>