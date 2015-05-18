<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Script-Type" content="text/javascript; charset=big5">
<meta http-equiv="Content-Style-Type" content="text/css; charset=big5">
<title>Crew Reporting Check System</title>
<script>
function flashFunc(obj,message)
{
	var n=0; 
	for(m=0;m<message.length;m++) 
		obj.innerHTML+='<span id="neonlight'+m+'" style="font-size:18px;color:#006666;font-weight:bold;">'+message.charAt(m)+'</span>';
	function neon()
	{ 
		if (n==0)
		{ 
			for (var m=0;m<message.length;m++) 
			{
				document.getElementById("neonlight"+m).style.color="#00ccff";
			}
		} 
		document.getElementById("neonlight"+n).style.color="#ff0066" 
		if (n<message.length-1) n++;
		else n=0;
		setTimeout(neon,50);
        } 
                neon();

      
}
function CheckDate()
{
      var today = new Date();
       
        var st_date =new Date('2007', '11', '25', '08', '30')
       
        var end_date =new Date('2008', '0', '30', '17', '00')
       
        if(today >= st_date && today <= end_date){
            flashFunc(document.getElementById("mydiv"),"進 入 碼 Entry Code :3322");
        }
}

</script>
<style type="text/css">
<!--
.style7 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 18px; color: #000099; }
-->
</style>
</head>
<body>
<%
String msg = request.getParameter("msg");
if(msg == null) msg = "Welcome to Crew Reporting Check System";
%>
<div align="center">
  <p class="style7"><%=msg%></p></div>
<div id="mydiv" align=center></div>
<script>
  CheckDate();
</script>
</body>
</html>