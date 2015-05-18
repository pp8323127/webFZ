<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,ci.db.*,da.PTPC.*,java.util.*"%>
<%

String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");
String peak = request.getParameter("peak");
String checkType = request.getParameter("checkType");

RetrieveData rd = new RetrieveData(fleet,rank);
ArrayList al = new ArrayList();
if("PC".equals(checkType)){
	al = rd.jobPCRank();
	session.setAttribute("trnRecordPC",al);
}else{
	al = rd.jobPTRank();
	session.setAttribute("trnRecordPT",al);
}




//各月份的人數
int[] index = rd.getRankCount(al);

for(int i=0;i<index.length;i++){
	if(i!= 0){
		index[i] = index[i]+index[i-1];
	}
	//out.print("index["+i+"] = "+index[i]+"&nbsp;");
}


//機隊總人數
NumberOfFleet nf = new NumberOfFleet();
int total = Integer.parseInt(nf.getCount(fleet, rank));

//預估受訓人數
ExpOfTrn ep = new ExpOfTrn(peak, total);
int expect = ep.getExp();


if(al.size() ==0)	
	out.print("No DATA!!");
else{	

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title><%=checkType%> </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="checkDel.js" language="javascript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

/** 點選「全選」button後，將該月份全部選取，
 *  且button變成「取消」字樣，反之亦然
 *	因上下各有一個，所以需控制兩個button
 */
function checkRank(idx,checkAllName,idx2){
	var start;
	var end;
	eval("var colValue = document.form1.elements["+idx2+"].value;");
	if(colValue=="全選"){
		eval("document.form1.elements["+idx2+"].value='取消'");
		eval("document.form1.elements["+(idx2+<%=al.size()%>+6)+"].value='取消'");
	}
	else {
		eval("document.form1.elements["+idx2+"].value='全選'");
		eval("document.form1.elements["+(idx2+<%=al.size()%>+6)+"].value='全選'");
	}
	
	switch (idx){
		case 1:start = 6;
			end=(start+<%=index[0]%>);
			break;
		case 2: start = (6+<%=index[0]%>);
				end = (6+<%=index[1]%>);
			break;
		case 3: start = (6+<%=index[1]%>);
			end = (6+<%=index[2]%>);
			break;
		case 4: start = (6+<%=index[2]%>);
			end =  (6+<%=index[3]%>);
			break;
		case 5: start = (6+<%=index[3]%>);
			end =(6+ <%=index[4]%>);
			break;
		default:
			break;
	}
	//alert("start="+start+"\nend="+end);
	for (var i=start;i< (end);i++){
	   var e = document.form1.elements[i];
		if (e.name != checkAllName)
			  e.checked = !e.checked;
	 }


}

//網頁全部載入後，才enable 「全選」的button，預設為disabled
function enableButton(){

	for(var i=0;i<5;i++){
		document.form1.elements[i].disabled=0;
		document.form1.elements[i+<%=al.size()%>+6].disabled=0;
	}
	//若該月份無資料，則不enabled
	<%	for(int  j=0;j<5 ; j++){

		if((j!= 0 && index[j] == index[j-1] )|| (j==0 && index[j]==0)){
			out.print("document.form1.elements["+j+"].disabled=1;\r\n");
			out.print("document.form1.elements["+(j+al.size()+6)+"].disabled=1;\r\n");
		}	
	}
	%>
 
}

/**按「reset」時，將所有的「全選」button字樣回復成「全選」
 *避免button已經變成「取消」字樣而不同步
 */
function resetButton(){
	for(var i=0;i<5;i++){
		document.form1.elements[i].value="全選";
		document.form1.elements[i+<%=al.size()%>+6].value="全選";
	}
}

function 　substitute(){//選擇save buffer時，帶入參數傳下一頁
	var t = checkDel('form1','sel');
	document.form1.classes.value="sub";
	
	if(t){
		document.form1.submit();
	}
}

/**計算勾選的數目且顯示
 * 觸發事件：勾選全選或個別checkbox、點選「全選」及「取消」按鈕時
 */
function calc(){
	var count=0;
	for(var i=6;i<(<%=al.size()%>+6);i++){
	  var e = document.forms[0].elements[i];
		if(e.checked){
			count++;
		}
	}
	
	if(count > (<%=expect%>)){
		document.getElementById("showTotal").innerHTML="<span class=\"txtred\"><strong>"+count+"</strong></span>";	
	}else{
		document.getElementById("showTotal").innerHTML="<span class=\"txtblue\">"+count+"</span>";	
	}


}
</script>
</head>

<body onLoad="enableButton()">

<form name="form1" action="makeList.jsp" method="post" onsubmit="document.form1.classes.value='list';return checkDel('form1','sel');" onreset="resetButton();calc()">
<table width="70%"  border="0" cellpadding="1" cellspacing="1" align="center">
  <tr >
    <td>
      <div align="center" ><span class="txtred"><%=checkType%> 建議施訓名單</span></div>
    </td>
  </tr>
  <tr >
    <td> <span class="fonte_dblue2">Fleet:<span class="txtred"><strong><%=fleet%></strong></span> Rank:<span class="txtred"><strong><%=rank%></strong></span> </span>
	總人數：<span class="txtred"><%=total%> </span>&nbsp;
	季節：<span class="fonte_pink">	<%
	if("on".equals(peak)){out.print("&nbsp;旺季&nbsp;&nbsp;");}else{out.print("&nbsp;淡季&nbsp;&nbsp;");}
	%>
	</span>
    預估需受訓人數：<span class="txtred"><%=expect%></span>&nbsp;&nbsp;目前選擇人數：<span  id="showTotal">0</span></td>
  </tr>
  <tr >
    <td class="button4"><span class="txtblue">圖示：</span>
	<span style="color:#CCCCCC">■</span><span class="txtblue">間隔8月以上(
	<input type="button" value="全選"  name="b1" onClick="checkRank(1,'noSel',0);calc()" disabled>) 
	<span style="color:#FDFFCA">■</span>間隔7月(<input type="button" value="全選" name="b2" onClick="checkRank(2,'noSel',1);calc()" disabled>) 
	<span style="color:#FFCCCC">■</span>間隔6月(<input type="button" value="全選" name="b3" onClick="checkRank(3,'noSel',2);calc()" disabled>) 
	<span style="color:#CCFFFF">■</span>間隔5月(<input type="button" value="全選" name="b4" onClick="checkRank(4,'noSel',3);calc()" disabled>) 
	<span style="color:#FFFFFF">■</span>間隔4月(<input type="button" value="全選" name="b5" onClick="checkRank(5,'noSel',4);calc()" disabled>)</span>
	</td>
  </tr>
</table>
<table width="70%"  border="1" cellpadding="1" cellspacing="1" bordercolor="#CCCCCC" align="center">
  <tr class="tablehead4">
    <td width="10%">All
        <input type="checkbox" name="noSel" onClick="CheckAll('form1','noSel');calc()" id="noSel">
    </td>
    <td width="5%">
      <div align="center">Fleet</div>
    </td>
    <td width="7%">
      <div align="center">Rank</div>
    </td>
    <td width="10%">
      <div align="center">Empno</div>
    </td>
    <td width="15%">
      <div align="center">Name</div>
    </td>
    <td width="22%">EName</td>
    <td width="15%">
      <div align="center">Last_Date</div>
    </td>
    <td width="16%">
      <div align="center">
	  <%
	  if("PC".equals(checkType)){
	  	out.print("CheckType");
	   }else{
	   	out.print("Subject");
	   }
	  %>
	  
	  
	  </div>
    </td>
  </tr>
  <%
int rowCount = 1;
String bgColor="#CCCCCC";//灰色,距今八月以上

	for(int i=0;i<al.size();i++){
		
		CKPLObj ck= (CKPLObj)al.get(i);
				
		if(i == index[0]){
			bgColor="#FDFFCA";//7月
			rowCount = 1;
		}
		 if(i == index[1] ){
			bgColor="#FFCCCC";//6月
			rowCount = 1;
		}
		 if(i == index[2]){
			bgColor="#CCFFFF";//5月
			rowCount = 1;
		}
		if(i == index[3]){//4月
			bgColor="#FFFFFF";
			rowCount = 1;		
		}

%>
  <tr bgcolor="<%=bgColor%>">
    <td>
      <div align="right">

        <input type="checkbox" value="<%=i%>" name="sel" onClick="calc()">
        <%=rowCount%></div>
    </td>
    <td>
      <div align="center"><%=ck.getFleet() %></div>
    </td>
    <td>
      <div align="center"><%=ck.getRank() %></div>
    </td>
    <td>
      <div align="center"><%=ck.getEmpno()%></div>
    </td>
    <td>
      <div align="center"><%=ck.getCname()%></div>
    </td>
    <td><div align="left">&nbsp;<%=ck.getEname() %></div>
</td>
    <td>
      <div align="center"><%=ck.getDate() %></div>
    </td>
    <td>
      <div align="center">
	  <%
	  	if("PC".equals(checkType)){
		  out.print(ck.getChktype());
		 }else{
		 	out.print(ck.getSubject());
		 }
	  
	  %></div>
    </td>
  </tr>
  <%
rowCount ++;
}
%>
</table>
<table width="70%"  border="0" align="center" cellpadding="1" cellspacing="1">
  <tr >
    <td class="button4"><span class="txtblue">圖示：</span>
	<span style="color:#CCCCCC">■</span><span class="txtblue">間隔8月以上(
	<input type="button" value="全選"  name="b1" onClick="checkRank(1,'noSel',0);calc()" disabled>) 
	<span style="color:#FDFFCA">■</span>間隔7月(<input type="button" value="全選" name="b2" onClick="checkRank(2,'noSel',1);calc()" disabled>) 
	<span style="color:#FFCCCC">■</span>間隔6月(<input type="button" value="全選" name="b3" onClick="checkRank(3,'noSel',2);calc()" disabled>) 
	<span style="color:#CCFFFF">■</span>間隔5月(<input type="button" value="全選" name="b4" onClick="checkRank(4,'noSel',3);calc()" disabled>) 
	<span style="color:#FFFFFF">■</span>間隔4月(<input type="button" value="全選" name="b5" onClick="checkRank(5,'noSel',4);calc()" disabled>)</span>
	</td>
  </tr>

  <tr >
    <td height="38" colspan="7">
      <div align="center" >
        <input name="送出" type="submit" class="button4" value="Save List" >
&nbsp;&nbsp;
        <input type="button" class="button3" value="Save Buffer" onClick="substitute()">
&nbsp;&nbsp;
        <input name="重設" type="reset" class="button5" value="ReSelect" >
        <input type="hidden" name="sourcePage" value="<%=checkType%>">
        <input type="hidden" name="fleet" value="<%=fleet%>">
        <input type="hidden" name="rank" value="<%=rank%>">
        <input type="hidden" name="peak" value="<%=peak%>">
        <input type="hidden" name="classes" value="list">
      </div>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</form>

</body>
</html>
<%
}
%>