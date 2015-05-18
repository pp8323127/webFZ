<%@page import="java.io.StringReader"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,tool.ReplaceAll,java.net.URLEncoder,ci.db.ConnDB,eg.prfe.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String sernno  = request.getParameter("sernno");
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");
ArrayList emptyobjAL = (ArrayList) session.getAttribute("emptyobjAL") ;

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

try{

//ort1
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
conn.setAutoCommit(false);	
//********************************************************************
sql = "INSERT INTO egtprfe (sernno,mitemno,sitemno,grade_percentage,kpino,kpi_eval,upduser,upddate) VALUES (?,?,?,?,?,?,?,sysdate)";
pstmt = conn.prepareStatement(sql);			
for(int i=1; i<emptyobjAL.size(); i++)
{
	PRFuncEvalObj obj =(PRFuncEvalObj) emptyobjAL.get(i);  
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
StringReader  memo2 =  new StringReader(request.getParameter("memo2"));   
sql = "INSERT INTO egtprfe2 (sernno,memo_type,memo) VALUES (?,?,?) ";
pstmt = conn.prepareStatement(sql);		
j=1;
pstmt.setString(j,sernno);
pstmt.setString(++j, "B");
//pstmt.setString(++j, request.getParameter("memo2"));
pstmt.setCharacterStream(++j,memo2, request.getParameter("memo2").length());
pstmt.executeUpdate();
pstmt.close();
//********************************************************************
//C 旅客反映
sql = "INSERT INTO egtprfe2 (sernno,memo_type,sect,seatno,cust_name,event_type,event,memo,cust_type,seat_class) VALUES (?,?,?,?,?,?,?,?,?,?) ";
pstmt = conn.prepareStatement(sql);		
for(int i=1; i<11; i++)
{
	j=1;
	if(request.getParameter("sect"+i) != null && !"".equals(request.getParameter("sect"+i)))
	{
		pstmt.setString(j,sernno);
		pstmt.setString(++j, "C");
		pstmt.setString(++j, request.getParameter("sect"+i));
		pstmt.setString(++j, request.getParameter("seatno"+i));
		pstmt.setString(++j, request.getParameter("cusname"+i));
		String[] event_type_str = request.getParameterValues("event_type"+i);
		String event_type_str2 = "";
		if(event_type_str != null)
		{
			for(int k=0;k<event_type_str.length;k++)
			{
				event_type_str2 = event_type_str2 + event_type_str[k]+"/";
			}
		}
		pstmt.setString(++j, event_type_str2);
		pstmt.setString(++j, request.getParameter("event"+i));
		pstmt.setString(++j, null);
		String[] cust_type_str = request.getParameterValues("cust_type"+i);
		String cust_type_str2 = "";
		if(cust_type_str != null)
		{
			for(int k=0;k<cust_type_str.length;k++)
			{
				cust_type_str2 = cust_type_str2 + cust_type_str[k]+"/";
			}
		}
		pstmt.setString(++j, cust_type_str2);
		pstmt.setString(++j, request.getParameter("seat_class"+i));
		pstmt.addBatch();		
	}
}

pstmt.executeBatch();	
pstmt.clearBatch();

//算平均分數
PRFuncEval prfe = new PRFuncEval();
String avgscore = prfe.getScore(emptyobjAL);
sql = "update egtstti set fe_score = to_number("+avgscore+")/100 where sernno = to_number("+sernno+") ";
pstmt = conn.prepareStatement(sql);	
pstmt.executeUpdate();
conn.commit();
commitstr = "Y";
}
catch (Exception e)
{
	err = e.toString();
	 try { conn.rollback(); } 
     catch (SQLException e1) 
	{ 
		err = e.toString();
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
		alert("Insert completed!!");		window.location.href='editListInfo_FE.jsp?sdate=<%=syy%>/<%=smm%>/<%=sdd%>&edate=<%=eyy%>/<%=emm%>/<%=edd%>';
		</script>
	<%
	}
}
%>