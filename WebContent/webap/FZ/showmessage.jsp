<%@page contentType="text/html; charset=big5" language="java"%>
<%
	//response.setHeader("Cache-Control","no-cache");
	//response.setDateHeader ("Expires", 0);
	request.setCharacterEncoding("Big5"); 
	String ms = null;
	String ms2 = null;
	String linkpage =null;
	String msgcode = null;
	ms = request.getParameter("messagestring");
	ms2 = request.getParameter("messagelink");
	linkpage = request.getParameter("linkto");
	msgcode = request.getParameter("msgcode");
	if (ms == null )
	{
		//ms = request.getParameter("messagestring").trim();
		ms="Welcome to China Airlines Crew Schedule Inquiry System";
	}
	if(msgcode != null){
		if("x1".equals(msgcode))
			ms = "Select Schedule to Apply !";
		else if("x2".equals(msgcode))
			ms = "系統今日暫停收件，請於工作日00:01開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)";
		else if("x3".equals(msgcode))
			ms = "已超過系統單日處理上限！";
		else if("x4".equals(msgcode))
			ms = "申請者或被換者有申請單未被 ED 確認不可再遞單";
		else if("x5".equals(msgcode))
			ms = "飛時差額不得大於12小時！！";
		else if("x6".equals(msgcode))
			ms = "飛時差額不得大於12小時！！";
		else if("x7".equals(msgcode))
			ms = "換班後超時給付大於五小時，不得申請。請重新填寫換班申請單！<br>Extra Pay Hours over 5 hours!!";
	
	}
%>
<html>
<head>
<title>Show Message</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>

<body text="#000000" class="txttitletop">
<div align="center">
  <p><%=ms%>
</p>
<%
	if (ms2 == null){
		ms2 = "&nbsp;";
		linkpage = "#";
	}

  else{
%>
  <p><a href="<%=linkpage%>"><%=ms2%></a></p>
  <%
  }
  %>
</div>
</body>
</html>
