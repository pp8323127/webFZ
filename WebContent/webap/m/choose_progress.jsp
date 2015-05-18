<%@page import="credit.SkjPickBidObj"%>
<%@page import="credit.SkjPickObj"%>
<%@page import="credit.SkjPickList"%>
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
	FZCrewObj uObj = lObj.getFzCrewObj();
	
	CrewPickFun cpf = new CrewPickFun();
    cpf.PocessPickQuery();
    CrewPickProcessRObj rObjAL = cpf.getProcPickObjAL();
    if("1".equals(rObjAL.getResultMsg())){
	    ArrayList objAL = rObjAL.getBidAL();
		
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
        $(document).ready(function () {
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

<div id="choose_progress" data-role="page">
<!-- Header bar Start -->
	<div data-role="header" data-position="fixed">
		<table id="header-bar">
			<tr>
				<td id="header-bar-btnBak">
					<a data-rel="back"><div id="naviBar_icon_Back"></div></a>
				</td>
				<td id="header-bar-btnAppname">選班處理進度(含退/改選班)</td>
				<td id="header-bar-btnMenu">
					<a id="btn_menu" href="#navbar"><div id="navi_icon_menu"></div></a>
				</td>
			</tr>
		</table>
	</div>
<!-- Header bar End -->

<!-- 處理進度查詢 Start-->

	<div role="main" class="ui-content">
		<table id="choose-prog-t">
			<tr>
				<th colspan="2">更新時間 </th>
			</tr>
		<%
		String tempbgcolor = "";
		if(null != objAL && objAL.size() >0){ 
			for(int i=0;i<objAL.size();i++){
				if(i%2==0){
					tempbgcolor = "";
				}else{
					tempbgcolor = "tr_bg";
				}
				SkjPickBidObj obj = (SkjPickBidObj) objAL.get(i);
				if(null != obj.getHandle_date() && !"".equals(obj.getHandle_date())){
					
		%>
			<tr class=<%=tempbgcolor%>>
				<td><%=obj.getBid_num() %></td>
				<td>
					<div class="td_line">No.<%=obj.getSno()%> <%=obj.getCname() %><%=obj.getEmpno()%>(<%=obj.getSern() %>)
					<br>已處理<%=obj.getHandle_date()%>	
					</div>
				</td>
			</tr>
		<%					
				}else{
		%>
			<tr class=<%=tempbgcolor%>>
				<td><%=obj.getBid_num() %></td>
				<td>
					<div class="td_line">No.<%=obj.getSno()%> <%=obj.getCname() %><%=obj.getEmpno()%>(<%=obj.getSern() %>)</div>
				</td>
			</tr>
		<%	
				}//if(null != obj.getHandle_date() && !"".equals(obj.getHandle_date())){
			}//for(int i=0;i<objAL.size();i++){
		}//if(null != objAL && objAL.size() >0){
		%>
		</table>

	</div>

<!-- 處理進度查詢 End -->

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