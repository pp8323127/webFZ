<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,tool.ReplaceAll,fz.pracP.*,java.net.URLEncoder,ci.db.ConnDB" %><%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String purserEmpno = request.getParameter("purserEmpno");
String yearsern = request.getParameter("yearsern");
String item1 = request.getParameter("item1");
String itemno = request.getParameter("item2");
String itemdsc = request.getParameter("item3");
String comments = request.getParameter("comm");
String fdate = request.getParameter("fltd");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("sect");
String src = request.getParameter("src");
if(src!= null && !"".equals(src))
{
	src="_"+src;
}
else
{
	src = "";
}
/*
String clb="null";
if("Y".equals(request.getParameter("clb")) ||  "N".equals(request.getParameter("clb"))){
	clb = "'"+request.getParameter("clb")+"'";
}

String mcr = "null";//預設存入db為null值
if("Y".equals(request.getParameter("mcr")) ||  "N".equals(request.getParameter("mcr"))){
	mcr = "'"+request.getParameter("mcr")+"'";
}
*/
String clb = null;
if(!"".equals(request.getParameter("clb")) || null != request.getParameter("clb") ){
	clb = request.getParameter("clb");
}
String mcr =null;
if(!"".equals(request.getParameter("mcr")) || null != request.getParameter("mcr") ){
	mcr = request.getParameter("mcr");
}

String rca = null;
if(!"".equals(request.getParameter("rca")) || null != request.getParameter("rca") ){
	rca = request.getParameter("rca");
}
String emg =null;
if(!"".equals(request.getParameter("emg")) || null != request.getParameter("emg") ){
	emg = request.getParameter("emg");
}

String acno = request.getParameter("acno");

if("null".equals(acno) || acno == null ) acno = "";


String pur = request.getParameter("pur");

//驗證是否為Purser

/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯
	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}	*/		

String goPage = "edFltIrr"+src+".jsp?isZ="+request.getParameter("isZ")+"&purserEmpno="+purserEmpno+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+sect.substring(0,3)+"&arv="+sect.substring(3)+"&acno="+acno+"&pur="+pur;

//by cs66 2005/04/25 避免update時無itemno
//by cs66 2005/8/25 避免update時無purser資料
if("".equals(itemno) | null == itemno | null == itemdsc | "".equals(itemdsc) 
    | "".equals(purserEmpno) | "".equals(pur)){
%>
<script>
alert("修改資料失敗，請重新進入「客艙報告」撰寫。");
self.close();
</script>
<%
	
}
else
{
//取得flag
ItemSel id = new ItemSel();
id.getStatement();
String flag = "";
flag = id.getItemFlag(itemno);
id.closeStatement();

//取代textarea中的換行符號為,
//comments = ReplaceAll.replace(comments,"\r\n",",");

comments = comments.replaceAll("\r\n",",");
Driver dbDriver = null;
Connection conn = null;
String sql  = null;
PreparedStatement pstmt = null;
boolean updStatus = false;
String errMsg = "";

try
{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
conn.setAutoCommit(false);

sql = "update egtcmdt set itemno=(SELECT itemno FROM egtcmpi WHERE Trim(itemdsc)=? "
	+"AND kin=(SELECT itemno FROM egtcmti WHERE itemdsc=?) ),"
	+"itemdsc=?,comments=?,chgdate=sysdate,chguser=?,flag=?,clb=?,mcr=?,rca=?,emg=? "
	+"where yearsern=?";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1,itemno);
pstmt.setString(2,item1);
pstmt.setString(3,itemdsc);
pstmt.setString(4,comments);
pstmt.setString(5,sGetUsr);
pstmt.setString(6,flag);
pstmt.setString(7,clb);
pstmt.setString(8,mcr);
pstmt.setString(9,rca);
pstmt.setString(10,emg);
pstmt.setString(11,yearsern);

pstmt.executeUpdate();
conn.commit();

updStatus = true;


}catch(SQLException e){
	errMsg += e.toString();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}	
}catch (Exception e){
	errMsg+= e.toString();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
}finally{
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (conn != null) {
		try {
			conn.close();
		} catch (SQLException e) {
				errMsg += e.getMessage();

		}
		conn = null;
	}
}
if(updStatus)
{
%>
<script language="JavaScript" type="text/JavaScript" src="../../MT/js/close.js"></script>
<script language="JavaScript" type="text/JavaScript">
	close_self("<%=goPage%>");
</script>
<%
}
else
{
%>
<%=errMsg%><br>
<a href="javascript:history.back(-1);">請重新輸入!!</a>

<%

}

}
%>