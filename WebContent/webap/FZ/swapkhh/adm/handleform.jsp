<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,swap3ackhh.*,ci.db.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  response.sendRedirect("../../sendredirect.jsp");
} else{
String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String fdd = request.getParameter("fdd");
String sno = request.getParameter("sno");
String eno = request.getParameter("eno");
String empno = request.getParameter("empno");
String rdate = fyy+"/"+fmm;


String errMsg = "";
StringBuffer sqlSB = new StringBuffer();
sqlSB.append("select * from (");
sqlSB.append("select to_char(f.newdate,'yyyy/mm/dd hh24:mi') newD,f.*, 'Y' acount, '0' acomm, 'Y' rcount, '0' rcomm, 'A' formtype from fztformf f where ");

if ("N".equals(fdd)){

	sqlSB.append("newdate >=to_date('"+rdate+"','yyyy/mm') ");
}else{
	//sql = sql + "to_char(newdate,'yyyy/mm/dd') <= '"+rdate+"'";
	sqlSB.append("newdate <= to_date('"+rdate+"/"+fdd+" 2359','yyyy/mm/dd hh24mi') ");
	
}

if (!"".equals(empno) && empno != null){
	//sql = sql + " and (aempno = '"+empno+"' or rempno = '"+empno+"') ";
	sqlSB.append("and (aempno = '"+empno+"' or rempno ='"+empno+"' ) ");
}
else
{
	if (!"".equals(sno) && sno != null )
	{
		if (!"".equals(eno) && eno != null)
		{
			//sql = sql + " and to_number(substr(to_char(formno),7)) >= "+sno+" and to_number(substr(to_char(formno),7)) <= "+eno;
			//sqlSB.append(" AND formno >="+fyy+fmm+sno +" AND formno <="+fyy+fmm+eno);
			sqlSB.append(" AND to_number(substr(to_char(formno),7)) >= "+sno +" and to_number(substr(to_char(formno),7)) <= " +eno);
		}
		else
		{
			//sql = sql + " and to_number(substr(to_char(formno),7)) = "+sno;
			//sqlSB.append(" AND formno ="+fyy+fmm+sno);
			sqlSB.append(" AND substr(to_char(formno),7) = '"+sno+"'" );
		}
	}
}
//sql = sql + " and ed_check is null order by 1";
sqlSB.append(" and ed_check is null ");
sqlSB.append(" union all ");
sqlSB.append("select to_char(f.newdate,'yyyy/mm/dd hh24:mi') newD, f.*, 'B' formtype from fztbformf f where ");

if ("N".equals(fdd))
{

	sqlSB.append("newdate >=to_date('"+rdate+"','yyyy/mm') ");
}else{
	//sql = sql + "to_char(newdate,'yyyy/mm/dd') <= '"+rdate+"'";
	sqlSB.append("newdate <= to_date('"+rdate+"/"+fdd+" 2359','yyyy/mm/dd hh24mi') ");
	
}

if (!"".equals(empno) && empno != null){
	//sql = sql + " and (aempno = '"+empno+"' or rempno = '"+empno+"') ";
	sqlSB.append("and (aempno = '"+empno+"' or rempno ='"+empno+"' ) ");
}
else{
	if (!"".equals(sno) && sno != null )
	{
		if (!"".equals(eno) && eno != null)
		{
			//sql = sql + " and to_number(substr(to_char(formno),7)) >= "+sno+" and to_number(substr(to_char(formno),7)) <= "+eno;
			//sqlSB.append(" AND formno >="+fyy+fmm+sno +" AND formno <="+fyy+fmm+eno);
			sqlSB.append(" AND to_number(substr(to_char(formno),7)) >= "+sno +" and to_number(substr(to_char(formno),7)) <= " +eno);
		}
		else
		{
			//sql = sql + " and to_number(substr(to_char(formno),7)) = "+sno;
			//sqlSB.append(" AND formno ="+fyy+fmm+sno);
			sqlSB.append(" AND substr(to_char(formno),7) = '"+sno+"'" );
		}
	}
}
//sql = sql + " and ed_check is null order by 1";
sqlSB.append(" and ed_check is null");
sqlSB.append(" ) order by formno ");

//out.print(sqlSB.toString()+"<br>");

String bcolor=null;

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

boolean status = false;
ArrayList commAL = new ArrayList();
ArrayList al = null;
try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("select * from fztcommf ORDER BY Decode(citem,'Agree',' ',citem)");

rs = pstmt.executeQuery();
while(rs.next())
{
	commAL.add(rs.getString("citem"));
}
rs.close();
pstmt.close();

pstmt = conn.prepareStatement(sqlSB.toString());
rs = pstmt.executeQuery();
while(rs.next())
{
	if(al == null){
		al = new ArrayList();
	}
	swap3ackhh.SwapFormObj obj = new swap3ackhh.SwapFormObj();
	obj.setFormno(rs.getString("formno"));
	obj.setAEmpno(rs.getString("aempno"));
	obj.setREmpno(rs.getString("rempno"));
	obj.setEd_check(rs.getString("ed_check"));		
	obj.setComments(rs.getString("comments"));
	obj.setNewuser(rs.getString("newuser"));
	obj.setNewdate(rs.getString("newD"));
	obj.setFormtype(rs.getString("formtype"));
	obj.setAcount(rs.getString("acount"));
	obj.setAcomm(rs.getString("acomm"));
	obj.setRcount(rs.getString("rcount"));
	obj.setRcomm(rs.getString("rcomm"));
	al.add(obj);						
}
	rs.close();
	pstmt.close();
	conn.close();
	status = true;
	if(al == null){
		status = false;
		errMsg = "查無資料!!<br>可能原因為 1.查詢區間內無資料. "
			+"<br>2.所以申請單均已處理.<br>已處理之申請單,請至「申請單查詢」中查詢.";	
	}
}catch (Exception e){
	  status = false;
	  errMsg +="ERROR:"+e.getMessage();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>申請單處理</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../../../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../../style/lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">

</head>

<body >
<%
if(!status){
%><div class="errStyle3"><img src="../../images/messagebox_warning.png" align="absmiddle"><%=errMsg%></div>
<%
}else{



%>
<div class="hiddenStatus" id="showMessage">Loading....</div>
<form name="form1" method="post" action="upd_handleform.jsp" ONSUBMIT="return checkForm()">
  <table width="1000" border="1" cellspacing="1" cellpadding="0" style="border-collapse:collapse; ">
  <caption class="txttitletop">
  換班申請單處理
  </caption>
    <tr class="bgPurple center"> 
      <td width="92" height="27">表單編號</td>
      <td width="82">申請者</td>
      <td width="83">被換者</td>
      <td width="145">審核</td>
      <td width="360">審核意見</td>
      <td width="131">遞單時間</td>
	  <td width="41">檢視</td>
    </tr>
    <%
	  	for(int i=0;i<al.size();i++)
	    {
			swap3ackhh.SwapFormObj obj = (swap3ackhh.SwapFormObj)al.get(i);				
%>
    <tr class="center<%if (i%2 == 1){%> bgLGray<%}%>"> 
	  <input type="hidden" name="formtype" value="<%=obj.getFormtype()%>">   
	  <input type="hidden" name="acount" value="<%=obj.getAcount()%>">   
	  <input type="hidden" name="acomm" value="<%=obj.getAcomm()%>">   
	  <input type="hidden" name="rcount" value="<%=obj.getRcount()%>">  
	  <input type="hidden" name="rcomm" value="<%=obj.getRcomm()%>">   
      <td ><%=obj.getFormtype()%><%=obj.getFormno()%><input type="hidden" name="formno" value="<%=obj.getFormno()%>"></td>
      <td ><%=obj.getAEmpno()%><input type="hidden" name="aempno" value="<%=obj.getAEmpno()%>">      </td>
      <td ><%=obj.getREmpno()%><input type="hidden" name="rempno" value="<%=obj.getREmpno()%>">      </td>
      <td >
        <label>
        <input name="cf<%=i%>" type="radio" value="Y" checked onClick="if(this.checked==true){document.getElementById('cfj<%=i%>').className='';}else{document.getElementById('cfj<%=i%>').className='red';}">
  Agree</label>
       
        <label id="cfj<%=i%>">
        <input type="radio" name="cf<%=i%>" value="N" onClick="if(this.checked==true){document.getElementById('cfj<%=i%>').className='red';}else{document.getElementById('cfj<%=i%>').className='';}">
  Reject</label>
        
      
	  </td>
      <td class="left" ><input name="addcomm" type="text" size="10" maxlength="10" style="margin-right:0.5em; ">
	  <select name="comm">
          <% for(int idx=0;idx<commAL.size();idx++){%><option value="<%=commAL.get(idx)%>"><%=commAL.get(idx)%></option><%}%>
        </select>
      </td>
      <td class="left">        <%=obj.getNewdate()%></td>
	  <td>
     <!-- <a href="javascript:showForm('<%=obj.getFormno()%>','<%=obj.getFormtype()%>');" ><img src="../../images/blue_view.gif" width="16" height="16"></a>-->
<%
if("A".equals(obj.getFormtype()))		  
{
%>
	<a href="../showForm.jsp?formno=<%=obj.getFormno()%>" target="_blank"><img src="../../images/blue_view.gif" width="16" height="16"></a>
<%	  
}
else
{
%>
	<a href="../../credit/swapkhh/showBForm.jsp?formno=<%=obj.getFormno()%>" target="_blank"><img src="../../images/blue_view.gif" width="16" height="16"></a><%	  
}
%>
	  </td>
    </tr>
   
    <%
	}
%>
 <tr class="bgLGray">
      <td colspan="7" class="left">Total  : <%=al.size()%>
	  <div class="center"><input type="submit" name="s1" id="s1" value="處理申請單" title="儲存申請單處理" class="kbd">
	  </div>
	  </td>
    </tr>

  </table>
  <br>
  <table width="77%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
	  <td class="noborder"><span style="color:#FF0000 ">* </span></td>
	  <td class="noborder"><div align="left"><span style="color:#FF0000 ">A 開頭單號為三次換班申請單; B 開頭單號為積點換班申請單</span></div></td>
  </tr>
  </table>    
</form>
<form name="form2" method="post" action="" target="showform" >
	<input type="hidden" name="formno" id="formno2">
</form>
<script language="javascript" src="../../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function showForm(formNo,formtype)
{
	document.getElementById("formno2").value = formNo;
	subwin('../blank.htm','showform');	
	if(formtype=="A")
	{
		document.form2.action="../showForm.jsp";
	}
	else
	{
		document.form2.action="../../credit/swapkhh/showBForm.jsp";
	}
	document.form2.submit();	
}

function checkForm()
{  
	if(confirm("是否要更新申請單狀態，並將結果寄送至組員信箱 ?"))
	{
		document.getElementById("showMessage").className="showStatus";
		document.getElementById("s1").disabled =true;
		document.form1.action="upd_handleform.jsp";
		return true;
	}
	else
	{
		return false;
	}
}

</script>

<%
}
%>

</body>
</html>
<%
}
%>