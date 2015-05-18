<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,ci.db.*,java.io.*,ftp.*,javax.sql.DataSource,javax.naming.InitialContext"%>
<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
//String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

/*
if ( sGetUsr == null) 
{	//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
*/

String filename = (String) session.getAttribute("filename");
String path = application.getRealPath("/")+"/FZ/crewshuttle/userfile/";
String yyyy = request.getParameter("sel_year");
String mm	= request.getParameter("sel_mon");
String dd	= request.getParameter("sel_dd");
String sql  = "";
String getSect = "";

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
Statement stmt2 = null;
ResultSet rs = null;
//ConnDB cn = new ConnDB();
DataSource ds = null;
ArrayList fltnoAL = new ArrayList();
ArrayList chkinAL = new ArrayList();
ArrayList ystdayAL = new ArrayList();
//default adding ""
fltnoAL.add("");
chkinAL.add("");
ystdayAL.add("");
int resultCount = 0;
//out.println("~~~1");
//####  folder change
try //must try and catch,otherwide will compile error
{
   //out.println("~~~2");
	java.io.File file_in=new java.io.File(path+filename);
	BufferedReader br = new BufferedReader(new FileReader(file_in));
	StringBuffer sb = null;
	String str = null;
	//out.println("~~~3");
	//out.println(path+filename+"<br>");
	
	//if (br.readLine() == null) out.println("~~~~NULL");
	//else out.println("~~~~NOT NULL");
	
	while ((str = br.readLine()) != null) {
	    //out.println("~~~~~~~"+str);
		splitString s = new splitString();		
		String[] token = s.doSplit(str,",");
		
		for (int i = 0; i < 12; i++){
		    //out.println("token["+i+"]="+ token[i].trim().toString());			
			if (i==1){ fltnoAL.add(token[i].trim()); }
            
			if (i==4){ chkinAL.add(token[i].trim()); }
            			
			if (i==7){
				if (token[i].trim().length()==6){
					ystdayAL.add("20"+token[i].trim());
				}else{
					ystdayAL.add(yyyy+mm+dd);
				}//if
			}//if		
			//out.println(fltnoAL+"<br>"+chkinAL+"<br>"+ystdayAL+"<br>");
		}//for
	}//while

/*
for (int j = 0; j < ystdayAL.size(); j++)
{
	out.print(j+"<BR>");
	out.print(fltnoAL.get(j)+"<BR>");
	out.print(chkinAL.get(j)+"<BR>");
	out.print(ystdayAL.get(j)+"<BR>");
}
*/
	//Delete today's record 

	try
	{
		//cn.setORP3FZUserCP();
		//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		//conn = dbDriver.connect(cn.getConnURL(), null);
       
		//DataSource 
        InitialContext initialcontext = new InitialContext();
        ds = (DataSource) initialcontext.lookup("CAL.FZDS02"); 
        conn = ds.getConnection();
		conn.setAutoCommit(true);
		
		stmt = conn.createStatement();
		stmt2 = conn.createStatement();

		sql = "Delete fztflin where fltd = to_date('"+yyyy+mm+dd+"','yyyymmdd') and chguser = 'SYS'";
		stmt.executeUpdate(sql);
		//stmt.executeUpdate("commit");

		for (int j=1; j < fltnoAL.size(); j++ )	{
			if(!(fltnoAL.get(j).equals(fltnoAL.get(j-1))))
			{   //new fltno
				//get sector
				getFlyInfo t = new getFlyInfo();
				getSect = t.getSector(fltnoAL.get(j).toString(),yyyy+"/"+mm+"/"+dd);

				chkNum s = new chkNum();
				if (s.isNum(fltnoAL.get(j).toString()) == true)	{
				//insert into fztflin 
					sql = "insert into fztflin values (To_Date('"+yyyy+"/"+mm+"/"+dd+"','yyyy/mm/dd'), LPAD('"+fltnoAL.get(j)+"',4,'0'), '"+getSect+"', To_Date(substr('"+ystdayAL.get(j)+"',1,4)"+"||'/'||substr('"+ystdayAL.get(j)+"',5,2)||'/'||substr('"+ystdayAL.get(j)+"',7,2)||' '||substr('"+chkinAL.get(j)+"',1,2)||':'||substr('"+chkinAL.get(j)+"',3,2)||':00','yyyy/mm/dd HH24:MI:SS'), null,null,null,null,'SYS', sysdate)";
				}else{
					sql = "insert into fztflin values (To_Date('"+yyyy+"/"+mm+"/"+dd+"','yyyy/mm/dd'), '"+fltnoAL.get(j)+"', '"+getSect+"', To_Date(substr('"+ystdayAL.get(j)+"',1,4)"+"||'/'||substr('"+ystdayAL.get(j)+"',5,2)||'/'||substr('"+ystdayAL.get(j)+"',7,2)||' '||substr('"+chkinAL.get(j)+"',1,2)||':'||substr('"+chkinAL.get(j)+"',3,2)||':00','yyyy/mm/dd HH24:MI:SS'), null,null,null,null,'SYS', sysdate)";
				}//if

				//out.print(sql+"<BR>");
				try{
					resultCount = stmt2.executeUpdate(sql);		
				}catch (Exception e)
				{//already exist
					sql = "update fztflin set tsa_dt =  To_Date(substr('"+ystdayAL.get(j)+"',1,4)"+"||'/'||substr('"+ystdayAL.get(j)+"',5,2)||'/'||substr('"+ystdayAL.get(j)+"',7,2)||' '||substr('"+chkinAL.get(j)+"',1,2)||':'||substr('"+chkinAL.get(j)+"',3,2)||':00','yyyy/mm/dd HH24:MI:SS') where fltd =  To_Date('"+yyyy+"/"+mm+"/"+dd+"','yyyy/mm/dd') and fltno = substr('"+fltnoAL.get(j)+"',1,4) and sect = '"+getSect+"'";
					try{
						resultCount = stmt2.executeUpdate(sql);
					}catch (Exception e2){
						out.print(e2.toString());
					}finally{}	
				}
				finally{}				
			}
		}// end of (int j=1; j < fltnoAL.size(); j++ )

		//delete duplication data
        /*
		sql = " SELECT fltd,fltno FROM ( SELECT to_char(fltd,'yyyy/mm/dd') fltd, fltno,Count(*) as c  FROM fztflin WHERE fltd = To_Date('"+yyyy+"/"+mm+"/"+dd+" 0000','yyyy/mm/dd hh24mi') GROUP BY fltd,fltno ) WHERE c >1 ";
		rs = stmt.executeQuery(sql);
		while (rs.next())		{
			sql = "delete from fztflin where fltd = To_Date('"+rs.getString("fltd")+" 0000','yyyy/mm/dd hh24mi') and fltno = '"+rs.getString("fltno")+"' and chguser = 'SYS'";		
			stmt2.executeUpdate(sql);		
		}
        */
	}catch (Exception e){
		  out.print("Error 2 : "+"<BR>"+e.toString());
	}finally{
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	}
}catch(Exception e){  
	out.print("Error 1 : "+e.toString());
}
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="crewcar.css">
<style type="text/css">
<!--
.style1 {color: #0000FF}
-->
</style>
</head>
<body>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="crewcar.css">
<style type="text/css">
<!--
.style1 {color: #0000FF}
-->
</style>
</head>
<body>
<div>
<%
if(resultCount !=0){
   %><p class="style1" align="center"><b>組員報到時間轉檔成功</b></p><%
}else{
   %><p class="style1" align="left"><b>組員報到時間轉檔失敗, 請檢查:</b></p>
     <p class="style1" align="left"><b>1. 檔案格式正確, 如: 641888,S6  ,1914, ,1945,   ,     ,      , , ,Y,石毓婷    
     <p class="style1" align="left"><b>2. 檔尾無多餘的Enter</b></p><%
}
%>
</div>
</body>
</html>