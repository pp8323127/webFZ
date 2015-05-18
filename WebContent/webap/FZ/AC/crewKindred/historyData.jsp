<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,fzac.crewkindred.*,java.text.*"%>
<%
String userid  = (String)session.getAttribute("cs55.usr");

String errMsg = "";
boolean  status = true;
String year = request.getParameter("year");
String month = request.getParameter("month");
String empno = request.getParameter("empno");
if("".equals(empno)){
	empno = null;
}
String selAll = request.getParameter("selAll");//顯示全部
String selDeleted = request.getParameter("selDeleted");//包含已刪除
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm",Locale.TAIWAN);


DataMaintain dm = new DataMaintain();
ArrayList dataAL = null;
if(userid == null){
	status = false;
	errMsg = "網頁已過期,請重新登入";

}else{
	
	
	try {
			dm.setYear(year);	
			dm.setMonth(month);
			dm.setEmpno(empno);
			if("Y".equals(selDeleted)){
				dm.setSelectDeletedData(true);
			}
			if("Y".equals(selAll)){
				dm.setSelectCrewAllData(true);
			}
			dm.SelectHistoryData();
			
			dataAL = dm.getDataAL();
		if (dataAL == null) {
			status = false;
			errMsg = "查無符合的資料";
		} else {
			
			status = true;
		}
	
	} catch (Exception e) {
		status = false;
		errMsg = "ERROR:"+e.getMessage();
	}	
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>歷史紀錄</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">

</head>

<body>
<%
if(!status){

%>
<div class="paddingTopBottom bgLYellow red center"><%=errMsg%></div>
<%

}else{

%>



<fieldset style="width:600pt; ">
  <legend class="blue"><img src="../../images/format-justify-fill.png" width="16" height="16">組員家屬電話 歷史申請資料
  
</legend>
<table width="100%"  border="1" cellspacing="2" cellpadding="2" class="tableStyle1">
  <caption>&nbsp;
  </caption>
  <tr class="bgBlue2 center">
 	 <td width="11%">註記</td>
    <td width="14%">組員員工號</td>
    <td width="16%" height="24">家屬姓名</td>
    <td width="13%">家屬手機</td>
    <td width="18%">申請時間</td>
    <td width="18%">匯入時間</td>
    <td width="9%">匯入者</td>
	
  </tr>
  <%
	for(int i=0;i<dataAL.size();i++){
		CrewKindredObj  obj = (CrewKindredObj)dataAL.get(i);
%>
  <tr class="left<%if(i%2==1){%> bgLGray<%}%>">
   <td class="center">
   <%if(null ==obj.getDelete_ind()){
	%>
	  <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="center" alt="申請刪除" title="申請刪除">
	<%	}	else if("Y".equals( obj.getDelete_ind())){%>
  <img src="../../images/delete_gray.gif" width="16" height="16" align="top" class="center" alt="申請取消" title="申請取消">
    <%}else if("Y".equals( obj.getExport_ind())){
	%>
	  <img src="../../images/accept.png" width="16" height="16" align="top" class="center" alt="資料已匯入" title="資料已匯入">
	<%
	}%>
   </td>
    <td class="center"><%=obj.getEmpno()%></td>
    <td><%=obj.getKindred_surName()+"&nbsp;"+obj.getKindred_First_Name()%></td>
    <td class="center"><%=obj.getKinddred_Phone_Num()%></td>
    <td><%=formatter.format(obj.getApply_time())%></td>
  <td><%if(obj.getExport_time() != null){out.print(formatter.format(obj.getExport_time()));}%></td>
    <td class="center"><%=obj.getExport_Empno()%></td>
	
  </tr>
  <%
}
%>
<tr >
  <td colspan="7" class="bgLGray left">
    <p><img src="../../images/accept.png" width="16" height="16" align="top">：申請新增 / 修改此筆聯絡人資訊<br>
        <%if("Y".equals(selDeleted)){%><img src="../../images/delete_gray.gif" width="16" height="16" align="top">：在資料轉入前，組員已自行取消此申請<br><%}%>
        <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" >：申請刪除已生效之聯絡人資訊</p>
    <div class="center"> 
	      <input type="button" class="kbd" onClick="self.location.href='historyQuery.jsp';" value=" 重 新 查 詢 ">
    </div></td>
  </tr>
   

</table>
</fieldset>
<%
}
%>
</body>
</html>
