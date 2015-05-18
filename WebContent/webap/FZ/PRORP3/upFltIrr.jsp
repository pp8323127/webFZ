<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,tool.ReplaceAll,fz.pr.orp3.*,java.net.URLEncoder,ci.db.ConnDB,fz.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String purserEmpno = request.getParameter("purserEmpno");
String psrname = request.getParameter("psrname");
String psrsern = request.getParameter("psrsern");
String pur = request.getParameter("pur");
//modify by cs66 at 2005/2/23 座艙長非第一個抓到的員工號時，再取得他的姓名及序號
if(!pur.equals(purserEmpno) | sGetUsr.equals(purserEmpno)){	
	chkUser ck = new chkUser();
	ck.findCrew(sGetUsr);
	psrname = ck.getName();
	psrsern = ck.getSern();
}
//驗證是否為Purser

/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯
	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}	*/		
//String GdYear = "2005";//request.getParameter("GdYear");
//String acno = (String)session.getAttribute("fz.acno");//抓聯管acno
String acno = request.getParameter("acno");
if("null".equals(acno) || acno == null ) acno = (String)session.getAttribute("fz.acno");
String fltno = request.getParameter("fltno");
String fdate = request.getParameter("fltd");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String dpt = request.getParameter("dpt");
String arv = request.getParameter("arv");
String sect  = dpt+arv;
String item1= request.getParameter("item1");
String itemno = request.getParameter("item2");
String itemdsc = request.getParameter("item3");
String comments = request.getParameter("comm");
String clb="null";
if("Y".equals(request.getParameter("clb")) ||  "N".equals(request.getParameter("clb"))){
	clb = "'"+request.getParameter("clb")+"'";
}

String mcr = "null";//預設存入db為null值
if("Y".equals(request.getParameter("mcr")) ||  "N".equals(request.getParameter("mcr"))){
	mcr = "'"+request.getParameter("mcr")+"'";
}


String goPage = "edFltIrr.jsp?purserEmpno="+purserEmpno+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&acno="+acno+"&GdYear="+GdYear+"&pur="+pur;

//by cs66 2005/04/25 避免update時無itemno
//by cs66 2005/8/25 避免update時無purser資料
if("".equals(itemno) | null == itemno | null == itemdsc | "null".equals(itemdsc) 
    | "".equals(purserEmpno) | "".equals(pur)){
%>
<script>
alert("新增資料失敗!!!\n請重新輸入!!");
self.location="<%=goPage%>";
</script>
<%
	
}else{


boolean t = true;
/*
int pos = 0;
String kstring = comments;
comments = "";

//將特殊符號 ' 拿掉
while(t){
	pos = kstring.indexOf("'");
	if(pos > 0){
		comments = comments + kstring.substring(0, pos);
		kstring = kstring.substring(pos + 1);
	}
	else{
		comments = comments + kstring;
		t = false;
	}
}
*/
//取得flag
ItemSel id = new ItemSel();
id.getStatement();
String flag = id.getItemFlag(itemno);

id.closeStatement();

//out.print(flag);
//取代textarea中的換行符號為,
comments = ReplaceAll.replace(comments,"\r\n",",");

String NewDataInSql = "newuser,newdate";

Driver dbDriver = null;
Connection conn = null;
//Statement stmt = null;
//ResultSet myResultSet = null;
PreparedStatement pstmt = null;
boolean updStatus = false;
String errMsg = "";
try{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
/*
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
		*/

		
if("null".equals(sGetUsr) || sGetUsr == null) sGetUsr="";
String sql = "INSERT INTO egtcmdt(yearsern,fltd,fltno,sect,itemno,itemdsc,comments,newdate,newuser,"+
	"acno,psrname,psrsern,caseclose,flag,clb,mcr) "+
	"VALUES(egqcmys.nextval,To_Date('"+ fdate+"','yyyy/mm/dd'),'"+fltno+"','"+sect+"',"+
	"(SELECT itemno FROM egtcmpi WHERE Trim(itemdsc)='"+itemno+"' AND kin=(SELECT itemno FROM egtcmti WHERE itemdsc='"+item1+"') ),"+
			"'"+itemdsc+"',?,sysdate,'"+sGetUsr+"','"+acno+"','"+ psrname+"',"+psrsern+",'N','"+flag+"',"
			+clb+","+mcr+")";


//stmt.executeQuery(sql);

pstmt = conn.prepareStatement(sql);
pstmt.setString(1,comments);
pstmt.executeUpdate();

updStatus = true;




//response.sendRedirect(goPage);

}catch(SQLException e){
	errMsg = e.toString();
	System.out.print(errMsg);
}catch (Exception e){
	errMsg = e.toString();
	System.out.print(errMsg);
}finally{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

if(updStatus){
	response.sendRedirect(goPage);

}else{
%>
<%=errMsg%><br>
<a href="<%=goPage%>">請重新輸入!!</a>

<%

}
}
%>