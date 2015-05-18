<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ackhh.*"%>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

//String ourTeam = (String)session.getAttribute("Unitcd");
String sGetUsr =  (String) session.getAttribute("userid") ;
String goPage  = "";

//if( "640073".equals((String)session.getAttribute("userid"))){
/*
String unitCd = (String)session.getAttribute("Unitcd");

if("176D".equals(unitCd) || "190A".equals(unitCd)){		
	 sGetUsr = request.getParameter("aEmpno");
}else{
	 sGetUsr = (String) session.getAttribute("userid") ;
}
*/
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month =request.getParameter("month");
String asno =request.getParameter("asno");

if(null ==session.getAttribute("userid") )
{
	response.sendRedirect("../../sendredirect.jsp");
}
else if(null == request.getParameter("year") | null == request.getParameter("month"))
{
%>
<p style="background-color:#99FFFF;color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center">請選擇年/月</p>

<%
}
else if(null == rEmpno |null == session.getAttribute("rEmpno")| "".equals(rEmpno))
{
%>
<p style="background-color:#99FFFF;color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center">請選擇被換者帳號</p>

<%
}
else if(aEmpno.equals(rEmpno))
{//被換者帳號與申請者相同
%>
<p style="color:red;text-align:center ">被換者(<%=rEmpno%>)員工號無效!!</p>
<%
}
else
{
CrewSwapSkj csk = new CrewSwapSkj(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料
ArrayList aCrewSkjAL = new ArrayList();//申請者的班表
ArrayList rCrewSkjAL = new ArrayList(); //被換者的班表
ArrayList commItemAL  = new ArrayList();
String aCname = null;
String rCname = null;
try 
{
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();		
	aCrewSkjAL	= csk.getACrewSkjAL();
	rCrewSkjAL = csk.getRCrewSkjAL();
	commItemAL = csk.getCommItemAL();	

	if(aCrewInfoObj != null)
	{ 
		aCname = aCrewInfoObj.getCname();
	}

	if(rCrewInfoObj != null)
	{ 
		rCname = rCrewInfoObj.getCname();
	}
} 
catch (SQLException e) 
{
	System.out.println(e.toString());	
}catch(Exception e){
	System.out.println(e.toString());
	//out.println(e.toString());
}
String bcolor=null;

%>
<html>
<head>
<title>換班申請單--勾選欲換班次</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../../menu.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../../errStyle.css">
<link rel="stylesheet" type="text/css" href="../../../style/lightColor.css">
<style type="text/css">
<!--


.bt{
	background-color:#99CCFF;color:#000000;font-family:Verdana;border:1pt solid #000000; 
}
.bt2{
		background-color:#CCCCCC;color:#000000;font-family:Verdana;border:1pt solid #000000; 
}
tr,td{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10pt;}
.center{text-align:center;}
.tablebody,select{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10pt;}
#aSwapSkj, #rSwapSkj,input{border:1pt solid gray ;}

-->
</style>
<script language="javascript" type="text/javascript">
function chek(){
var len = <%=aCrewSkjAL.size()+rCrewSkjAL.size()%>;
var c = 0;
	for(var i=0;i<len;i++)
	{
		if(document.form1.elements[i].checked)
		{
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

<script language="javascript" src="../../js/subWindow.js" type="text/javascript"></script>
</head>


<body>
<%
//申請者與被換者應為有效組員方可使用換班功能,
if(null == rCrewInfoObj   | null ==aCrewInfoObj   )
{
%>
<div class="errStyle1" >
<br>
被換者： <%=rEmpno%> 非有效的員工號,請<a href="javascript:history.back(-1)" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>
<%
}
else if(null == aCrewSkjAL)
{
%>
<div class="errStyle1">
<br>
申請者： <%=aEmpno%> 於 <%=year+"/"+month %>  無班表,請<a href="javascript:history.back(-1)" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>
<%
}
else if(  null == rCrewSkjAL)
{
%>
<div  class="errStyle1">
<br>
被換者： <%=rEmpno%> 於 <%=year+"/"+month %>  無班表,請<a href="javascript:history.back(-1)" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>
<%
}
else
{
%>
  <form name="form1" method="post"  action="creditSwap_step7.jsp" onsubmit="return chek()" >

            
  <div align="center">
<table width="70%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td > <img src="../../images/information.png" width="16" height="16"><span class="txtxred">
		The following shedule is for reference only.<br> 
		For official up-to-date schedule information, please contact Scheduling Department.
            <br>
        下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。     </span></strong> </td>
    </tr>
  </table>
    <span class="txtblue"><b><br>
    Applicant</b></span><br>
                <span class="txtblue"><%=aCname%> 
					<%=aCrewInfoObj.getEmpno()%> 
					<%=aCrewInfoObj.getSern()%> 
					<%=aCrewInfoObj.getOccu()%> <%=aCrewInfoObj.getBase()%> 
					CR:<%=aCrewInfoObj.getPrjcr()%></span>
                <table width="65%" border="1" cellspacing="1" cellpadding="1" style="border-collapse:collapse; ">
        <tr class="bgPurple center"   >
          <td width="28%" class="tablehead">FltDate</td>
          <td width="13%" class="tablehead">Fltno</td>
          <td width="13%" class="tablehead">CR</td>
          <td width="8%" class="tablehead">RestHr</td>
          <td width="8%" class="tablehead">SpCode</td>
          <td width="14%" class="tablehead">Detail</td>
          <td width="15%" class="tablehead">Select </td>
            <!--  ALL <input name="putAll" type="checkbox" onClick="CheckAll('form1','putAll');CheckAll('form1','putAll2');CheckAll('form1','checkput2')"> -->
            
          
        </tr>
        <%

	for(int i=0;i<aCrewSkjAL.size();i++)
	{
		CrewSkjObj obj =(CrewSkjObj) aCrewSkjAL.get(i);		
			if (i%2 == 0){
				bcolor = "bgLBlue";
			}else{
				bcolor = "";
			}
			if("SUN".equals(obj.getDayOfWeek()) || "SAT".equals(obj.getDayOfWeek())){
				//週末
				bcolor="bgLPink";
			}
			
%>
        <tr class="<%=bcolor%>">
          <td class="tablebody"><%=obj.getFdate()+" ( "+obj.getDayOfWeek()+" ) "%></td>
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
	resthr = "一曆日";			
}
%>
          <td class="tablebody">&nbsp;<%=resthr%></td>
          <td class="tablebody">&nbsp;<%=obj.getSpCode()%></td>
          <td class="tablebody">
		  <%
		  if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
		  %>
		 <a href="#" onClick="subwinXY('../../swapkhh/tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" >
				<img height="16" src="../../images/blue_view.gif" width="16" border="0"></a>
		<%
		}else{out.print("&nbsp;");}
		%>				
		  </td>
          <td width="18%" class="tablebody">
            <div align="center">&nbsp;
		  <%
		  if(!"B1".equals(obj.getDutycode()) && !"EE".equals(obj.getDutycode()) 
			&& !"MT".equals(obj.getDutycode()) && !"CT".equals(obj.getDutycode()) &&
			!"FT".equals(obj.getDutycode()) && !"B2".equals(obj.getDutycode()) &&
			!"GS".equals(obj.getDutycode()) && !"BL".equals(obj.getDutycode()) 
			&& ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) | "XL".equals(obj.getDutycode()) | "LVE".equals(obj.getDutycode()))) ) ){
		 
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
    <span class="txtblue"><b>Substitute</b></span><br>
                <span class="txtblue">
				<%=rCname%> 
					<%=rCrewInfoObj.getEmpno()%> 
					<%=rCrewInfoObj.getSern()%> 
					<%=rCrewInfoObj.getOccu()%> <%=rCrewInfoObj.getBase()%> 
					CR:<%=rCrewInfoObj.getPrjcr()%></span>
				</span>
              <table width="65%" border="1" cellspacing="1" cellpadding="1" style="border-collapse:collapse; ">
       <tr  class="bgPurple center" >
          <td width="28%" class="tablehead">FltDate</td>
          <td width="13%" class="tablehead">Fltno</td>
          <td width="13%" class="tablehead">CR</td>
          <td width="8%" class="tablehead">RestHr</td>
          <td width="8%" class="tablehead">SpCode</td>
          <td width="14%" class="tablehead">Detail</td>
          <td width="15%" class="tablehead">Select </td>
                      <!--  ALL <input name="putAll" type="checkbox" onClick="CheckAll('form1','putAll');CheckAll('form1','putAll2');CheckAll('form1','checkput2')"> -->
                  
                </tr>
        <%
	for(int i=0;i<rCrewSkjAL.size();i++)
	{
		CrewSkjObj obj = (CrewSkjObj)rCrewSkjAL.get(i);		
			if (i%2 == 0){
				bcolor = "bgLBlue";
			}else{
				bcolor = "";
			}
			if("SUN".equals(obj.getDayOfWeek()) || "SAT".equals(obj.getDayOfWeek())){
				//週末
				bcolor="bgLPink";
			}
%>
        <tr class="<%=bcolor%>">
          <td class="tablebody"><%=obj.getFdate()+" ( "+obj.getDayOfWeek()+" ) "%></td>
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
	resthr = "一曆日";			
}
%>
          <td class="tablebody">&nbsp;<%=resthr%></td>
          <td class="tablebody">&nbsp;<%=obj.getSpCode()%></td>
          <td class="tablebody">
		  <%
		  if("FLY".equals(obj.getCd()) | "TVL".equals(obj.getCd())){
		  %>
		 <a href="#" onClick="subwinXY('../../swapkhh/tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" >
				<img height="16" src="../../images/blue_view.gif" width="16" border="0"></a>
		<%
		}else{out.print("&nbsp;");}
		%>				
		  </td>
          <td width="18%" class="tablebody">
			<div align="center">&nbsp;
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
		  %>          
		    </div>
		  </td>
        </tr>
     <%
		}
	%>
    </table>
	<br>
	<table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>          
              <div align="left">
              
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
            <span class="txtxred">註：跨月班次之飛時，僅計算至當月底.</span>            <br>
            </p>          
          </td>
      </tr>
    </table>
    </div>          
        
  <p align="center"> 
	<input type="hidden" name="year"  value="<%=year%>">
	<input type="hidden" name="month" value="<%=month%>">
 	<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
	<input type="hidden" name="rEmpno" value="<%=rEmpno%>">
 	<input type="hidden" name="asno" value="<%=asno%>">
    <input type="Submit" name="Submit" value="送出任務互換資訊" class="buttonLPink">
  </form>
<%
}
%>  
</body>
</html>
<%
}
%>