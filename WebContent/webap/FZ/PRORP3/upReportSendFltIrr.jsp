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
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String fdate = request.getParameter("fltd");
String fltno = request.getParameter("fltno").trim();
String sect = request.getParameter("dpt").trim()+request.getParameter("arv").trim();
String sql = "SELECT Count(*) count FROM egtcflt WHERE   fltd = To_Date('"+ fdate+"','yyyy/mm/dd') "+
			"and fltno='"+fltno+"' and sect='"+sect+"'" ;


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
int rowCount = 0;
String fltd = null;
String newdate = null;

String goPage= "";
String GdYear = "";


//2006/02/15 �s�W�G�ˬd�O�_��J�n���Ǯɸ�T(TEST)
//�n���Ǯɸ�T
fz.pr.orp3.BordingOnTime borot = new fz.pr.orp3.BordingOnTime(fdate,fltno,sect,purserEmpno);
try {
	borot.SelectData();
//	System.out.println("�O�_��flight��ơG" + borot.isHasFlightInfo());
//	System.out.println("�O�_���n����ơG" + borot.isHasBdotInfo());

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
}


//2006/03/14 �ˬd�G�O�_���խ��W��
fz.pr.orp3.CheckFltData cflt = new fz.pr.orp3.CheckFltData(fdate, fltno, sect,purserEmpno);
try {
	cflt.RetrieveData();
//	System.out.println("�O�_��flight ��ơG" + cflt.isHasFltData());
	if ( cflt.isHasFltData() ) {
//		System.out.println("�O�_��Crew��ơG" + cflt.isHasFltCrewData());
//		System.out.println("�O�_���n���Ǯɸ�ơG" + cflt.isHasBdotData());
//		System.out.println("�O�_�i��s���i:" + cflt.isUpd());
	}
} catch (SQLException e) {
	System.out.println(e.toString());
} catch (Exception e) {
	System.out.println(e.toString());
}

//�Y����J�n����ơA���o�e�X���i!!
if( !borot.isHasBdotInfo()){//�L�n�����
%>
<script language="javascript" type="text/javascript">
alert("�|����JCrew Boarding On time��T,���o�e�X���i!!\n�Щ�Flt Irregularity��J!!");
self.location = "PRSel.jsp";
</script>
<%
}else if(!cflt.isHasFltCrewData()){
String goToPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
			fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";

%>
<script language="javascript" type="text/javascript">
alert("�|���s��խ��ҵ�,���o�e�X���i!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}else{



try{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
rs = stmt.executeQuery(sql);//�d�߬O�_�w�g����ơA�Y���A�h�e�X���i...�Y�L�A�h�^�� flightcrew.jsp
while(rs.next()){
	rowCount = rs.getInt("count");
}
rs.close();

if(rowCount != 0){//egtcflt ���w�����i�����A�h�e�X
//out.print("�����i����");

	sql = "update egtcflt set upd='N', reject=null, reject_dt=null where fltd=to_date('"+ fdate +
		  "','yyyy/mm/dd') and fltno='"+ fltno +"' and sect ='"+ sect +"'" ;
				
	stmt.executeQuery(sql);//�Nupd�]��N

//Modified by cs66 at 2005/01/03: gdYear���[1000
	
/*				
	//����i�|�������e�X�e�Agdyear in egtgddt ���쥻����gdyear+1000		�A�ҥH���B�n��^�h	
	sql ="UPDATE egtgddt SET gdyear=to_char(to_number(gdyear)-1000) "+
					"WHERE fltd=to_date('"+ fdate+"','yyyy/mm/dd') "+
					"AND fltno='"+fltno.trim() +"' AND sect='"+sect.trim()+"' ";
					
			
	stmt.executeQuery(sql);//�]�wgdyear
*/	
//�P�_egtcrpt�O�_���O��, ��-->update, �L-->insert
rs = stmt.executeQuery("select fltd, newdate from egtcrpt where fltd=to_date('"+ fdate +"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ");
if(rs != null){
	while(rs.next()){
		fltd = rs.getString("fltd");
		newdate = rs.getString("newdate");
	}
}
//out.println(ct);
if(fltd == null){
	sql = "insert into egtcrpt values(to_date('"+ fdate +"','yyyy/mm/dd'),'"+fltno+"','"+sect+"','"+sGetUsr+"','"+sGetUsr+"',sysdate,'Y',null,sysdate,null,null,null)";
}
else{
	if(newdate == null){
		sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate,newdate=sysdate,caseclose='N' "+
		   	  "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ";
	}
	else{
		sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate,caseclose='N' "+
		   	  "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ";
	}
}
//out.println(sql);
/*	sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate "+
		   "where fltd=to_date('"+ fdate +"','yyyy/mm/dd') "+
		  " and fltno='"+fltno.trim()+"' and sect='"+ sect.trim() +"' ";*/
	
	stmt.executeQuery(sql);	  

}else{	//�L���i�����A��flightcrew�A�ǻ��ѼơGfyy,fnn,fdd,fltno,GdYear,acno
//out.print("No");


	//11~12�몺��Z�A���Z�~�׬��U�@�Ӧ~��
   if(fdate.substring(5,7).equals("11") ||fdate.substring(5,7).equals("12")){	
		GdYear =(Integer.toString((Integer.parseInt(fdate.substring(0,4))+1) ));
	}
	else{
		GdYear = fdate.substring(0,4);
	}
	goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
			fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";

}

}
catch (Exception e)
{
	  t = true;
//	  out.print(e.toString());
		  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(�e�X���i)</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script>
<%
if(!goPage.equals("")){//egtcflt���|��������....�୶��flightcrew�A��JPartI  Report
	out.print("alert('���i�|����g�����A���o�e�X!!\\n\\n�Ы��u�T�w�v��JPartI Report');"+
			"self.location='"+ goPage+"';");
}
else{//egtcflt���w�g������....
%>
alert("���i�w�g�e�X!!");
<%
}
%>
</script>
</head>
<body>
<div align="center">

  <span class="purple_txt"><strong>���i�w���\�e�X!!!<br>
  <br>
Send Report Success!!
<br>
<br>
</strong></span><span class="red12"><strong>���i�@�g�e�X�A�Y���o���C
</strong></span></div>
</body>
</html>
<%
}//end of check �O�_���n���Ǯɸ��
%>