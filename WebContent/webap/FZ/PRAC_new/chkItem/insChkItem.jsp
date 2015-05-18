<%@ page contentType="text/html; charset=big5" language="java"  pageEncoding="big5" %>
<%@ page import="java.sql.*,ci.db.*"%>
<%

String fltd  = request.getParameter("fltd");
String fltno  = request.getParameter("fltno");
String sector  = request.getParameter("sector");
String psrEmpn  = request.getParameter("psrEmpn");
String LingPar = request.getParameter("LingPar");
String goPage = request.getParameter("goPage");



String executeStatus = request.getParameter("executeStatus");//���檬�A, Y/N
String ev =null;
String[] evItm  =null;
String[] correctItm = null;


if("Y".equals(executeStatus)){
 ev = request.getParameter("ev");//�w����,���檬�A=���`Y/���F�з�N
 evItm =  request.getParameterValues("evItm");//�w����,���F�зǪ��ﶵ
 correctItm = request.getParameterValues("correctItm");//�w����,���F�з�,�H�B�����ﶵ, 	
 
}


String esYComm = request.getParameter("esYComm").trim();//�w����Comments
String esNComm = request.getParameter("esNComm").trim();//������Comments

String seqno = request.getParameter("seqno");

boolean status = true;
boolean updateStatus = false;
String errMsg = "";
if("".equals(executeStatus) || null == executeStatus){
	errMsg = "�п�ܦҮְ��檬�A(�w����/������).";
	status = false;

}else if("N".equals(executeStatus) && ( esNComm== null |"".equals(esNComm))){
	errMsg = "������Ү�,�п�J��].";
	status = false;
}else if("Y".equals(executeStatus) && ( ev== null |"".equals(ev))){
	errMsg = "�п�ܦҮְ��浲�G(���`/���F�з�).";
	status = false;
		
}


if(status){

Connection conn = null;
PreparedStatement pstmt = null;
ConnDB cn = new ConnDB();
ResultSet rs = null;
Driver dbDriver = null;
	int tempCheckSeqno = 0;

try {     
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);
	
	pstmt = conn.prepareStatement("SELECT Nvl(Max(seqno),0)+1 mx FROM  egtchkrdm");
	rs = pstmt.executeQuery();
	if(rs.next())
	{
		tempCheckSeqno = rs.getInt("mx");
	}
	
	pstmt = conn.prepareStatement("INSERT INTO egtchkrdm(series_num,fltd,fltno,sector,"
		+"psrempn,seqno,checkseqno,executestatus,evalstatus,comments) "
		+"VALUES(?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?)");
	
	pstmt.setString(1,null);//series_num
	pstmt.setString(2,fltd);//fltd
	pstmt.setString(3,fltno);//fltno
	pstmt.setString(4,sector);//sector
	pstmt.setString(5,psrEmpn);//psrempn
	pstmt.setInt(6,tempCheckSeqno);//seqno
	pstmt.setString(7,seqno);//checkseqno
	pstmt.setString(8,executeStatus);//executestatus	
	pstmt.setString(9,ev);//evalstatus
	if("Y".equals(executeStatus)){
		pstmt.setString(10,esYComm);//comments
	
	}else{
		pstmt.setString(10,esNComm);//comments
	
	}
	
	pstmt.executeUpdate();
	
	if(evItm != null){
		for(int i=0;i<evItm.length;i++){
			
				pstmt = conn.prepareStatement("INSERT INTO egtchkrdd(checkseqno,checkdetailseq,checkrdseq,correct) "
						+"VALUES(?,?,?,?)");
				pstmt.setString(1,seqno);//checkseqno
				pstmt.setString(2,evItm[i]);//checkdetailseq
				pstmt.setInt(3,tempCheckSeqno);//checkrdseq
				//checkrdseq
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
	//�����~�� rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
		
}catch(Exception e){
	updateStatus = false;
	errMsg += e.getMessage();

	try {
	//�����~�� rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
}  
finally 
{
	if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (conn != null) 
	{
		try {
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
			alert("�d�ֶ��ظ�Ƨ�s����!!");
			window.opener.location.reload();
			void(window.open('','_parent',''));
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
