<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %><%@ page import="eg.zcrpt.*,java.sql.*,tool.ReplaceAll,fz.pracP.*,java.net.URLEncoder,ci.db.*" %><%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

String idx = request.getParameter("idx");
ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
String item = request.getParameter("itemno");//old
String seqkey = request.getParameter("seqkey");
String item1 = request.getParameter("item1");
String itemno = request.getParameter("item2");
String itemdsc = request.getParameter("item3");
String comments = request.getParameter("comm");

//out.println("item = "+item+" itemdsc_old "+itemdsc_old+" item1 "+item1+" itemno "+itemno+" itemdsc "+ itemdsc+"<br>");

String goPage = "zcedFltIrr.jsp?idx="+idx;

//by cs66 2005/04/25 避免update時無itemno
//by cs66 2005/8/25 避免update時無purser資料
if("".equals(itemno) | null == itemno | null == itemdsc | "".equals(itemdsc))
{
%>
<script>
alert("修改資料失敗，請重新進入「助理座艙長報告」撰寫。");
self.close();
</script>
<%
	
}else{


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
ConnectionHelper ch = new ConnectionHelper();
conn = ch.getConnection();
conn.setAutoCommit(false);

sql = "update egtzccmdt set itemno=(SELECT itemno FROM egtcmpi WHERE Trim(itemdsc)=? "
	+"AND kin=(SELECT itemno FROM egtcmti WHERE itemdsc=?) ),"
	+"itemdsc=?,comments=?,flag=? "
	+"where seqkey=to_number(?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1,itemno);
pstmt.setString(2,item1);
pstmt.setString(3,itemdsc);
pstmt.setString(4,comments);
pstmt.setString(5,flag);
pstmt.setString(6,seqkey);
pstmt.executeUpdate();
conn.commit();
//更新flt irr items
//************************************************************
ZCReport zcrt = new ZCReport();
obj.setZcfltirrObjAL(zcrt.getZCFltIrrItem(obj.getSeqno()));            
//************************************************************
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
if(updStatus){

%>
<script language="JavaScript" type="text/JavaScript" src="../../../MT/js/close.js"></script>
<script language="JavaScript" type="text/JavaScript">
	close_self("<%=goPage%>");
</script>
<%
}else{
%>
<%=errMsg%><br>
<a href="javascript:history.back(-1);">請重新輸入!!</a>

<%

}

}
%>