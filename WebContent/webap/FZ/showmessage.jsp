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
			ms = "�t�Τ���Ȱ�����A�Щ�u�@��00:01�}�l����<BR>�i���]���G1.�Ұ���2.���ƬG(�䭷)";
		else if("x3".equals(msgcode))
			ms = "�w�W�L�t�γ��B�z�W���I";
		else if("x4".equals(msgcode))
			ms = "�ӽЪ̩γQ���̦��ӽг楼�Q ED �T�{���i�A����";
		else if("x5".equals(msgcode))
			ms = "���ɮt�B���o�j��12�p�ɡI�I";
		else if("x6".equals(msgcode))
			ms = "���ɮt�B���o�j��12�p�ɡI�I";
		else if("x7".equals(msgcode))
			ms = "���Z��W�ɵ��I�j�󤭤p�ɡA���o�ӽСC�Э��s��g���Z�ӽг�I<br>Extra Pay Hours over 5 hours!!";
	
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
