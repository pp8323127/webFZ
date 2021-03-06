<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,java.io.*,ci.db.*,tool.ReplaceAll,java.text.*,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String flsd  =   request.getParameter("flsd");
String fled  =   request.getParameter("fled");

String syy  =   flsd.substring(0,4);
String smm  =   flsd.substring(5,7);
String sdd  =   flsd.substring(8,10);

String eyy  =   fled.substring(0,4);
String emm  =   fled.substring(5,7);
String edd  =   fled.substring(8,10);

String[] ciItemNoAL = request.getParameterValues("ciItemNo");
String sltCiItemNo = null;

for(int i=0;i<ciItemNoAL.length;i++)	//選多項目時
{
	//out.print("ciItemNoAL="+ciItemNoAL[i]+"<br>");
	if (i==0)
	{
		sltCiItemNo = ciItemNoAL[i];	//只有一個時
	}
	else
	{
		sltCiItemNo = sltCiItemNo+"','"+ciItemNoAL[i];//兩個項目以上，用','格開
	}
}
//out.print(sltCiItemNo+"<br>");

java.util.Date date = new java.util.Date();
DateFormat datef = DateFormat.getDateTimeInstance();

String count = null;
int S = 0;

String sql  = "";
String sql2 = "";
String sql3 = "";
String sql4 = "";
String sql5 = "";
String sql6 = "";
String sql7 = "";
String sql8 = "";

Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;

ResultSet rs = null;
ResultSet rs2 = null;

ConnDB cn = new ConnDB();

String path = application.getRealPath("/")+"/SFLY/file/";
Driver dbDriver = null;

// delete old ftb csv file
File f  = new File(path);
File[] objFiles = f.listFiles(); 
 
for(int i=0; i< objFiles.length; i++){
	if (objFiles[i].isDirectory()){}	
	else{
		//out.print(objFiles[i].toString()+"<br>");
		
		String delFile = objFiles[i].toString();
		File f2 = new File(delFile);
		f2.delete();
	}
}

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	
					
//check is any data in the selecting period of time	
//	查所有的
sql="SELECT Max(DISTINCT(ci.itemno)) as S " 
   +"FROM egtstti ti, egtstcc cc, egtstci ci "
   +"WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "
        +" and cc.sernno=ti.sernno and cc.itemno=ci.itemno ";		
//out.print("sql="+sql+"<BR>");
rs= stmt.executeQuery(sql);

while(rs.next())
{
	S = Integer.parseInt(rs.getString("S")) +1;  //first item Arraylist size
	//out.print("S= "+S+"<BR>");
	int[] issueNo     = new int[S];
	String[] issue = new String[S];
	int[] sumA        = new int[S];
	int[] sumB        = new int[S];
	int[] sumC        = new int[S];	
	int[] rmNo_SC     = new int[S];
	int[] rmNo_SK     = new int[S];
	int[] rmNo_SP     = new int[S];	
	String[] purnameForErr = new String[S];		
	String[] crewForErr = new String[S];		
	String[] remarkForErr = new String[S];			

	for (int a=0; a<S; a++)
	{
		purnameForErr[a]="";
		crewForErr[a]="";
		remarkForErr[a]="";
	}	

if (S>1)
{
	FileWriter fw = new FileWriter(path+"SIL_"+flsd.replaceAll("/", "-")+"to"+fled.replaceAll("/", "-")+"_"+userid+".csv",false);
	fw.write("Self Inspection List Report                             Run"+datef.format(date)+"\r\n");
	fw.write("Period:     From "+flsd+"  to  "+fled+" \r\n ");
	fw.write(" Issue No , Issue ,NO. Checked,Correctly Answer/ Perform,Incorrectly Answer /Perform ,Safet Concept, Safety Knowledge, Safety Performance , PurName for InCorrect , Crew Name for InCorrect , FeedBack for InCorrect "+"\r\n");
	
//產生所有人SIL EXCEL報表 
	sql2=" select ci.itemno as IssueNo, ci.subject as Issue ,"+
                 "sum(cc.tcrew) AS Checked, sum(cc.correct) AS Correct , sum(cc.incomplete) AS Incorrect"+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno and ci.itemno in ('"+sltCiItemNo+"') "+
         " GROUP BY ci.itemno, ci.subject ";		 
	//out.print("sql2="+sql2+"<BR>");
	rs2 = stmt2.executeQuery(sql2); 

	while(rs2.next())
	{
		String Issue = rs2.getString("Issue");
		Issue = ReplaceAll.replace(Issue,",","，");
		Issue = ReplaceAll.replace(Issue,"/","／");
		issueNo[Integer.parseInt(rs2.getString("IssueNo"))]=Integer.parseInt(rs2.getString("IssueNo"));
		issue[Integer.parseInt(rs2.getString("IssueNo"))]=Issue;	
		sumA[Integer.parseInt(rs2.getString("IssueNo"))]=Integer.parseInt(rs2.getString("Checked"));
		sumB[Integer.parseInt(rs2.getString("IssueNo"))]=Integer.parseInt(rs2.getString("Correct"));
		sumC[Integer.parseInt(rs2.getString("IssueNo"))]=Integer.parseInt(rs2.getString("Incorrect"));
		//out.print("issueNo["+Integer.parseInt(rs2.getString("IssueNo"))+"]="+Issue+"<br>");
		//out.print("sumA["+Integer.parseInt(rs2.getString("IssueNo"))+"]="+rs2.getString("Checked")+"<br>");
		//out.print("sumB["+Integer.parseInt(rs2.getString("IssueNo"))+"]="+rs2.getString("Correct")+"<br>");
		//out.print("sumC["+Integer.parseInt(rs2.getString("IssueNo"))+"]="+rs2.getString("Incorrect")+"<br>");
	}

// array of egtstcc\itemno_rm=001(safety concept)
	sql3=" select ci.itemno as IssueNo , ci.subject as Issue, count(cc.itemno_rm) as rm "+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno "+ 
				"AND ci.itemno in ('"+sltCiItemNo+"') and cc.itemno_rm ='001' "+
         " GROUP BY ci.itemno, ci.subject "+
		 " ORDER BY IssueNo ";		 
	//out.print("sql3="+sql3+"<BR>");
	
	rs2 = stmt2.executeQuery(sql3); 

	while(rs2.next())
	{
		issueNo[Integer.parseInt(rs2.getString("IssueNo"))]=Integer.parseInt(rs2.getString("IssueNo"));
		rmNo_SC[Integer.parseInt(rs2.getString("IssueNo"))]=Integer.parseInt(rs2.getString("rm"));
	}	

	
// array of egtstcc\itemno_rm=002(safety knowledge)
	sql4=" select ci.itemno as IssueNo , ci.subject as Issue, count(cc.itemno_rm) as rm "+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno "+ 
				"AND ci.itemno in ('"+sltCiItemNo+"') and cc.itemno_rm ='002' "+
         " GROUP BY ci.itemno, ci.subject "+
		 " ORDER BY IssueNo ";		 
	//out.print("sql4="+sql4+"<BR>");
	
	rs2 = stmt2.executeQuery(sql4); 

	while(rs2.next())
	{
		issueNo[rs2.getInt("IssueNo")]=Integer.parseInt(rs2.getString("IssueNo"));
		rmNo_SK[rs2.getInt("IssueNo")]=Integer.parseInt(rs2.getString("rm"));
	}	
	
// array of egtstcc\itemno_rm=003(safety Pderformance)
	sql5=" select ci.itemno as IssueNo , ci.subject as Issue, count(cc.itemno_rm) as rm "+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno "+ 
				"AND ci.itemno in ('"+sltCiItemNo+"') and cc.itemno_rm ='003' "+
         " GROUP BY ci.itemno, ci.subject "+
		 " ORDER BY IssueNo ";		 
	//out.print("sql5="+sql5+"<BR>");
	rs2 = stmt2.executeQuery(sql5); 

	while(rs2.next())
	{
		issueNo[rs2.getInt("IssueNo")]=Integer.parseInt(rs2.getString("IssueNo"));
		rmNo_SP[rs2.getInt("IssueNo")]=Integer.parseInt(rs2.getString("rm"));
	}	
		
//array of purname for answer Incorrect 
	sql6="SELECT ci.itemno as IssueNo , ci.subject as Issue, "+ 
                "ti.purname||'('||ti.fltd||')' AS purname "+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno "+ 
				"AND ci.itemno in ('"+sltCiItemNo+"') and cc.incomplete not in ('0') "+
		 " ORDER BY IssueNo ";

	//out.print("sql6="+sql6+"<BR>");
	rs2 = stmt2.executeQuery(sql6); 

	while(rs2.next())
	{
		if(purnameForErr[rs2.getInt("IssueNo")]=="")
			purnameForErr[rs2.getInt("IssueNo")] += rs2.getString("purname");
		else
			purnameForErr[rs2.getInt("IssueNo")] +=" / "+rs2.getString("purname");
	}

//array of crew name for answer Incorrect 
	sql7="SELECT ci.itemno as IssueNo , ci.subject as Issue, "+ 
                "cc.crew_comm||'('||ti.fltd||')' AS crewName "+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno "+ 
				"AND ci.itemno in ('"+sltCiItemNo+"') and cc.incomplete not in ('0') "+
		 " ORDER BY IssueNo ";

	//out.print("sql7="+sql7+"<BR>");
	rs2 = stmt2.executeQuery(sql7); 

	while(rs2.next())
	{
		String crewName = rs2.getString("crewName");
		crewName = ReplaceAll.replace(crewName,",","，");
		crewName = ReplaceAll.replace(crewName,"\r\n",";");
		if(crewForErr[rs2.getInt("IssueNo")]=="")
			crewForErr[rs2.getInt("IssueNo")] += crewName;
		else
			crewForErr[rs2.getInt("IssueNo")] +=" / "+crewName;
	}
	
//array of crew name for answer Incorrect 
	sql8="SELECT ci.itemno as IssueNo , ci.subject as Issue, "+ 
                "cc.acomm||'('||ti.fltd||')' AS remarkDsc "+
         " FROM egtstti ti, egtstcc cc, egtstci ci "+
         " WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
                "AND cc.sernno=ti.sernno and cc.itemno=ci.itemno "+ 
				"AND ci.itemno in ('"+sltCiItemNo+"') and cc.incomplete not in ('0') "+
		 " ORDER BY IssueNo ";

	//out.print("sql8="+sql8+"<BR>");
	rs2 = stmt2.executeQuery(sql8); 

	while(rs2.next())
	{
		String remarkDsc = rs2.getString("remarkDsc");
		remarkDsc = ReplaceAll.replace(remarkDsc,",","，");	
		if(remarkForErr[rs2.getInt("IssueNo")]=="")
			remarkForErr[rs2.getInt("IssueNo")] += remarkDsc;
		else
			remarkForErr[rs2.getInt("IssueNo")] +=" / "+remarkDsc;
	}	

//寫入檔案
	for (int i=1; i<S; i++)
	{
		if(issueNo[i] == 0)
		{
		}
		else
		{
		fw.write(issueNo[i]+","+issue[i]+","+sumA[i]+","+sumB[i]+","+sumC[i]+","+rmNo_SC[i]+","+rmNo_SK[i]+","+rmNo_SP[i]+","+purnameForErr[i]+","+crewForErr[i]+","+remarkForErr[i]+"\r\n");
		//fw.write(issueNo[i]+","+issue[i]+","+sumA[i]+","+sumB[i]+","+sumC[i]+"\r\n");	
		//out.print(issueNo[i]+","+issue[i]+","+sumA[i]+","+sumB[i]+","+sumC[i]+","+rmNo_SC[i]+"<br>");
		}
	}	
	
fw.flush();	
fw.close();

}//end of if S>1
} //end of while loop rs
}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs  != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(stmt  != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Generate Cabin Safety Check List Flag Count Excel report</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
.style2 {color: #464883; font-family: "Verdana"; line-height: 13.5pt;}
-->
</style>
</head>

<body link="#CC0099">
<br>
<br><br><br><br>
<% if (S>1)
{
%>
<script language=javascript>
	alert("檔案產生完成!!\nSafety Inspction List Report Generated !!");
</script>
<div align="center">
 <p class="txttitletop">Self Inspection List Report Excel Report<br>
 檔案下載 / Download File</p>
  <a href="download.jsp?filename=SIL_<%=flsd.replaceAll("/", "-")%>to<%=fled.replaceAll("/", "-")%>_<%=userid%>.csv"><font size="4"><img src="../images/ed4.gif" border="0"><span class="txtblue">請按滑鼠左鍵</span><span class="style2">/</span><span class="txtblue">儲存檔案(CSV) (Click left button to save the file)</span></font></a> <BR>
 <BR>
 <table width="50%"  border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="txtblue"><div align="center"><span class="style1">*建議將檔案下載至Local PC再開啟, 因檔案較大直接開啟較費時</span><br>
       請按<span class="style1">滑鼠左鍵/儲存檔案</span>將檔案下載至您的電腦儲存.</div></td>
   </tr>
 </table>
</div>
<%
}
else
{
%>
<div align="center">
  <br>
	<span class="txtblue">尚無<%=syy%>年/<%=smm%>月/<%=sdd%>日至<%=eyy%>年/<%=emm%>月/<%=edd%>日之資料<br>
	Self Inspection List Report info for <%=syy%>/<%=smm%>/<%=sdd%>&nbsp;to&nbsp;<%=eyy%>/<%=emm%>/<%=edd%> doesn't exist.
	</span>
  <br>
</div>
<%
}
%>
</body>
</html>
