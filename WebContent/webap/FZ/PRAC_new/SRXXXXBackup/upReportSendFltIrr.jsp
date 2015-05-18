<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,fz.pracP.*,	fz.pracP.dispatch.*,ci.db.ConnDB,java.net.URLEncoder,ci.db.*, fz.psfly.*,fz.projectinvestigate.*"%>
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
fz.pracP.BordingOnTime borot = new fz.pracP.BordingOnTime(fdate,fltno,sect,purserEmpno);
try {
	borot.SelectData();
//	System.out.println("�O�_��flight��ơG" + borot.isHasFlightInfo());
//	System.out.println("�O�_���n����ơG" + borot.isHasBdotInfo());

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
}

//�ˬd�G�O�_���խ��W��
fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fdate, fltno, sect,purserEmpno);
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

//******************************************************************
//Check if need to fill PSFLY and Done
boolean needfill = true;
boolean chk_sfly_have_data  = false;
PRSFlyIssue psf = new PRSFlyIssue();
psf.getPsflyTopic_no(fdate, fltno, sect.substring(0,3), sect.substring(3),purserEmpno,"","") ;
if(psf.getTopic_noAL().size()>0)
{
	needfill = true;
}
else
{
	needfill = false;
}
CheckPSFLYData chksfly = new CheckPSFLYData(fdate,fltno, sect, purserEmpno);
chk_sfly_have_data = chksfly.hasData();
//******************************************************************
//******************************************************************
//Check if need to fill Project and Done �M�׺޲z
boolean pjneedfill = false;
boolean chk_proj_have_data  = false;
PRPJIssue pj = new PRPJIssue();
pj.getPRProj_no(fdate, fltno, sect.substring(0,3), sect.substring(3),sGetUsr,"","") ;
//out.println(fdate+"  "+fltno+"  "+sect.substring(0,3)+"  "+sect.substring(3)+"  "+sGetUsr);
if(pj.getProj_noAL().size()>0)
{
	pjneedfill = true;
}
CheckProjData chkproj = new CheckProjData(fdate,fltno, sect, purserEmpno);
chk_proj_have_data = chkproj.hasData();
//******************************************************************
//�u���B�z
boolean iflessdisp_pass = false;
boolean iflessdisp = true;
String tempfltno = "";
String tempfleet = "";
String lessdispstr = "";
if(fltno.length()>= 4)
{
	tempfltno = fltno.substring(1,4);
}
else
{
	tempfltno = fltno;
}
FlexibleDispatch fd = new FlexibleDispatch();
iflessdisp = fd.ifFlexibleDispatch(fdate,fltno,sect,sGetUsr);
tempfleet = fd.getFleetCd();
if(iflessdisp == false)
{
	iflessdisp_pass = true;
}
else //if(iflessdisp == true)
{
	//get pax �H��
	int pax_count = fd.getPaxCount(fdate, fltno, sect); 
	//get �u���H��
	int disp_count = fd.getFlexibleNum(fltno, tempfleet, sect, pax_count) ;
	//get ACM �H��
	int acm_count = fd.getACMCount(fdate, fltno, sect) ;
	if(disp_count <= acm_count | pax_count <=0 )
	{
		iflessdisp_pass = true;
	}
	else //if(disp_count != acm_count )
	{
		int i13_count  = fd.getI13Count(fdate, fltno, sect) ;
		if(i13_count>0)
		{
			iflessdisp_pass = true;
		}
	}
}
//******************************************************************

//�Y�L��J�n����ơA���o�e�X���i!!
if( !borot.isHasBdotInfo()){//�L�n�����
%>
<script language="javascript" type="text/javascript">
alert("�|����JCrew Boarding On time��T,���o�e�X���i!!\n�Щ�Flt Irregularity��J!!");
self.location = "PRSel.jsp";
</script>
<%
}
else if(!cflt.isHasFltCrewData())
{
String goToPage= "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
			fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";
%>
<script language="javascript" type="text/javascript">
alert("�|���s��խ��ҵ�,���o�e�X���i!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else if(needfill == true && chk_sfly_have_data == false) 
{
String goToPage= "RepostList.jsp?yy="+fdate.substring(0,4)+"&mm="+fdate.substring(5,7);
%>
<script language="javascript" type="text/javascript">
alert("�|����g�y�����ۧڷ�����i,���o�e�X!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else if(pjneedfill == true && chk_proj_have_data == false) 
{//�M�׽լd
String goToPage= "RepostList.jsp?yy="+fdate.substring(0,4)+"&mm="+fdate.substring(5,7);
%>
<script language="javascript" type="text/javascript">
alert("�|����g�y�����M�׽լd���i,���o�e�X!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else if (iflessdisp_pass == false)
{
String goToPage= "RepostList.jsp?yy="+fdate.substring(0,4)+"&mm="+fdate.substring(5,7);
%>
<script language="javascript" type="text/javascript">
alert("�u���H�Ƥ����T,�нT�{,�Ω�<Flt Irregularity>��������]!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else
{
try
{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
rs = stmt.executeQuery(sql);//�d�߬O�_�w�g����ơA�Y���A�h�e�X���i...�Y�L�A�h�^�� flightcrew.jsp
while(rs.next())
{
	rowCount = rs.getInt("count");
}
rs.close();

if(rowCount != 0)
{//egtcflt ���w�����i�����A�h�e�X
//out.print("�����i����");

	sql = "update egtcflt set upd='N', reject=null, reject_dt=null where fltd=to_date('"+ fdate +
		  "','yyyy/mm/dd') and fltno='"+ fltno +"' and sect ='"+ sect +"'" ;
				
	stmt.executeUpdate(sql);//�Nupd�]��N

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
while(rs.next())
{
	fltd = rs.getString("fltd");
	newdate = rs.getString("newdate");
}

rs.close();
//���otrip_num
String trip_num = "null";
rs = stmt.executeQuery("select dps.trip_num "
	   +"from egdb.duty_prd_seg_v dps, egdb.roster_v r where dps.series_num=r.series_num  "
	   +"  and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	   +" and r.staff_num ='"+purserEmpno+"' AND dps.act_str_dt_tm_gmt BETWEEN  "
	   +" to_date('"+fdate.substring(0,7)+"01 00:00','yyyy/mmdd hh24:mi') AND "
	   +" Last_Day( To_Date('"+fdate.substring(0,7)+"01 23:59','yyyy/mmdd hh24:mi'))  "
	   +" AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') AND  r.acting_rank='PR'  "
	   +" AND dps.flt_num='"+fltno+"' AND dps.port_a||dps.port_b='"+sect+"' "
	   +" AND   dps.str_dt_tm_loc    BETWEEN  "
	   +" to_date('"+fdate+" 0000','yyyy/mm/dd hh24mi')  "
	   +" AND To_Date('"+fdate+" 2359','yyyy/mm/dd hh24mi')");

while(rs.next())
{
	trip_num = "'"+rs.getString("trip_num")+"'";
}

rs.close();




//out.println(ct);
if(fltd == null)
{
	sql = "insert into egtcrpt(fltd,fltno,sect,empno,chguser,chgdate,flag,caseclose,newdate,trip_num) "
		+"values(to_date('"+ fdate +"','yyyy/mm/dd'),'"+fltno+"','"+sect+"','"+sGetUsr+"','"+sGetUsr+
		"',sysdate,'Y',null,sysdate,"+trip_num+")";
}
else
{
	if(newdate == null)
	{
		sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate,newdate=sysdate,caseclose='N' "+
		   	  "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ";
	}
	else
	{
		sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate,caseclose='N' "+
		   	  "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ";
	}
}
//out.println(sql);
/*	sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate "+
		   "where fltd=to_date('"+ fdate +"','yyyy/mm/dd') "+
		  " and fltno='"+fltno.trim()+"' and sect='"+ sect.trim() +"' ";*/
	
	stmt.executeUpdate(sql);	  

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
 System.out.print("ReportSend ERROR:"+e.toString()+"<BR>"+sql);
//		  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));
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

</head>
<body>

<%
if(t){
	  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));	
}else{
%>
<div align="center">

  <span class="purple_txt"><strong>���i�w���\�e�X!!!<br>
  <br>
Send Report Success!!
<br>
<br>
</strong></span><span class="red12"><strong>���i�@�g�e�X�A�Y���o���C
</strong></span></div>
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
<%
}
%>
</body>
</html>
<%
}//end of check �O�_���n���Ǯɸ��
%>