<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,
				fz.pr.orp3.*,
				ci.db.ConnDB,
				java.net.URLEncoder,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//座艙長報告--送出報告
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


//2006/02/15 新增：檢查是否輸入登機準時資訊(TEST)
//登機準時資訊
fz.pr.orp3.BordingOnTime borot = new fz.pr.orp3.BordingOnTime(fdate,fltno,sect,purserEmpno);
try {
	borot.SelectData();
//	System.out.println("是否有flight資料：" + borot.isHasFlightInfo());
//	System.out.println("是否有登機資料：" + borot.isHasBdotInfo());

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
}


//2006/03/14 檢查：是否有組員名單
fz.pr.orp3.CheckFltData cflt = new fz.pr.orp3.CheckFltData(fdate, fltno, sect,purserEmpno);
try {
	cflt.RetrieveData();
//	System.out.println("是否有flight 資料：" + cflt.isHasFltData());
	if ( cflt.isHasFltData() ) {
//		System.out.println("是否有Crew資料：" + cflt.isHasFltCrewData());
//		System.out.println("是否有登機準時資料：" + cflt.isHasBdotData());
//		System.out.println("是否可更新報告:" + cflt.isUpd());
	}
} catch (SQLException e) {
	System.out.println(e.toString());
} catch (Exception e) {
	System.out.println(e.toString());
}

//若為輸入登機資料，不得送出報告!!
if( !borot.isHasBdotInfo()){//無登機資料
%>
<script language="javascript" type="text/javascript">
alert("尚未輸入Crew Boarding On time資訊,不得送出報告!!\n請於Flt Irregularity輸入!!");
self.location = "PRSel.jsp";
</script>
<%
}else if(!cflt.isHasFltCrewData()){
String goToPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
			fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";

%>
<script language="javascript" type="text/javascript">
alert("尚未編輯組員考評,不得送出報告!!\n");
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
rs = stmt.executeQuery(sql);//查詢是否已經有資料，若有，則送出報告...若無，則回到 flightcrew.jsp
while(rs.next()){
	rowCount = rs.getInt("count");
}
rs.close();

if(rowCount != 0){//egtcflt 中已有報告紀錄，則送出
//out.print("有報告紀錄");

	sql = "update egtcflt set upd='N', reject=null, reject_dt=null where fltd=to_date('"+ fdate +
		  "','yyyy/mm/dd') and fltno='"+ fltno +"' and sect ='"+ sect +"'" ;
				
	stmt.executeQuery(sql);//將upd設為N

//Modified by cs66 at 2005/01/03: gdYear不加1000
	
/*				
	//∵報告尚未正式送出前，gdyear in egtgddt 為原本的的gdyear+1000		，所以此處要減回去	
	sql ="UPDATE egtgddt SET gdyear=to_char(to_number(gdyear)-1000) "+
					"WHERE fltd=to_date('"+ fdate+"','yyyy/mm/dd') "+
					"AND fltno='"+fltno.trim() +"' AND sect='"+sect.trim()+"' ";
					
			
	stmt.executeQuery(sql);//設定gdyear
*/	
//判斷egtcrpt是否有記錄, 有-->update, 無-->insert
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

}else{	//無報告紀錄，到flightcrew，傳遞參數：fyy,fnn,fdd,fltno,GdYear,acno
//out.print("No");


	//11~12月的航班，考績年度為下一個年度
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
		  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
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
<title>Send Report(送出報告)</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script>
<%
if(!goPage.equals("")){//egtcflt中尚未有紀錄....轉頁至flightcrew，輸入PartI  Report
	out.print("alert('報告尚未填寫完畢，不得送出!!\\n\\n請按「確定」輸入PartI Report');"+
			"self.location='"+ goPage+"';");
}
else{//egtcflt中已經有紀錄....
%>
alert("報告已經送出!!");
<%
}
%>
</script>
</head>
<body>
<div align="center">

  <span class="purple_txt"><strong>報告已成功送出!!!<br>
  <br>
Send Report Success!!
<br>
<br>
</strong></span><span class="red12"><strong>報告一經送出，即不得更改。
</strong></span></div>
</body>
</html>
<%
}//end of check 是否有登機準時資料
%>