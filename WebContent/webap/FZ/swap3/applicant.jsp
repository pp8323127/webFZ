<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3.*"%>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

//String ourTeam = (String)session.getAttribute("Unitcd");
String sGetUsr =  (String) session.getAttribute("userid") ;//"";
String goPage  = "";
/*
session.setAttribute("aCrewInfoObj",null);	
session.setAttribute("rCrewInfoObj",null);	
session.setAttribute("aCrewSkjAL",null);	
session.setAttribute("rCrewSkjAL",null);	
*/




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
String empno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month = request.getParameter("month");
String mymm = year+"/"+month;

if(sGetUsr.equals(empno)){//被換者帳號與申請者相同
%>
<p style="color:red;text-align:center ">被換者(<%=empno%>)員工號無效!!</p>

<%
}else{
CrewSwapSkj csk = new CrewSwapSkj(sGetUsr, empno, year, month);
CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料
ArrayList aCrewSkjAL = null;//申請者的班表
ArrayList rCrewSkjAL = null; //被換者的班表
ArrayList commItemAL = null;


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
} catch (SQLException e) {
	System.out.println(e.toString());	
}catch(Exception e){
	System.out.println(e.toString());
}



String bcolor=null;


%>
<html>
<head>
<title>換班申請單--勾選欲換班次</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">

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
var len = <%=aCrewSkjAL.size()%>+<%=rCrewSkjAL.size()%>;
var c = 0;
	for(var i=0;i<len;i++){
		if(document.form1.elements[i].checked){
			c++;
		}
	}
	
	if(c == 0){
		alert("請勾選更換班次!!");
		return false;
	}else{
		document.form1.Submit.disabled=1;
		return true;
	}
}
</script>


</head>


<body bgcolor="#FFFFFF" text="#000000">
<%
//先判斷是否有班表 add by cs66 at 2006/03/24 
if(aCrewSkjAL.size() == 0 && aCrewSkjAL.size()  == 0 ){
%>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;">
<br>
<%=year+"/"+month+" 並無班表!!"%>
<br>
</div>
<%
}
else 

//申請者與被換者應為有效組員方可使用換班功能,
if(rCrewInfoObj == null | aCrewInfoObj == null){
%>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;">
<br>
被換者： <%=empno%> 非有效的員工號,請<a href="javascript:history.back(-1)" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>


<%
}else {

%>
  <form name="form1" method="post"  action="flow.jsp" onsubmit="return chek()" >

            
  <div align="center"><span class="txtblue"> </span>
<table width="70%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td ><a href="../apply_readme.htm" target="_blank"  ><span class="bt2"><br>
          &nbsp;填申請單流程說明&nbsp;</span></a><br>
          <strong></span><span class="txtxred">
		The following shedule is for reference only.<br> 
		For official up-to-date schedule information, please contact Scheduling Department.
            <br>
        下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。        </span></strong> </td>
    </tr>
  </table>
    <span class="txtblue"><b><br>
    Applicant</b></span><br>
                <span class="txtblue"><%=aCrewInfoObj.getCname()+aCrewInfoObj.getSpCode()%> 
					<%=aCrewInfoObj.getEmpno()%> 
					<%=aCrewInfoObj.getSern()%> 
					<%=aCrewInfoObj.getOccu()%> <%=aCrewInfoObj.getBase()%> 
					SP:<%=aCrewInfoObj.getSpCode()%> 
					CR:<%=aCrewInfoObj.getPrjcr()%></span>
                <table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="20%" class="tablehead">FltDate</td>
          <td width="14%" class="tablehead">FltNo</td>
          <td width="19%" class="tablehead">TripNo</td>
          <td width="12%" class="tablehead">CR</td>
          <td width="12%" class="tablehead">Detail</td>
          <td width="23%" class="tablehead">Select 
            <!--  ALL <input name="putAll" type="checkbox" onClick="CheckAll('form1','putAll');CheckAll('form1','putAll2');CheckAll('form1','checkput2')"> -->
            
          </td>
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
          <td class="tablebody"><%=obj.getDutycode()%></td>
          <td class="tablebody"><%=obj.getTripno()%></td>
          <td class="tablebody"><span class="txtxred"><%=obj.getCr()%></span></td>
          <td class="tablebody"><a href="../schdetail.jsp?fdate=<%=obj.getFdate()%>&tripno=<%=obj.getTripno()%>" target="_blank"><img src="../images/red.gif" width="15" height="15" alt="show fly schedule detail" border="0"></a></td>
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
				<%=rCrewInfoObj.getCname()+rCrewInfoObj.getSpCode()%> 
					<%=rCrewInfoObj.getEmpno()%> 
					<%=rCrewInfoObj.getSern()%> 
					<%=rCrewInfoObj.getOccu()%> <%=rCrewInfoObj.getBase()%> 
					SP:<%=rCrewInfoObj.getSpCode()%> 
					CR:<%=rCrewInfoObj.getPrjcr()%></span>
				</span>
              <table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="20%" class="tablehead">FltDate</td>
          <td width="14%" class="tablehead">FltNo</td>
          <td width="19%" class="tablehead">TripNo</td>
          <td width="12%" class="tablehead">CR</td>
          <td width="12%" class="tablehead">Detail</td>
          <td width="23%" class="tablehead">Select
           <!-- All 
            <input name="putAll2" type="checkbox" onClick="CheckAll('form1','putAll');CheckAll('form1','putAll2');CheckAll('form1','checkput')">-->
</td>
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
          <td class="tablebody"><%=obj.getFdate()%></td>
          <td class="tablebody"><%=obj.getDutycode()%></td>
          <td class="tablebody"><%=obj.getTripno()%></td>
          <td class="tablebody"><span class="txtxred"><%=obj.getCr()%></span></td>

          <td class="tablebody"><a href="../schdetail.jsp?fdate=<%=obj.getFdate()%>&tripno=<%=obj.getTripno()%>&empno=<%=obj.getEmpno()%>" target="_blank"><img src="../images/red.gif" width="15" height="15" alt="show fly schedule detail" border="0"></a></td>
          <td class="tablebody">
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
              
                <input type="hidden" name="mymm" value="<%=mymm%>">
                  <font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#FF0000">Comments</font></b></font><!-- <input type="text" name="comments" size="50" value="N" maxlength="50">	-->
			 <select name="comments">
			 <option value="已自行查詢，責任自負">已自行查詢，責任自負</option>
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
            放棄特休假，請在Comments輸入申請者（A）或被換者（R
            )+日期<br>
            Example:A12/17表示申請者放棄12/17特休假,&nbsp;R12/25表示被換者放棄12/25特休假<br>
            </p>          
          </td>
          </tr>
    </table>
    </div>          
        
  <p align="center"> 
    <input type="Submit" name="Submit" value="送出任務互換資訊" class="bt">
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