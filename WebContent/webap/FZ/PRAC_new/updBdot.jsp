<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//更新登機準時資訊

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}
else if("2400".equals(request.getParameter("bdtm")))
{
%>
<div style="background-color:#66FFFF;color:#FF0000;text-align:center;padding:2pt;font-family:Verdana;font-size:10pt; "><br>
登機時間，請輸入24小時制HHMM（自0000 ~ 2359）<br>
<a href="javascript:history.back(-1);">Back</a>
</div>
<%
}
else
{
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
//****************************************
//Add by betty on 2008/10/01 
//in case when fltno == 三碼
if (fltno.length()==3)
{
   fltno = "0"+fltno;                
}
//****************************************
String acno		= request.getParameter("acno");
String sect 	= request.getParameter("sect");
String purserEmpno	= request.getParameter("purserEmpno");
String psrname= request.getParameter("psrname");
String psrsern= request.getParameter("psrsern");
String pgroups= request.getParameter("pgroups");
String bdot	= request.getParameter("bdot");
String bdreason = request.getParameter("bdreason");

String bdtime = request.getParameter("bdtmyyyy")
				+request.getParameter("bdtmmm")
				+request.getParameter("bdtmdd")
				+" "+request.getParameter("bdtm");		
				
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
int flag = 0;
String msg = "";
				
fz.pracP.BordingOnTime borot = null;
//檢查登機時間長度是否相符 yyyymmdd hh24mi


try{
//     User connection pool 
       cn.setORP3EGUserCP();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL() ,null);

// 直接連線 ORP3FZ cn.setORT1EG();
//            cn.setORP3EGUser();
/*
cn.setORT1EG();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
		cn.getConnPW());
*/
if("N".equals(bdot) && bdtime.length() != 13)
{	
	flag=1;
	msg="登機時間錯誤!!";
}
else
{
//登機準時資訊
	borot = new fz.pracP.BordingOnTime(fdate,fltno,sect,purserEmpno);
	try 
	{
		borot.SelectData();
	//	System.out.println("是否有flight資料：" + borot.isHasFlightInfo());
	//	System.out.println("是否有登機資料：" + borot.isHasBdotInfo());
	
	} 
	catch (SQLException e) 
	{
		System.out.print(e.toString());
	} 
	catch (Exception e) 
	{
		System.out.print(e.toString());
	}

if ( !borot.isHasFlightInfo())
{	//insert 

	if("Y".equals(bdot))
	{ 	
		sql = "insert into egtcflt (fltd,fltno,sect,acno,psrempn,psrsern,psrname,pgroups,chgdate,bdot,bdtime,bdreason) "
			+"values(to_date('"+fdate+" 0000','yyyy/mm/dd hh24mi'),?,?,?,?,"
			+"(select sern from egtcbas where trim(empn)=?),(SELECT cname FROM egtcbas WHERE trim(empn)=?),(SELECT groups FROM egtcbas WHERE trim(empn)=?),"
			+"sysdate,?,to_date('"+bdtime+"','yyyymmdd hh24mi'),null)";
	
	   pstmt = conn.prepareStatement(sql);
	
	   pstmt.setString(1,fltno);
	   pstmt.setString(2,sect);	
	   pstmt.setString(3,acno);
	   pstmt.setString(4,purserEmpno);  	   
	   pstmt.setString(5,purserEmpno);      
	   pstmt.setString(6,purserEmpno);      
	   pstmt.setString(7,purserEmpno);   
/*	       
	   pstmt.setString(5,psrsern);      
	   pstmt.setString(6,psrname);      
	   pstmt.setString(7,pgroups);      
*/	   
	   pstmt.setString(8,bdot);      
	
			
	}
	else
	{
		sql = "insert into egtcflt (fltd,fltno,sect,acno,psrempn,psrsern,psrname,pgroups,chgdate,bdot,bdtime,bdreason) "
			+"values(to_date('"+fdate+" 0000','yyyy/mm/dd hh24mi'),?,?,?,?,"
			+"(select sern from egtcbas where trim(empn)=?),(SELECT cname FROM egtcbas WHERE trim(empn)=?),(SELECT groups FROM egtcbas WHERE trim(empn)=?),"
			+"sysdate,?,to_date('"+bdtime+"','yyyymmdd hh24mi'),?)";
	
	   pstmt = conn.prepareStatement(sql);
	
	   pstmt.setString(1,fltno);
	   pstmt.setString(2,sect);	
	   pstmt.setString(3,acno);
	   pstmt.setString(4,purserEmpno);      
	   pstmt.setString(5,purserEmpno);      
	   pstmt.setString(6,purserEmpno);      
	   pstmt.setString(7,purserEmpno);   
	   
/*	   
	   pstmt.setString(5,psrsern);      
	   pstmt.setString(6,psrname);      
	   pstmt.setString(7,pgroups);      
*/
	   pstmt.setString(8,bdot);      
	   pstmt.setString(9,bdreason);      
	   
	}
		pstmt.executeUpdate();   
		
		//out.print("insert ok!!");   
	

}
else
{	//update
			
	if("Y".equals(bdot))
	{
		sql = "update egtcflt set bdot=?,bdtime=to_date('"+bdtime+"','yyyymmdd hh24mi'),bdreason=null,chgdate=sysdate "
		+"where fltd= To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi') AND fltno=? AND sect=? AND psrempn=?";
	    pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,bdot);
		pstmt.setString(2,fltno);
		pstmt.setString(3,sect);
		pstmt.setString(4,purserEmpno);
	}
	else
	{
		sql = "update egtcflt set bdot=?,bdtime=to_date('"+bdtime+"','yyyymmdd hh24mi'),bdreason=?,chgdate=sysdate "
		+"where fltd= To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi') AND fltno=? AND sect=? AND psrempn=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,bdot);
		pstmt.setString(2,bdreason);
		pstmt.setString(3,fltno);
		pstmt.setString(4,sect);
		pstmt.setString(5,purserEmpno);
	}
		pstmt.executeUpdate();   
	
//	out.print("update");  
}
}//end of pass 登機時間長度check

}
catch (SQLException e)
{
//	  out.print(e.toString());
	flag =-1;
	//msg ="登機時間格式錯誤，請輸入HHMM<br>或備註字數超過75個中文字.<br>";
	msg ="該班報告已存在，請連絡各組查詢<br>";
	
	System.out.print("EG purser report updBdot error:"+e.toString());
}
catch (Exception e)
{
	flag =-1;
	msg = e.toString();
//	  out.print(e.toString());
}
finally
{
	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}

	if(flag != 0)
	{
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode(msg));
		
	}
	else
	{
	String goPage = "edFltIrr.jsp?isZ="+request.getParameter("isZ")+"&purserEmpno="+purserEmpno+"&fdate="+fdate+"&fltno="+fltno+"&dpt="+sect.substring(0,3)+"&arv="+sect.substring(3)+"&acno="+acno+"&GdYear="
			+request.getParameter("GdYear")+"&pur="+purserEmpno;
%>
<script>
	alert("Update Crew Boarding On Time Success!!");
	self.location="<%=goPage%>";
</script>
<%			
	//response.sendRedirect(goPage);
	
	}
}//end of has session value		
%>