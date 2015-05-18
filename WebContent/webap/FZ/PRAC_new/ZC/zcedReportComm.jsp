<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.sql.*,java.net.URLEncoder,java.util.GregorianCalendar,ci.db.*"%>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();

	String bcolor="";
	String fontcolor = "";
	Connection conn = null;
	Driver dbDriver = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	String returnstr = "";
       
    try
    {
		ConnectionHelper ch = new ConnectionHelper();
		conn = ch.getConnection();
		conn.setAutoCommit(false);	
		stmt = conn.createStatement();	

		if(crewListobjAL.size() >0)
		{//若無資料，則insert

		  sql = " delete from egtzccrew where seqno = to_number("+obj.getSeqno()+")"; 
		  stmt.executeUpdate(sql);			

		  sql = "insert into egtzccrew (seqno, empno, sern, cname, duty, score, grp, best_performance) values (?, ?, ?, ?, Decode(?,NULL,'X',?), Decode(?,NULL,0,?), ?, ?)";
		  pstmt = conn.prepareStatement(sql);		
		  for(int i=0; i<crewListobjAL.size(); i++)
		  {
		    int j=1;
			ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);	
			//update seqno
			zccrewobj.setSeqno(obj.getSeqno());
			//***********************************
			if(!"Y".equals(zccrewobj.getIfcheck()))
			{
				pstmt.setString(j, zccrewobj.getSeqno());
				pstmt.setString(++j, zccrewobj.getEmpno());
				pstmt.setString(++j, zccrewobj.getSern());
				pstmt.setString(++j, zccrewobj.getCname());

				if("".equals(zccrewobj.getDuty()) | zccrewobj.getDuty()==null)
				{
					zccrewobj.setDuty("X");
				}
				pstmt.setString(++j, zccrewobj.getDuty());
				pstmt.setString(++j, zccrewobj.getDuty());

				if("".equals(zccrewobj.getScore()) | zccrewobj.getScore()==null)
				{
					zccrewobj.setScore("0");
				}
				pstmt.setString(++j, zccrewobj.getScore());
				pstmt.setString(++j, zccrewobj.getScore());
				pstmt.setString(++j, zccrewobj.getGrp());			
				pstmt.setString(++j, zccrewobj.getBest_performance());				
				pstmt.addBatch();	
			}
			else
			{
				//delete edited crew grade data
				String delstr = "delete from egtzcgddt where seqno = '"+zccrewobj.getSeqno()+"' and empno = '"+zccrewobj.getEmpno()+"' ";
				stmt.executeUpdate(delstr);			
			}
		  }//for(int i=0; i<crewListobjAL.size(); i++)
		}//if(crewListobjAL.size() >0)
		pstmt.executeBatch();				
		pstmt.clearBatch();
		conn.commit();	

		//更新crew record
		//************************************************************
		ZCReport zcrt = new ZCReport();
		obj.setZccrewObjAL(zcrt.getZCCrewList(obj.getSeqno()));
		//************************************************************
		returnstr = "Y";
	}
	catch (Exception e)
	{
			try 
			{ 
				conn.rollback(); 
				returnstr = e.toString(); 
			} 
			catch (SQLException e1) 
			{ 
				returnstr = e1.toString(); 
			}
	} 
	finally
	{
		try{if(rs != null) rs.close();}catch (Exception e){}
		try{if(stmt != null) stmt.close();}catch (Exception e){}
		try{if(pstmt != null) pstmt.close();}catch (Exception e){}
		try{if(conn != null) conn.close();}catch (Exception e){}
	}

if("Y".equals(returnstr))
{
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>編輯助理座艙長報告</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script>
function switchColor()
{	
	if(Success.style.color=="navy"){
		Success.style.color="yellow";
	}
	else if(Success.style.color=="yellow"){
		Success.style.color="navy";
	}
	setTimeout("switchColor()",750);
}

function disableButton(){
	/*if(confirm("提醒您:\n2006/7/1起,越洋航線,請務必輸入組員CCOM考核.\n\n已輸入或不需輸入CCOM考核,請點選「確定」將報告存檔.\n若您尚未輸入,請按「取消」,並於組員考核項目部分輸入組員CCOM考核.\n")){
		document.form1.save.disabled=1;
		return true;
	}else{
		return false;
	}*/
	document.form1.save.disabled=1;
	return true;


}
</script>
<script src="../../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="javascript" src="../changeAction.js" type="text/javascript"></script>

</head>
<body  onload='switchColor()'>
<div align="center">
  <div align="center">
     <strong> 
	 <span  style="background:#FF6666;color:navy " class="txtxred" id="Success">Score &amp; Crew Evaluation Update Success!!</span> </strong></div>
  <form name="form1" method="post" action="zcupReportSave.jsp" target="_self"  onsubmit="return disableButton()">
  	<input type="hidden" name="idx" value="<%=idx%>">
    <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
<noscript>
    <tr>
      <td height="24" colspan="4" style="background-color:#CCFFFF;color:#FF0000;font-size:10pt; ">
	    <div align="center"><span >若無法開啟編輯優點/註記之視窗，請<a href="guide/openjs/index.htm" target="_blank">點此參照說明</a>更改瀏覽器之設定.</span></div>
      </td>
    </tr>
	</noscript>

      <tr>
        <td colspan="3" valign="left">
          <div align="left" class="txtred">
          <span class="txtblue">PR Report&nbsp; &nbsp;</span><span class="red12"><strong> Step3.Grading In-Flight Service </strong></span></div></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> 
          <div align="left">FDate:<span class="txtred"><%=obj.getFdate()%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=obj.getFlt_num()%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=obj.getPort()%></span> </div>
        </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">CM:<span class="txtred"><%=obj.getPsrname()%>&nbsp;<%=obj.getPsrsern()%>&nbsp;<%=obj.getPsrempn()%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=obj.getCpname()%></span></div>
        </td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">PR:<span class="txtred"><%=obj.getZcname()%>&nbsp;<%=obj.getZcsern()%>&nbsp;<%=obj.getZcempn()%></span></div>
        </td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="381" valign="middle"  class="txtblue">
          <div align="left">A/C:<span class="txtred"><%=obj.getAcno()%></span></div>
        </td>
        <td width="142" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
    </table>
    <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="300">Name</td>
      <td width="55">Sern</td>
      <td width="55">Empno</td>
      <td width="55">Duty</td>
      <td width="95">Score</td>
      <td width="70">最佳服務</td>
    </tr>
	<%
	int crewcount = 0;
	crewListobjAL = obj.getZccrewObjAL();
	for(int i=0;i<crewListobjAL.size();i++)
	{
		ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);
		if(!"Y".equals(zccrewobj.getIfcheck()))
		{
			crewcount ++;
			if (crewcount%2 == 0)
			{
				bcolor = "#99CCFF";
			}
			else
			{
				bcolor = "#FFFFFF";
			}		
%>
  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=zccrewobj.getCname()%>" name="cname">
	  </td>
      <td class="tablebody">
        <input type="text" style="background-color:<%=bcolor%> ;border:0pt;text-decoration:underline;cursor:hand" readonly  size="6" value="<%=zccrewobj.getSern()%>" name="sern" onClick="subwinXY('zcedGdType.jsp?idx=<%=idx%>&subidx=<%=i%>','edGdType','800','500')">
	  </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=zccrewobj.getEmpno()%>" name="empno"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="3" value="<%=zccrewobj.getDuty()%>" name="duty"> </td>
      <td class="tablebody">
	  <%
	  if (zccrewobj.getScore().equals("9") ||  zccrewobj.getScore().equals("10") || zccrewobj.getScore().equals("1") || zccrewobj.getScore().equals("2") || zccrewobj.getScore().equals("3"))
	  {
	  	fontcolor="#FF33CC;font-weight: bold";
	  }
	  else
	  {
	  	fontcolor="#000000";
	  }
	  %>
	<input type="text" style="background:<%=bcolor%> ;border:0pt;color:<%=fontcolor%>;text-decoration:underline;cursor:hand" readonly  size="2" value="<%if("0".equals(zccrewobj.getScore())) out.print("X");else out.print(zccrewobj.getScore());%>" name="score" onClick="subwinXY('zcedGdType.jsp?idx=<%=idx%>&subidx=<%=i%>','edGdType','800','500')">      
	</td>
    <td class="tablebody">&nbsp;
<%
	  if("Y".equals(zccrewobj.getBest_performance()))
	  {
%>
	<img src="../../images/ed1.gif" border="0">
<%		
	  }

	  %></td>
  </tr>
  <%
	}//if(!"Y".equals(zccrewobj.getIfcheck()))
}//for(int i=0;i<crewListobjAL.size();i++)
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="26">&nbsp;</td>
      <td width="105">
        <div align="left" class="txtblue">Total:<%=crewcount%>        </div>
      </td>
      <td width="444"><span class="txttitletop">
		<input type="submit" name="save" value="  Save (Next) " class="addButton"  >
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="back" value="  Back  " onClick="javascript:history.back(-1)">  
		&nbsp;&nbsp;&nbsp;
		  <input type="hidden" name="idx" value="<%=idx%>">
	  </td>
      <td width="29">
      </td>
    </tr>
    <tr>
      <td colspan="4" class="purple_txt">
        <div align="left">
		<strong>*Please click Sern or Score column to edit In-Flight Service Grade while <br>
        the crew's socre is 1,2,3,9 or 10</strong></div>
      </td>
    </tr>
</table>
</form>
</body>
</html>
<%
}//if("Y".equals(returnstr))
}//if ( sGetUsr == null | objAL == null) 
%>