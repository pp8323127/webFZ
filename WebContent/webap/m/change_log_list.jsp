<%@page import="java.util.ArrayList"%>
<%@page import="fzAuthP.FZCrewObj"%>
<%@page import="ws.crew.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
try{
LoginAppBObj lObj= (LoginAppBObj) session.getAttribute("loginAppBobj");
if(lObj == null ) {
	out.println("請登入");
	response.sendRedirect("login.jsp");
}else{  
	String year = (String)request.getParameter("myDate");
	if(null!=year && !"".equals(year) && year.length() > 4){
		year = year.substring(0,year.length()-1);
	}
	FZCrewObj uObj = lObj.getFzCrewObj();
	
	CrewSwapFun csf = new CrewSwapFun();
    csf.SwapRdList(year, uObj.getEmpno(), uObj.getBase());
    SwapRdRObj rObjAL = csf.getSwapRdObjAL(); 
    if("1".equals(rObjAL.getResultMsg())){
	    ArrayList objAL = rObjAL.getSwapRdObjAL();
		ArrayList objAL2 = rObjAL.getRealSwapRdObjAL();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>iCrew</title>
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />	
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />	
	<link rel="stylesheet" href="jQueryMob/CSS.css">
	<script src="jQueryMob/jquery.js" language="javascript"></script>	
	<script src="jQueryMob/jquery.mobile.custom.js" language="javascript"></script>
    <script type="text/javascript">
	    $(document).ready(function() {
	        $("#btn_menu").click(function(e){
	            $.ajax({
	                type: "POST",
	                url: "navbar.jsp",
	                success:function(data){
	                    //alert(data);
	                    $("#right-list li").remove();
	                    $("#right-list").append(data).listview("refresh");
	                },
	                error:function(xhr, ajaxOptions, thrownError){
	                    console.log(xhr.status);
	                    console.log(thrownError);
	                    alert("Error");
	                }
	            });
	            e.preventDefault();
	        });
	    });
    </script>

</head>
<body>

<div id="change_log_list" data-role="page">
<!-- Header bar Start -->
	<div data-role="header" data-position="fixed">
		<table id="header-bar">
			<tr>
				<td id="header-bar-btnBak">
					<a data-rel="back"><div id="naviBar_icon_Back"></div></a>
				</td>
				<td id="header-bar-btnAppname">換班紀錄查詢</td>
				<td id="header-bar-btnMenu">
					<a id="btn_menu" href="#navbar"><div id="navi_icon_menu"></div></a>
				</td>
			</tr>
		</table>
	</div>
<!-- Header bar End -->

<!-- 換班紀錄查詢 Start-->
	<div role="main" class="ui-content">
		<ul data-role="listview" id="log_listview">
			<%
			if(null != objAL && objAL.size()>0){
			%>
			<li data-role="list-divider">
				<p><%=year %>年</p>
				<p>電子換班紀錄</p>
			</li>
			<%	for(int i=0;i<objAL.size();i++){
					SwapRdObj obj = (SwapRdObj)objAL.get(i);
					if(null!=obj.getFormnoAL()){
			%>
			<li><a href="change_log_result.jsp?type=A&formno=<%=obj.getFormnoAL() %>" class="ui-btn ui-nodisc-icon ui-btn-icon-right ui-icon-list_btn_arrow_right_gray" data-ajax="false">
					<p><%=obj.getFormnoAL() %></p>
					<p><%=obj.getaCnameAL() %>-<%=obj.getrCnameAL() %></p>
					<!-- 
					<input type="hidden" name="formno" value="<%=obj.getFormnoAL() %>">					
					<input type="hidden" name="FormType" value="<%=obj.getFormtypeAL()%>">
					<input type="hidden" name="bAEmpno" value="<%=obj.getaEmpnoAL() %>">
					<input type="hidden" name="bREmpno" value="<%=obj.getrEmpnoAL() %>">
					<input type="hidden" name="aName" value="<%=obj.getaCnameAL()%>">
					<input type="hidden" name="rName" value="<%=obj.getrCnameAL()%>">
					<input type="hidden" name="comm" value="<%=obj.getCommentsAL()%>">
					<input type="hidden" name="chkDate" value="<%=obj.getCheckDateAL()%>">
					<input type="hidden" name="chgAll" value="<%=obj.getChgAllAL()%>">
					<input type="hidden" name="newDate" value="<%=obj.getNewDateAL()%>">
					 -->
				</a>
			</li>
			<% 
					}//if(null!=obj.getFormnoAL()){
				}//for(int i=0;i<objAL.size();i++){
			}//if(null != objAL && objAL.size()>0)
			else{
			%>
			<li data-role="list-divider">
				<p><%=year %>年</p>
				<p>無電子換班紀錄</p>
			</li>
			<%
			}
			%>
		</ul>
	
		<div id="log_list_ask">
			<p>相同申請單，請勿重複遞單</p>
			<p>A開頭單號為三次換班申請單</p>
			<p>B開頭單號為積點換班申請單</p>
		</div>
		<%
		if(null != objAL2 && objAL2.size()>0){
		%>
		<ul data-role="listview" id="log_listview">
		<li data-role="list-divider">
				<p><%=year %>年</p>
				<p>實體換班紀錄</p>
			</li>
		<%	for(int i=0;i<objAL2.size();i++){
				RealSwapRdObj obj = (RealSwapRdObj)objAL.get(i);
				if(null!= obj.getFormno() && !"".equals(obj.getFormno())){
		%>	
			<li><a href="change_log_result.jsp?type=B" class="ui-btn ui-nodisc-icon ui-btn-icon-right ui-icon-list_btn_arrow_right_gray" data-ajax="false">
					<p><%=obj.getFormno() %></p>
					<p><%=obj.getAEmpno() %>-<%=obj.getRComm() %></p>
					<!-- 
					<input type="hidden" name="formno" value="<%=obj.getFormno() %>">
					<input type="hidden" name="aEmpno" value="<%=obj.getAEmpno() %>">
					<input type="hidden" name="rEmpno" value="<%=obj.getRComm() %>">
					<input type="hidden" name="aComm" value="<%=obj.getAComm()%>">
					<input type="hidden" name="aCount" value="<%=obj.getACount()%>">
					<input type="hidden" name="rComm" value="<%=obj.getRComm()%>">
					<input type="hidden" name="rCount" value="<%=obj.getRCount()%>">
					<input type="hidden" name="year" value="<%=obj.getYear()%>">
					<input type="hidden" name="month" value="<%=obj.getMonth()%>">
					<input type="hidden" name="chgDate" value="<%=obj.getChgDate()%>">
					<input type="hidden" name="chgUser" value="<%=obj.getChgUser()%>">
					 -->
				</a>
			</li>
		<% 
				}//if(null!= obj.getFormno()){
			}//for(int i=0;i<objAL2.size();i++){
		}//if(null != objAL2 && objAL2.size()>0){
		%>
		</ul>
	</div>
<!-- 換班紀錄查詢 End-->

<!-- navbar Slide Panel -->
    <div id="navbar" data-role="panel" data-position="right" data-position-fixed="false" data-display="overlay" data-theme="b">
        <ul id="right-list" data-role="listview" data-inset="true" data-icon="false">
        </ul>
    </div>
<!-- navbar Slide Panel -->

</div>


</body>
</html>
<%
    }else{
    	out.println(rObjAL.getResultMsg());
    }
}
}catch(Exception e){
	out.println(e.toString());
}
%>