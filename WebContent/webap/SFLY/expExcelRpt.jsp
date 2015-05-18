<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,java.io.*,ci.db.*,tool.ReplaceAll,,java.net.URLEncoder,java.text.*,java.util.ArrayList" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}

String flsd = request.getParameter("flsd");
String fled = request.getParameter("fled");

String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");

String fiFlag  =   request.getParameter("flag");

String[] fiItemNoAL = request.getParameterValues("fiItemNo");
String sltFiItemNo = null;

for(int i=0;i<fiItemNoAL.length;i++)	//選多項目時
{
	//out.print("fiItemNoAL="+fiItemNoAL[i]+"<br>");
	if (i==0)
	{
		sltFiItemNo = fiItemNoAL[i];	//只有一個時
	}
	else
	{
		sltFiItemNo = sltFiItemNo+"','"+fiItemNoAL[i];//兩個項目以上，用','格開
	}
}


java.util.Date date = new java.util.Date();
DateFormat datef = DateFormat.getDateTimeInstance();

int f = 0; // first item 總數
int s = 0; // sub item 對應 first item 總數

String sql = "";
String sql2 = "";
String sql3 = "";
String sql4 = "";
String sql5 = "";
String sql6 = "";
String sql7 = "";
String sql8 = "";
String sql9 = "";
String sqlA = "";

Statement stmt = null;
Statement stmt2 = null;
Statement stmt3 = null;
Statement stmt4 = null;
Statement stmt5 = null;
Statement stmt6 = null;
Statement stmt7 = null;
Statement stmt8 = null;
Statement stmt9 = null;
Statement stmtA = null;

ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;
ResultSet rs5 = null;
ResultSet rs6 = null;
ResultSet rs7 = null;
ResultSet rs8 = null;
ResultSet rs9 = null;
ResultSet rsA = null;

Connection conn = null;
ConnDB cn = new ConnDB();
     
String path = application.getRealPath("/")+"/SFLY/file/";
Driver dbDriver = null;

// delete old ftb csv file
File f0 = new File(path);
File[] objFiles = f0.listFiles(); 
 
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
stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt8 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt9 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmtA = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

//check is any data in the selecting period of time					
sql="select count(distinct fi.itemdsc) as f , nvl(Max((Mod(To_Number(si.itemno)*10, 10))),0) as s "+
    "FROM egtstti ti, egtstfi fi, egtstsi si, egtstdt dt "+
    "WHERE ti.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') "+
          " and dt.sernno=ti.sernno and dt.itemno=si.itemno "+ 
		  " and si.kin=fi.itemno  ";
//out.print("sql="+sql+"<BR>");
rs = stmt.executeQuery(sql);

while(rs.next())
{
	f = Integer.parseInt(rs.getString("f")) +1;  //first item Arraylist size
	s = Integer.parseInt(rs.getString("s")) +1; //second item Arraylist size  
	//out.print("f="+f+",s="+s+"<br>");
	int[][] countY  = new int[f][s];
	int[][] countN  = new int[f][s];
	int[][] countNA = new int[f][s];
	int[][] rmNo_SC = new int[f][s];
	int[][] rmNo_SK = new int[f][s];
	int[][] rmNo_SP = new int[f][s];	
	String[][]     item = new String[f][s];
	String[][] sub_item = new String[f][s];	
	String[][] purnameForN = new String[f][s];	
	String[][] remarkForN = new String[f][s];		
	
	for (int a=0; a<f; a++)
	{
		for (int b=0; b<s; b++)
		{
			purnameForN[a][b]="";
			remarkForN[a][b]="";
		}
	}	

if (f>1)
{

	//out.print("f="+f+",s="+s+"<br>");
	FileWriter fw = new FileWriter(path+"CheckList_"+flsd.replaceAll("/", "-")+" to "+fled.replaceAll("/", "-")+"_"+userid+".csv",false);
	fw.write("CABIN SAFETY CHECK LIST                                                                            Run"+datef.format(date)+"\r\n");
	fw.write("Period: From "+flsd+"  to  "+fled+" \r\n ");
	fw.write(" ITEM ,  SUB_ITEM            ,Yes,NDIP,N/A,Safety Concept,Safety Knowledge,Safety Performance,CM_Name for N, Remark for N"+"\r\n");

	//array of item	and sub_item and flag=0(N/A)
	sql2="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.flag AS flag "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"')  "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql2="+sql2+"<BR>");
	rs2 = stmt2.executeQuery(sql2); 
	
	while(rs2.next())
	{
		String Item = rs2.getString("item");
		String Sub_Item =rs2.getString("sub_item");
		Item = ReplaceAll.replace(Item,",","，");
		Sub_Item = ReplaceAll.replace(Sub_Item,",","，");
		item[Integer.parseInt(rs2.getString("itemno"))][1]=Item;
	sub_item[Integer.parseInt(rs2.getString("itemno"))][Integer.parseInt(rs2.getString("sub_itemno"))]=Sub_Item;
	}
	

	//array of flag=1 (YES)
	sql3="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item, "+
				"Count(flag) as countY "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.flag AS flag "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"') AND d.flag='1' "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql3="+sql3+"<BR>");
	rs3 = stmt3.executeQuery(sql3); 
	
	while(rs3.next())
	{
	countY[Integer.parseInt(rs3.getString("itemno"))][Integer.parseInt(rs3.getString("sub_itemno"))]=Integer.parseInt(rs3.getString("countY"));
	}

	//array of flag=2 (No)
	sql4="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item, "+
				"Count(flag) as countN "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.flag AS flag "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"') AND d.flag='2' "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql4="+sql4+"<BR>");
	rs4 = stmt4.executeQuery(sql4); 
	
	while(rs4.next())
	{
	countN[Integer.parseInt(rs4.getString("itemno"))][Integer.parseInt(rs4.getString("sub_itemno"))]=Integer.parseInt(rs4.getString("countN"));
	}	
	
	//array of flag=0 (N/A)
	sql5="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item, "+
				"Count(flag) as countNA "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.flag AS flag "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"') AND d.flag='0' "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql5="+sql5+"<BR>");
	rs5 = stmt5.executeQuery(sql5); 
	
	while(rs5.next())
	{
	countNA[Integer.parseInt(rs5.getString("itemno"))][Integer.parseInt(rs5.getString("sub_itemno"))]=Integer.parseInt(rs5.getString("countNA"));
	}	

	//array of egtstdt/itemno_rm=1 (Safety Concept)
	sql6="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item, "+
				"Count(rmNo) as rmNo_SC "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.itemno_rm AS rmNo "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"') AND d.itemno_rm='001' "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql6="+sql6+"<BR>");
	rs6 = stmt6.executeQuery(sql6); 
	
	while(rs6.next())
	{
	rmNo_SC[Integer.parseInt(rs6.getString("itemno"))][Integer.parseInt(rs6.getString("sub_itemno"))]=Integer.parseInt(rs6.getString("rmNo_SC"));
	}	
	
	//array of egtstdt/itemno_rm=2 (Safety Knowledge)
	sql7="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item, "+
				"Count(rmNo) as rmNo_SK "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.itemno_rm AS rmNo "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"') AND d.itemno_rm='002' "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql7="+sql7+"<BR>");
	rs7 = stmt7.executeQuery(sql7); 
	
	while(rs7.next())
	{
	rmNo_SK[Integer.parseInt(rs7.getString("itemno"))][Integer.parseInt(rs7.getString("sub_itemno"))]=Integer.parseInt(rs7.getString("rmNo_SK"));
	}		
	
	//array of egtstdt/itemno_rm=3 (Safety Performance)
	sql8="SELECT substr(sub_itemno,1,instr(sub_itemno,'.')-1) as itemno, "+
       		    "itemno||'.'||itemdsc AS item, "+
       			"To_Char(Mod(To_Number(sub_itemno)*10, 10)) AS sub_itemno, "+
                "sub_itemno||' '||sub_itemdsc AS sub_item, "+
				"Count(rmNo) as rmNo_SP "+
         "from(SELECT f.itemno AS itemno, f.itemdsc, s.itemno AS sub_itemno, s.itemdsc AS sub_itemdsc, d.itemno_rm AS rmNo "+
               "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
               "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno and f.itemno in ('"+sltFiItemNo+"') AND d.itemno_rm='003' "+
                  "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') ) "+
         "GROUP BY itemno, itemdsc, sub_itemno , sub_itemdsc "+ 
         "ORDER BY item, itemno, sub_itemno ";

	//out.print("sql8="+sql8+"<BR>");
	rs8 = stmt8.executeQuery(sql8); 
	
	while(rs8.next())
	{
	rmNo_SP[Integer.parseInt(rs8.getString("itemno"))][Integer.parseInt(rs8.getString("sub_itemno"))]=Integer.parseInt(rs8.getString("rmNo_SP"));
	}		
	
//array of purname for select flag=fiFlag 
	sql9="SELECT substr(s.itemno,1,instr(s.itemno,'.')-1) as itemno, "+
                "f.itemno||'.'||f.itemdsc AS item, "+ 
				"To_Char(Mod(To_Number(s.itemno)*10, 10)) AS sub_itemno, "+
                "s.itemno||' '||s.itemdsc AS sub_item, "+
                "t.purname||'('||t.fltd||')' AS purname "+
          "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
		  "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno "+
              "and f.itemno in ('"+sltFiItemNo+"')  AND d.flag='"+fiFlag+"' "+
              "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd')  "+
          "ORDER BY itemno, sub_itemno ";

	//out.print("sql9="+sql9+"<BR>");
	rs9 = stmt9.executeQuery(sql9); 

	while(rs9.next())
	{
		if(purnameForN[Integer.parseInt(rs9.getString("itemno"))][Integer.parseInt(rs9.getString("sub_itemno"))]=="")
			purnameForN[Integer.parseInt(rs9.getString("itemno"))][Integer.parseInt(rs9.getString("sub_itemno"))] += rs9.getString("purname");
		else
		purnameForN[Integer.parseInt(rs9.getString("itemno"))][Integer.parseInt(rs9.getString("sub_itemno"))] +=" / "+rs9.getString("purname");
	}
	
//array of Remark Column for select flag=fiFlag
	sqlA="SELECT substr(s.itemno,1,instr(s.itemno,'.')-1) as itemno, "+
                "f.itemno||'.'||f.itemdsc AS item, "+ 
				"To_Char(Mod(To_Number(s.itemno)*10, 10)) AS sub_itemno, "+
                "s.itemno||' '||s.itemdsc AS sub_item, "+
                "d.remark||'('||t.fltd||')' AS remarkDsc "+
          "FROM egtstti t, egtstfi f, egtstsi s, egtstdt d  "+
		  "WHERE s.kin=f.itemno AND d.itemno=s.itemno AND d.sernno=t.sernno "+
              "and f.itemno in ('"+sltFiItemNo+"')  AND d.flag='"+fiFlag+"' "+
              "AND t.fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd')  "+
          "ORDER BY itemno, sub_itemno ";

	//out.print("sqlA="+sqlA+"<BR>");
	rsA = stmtA.executeQuery(sqlA); 

	while(rsA.next())
	{
		if(remarkForN[Integer.parseInt(rsA.getString("itemno"))][Integer.parseInt(rsA.getString("sub_itemno"))]=="")
			remarkForN[Integer.parseInt(rsA.getString("itemno"))][Integer.parseInt(rsA.getString("sub_itemno"))] += rsA.getString("remarkDsc");
		else
			remarkForN[Integer.parseInt(rsA.getString("itemno"))][Integer.parseInt(rsA.getString("sub_itemno"))] +=" / "+rsA.getString("remarkDsc");
	}	
	

//寫入資料

	for (int i=1; i<f; i++)
	{
		if(item[i][1] == null)
		{
		}
		else
		{
			int x=1;  //如果f item相同，則不重印出
			for (int j=1; j<s; j++)
			{
				if(sub_item[i][j] == null)
				{
				}
				else
				{
					if (x==1)  //如果f item相同，則不重印出
					{	
						fw.write(item[i][1]+","+sub_item[i][j]+","+countY[i][j]+","+countN[i][j]+","+countNA[i][j]+","+rmNo_SC[i][j]+","+rmNo_SK[i][j]+","+rmNo_SP[i][j]+","+purnameForN[i][j]+","+remarkForN[i][j]+"\r\n");
						//out.print("remarkForN[i][j]="+remarkForN[i][j]+"<br>");
						x++;
					}
					else
					{
						fw.write(""+","+sub_item[i][j]+","+countY[i][j]+","+countN[i][j]+","+countNA[i][j]+","+rmNo_SC[i][j]+","+rmNo_SK[i][j]+","+rmNo_SP[i][j]+","+purnameForN[i][j]+","+remarkForN[i][j]+"\r\n");
						//out.print("remarkForN[i][j]="+remarkForN[i][j]+"<br>");
					}

				}
			}
		}
	}

	fw.flush();	
	fw.close(); 
}//end of if f>1
}// end of while(rs.next())
}// end of try
catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs  != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(rs3 != null) rs3.close();}catch(SQLException e){}
    try{if(rs4 != null) rs4.close();}catch(SQLException e){}
	try{if(rs5 != null) rs5.close();}catch(SQLException e){}
	try{if(rs6 != null) rs6.close();}catch(SQLException e){}	
	try{if(rs7 != null) rs7.close();}catch(SQLException e){}
	try{if(rs8 != null) rs8.close();}catch(SQLException e){}				
	try{if(rs9 != null) rs9.close();}catch(SQLException e){}				
	try{if(rsA != null) rsA.close();}catch(SQLException e){}			
	try{if(stmt  != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(stmt3 != null) stmt3.close();}catch(SQLException e){}	
	try{if(stmt4 != null) stmt4.close();}catch(SQLException e){}
	try{if(stmt5 != null) stmt5.close();}catch(SQLException e){}	
	try{if(stmt6 != null) stmt6.close();}catch(SQLException e){}	
	try{if(stmt7 != null) stmt7.close();}catch(SQLException e){}	
	try{if(stmt8 != null) stmt8.close();}catch(SQLException e){}				
	try{if(stmt9 != null) stmt9.close();}catch(SQLException e){}			
	try{if(stmtA != null) stmtA.close();}catch(SQLException e){}				
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Generate Cabin Safety Check List Flag Count Excel report</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body link="#CC0099">
<br>
<br><br><br><br>
<% 
if (f>1)
{
	%>
	<script language=javascript>
		alert("檔案產生完成!!\nCabin Safety Check List Report Generated !!");
	</script>
	<div align="center">
 	<p class="txttitletop">Cabin Safety Check List Excel Report<br>
 	檔案下載 / Download File</p>
  	<a href="download.jsp?filename=CheckList_<%=flsd.replaceAll("/", "-")%> to <%=fled.replaceAll("/", "-")%>_<%=userid%>.csv"><font size="4"><img src="images/ed4.gif" border="0"><span class="txtblue">請按滑鼠左鍵/儲存新檔(CSV) (Click left button to save the file)</span></font></a> <BR>
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
		Cabin safety check list info for <%=syy%>/<%=smm%>/<%=sdd%>&nbsp;to&nbsp;<%=eyy%>/<%=emm%>/<%=edd%> doesn't exist.
		</span>
  	<br>
	</div>
<%
}
%>
</body>
</html>




