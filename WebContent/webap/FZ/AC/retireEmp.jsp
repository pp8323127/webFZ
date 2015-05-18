<%@ page contentType="text/html; charset=big5" language="java" errorPage="" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%!
public class RetireEmpObj {
	private String empno;
	private String rtryear;
	private String chguser;
	private String chgdate;
	
	public String getChgdate() {
		return chgdate;
	}
	private void setChgdate(String chgdate) {
		this.chgdate = chgdate;
	}
	public String getChguser() {
		return chguser;
	}
	private void setChguser(String chguser) {
		this.chguser = chguser;
	}
	public String getEmpno() {
		return empno;
	}
	private void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getRtryear() {
		return rtryear;
	}
	private void setRtryear(String rtryear) {
		this.rtryear = rtryear;
	}

}

%>
<%
//班表公布時間



response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (sGetUsr == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String userid =(String) session.getAttribute("userid") ; 

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
ArrayList dataAL = new ArrayList();
int count = 0;
try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);



stmt = conn.createStatement();

String comm = null;
String sql = "SELECT * FROM fztretire order by rtryear,empno";
rs = stmt.executeQuery(sql); 

while(rs.next()){
	RetireEmpObj obj = new RetireEmpObj();
	obj.setEmpno(rs.getString("empno"));
	obj.setRtryear(rs.getString("rtryear"));
	obj.setChguser(rs.getString("chguser"));
	obj.setChgdate(rs.getString("chgdate"));		
	dataAL.add(obj);
}
rs.close();
}catch (SQLException e){	 
	  out.println(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

//取得中文姓名
aircrew.CrewCName cc = new aircrew.CrewCName();

%>

<html>
<head>
<title>屆退人員名單設定</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script type="text/javascript" language="javascript">
function chk(){
	var e = document.form2.empno.value;
	var r = document.form2.rtyear.value;
	
	if(e == ""){
		alert("請輸入屆退人員之員工號!!");
		document.form2.empno.focus();
		return false;
	}else if(r == ""){
		alert("請輸入屆退人員退休年份!!");
		document.form2.rtyear.focus();
		return false;

	}else{
		document.form2.s.disabled=1;
		return true;
	}
}
function chkDel(e,c){
	if(confirm("確認要刪除 "+e+" "+c+" ?")){
		self.location='delRetireEmp.jsp?empno='+e;
		return true;
	}else{
		return false;
	}
}


</script>






<link href="../kbd.css" rel="stylesheet" type="text/css">
</head>


<body >
<div align="center">
  <%
if(dataAL.size() != 0){
%>
屆退人員名單設定
</div>
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
 <tr>
      <td width="25%" bgcolor="#CCCCCC"  class="tablebody">員工號</td>
	   <td width="12%" bgcolor="#CCCCCC"  class="tablebody">姓名</td>
	   <td width="13%" bgcolor="#CCCCCC"  class="tablebody">退休年份</td>
	   <td width="23%" bgcolor="#CCCCCC"  class="tablebody">刪除</td>
    </tr>

        <div align="center">
<%
		for(int i=0;i< dataAL.size();i++){
			RetireEmpObj obj = (RetireEmpObj)dataAL.get(i);
			

%>
 <tr>
   <td class="tablebody">
     <div align="center"><%=obj.getEmpno()%>
       
         <br>
   </div></td>
   <td class="tablebody"><%=cc.getCname(obj.getEmpno())%></td>
   <td class="tablebody"><%=obj.getRtryear()%></td>
   <td class="tablebody">     <input name="Submit2" type="button" class="kbd" value="確認刪除" onClick="return chkDel('<%=obj.getEmpno()%>','<%=cc.getCname(obj.getEmpno())%>')">
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
	out.print("<p class=\"txtblue\" align=\"center\">目前並無設定屆退人員名單!!!!</p><hr width=\"45%\" align=\"center\">");
}
%>

<hr width="45%" align="center" noshade>


<form action="addRetireEmp.jsp"  method="post" name="form2" id="form2" onSubmit="return chk()">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="3" class="tablehead3">
        <div align="center">新增屆退人員名單</div>
      </td>
    </tr>

	    <tr>
	      <td width="46%" bgcolor="#CCCCCC"  class="tablebody">員工號</td>
	      <td width="54%" bgcolor="#CCCCCC"  class="tablebody">退休年份</td>
    </tr>
	    <tr>
      <td  class="tablebody">
        <input type="text" name="empno" size="6" maxlength="6">
</td>
      <td  class="tablebody">
	  <input type="text" name="rtyear" size="4" maxlength="4">
		</td>
		
		
    </tr>

    <tr>
      <td colspan="2"  class="tablebody">
        <div align="center"> &nbsp;&nbsp;
            <input type="submit" class="kbd" value="確認新增" name="s">
        </div>
      </td>
    </tr>
  </table>
</form>

<div align="center" class="txtxred">*若需修改員工退休年份，請先將該筆資料刪除後再新增。  <br>
</div>
</body>
</html>
