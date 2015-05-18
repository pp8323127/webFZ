<%@ page contentType="text/html; charset=big5" 
		language="java" 
		import="crewhr.*,java.sql.*,fz.*,java.util.*,java.text.*,ci.db.*"  
		errorPage="err.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Hours</title>
<link href="../menu.css" rel="stylesheet" type="text/css">



</head>
<%
String y = request.getParameter("sel_year");
String m = request.getParameter("sel_mon");
String mid = request.getParameter("sel_emp");

  String cname = null;
  String ename = null;
 
  String[] dat = new String[50];
  String[] flt  = new String[50];
  String[] dpt = new String[50];
  String[] arv= new String[50];
  String[] blkout = new String[50];
  String[] off = new String[50];
  String[] land = new String[50];
  String[] blkin = new String[50];
  String[] flyhr = new String[50];
  float[] blk = new float[50];
  String[] travhr = new String[50];
  String[] duty = new String[50];
  String[] da = new String[50];
  
  int xCount = 0;
  float[] blkhr = new float[50];
  float total_jcblk = 0;
  float total_blk = 0;

Connection conn = null;
Statement stmt = null;
ResultSet dr1 = null;
ResultSet dr2 = null;
 Driver dbDriver = null;
try{

ConnDB cn = new ConnDB();

cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(); 

String sql = "select * from dftcrew where empno='"+mid+"'";
String sql2 = "select f.bod bod,f.year,f.mon,f.dd,f.dpt,f.arv,f.blkout,f.takeoff,f.landing,f.blkin,f.blk blkhr,"
			 +"round(f.fly/60,3) flyhr,nvl(da,'&nbsp;') da,fltno,nvl(duty,'&nbsp;') duty,nvl(jobid,'&nbsp;') jobid "
			 +"from dftlogf f,dftlogc c"
			+" where year='"+y+"' and mon='"+m+"' and f.logno=c.logno and empno='"+mid+"' and (c.jobid not in ('E','M') or c.jobid is null)"
			+" order by f.bod,f.blkout";
//out.print(sql2);
dr1 = stmt.executeQuery(sql);
int countdr1 = 0;
if(dr1 != null)
{
	while( dr1.next() )
	{		
		cname =dr1.getString("name");
		ename = dr1.getString("ename");
		countdr1++;
	}
}
if(countdr1 ==0){
%>

	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="<br><br><br><br>無此員工的資料<BR>No Data!!" />
	</jsp:forward>

<%
}
dr2 = stmt.executeQuery(sql2);
if(dr2 != null)
{
  while( dr2.next())
  {
   dat[xCount] = dr2.getString("bod");
   flt[xCount] = dr2.getString("fltno");
   dpt[xCount] = dr2.getString("dpt");
   //4 City Code Conversion
   if(dpt[xCount].equals("TYO")) dpt[xCount] = "NRT";
   if(dpt[xCount].equals("ROM")) dpt[xCount] = "FCO";
   if(dpt[xCount].equals("NYC")) dpt[xCount] = "JFK";
   if(dpt[xCount].equals("JKT")) dpt[xCount] = "CGK";
   arv[xCount] = dr2.getString("arv");
   blkout[xCount] = dr2.getString("blkout");
   off[xCount] = dr2.getString("takeoff");
   land[xCount] = dr2.getString("landing");
   blkin[xCount] = dr2.getString("blkin");
   flyhr[xCount] = dr2.getString("flyhr");
   blk[xCount] = dr2.getInt("blkhr");
   duty[xCount] = dr2.getString("duty")+dr2.getString("jobid");
   da[xCount] = dr2.getString("da");
   xCount++;
  }
}

%>
<body>
<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr >
    <td width="32%" class="txtblue">EMPNO：<span class="txtgray2"><%=mid%></span></td>
    <td width="42%" class="txtblue">Name：<span class="txtgray2"><%=cname%>&nbsp;<%=ename%></span></td>
    <td width="26%" class="txtblue">Date：<span class="txtgray2"><%=y+"/"+m%></span></td>
  </tr>
</table>
<div align="center"><br>
  <%
if(xCount ==0){
%>
  
  <span class="txttitletop"><br>No Crew Hours</span><br>
<br>
<br>

  <%
}
else{
da13UtcTime ut = new da13UtcTime();
blkhr = ut.getDa13Atdu(dat, flt, dpt);

%>
</div>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1">
  <tr class="tablehead3">
    <td width="10%" class="tablehead3">DATE</td>
    <td width="10%" class="tablehead3">FLT</td>
    <td width="11%" class="tablehead3">DPT</td>
    <td width="12%" class="tablehead3">ARV</td>
    <td width="8%" class="tablehead3">BLKOUT</td>
    <td width="10%" class="tablehead3">OFF</td>
    <td width="6%" class="tablehead3">LAND</td>
    <td width="6%" class="tablehead3">BLKIN</td>
    <td width="6%" class="tablehead3">FLYHR</td>
    <td width="7%" class="tablehead3">BLKHR</td>
	<td width="7%" class="tablehead3">JCBLKHR</td>
    <td width="7%" class="tablehead3">TRAVHR</td>
    <td width="7%" class="tablehead3">DUTY</td>
    <td width="14%" class="tablehead3">DA</td>
  </tr>
<%
for(int i = 0; i<xCount; i++)
{
	//out.println(i + " DA13 blkhr : " +blkhr[i]);
	//out.println(i + " crewrec blk : " +blk[i]);
	//if (blkhr[i]==0) {blkhr[i] = blk[i];} //*****modify by cs55 2004/05/06
%>
  <tr>
    <td class="tablebody"><%=dat[i]%></td>
    <td class="tablebody">CI<%=flt[i]%></td>
    <td class="tablebody"><%=dpt[i]%></td>
    <td class="tablebody"><%=arv[i]%></td>
    <td class="tablebody"><%=blkout[i]%></td>
    <td class="tablebody"><%=off[i]%></td>
    <td class="tablebody"><%=land[i]%></td>
    <td class="tablebody"><%=blkin[i]%></td>
    <td class="tablebody"><%=flyhr[i]%></td>
    <td class="tablebody"><%=Math.floor(((blk[i]/60)+0.0005)*1000)/1000%></td>
	<td class="tablebody"><%=Math.floor(((blkhr[i]/60)+0.0005)*1000)/1000%></td>
    <td class="tablebody">&nbsp;</td>
    <td class="tablebody"><%=duty[i]%></td>
    <td class="tablebody"><%=da[i]%></td>
  </tr>
<%
}
%>
</table>
<br>

<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td width="14%" class="tablebody">Summary</td>
<%
for(int i=0; i<blkhr.length; i++)
{
	if (dat[i] == null) 
	{
		i = 99;
	}
	else
	{
		total_jcblk = total_jcblk + blkhr[i];
		total_blk = total_blk + blk[i];
	}
}
%>
    <td width="30%" class="tablebody">BLKHR=&nbsp;<%=Math.floor(((total_blk/60)+0.0005)*1000)/1000%></td>
    <td width="30%" class="tablebody">JCBLKHR=&nbsp;<%=Math.floor(((total_jcblk/60)+0.0005)*1000)/1000%></td>
    <td width="31%" class="tablebody">TRAVHR=</td>
    <td width="25%" class="tablebody">USD=</td>
  </tr>
</table><br>
<br>
<%
}

}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(dr1 != null) dr1.close();}catch(SQLException e){}
	try{if(dr2 != null) dr2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

//抓班表資訊網

//
//Get Today************************
//Connection conn = null;
Driver dbDriver = null;
Statement stmt2 = null;
ResultSet myResultSet = null;
try
{


GregorianCalendar currentDate = new GregorianCalendar();
java.util.Date curDate = (java.util.Date)currentDate.getTime();

SimpleDateFormat dateFmD = new SimpleDateFormat("MM");
SimpleDateFormat dateFmY = new SimpleDateFormat("yyyy");

String nowdayYY = dateFmY.format(curDate);
String nowdayMM = dateFmD.format(curDate);


if(nowdayYY.equals(y) && nowdayMM.equals(m) )	{   //若是本月的，才show下面的

//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//****************************************
dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt2 = conn.createStatement();

String btime=null;
String etime=null;
String mysql= "select * "+
"from "+ct.getTable()+" where trim(empno)='"+mid+"' "+
" and (fdate > to_char(sysdate,'yyyy/mm/dd') and to_date(fdate,'yyyy/mm/dd') <= last_day(sysdate))"+
//" and substr(fdate,1,7)=to_char(sysdate+1,'yyyy/mm')"+
" and length(dutycode)>= 3 "+
" and dutycode <> 'REST' and dh <> 'Y'"+
" order by fdate, dutycode, tripno";
myResultSet = stmt2.executeQuery(mysql);
//out.print(mysql);

String fdate1=null;
String dutycode1=null;
String tripno1=null;
String dpt1=null;
String arv1=null;
String btime1=null;
String etime1=null;
String qual1 = null;
String actp1=null;
String spcode1=null;
int blk_hh = 0;
int blk_mm = 0;

%>
<hr align="center" width="90%" size="1" noshade color="#464883">
<br>
<br>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="8" class="tablebody">本月Schedule</td>
  </tr>
  <tr>
    <td width="10%" class="tablehead3">Date</td>
    <td width="8%" class="tablehead3">FLT</td>
     <td width="12%" class="tablehead3">TripNo</td>
   <td width="9%" class="tablehead3">DPT</td>
    <td width="11%" class="tablehead3">ARV</td>
    <td width="15%" class="tablehead3">BLKOUT</td>
    <td width="17%" class="tablehead3">BLKIN</td>
    <td width="18%" class="tablehead3">BLKHR</td>
  </tr>
  <%
int xCount2 =0;
String bcolor = null;
float total_blkhr2 = 0;
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 

			fdate1 = myResultSet.getString("fdate");
			dutycode1 = myResultSet.getString("dutycode");
			tripno1 = myResultSet.getString("tripno");
			dpt1 = myResultSet.getString("dpt");
			arv1 = myResultSet.getString("arv");
			btime1 = myResultSet.getString("btime");
			etime1 = myResultSet.getString("etime");
			qual1 = myResultSet.getString("qual");
			actp1 = myResultSet.getString("actp");
			spcode1 = myResultSet.getString("spcode");
			float blkhr2;// = new float[fdate1.length()];

			xCount2++;
			if (xCount2%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}

	int  btime1_hh 	= Integer.parseInt(btime1.substring(0,2));
	int  btime1_mm 	= Integer.parseInt(btime1.substring(2,4));
	int  etime1_hh  = Integer.parseInt(etime1.substring(0,2));
	int  etime1_mm	= Integer.parseInt(etime1.substring(2,4));
	 if((etime1_hh - btime1_hh) < 0)
        {
			blk_hh = 24 - btime1_hh + etime1_hh;
       	}
       	else
       	{
       		blk_hh = etime1_hh - btime1_hh;
       	}
       	if((etime1_mm - btime1_mm) < 0)
       	{
       		blk_mm = etime1_mm + 60 - btime1_mm;
       		blk_hh = blk_hh - 1;
       	}
       	else
      	{
      		blk_mm = etime1_mm - btime1_mm;
      	}	//~~~end	



		blkhr2 = (blk_hh * 60) + blk_mm;
		total_blkhr2 = total_blkhr2+blkhr2;
			
%>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=fdate1%></td>
    <td class="tablebody"><%=dutycode1%></td>
    <td class="tablebody"><%=tripno1%></td>
    <td class="tablebody"><%=dpt1%></td>
    <td class="tablebody"><%=arv1%></td>
    <td class="tablebody"><%=btime1%></td>
	 <td class="tablebody"><%=etime1%></td>
    <td class="tablebody"><%=Math.floor(((blkhr2/60)+0.0005)*1000)/1000%> </td>
  </tr>
  <%
	
	}	//end of while
}	//end of if
%>
  <tr>
    <td colspan="8" class="tablebody"><div align="center">Total BLKHR=<%=Math.floor(((total_blkhr2/60)+0.0005)*1000)/1000%></div></td>
  </tr>
</table>
<%
}//end of IF(show本月）
%>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><span class="txttitle">Remark:<br>
      1. BlockOut/Takeoff/Landing/BlockIn format HHMM<br>
      2. BLKHR If no time in out/off/on/in then (blkhr=schedule) else (blkhr=In - Out)<br>
    3. JCBLKHR blockhr from JC/AirOps system</span><br></td>
  </tr>
</table>
</body>
</html>
<%

}
catch (Exception e)
{
	out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>