<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ackhh.*"%>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

//String ourTeam = (String)session.getAttribute("Unitcd");
String sGetUsr =  (String) session.getAttribute("userid") ;//"";
String goPage  = "";

String aEmpno = (String) session.getAttribute("userid");//request.getParameter("aEmpno");


//if( "640073".equals((String)session.getAttribute("userid"))){
/*
String unitCd = (String)session.getAttribute("Unitcd");

if("176D".equals(unitCd) || "190A".equals(unitCd)){		
	 sGetUsr = request.getParameter("aEmpno");
}else{
	 sGetUsr = (String) session.getAttribute("userid") ;
}
*/


//String cname = (String) session.getAttribute("cname") ;
//String empno = request.getParameter("empno");
String empno = request.getParameter("rEmpno");//request.getParameter("rEmpno");(String)session.getAttribute("rEmpno");
String rEmpno = (String)session.getAttribute("rEmpno");

String year = request.getParameter("year");
String month = request.getParameter("month");
if(null ==session.getAttribute("userid") ){
		response.sendRedirect("/webfz/FZ/sendredirect.jsp");

}else if(null == request.getParameter("year") | null == request.getParameter("month")){
%>
<p style="background-color:#99FFFF;color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center">�п�ܦ~/��</p>

<%
}else if(null == request.getParameter("rEmpno") |null == session.getAttribute("rEmpno")
	| "".equals(request.getParameter("rEmpno"))
){
%>
<p style="background-color:#99FFFF;color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center">�п�ܳQ���̱b��</p>

<%
}else if(aEmpno.equals(rEmpno)){//�Q���̱b���P�ӽЪ̬ۦP
%>
<p style="color:red;text-align:center ">�Q����(<%=empno%>)���u���L��!!</p>

<%
}else{
CrewSwapSkj csk = new CrewSwapSkj(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //�ӽЪ̪��խ��ӤH���
CrewInfoObj rCrewInfoObj = null;//�Q���̪��խ��ӤH���
ArrayList aCrewSkjAL = null;//�ӽЪ̪��Z��
ArrayList rCrewSkjAL = null; //�Q���̪��Z��
ArrayList commItemAL = null;
String aCname = null;
String rCname = null;
try {
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();		
	aCrewSkjAL	= csk.getACrewSkjAL();
	rCrewSkjAL = csk.getRCrewSkjAL();
	commItemAL = csk.getCommItemAL();
	
/*	
	session.setAttribute("aCrewInfoObj",aCrewInfoObj);	
	session.setAttribute("rCrewInfoObj",rCrewInfoObj);	
	session.setAttribute("aCrewSkjAL",aCrewSkjAL);	
	session.setAttribute("rCrewSkjAL",rCrewSkjAL);	
*/
if(aCrewInfoObj != null){ 
//	aCname = new String(ci.tool.UnicodeStringParser.removeExtraEscape(
//			aCrewInfoObj.getCname()).getBytes(), "Big5");
aCname = aCrewInfoObj.getCname();
}

if(rCrewInfoObj != null){ 
//	rCname =new String(ci.tool.UnicodeStringParser.removeExtraEscape(
//			rCrewInfoObj.getCname()).getBytes(), "Big5");
rCname = rCrewInfoObj.getCname();
}


} catch (SQLException e) {
	System.out.println(e.toString());	
}catch(Exception e){
	System.out.println(e.toString());
	//out.println(e.toString());
}
String bcolor=null;



%>
<html>
<head>
<title>�����խ����Z�ӽг�--�Ŀ�����Z��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../menu.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<style type="text/css">
<!--


.bt{
	background-color:#99CCFF;color:#000000;font-family:Verdana;border:1pt solid #000000; 
}
.bt2{
		background-color:#CCCCCC;color:#000000;font-family:Verdana;border:1pt solid #000000; 
}

-->
</style>
<script language="javascript" type="text/javascript">
function chek(){
var len = <%=aCrewSkjAL.size()+rCrewSkjAL.size()%>;
var c = 0;
	for(var i=0;i<len;i++){
		if(document.form1.elements[i].checked){
			c++;
		}
	}
	
	if(c == 0){
		alert("�ФĿ�󴫯Z��!!");
		return false;
	}else{
		document.form1.Submit.disabled=1;
		return true;
	}
}
</script>

<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>
</head>


<body>
<%
//�ӽЪ̻P�Q�����������Ĳխ���i�ϥδ��Z�\��,
if(null == rCrewInfoObj   | null ==aCrewInfoObj   ){
%>
<div class="errStyle1" >
<br>
�Q���̡G <%=rEmpno%> �D���Ī����u��,��<a href="javascript:history.back(-1)" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>


<%
}else if(null == aCrewSkjAL){
%>
<div class="errStyle1">
<br>
�ӽЪ̡G <%=aEmpno%> �� <%=year+"/"+month %>  �L�Z��,��<a href="javascript:history.back(-1)" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}else if(  null == rCrewSkjAL){
%>
<div  class="errStyle1">
<br>
�Q���̡G <%=rEmpno%> �� <%=year+"/"+month %>  �L�Z��,��<a href="javascript:history.back(-1)" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}else{

%>
  <form name="form1" method="post"  action="flowRetire.jsp" onsubmit="return chek()" >

            
  <div align="center"><span class="txtblue"> </span>
<table width="70%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td ><a href="../apply_readme.htm" target="_blank"  ><span class="bt2"><br>
          &nbsp;��ӽг�y�{����&nbsp;</span></a><br>
          <strong></span><span class="txtxred">
		The following shedule is for reference only.<br> 
		For official up-to-date schedule information, please contact Scheduling Department.
            <br>
        �U�C�Z��ȨѰѦҡA�ЦV�խ����������T�{�ӤH�����Z����ȡC        </span></strong> </td>
    </tr>
  </table>
    <span class="txtblue"><b><br>
    Applicant</b></span><br>
                <span class="txtblue"><%=aCname%> 
					<%=aCrewInfoObj.getEmpno()%> 
					<%=aCrewInfoObj.getSern()%> 
					<%=aCrewInfoObj.getOccu()%> <%=aCrewInfoObj.getBase()%> 
					CR:<%=aCrewInfoObj.getPrjcr()%></span>
                <table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="28%" class="tablehead">FltDate</td>
          <td width="13%" class="tablehead">Fltno</td>
          <td width="13%" class="tablehead">CR</td>
          <td width="11%" class="tablehead">RestHr</td>
          <td width="8%" class="tablehead">SpCode</td>
          <td width="14%" class="tablehead">Detail</td>
          <td width="12%" class="tablehead">Select </td>
            <!--  ALL <input name="putAll" type="checkbox" onClick="CheckAll('form1','putAll');CheckAll('form1','putAll2');CheckAll('form1','checkput2')"> -->
            
          
        </tr>
        <%

	for(int i=0;i<aCrewSkjAL.size();i++){
		CrewSkjObj obj =(CrewSkjObj) aCrewSkjAL.get(i);		
			if (i%2 == 0){
				bcolor = "#CCCCCC";
			}else{
				bcolor = "#FFFFFF";
			}
%>
        <tr bgcolor="<%=bcolor%>">
          <td class="tablebody"><%=obj.getFdate()%></td>
          <td class="tablebody"><%=obj.getDutycode()%><%if("TVL".equals(obj.getCd())){out.print("&nbsp;TVL");}%></td>
          <td class="tablebody"><span class="txtxred"><%=obj.getCr()%></span></td>
<%
String resthr = "";
resthr = obj.getResthr();
if("SB".equals(obj.getDutycode()))
{
	resthr = "24";			
}
else if ("0026".equals(obj.getDutycode()) | "1026".equals(obj.getDutycode()) | "2026".equals(obj.getDutycode()))
{
	resthr = "36";			
}
else if ("0130".equals(obj.getDutycode()) | "2130".equals(obj.getDutycode()))
{
	resthr = "�@���";			
}
%>
          <td class="tablebody">&nbsp;<%=resthr%></td>
          <td class="tablebody">&nbsp;<%=obj.getSpCode()%></td>
          <td class="tablebody">
		  <%
		  if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
		  %>
		 <a href="#" onClick="subwinXY('tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" >
				<img height="16" src="../img2/doc3.gif" width="16" border="0"></a>
		<%
		}else{out.print("&nbsp;");}
		%>				
		  </td>
          <td class="tablebody">
            <div align="center">
			<input type="checkbox" name="aSwapSkj" id="aSwapSkj" value="<%=i%>">
			<%
			/*
			value = obj.getFdate()+obj.getTripno()+obj.getDutycode()+obj.getCr()

			  */
			  %>
          </div></td>
        </tr>
     <%
		}
		
	%>
    </table>
              <br>
    <span class="txtblue"><b>Substitute</b></span><br>
                <span class="txtblue">
				<%=rCname%> 
					<%=rCrewInfoObj.getEmpno()%> 
					<%=rCrewInfoObj.getSern()%> 
					<%=rCrewInfoObj.getOccu()%> <%=rCrewInfoObj.getBase()%> 
					CR:<%=rCrewInfoObj.getPrjcr()%></span>
				</span>
              <table width="65%" border="0" cellspacing="0" cellpadding="0">
                <tr>
          <td width="28%" class="tablehead">FltDate</td>
          <td width="13%" class="tablehead">Fltno</td>
          <td width="13%" class="tablehead">CR</td>
          <td width="11%" class="tablehead">RestHr</td>
          <td width="8%" class="tablehead">SpCode</td>
          <td width="14%" class="tablehead">Detail</td>
          <td width="12%" class="tablehead">Select </td>
                      <!--  ALL <input name="putAll" type="checkbox" onClick="CheckAll('form1','putAll');CheckAll('form1','putAll2');CheckAll('form1','checkput2')"> -->
                  
                </tr>
        <%
	for(int i=0;i<rCrewSkjAL.size();i++){
		CrewSkjObj obj = (CrewSkjObj)rCrewSkjAL.get(i);		
			if (i%2 == 0){
				bcolor = "#CCCCCC";
			}else{
				bcolor = "#FFFFFF";
			}
%>
        <tr bgcolor="<%=bcolor%>">
          <td width="29%" class="tablebody"><%=obj.getFdate()%></td>
          <td class="tablebody"><%=obj.getDutycode()%><%if("TVL".equals(obj.getCd())){out.print("&nbsp;TVL");}%></td>
          <td width="15%" class="tablebody"><span class="txtxred"><%=obj.getCr()%></span></td>
<%
String resthr = "";
resthr = obj.getResthr();
if("SB".equals(obj.getDutycode()))
{
	resthr = "24";			
}
else if ("0026".equals(obj.getDutycode()) | "1026".equals(obj.getDutycode()) | "2026".equals(obj.getDutycode()))
{
	resthr = "36";			
}
else if ("0130".equals(obj.getDutycode()) | "2130".equals(obj.getDutycode()))
{
	resthr = "�@���";			
}
%>
          <td class="tablebody">&nbsp;<%=resthr%></td>
          <td width="10%" class="tablebody">&nbsp;<%=obj.getSpCode()%></td>
          <td width="14%" class="tablebody">
		  <%
		  if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
		  %>
		 <a href="#" onClick="subwinXY('tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" >
				<img height="16" src="../img2/doc3.gif" width="16" border="0"></a>
		<%
		}else{out.print("&nbsp;");}
		%>				
		  </td>
          <td width="18%" class="tablebody">
            <div align="center">
				<input type="checkbox" name="rSwapSkj" id="rSwapSkj" value="<%=i%>">
<%
/*   obj.getFdate()+obj.getTripno()+obj.getEmpno()+obj.getDutycode()+obj.getCr()
*/
%>
  
          </div></td>
        </tr>
     <%
		}
	%>
    </table>

	<table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>          
              <div align="left">
              
                  <font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#FF0000">Comments</font></b></font><!-- <input type="text" name="comments" size="50" value="N" maxlength="50">	-->
			 <select name="comments">
			 <option value="�w�ۦ�d�ߡA�d���ۭt">�w�ۦ�d�ߡA�d���ۭt</option>
			<%
			for(int i=0;i<commItemAL.size();i++){
			 %>
              <option value="<%=(String)commItemAL.get(i)%>"><%=(String)commItemAL.get(i)%></option>
			  <%
			}
			%>
            </select>
			 <input name="comm2" type="text" size="20" maxlength="110">
            </div>
          </td>
        </tr>
        <tr>
          <td><p class="txtblue"><br>
            ���S�𰲡A�ЦbComments��J�ӽЪ̡]A�^�γQ���̡]R
            )+���<br>
            Example:A12/17��ܥӽЪ̩��12/17�S��,&nbsp;R12/25��ܳQ���̩��12/25�S��<br>
            <span class="txtxred">���G���Z�������ɡA�ȭp��ܷ�멳.</span>            <br>
            </p>          
          </td>
      </tr>
    </table>
    </div>          
        
  <p align="center"> 
    <input type="Submit" name="Submit" value="�e�X���Ȥ�����T" class="bt">
	<input type="hidden" name="year"  value="<%=year%>">
	<input type="hidden" name="month" value="<%=month%>">
 	<input type="hidden" name="aEmpno" value="<%=sGetUsr%>">
	<input type="hidden" name="rEmpno" value="<%=empno%>">

  </form>
<%
}
%>  
</body>
</html>
<%
}
%>