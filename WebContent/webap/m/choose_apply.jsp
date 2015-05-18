<%@page import="credit.CreditObj"%>
<%@page import="credit.FullAttendanceForPickSkjObj"%>
<%@page import="fzAuthP.FZCrewObj"%>
<%@page import="ws.crew.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
LoginAppBObj lObj= (LoginAppBObj) session.getAttribute("loginAppBobj");
if(lObj == null ) {
	out.println("請登入");
	response.sendRedirect("login.jsp");
}else{  
	FZCrewObj uObj = lObj.getFzCrewObj();
	/*全勤*/
	CrewPickFun cpf = new CrewPickFun();
	cpf.ChkPickAttInfo(uObj.getEmpno(),"","");
	CrewPickFullAttRObj aObjAL =cpf.getPickAttObjAL(); 
	FullAttendanceForPickSkjObj[] aObj = aObjAL.getCrewAttAr();
	/*積點*/
	cpf.ChkPickCtInfo(uObj.getEmpno(),"","");
	CrewPickCreditRObj cObjAL= cpf.getPickCtObjAL();
	CreditObj[]  cObj = cObjAL.getCrewCtAr();
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>iCrew</title>
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />	
	<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />	
	<link rel="stylesheet" href="jQueryMob/CSS.css">
	<script src="jQueryMob/jquery.js" language="javascript"></script>	
	<script src="jQueryMob/jquery.mobile.custom.js" language="javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
        	var count = 0;
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
         	 //submit
            $("#sub").click(function(e){
            	//var pointList = $("input:checkbox[name='point']:checked").val();            	
            	//var att = $('input:radio:checked[name="att"]').val();
            	var att = GetCheckedValue('att'); 
            	var pointList = GetCheckedValue('point');
            	var type = 0;
            	var sdate = "";
            	var edate = "";
            	var comment = "";
            
            	/*console.log(att);
            	console.log(pointList);
            	console.log(count);          	
            	//alert(pointList); 
            	console.log((att != "" || count == 3));    
            	console.log(!(att != "" && count >= 3));   
            	console.log(((att != "" || count == 3) && !(att != "" && count >= 3))); */
            	if((att != "" || count == 3) && !(att != "" && count >= 3)){
            		if(att !=""){
            			type = 1;
            			sdate = $("#start"+att).val();
            			edate = $("#final_end"+att).val();
            			comment = $("#comment"+att).val();
            		}else if(count == 3){
            			type = 2;
            		}
            		$.ajax({
	        			type: "POST",
	        			url: "chkChoose_apply.jsp",
	        			data: {type:type,att:att,pointList:pointList,sdate:sdate,edate:edate,comment:comment},
	        			success:function(data){	       
	        				$("#strMsg").html(data);
	        				$("#backData").val(data);
		        			$("#alert-popup-apply").popup("open");		        				
	        				//console.log(data);
	        			},
	        			error:function(xhr, ajaxOptions, thrownError){
	        				console.log(xhr.status);
	        				console.log(thrownError);
	        				$("#strMsg").html("Error");
	        				$("#backData").val("");
	        				$("#alert-popup-apply").popup("open");
	        			}
	        		});
	        		e.preventDefault();
            	}else{
            		$("#strMsg").html("請勾選:全勤選班單 or 三個積點換取選班機會 or 一個選班單");
            		$("#backData").val("");
            		$("#alert-popup-apply").popup("open");
            	}
            	
            	
        	});
         	 //confirm
			$("#popConf").click(function(e){
				var msg = $("#backData").val();
				//console.log(msg);
				//console.log(msg.indexOf("Successful"));
				//console.log(msg.match("Successful"));
				if(msg.indexOf("Successful") > -1){
					$("#popConf").attr("href","choose_main.html");
				}else{
					$("#alert-popup-apply").popup("close");	
				}
            	count = 0;
            });
            function GetCheckedValue(checkBoxName){                	
            	return $('input:checkbox:checked[name=' + checkBoxName + ']').map(function ()
            	{
            		if(checkBoxName == "point"){
	            		var countV = $("#count"+$(this).val()).val();        		
	            		if(countV == "其它選班單"){
	            			count = count +3 ;
	            		}else{
	            			count ++;
	            		}
            		}
            		return $(this).val();
            	}).get().join(',');
            };
            
        });
        
    </script>

</head>
<body>

<div id="choose_apply" data-role="page">
<!-- Header bar Start -->
	<div data-role="header" data-position="fixed">
		<table id="header-bar">
			<tr>
				<td id="header-bar-btnBak">
					<a data-rel="back"><div id="naviBar_icon_Back"></div></a>
				</td>
				<td id="header-bar-btnAppname">選班資格申請</td>
				<td id="header-bar-btnMenu">
					<a id="btn_menu" href="#navbar"><div id="navi_icon_menu"></div></a>
				</td>
			</tr>
		</table>
	</div>
<!-- Header bar End -->

<!-- 選班資格申請 Start-->
	<div role="main" class="ui-content">
	<% if(null != aObj && aObj.length > 0){%>
		<table id="choose-serv-t">
			<tr>
				<th colspan="3">全勤換班權利</th>
			</tr>
			<%for(int i=0;i<aObj.length;i++){%>
			<tr>
				<td>
				<input type="checkbox" name="att" id="att<%=i%>" value="<%=i%>">
				<input type="hidden" name="start"  id="start<%=i%>" value="<%=aObj[i].getCheck_range_start()%>">
				<input type="hidden" name="final_end"  id="final_end<%=i%>" value="<%=aObj[i].getCheck_range_final_end()%>">
				<input type="hidden" name="comment"  id="comment<%=i%>"" value="<%=aObj[i].getComments()%>">
				</td>
				<td><%=aObj[i].getCheck_range_start()%>~<%=aObj[i].getCheck_range_final_end() %></td>
				<td><a href="#alert-popup-info" data-rel="popup" data-transition="pop"><div id="list_icon_info_gray_20px"></div></a></td>
			</tr>
			<%}%>
		</table>
	<%}%>
	<% if(null != cObj && cObj.length > 0){%>	
		<table id="choose-serv-t" style="margin-top: 15px;">
			<tr>
				<th colspan="4">積點選班權利</th>
			</tr>
			<%for(int i=0;i<cObj.length;i++){%>
			<tr>
				<td><input type="hidden" name="count<%=cObj[i].getSno()%>"  id="count<%=cObj[i].getSno()%>" value="<%=cObj[i].getReason()%>">
				<input type="checkbox" name="point" id="point<%=i%>" value="<%=cObj[i].getSno()%>"></td>
				<td>#<%=(i+1)%>:<%=cObj[i].getReason() %></td>
				<td><%=cObj[i].getFormno() %></td>
				<td><a href="#alert-popup-info" data-rel="popup" data-transition="pop"><div id="list_icon_info_gray_20px"></div></a></td>
			</tr>
			<%} %>				
		</table>
	<%}%>
		<div id="btnApply" class="choose_btnApply">
			<a  id="sub" href="#" data-rel="popup" data-transition="pop" class="ui-btn ui-corner-all"><div>申請選班</div></a>
		</div>
	</div>
	
	<!-- 定義popup顯示位置 -->
	<div id="popupSite"></div>
<!-- 選班資格申請 End-->

<!-- popup container start -->
<div data-role="popup" id="alert-popup-info" class="ui-content popupDiv" data-overlay-theme="b" data-dismissible="false" data-position-to="#popupSite" data-shadow="true" data-corners="true">
    <div data-role="header" class="popup-header">
       <p>備註事項</p>
    </div>
	<hr style="margin-top: 17px;">
    <div data-role="content" class="popup-content">
        <p>2015/03/01-2015/06/30, 122 days (留停)</p>
        <a class="ui-btn btnPopOK" data-rel="back"><div>確 認</div></a>
    </div>
</div>

<div data-role="popup" id="alert-popup-apply" class="ui-content popupDiv" data-overlay-theme="b" data-dismissible="false" data-position-to="window" data-shadow="true" data-corners="true">
    <div data-role="header" class="popup-header">
       <p >選班資格申請</p>
    </div>

    <div data-role="content" class="popup-content">    
    	<input type="hidden" id="backData" >	
        <p id="strMsg"></p>
        <a id="popConf" class="ui-btn btnPopOK" href="#" data-ajax="false"><div>確 認</div></a><!--  -->
    </div>
</div>
<!-- popup container end -->

<!-- navbar Slide Panel -->
    <div id="navbar" data-role="panel" data-position="right" data-position-fixed="false" data-display="overlay" data-theme="b">
        <ul id="right-list" data-role="listview" data-inset="true" data-icon="false">
        </ul>
    </div>
<!-- navbar Slide Panel -->

</div>


</body>
</html>
<%}%>