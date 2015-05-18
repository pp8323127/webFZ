<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*,fz.psfly.*"%>
<%
String uid = request.getParameter("uid");
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../../sendredirect.jsp");
} 

String fltdt = request.getParameter("fltdt");//yyyy/mm/dd
String fltno = request.getParameter("fltno");//006
String sect = request.getParameter("sect");//TPELAX
String topic_no = request.getParameter("topic_no");
String fleet = request.getParameter("fleet");
String acno = request.getParameter("acno");
String[] chkItem = request.getParameterValues("checkfactor");
ArrayList insAL = new ArrayList();

//Check if fill completed
PRSFlyIssue psf = new PRSFlyIssue();
ArrayList bankItemobjAL = new ArrayList();
psf.getBankItemno(topic_no);//blank 
bankItemobjAL = psf.getBankObjAL();
boolean passchk = true;
for(int i=0; i<bankItemobjAL.size(); i++)
{
	//check if filled for each issue
	PSFlyIssueObj obj = (PSFlyIssueObj) bankItemobjAL.get(i);
	String tempNum_satisfy = request.getParameter("ccnum"+obj.getTopic_no()+"-"+obj.getItemno());
	String tempNum_needtoimprove = request.getParameter("cpnum"+obj.getTopic_no()+"-"+obj.getItemno());
	if( (tempNum_satisfy == null | "".equals(tempNum_satisfy) | "0".equals(tempNum_satisfy)) && (tempNum_needtoimprove == null | "".equals(tempNum_needtoimprove) | "0".equals(tempNum_needtoimprove)))
	{
		passchk = false;
	}
	
	//check if has reasons for need to improve item
	if (tempNum_needtoimprove == null | "".equals(tempNum_needtoimprove))
	{
		tempNum_needtoimprove ="0";
	}
	int countnum =0;
	if (Integer.parseInt(tempNum_needtoimprove)>0)
	{
		if(chkItem == null)
		{
			passchk = false;
		}
		else
		{
			for(int c=0;c<chkItem.length;c++)
			{
				if((obj.getTopic_no()+"-"+obj.getItemno()).equals(chkItem[c].substring(0,chkItem[c].indexOf("/"))))
				{
					countnum++;
				}
			}
		}		
		if(countnum<=0)
		{
			passchk = false;
		}
	}
}

if(passchk == true)
{
	if(chkItem != null)
	{
		for(int i=0;i<chkItem.length;i++)
		{
			PRSFlyFactorObj obj = new PRSFlyFactorObj();
			for(int j=0; j<bankItemobjAL.size(); j++)
			{
				PSFlyIssueObj objb = (PSFlyIssueObj) bankItemobjAL.get(j);
				if(objb.getTopic_no().equals(chkItem[i].substring(0,chkItem[i].indexOf("-"))) && objb.getItemno().equals(chkItem[i].substring(chkItem[i].indexOf("-")+1,chkItem[i].indexOf("/"))))
				{
					objb.setRanking("Y");
				}
			}
			//like "2-12/A-16"
			obj.setTopic_no(chkItem[i].substring(0,chkItem[i].indexOf("-")));
			obj.setItemno(chkItem[i].substring(chkItem[i].indexOf("-")+1,chkItem[i].indexOf("/")));
			obj.setKin(chkItem[i].substring(0,chkItem[i].indexOf("-")));
			obj.setQtype("S");
			obj.setFltdt(fltdt);
			obj.setFltno(fltno);
			obj.setSect(sect);
			obj.setEmpno(sGetUsr);
			obj.setAcno(acno);
			obj.setFleet(fleet);
			String tempNum_satisfy = request.getParameter("ccnum"+chkItem[i].substring(0,chkItem[i].indexOf("/")));
			if(tempNum_satisfy==null | "".equals(tempNum_satisfy))
			{
				tempNum_satisfy="0";
			}
			obj.setNum_satisfy(tempNum_satisfy);
		    String tempDuty_satisfy = request.getParameter("duty-cnum"+chkItem[i].substring(0,chkItem[i].indexOf("/")));
		    if(tempDuty_satisfy==null | "".equals(tempDuty_satisfy))
			{
				tempDuty_satisfy="";
			}
			obj.setDuty_satisfy(tempDuty_satisfy);

			String tempNum_needtoimprove = request.getParameter("cpnum"+chkItem[i].substring(0,chkItem[i].indexOf("/")));
			if(tempNum_needtoimprove==null | "".equals(tempNum_needtoimprove))
			{
				tempNum_needtoimprove="0";
			}	
			obj.setNum_needtoimprove(tempNum_needtoimprove);

			String tempDuty_needtoimprove = request.getParameter("duty-pnum"+chkItem[i].substring(0,chkItem[i].indexOf("/")));
		    if(tempDuty_needtoimprove==null | "".equals(tempDuty_needtoimprove))
			{
				tempDuty_needtoimprove="";
			}
			obj.setDuty_needtoimprove(tempDuty_needtoimprove);
			obj.setFactor_no(chkItem[i].substring(chkItem[i].indexOf("/")+1,chkItem[i].lastIndexOf("-")));
			obj.setFactor_sub_no(chkItem[i].substring(chkItem[i].lastIndexOf("-")+1));
			obj.setDesc_needtoimprove(request.getParameter("desc-"+chkItem[i]));
			insAL.add(obj);
		}
	}//if(chkItem != null)
	//chkItem is null, means no need to improve items	
	for(int i=0; i<bankItemobjAL.size(); i++)
	{
		PSFlyIssueObj obji = (PSFlyIssueObj) bankItemobjAL.get(i);
		if(!"Y".equals(obji.getRanking()))
		{
			PRSFlyFactorObj obj = new PRSFlyFactorObj();
			obj.setTopic_no(obji.getTopic_no());
			obj.setItemno(obji.getItemno());
			obj.setKin(obji.getTopic_no());
			obj.setQtype("S");
			obj.setFltdt(fltdt);
			obj.setFltno(fltno);
			obj.setSect(sect);
			obj.setEmpno(sGetUsr);
			obj.setAcno(acno);
			obj.setFleet(fleet);
			String tempNum_satisfy = request.getParameter("ccnum"+obji.getTopic_no()+"-"+obji.getItemno());
			if(tempNum_satisfy==null | "".equals(tempNum_satisfy))
			{
				tempNum_satisfy="0";
			}
			obj.setNum_satisfy(tempNum_satisfy);
			obj.setDuty_satisfy(request.getParameter("duty-cnum"+obji.getTopic_no()+"-"+obji.getItemno()));			
			obj.setNum_needtoimprove("0");
			obj.setDuty_needtoimprove("");
			obj.setFactor_no("");
			obj.setFactor_sub_no("");
			obj.setDesc_needtoimprove("");
			insAL.add(obj);
		}
	}
//out.println("bankItemobjAL "+bankItemobjAL.size()+"<br>");
//out.println("insAL "+insAL.size()+"<br>");
	//out.println("**********************************");
/*	
	for(int i =0; i<insAL.size(); i++)
	{
		PRSFlyFactorObj obj = (PRSFlyFactorObj) insAL.get(i);
		out.println(obj.getTopic_no());
		out.println("<br>");
		out.println(obj.getItemno());
		out.println("<br>");
		out.println(obj.getKin());
		out.println("<br>");
		out.println(obj.getQtype());
		out.println("<br>");
		out.println(obj.getFltdt());
		out.println("<br>");
		out.println(obj.getFltno());
		out.println("<br>");
		out.println(obj.getSect());
		out.println("<br>");
		out.println(obj.getEmpno());
		out.println("<br>");
		out.println(obj.getAcno());
		out.println("<br>");
		out.println(obj.getFleet());
		out.println("<br>");
		out.println(obj.getAcno());
		out.println("<br>");
		out.println(obj.getNum_satisfy());
		out.println("<br>");
		out.println(obj.getDuty_satisfy());
		out.println("<br>");
		out.println(obj.getNum_needtoimprove());
		out.println("<br>");
		out.println(obj.getDuty_needtoimprove());
		out.println("<br>");
		out.println(obj.getFactor_no());
		out.println("<br>");
		out.println(obj.getFactor_sub_no());
		out.println("<br>");
		out.println(obj.getNewdate());	
		out.println("<br>");
	}
*/	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	Driver dbDriver = null;
	String sql = "";
	ResultSet rs = null;
	String returnstr = "";
	int count = 0;
	boolean iscommit = false;
	try
	{
		ConnDB cn = new ConnDB();
		cn.setORP3EGUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		conn.setAutoCommit(false);	
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

		sql = " delete from egtprsf  WHERE fltdt = To_Date('"+fltdt+"','yyyy/mm/dd') AND fltno = '"+fltno+"' AND sect = '"+sect+"' AND empno = '"+sGetUsr+"'";
//out.println(sql);


		stmt.executeUpdate(sql);

		sql = "insert into egtprsf (fltdt,fltno,sect,empno,fleet,acno,topic_no,itemno,num_satisfy,duty_satisfy,num_needtoimprove,duty_needtoimprove,factor_no,factor_sub_no,newdate,desc_needtoimprove,psfm_itemno) values (to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,(select distinct(psfm_itemno) from  egtpsti where topic_no = ?)) ";

		pstmt = null;
		pstmt = conn.prepareStatement(sql);			
		int count2 =0;
		for(int i =0; i<insAL.size(); i++)
		{
			PRSFlyFactorObj obj = (PRSFlyFactorObj) insAL.get(i);
			int j = 1;

			pstmt.setString(j, obj.getFltdt());
			pstmt.setString(++j, obj.getFltno());  
			pstmt.setString(++j, obj.getSect());  
			pstmt.setString(++j, obj.getEmpno());  
			pstmt.setString(++j, obj.getFleet());  
			pstmt.setString(++j, obj.getAcno());  
			pstmt.setString(++j, obj.getTopic_no());  
			pstmt.setString(++j, obj.getItemno());  
			pstmt.setString(++j, obj.getNum_satisfy());  
			pstmt.setString(++j, obj.getDuty_satisfy());  
			pstmt.setString(++j, obj.getNum_needtoimprove());  
			pstmt.setString(++j, obj.getDuty_needtoimprove());  

			if("0".equals(obj.getNum_needtoimprove()) | "".equals(obj.getNum_needtoimprove()))
			{
				obj.setFactor_no("");
				obj.setFactor_sub_no("");
				obj.setDesc_needtoimprove("");
				//obj.setTopic_no("");
			}

			pstmt.setString(++j, obj.getFactor_no());  
			pstmt.setString(++j, obj.getFactor_sub_no());  
			pstmt.setString(++j, obj.getDesc_needtoimprove());  
			pstmt.setString(++j, obj.getTopic_no());  
			pstmt.addBatch();
			count2++;
			if (count2 == 10)
			{
				pstmt.executeBatch();
				pstmt.clearBatch();
				count2 = 0;
			}
		}

		if (count2 > 0)
		{
			pstmt.executeBatch();
			pstmt.clearBatch();
		}

		conn.commit();	
		iscommit = true;
	}
	catch (Exception e) 
	{	out.println(e.toString());
		try { conn.rollback(); } //有錯誤時 rollback
		catch (SQLException e1) { out.print(e1.toString()); }
	%>
		<script language=javascript>
			alert("Update failed!!\n更新失敗!!");
			//window.history.back(-1)
		</script>
	<%
	} 
	finally
	{
		if (stmt != null) try {stmt.close();} catch (SQLException e) {}	
		if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
		if (conn != null) try { conn.close(); } catch (SQLException e) {}
		if(iscommit == true)
		{
		%>
			<script language=javascript>
				alert("Update completed!!\n更新成功!!");
				//window.opener.location.reload();
				this.window.close();
				</script>
		<%
		}
	}
}//if(passchk == true)
else
{
%>
	<script language=javascript>
		alert("Please complete each Issue!!\n有部份題目尚未填寫完全!!");
		window.history.back(-1);
	</script>
<%
}
%>