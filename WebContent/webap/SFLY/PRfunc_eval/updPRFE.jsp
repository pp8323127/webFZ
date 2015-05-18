<%@page import="java.io.StringReader"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,tool.ReplaceAll,java.net.URLEncoder,ci.db.ConnDB,eg.prfe.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String sernno  = request.getParameter("sernno");
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");
ArrayList objAL = (ArrayList) session.getAttribute("objAL") ;

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
int hasItemCount = 0;
int j=1;
String forwardPage = "";
String sql = null;
String err = "";
String commitstr = "N";
Driver dbDriver = null;
ConnDB cn = new ConnDB();
try
{
//ort1
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
conn.setAutoCommit(false);	

sql = " delete egtprfe where sernno = '"+sernno+"'";
pstmt = conn.prepareStatement(sql);	
pstmt.executeUpdate();

sql = " delete egtprfe2 where sernno = '"+sernno+"'";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

sql = " delete egtprfs where sernno = '"+sernno+"'";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();

//********************************************************************
err = "egtprfe";
sql = "INSERT INTO egtprfe (sernno,mitemno,sitemno,grade_percentage,kpino,kpi_eval,upduser,upddate) VALUES (?,?,?,?,?,?,?,sysdate)";
pstmt = conn.prepareStatement(sql);			
for(int i=1; i<objAL.size(); i++)
{
	PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(i);  
	obj.setSernno(sernno);
	obj.setKpi_eval(request.getParameter(obj.getKpino()));
	j=1;
	pstmt.setString(j,sernno);
	pstmt.setString(++j, obj.getMitemno());
	pstmt.setString(++j, obj.getSitemno());
	pstmt.setString(++j, obj.getGrade_percentage());
	pstmt.setString(++j, obj.getKpino());
	pstmt.setString(++j, request.getParameter(obj.getKpino()));				
	pstmt.setString(++j, userid);
	pstmt.addBatch();		
}
pstmt.executeBatch();	
pstmt.clearBatch();
pstmt.close();
//********************************************************************
//A 座艙長客艙管理觀察
//memo 1
err = "egtprfe2 A";
StringReader  memo1 =  new StringReader(request.getParameter("memo1"));   
sql = "INSERT INTO egtprfe2 (sernno,memo_type,memo) VALUES (?,?,?) ";
pstmt = conn.prepareStatement(sql);		
j=1;
pstmt.setString(j,sernno);
pstmt.setString(++j, "A");
//pstmt.setString(++j, request.getParameter("memo1"));
pstmt.setCharacterStream(++j,memo1, request.getParameter("memo1").length());
pstmt.executeUpdate();
pstmt.close();
//********************************************************************
//B 航班事務改善建議
//memo 2
err = "egtprfe2 B";
//StringReader  memo2 =  new StringReader(request.getParameter("memo2"));   
sql = "INSERT INTO egtprfe2 (sernno,memo_type) VALUES (?,?) ";
pstmt = conn.prepareStatement(sql);		
j=1;
pstmt.setString(j,sernno);
pstmt.setString(++j, "B");
//pstmt.setString(++j, request.getParameter("memo2"));
//pstmt.setCharacterStream(++j,memo2, request.getParameter("memo2").length());
pstmt.executeUpdate();
pstmt.close();

//********************************************************************
//B 航班事務改善建議 細項
err = "egtprfs B2";
String[] sugArr = request.getParameterValues("sugArr");
String[] memo2 = request.getParameterValues("memo2");   
sql = "INSERT INTO egtprfs(sernno, itemno, feedback) VALUES (?,?,?)";
pstmt = conn.prepareStatement(sql);		
for(int i=0;i<sugArr.length;i++){
	j=1;
	if(null != memo2[i] && !"".equals(memo2[i])){
		pstmt.setString(j,sernno);
		pstmt.setString(++j, sugArr[i]);
		pstmt.setString(++j, memo2[i]);
		pstmt.addBatch();
	}
}
//pstmt.setCharacterStream(++j,memo2, request.getParameter("memo2").length());
pstmt.executeBatch();	
pstmt.clearBatch();
pstmt.close();
//********************************************************************
//C 旅客反映
err = "egtprfe2 C";
String[] sect = request.getParameterValues("sect");
String[] seatno = request.getParameterValues("seatno");   
String[] cusname = request.getParameterValues("cusname");
String[] cust_type = request.getParameterValues("cust_type");   
String[] seat_class = request.getParameterValues("seat_class");
String[] cardno = request.getParameterValues("cardno");  
sql = "INSERT INTO egtprfe2 (sernno,memo_type,sect,seatno,cust_name,cust_type,seat_class,cardno,seqno) VALUES (?,?,?,?,?,?,?,?,?) ";
pstmt = conn.prepareStatement(sql);
for(int i=0; i<sect.length; i++)
{
	j=1;
	if(sect[i] != null && !"".equals(sect[i]))
	{
	
		if(null == seatno[i]) seatno[i]="";
		if(null == cusname[i]) cusname[i]="";
		if(null == cust_type[i]) cust_type[i]="";
		if(null == seat_class[i]) seat_class[i]="";
		if(null == cardno[i]) cardno[i]="";
		pstmt.setString(j,sernno);
		pstmt.setString(++j, "C");
		pstmt.setString(++j, sect[i]);
		pstmt.setString(++j, seatno[i]);
		pstmt.setString(++j, cusname[i]);
		pstmt.setString(++j, cust_type[i]);
		pstmt.setString(++j, seat_class[i]);
		pstmt.setString(++j, cardno[i]);
		pstmt.setString(++j, (i+1)+"");
		pstmt.addBatch();		
	}
}
pstmt.executeBatch();	
pstmt.clearBatch();

//算平均分數
PRFuncEval prfe = new PRFuncEval();
String avgscore = prfe.getScore(objAL);
sql = "update egtstti set fe_score = to_number("+avgscore+")/100 where sernno = "+sernno;
//out.print(sql+"<br>");
pstmt = conn.prepareStatement(sql);	
pstmt.executeUpdate();
conn.commit();
commitstr = "Y";
}
catch (Exception e)
{
	 err += e.toString();
	 try 
	 { 
		 conn.rollback(); 
	 } 
     catch (SQLException e1) 
	 {
		 err += e1.toString();
	 }
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	if(!"Y".equals(commitstr))
	{ 
	 %>
	<script language="javascript" type="text/javascript">
	alert("Update failed!!\n資料更新失敗!!");
	//window.history.back(-1);
	</script>
	<%
		out.println(err);
	}
	else
	{
%>
		<script language="javascript">
		alert("Update completed!!");
		window.location.href='editListInfo_FE.jsp?sdate=<%=syy%>/<%=smm%>/<%=sdd%>&edate=<%=eyy%>/<%=emm%>/<%=edd%>';
		</script>
<%
	}
}
%>