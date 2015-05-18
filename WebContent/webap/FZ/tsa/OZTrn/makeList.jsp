<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,ci.db.*,da.PTPC.*,java.util.*,ci.tool.*"%>
<%
String userid  = (String)session.getAttribute("cs55.usr");

if(request.getParameterValues("sel") == null){
	out.print("<a href='javascript:history.back(-1)'>Select Again!!!</a>");
	
}else{

	String[] index = request.getParameterValues("sel");
	String sourcePage = request.getParameter("sourcePage");
	String fleet	= request.getParameter("fleet");
	String rank 	= request.getParameter("rank");
	String peak = request.getParameter("peak");
	ArrayList al = new ArrayList();

	
	StringBuffer sb = new StringBuffer();
	if("PC".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordPC");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Check_Type\r\n");
	}else if ("PT".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordPT");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Subject\r\n");
	}else if ("CRM".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordCRM");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Subject\r\n");
	}else if ("SS".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordSS");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Subject\r\n");
	}else if ("FM".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordFM");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Subject\r\n");
	}else if ("ES".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordES");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Subject\r\n");
	}else if ("RC".equals(sourcePage)){
		al = (ArrayList)session.getAttribute("trnRecordRC");
		sb.append("Fleet,Rank,Empno,CName,EName,Last_Date,Subject\r\n");
	}
	
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.MONTH ,1);//�U�Ӥ�
	String fileName = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"_"+
		fleet+rank+sourcePage;
	if("sub".equals(request.getParameter("classes"))){
		fileName +="Sub.csv";
	}else{
		fileName +="List.csv";
	}
	
for(int i=0;i<index.length;i++){
	CKPLObj ck= (CKPLObj)al.get(Integer.parseInt(index[i]));
	sb.append(ck.getFleet()+",");
	sb.append(ck.getRank()+",");
	sb.append(ck.getEmpno()+",");
	sb.append(ck.getCname()+",");
	sb.append(ck.getEname()+",");
	sb.append(ck.getDate()+",");
	
	if("PT".equals(sourcePage)){
		sb.append(ck.getSubject()+"\r\n");
	}else{
		sb.append(ck.getChktype()+"\r\n");
	}	
	

}
//�N�������Ƽg�Jcsv��
WriteLog wl = new WriteLog(application.getRealPath("/")+"/file/"+fileName);
wl.WriteFile(sb.toString(),false);

//�g�Jlog
wl = new WriteLog(application.getRealPath("/")+"/Log/oztrnLog.txt");
wl.WriteFileWithTime(userid +" make file "+ fileName);
%>
<script language="javascript">
alert("Make File Success!!");
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<p align="center"><a href="download.jsp?filename=<%=fileName%>"><img align="TOP" border="0" height="16" src="upload.gif" width="16"><span class="txtred"><u>���I���Ϋ��k��t�s�s��!!</u></span></a></p>
<div align="center">��
<%
	if("PT".equals(sourcePage) |"PC".equals(sourcePage)  ){
%>
	  <a href="all.jsp?fleet=<%=fleet%>&rank=<%=rank%>&peak=<%=peak%>&checkType=<%=sourcePage%>" target="_self"><u>�^�e�@��</u></a>���s���ͦW��
<%
	}else{
%>
	  <a href="CRMSSFM.jsp?fleet=<%=fleet%>&rank=<%=rank%>&peak=<%=peak%>&checkType=<%=sourcePage%>" target="_self"><u>�^�e�@��</u></a>���s���ͦW��
	
<%
	}
}
%>
</div>
