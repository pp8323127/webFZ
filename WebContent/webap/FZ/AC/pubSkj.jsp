<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" errorPage="" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%!
public class  PubObj{
	private String yearMonth;
	private String pubdate;
	private String upduser;
	private int upper_limit =0;
	private int lower_limit =0;

		
	public String getPubdate() {
		return pubdate;
	}

	private void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	private void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getUpduser() {
		return upduser;
	}

	private void setUpduser(String upduser) {
		this.upduser = upduser;
	}

	public int getUpper_limit() {
		return upper_limit;
	}

	private void setUpper_limit(int upper_limit) {
		this.upper_limit = upper_limit;
	}

	public int getLower_limit() {
		return lower_limit;
	}

	private void setLower_limit(int lower_limit) {
		this.lower_limit = lower_limit;
	}
}

%>
<%
//�Z�����ɶ�
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
boolean auth = false;
//20130326�W�[
//������(632544), �իT��(641090), �}�Q�f(638716), 
if("632544".equals(sGetUsr) | "641090".equals(sGetUsr) | "638716".equals(sGetUsr) | "Y".equals((String)session.getAttribute("powerUser")) ){
	auth = true;
}
if (sGetUsr == null || !auth) 
{		
	response.sendRedirect("../login.htm");
}

String userid =(String) session.getAttribute("userid") ; 

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
ArrayList dataAL = new ArrayList();
int count = 0;
ConnDB cn = new ConnDB();
try
{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


/*
cn.setORT1FZ();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
*/
stmt = conn.createStatement();

String comm = null;
String sql = "SELECT yyyy||'/'||mm yearMonth,upduser,To_Char(pubdate,'yyyy/mm/dd hh24:mi') pubdate,upper_limit,lower_limit  FROM fztspub order by yyyy||mm";
rs = stmt.executeQuery(sql); 

while(rs.next())
{
	PubObj obj = new PubObj();
	obj.setPubdate(rs.getString("pubdate"));
	obj.setYearMonth(rs.getString("yearMonth"));
	obj.setUpduser(rs.getString("upduser"));
	obj.setUpper_limit(rs.getInt("upper_limit"));
	obj.setLower_limit(rs.getInt("lower_limit"));
	dataAL.add(obj);
}
rs.close();
}catch (SQLException e){
	 
	  out.println(e.toString());
}
catch (Exception e){
	 
	  out.println(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<html>
<head>
<title>�]�w�Z�����ɶ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../js/showDate.js"></script>
<script src="../js/checkBlank.js"></script>
<script src="../js/checkDel.js"></script>
<script language="JavaScript" src="calendar2.js" ></script>

</head>


<body onLoad="showYM('form2','y','m')" >
<div align="center">
  <%
if(dataAL.size() != 0){
%>
�Z�����ɶ��]�w
</div>
  <table width="60%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="6" class="tablehead3">
        <div align="center">�Z�����ɶ�</div>
      </td>
    </tr>
 <tr>
      <td bgcolor="#CCCCCC"  class="tablebody">�Z����</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">�����ɶ�</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">�ɼƤW��</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">�ɼƤU��</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">��s�H��</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">�R��</td>
    </tr>

        <div align="center">
<%
		for(int i=0;i< dataAL.size();i++)
		{
			PubObj obj = (PubObj)dataAL.get(i);
%>
 <tr>
   <td class="tablebody">
    <div align="center"><%=obj.getYearMonth()%></div></td>
   <td class="tablebody"><%=obj.getPubdate()%></td>
   <td class="tablebody"><%=obj.getUpper_limit()%></td>
   <td class="tablebody"><%=obj.getLower_limit()%></td>
   <td class="tablebody"><%=obj.getUpduser()%></td>
   <td class="tablebody"><input name="Submit2" type="button" class="btm" value="�T�{�R��" onClick="javascript:self.location='delPubSkj.jsp?ym=<%=obj.getYearMonth()%>'">
   </td>
      </tr>	  
        <%
		}
	%>  
        </div>
  </table>
<%
}else
{
	out.print("<p class=\"txtblue\" align=\"center\">�ثe�õL�]�w�Z�����ɶ�!!!!</p><hr width=\"50%\" align=\"center\">");
}
%>

<hr width="60%" align="center" noshade>


<form action="addPubSkj.jsp"  method="post" name="form2" id="form2" onSubmit="return checkBlank('form2','fdate','�п�ܤ����ɶ�!!')">
  <table width="60%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="4" class="tablehead3">
        <div align="center">�s�W�Z�����ɶ�</div>
      </td>
    </tr>

	    <tr>
	      <td bgcolor="#CCCCCC"  class="tablebody">�Z����</td>
	      <td bgcolor="#CCCCCC"  class="tablebody">�����ɶ�</td>
	      <td bgcolor="#CCCCCC"  class="tablebody">�ɼƤW��</td>
	      <td bgcolor="#CCCCCC"  class="tablebody">�ɼƤU��</td>
    </tr>
	    <tr>
      <td  class="tablebody">
        <select name="y">
	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=2005;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>	
</select>
        <select name="m">
          <jsp:include page="../temple/month.htm"/>        
</select>
      </td>
      <td  class="tablebody">
	  <span class="txtblue">
        <input type="text" size="10" maxlength="10" name="fdate" id="fdate" onClick="cal.popup();">
        <img height="16" src="img/cal.gif" width="16" onClick="cal.popup();"> &nbsp;&nbsp;&nbsp;
		<input type="text" size="2" maxlength="2" name="hh" value="00">:<input type="text" size="2" maxlength="2" name="mm" value="00">	<br>
		(�п�ܤ���ÿ�J24�p�ɨ�HH:MM)
			</span>
	  </td>
	  <td  class="tablebody">
		<input type="text" size="6" maxlength="6" name="upper_limit" value="9500">
		</td>
	  <td  class="tablebody">
		<input type="text" size="6" maxlength="6" name="lower_limit" value="7000">
	  </td>
    </tr>
    <tr>
      <td colspan="4"  class="tablebody">
        <div align="center"> &nbsp;&nbsp;
            <input name="Submit" type="submit" class="btm" value="�T�{�s�W">
        </div>
      </td>
    </tr>
  </table>
</form>

<div align="center" class="txtxred">*�Y�ݭק綠���ɶ��A�Х��N�ӵ���ƧR����A�s�W�C<br>
  �Y�Ӥ�����]�w�����ɶ��A�����\�խ����Z.
</div>
</body>
</html>
<script language="JavaScript">
var cal = new calendar2(document.forms['form2'].elements['fdate']);
cal.year_scroll = true;
cal.time_comp = false;
</script>
