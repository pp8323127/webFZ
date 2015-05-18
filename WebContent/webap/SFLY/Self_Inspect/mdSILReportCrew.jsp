<%@page import="fz.psfly.PSFlySelfIns"%>
<%@page import="ws.prac.SFLY.MP.MPsflySelfCrewObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflySelfCrew"%>
<%@ page contentType="text/html; charset=big5" language="java"
	import="java.sql.*,ci.db.*,java.util.*"%>
<%
	String userid = (String) session.getAttribute("userid"); //get user id if already login

	if (userid == null) {
		response.sendRedirect("logout.jsp");
	}	
	String sernno = request.getParameter("sernno");
	String itemno = request.getParameter("itemno");
	String fltno	= request.getParameter("fltno");
	String sect		= request.getParameter("sect");
	String fltd      = request.getParameter("fltd");
	String comm = "";	
	ArrayList objAL=null;
	//out.println(sernno+","+itemno);
	PSFlySelfIns sfly = new PSFlySelfIns();
	if(!"".equals(sernno)){
		sfly.SelfInsCrew(fltd, sect, fltno, "");
		//out.println(sfly.getsInsItem().getErrorMsg());
	}
	MPsflySelfCrew[] allcrew = sfly.getsInsItem().getCrewArr();	
	sfly.getSelfInsCrew(sernno, itemno);
	objAL = sfly.getObjAL();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit Crew</title>
<script language="javascript" type="text/javascript">
function check(){	
	//if (eval(document.form2.elements[i].checked)) count++;
	var empno = document.form2.addExtraEmpno.value();
	var comm = document.form2.comm2.value();
	if(empno == "") {
		alert("please input empno for extra crew list.");
		document.form2.addExtraEmpno.focus();
		return false;
	}else if(comm == ""){
		alert("please input comments");
		document.form2.comm2.focus();
		return false;
	}else{
		return true;
	}
}
</script>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form name="form1" method="post" action="mdSILReportCrewSave.jsp"
		onsubmit="">
		<div align="center">
			<span class="txttitletop">Edit Crew Comment</span>
		</div>
		<table width="70%" border="1" align="center" cellpadding="1"
			cellspacing="1">
			<tr bgcolor="#9CCFFF" class="txtblue">
				<td width="25%" class="table_head"><div align="center">Empno/Name</div></td>
				<td width="75%" class="table_head"><div align="center">Comment</div></td>
			</tr>
			<tr>
				<%
					if (objAL != null && objAL.size() > 0) {
						for (int k = 0; k < objAL.size(); k++) {
							MPsflySelfCrewObj crewObj = (MPsflySelfCrewObj) objAL.get(k);
							if (allcrew != null && allcrew.length > 0) {
								for (int j = 0; j < allcrew.length; j++) {
									if(allcrew[j].getEmpno().equals(crewObj.getEmpno())){
										allcrew[j].setEmpno("");
									}
								}
							}
				%>
				<td><div align="center">
						<input type="hidden" name="empno" id="empno" value="<%=crewObj.getEmpno()%>"> <%=crewObj.getEmpno()%>
					</div></td>
				<td><input name="comm" type="text" id="comm" size="50" value="<%=crewObj.getCrew_comm()%>"></td>

			</tr>
			<%
				}
				}
			%>
			<tr>

				<td><select name="empno" id="empno">
						<option value="">½Ð¿ï¾Ü</option>
						<%
							if (allcrew != null && allcrew.length > 0) {
								for (int j = 0; j < allcrew.length; j++) {
									MPsflySelfCrew allCrewObj = allcrew[j];
									if(!"".equals(allCrewObj.getEmpno())){
						%>
						<option value="<%=allCrewObj.getEmpno()%>"><%=allCrewObj.getEmpno()%>/<%=allCrewObj.getName()%></option>
						<%
									}
								} //for(int j=0;j<allcrew.length;j++){
							} // if(allcrew !=null && allcrew.length>0){
						%>
				</select></td>
				<td><input name="comm" type="text" id="comm" size="50" value="<%=comm%>"></td>
			</tr>

			<tr>
				<td colspan="3">
					<div align="center">
						<input type="hidden" name="itemno" id="itemno" value="<%=itemno%>">
						<input type="hidden" name="sernno" id="sernno" value="<%=sernno%>">
						<input type="submit" name="Submit" value="Submit"> 
						<input type="reset" name="Reset" value="Reset">
					</div>
				</td>
			</tr>

		</table>
	</form>
<hr></hr>
	<form name="form2" method="post" action="addSILReportCrewList.jsp" onsubmit="retrun check();">
	<center>
	  <span class="txttitletop">Add Crew &amp; Comment by Empno</span>
	</center>
		<table width="70%" border="1" align="center" cellpadding="1"
			cellspacing="1">
			<tr bgcolor="#9CCFFF" class="txtblue">
				<td width="25%" class="table_head"><div align="center">Empno</div></td>
				<td width="75%" class="table_head"><div align="center">Comment</div></td>
			</tr>
			<tr>
				<td><input name="addExtraEmpno" type="text" id="addExtraEmpno" size="8"
					maxlength="6" value=""></td>
				<td><input name="comm2" type="text" id="comm2" size="50" value="">
				</td>
			</tr>

			<tr>
				<td colspan="3">
					<div align="center">
						<input type="hidden" name="itemno" id="itemno" value="<%=itemno%>">
						<input type="hidden" name="sernno" id="sernno" value="<%=sernno%>">
						<input type="submit" name="Submit" value="add">
						<input type="reset" name="Reset" value="Reset">
					</div>
				</td>
			</tr>

		</table>
	</form>

</body>
</html>
