<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,
				fz.pr.orp3.*,
				ci.db.ConnDB,
				java.net.URLEncoder,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//�y�������i--�e�X���i
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(�s����Z)</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="javascript" src="changeAction.js" type="text/javascript"></script>
<script  language="javascript"  type="text/javascript">
function warn(){
/*var msg = "���i�e�X�e�A�нT�{�U�խ����ҵ����جO�_�w�g��J�C\n���Ƭ�������r�̡A�@�w�n��J�ҵ����ءC\n(���I��խ����Ǹ��Τ��ƨӵ���)\n\n���i�@�g�e�X�A�Y���o���";
alert(msg);
*/
var msg = "�нT�{�A���Z���w�L���󲧱`�ƶ��A�åߧY�e�X���i?\n\n";
msg +="1.�Y���Z���L���`�ƶ��A�Ы��u�T�w�v�A�e�X���i\n"
msg +="2.�Y���Z�������󲧱`�ƶ��A�Ы���������A�I��Edit Flt Irregularity.\n";
	if( confirm(msg)){
		return true;
	}
	else{
			return false;

	}

}
</script>
</head>

<body>
<div align="center">
<%
String fdate = request.getParameter("fdate");
//���o���Z�~��
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

//String GdYear = "2005";//request.getParameter("GdYear");
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");

String fltno = request.getParameter("fltno").trim();
String sect = request.getParameter("dpt").trim()+request.getParameter("arv").trim();
String acno = request.getParameter("acno");
String ispart2 = request.getParameter("ispart2");
//�p�G�OPart 2 link�L�ӫh�����ˬd
if(ispart2 == null){
	//�s�W�P�_score = 1, 2, 3, 9, 10�O�_���w��JGDDetail(�Үֶ���)
	String[] sern = request.getParameterValues("sern");
	String[] score = request.getParameterValues("score");
	CheckGD cgd = new CheckGD();
	//return:0 OK, return:sern(20306) ���խ����O���Ү֩���
	String chkr = cgd.doCheck(fdate,fltno,sect,sern,score);
	String astring = "�խ��Ǹ� "+ chkr +" ���O���Үֶ��� !";
	if(!chkr.equals("0")){
	%>
		<script>
			alert("<%=astring%>" );
			history.back(-1);
		</script>
	<%	
	}
	//�P�_����
}

String ModifyPage="edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
				
String LingPar = "edFltIrr.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv")+"&GdYear="+GdYear+"&acno="+acno;


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
String goPage= "";
int rowcount = 0;
String sql = "";
String errMsg = "";
boolean status = false;
try{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
////�d�߬O�_�w�g����ơA�Y���A�h�e�X���i...�Y�L�A�h�^�� flightcrew.jsp
/*
sql = "SELECT Count(*) count FROM egtcflt WHERE fltd = To_Date('"+ fdate+"','yyyy/mm/dd') "+
	  "and fltno='"+fltno+"' and sect='"+sect+"'" ;
rs = stmt.executeQuery(sql);
if(rs.next()) rowcount = rs.getInt("count");
if(rowcount == 0) {
	goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
	fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";
}
*/
sql = "update egtcflt set upd='Y' where fltd=to_date('"+ fdate + "','yyyy/mm/dd')" +
      " and fltno='"+ fltno +"' and sect ='"+ sect +"' and psrempn ='" +purserEmpno +
	  "' and psrsern ='"+psrsern+"'" ;

stmt.executeQuery(sql);
status = true;

}
catch (Exception e)
{
	 errMsg = e.toString();
	  out.print(errMsg);
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}


//TODO  update egtgddt
//�ˬd��Z���
fz.pr.orp3.CheckFltData cflt = new fz.pr.orp3.CheckFltData(fdate, fltno, sect,purserEmpno);
if( status ){
	
	
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
	
	if(cflt.isHasFltCrewData()){//�� Flight Crew���
		goPage = "edReportModify.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+
				request.getParameter("dpt").trim()+"&arv="+request.getParameter("arv").trim()
				+"&GdYear="+GdYear;
	}else{
		goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
		fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";	
	}
	
	
}else{
	out.println(errMsg);
}

%>
  <span class="purple_txt"><strong>���i�w�x�s�A�i�A�׭ק�C<br>
  <br>
 Report is Saved and can be modified!! <br>
  </strong></span>

  <form name="form1" method="post" action="upReportSendFltIrr.jsp"  onSubmit="return warn()">
    <blockquote>
      <blockquote>
        <blockquote>
          <blockquote>
            <blockquote>
              <blockquote>
                <blockquote>
                  <p align="left">

              <input name="Submit" type="button" class="addButton" value="Modify Report" onClick="preview('form1','<%=goPage%>')">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
	                <input type="button" value="Edit Flt Irregularity" class="addButton" onClick="preview('form1','<%=LingPar%>')">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                <br><br>
					
					<input type="button" value="View Report" class="addButton" onClick="javascript:window.open('PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>')" > <br><br>
	                <input type="submit" value="Send Report" class="delButon" >
					 <br><br>
                  </p>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
	<input type="hidden" name="fdate" value="<%=fdate%>">
    <input type="hidden" name="fltd" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">		
		<input type="hidden" name="section" value="<%=sect%>">
        <input type="hidden" name="dpt" value="<%=request.getParameter("dpt").trim()%>">		
		 <input type="hidden" name="arv" value="<%=request.getParameter("arv").trim()%>">	
 		 <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		 <input type="hidden" name="psrname" value="<%=psrname%>">	
 		 <input type="hidden" name="psrsern" value="<%=psrsern%>">
		 <input type="hidden" name="pur" value="<%=purserEmpno%>">
		 	  </form>
  <span class="purple_txt"><strong> <br>
 <br>
  </strong></span></div>
</body>
</html>
<script>
<%
//if(!goPage.equals("")){
//egtcflt���|��������....�୶��flightcrew�A�i�JPartI  Report
if(!cflt.isHasFltCrewData()){
	out.print("alert('���i�|����g�����A���o�e�X!!\\n\\n�Ы��u�T�w�v�i�JPartI Report Edit');"
			+"self.location='"+ goPage+"';");
}
else{//egtcflt���w�g������....
%>
alert("���i�x�s���\!!");
<%
}
%>
</script>