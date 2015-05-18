<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,fzAuthP.*" %>

<% 
    session.removeAttribute("UserID");
    session.removeAttribute("Password");
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.structure.css" />	
<link rel="stylesheet" href="jQueryMob/jquery.mobile.custom.theme.css" />	
<script src="jQueryMob/jquery.js" language="javascript"></script>	
<script src="jQueryMob/jquery.mobile.custom.js" language="javascript"></script>	
<script type="text/javascript">
$(document).ready(function () {
	
	$("#sub").click(function(e){
		var userid = $("#inputId").val();
		var pwd = $("#inputPwd").val();
		$.ajax({
			type: "POST",
			url: "checkUser.jsp",
			data: {UserID:userid, Password:pwd},
			success:function(data){
				//alert(data);
				if ($.trim(data) === "true"){
					//alert("true");					
					//$.mobile.changePage("index1.jsp", {transition : "slide"}, false);
					$("#loginForm").attr("action", "index1.jsp");
					$("#loginForm").submit();
					
				}
				else{
					//alert("false");
					$("#myPopupDialog").popup("open");
				}
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

// $(document).ready(init);
// function init(){
// 	console.log("0");
//  	$("#sub").click(clickFun);
// }		
// function clickFun() {
// 		$.ajax({
// 			type : "POST",
// 			url : "swap1.jsp",
// 			data :{Name:loginForm.Name.value, Pwd:loginForm.Pwd.value},
// 			//contentType: "text/html",
// 			//dataType: "text/html",
// 			async: true,
// 			success: function (data) {
// 				//console.log(data); 
// 				//$("#errorMsg").html(data);
// 				alert(data);
// 			},
// 			error:function(xhr, ajaxOptions, thrownError){ 
// 				console.log(xhr.status); 
// 				console.log(thrownError); 
// 				alert("Error");
// 			}
// 		})
// }

</script>

</head>
<body>

<!--login page-->
	<div id="Home" data-role="page" data-theme="a">
	  <div data-role="header" data-position="fixed">
		<h3>iCrew</h3>
	  </div>
	  <div role="main" class="ui-content">
	  <form id="loginForm" method="POST" action="" data-ajax="false">
			<div class="ui-field-contain">
				<label for="inputId">EmployID</label>
				<input type="text" id="inputId">
			</div>
			<div class="ui-field-contain">
				<label for="inputPwd">Password</label>
				<input type="password" id="inputPwd" data-mini="false">
			</div>
			<div class="ui-content">
			    <button id="sub" class="ui-btn ui-corner-all">Submit</button>
			</div>
	   </form>
		<!--<a class="ui-btn" id="btnLogin" data-transition="slide" href="#pageHome">Login</a>-->			
<!-- 		<div id="errorMsg"></div> -->		
		
		<div data-role="footer" data-position="fixed">
		  <h3>Footer</h3>
	    </div>
	    
	   <div data-role="popup" id="myPopupDialog" data-overlay-theme="b" data-dismissible="false">
	
	     <div data-role="main" class="ui-content" align="center">
	       <div class="ui-field-contain">
	         <h3>登入錯誤</h3>
	         <p>員工號或EIP密碼不正確</p>
	       </div>
	       <div class="ui-content">
	         <a href="#" class="ui-btn ui-corner-all" data-rel="back">確定</a>
	       </div>
	     </div>
	     
	   </div>
	   	    
	  </div>
	  
	</div>

</body>
</html>