<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*"  %>
<%!
public class RealSwapRdObj {
	private String formno;
	private String year;
	private String month;
	private String aEmpno;
	private String aCount;
	private String aComm;
	private String rEmpno;
	private String rCount;
	private String rComm;
	private String chgUser;
	private String chgDate;
	
	public String getAComm() {
		return aComm;
	}
	public void setAComm(String comm) {
		aComm = comm;
	}
	public String getACount() {
		return aCount;
	}
	public void setACount(String count) {
		aCount = count;
	}
	public String getAEmpno() {
		return aEmpno;
	}
	public void setAEmpno(String empno) {
		aEmpno = empno;
	}
	public String getChgDate() {
		return chgDate;
	}
	public void setChgDate(String chgDate) {
		this.chgDate = chgDate;
	}
	public String getChgUser() {
		return chgUser;
	}
	public void setChgUser(String chgUser) {
		this.chgUser = chgUser;
	}
	public String getFormno() {
		return formno;
	}
	public void setFormno(String formno) {
		this.formno = formno;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}

	public String getRComm() {
		return rComm;
	}
	public void setRComm(String comm) {
		rComm = comm;
	}
	public String getRCount() {
		return rCount;
	}
	public void setRCount(String count) {
		rCount = count;
	}
	public String getREmpno() {
		return rEmpno;
	}
	public void setREmpno(String empno) {
		rEmpno = empno;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

}

%>
<%
String empno = request.getParameter("empno");
String year = request.getParameter("year");
String month = request.getParameter("month");
boolean isAll = false;
if("".equals(empno) | null == empno){
	isAll  = true;
}



Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMsg = "";
ci.db.ConnDB cn = new ci.db.ConnDB();
String formno = "";
ArrayList dataAL = new ArrayList();

try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
if(isAll){

	pstmt = conn.prepareStatement("SELECT To_Char(r.chgdate,'yyyy/mm/dd') chgDate1,r.* "
		+"FROM fztrformf r WHERE station='KHH' and Yyyy=? AND mm=?  order by formno");
	pstmt.setString(1,year);
	pstmt.setString(2,month);

}else{
	pstmt = conn.prepareStatement("SELECT To_Char(r.chgdate,'yyyy/mm/dd') chgDate1,r.* "
		+"FROM fztrformf r WHERE  station='KHH' and Yyyy=? AND mm=? AND ( aempno =? OR rempno = ?) order by formno");
	pstmt.setString(1,year);
	pstmt.setString(2,month);
	pstmt.setString(3,empno);
	pstmt.setString(4,empno);
}
			
	
rs = pstmt.executeQuery();
while(rs.next()){
	RealSwapRdObj obj = new RealSwapRdObj();
	obj.setAComm(rs.getString("acomm"));
	obj.setACount(rs.getString("aCount"));
	obj.setAEmpno(rs.getString("aempno"));
	obj.setChgDate(rs.getString("chgDate1"));
	obj.setChgUser(rs.getString("chguser"));
	obj.setFormno(rs.getString("formno"));
	obj.setMonth(rs.getString("mm"));
	obj.setRComm(rs.getString("rcomm"));
	obj.setRCount(rs.getString("rcount"));
	obj.setREmpno(rs.getString("rempno"));
	obj.setYear(rs.getString("yyyy"));

	dataAL.add(obj);
}

	status = true;

} catch (SQLException e) {
	errMsg = e.toString();	
} catch (Exception e) {
	errMsg = e.toString();
} finally {
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}

//���o�m�W
aircrew.CrewCName cc = new aircrew.CrewCName();


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���鴫�Z�O��</title>
<script language="javascript" type="text/javascript">
	function checkDel(e){
		if(confirm("�T�w�n�R�� "+e)){
			self.location ="delRealSwap.jsp?formno="+e;			
			return true;
		}else{
			return false;
		}

	}
</script>
<link rel="stylesheet" type="text/css" href="realSwap.css">
<link rel="stylesheet" type="text/css" href="../style/kbd.css" >
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">

</head>

<body>
<div align="center">
  <%
if(!status){
%>
<div class="errStyle1"><%=errMsg%></div>
<%
	
}else if(dataAL.size() == 0){
%>
<div class="errStyle1"><%=year+"/"+month+" "+empno+" �L���鴫�Z�O��"%></div>
<%


}else{

%>

<%=year+"/"+month%>���鴫�Z�O��
<%
if(!isAll){out.print("&nbsp;&nbsp;EMPNO:"+empno);}
%>
&nbsp;&nbsp;Total: <%=dataAL.size()%>
<br>
</div>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="0" class="tableBorder1" >
 <tr class="tableInner3">
    <td width="5%" rowspan="3">Edit</td>
    <td width="6%" rowspan="3">Delete</td>
    <td width="11%" rowspan="3">Formno</td>
    <td width="12%">���Z�~��</td>
    <td colspan="3">��s���</td>
  </tr>
  <tr class="tableInner3">
    <td >�ӽЪ�</td>
    <td width="12%" >�m�W</td>
    <td width="11%" >���ƭp��</td>
    <td width="43%" >
      <div align="left">��u���Z�z��</div>
    </td>
  </tr>
  <tr class="tableInner3">
    <td >�Q����</td>
    <td >�m�W</td>
    <td >���ƭp��</td>
    <td >
      <div align="left">��u���Z�z��</div>
    </td>
  </tr>
    <%
  for(int i=0;i<dataAL.size();i++){
  String str = "";
  	RealSwapRdObj obj = (RealSwapRdObj)dataAL.get(i);
	if((i+1)%2 ==0){
		str = "class=\"tableInner2\"";
	}
  %>
  <tr <%=str%>>
    <td rowspan="3"><input type="button" value="Edit" class="kbd" onClick="javascript:self.location='edRealSwap.jsp?formno=<%=obj.getFormno()%>';"></td>
    <td rowspan="3"><input type="button" value="Delete"  class="kbd" onClick="return checkDel('<%=obj.getFormno()%>')"></td>
    <td rowspan="3"><%=obj.getFormno()%></td>
    <td><%=obj.getYear()+"/"+obj.getMonth()%></td>
    <td colspan="3"><%=obj.getChgDate()%></td>
  </tr>
  <tr <%=str%>>

    <td><%=obj.getAEmpno()%></td>
    <td><%=cc.getCname(obj.getAEmpno())%></td>
    <td><%=obj.getACount()%></td>
    <td>
      <div align="left"><%=obj.getAComm()%></div>
    </td>
  </tr>
  <tr <%=str%>>

    <td><%=obj.getREmpno()%></td>
    <td><%=cc.getCname(obj.getREmpno())%></td>
    <td><%=obj.getRCount()%></td>
    <td>
      <div align="left"><%=obj.getRComm()%></div>
    </td>
  </tr>
  <%
  }
  %>
</table>
<%



}

%>
</body>
</html>
