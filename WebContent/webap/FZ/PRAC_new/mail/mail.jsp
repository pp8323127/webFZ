
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,ci.db.ConnDB,java.util.ArrayList"%>
<%
String rid = request.getParameter("rid");
String caseno = request.getParameter("caseno");
if(rid == null){
	String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
	if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
		response.sendRedirect("../sendredirect.jsp");
	} 
}
%>
<html>
<head>
<meta name="viewport"content="minimum-scale=0.6 maximum-scale=1.5 initial-scale=1.0 user-scalable=yes width=768">
<!--支援ipad 可縮放頁面-->
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Mail to Crews</title>
<link rel ="stylesheet" type="text/css" href="../../style/checkStyle1.css">
<link rel ="stylesheet" type="text/css" href="../../style/btn.css">
<style type="text/css">
.style1 
{
	font-size: 14px;
	line-height: 15pt;
	color: #0000FF;
	font-family:  Verdana;
}
.txtblue
{
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  Verdana;
}
.txtred 
{
	font-size: 13px;
	line-height: 13.5pt;
	color: #FF0000;
	font-family:Verdana;
}
.style4 {font-size: 13px; line-height: 13.5pt; color: #464883; font-family: Verdana; font-weight: bold; }
</style>

<script language="javascript" type="text/javascript">
function sentMail()
{
	var c = 0;
	var str = "";
	for (var i=0;i<form1.sel.length;++i) {
      if (form1.sel[i].checked) c+=1;
    }
	if(c > 0){	
		form1.btn_sub.disabled=1;
		//document.getElementById("btn_sub").disabled=1;		
		str = "是否送出信件?";
	}else{
		form1.btn_sub.disabled=1;
		//document.getElementById("btn_sub").disabled=1;
		alert("請至少勾選一個組員");
		return false;
	}
	
	if(confirm(str)){
		document.form1.submit();
		return true;
	}else{
		return false;
	}

}

function checkall(){
	if(form1.allck.checked){
		for (var i=0;i<form1.sel.length;++i) {
			form1.sel[i].checked = true;
		}
	}else{
		for (var i=0;i<form1.sel.length;++i) {
			form1.sel[i].checked = false;
		}
	}
}
</script>

</head>
<body>
  <div align="center">
<%
String fdate = request.getParameter("fdate");//yyyymmdd
String ftime = request.getParameter("ftime");//hhmi
String fltno = request.getParameter("fltno");//0006
String sect = request.getParameter("sect");//TPELAX
String user = request.getParameter("user");//
/*out.println(fdate);
out.println(ftime);
out.println(fltno);
out.println(sect);
out.println(user);*/
/*mail list*/
ArrayList crewEmpnAL =  new ArrayList();
ArrayList crew	 = new ArrayList();//cname
ArrayList sern	 = new ArrayList();
ArrayList duty	 = new ArrayList();
ArrayList groups = new ArrayList();

Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

ConnDB cn = new ConnDB();
ArrayList dataAL = null;
StringBuffer sb = null;

if(null != fdate && !"".equals(fdate)
&& null != ftime && !"".equals(ftime)
&& null != fltno && !"".equals(fltno) 
&& null != sect && !"".equals(sect)
&& null != user && !"".equals(user)){
	fdate.replace("/","");	
	fdate.replace(":","");
	try{
		sb = new StringBuffer();
	    sb.append("SELECT to_char(act_str_dt_tm_gmt, 'yyyymmdd hh24mi') actStrDt,"+
	    		  "To_Char(d.str_dt_tm_loc, 'mm/dd hh24mi') str_dt_loc,"+
	    	      "To_Char(d.end_dt_tm_loc, 'mm/dd hh24mi') end_dt_loc,"+
	    	      "rr.staff_num, cc.Rank_cd, cc.ename, cc.grp, cc.sern, cc.cname");
	    sb.append(" FROM duty_prd_seg_v d ,");
	    sb.append(" ( select r.series_num,r.staff_num,r.special_indicator  FROM roster_v r  WHERE r.delete_ind='N'   ) rr ,");
	    sb.append(" (SELECT c.staff_num,cv.rank_cd Rank_cd, c.other_surname||' '||c.other_first_name ename,");
	    sb.append(" c.preferred_name  cname, c.section_number grp, LTrim(LPad(Nvl(Trim(c.seniority_code),'0'),12,'0'),'0') sern ");
	    sb.append(" FROM crew_v c,crew_rank_v cv ");
	    sb.append(" WHERE c.staff_num = cv.staff_num  AND cv.eff_dt<= To_Date(?,'yyyymmdd') ");
	    sb.append(" AND (cv.exp_dt IS null  OR cv.exp_dt >= To_Date(?,'yyyymmdd') ) ) cc ");
	    sb.append(" WHERE d.series_num = rr.series_num  AND rr.staff_num = cc.staff_num ");
	    sb.append(" AND d.act_str_dt_tm_gmt BETWEEN (To_Date(?,'yyyymmdd hh24mi') - 2) and (To_Date(?,'yyyymmdd hh24mi') + 2) ");
	    sb.append(" AND d.str_dt_tm_loc BETWEEN  To_Date(?,'yyyymmdd hh24mi') AND To_Date(?,'yyyymmdd hh24mi') ");
	    sb.append(" AND d.delete_ind='N' AND d.duty_cd in ('FLY','TVL')"); 
	    sb.append(" and d.act_port_a||d.act_port_b=upper('"+sect+"') ");
	    //2013/10/29 delay班--no data問題
	    if(fltno.indexOf("Z") > -1){
	       fltno = fltno.substring(0,4);
	       sb.append("AND d.flt_num in ('"+fltno+"','"+fltno+"Z') ");
	    }else{
	       sb.append("AND d.flt_num='"+fltno+"' ");
	    } 
	    /* 排序時，前艙排前面，後艙PR排前面，其餘照序號排 */
	    sb.append("  ORDER BY d.fd_ind DESC,  ");
	    sb.append(" decode(cc.rank_cd,'PR','00001','FC','00002',lpad(cc.sern,5,'0')) ");
		
		
	    cn.setAOCIPRODCP();
	    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	    conn = dbDriver.connect(cn.getConnURL(), null);
	
	    pstmt = conn.prepareStatement(sb.toString());
	    pstmt.setString(1, fdate);
	    pstmt.setString(2, fdate);
	    // pstmt.setString(3,fltdate+" 0000");
	    // pstmt.setString(4,fltdate+" 2359");
	    pstmt.setString(3, fdate + " 0000");
	    pstmt.setString(4, fdate + " 2359");
	    pstmt.setString(5, fdate + " " + ftime);
	    pstmt.setString(6, fdate + " " + ftime);   
	//    pstmt.setString(7, fltno);
		aircrew.CrewInfo cc = new aircrew.CrewInfo();
	    rs = pstmt.executeQuery();
		if(rs != null){
			while(rs.next()){
				duty.add(rs.getString("Rank_cd"));
				crewEmpnAL.add(rs.getString("staff_num"));
				crew.add(cc.getCname(rs.getString("staff_num")));//cname
				sern.add(rs.getString("sern"));
				groups.add(rs.getString("grp"));
			}
		}
	
	}
	catch (Exception e)
	{
		  out.print(e.toString()+fdate+fltno+sect);//+sb.toString()
	}
	finally
	{
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	}
	
}else{
		out.print("參數錯誤");
}	
%> 
</div>
<form action="sendMail.jsp" method="post" name="form1" class="txtblue" onSubmit="return f_submit();">

<div align="center">
<p align="center" class="style1">Send Mail:</p>
<table width="80%"  border="1" cellpadding="0" cellspacing="0">
	<tr> 
		<td bgcolor="#d5a9f2" class="style1"><div align="left">Subject</div></td>
		<td>       
		<div align="left">
		<input type="text" name="subject" id="subject" size="50" maxlength="50" value=""  class="t1">
		</div>
		</td>
	</tr>
	<tr> 
		<td bgcolor="#d5a9f2" class="style1"><div align="left">Carbon Copy</div></td>
		<td>       
		<div align="left">
		<textarea name="cc" id="cc" cols=80 rows=5  class="t1"></textarea><br>
		新增副本請用<span class="style7">,</span>分隔 ex: xxxxxx@cal.aero<span class="style5">,</span>oooooo@cal.aero
		</div>
		</td>
	</tr>
	<tr> 
		<td bgcolor="#d5a9f2" class="style1"><div align="left">Message</div></td>
		<td> <p align="left"> 
		<textarea name="message" id="message" cols=80 rows=12  class="t1"></textarea><br>
		</td>
	</tr>
</table>
</div>

<hr width="95%" align = "center">

<div align="center">
  <span align="center" class="style1">Mail List</span>
</div>
  <table width="85%"  border="1" align="center" cellpadding="0" cellspacing="0" >
    <tr bgcolor="#d5a9f2">
      <td style="width: 150px;"><div align="center" class="style1">Duty</div></td>
      <td><div align="center" class="style1">Empn.</div></td>
      <td><div align="center" class="style1">CName</div></td>
      <td><div align="center" class="style1">S.No.</div></td>
      <td><div align="center" class="style1">Groups</div></td>
      <td><div align="center" class="style1">Mail<input type="checkbox" name="allck" id="allck" onClick="checkall();"></div></td>

    </tr>
<%
for(int i=0; i<sern.size(); i++){
String bgColor ="";
	
	if((i%2)==1)
	{
		bgColor="#FFFFFF";
	}
	else
	{
		bgColor="#c9c9c9";
	}
%>
	<tr bgcolor="<%=bgColor%>">
      <td height="26"><div align="center" class="style4"><%=duty.get(i)%>&nbsp;</div></td>
      <td height="26"><div align="center" class="style4"><%=crewEmpnAL.get(i)%></div></td>
      <td height="26"><div align="center" class="style4"><%=crew.get(i)%></div></td>
	  <td height="26"><div align="center" class="style4"><%=sern.get(i)%></div></td>
      <td height="26"><div align="center" class="style4"><%=groups.get(i)%></div></td>
	  <td height="26"><div align="center" class="style4">
	  <input type="checkbox" name="sel" id="sel<%=i%>" value=<%=crewEmpnAL.get(i)%>></div></td>
	</tr>
	<input type="hidden" name="rid" id="rid" value=<%=rid%>>
	<input type="hidden" name="user" id="user" value=<%=user%>>
<%
}

%>
	<tr align= "center">
		<td colspan="20">
		<input name="btn_sub" id="btn_sub"  type="button" class="txtblue" value="Send" onClick="sentMail();"> 
		<input name="btn_r" id="btn_r" type="button" class="txtblue" value="Reset" OnClick="document.form1.btn_sub.disabled=0">
		</td>
	</tr>	 
</table>

</form>	
</body>
</html>
