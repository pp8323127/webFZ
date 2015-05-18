<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,java.util.Date,java.net.URLEncoder,ci.db.*"%>
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} else{
String fdate = request.getParameter("fdate");

//String GdYear = "2005";//request.getParameter("GdYear");
//���o���Z�~��
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String purserEmpno = request.getParameter("purserEmpno");
String pursern	= request.getParameter("pursern");
String purname	= request.getParameter("purname");
String pgroups = request.getParameter("pgroups");
String f = request.getParameter("f");//F���H��
String c = request.getParameter("c");//C���H��
String y = request.getParameter("y");//C���H��
String pxac = request.getParameter("pxac");//�`�H��
String book_total = request.getParameter("book_total");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();
String acno = request.getParameter("acno");
session.setAttribute("cs55.acno",acno);
String sect = dpt + arv;
//�P�_�O�_���ӯZ�y����
String pbuser = (String)session.getAttribute("pbuser");
if(pbuser == null) pbuser = "N";

//�ˬd��Z���
fz.pr.orp3.CheckFltData cflt = new fz.pr.orp3.CheckFltData(fdate, fltno, dpt+arv,purserEmpno);
String errMsg = "";
boolean status = false;
String goPage = "";
try {
	cflt.RetrieveData();

	status = true;
} catch (SQLException e) {
	errMsg= e.toString() ;
	System.out.println(errMsg);
} catch (Exception e) {
	errMsg= e.toString() ;
	System.out.println(errMsg);
}

if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") && !sGetUsr.equals("633007") && !sGetUsr.equals("634319") && !sGetUsr.equals("640790") && !sGetUsr.equals("640792") && !sGetUsr.equals("627018") && !sGetUsr.equals("627536") && !sGetUsr.equals("630208") && !sGetUsr.equals("629019") && !sGetUsr.equals("625384") && !sGetUsr.equals("630166") && !sGetUsr.equals("628997") && !pbuser.equals("Y")){

	if(  !sGetUsr.equals(purserEmpno)  ){	//�D���Z���y�����A���o�ϥΦ��\��
		//response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��"));
		status = false;
		errMsg = "�D���Z���y�����A���o�ϥΦ��\��";

	}

}

if ( cflt.isHasFltData() ) {//��flight���
	/* --------------------------
		��crew���
	--------------------------   */	
	if(cflt.isHasFltCrewData()){
	
			// 1. ���i�s����Z�A�i�ק�
		if(  cflt.isUpd() || pbuser.equals("Y") ){					

		goPage = "edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&GdYear="+GdYear;
		
		}else {	// update = N
			status=false;
			errMsg = "���i�w�e�X���i�ק�";
		}
	}else{//�LCrew���

		
	goPage = "edCrew.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&pxac="+pxac+"&book_total="
		+book_total+"&acno="+acno+"&f="+f+"&c="+c+"&y="+y+"&GdYear="+GdYear+"&purname="+URLEncoder.encode(purname)
		+"&pursern="+pursern+"&purserEmpno="+purserEmpno+"&pgroups="+pgroups;
	}
}else{//�Lflight ���
	goPage = "edCrew.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&pxac="+pxac+"&book_total="
		+book_total+"&acno="+acno+"&f="+f+"&c="+c+"&y="+y+"&GdYear="+GdYear+"&purname="+URLEncoder.encode(purname)
		+"&pursern="+pursern+"&purserEmpno="+purserEmpno+"&pgroups="+pgroups;
 
}		



if(!status){
	out.print(errMsg);
}else{

	response.sendRedirect(goPage);


}//end of status= true

}//end of has session value
/*
Connection con = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
String upd = null;
String rs = null;


try{

	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	con = dbDriver.connect(cn.getConnURL(), null);
	
	stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
	
	String sql = "select nvl(upd,'Y') upd from egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect = '"+sect+"'";
	myResultSet = stmt.executeQuery(sql); 

	if(myResultSet.next()){
		upd = myResultSet.getString("upd");
		 //*******************************�}��Power User�i�d�� 2004/10/14 
		if (upd.equals("Y") || pbuser.equals("Y")){ //���i�s����Z�i�ק�
			rs = "edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&GdYear="+GdYear;
		}
		else{ //���i�w�e�X���i�ק�
			rs = "../showmessage.jsp?messagestring="+URLEncoder.encode("���i�w�e�X���i�ק� !")+"&messagelink=Back&linkto=javascript:history.go(-1)";
		}
	}
	else{
		rs = "edCrew.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&pxac="+pxac+"&book_total="+book_total+"&acno="+acno+
		"&f="+f+"&c="+c+"&y="+y+"&GdYear="+GdYear+"&purname="+URLEncoder.encode(purname)+"&pursern="+pursern+"&purserEmpno="+purserEmpno+"&pgroups="+pgroups;
		//out.println(rs);
	}
	response.sendRedirect(rs);
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(con != null) con.close();}catch(SQLException e){}
}*/
%>