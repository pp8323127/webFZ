<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = "633237";//(String) session.getAttribute("userid") ; //Check if logined
//if ((sGetUsr == null) || (session.isNew()) )
//{		//check user session start first or not login
	//response.sendRedirect("sendredirect.jsp");
//}


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Document</title>
<script language="JavaScript" type="text/JavaScript">
</script>
<style type="text/css">

.style2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 24px;
	font-weight: bold;
	color: #0000FF;
	border-top-color: #0000FF;
	border-right-color: #0000FF;
	border-bottom-color: #0000FF;
	border-left-color: #0000FF;
}
.style3 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #333333;
	border-top-color: #0000FF;
	border-right-color: #0000FF;
	border-bottom-color: #0000FF;
	border-left-color: #0000FF;
}

</style>
</head>

<body>
 <table width="70%"  border="1" align="center" cellpadding="1" cellspacing="1">
	<tr>
	    <td>
		  <div align="center">
		  	<span class="style2">Health Information for Plateau Airport</span>
          </div></td>	    
	</tr>
	<tr>
	    <td>
		  <div align="left"><span class="style3">
Person who has the following symptom is not suitable for plateau flight:<br><br>
1.&nbsp;Suffering from significant cardiovascular disease, respiratory or ENT disorder, epilepsy, cerebrovascular disease, anemia, digestive disease, and endocrine disorder, pregnancy, history of  mountain sickness.<br><br>
2.&nbsp;Usually appropriate body training and rest can enhance the endurance ability for less oxygen intake and reduce the body oxygen consumption. Thus will speed the adjustment of your body to the plateau.<br><br>
3.&nbsp;Sufficient and good rest is essential before flight.<br><br>
4.&nbsp;Avoid severe activities or over tiredness before entering the plateau.  The movement must be slow, no jogging,no heavy items, no intense exercise and reducing bath frequency after entering plateau.<br><br>
5.&nbsp;Maintain balanced psychological condition: Over psychological tension and anxiety will harm the adjustment of human body to the plateau.<br><br>
6.&nbsp;Avoid catching cold and infection�G The freezing climate and wide change of day and night temperature will easily trigger the respiratory disease and become the high plateau sickness. Remember to bring enough protective clothing, particularly to hands, feet and face.<br><br>
7.&nbsp;Balanced nutrition:Better take high sugar, protein and carbohydrate foods or vegetables and fruits with rich Vietmin C. Avoid gas forming food such as beans or carbonate drinks. Don��t smoke , drink and take tranquilizer. <br><br>
8.&nbsp;Liquid supplement�GAt least take 4-5 liters of drinking water every day.<br><br>
9.&nbsp;Avoid sunlight radiation�G To prevent skin burn and vision damage, it is better to equip yourself with sun block device.<br><br>
10.&nbsp;Mountain sickness: If there were any symptom such as headache, dizziness, anorexia, insomnia, vomiting, and peripheral edema, and most serious symptoms such as conscious disturbance, unstable gait and sort of breathing at rest, please go to hospital for treatment immediately.<br><br>
</span>
          </div></td>	    
	</tr>
	
 </table>
 <hr align="center">
 <table width="70%"  border="1" align="center" cellpadding="1" cellspacing="1">
	<tr>
	    <th>
		  <div align="center"><span class="style2">���谪��������ȯ�ūO����T</span>
	        <br>
          </div>		 
		 </th>
	</tr>
	<tr>
	    <td>
		  <div align="left"><span class="style3">�q�о\Ū�H�U��T��ñ�W�T�{�G<br><br>
1.&nbsp;�w���Y���ߦ�ޯe�f�B�I�l�Φջ��t�ίe�f�B���w�B����ޯe�f�B�h��B���ƨt�ίe�f�B�Τ����c�t�ίe�f���B���W���B�����w���s�g�f�v�̩Ψ�L�Y�����餣�A�A���y�i�J���쭸��C<br><br>
2.&nbsp;������ȫe�����R���B�}�n���ίv�~��C<br><br>
3.&nbsp;��֨���Ӯ�G�X�J����a�Ϫ��e��Ѥ��קK�@�P�����ʡA�i�J����a�ϫe���קK�L�ׯh�ҡC�ʧ@�n�w�A���n�]�B�A���������F�֬~���B�~�Y�F���n���R�ΰ��E�P���B�ʡC<br><br>
4.&nbsp;�קK�۲D�ηP�V�G�����ԴH�N�B��]�Ůt�j�A���w�I�l�D�e�f�ӻ��o����g�C�窫�n�H����a�O�x�A�ר���ⳡ�B�}���έ������O�@��n�`�N�C<br><br>
5.&nbsp;�O���}�n���߲z���A�G����A���ʾ���P���g�t�νո`�����A�믫�L�׺�i�M�J�{�����Q��H��ﰪ�����Ҫ��A���C<br><br>
6.&nbsp;���R���šG���b����a�ϾA�ת����娭��M�𮧡A���ʨ���i���娭���ʮ񪺭@���O�A�ӾA�ץ𮧫h�i��֨��骺�Ӯ�q�A�i�[�ֹﰪ�쪺�A���C<br><br>
7.&nbsp;��i���šG�H���}�B���J�խ����B���Ҥ��ƦX�����ΡA�קK�Y���𭹪�(�p�����κһĶ���)�A�̦n�h������δI�t���L�RC�����G�A�C�Z����ɭn�h�Z�@�������ơA�H��֭G����G�������C���n�l�ҡB���n�ܰs�ΪA�����R���C�p�G�X�{�Y�w�B���ߡB���שI�l���P���r�g���A�i�A��ɥR�ĩʭ����p���B�J�B�\���B�֮絥�C���\���y�L���A�H�K�W�[�z�D�t��޵o�ߪ������C<br><br>
8.&nbsp;�ɥR�����G�n�h�ɥR�����C�b�����ަa��80�J�N�m�ˤF�ܵy�Ū��N�n�C�n�ֶq�h���A�ܤ֨C�ѭn�ܤW4-5���ɪ������A�H�O�����G�M������h�A�Y����P��f���{�H�A�Y��ܨ�γ\�w�s�����ײ����x�A���ߧY�ɥR�����C<br><br>
9.&nbsp;�קK�����g�G���쵵�~�u�j�׸����찪�X2.5���A���Ʀ�����j���B�jUV�u�Ӯg�����~�p�����赥�A�H����ֽ��`�˩M���O�l�ˡC<br><br>
10.&nbsp;���s�g�g��:��F�����Y���Y�h�B�Y�w�B�����B���v�B�äߡB�P����~�Υ����«嵥�g���A�Ʀܦ��Y�������s�g�g���p�N�Ѫ����ܡB�B�A��í�B�𮧮ɩI�l�x���B�@�w�n�ߧY����|�E�v�C<br><br>
			</span></div>		  </td>	    
		</tr>
 </table>
   <br>	
   <br>	
   <div align="center">
   <input type="BUTTON" value="   NEXT   " onclick="javascript:window.close();" />
  </div>

</body>
</html>
