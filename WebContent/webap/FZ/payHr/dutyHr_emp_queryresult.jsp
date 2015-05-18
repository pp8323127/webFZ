<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,javax.sql.DataSource,javax.naming.InitialContext, java.util.*, java.io.*, java.text.*, ci.db.*, org.apache.poi.hssf.usermodel.*, fz.*" %>
<html><head><title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%!
String year1, mon1, levelhr, empno, cname, base, rank, gtlt, empCond, baseCond, rankCond, baseDisp, rankDisp;
ArrayList ArrEmpno  = null;
ArrayList ArrBase   = null;
ArrayList ArrRank   = null;
ArrayList ArrDutyHr = null;
int i, cnt;
String bcolor = null;

DataSource ds           = null;
Driver dbDriver         = null;
Connection conn         = null;
Statement stmt          = null;
ResultSet myResultSet   = null;
ConnDB cn               = new ConnDB();
String sql              = null;

DataSource ds_a         = null;  
Driver dbDriver_a       = null;
Connection conn_a       = null;  
Statement stmt_a        = null;
ResultSet myResultSet_a = null;  
ConnDB cn_a             = new ConnDB();
String sql_a            = null;  
%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (userid == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} //if

year1   = request.getParameter("sel_year1");
mon1    = request.getParameter("sel_mon1");
levelhr = request.getParameter("txt_hr");
base    = request.getParameter("sel_base");
rank    = request.getParameter("sel_rank");

empno   = request.getParameter("txt_emp");
if (empno == null || "".equals(empno.trim())) {
   empCond  = "";
   baseCond = "and d.base='"+base+"' ";
   rankCond = "and b.rank_cd ='"+rank+"' ";
   baseDisp = "";
   rankDisp = "";
}else{
   empCond  = "and   a.staff_num='"+empno+"' ";
   baseCond = "";
   rankCond = "";
   baseDisp = base;
   rankDisp = rank;   
}//if

gtlt    = request.getParameter("sel_gtlt");
if (gtlt.equals("1")) gtlt = " > ";
if (gtlt.equals("2")) gtlt = " < ";

ArrEmpno  = new ArrayList();
ArrBase   = new ArrayList();
ArrRank   = new ArrayList();
ArrDutyHr = new ArrayList();

bcolor = "";
try{
	InitialContext initialcontext = new InitialContext();
	ds = (DataSource) initialcontext.lookup("CAL.FZDS03"); 
	conn = ds.getConnection();
	conn.setAutoCommit(false);	
    stmt = conn.createStatement();
	
	sql = "select a.staff_num, d.base, b.rank_cd, " +
	      "trunc(sum(c.cum_dp)/60) || ':' || LPAD(trunc(mod(sum(c.cum_dp),60)),2,'0') duty_hr "+
          "from crew_v a, crew_rank_v b, crew_base_v d, crew_cum_hr_cc_v c " +
          "where a.staff_num=b.staff_num " +
          "and   a.staff_num=c.staff_num " +
          "and   a.staff_num=d.staff_num " +
          "and c.cal_dt between to_date('"+year1+mon1+"01','yyyymmdd') " + 
		  "and         last_day(to_date('"+year1+mon1+" 2359','yyyymm HH24MI')) " +
		  empCond  +
          rankCond +
          baseCond +
		  "and d.base not in ('TSA','HND') " + 
          "and c.cal_dt between b.eff_dt and nvl(b.exp_dt,to_date('209901','yyyymm')) " +
          "and c.cal_dt between d.eff_dt and nvl(d.exp_dt,to_date('209901','yyyymm')) " +
          "group by a.staff_num, d.base, b.rank_cd " +
          "HAVING sum(c.cum_dp) "+gtlt+" 60 * "+levelhr+" " +
          "order by a.staff_num ";
	
	   //out.print(sql);
	   myResultSet = stmt.executeQuery(sql); 
	   if(myResultSet != null){
	       while (myResultSet.next()){
		       ArrEmpno.add(myResultSet.getString("staff_num"));
	           ArrBase.add(myResultSet.getString("base"));		   
			   ArrRank.add(myResultSet.getString("rank_cd"));
	           ArrDutyHr.add(myResultSet.getString("duty_hr"));			   
		   }//while
	    }//if		
}catch (SQLException e){
      out.println("SQL Exception Error : <BR>" + sql+ "\r\n" + e.toString());
}catch (Exception e){
      out.println("Exception Error :  <BR>" + sql+ "\r\n" + e.toString());
}finally{
  	try{
	     if(myResultSet != null) myResultSet.close();
	}catch(SQLException e){out.println("Erron in myResultSet.close() <BR> " + e.toString());}
	
	try{
	     if(stmt != null) stmt.close();   
	}catch(SQLException e){out.println("Erron in  stmt.close() <BR>  " + e.toString());}
		
	try{
	      if(conn != null){
		     conn.close(); 			  					 
	       }//if
	}catch(SQLException e){ out.println("Error in conn.close()" + e.toString());}
}//try

%>
<body>
<table width="100%"  border="0" align="center"><tr><td>
<div align="center" class="txttitletop"> 
        <%=year1%>/<%=mon1%> <%=base%> <%=rank%> Cabin Crew Duty Hour<BR>
          (Duty Hour <%=gtlt%> <%=levelhr%>小時者) <BR>
          <a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="Printing"></a> 
        </p>
      </div>
</td></tr> </table> 
<%
String path = application.getRealPath("/")+"/file/";
String filename = "empdutyhr.csv";
FileWriter fw = new FileWriter(path+filename,false);
fw.write("Empno,Cname,Base,Rank,DutyHr" + "\r\n");

if (ArrEmpno.size() == 0){
    out.println("No Data.");
}else{  %>      
    <table border="1" align="center" width="40%"> <!-- statistics table  --> <tr>
	<td class="tablehead" bgcolor="#CCCCCC">Empno</td>
	<td class="tablehead" bgcolor="#CCCCCC">Cname</td>
	<td class="tablehead" bgcolor="#CCCCCC">Base</td>
	<td class="tablehead" bgcolor="#CCCCCC">Rank</td>
	<td class="tablehead" bgcolor="#CCCCCC">Duty Hour<BR>(hh:mm)</td>
	<%
    cname = "";
	cnt = 0;
	for(i = 0; i < ArrEmpno.size(); i++){ 
		 if((i % 2) == 0)  bcolor = "";
		 else bcolor = "#FFFF99";	 		 
         %>	
	     <tr bgcolor="<%=bcolor%>" align="center"> 
		 <td class="FontSizeEngB"><%=ArrEmpno.get(i)%></td>
		 <%
		 try{
		 	InitialContext initialcontext_a = new InitialContext();
		 	ds_a = (DataSource) initialcontext_a.lookup("CAL.EGDS01"); 
		 	conn_a = ds_a.getConnection();
		 	conn_a.setAutoCommit(false);
		    stmt_a = conn_a.createStatement();
		    
			sql_a = "select cname from EGTCBAS where empn='"+ArrEmpno.get(i)+"'";
            
			myResultSet_a = stmt_a.executeQuery(sql_a); 
			if(myResultSet_a != null){
	           while (myResultSet_a.next()){
	               cname = myResultSet_a.getString("cname");
	           }//while
	        }//if
						
	     }catch (SQLException e){ out.println("SQL Exception Error : <BR>" + sql_a + "\r\n" + e.toString());
	     }catch (Exception e)   { out.println("Exception Error :     <BR>" + sql_a + "\r\n" + e.toString());
	     }finally{
 	      	try{ if(myResultSet_a != null) myResultSet_a.close();
	     	}catch(SQLException e){out.println("Erron in myResultSet_a.close() <BR>" + e.toString());}
	     	
			try{ if(stmt_a != null) stmt_a.close();   
	     	}catch(SQLException e){out.println("Erron in  stmt_a.close()       <BR>" + e.toString());}
		   
		   	try{ if(conn_a != null){ conn_a.close();  }//if
	        }catch(SQLException e){out.println("Error in conn_a.close()        <BR>" + e.toString());}
	     }//try

		 %>	 		 
		 <td class="FontSizeEngB"><%=cname%></td>
		 <td class="FontSizeEngB"><%=ArrBase.get(i)%></td>
		 <td class="FontSizeEngB"><%=ArrRank.get(i)%></td>		 		 
         <td class="FontSizeEngB"><%=ArrDutyHr.get(i)%></td>
	     </tr> <% 
		 fw.write(ArrEmpno.get(i) + ",");
		 fw.write(cname + ",");
		 fw.write(ArrBase.get(i) + ",");
	     fw.write(ArrRank.get(i) + ",");
	     fw.write(ArrDutyHr.get(i)  + "\r\n");
		 
		 cnt++;
	} //for %>	
	</table>   
	<table border="0" align="center" width="40%"><tr>
	<td class="FontSizeEngB" align="center">Count: <%=cnt%></td></tr>
	</table>
   <%
}//if 

fw.close();
//session close
//session.invalidate();
%>
<BR>
<table border="0" align="center" width="40%"><tr align="center"><td>
<a href="saveFile.jsp?filename=<%=filename%>">
<img src="../images/ed4.gif" border="0"><span class="txtblue"><%=filename%></span></a><br>
</td></tr></table>
<div align="center" class="txtblue">請點擊連結存檔<BR>
  Click link to save file</div>
</body>
</html>
