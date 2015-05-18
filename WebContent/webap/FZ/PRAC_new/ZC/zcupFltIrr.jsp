<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*,java.sql.*,tool.ReplaceAll,fz.pracP.*,java.net.URLEncoder,ci.db.*,fz.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if (session.isNew() || sGetUsr == null || objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
} 

String idx = request.getParameter("idx");
ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
String item1= request.getParameter("item1");
String itemno = request.getParameter("item2");
String itemdsc = request.getParameter("item3");
String comments = request.getParameter("comm");
String goPage = "zcedFltIrr.jsp?idx="+idx;
String sql = "";

//by cs71 2005/04/25 避免update時無itemno
if("".equals(itemno) | null == itemno | null == itemdsc | "null".equals(itemdsc) | "".equals(idx) | "null".equals(idx))
{
%>
<script>
alert("新增資料失敗!!!\n請重新輸入!!");
self.location="<%=goPage%>";
</script>
<%
}
else
{
boolean t = true;
//取得flag
ItemSel id = new ItemSel();
id.getStatement();
String flag = id.getItemFlag(itemno);
id.closeStatement();
//out.print(flag);

Connection conn = null;
PreparedStatement pstmt = null;
boolean updStatus = false;
String errMsg = "";
try
{
ConnectionHelper ch = new ConnectionHelper();
conn = ch.getConnection();
conn.setAutoCommit(false);

if("".equals(obj.getIfsent()) | obj.getIfsent() == null)
{
	//update seqno
	ZCReport zcrt2 = new ZCReport();
	obj.setSeqno(zcrt2.getZCReportSeqno(obj.getFdate(),obj.getFlt_num(),obj.getPort(),sGetUsr));
	//*******************************************************************************************

	sql = " insert into egtzcflt (seqno,fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,zcempn,zcsern,zcname,zcgrps,ifsent,newuser,newdate) values (?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";

/*
if("633146".equals(sGetUsr))
{
	String tempsql = " insert into egtzcflt (seqno,fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,zcempn,zcsern,zcname,zcgrps,ifsent,newuser,newdate) values ('"+obj.getSeqno()+"',to_date('"+obj.getFdate()+"','yyyy/mm/dd'),'"+obj.getFlt_num()+"','"+obj.getPort()+"','"+obj.getCpname()+"','"+obj.getCpno()+"','"+obj.getAcno()+"','"+obj.getPsrempn()+"','"+obj.getPsrsern()+"','"+obj.getPsrname()+"','"+obj.getPgroups()+"','"+obj.getZcempn()+"','"+obj.getZcsern()+"','"+obj.getZcname()+"','"+obj.getZcgrps()+"','N','"+sGetUsr+"',sysdate)";
}
*/
	pstmt = conn.prepareStatement(sql);  
    int j=1;
	pstmt.setString(j, obj.getSeqno());
	pstmt.setString(++j, obj.getFdate());
	pstmt.setString(++j, obj.getFlt_num());
	pstmt.setString(++j, obj.getPort());
	pstmt.setString(++j, obj.getCpname());
	pstmt.setString(++j, obj.getCpno());
	pstmt.setString(++j, obj.getAcno());
	pstmt.setString(++j, obj.getPsrempn());
	pstmt.setString(++j, obj.getPsrsern());
	pstmt.setString(++j, obj.getPsrname());
	pstmt.setString(++j, obj.getPgroups());
	pstmt.setString(++j, obj.getZcempn());
	pstmt.setString(++j, obj.getZcsern());
	pstmt.setString(++j, obj.getZcname());
	pstmt.setString(++j, obj.getZcgrps());
	pstmt.setString(++j, "N");
	pstmt.setString(++j, sGetUsr);
	pstmt.addBatch();	
	pstmt.executeBatch();				
	pstmt.clearBatch();
    obj.setIfsent("N");
}

sql = "INSERT INTO egtzccmdt(seqkey,seqno,itemno,itemdsc,comments,flag) VALUES ((SELECT Nvl(Max(seqkey),0)+1 FROM egtzccmdt),?,(SELECT itemno FROM egtcmpi WHERE Trim(itemdsc)=? AND kin=(SELECT itemno FROM egtcmti WHERE itemdsc=?)),?,?,?)";
/*
if("633146".equals(sGetUsr))
{
out.print(sql +" * "+obj.getSeqno()+" * "+itemno+" * "+item1+" * "+itemdsc+" * "+comments+" * "+flag+" * "+"<br>");
}
*/
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,obj.getSeqno());
pstmt.setString(2,itemno);
pstmt.setString(3,item1);
pstmt.setString(4,itemdsc);
pstmt.setString(5,comments);
pstmt.setString(6,flag);
pstmt.executeUpdate();
conn.commit();


//更新flt irr items
//************************************************************
ZCReport zcrt = new ZCReport();
obj.setZcfltirrObjAL(zcrt.getZCFltIrrItem(obj.getSeqno()));            
//************************************************************
updStatus = true;
}
catch(SQLException e)
{
	errMsg = e.toString();
	try 
	{
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}	
}catch (Exception e){
	errMsg = e.toString();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
}
finally
{
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (conn != null) {
		try {
			conn.close();
		} catch (SQLException e) {
				errMsg += e.getMessage();

		}
		conn = null;
	}
}
if(updStatus)
{
	//if(!"633146".equals(sGetUsr))
	//{
	response.sendRedirect(goPage);
	//}
}
else
{
%>
<%=errMsg%><br>
<a href="javascript:history.back(-1);">請重新輸入!!</a>
<%
}
}
%>