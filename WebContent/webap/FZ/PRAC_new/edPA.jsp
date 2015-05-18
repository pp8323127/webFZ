<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null)
{
	response.sendRedirect("../sendredirect.jsp");
}
else
{
String fltd = null;
if( !"".equals(request.getParameter("fltd")) && null != request.getParameter("fltd"))
{
	 fltd = request.getParameter("fltd");
}

String fltno = null;
if( !"".equals(request.getParameter("fltno")) && null != request.getParameter("fltno"))
{
	fltno = request.getParameter("fltno");
}
String sect = null;
if( !"".equals(request.getParameter("sect")) && null != request.getParameter("sect"))
{
	sect = request.getParameter("sect");
}
String empno= null;
if( !"".equals(request.getParameter("empno")) && null != request.getParameter("empno"))
{
	empno =  request.getParameter("empno");
}
String cname = "";

boolean status = false;
String errMsg = "";

//取得基本資料  
fzac.CrewInfo c = new fzac.CrewInfo(empno);
fzac.CrewInfoObj o = c.getCrewInfo();

if (c.isHasData()) 
{
	cname=o.getCname();
}


//取得PA考評項目、敘述
fz.pracP.pa.EvaluationType evalType = new fz.pracP.pa.EvaluationType();
ArrayList evalTypeAL = evalType.getDataAL();
status = true;

//取得PA考評資料
fz.pracP.pa.PACrewEvalData paData = new fz.pracP.pa.PACrewEvalData(fltd,fltno,sect,empno);
ArrayList evalScoreDataAL = null;
try
{
	paData.SelectData();
	evalScoreDataAL = paData.getDataAL();
	status = true;	
}
catch(Exception e)
{
	status = false;
	errMsg = e.toString();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>PA Crew Evaluation Score</title>
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="ZC/style.css">
<link rel="stylesheet" type="text/css" href="../kbd.css">
<script language="javascript" type="text/javascript">
function disableButton()
{
		document.getElementById("exitButton").disabled=1;
		document.getElementById("resetButton").disabled=1;
		if(document.getElementById("delButton") != null){
			document.getElementById("delButton").disabled=1;
		}
		document.getElementById("SaveButton").disabled=1;			
}
function goDel()
{
	if(confirm("確定要刪除此筆資料？"))
	{
		document.form1.action="delPA.jsp";
		document.form1.submit();
		disableButton();
		return true;
	}
	else
	{
		return false;
	}	
}

function getComm(s1,s2)
{
	var getcomm = "";
	for(var i=1; i<=parseInt(s1); i++)
	{
		if(eval("document.form1."+s2+"t"+i+".checked") == true)
		{
		    getcomm = getcomm + eval("document.form1."+s2+"t"+i+".value");
		}
	}
	getcomm = eval("document.form1."+s2+".value") + getcomm;
	eval("document.getElementById('"+s2+"').value = '"+getcomm+"'");
}

</script>
</head>

<body class="center">

<%
if(!status)
{
%>
<div class="errStyle1"><%=errMsg%></div>
<%
}
else
{
	if(evalTypeAL != null)
	{
%>
<div class="blue"><span style="font-size:large;font-weight:bold; " >PA Crew Evaluation Score</span><br>
<%=fltd%> <%=fltno%> / <%=sect%> <%=empno%> <%=cname%></div>
<div align="left">
<UL>
 <li><span class="r">Comments需按欲表達意思，邏輯點選；再按套用，俾字串組合。</span>   
 <li><span class="r">制式評語，可複選；或自行輸入於欄位內。</span>
 <li><span class="r">3分以下，9分以上必需填寫評語。</span>
 <li><span class="r">請公正評分；本資料庫可隨時查考歷史資料，以為佐證。</span>  
</UL>
</div>

<form name="form1" action="updPA.jsp" method="post" onSubmit="return checkForm()">
<table width="95%" cellpadding="0" cellspacing="2" class="tableBorder1">
	<tr class="tableInner3">
    <td width="15%">Evaluation Item</td>
    <td width="10%">Score<br>
      (1~10)</td>
	<td width="45%">Comments</td>	
	</tr>
<%
for(int i=0;i<evalTypeAL.size();i++)
{
	fz.pracP.pa.EvaluationTypeObj evalObj = (fz.pracP.pa.EvaluationTypeObj)evalTypeAL.get(i);
	String classType = "";
	if(i%2 == 0)
	{
		classType ="";
	}
	else
	{
		classType = "class='tableInner2'";
	}
%>
<tr <%=classType%>>
	<td><%= evalObj.getScoreDesc()%></td>
	<td>
	<select name="score<%=evalObj.getScoreType()%>" id="score<%=evalObj.getScoreType()%>" >
	<option value="">請選擇</option>
	<%
	if("1".equals(evalObj.getScoreType()))
	{
	    String[] dutySelItem = {"Z1","1L","1LA","1R","Z2","2L","2R","UDZ","UDR","UDL","UDA","Z3","3L","3R","3LA","3RA","4LA","4RA","4L","4R","5L","5R"};

		for(int j=0;j<dutySelItem.length;j++)
		{
			out.print("<option value=\""+dutySelItem[j]+"\">"+dutySelItem[j]+"</option>");
		}
	}
	else
	{
		for( int sel=10;sel>0;sel--)
		{
			out.print("<option value=\""+sel+"\">"+sel+"</option>");
		}
	}
	%>
	</select>
	</td>
	<td class="left"><input name="comm<%=evalObj.getScoreType()%>" id="comm<%=evalObj.getScoreType()%>" type="text" size="60" maxlength="100">
	<br>
<%
	if("2".equals(evalObj.getScoreType()))
	{
%>
    <fieldset style="text-align:left;">
	<legend class="txtblue">制式評語</legend>
	<input name="comm<%=evalObj.getScoreType()%>t1" id="comm<%=evalObj.getScoreType()%>t1" type="checkbox" value="中文">中文
	<input name="comm<%=evalObj.getScoreType()%>t2" id="comm<%=evalObj.getScoreType()%>t2" type="checkbox" value="英文">英文
	<input name="comm<%=evalObj.getScoreType()%>t3" id="comm<%=evalObj.getScoreType()%>t3" type="checkbox" value="台語">台語
	<input name="comm<%=evalObj.getScoreType()%>t4" id="comm<%=evalObj.getScoreType()%>t4" type="checkbox" value="清晰">清晰
	<input name="comm<%=evalObj.getScoreType()%>t5" id="comm<%=evalObj.getScoreType()%>t5" type="checkbox" value="須加強">須加強
	<input type="button" name="b1" id="b1" onclick="getComm('5','comm<%=evalObj.getScoreType()%>')" value="套用">
	</fieldset>
<%
    }
	else if("3".equals(evalObj.getScoreType()))
	{
%>
    <fieldset style="text-align:left;">
	<legend class="txtblue">制式評語</legend>
	<input name="comm<%=evalObj.getScoreType()%>t1" id="comm<%=evalObj.getScoreType()%>t1" type="checkbox" value="重點訊息表達">重點訊息表達
	<input name="comm<%=evalObj.getScoreType()%>t2" id="comm<%=evalObj.getScoreType()%>t2" type="checkbox" value="善用Falling Pitch">善用Falling Pitch
	<input name="comm<%=evalObj.getScoreType()%>t3" id="comm<%=evalObj.getScoreType()%>t3" type="checkbox" value="未表達重點">未表達重點
	<input name="comm<%=evalObj.getScoreType()%>t4" id="comm<%=evalObj.getScoreType()%>t4" type="checkbox" value="未善用Falling Pitch ">未善用Falling Pitch 
	<input name="comm<%=evalObj.getScoreType()%>t5" id="comm<%=evalObj.getScoreType()%>t5" type="checkbox" value="語氣太重">語氣太重
	<input type="button" name="b1" id="b1" onclick="getComm('5','comm<%=evalObj.getScoreType()%>')" value="套用">
	</fieldset>
<%
    }
	else if("4".equals(evalObj.getScoreType()))
	{
%>
    <fieldset style="text-align:left;">
	<legend class="txtblue">制式評語</legend>
	<input name="comm<%=evalObj.getScoreType()%>t1" id="comm<%=evalObj.getScoreType()%>t1" type="checkbox" value="流利">流利
	<input name="comm<%=evalObj.getScoreType()%>t2" id="comm<%=evalObj.getScoreType()%>t2" type="checkbox" value="自然">自然
	<input name="comm<%=evalObj.getScoreType()%>t3" id="comm<%=evalObj.getScoreType()%>t3" type="checkbox" value="不急不徐">不急不徐
	<input name="comm<%=evalObj.getScoreType()%>t4" id="comm<%=evalObj.getScoreType()%>t4" type="checkbox" value="稍快">稍快
	<input name="comm<%=evalObj.getScoreType()%>t5" id="comm<%=evalObj.getScoreType()%>t5" type="checkbox" value="熟悉度不足">熟悉度不足
	<input type="button" name="b1" id="b1" onclick="getComm('5','comm<%=evalObj.getScoreType()%>')" value="套用">
	</fieldset>
<%
    }
	else if("5".equals(evalObj.getScoreType()))
	{
%>
    <fieldset style="text-align:left;">
	<legend class="txtblue">制式評語</legend>
	<input name="comm<%=evalObj.getScoreType()%>t1" id="comm<%=evalObj.getScoreType()%>t1" type="checkbox" value="按廣播內容正確表達情感">按廣播內容正確表達情感
	<input name="comm<%=evalObj.getScoreType()%>t2" id="comm<%=evalObj.getScoreType()%>t2" type="checkbox" value="音量剛好">音量剛好
	<input name="comm<%=evalObj.getScoreType()%>t3" id="comm<%=evalObj.getScoreType()%>t3" type="checkbox" value="Mike 技巧不好">Mic 技巧不好
	<input name="comm<%=evalObj.getScoreType()%>t4" id="comm<%=evalObj.getScoreType()%>t4" type="checkbox" value="音量太小">音量太小
    <input name="comm<%=evalObj.getScoreType()%>t5" id="comm<%=evalObj.getScoreType()%>t5" type="checkbox" value="聲音未開">聲音未開
	<input type="button" name="b1" id="b1" onclick="getComm('5','comm<%=evalObj.getScoreType()%>')" value="套用">
	</fieldset>
<%
    }
	else if("6".equals(evalObj.getScoreType()))
	{
%>
    <fieldset style="text-align:left;">
	<legend class="txtblue">制式評語</legend>
	<input name="comm<%=evalObj.getScoreType()%>t1" id="comm<%=evalObj.getScoreType()%>t1" type="checkbox" value="誠懇">誠懇
	<input name="comm<%=evalObj.getScoreType()%>t2" id="comm<%=evalObj.getScoreType()%>t2" type="checkbox" value="用心">用心
	<input name="comm<%=evalObj.getScoreType()%>t3" id="comm<%=evalObj.getScoreType()%>t3" type="checkbox" value="Individual Attention">Individual Attention
	<input name="comm<%=evalObj.getScoreType()%>t4" id="comm<%=evalObj.getScoreType()%>t4" type="checkbox" value="機械性">機械性
	<input name="comm<%=evalObj.getScoreType()%>t5" id="comm<%=evalObj.getScoreType()%>t5" type="checkbox" value="情感不足">情感不足
	<input type="button" name="b1" id="b1" onclick="getComm('5','comm<%=evalObj.getScoreType()%>')" value="套用">
	</fieldset>
<%
	}
%>
	</td>
</tr>

<%

}

%>	
<tr>
  <td colspan="3">
<input type="submit" name="SaveButton" id="SaveButton" value="Save (儲存)" class="kbd">
&nbsp;&nbsp;&nbsp;
<%
if(evalScoreDataAL != null)
{
	fz.pracP.pa.PACrewEvalObj obj = (fz.pracP.pa.PACrewEvalObj)evalScoreDataAL.get(0);
	
%>
<input name="resetButton" type="button" class="kbd" id="resetButton" onClick="initData()" value="Reset (清除重寫)">
&nbsp;&nbsp;&nbsp;
<input name="delButton" type="button" class="kbd" id="delButton"  onClick="return goDel()" value="Delete (刪除)">  
&nbsp;&nbsp;&nbsp;
<input type="hidden" name="seqno" value="<%=obj.getSeqno()%>">
<%
}
else
{
%>
<input type="reset" class="kbd" id="resetButton" value="Reset (清除重寫)">
&nbsp;&nbsp;&nbsp;
<input type="hidden" name="seqno" value="">
<%
}
%>
<input name="exitButton" type="button" class="kbd" id="exitButton"  onClick="javascript:self.close()" value="Exit (離開)">  

<input type="hidden" name="fltd" value="<%=fltd%>">
<input type="hidden" name="fltno" value="<%=fltno%>">
<input type="hidden" name="sect" value="<%=sect%>">
<input type="hidden" name="empno" value="<%=empno%>">

  </td>
</tr>
<tr class="r">
  <td colspan="3" class="left">*各項考評分數均需填寫，不得空白.<!--<br>
    *各考評項目詳細說明，可將滑鼠移至<img src="../images/qa2.gif"  width="22" height="22" style="vertical-align:text-top; " > 圖示檢視.--></td>
</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
function checkForm()
{
<%
for(int i=0;i<evalTypeAL.size();i++)
{
	fz.pracP.pa.EvaluationTypeObj evalJSObj = (fz.pracP.pa.EvaluationTypeObj)evalTypeAL.get(i);
		
%>
	if(document.getElementById("score<%=evalJSObj.getScoreType()%>").value =="")
	{
		alert("請選擇 [<%=evalJSObj.getScoreDesc()%>] 項目的分數");
		document.getElementById("score<%=evalJSObj.getScoreType()%>").focus();
		return false;
	}
<%
}

for(int i=1;i<evalTypeAL.size();i++)
{
	fz.pracP.pa.EvaluationTypeObj evalJSObj = (fz.pracP.pa.EvaluationTypeObj)evalTypeAL.get(i);		
%>
	if((parseInt(document.getElementById("score<%=evalJSObj.getScoreType()%>").value) <=3 || parseInt(document.getElementById("score<%=evalJSObj.getScoreType()%>").value) >=9) && document.getElementById("comm<%=evalJSObj.getScoreType()%>").value == "" )
	{
		alert("請填寫 [<%=evalJSObj.getScoreDesc()%>] 項目的Comments");
		document.getElementById("comm<%=evalJSObj.getScoreType()%>").focus();
		return false;
	}
<%
}

%>			
	disableButton();

	return true;
}
</script>
<%
if(evalScoreDataAL != null)
{
%>
<script language="javascript" type="text/javascript">
	function initData()
	{
	<%
		for(int index = 0;index < evalScoreDataAL.size(); index ++)
		{
			fz.pracP.pa.PACrewEvalObj obj = (fz.pracP.pa.PACrewEvalObj) evalScoreDataAL.get(index);
			
	%>
			document.getElementById("score<%=obj.getScoreType()%>").value = "<%=obj.getScore()%>";
			document.getElementById("score<%=obj.getScoreType()%>")[document.getElementById("score<%=obj.getScoreType()%>").selectedIndex].style.color = "#FF0000";
			document.getElementById("comm<%=obj.getScoreType()%>").value = "<%=obj.getComm()%>";
	<%	
		}
	%>										
	}
	initData();
</script>

<%
} //end of has Eval Data and initial it.

	}//end of evalTypeAL != null
	else
	{
%>
<div class="errStyle1">資料庫連線失敗，請稍後再試.</div>
<%	
	}
}//end of status = true;
%>
</body>
</html>
<%
}
%>