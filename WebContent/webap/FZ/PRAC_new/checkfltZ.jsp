<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,java.util.Date,java.net.URLEncoder,ci.db.*,fz.pracP.*"%>
<%


String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		
	response.sendRedirect("../sendredirect.jsp");
} 
else
{
String fdate = request.getParameter("fdate"); // yyyy/mm/dd
//String GdYear = "2005";//request.getParameter("GdYear");
//���o���Z�~��

String GdYear = fz.pracP.GdYear.getGdYear(fdate);
//out.print(GdYear);


String purserEmpno = request.getParameter("purserEmpno");
String pursern	= request.getParameter("pursern");
String purname	= request.getParameter("purname");
String pgroups =request.getParameter("pgroups");
String f = request.getParameter("f");//F���H��
String c = request.getParameter("c");//C���H��
String y = request.getParameter("y");//C���H��
String pxac = request.getParameter("pxac");//�`�H��
String book_total = request.getParameter("book_total");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();
String acno = request.getParameter("acno");
String stdDt = null;
if(!"".equals(request.getParameter("stdDt")) && null != request.getParameter("stdDt"))
{
	stdDt = request.getParameter("stdDt");
}

session.setAttribute("cs55.acno",acno);


//�P�_�O�_���ӯZ�y����
String pbuser = (String)session.getAttribute("pbuser");
if(pbuser == null) pbuser = "N";


//�ˬd�O�_��Power user(�}�o�H��.groupId=CSOZEZ)
String  isPowerUser = (String)session.getAttribute("powerUser"); 


//�ˬd��Z���
CheckFltData cflt = new CheckFltData(fdate, fltno, dpt+arv,purserEmpno);

String errMsg = "";
boolean status = false;
String goPage = "";
try 
{
	cflt.RetrieveData();
	status = true;
} 
catch (SQLException e) 
{
	errMsg= e.toString() ;
	System.out.println(errMsg);
} 
catch (Exception e) 
{
	errMsg= e.toString() ;
	System.out.println(errMsg);
}

try
{
	if ( cflt.isHasFltData() ) 
	{//��flight���
		/* --------------------------
			��crew���
		--------------------------   */	
		if(cflt.isHasFltCrewData())
		{	
				// 1. ���i�s����Z�A�i�ק�
			if(  cflt.isUpd() || "Y".equals(pbuser) )
			{					

			goPage = "edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&GdYear="+GdYear;
			
			}else {	// update = N
				status=false;
				errMsg = "���i�w�e�X���i�ק�";
			}
		}
		else
		{//�LCrew���
		goPage = "edCrewZ.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&pxac="+pxac+"&book_total="+book_total+"&acno="+acno+"&f="+f+"&c="+c+"&y="+y+"&GdYear="+GdYear+"&purname="+URLEncoder.encode(purname)+"&pursern="+pursern+"&purserEmpno="+purserEmpno+"&pgroups="+pgroups+"&stdDt="+stdDt;
		}
	}
	else
	{//�Lflight ���
		goPage = "edCrewZ.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&pxac="+pxac+"&book_total="+book_total+"&acno="+acno+"&f="+f+"&c="+c+"&y="+y+"&GdYear="+GdYear+"&purname="+URLEncoder.encode(purname)+"&pursern="+pursern+"&purserEmpno="+purserEmpno+"&pgroups="+pgroups+"&stdDt="+stdDt;
	}		


	if(!"Y".equals(isPowerUser) &&
	 !sGetUsr.equals("627018") && !sGetUsr.equals("627536") && !sGetUsr.equals("630208") 
	 && !sGetUsr.equals("629019") && !sGetUsr.equals("625384") && !sGetUsr.equals("630166") && !sGetUsr.equals("628997") && !"Y".equals(pbuser))
	{
		if(  !sGetUsr.equals(purserEmpno)  )
		{	//�D���Z���y�����A���o�ϥΦ��\��
			status = false;
			errMsg = "�D���Z���y�����A���o�ϥΦ��\��";
		}

	}

}
catch (Exception e) 
{
	errMsg= e.toString() ;
	out.println(errMsg);
}

	if(!status)
	{
		out.print(errMsg);
	}
	else
	{
		response.sendRedirect(goPage);
	}//end of status= true


}//end of has session value		
%>