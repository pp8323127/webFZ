<%@page contentType="text/html; charset=big5" language="java" 
import="java.sql.*,javax.sql.DataSource,javax.naming.*,ci.db.*"%>

<html>
<head>
<title>Crew Personal Record</title>
	<meta http-equiv="Content-Type" content="text/html; charset=big5">
	<meta http-equiv="pragma" content="no-cache">

<%
// JSP
String linkuser = request.getParameter("empno");
String Thisyear__myyear ;


int ttd = 0;
int ttn = 0;
int tld = 0;
int tln = 0;
String Recordset1__myempn = "633334";

String Recordset1__myyear = "2010";

String Recordset1__mymonth = "01";

//DataSource
Context initContext = null;
DataSource ds = null;
Driver 				dbDriver 			= null;

//DataSource
Connection conn = null;
//****************************************
PreparedStatement StatementRecordset1 = null;
PreparedStatement StatementRecordset2 = null;
PreparedStatement StatementThisyear = null;
PreparedStatement StatementThismonth = null;
PreparedStatement StatementAcctotal = null;
PreparedStatement StatementYeartotal = null;
PreparedStatement StatementMonthtotal = null;
PreparedStatement StatementAcctold = null;
PreparedStatement StatementMonthtold = null;
PreparedStatement StatementAcccafototal = null;
PreparedStatement StatementMonthstold = null;

ResultSet Recordset1 = null;
ResultSet Recordset2 = null;
ResultSet Thisyear = null;
ResultSet Thismonth = null;
ResultSet Acctotal = null;
ResultSet Yeartotal = null;
ResultSet Monthtotal = null;
ResultSet Acctold = null;
ResultSet Monthtold = null;
ResultSet Acccafototal = null;
ResultSet Monthstold = null;
//****************************************
ConnDB cn = new ConnDB() ;

try{
		initContext = new InitialContext();
		//connect to ORP3 by Datasource
		//ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
		//conn = ds.getConnection();
	//DataSource
	cn.setDFUserCP();
	//cn.setORP3FZUserCP() ; 
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn  = dbDriver.connect(cn.getConnURL(), null);
		
		StatementRecordset1 = conn.prepareStatement("SELECT fleet,         trunc(sum(ca) / 60) tca,         mod(sum(ca),60) mca,         trunc(sum(pic) / 60) tpic,         mod(sum(pic),60) mpic,         trunc(sum(fo) / 60) tfo,         mod(sum(fo),60) mfo,         trunc(sum(fe) / 60) tfe,         mod(sum(fe),60) mfe,         trunc(sum(inst) / 60) tinst,         mod(sum(inst),60) minst,         trunc(sum(night) / 60) tnight,         mod(sum(night),60) mnight,         trunc(sum(dutyip) / 60) tdutyip,         mod(sum(dutyip),60) mdutyip,         trunc(sum(dutysf) / 60) tdutysf,         mod(sum(dutysf),60) mdutysf,         trunc(sum(dutyca) / 60) tdutyca,         mod(sum(dutyca),60) mdutyca,         trunc(sum(dutyfo) / 60) tdutyfo,         mod(sum(dutyfo),60) mdutyfo,         trunc(sum(dutyfe) / 60) tdutyfe,         mod(sum(dutyfe),60) mdutyfe,  trunc(sum(pic2) / 60) tpic2,         mod(sum(pic2),60) mpic2     from(        SELECT FLEET_CD fleet,              CA ca,              PIC pic,              FO fo,              FE fe,              INST inst,              NIGHT night,              DUTYIP dutyip,              DUTYSF dutysf,              DUTYCA dutyca,              DUTYFO dutyfo,              DUTYFE dutyfe, PIC2 pic2  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Recordset1__myempn + "' and fleet_cd <> 'OPS' and ((YY='" + Recordset1__myyear + "' and MM<='" + Recordset1__mymonth + "') or YY<'" + Recordset1__myyear + "') )  GROUP BY fleet  ORDER BY fleet ASC");
		Recordset1 = StatementRecordset1.executeQuery();
		boolean Recordset1_isEmpty = !Recordset1.next();
		boolean Recordset1_hasData = !Recordset1_isEmpty;
		Object Recordset1_data;
		int Recordset1_numRows = 0;
		%>
		<%
		String Recordset2__myempn = "633334";
		%>
		<%
		StatementRecordset2 = conn.prepareStatement("SELECT ename  FROM dfdb.dftcrew  WHERE empno='" + Recordset2__myempn + "'");
		Recordset2 = StatementRecordset2.executeQuery();
		boolean Recordset2_isEmpty = !Recordset2.next();
		boolean Recordset2_hasData = !Recordset2_isEmpty;
		Object Recordset2_data;
		int Recordset2_numRows = 0;
		%>
		<%
		String Thisyear__myempn = "633334";
		%>
		<%
		Thisyear__myyear = "2010";
		%>
		<%
		String Thisyear__mymonth = "01";
		%>
		<%
		// THIS YEAR
		StatementThisyear = conn.prepareStatement("SELECT fleet,         trunc(sum(ca) / 60) tca,         mod(sum(ca),60) mca,         trunc(sum(pic) / 60) tpic,         mod(sum(pic),60) mpic, trunc(sum(pic2) / 60) tpic2,         mod(sum(pic2),60) mpic2,         trunc(sum(fo) / 60) tfo,         mod(sum(fo),60) mfo,         trunc(sum(fe) / 60) tfe,         mod(sum(fe),60) mfe,         trunc(sum(inst) / 60) tinst,         mod(sum(inst),60) minst,         trunc(sum(night) / 60) tnight,         mod(sum(night),60) mnight,         trunc(sum(dutyip) / 60) tdutyip,         mod(sum(dutyip),60) mdutyip,         trunc(sum(dutysf) / 60) tdutysf,         mod(sum(dutysf),60) mdutysf,         trunc(sum(dutyca) / 60) tdutyca,         mod(sum(dutyca),60) mdutyca,         trunc(sum(dutyfo) / 60) tdutyfo,         mod(sum(dutyfo),60) mdutyfo,         trunc(sum(dutyfe) / 60) tdutyfe,         mod(sum(dutyfe),60) mdutyfe    from(        SELECT FLEET_CD fleet,              CA ca,              PIC pic,              FO fo,              FE fe,              INST inst,              NIGHT night,              DUTYIP dutyip,              DUTYSF dutysf,              DUTYCA dutyca,              DUTYFO dutyfo,              DUTYFE dutyfe, PIC2 pic2  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Thisyear__myempn + "' and fleet_cd <> 'OPS' and YY='" + Thisyear__myyear + "' and MM<='" + Thisyear__mymonth + "' )  GROUP BY fleet  ORDER BY fleet ASC");
		Thisyear = StatementThisyear.executeQuery();
		boolean Thisyear_isEmpty = !Thisyear.next();
		boolean Thisyear_hasData = !Thisyear_isEmpty;
		out.print("<script>"); out.print("//Read DB thisyear "+Thisyear__myyear+"/"+Thisyear__mymonth) ; 
		 out.print("//Thisyear_isEmpty="+Thisyear_isEmpty) ; 
		  out.print("//Thisyear_hasData="+Thisyear_hasData) ; out.println("</script>");
		Object Thisyear_data;
		int Thisyear_numRows = 0;

		String Thismonth__myempn = "633334";

		String Thismonth__myyear = "2010";

		String Thismonth__mymonth = "01";

		// THIS MONTH
		StatementThismonth = conn.prepareStatement("SELECT fleet,         trunc(sum(ca) / 60) tca,         mod(sum(ca),60) mca,         trunc(sum(pic) / 60) tpic,         mod(sum(pic),60) mpic, trunc(sum(pic2) / 60) tpic2,         mod(sum(pic2),60) mpic2,         trunc(sum(fo) / 60) tfo,         mod(sum(fo),60) mfo,         trunc(sum(fe) / 60) tfe,         mod(sum(fe),60) mfe,         trunc(sum(inst) / 60) tinst,         mod(sum(inst),60) minst,         trunc(sum(night) / 60) tnight,         mod(sum(night),60) mnight,         trunc(sum(dutyip) / 60) tdutyip,         mod(sum(dutyip),60) mdutyip,         trunc(sum(dutysf) / 60) tdutysf,         mod(sum(dutysf),60) mdutysf,         trunc(sum(dutyca) / 60) tdutyca,         mod(sum(dutyca),60) mdutyca,         trunc(sum(dutyfo) / 60) tdutyfo,         mod(sum(dutyfo),60) mdutyfo,         trunc(sum(dutyfe) / 60) tdutyfe,         mod(sum(dutyfe),60) mdutyfe    from(        SELECT FLEET_CD fleet,              CA ca,              PIC pic,              FO fo,              FE fe,              INST inst,              NIGHT night,              DUTYIP dutyip,              DUTYSF dutysf,              DUTYCA dutyca,              DUTYFO dutyfo,              DUTYFE dutyfe, PIC2 pic2  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Thismonth__myempn + "' and fleet_cd <> 'OPS' and YY='" + Thismonth__myyear + "' and MM='" + Thismonth__mymonth + "' )  GROUP BY fleet  ORDER BY fleet ASC");
		Thismonth = StatementThismonth.executeQuery();
		boolean Thismonth_isEmpty = !Thismonth.next();
		boolean Thismonth_hasData = !Thismonth_isEmpty;
		out.print("<script>"); out.print("//Read DB thismonth "+Thismonth__myyear+"/"+Thismonth__mymonth) ; 
		 out.print("//Thismonth_isEmpty="+Thismonth_isEmpty) ; 
		  out.print("//Thismonth_hasData="+Thismonth_hasData) ; out.println("</script>");
		Object Thismonth_data;
		int Thismonth_numRows = 0;
		%>
		<%
		String Acctotal__myempn = "633334";
		%>
		<%
		String Acctotal__myyear = "2010";
		%>
		<%
		String Acctotal__mymonth = "01";
		%>
		<%
		StatementAcctotal = conn.prepareStatement("SELECT empn,         trunc(sum(ca) / 60) tca,         mod(sum(ca),60) mca,         trunc(sum(pic) / 60) tpic,         mod(sum(pic),60) mpic, trunc(sum(pic2) / 60) tpic2,         mod(sum(pic2),60) mpic2,         trunc(sum(fo) / 60) tfo,         mod(sum(fo),60) mfo,         trunc(sum(fe) / 60) tfe,         mod(sum(fe),60) mfe,         trunc(sum(inst) / 60) tinst,         mod(sum(inst),60) minst,         trunc(sum(night) / 60) tnight,         mod(sum(night),60) mnight,         trunc(sum(dutyip) / 60) tdutyip,         mod(sum(dutyip),60) mdutyip,         trunc(sum(dutysf) / 60) tdutysf,         mod(sum(dutysf),60) mdutysf,         trunc(sum(dutyca) / 60) tdutyca,         mod(sum(dutyca),60) mdutyca,         trunc(sum(dutyfo) / 60) tdutyfo,         mod(sum(dutyfo),60) mdutyfo,         trunc(sum(dutyfe) / 60) tdutyfe,         mod(sum(dutyfe),60) mdutyfe    from(        SELECT STAFF_NUM empn,           FLEET_CD fleet,              CA ca,              PIC pic,              FO fo,              FE fe,              INST inst,              NIGHT night,              DUTYIP dutyip,              DUTYSF dutysf,              DUTYCA dutyca,              DUTYFO dutyfo,              DUTYFE dutyfe, PIC2 pic2  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Acctotal__myempn + "' and fleet_cd <> 'OPS' and ((YY='" + Acctotal__myyear + "' and MM<='" + Acctotal__mymonth + "') or YY<'" + Acctotal__myyear + "') )  GROUP BY empn");
		Acctotal = StatementAcctotal.executeQuery();
		out.print("<script>"); out.print("//Read DB Acctotal") ; out.println("</script>");
		boolean Acctotal_isEmpty = !Acctotal.next();
		boolean Acctotal_hasData = !Acctotal_isEmpty;
		Object Acctotal_data;
		int Acctotal_numRows = 0;
		%>
		<%
		String Yeartotal__myempn = "633334";
		%>
		<%
		String Yeartotal__myyear = "2010";
		%>
		<%
		String Yeartotal__mymonth = "01";
		%>
		<%
		StatementYeartotal = conn.prepareStatement("SELECT empn,         trunc(sum(ca) / 60) tca,         mod(sum(ca),60) mca,         trunc(sum(pic) / 60) tpic,         mod(sum(pic),60) mpic, trunc(sum(pic2) / 60) tpic2,         mod(sum(pic2),60) mpic2,         trunc(sum(fo) / 60) tfo,         mod(sum(fo),60) mfo,         trunc(sum(fe) / 60) tfe,         mod(sum(fe),60) mfe,         trunc(sum(inst) / 60) tinst,         mod(sum(inst),60) minst,         trunc(sum(night) / 60) tnight,         mod(sum(night),60) mnight,         trunc(sum(dutyip) / 60) tdutyip,         mod(sum(dutyip),60) mdutyip,         trunc(sum(dutysf) / 60) tdutysf,         mod(sum(dutysf),60) mdutysf,         trunc(sum(dutyca) / 60) tdutyca,         mod(sum(dutyca),60) mdutyca,         trunc(sum(dutyfo) / 60) tdutyfo,         mod(sum(dutyfo),60) mdutyfo,         trunc(sum(dutyfe) / 60) tdutyfe,         mod(sum(dutyfe),60) mdutyfe    from(        SELECT STAFF_NUM empn,           FLEET_CD fleet,              CA ca,              PIC pic,              FO fo,              FE fe,              INST inst,              NIGHT night,              DUTYIP dutyip,              DUTYSF dutysf,              DUTYCA dutyca,              DUTYFO dutyfo,              DUTYFE dutyfe, PIC2 pic2  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Yeartotal__myempn + "' and fleet_cd <> 'OPS' and YY='" + Yeartotal__myyear + "' and MM<='" + Yeartotal__mymonth + "' )  GROUP BY empn");
		Yeartotal = StatementYeartotal.executeQuery();
		out.print("<script>"); out.print("//Read DB Yeartotal") ; out.println("</script>");
		boolean Yeartotal_isEmpty = !Yeartotal.next();
		boolean Yeartotal_hasData = !Yeartotal_isEmpty;
		Object Yeartotal_data;
		int Yeartotal_numRows = 0;
		%>
		<%
		String Monthtotal__myempn = "633334";
		%>
		<%
		String Monthtotal__myyear = "2010";
		%>
		<%
		String Monthtotal__mymonth = "01";
		%>
		<%
		StatementMonthtotal = conn.prepareStatement("SELECT empn,         trunc(sum(ca) / 60) tca,         mod(sum(ca),60) mca,         trunc(sum(pic) / 60) tpic,         mod(sum(pic),60) mpic, trunc(sum(pic2) / 60) tpic2,         mod(sum(pic2),60) mpic2,         trunc(sum(fo) / 60) tfo,         mod(sum(fo),60) mfo,         trunc(sum(fe) / 60) tfe,         mod(sum(fe),60) mfe,         trunc(sum(inst) / 60) tinst,         mod(sum(inst),60) minst,         trunc(sum(night) / 60) tnight,         mod(sum(night),60) mnight,         trunc(sum(dutyip) / 60) tdutyip,         mod(sum(dutyip),60) mdutyip,         trunc(sum(dutysf) / 60) tdutysf,         mod(sum(dutysf),60) mdutysf,         trunc(sum(dutyca) / 60) tdutyca,         mod(sum(dutyca),60) mdutyca,         trunc(sum(dutyfo) / 60) tdutyfo,         mod(sum(dutyfo),60) mdutyfo,         trunc(sum(dutyfe) / 60) tdutyfe,         mod(sum(dutyfe),60) mdutyfe    from(        SELECT STAFF_NUM empn,           FLEET_CD fleet,              CA ca,              PIC pic,              FO fo,              FE fe,              INST inst,              NIGHT night,              DUTYIP dutyip,              DUTYSF dutysf,              DUTYCA dutyca,              DUTYFO dutyfo,              DUTYFE dutyfe, PIC2 pic2  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Monthtotal__myempn + "' and fleet_cd <> 'OPS' and YY='" + Monthtotal__myyear + "' and MM='" + Monthtotal__mymonth + "' )  GROUP BY empn");
		Monthtotal = StatementMonthtotal.executeQuery();
		out.print("<script>"); out.print("//Read DB Monthtotal") ; out.println("</script>");
		boolean Monthtotal_isEmpty = !Monthtotal.next();
		boolean Monthtotal_hasData = !Monthtotal_isEmpty;
		Object Monthtotal_data;
		int Monthtotal_numRows = 0;
		%>
		<%
		String Acctold__myempn = "636018";
		if (request.getParameter("empno") !=null) {Acctold__myempn = (String)request.getParameter("empno");}
		%>
		<%
		String Acctold__myyear = "2002";
		if (request.getParameter("year") !=null) {Acctold__myyear = (String)request.getParameter("year");}
		%>
		<%
		String Acctold__mymonth = "5";
		if (request.getParameter("month") !=null) {Acctold__mymonth = (String)request.getParameter("month");}
		%>
		<%
		StatementAcctold = conn.prepareStatement("SELECT empn, fleet,        sum(today) ttoday, sum(tonit) ttonit,           sum(ldday) tldday, sum(ldnit) tldnit from   (SELECT STAFF_NUM empn, fleet_cd fleet, TODAY today, TONIT tonit, LDDAY ldday, LDNIT ldnit  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Acctold__myempn + "' and ((YY='" + Acctold__myyear + "' and MM<='" + Acctold__mymonth + "') or YY<'" + Acctold__myyear + "') and fleet_cd <> 'OPS')  GROUP BY empn, fleet");
		Acctold = StatementAcctold.executeQuery();
		out.print("<script>"); out.print("//Read DB Acctold") ; out.println("</script>");
		boolean Acctold_isEmpty = !Acctold.next();
		boolean Acctold_hasData = !Acctold_isEmpty;
		Object Acctold_data;
		int Acctold_numRows = 0;

		String Monthtold__myempn = "633334";

		String Monthtold__myyear = "2010";

		String Monthtold__mymonth = "01";

		StatementMonthtold = conn.prepareStatement("SELECT empn, fleet, sum(today) ttoday,           sum(tonit) ttonit, sum(ldday) tldday,  sum(ldnit) tldnit  from (SELECT STAFF_NUM empn, fleet_cd fleet, TODAY today,  TONIT tonit,LDDAY ldday,LDNIT ldnit  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Monthtold__myempn + "' and YY='" + Monthtold__myyear + "' and MM='" + Monthtold__mymonth + "' and fleet_cd <> 'OPS')  GROUP BY empn,fleet");
		Monthtold = StatementMonthtold.executeQuery();
		out.print("<script>"); out.print("//Read DB Monthtold") ; out.println("</script>");
		boolean Monthtold_isEmpty = !Monthtold.next();
		boolean Monthtold_hasData = !Monthtold_isEmpty;
		Object Monthtold_data;
		int Monthtold_numRows = 0;

		String Acccafototal__myempn = "633334";

		String Acccafototal__myyear = "2010";

		String Acccafototal__mymonth = "01";

		StatementAcccafototal = conn.prepareStatement("SELECT trunc(scafo / 60) tcafo,         mod(scafo, 60) mcafo,         trunc(sfe / 60) tfe,         mod(sfe, 60) mfe,         trunc(sdutycafo / 60) tdutycafo,         mod(sdutycafo, 60) mdutycafo,         trunc(sdutyfe / 60) tdutyfe,         mod(sdutyfe, 60) mdutyfe  from(  select empn,         sum(ca) + sum(fo) scafo,         sum(fe) sfe,         sum(dutyca) + sum(dutyfo) + sum(dutyip) sdutycafo,         sum(dutyfe) sdutyfe  from(        SELECT STAFF_NUM empn,           CA ca,              FO fo,           FE fe,           DUTYCA dutyca,              DUTYFO dutyfo,      DUTYIP dutyip,        DUTYFE dutyfe  FROM dfdb.DFTCREC  WHERE STAFF_NUM='" + Acccafototal__myempn + "' and fleet_cd <> 'OPS' and ((YY='" + Acccafototal__myyear + "' and MM<='" + Acccafototal__mymonth + "') or YY<'" + Acccafototal__myyear + "') )  GROUP BY empn)");
		Acccafototal = StatementAcccafototal.executeQuery();
		out.print("<script>"); out.print("//Read DB Acccafototal") ; out.println("</script>");
		boolean Acccafototal_isEmpty = !Acccafototal.next();
		boolean Acccafototal_hasData = !Acccafototal_isEmpty;
		Object Acccafototal_data;
		int Acccafototal_numRows = 0;

		String Monthstold__myempn = "633334";

		String Monthstold__myyear = "2010";

		String Monthstold__mymonth = "01";

		//modify by cs55 2002/9/17
		int startyear = Integer.parseInt(Monthstold__myyear);
		int startmonth = Integer.parseInt(Monthstold__mymonth);
		String mysql = null;
		if (startmonth <= 2)
		{
				startmonth = startmonth + 12 - 2;
				startyear = startyear - 1;
				String year1 = String.valueOf(startyear);
				String month1 = String.valueOf(startmonth);
				mysql = "select empn, fleet, sum(today) ttoday, sum(tonit) ttonit, " +
							   "sum(ldday) tldday, sum(ldnit) tldnit from ( " +
							   "SELECT STAFF_NUM empn, fleet_cd fleet,TODAY today,TONIT tonit," +
							   "LDDAY ldday,LDNIT ldnit FROM dfdb.DFTCREC " +
							   "WHERE STAFF_NUM='" + Monthstold__myempn + "' and ((YY='" +
								year1 + "' and MM>='" + month1 + "') or (YY='" + 
								Monthstold__myyear + "' and MM<='" + Monthstold__mymonth +
								 "'))  and fleet_cd <> 'OPS')  GROUP BY empn,fleet";
		}
		else
		{
				mysql = "select empn, fleet,         sum(today) ttoday,         sum(tonit) ttonit,         sum(ldday) tldday,         sum(ldnit) tldnit  from (SELECT STAFF_NUM empn, fleet_cd fleet,           TODAY today,              TONIT tonit,              LDDAY ldday,              LDNIT ldnit      FROM dfdb.DFTCREC       WHERE STAFF_NUM='" + Monthstold__myempn + "' and YY='" + Monthstold__myyear + "' and MM<='" + Monthstold__mymonth + "' and MM>='" + Monthstold__mymonth + "'-2  and fleet_cd <> 'OPS')  GROUP BY empn,fleet";
		}
		//2002/9/17 end

		StatementMonthstold = conn.prepareStatement(mysql);
		Monthstold = StatementMonthstold.executeQuery();
		out.print("<script>"); out.print("//Read DB Monthstold") ; out.println("</script>");
		boolean Monthstold_isEmpty = !Monthstold.next();
		boolean Monthstold_hasData = !Monthstold_isEmpty;
		Object Monthstold_data;
		int Monthstold_numRows = 0;

		int Repeat2__numRows = -1;
		int Repeat2__index = 0;
		Thisyear_numRows += Repeat2__numRows;

		int Repeat3__numRows = -1;
		int Repeat3__index = 0;
		Thismonth_numRows += Repeat3__numRows;

		int Repeat6__numRows = -1;
		int Repeat6__index = 0;
		Acctold_numRows += Repeat6__numRows;

		int Repeat5__numRows = -1;
		int Repeat5__index = 0;
		Monthstold_numRows += Repeat5__numRows;

		int Repeat4__numRows = -1;
		int Repeat4__index = 0;
		Monthtold_numRows += Repeat4__numRows;

		int Repeat1__numRows = -1;
		int Repeat1__index = 0;
		Recordset1_numRows += Repeat1__numRows;
		out.print("<script>"); out.print("//End of segment-1 JSP") ; out.println("</script>");
		%>
		</head>
		<body>
		<div align="center"><font face="Arial, Helvetica, sans-serif" size="3"><strong>China Airlines 
			Cockpit Crew Personal Record</strong></font>
		</div>
		<div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><strong><font color="#000099">Report ID : 
		  DFP001 </font></strong></font></div>
		<table width="100%" border="0" align="center">
		  <tr> 
			<td width="15%"><font color="#000099"><strong><font face="Arial, Helvetica, sans-serif" size="2"><%= ((request.getParameter("empno")!=null)?request.getParameter("empno"):"") %></font></strong></font></td>
			<td width="53%"><font color="#000099"><strong><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("ENAME"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></strong></font></td>
			<td width="32%"> 
			  <div align="right"><font color="#000099"><strong><font face="Arial, Helvetica, sans-serif" size="2">Accumulate 
				Data Month:<%= ((request.getParameter("year")!=null)?request.getParameter("year"):"") %>/<%= ((request.getParameter("month")!=null)?request.getParameter("month"):"") %></font></strong></font></div>
			</td>
		  </tr>
		</table>
		<div align="center"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><strong>&lt;Accumulate&gt;</strong></font></div>
		
		
		<table width="100%" border="1" align="center" cellspacing="0" cellpadding="0">
		<!-- On Seat Block Time -->
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2">&nbsp;</font></font></font></div>
			</td>
			<td colspan="4"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><strong>On-Seat 
				Block Time</strong></font></div>
			</td>
			<td colspan="2">&nbsp;
			</td>
			<td colspan="6"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><strong>Duty 
			Block Time</strong></font></font></font></div>			  <div align="center"></div></td>
		  </tr>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Actype</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">CA</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FO</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FE</font></strong></div>
			</td>
			<td width="7%"><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">PIC(U/S)</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Instrum</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Night</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">IP</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">SF</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">CA</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FO</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FE</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">PIC</font></strong></div>
			</td>
		  </tr>
		<%	out.print("<script>"); 
			out.print("//Recordset1_hasData= "+Recordset1_hasData) ; 
			out.print("//Repeat1__numRows= "+Repeat1__numRows) ; 
			out.println("</script>");  %>
		  
		 <%   while ((Recordset1_hasData)&&(Repeat1__numRows-- != 0)) { %>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("FLEET"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TCA"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MCA"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TFO"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MFO"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TFE"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MFE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%">
			<div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TPIC2"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MPIC2"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TINST"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MINST"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TNIGHT"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MNIGHT"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TDUTYIP"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MDUTYIP"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TDUTYSF"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MDUTYSF"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TDUTYCA"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MDUTYCA"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TDUTYFO"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MDUTYFO"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TDUTYFE"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MDUTYFE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font size="2"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><%=(((Recordset1_data = Recordset1.getObject("TPIC"))==null || Recordset1.wasNull())?"":Recordset1_data)%>:<%=(((Recordset1_data = Recordset1.getObject("MPIC"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></font></font><font face="Arial, Helvetica, sans-serif"></font></font></font></font></div>
			</td>
		  </tr>
		  <%
		  Repeat1__index++;
		  Recordset1_hasData = Recordset1.next();
		}
		%>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Total</font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TCA"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MCA"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TFO"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MFO"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TFE"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MFE"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%">
			<div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TPIC2"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MPIC2"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TINST"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MINST"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TNIGHT"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MNIGHT"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TDUTYIP"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MDUTYIP"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TDUTYSF"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MDUTYSF"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TDUTYCA"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MDUTYCA"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TDUTYFO"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MDUTYFO"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TDUTYFE"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MDUTYFE"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctotal_data = Acctotal.getObject("TPIC"))==null || Acctotal.wasNull())?"":Acctotal_data)%>:<%=(((Acctotal_data = Acctotal.getObject("MPIC"))==null || Acctotal.wasNull())?"":Acctotal_data)%></font></div>
			</td>
		  </tr>
		</table>
		<table width="100%" border="0" align="center">
		  <tr> 
			<td width="10%"><strong><font color="#006633" size="2" face="Arial, Helvetica, sans-serif">Flight 
			  Total </font></strong></td>
			<td width="22%"><strong><font color="#006633" size="2" face="Arial, Helvetica, sans-serif">CA/FO : 
			  <%=(((Acccafototal_data = Acccafototal.getObject("TCAFO"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%>:<%=(((Acccafototal_data = Acccafototal.getObject("MCAFO"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%></font></strong></td>
			<td width="17%"><strong><font color="#006633" size="2" face="Arial, Helvetica, sans-serif">FE : <%=(((Acccafototal_data = Acccafototal.getObject("TFE"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%>:<%=(((Acccafototal_data = Acccafototal.getObject("MFE"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%></font></strong></td>
			<td width="25%"> 
			  <div align="right"><font color="#006633"><strong><font size="2" face="Arial, Helvetica, sans-serif">CA/FO 
				: <%=(((Acccafototal_data = Acccafototal.getObject("TDUTYCAFO"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%>:<%=(((Acccafototal_data = Acccafototal.getObject("MDUTYCAFO"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%></font></strong></font></div>
			</td>
			<td width="26%"> 
			  <div align="right"><font color="#006633"><strong><font size="2" face="Arial, Helvetica, sans-serif">FE 
				: <%=(((Acccafototal_data = Acccafototal.getObject("TDUTYFE"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%>:<%=(((Acccafototal_data = Acccafototal.getObject("MDUTYFE"))==null || Acccafototal.wasNull())?"":Acccafototal_data)%></font></strong></font></div>
			</td>
		  </tr>
		</table>
		<div align="center">
		  
			<table width="100%" border="1" cellpadding="0" cellspacing="0" align="center">
			<tr>
			  <td colspan="5"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">&lt;Accumulate&gt;</font></strong></div></td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			  <td colspan="2"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Takeoff</font></strong></div></td>
			  <td colspan="2"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Landing</font></strong></div></td>
			</tr>
			<tr>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Fleet</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Day</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font size="2"><font face="Arial, Helvetica, sans-serif" size="2">Day</font></font></font></font></font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></font></font></font></div></td>
			</tr>
			<%
			ttd = 0;
			ttn = 0;
			tld = 0;
			tln = 0; 
			while ((Acctold_hasData)&&(Repeat6__numRows-- != 0)) { 
			if(Acctold.getInt("TTODAY") == 0 && Acctold.getInt("TTONIT") == 0 && Acctold.getInt("TLDDAY") == 0 && Acctold.getInt("TLDNIT") == 0){
			//nothing to do
			}
			else{
			%>
			<tr>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Acctold_data = Acctold.getObject("FLEET"))==null || Acctold.wasNull())?"":Acctold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctold_data = Acctold.getObject("TTODAY"))==null || Acctold.wasNull())?"":Acctold_data)%></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctold_data = Acctold.getObject("TTONIT"))==null || Acctold.wasNull())?"":Acctold_data)%></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctold_data = Acctold.getObject("TLDDAY"))==null || Acctold.wasNull())?"":Acctold_data)%></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Acctold_data = Acctold.getObject("TLDNIT"))==null || Acctold.wasNull())?"":Acctold_data)%></font></div></td>
			</tr>
			<%
			}
			ttd = ttd + Acctold.getInt("TTODAY");
			ttn = ttn + Acctold.getInt("TTONIT");
			tld = tld + Acctold.getInt("TLDDAY");
			tln = tln + Acctold.getInt("TLDNIT");
		  Repeat6__index++;
		  Acctold_hasData = Acctold.next();
		}
		%>
		  <tr>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2">Total</font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=ttd%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=ttn%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=tld%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=tln%></font></font></font></div></td>
			</tr>
		  </table>
		<strong><font color="#0000FF">&lt;<font face="Arial, Helvetica, sans-serif" size="2">This 
				  Year&gt;</font></font></strong>
		</div>
		
		
		<table border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
		  <tr> 
			<td height="15"> 
			  <div align="center">&nbsp;</div>
			</td>
			<td colspan="4" height="15"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">On-Seat 
				Block Time</font></strong></div>
			</td>
			<td colspan="2" height="15">&nbsp;</td>
			<td colspan="6" height="15"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Duty 
				Block Time</font></strong></div>
			</td>
		  </tr>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Actype</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">CA</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FO</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FE</font></strong></div>
			</td>
			<td width="7%"><div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">PIC(U/S)</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Instrum</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Night</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">IP</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">SF</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">CA</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FO</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">FE</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">PIC</font></strong></div>
			</td>
		  </tr>
		  <% while ((Thisyear_hasData)&&(Repeat2__numRows-- != 0)) { %>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("FLEET"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TCA"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MCA"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TFO"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MFO"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TFE"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MFE"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%">
			<div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TPIC2"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MPIC2"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TINST"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MINST"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TNIGHT"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MNIGHT"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TDUTYIP"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MDUTYIP"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TDUTYSF"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MDUTYSF"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TDUTYCA"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MDUTYCA"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TDUTYFO"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MDUTYFO"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font size="2" face="Arial, Helvetica, sans-serif"><%=(((Thisyear_data = Thisyear.getObject("TDUTYFE"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MDUTYFE"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thisyear_data = Thisyear.getObject("TPIC"))==null || Thisyear.wasNull())?"":Thisyear_data)%>:<%=(((Thisyear_data = Thisyear.getObject("MPIC"))==null || Thisyear.wasNull())?"":Thisyear_data)%></font></div>
			</td>
		  </tr>
		  <%
		  Repeat2__index++;
		  Thisyear_hasData = Thisyear.next();
		}
		%>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Total</font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TCA"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MCA"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TFO"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MFO"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TFE"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MFE"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%">
			<div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TPIC2"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MPIC2"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TINST"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MINST"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TNIGHT"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MNIGHT"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TDUTYIP"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MDUTYIP"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TDUTYSF"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MDUTYSF"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TDUTYCA"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MDUTYCA"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TDUTYFO"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MDUTYFO"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TDUTYFE"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MDUTYFE"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Yeartotal_data = Yeartotal.getObject("TPIC"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%>:<%=(((Yeartotal_data = Yeartotal.getObject("MPIC"))==null || Yeartotal.wasNull())?"":Yeartotal_data)%></font></font></font></div>
			</td>
		  </tr>
		</table>
		
		
		
		<div align="center"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><strong>&lt;This 
		  Month&gt;</strong></font></div>
		<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
		  <tr> 
			<td width="7%"> 
			  <div align="center">&nbsp;</div>
			</td>
			<td colspan="4"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">On-Seat 
				Block Time</font></strong></div>
			</td>
			<td colspan="2">&nbsp; 
			  
			</td>
			<td colspan="6"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Duty 
				Block Time</font></strong></div>
			</td>
		  </tr>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Actype</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">CA</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">FO</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">FE</font></strong></div>
			</td>
			<td width="7%">
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">PIC(U/S)</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Instrum</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Night</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">IP</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">SF</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">CA</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">FO</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">FE</font></strong></div>
			</td>
			<td width="7%"> 
			  <div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">PIC</font></strong></div>
			</td>
		  </tr>
		  <% while ((Thismonth_hasData)&&(Repeat3__numRows-- != 0)) { %>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("FLEET"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2">
			  	<%=(((Thismonth_data = Thismonth.getObject("TCA"))==null || Thismonth.wasNull())?"":Thismonth_data)%>
				:
				<%=(((Thismonth_data = Thismonth.getObject("MCA"))==null || Thismonth.wasNull())?"":Thismonth_data)%>
			</font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TFO"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MFO"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TFE"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MFE"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%">
			<div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TPIC2"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MPIC2"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TINST"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MINST"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TNIGHT"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MNIGHT"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TDUTYIP"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MDUTYIP"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TDUTYSF"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MDUTYSF"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TDUTYCA"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MDUTYCA"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TDUTYFO"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MDUTYFO"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TDUTYFE"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MDUTYFE"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Thismonth_data = Thismonth.getObject("TPIC"))==null || Thismonth.wasNull())?"":Thismonth_data)%>:<%=(((Thismonth_data = Thismonth.getObject("MPIC"))==null || Thismonth.wasNull())?"":Thismonth_data)%></font></div>
			</td>
		  </tr>
		  <%
		  Repeat3__index++;
		  Thismonth_hasData = Thismonth.next();
		}
		%>
		  <tr> 
			<td width="7%"> 
			  <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Total</font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TCA"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MCA"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TFO"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MFO"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TFE"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MFE"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%">
			<div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TPIC2"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MPIC2"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TINST"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MINST"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TNIGHT"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MNIGHT"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TDUTYIP"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MDUTYIP"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TDUTYSF"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MDUTYSF"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TDUTYCA"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MDUTYCA"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TDUTYFO"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MDUTYFO"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TDUTYFE"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MDUTYFE"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
			<td width="7%"> 
			  <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Monthtotal_data = Monthtotal.getObject("TPIC"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%>:<%=(((Monthtotal_data = Monthtotal.getObject("MPIC"))==null || Monthtotal.wasNull())?"":Monthtotal_data)%></font></div>
			</td>
		  </tr>
		</table>
		<div align="center"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><strong>Takeoff Landing Statistic</strong></font></div>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0" align="center">
			<tr>
			  <td colspan="5"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">&lt;This Month&gt;</font></strong></div></td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			  <td colspan="2"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Takeoff</font></strong></div></td>
			  <td colspan="2"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Landing</font></strong></div></td>
			</tr>
			<tr>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Fleet</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Day</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font size="2"><font face="Arial, Helvetica, sans-serif" size="2">Day</font></font></font></font></font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></font></font></font></div></td>
			</tr>
			<%
			ttd = 0;
			ttn = 0;
			tld = 0;
			tln = 0; 
			while ((Monthtold_hasData)&&(Repeat4__numRows-- != 0)) { %>
			<tr>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthtold_data = Monthtold.getObject("FLEET"))==null || Monthtold.wasNull())?"":Monthtold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthtold_data = Monthtold.getObject("TTODAY"))==null || Monthtold.wasNull())?"":Monthtold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthtold_data = Monthtold.getObject("TTONIT"))==null || Monthtold.wasNull())?"":Monthtold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthtold_data = Monthtold.getObject("TLDDAY"))==null || Monthtold.wasNull())?"":Monthtold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthtold_data = Monthtold.getObject("TLDNIT"))==null || Monthtold.wasNull())?"":Monthtold_data)%></font></font></font></div></td>
			</tr>
			<%
			ttd = ttd + Monthtold.getInt("TTODAY");
			ttn = ttn + Monthtold.getInt("TTONIT");
			tld = tld + Monthtold.getInt("TLDDAY");
			tln = tln + Monthtold.getInt("TLDNIT");
		  Repeat4__index++;
		  Monthtold_hasData = Monthtold.next();
		}
		%>
			<tr>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2">Total</font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=ttd%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=ttn%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=tld%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=tln%></font></font></font></div></td>
			</tr>
			<tr>
			  <td colspan="5"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">&lt;Last 3 Months&gt;</font></strong></div></td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			  <td colspan="2"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Takeoff</font></strong></div></td>
			  <td colspan="2"><div align="center"><strong><font face="Arial, Helvetica, sans-serif" size="2">Landing</font></strong></div></td>
			</tr>
			<tr>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Fleet</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Day</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font size="2"><font face="Arial, Helvetica, sans-serif" size="2">Day</font></font></font></font></font></div></td>
			  <td width="7%"><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></font></font></font></div></td>
			</tr>
			<% 
			ttd = 0;
			ttn = 0;
			tld = 0;
			tln = 0;
			while ((Monthstold_hasData)&&(Repeat5__numRows-- != 0)) { %>
			<tr>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthstold_data = Monthstold.getObject("FLEET"))==null || Monthstold.wasNull())?"":Monthstold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthstold_data = Monthstold.getObject("TTODAY"))==null || Monthstold.wasNull())?"":Monthstold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthstold_data = Monthstold.getObject("TTONIT"))==null || Monthstold.wasNull())?"":Monthstold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthstold_data = Monthstold.getObject("TLDDAY"))==null || Monthstold.wasNull())?"":Monthstold_data)%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=(((Monthstold_data = Monthstold.getObject("TLDNIT"))==null || Monthstold.wasNull())?"":Monthstold_data)%></font></font></font></div></td>
			</tr>
			<%
			ttd = ttd + Monthstold.getInt("TTODAY");
			ttn = ttn + Monthstold.getInt("TTONIT");
			tld = tld + Monthstold.getInt("TLDDAY");
			tln = tln + Monthstold.getInt("TLDNIT");
		  Repeat5__index++;
		  Monthstold_hasData = Monthstold.next();
		}
		%>
			<tr>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2">Total</font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=ttd%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=ttn%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=tld%></font></font></font></div></td>
			  <td><div align="center"><font face="Arial, Helvetica, sans-serif"><font face="Arial, Helvetica, sans-serif"><font size="2"><%=tln%></font></font></font></div></td>
			</tr>
		</table>
	    <p><br>
			  <font face="Arial, Helvetica, sans-serif" size="2">Duty Block Time:CA=CP+IP, 
			FE=IFE+FE</font>
		  <br>
			  <font face="Arial, Helvetica, sans-serif" size="2">AC-Type:BEF=Before CAL, 
			OTR=Other type</font>
			<br>
			  <font face="Arial, Helvetica, sans-serif" size="2">Takeoff/Landing record from 
			1994/11</font>
			<br>
			  <font face="Arial, Helvetica, sans-serif" size="2">NIT and INST record from 
			1997/11</font>
			<br>
			  <font face="Arial, Helvetica, sans-serif" size="2">744/742 split record from 
		2000/01</font>
		<br>
		<font face="Arial, Helvetica, sans-serif" size="2">PIC(U/S) record from 2005/01/01</font>
		<br>
		<font face="Arial, Helvetica, sans-serif" size="2">cs57 test</font>
		</body>
		</html>
<%
}
catch (Exception e)
{
	out.println(e);
	//out.print("Thisyear__myyear= "+Thisyear__myyear);
	out.println("N/A");
}
finally
{
	try{if(Recordset1 != null) Recordset1.close();}catch(SQLException e){}
	try{if(Recordset2 != null) Recordset2.close();}catch(SQLException e){}
	try{if(Thisyear != null) Thisyear.close();}catch(SQLException e){}
	try{if(Thismonth != null) Thismonth.close();}catch(SQLException e){}
	try{if(Acctotal != null) Acctotal.close();}catch(SQLException e){}
	try{if(Yeartotal != null) Yeartotal.close();}catch(SQLException e){}
	try{if(Monthtotal != null) Monthtotal.close();}catch(SQLException e){}
	try{if(Acctold != null) Acctold.close();}catch(SQLException e){}
	try{if(Monthtold != null) Monthtold.close();}catch(SQLException e){}
	try{if(Acccafototal != null) Acccafototal.close();}catch(SQLException e){}
	try{if(Monthstold != null) Monthstold.close();}catch(SQLException e){}
	try{if(StatementRecordset1 != null) StatementRecordset1.close();}catch(SQLException e){}
	try{if(StatementRecordset2 != null) StatementRecordset2.close();}catch(SQLException e){}
	try{if(StatementThisyear != null) StatementThisyear.close();}catch(SQLException e){}
	try{if(StatementThismonth != null) StatementThismonth.close();}catch(SQLException e){}
	try{if(StatementAcctotal != null) StatementAcctotal.close();}catch(SQLException e){}
	try{if(StatementYeartotal != null) StatementYeartotal.close();}catch(SQLException e){}
	try{if(StatementMonthtotal != null) StatementMonthtotal.close();}catch(SQLException e){}
	try{if(StatementAcctold != null) StatementAcctold.close();}catch(SQLException e){}
	try{if(StatementMonthtold != null) StatementMonthtold.close();}catch(SQLException e){}
	try{if(StatementAcccafototal != null) StatementAcccafototal.close();}catch(SQLException e){}
	try{if(StatementMonthstold != null) StatementMonthstold.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>