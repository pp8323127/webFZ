<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ackhh.*"%>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

//String ourTeam = (String)session.getAttribute("Unitcd");
String sGetUsr =  (String) session.getAttribute("userid") ;
String goPage  = "";

String aEmpno = (String) session.getAttribute("userid");//request.getParameter("aEmpno");request.getParameter("aEmpno");
if(session.isNew() | null == session.getAttribute("userid")){

response.sendRedirect("../sendredirect.jsp");
}else{


//String cname = (String) session.getAttribute("cname") ;
//String empno = request.getParameter("empno");
String empno = request.getParameter("rEmpno");//request.getParameter("rEmpno");(String)session.getAttribute("rEmpno");
String rEmpno = (String)session.getAttribute("rEmpno");

String year = request.getParameter("year");
String month = request.getParameter("month");

if(aEmpno.equals(rEmpno)){//�Q���̱b���P�ӽЪ̬ۦP
%>
<p style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">�Q����(<%=empno%>)���u���L��!!</p>

<%
}else{
CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //�ӽЪ̪��խ��ӤH���
CrewInfoObj rCrewInfoObj = null;//�Q���̪��խ��ӤH���
ArrayList aCrewSkjAL = null;//�ӽЪ̪��Z��
ArrayList rCrewSkjAL = null; //�Q���̪��Z��

String aCname = null;
String rCname = null;
try {
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();		
	aCrewSkjAL	= csk.getACrewSkjAL();
	rCrewSkjAL = csk.getRCrewSkjAL();
	
	

if(aCrewInfoObj != null){ 
/*	aCname = new String(ci.tool.UnicodeStringParser.removeExtraEscape(
			aCrewInfoObj.getCname()).getBytes(), "Big5");
*/
	aCname			 = aCrewInfoObj.getCname();
}

if(rCrewInfoObj != null){ 
/*	rCname =new String(ci.tool.UnicodeStringParser.removeExtraEscape(
			rCrewInfoObj.getCname()).getBytes(), "Big5");
*/
	rCname	 = rCrewInfoObj.getCname();
}


} catch (SQLException e) {
	System.out.println("crossCr Exception :"+e.toString());	
}catch(Exception e){
	System.out.println("crossCr Exception :"+e.toString());
	//out.println(e.toString());
}
//���o�Q�d�ߪ̤w������
swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,year,month);


String bcolor=null;



%>
<html>
<head>
<title>���ɸպ�d��</title>
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


<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

function chek(){
//var len = <%=aCrewSkjAL.size()+rCrewSkjAL.size()%>;
var c = 0;
	for(var i=0;i<document.form1.elements.length;i++){
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

</head>


<body>
<%
//�ӽЪ̻P�Q�����������Ĳխ���i�ϥδ��Z�\��,
if(null == rCrewInfoObj   | null ==aCrewInfoObj   ){
%>
<div class="errStyle1" >
<br>
�Q���̡G <%=rEmpno%> �D���Ī����u��,��<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>


<%
}else if(null == aCrewSkjAL){
%>
<div class="errStyle1">
<br>
<%=aEmpno%> �� <%=year+"/"+month %>  �L�Z��,��<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}else if(  null == rCrewSkjAL){
%>
<div  class="errStyle1">
<br>
�Q�d�ߪ̡G <%=rEmpno%> �� <%=year+"/"+month %>  �L�Z��,��<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}else{
//�g�Jlog
fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ400K");
%>
<form name="form1" method="post"  action="crossCrCalc.jsp" onsubmit="return chek()" >

<div align="center"> 
	<span class="txtxred">���Z���ɸպ�</span><a href="javascript:window.print();"><img src="../images/print.gif" border="0"></a><br>
  <span class="txtblue"><%=aCname%> 
					<%=aCrewInfoObj.getEmpno()%> 
					<%=aCrewInfoObj.getSern()%> 
					<%=aCrewInfoObj.getOccu()%> <%=aCrewInfoObj.getBase()%> 
	        CR:<%=aCrewInfoObj.getPrjcr()%></span>
  <span class="txtblue"><span class="txtxred">����w���Z����:<%=ac.getAApplyTimes()%></span></span>
                <table width="65%" border="0" cellspacing="0" cellpadding="0">
                <tr>
				  <td width="28%" class="tablehead">FltDate</td>
				  <td width="13%" class="tablehead">Fltno</td>
				  <td width="13%" class="tablehead">CR</td>
				  <td width="11%" class="tablehead">RestHr</td>
				  <td width="8%" class="tablehead">SpCode</td>
				  <td width="14%" class="tablehead">Detail</td>
				  <td width="12%" class="tablehead">Select </td>
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
                    <td height="27" class="tablebody"><%=obj.getFdate()%></td>
                    <td class="tablebody"><%=obj.getDutycode()%>
                        <%if("TVL".equals(obj.getCd())){out.print("&nbsp;TVL");}%>
                    </td>
                    <td class="tablebody">&nbsp;<span style="color:#FF0000"> 
<%
					if("BL".equals(obj.getCd()))
					{
						out.print("0200");
					}
					else
					{
						out.print(obj.getCr());
					}					
					%> 
					</span> 
					</td>
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
          <td width="14%" class="tablebody">

			<%
			
			if(!"0".equals(obj.getTripno())){
			%>
					<a href="#" onClick="subwinXY('tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" > <img height="16" src="../img2/doc3.gif" width="16" border="0"></a><% }else{out.print("&nbsp;");} %> </td>
                  
		  <td class="tablebody"> <div align="center">&nbsp;
		  <%
		if(!"B1".equals(obj.getDutycode()) && !"EE".equals(obj.getDutycode()) 
			&& !"MT".equals(obj.getDutycode()) && !"CT".equals(obj.getDutycode()) &&
			!"FT".equals(obj.getDutycode()) && !"B2".equals(obj.getDutycode()) &&
			!"GS".equals(obj.getDutycode()) && !"BL".equals(obj.getDutycode()) 
			&& ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) | "XL".equals(obj.getDutycode()) | "LVE".equals(obj.getDutycode()))) ) )
			{		 
		  %>
			 
				<input type="checkbox" name="aSwapSkj" id="aSwapSkj" value="<%=i%>">
			
			  <%
			  }else{out.print("&nbsp;");}
			  %>
  </div>			  
			</td>
			</tr>
      <%
		}
		
	%>
                </table>
              <br>
    <br>
                <span class="txtblue">
				<%=rCname%> 
					<%=rCrewInfoObj.getEmpno()%> 
					<%=rCrewInfoObj.getSern()%> 
					<%=rCrewInfoObj.getOccu()%> <%=rCrewInfoObj.getBase()%> 
					CR:<%=rCrewInfoObj.getPrjcr()%>&nbsp;<span class="txtxred">����w���Z����:<%=ac.getRApplyTimes()%></span></span>
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
          <td height="27" class="tablebody"><%=obj.getFdate()%></td>
          <td class="tablebody"><%=obj.getDutycode()%><%if("TVL".equals(obj.getCd())){out.print("&nbsp;TVL");}%></td>
          <td class="tablebody">&nbsp;<span style="color:#FF0000"> <%=obj.getCr()%></span></td>
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
              <td width="14%" class="tablebody">

			<%
			
			if(!"0".equals(obj.getTripno())){
			%>
					<a href="#" onClick="subwinXY('tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" > <img height="16" src="../img2/doc3.gif" width="16" border="0"></a><% }else{out.print("&nbsp;");} %> </td>
          <td class="tablebody"><div align="center">&nbsp;
		  <%
		 if(!"B1".equals(obj.getDutycode()) && !"EE".equals(obj.getDutycode())
		 	&& !"MT".equals(obj.getDutycode()) && !"CT".equals(obj.getDutycode()) &&
			!"FT".equals(obj.getDutycode()) && !"B2".equals(obj.getDutycode()) &&
			!"GS".equals(obj.getDutycode()) && !"BL".equals(obj.getDutycode()) 
			&& ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) | "XL".equals(obj.getDutycode()) | "LVE".equals(obj.getDutycode()))) ) )
		 {
		  %>
            
			<input type="checkbox" name="rSwapSkj" id="rSwapSkj" value="<%=i%>">

		  <%
		  }else{out.print("&nbsp;");}
		  %>          </div>
		  </td>
		  
          </tr>
     <%
		}
	%>
    </table>


              <br>
</div>          
            <div align="center">
	  <input type="Submit" name="Submit" value="���Z���ɸպ�" class="bt">
	  <input type="hidden" name="year"  value="<%=year%>">
	  <input type="hidden" name="month" value="<%=month%>">
 	  <input type="hidden" name="aEmpno" value="<%=sGetUsr%>">
	  <input type="hidden" name="rEmpno" value="<%=empno%>">
      <br>  
          </div>
		  
</form>
<div style="text-align:justify;font-family:Verdana;font-size:10pt;padding-left:150pt;color:#FF0000;padding-bottom:2pt;padding-top:2pt;margin-left:50pt;line-height:1.3" align="center">
**���G<br>
1.B1,CT,FT,B2,GS ���o�ӽд��Z<br>
2.EE,MT�ݥ��g�դW�P�N��A��񴫯Z��ӽ�.<br>
3.���\��ȴ��Ѵ��Z�e���ɸպ�A<br>
���ˬd���Z����O�_���ӽг�|���gED�B�z�A<br>
�θӤ봫�Z���ƶW�L3�����o���Z�����p.<br>
4.�d�ߥ��ȩ��ӡA���I��Detail <img height="16" src="../img2/doc3.gif" width="16" border="0">�ϥ�.<br>
</div>
<%
}
%>  
</body>
</html>
<%
}

}//end of has session
%>