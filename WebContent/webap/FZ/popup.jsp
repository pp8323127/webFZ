<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*,ci.db.*" errorPage="" %>
<%
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean status = false;
String ms = "";
String chgdate = null;
String sql = "";
String occu = (String) session.getAttribute("occu");
if(occu == null) occu = "N";

//�������Z�޲z�H��
String khhEF = "N";
if( session.getAttribute("KHHEFFZ") != null){
	khhEF = (String)session.getAttribute("KHHEFFZ");
}

String base = (String)session.getAttribute("base");

if("Y".equals((String)session.getAttribute("COCKPITCREW"))){	//�e���խ�
	sql = "select (CASE WHEN ms IS NOT NULL THEN '����խ��`�N�ƶ�:<br>'||ms ELSE '' END ) ms,flag "
		+"from fzthotn where flag='1'";
}
else if("Y".equals(khhEF) || "KHH".equals(base)){	
	//�������Z�޲z�H�� & �D�����խ�
	sql = "select (CASE WHEN ms IS NOT NULL THEN 'KHH�ȿ��խ��`�N�ƶ�:<br>'||ms ELSE '' END ) ms, flag "
		+"from fzthotn where flag='2' and station='KHH'";
}else{
	//�x�_�խ��A�@��խ�
	sql = "select (CASE WHEN ms IS NOT NULL THEN '�ȿ��խ��`�N�ƶ�:<br>'||ms ELSE '' END ) ms,flag "
		+"from fzthotn where flag='2' and station='TPE'";
}
String  ms2 = "";

try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);stmt = conn.createStatement();
stmt = conn.createStatement();

rs = stmt.executeQuery(sql);
if(rs != null){
	while(rs.next()){

		ms =  rs.getString("ms") ;
	
	}
}
if(ms == null){
ms = " ";
}
ms2 = ms.replaceAll("<br>", "");
ms2 = ms2.replaceAll("<BR>","");
ms2 = ms2.replaceAll("\"","\\\\u0022");

}
catch (Exception e)
{

	  status = true;
	  out.print("ERROR:"+e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title> �u�խ��Z���T���v�n����</title>
<link rel="stylesheet" type="text/css" href="style.css">
 <script language="javascript" type="text/javascript" src="js/subWindow.js"></script>
<script Language="JavaScript">
<!--
count = 0;
str = "<%=ms2%>";
function moveText()
{
	status = str.substring(count++,str.length+1);
	count %= str.length;
	setTimeout("moveText()",300);
}
setTimeout("moveText()",300);
// -->
</script>


</head>

<%
//�e�῵��ܤ��P��remarks��
if("Y".equals((String)session.getAttribute("COCKPITCREW"))){			//�e��
	out.print("<body onLoad=\"subwinXY('../cockremarks.htm','notice','750','400')\">");

}
else
{
	String userip = request.getRemoteAddr();
	/*
	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5)))
	{
		out.print("<body onLoad=\"subwinXY('../cbnremarks.htm','notice','750','400');subwinXY('playswf.jsp','notice2','750','400');\">");
	}
	else
	{
		out.print("<body onLoad=\"subwinXY('../cbnremarks.htm','notice','750','400')\">");
	}
	*/
	
	out.print("<body onLoad=\"subwinXY('../cbnremarks.htm','notice','750','400')\">");
	//out.print("<body onLoad=\"subwinXY('../cbnremarks.htm','notice','750','400');subwinXY('playswf.jsp','notice2','750','400');\">");
}
%>

<p>&nbsp;</p>
<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td  align="center">
      <div  class="red">HotNews!!!</div>
        
 <script language="JavaScript">
	<!--
	var index = 3
	text = new Array(3);
	
	text[0] ='<%=ms%>'
	text[1] =''
	text[2] =''
	
	document.write ("<marquee class='mb'  scrollamount='3' scrolldelay='100' direction= 'up' width='90%' id=xiaoqing height='150' onmouseover=xiaoqing.stop() onmouseout=xiaoqing.start()>");
	for (i=0;i<index;i++){
	document.write (text[i] + "<br>");
	}
	document.write ("</marquee>");
	// -->
</script> 
	  
   
    </td>
  </tr>
  
  <tr>
    <td   valign="top" align="left"><br>

      <ul class="blue">
        <li>���t�δ��Ѳխ����Z��T�d�� �B ���W���Z�ӽ� ���\��A�w��h�[�Q�ΡC</li>
		<li>���t�Υi�̱z�ӤH�N�@�N�Z����w�C</li>
        <li>���O�@�ӤH���p�κ����w�����@�A�бz�ԲӾ\Ū�U�C���ڡA�æ��q�ȽT���u�G
          <br>          
          <ul class="red">
            <li>�ڤ��N�ӤH USERID �� PASSWORD �i�D�L�H�A�ΨѥL�H�ϥΡC </li>
            <li>�b�ڧ������W�d�ߩΥӽЫ�A�@�w�h�X�����A�H����L�H�_�ΡC </li>
            <li>���@��u���q�����δ��Z�������W�w�C </li>
          </ul>
        </li>
      </ul>      </td>
  </tr>
  <tr>
    <td height="46">
      <blockquote>
        <p><span class="red">���t�Ϋ�ĳ�ϥ� Internet Explorer 6.0 �H�W�����A1024 x768 �ѪR���s��</span><br>
          Best Resolution  1024 x 768 Pixels / IE 6.0<br>
  We recommend to use Firefox as browser when you are working with MAC.
        
      </p>
    </blockquote></td>
  </tr>
</table>
</body>
</html>
<%

%>

