<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,java.net.URLEncoder,fz.pracP.*,ci.db.ConnDB" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


String purserEmpno = request.getParameter("purserEmpno");
String pur = request.getParameter("pur");

//���ҬO�_��Purser

/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66�i�s��
	if(  !sGetUsr.equals("purserEmpno")  ){	//�D���Z���y�����A���o�ϥΦ��\��
		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��") );
	}

}			*/
String fdate = request.getParameter("fdate");
//String GdYear = "2005";//request.getParameter("GdYear");
//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt");
String arv = request.getParameter("arv");
String acno = (String)session.getAttribute("fz.acno");//���p��acno

String[] delItem = request.getParameterValues("delItem");
String src = request.getParameter("src");
if(src!= null && !"".equals(src))
{
	src="_"+src;
}
else
{
	src = "";
}


String delItemRange = "";

for(int i=0;i<delItem.length;i++){
	if(i==0){
		delItemRange = "'"+ delItem[i]+"'";
	}
	else{
		delItemRange =delItemRange + ",'"+ delItem[i]+"'";
	}

}    	

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;

try{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
String sql = "delete egtcmdt where yearsern in("+delItemRange+")";
stmt.executeUpdate(sql);

String goPage = "edFltIrr"+src+".jsp?isZ="+request.getParameter("isZ")+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&purserEmpno="+purserEmpno+"&acno="+acno+"&GdYear="+GdYear+"&pur="+purserEmpno;
response.sendRedirect(goPage);

}
catch (Exception e)
{
	  out.print(e.toString());
	  //response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));

}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>