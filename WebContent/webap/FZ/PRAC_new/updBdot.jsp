<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//��s�n���Ǯɸ�T

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}
else if("2400".equals(request.getParameter("bdtm")))
{
%>
<div style="background-color:#66FFFF;color:#FF0000;text-align:center;padding:2pt;font-family:Verdana;font-size:10pt; "><br>
�n���ɶ��A�п�J24�p�ɨ�HHMM�]��0000 ~ 2359�^<br>
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
//in case when fltno == �T�X
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
//�ˬd�n���ɶ����׬O�_�۲� yyyymmdd hh24mi


try{
//     User connection pool 
       cn.setORP3EGUserCP();
       dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
       conn = dbDriver.connect(cn.getConnURL() ,null);

// �����s�u ORP3FZ cn.setORT1EG();
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
	msg="�n���ɶ����~!!";
}
else
{
//�n���Ǯɸ�T
	borot = new fz.pracP.BordingOnTime(fdate,fltno,sect,purserEmpno);
	try 
	{
		borot.SelectData();
	//	System.out.println("�O�_��flight��ơG" + borot.isHasFlightInfo());
	//	System.out.println("�O�_���n����ơG" + borot.isHasBdotInfo());
	
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
}//end of pass �n���ɶ�����check

}
catch (SQLException e)
{
//	  out.print(e.toString());
	flag =-1;
	//msg ="�n���ɶ��榡���~�A�п�JHHMM<br>�γƵ��r�ƶW�L75�Ӥ���r.<br>";
	msg ="�ӯZ���i�w�s�b�A�гs���U�լd��<br>";
	
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