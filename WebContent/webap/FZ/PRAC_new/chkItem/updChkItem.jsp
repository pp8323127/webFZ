<%@ page contentType="text/html; charset=big5" language="java"  pageEncoding="big5" %>
<%@ page import="java.sql.*,ci.db.*"%>
<%

String fltd  = request.getParameter("fltd");
String fltno  = request.getParameter("fltno");
String sector  = request.getParameter("sector");
String psrEmpn  = request.getParameter("psrEmpn");
String LingPar = request.getParameter("LingPar");
String goPage = request.getParameter("goPage");

String checkRdSeq = null;
if(null != request.getParameter("checkRdSeq") && !"".equals(request.getParameter("checkRdSeq"))){
	checkRdSeq = request.getParameter("checkRdSeq");
}


String executeStatus = request.getParameter("executeStatus");//執行狀態, Y/N
String ev =null;
String[] evItm  =null;
String[] correctItm = null;


if("Y".equals(executeStatus))
{
 ev = request.getParameter("ev");//已執行,執行狀態=正常Y/未達標準N
 evItm =  request.getParameterValues("evItm");//已執行,未達標準的選項
 correctItm = request.getParameterValues("correctItm");//已執行,未達標準,以矯正的選項, 	 
}


String esYComm = request.getParameter("esYComm").trim();//已執行Comments
String esNComm = request.getParameter("esNComm").trim();//未執行Comments

String seqno = request.getParameter("seqno");

boolean status = true;
boolean updateStatus = false;
String errMsg = "";
if("".equals(executeStatus) || null == executeStatus){
	errMsg = "請選擇考核執行狀態(已執行/未執行).";
	status = false;

}else if("N".equals(executeStatus) && ( esNComm== null |"".equals(esNComm))){
	errMsg = "未執行考核,請輸入原因.";
	status = false;
}else if("Y".equals(executeStatus) && ( ev== null |"".equals(ev))){
	errMsg = "請選擇考核執行結果(正常/未達標準).";
	status = false;
		
}


if(status)
{

Connection conn = null;
PreparedStatement pstmt = null;
ConnDB cn = new ConnDB();
ResultSet rs = null;
Driver dbDriver = null;

try 
{     
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);
	
	
	pstmt = conn.prepareStatement("update egtchkrdm set executestatus=?,evalstatus=?,comments=? where seqno=? ");
	
	pstmt.setString(1,executeStatus);//executestatus
	pstmt.setString(2,ev);//evalstatus
	if("Y".equals(executeStatus)){
		pstmt.setString(3,esYComm);//comments
	
	}else{
		pstmt.setString(3,esNComm);//comments
	
	}
	pstmt.setString(4,checkRdSeq);//checkseqno
	
	
	pstmt.executeUpdate();
	
	//先刪除現有comm
	pstmt = conn.prepareStatement("delete egtchkrdd where checkrdseq=?");
	pstmt.setString(1,checkRdSeq);
	pstmt.executeUpdate();
	
	if(evItm != null){
		for(int i=0;i<evItm.length;i++){
			
				pstmt = conn.prepareStatement("INSERT INTO egtchkrdd(checkseqno,checkdetailseq,checkrdseq,correct) "
						+"VALUES(?,?,?,?)");
				pstmt.setString(1,seqno);//checkseqno
				pstmt.setString(2,evItm[i]);//checkdetailseq
				pstmt.setString(3,checkRdSeq);//checkrdseq
				if(correctItm != null){
					pstmt.setString(4,"N");
				for(int idx=0;idx<correctItm.length;idx++){
					if(correctItm[idx].equals(evItm[i])){
						pstmt.setString(4,"Y");						
					}			
				}
				}else{
					pstmt.setString(4,"N");
				}
				pstmt.executeUpdate();
				pstmt.close();			


			
		}
	}
	conn.commit();	
	updateStatus = true;	
}catch(SQLException e){
	updateStatus = false;
	errMsg += e.getMessage();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
		
}catch(Exception e){
	updateStatus = false;
	errMsg += e.getMessage();

	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
}  
finally 
{
	if (rs != null)
		try 
		{
			rs.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (pstmt != null)
		try 
		{
			pstmt.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (conn != null) 
	{
		try 
		{
			conn.close();
		} catch (SQLException e) {
				errMsg += e.getMessage();
		}
		conn = null;
	}

	if(updateStatus == true)
	{
	%>
		<script language=javascript>
			alert("查核項目資料更新完成!!");
			//window.opener.location.reload();
			this.window.close();
		</script>
	<%
	}
	else
	{
%>
		<script language=javascript>
			alert("<%=errMsg%>!!");
			window.history.back(-1);
		</script>
<%
	}
}
}//if(status)
else 
{
%>
	<script language=javascript>
		alert("<%=errMsg%>!!");
		window.history.back(-1);
	</script>
<%
}
%>