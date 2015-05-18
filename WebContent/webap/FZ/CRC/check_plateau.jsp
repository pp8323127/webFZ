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
6.&nbsp;Avoid catching cold and infection： The freezing climate and wide change of day and night temperature will easily trigger the respiratory disease and become the high plateau sickness. Remember to bring enough protective clothing, particularly to hands, feet and face.<br><br>
7.&nbsp;Balanced nutrition:Better take high sugar, protein and carbohydrate foods or vegetables and fruits with rich Vietmin C. Avoid gas forming food such as beans or carbonate drinks. Don’t smoke , drink and take tranquilizer. <br><br>
8.&nbsp;Liquid supplement：At least take 4-5 liters of drinking water every day.<br><br>
9.&nbsp;Avoid sunlight radiation： To prevent skin burn and vision damage, it is better to equip yourself with sun block device.<br><br>
10.&nbsp;Mountain sickness: If there were any symptom such as headache, dizziness, anorexia, insomnia, vomiting, and peripheral edema, and most serious symptoms such as conscious disturbance, unstable gait and sort of breathing at rest, please go to hospital for treatment immediately.<br><br>
</span>
          </div></td>	    
	</tr>
	
 </table>
 <hr align="center">
 <table width="70%"  border="1" align="center" cellpadding="1" cellspacing="1">
	<tr>
	    <th>
		  <div align="center"><span class="style2">飛航高原機場任務航空保健資訊</span>
	        <br>
          </div>		 
		 </th>
	</tr>
	<tr>
	    <td>
		  <div align="left"><span class="style3">敬請閱讀以下資訊並簽名確認：<br><br>
1.&nbsp;患有嚴重心血管疾病、呼吸及耳鼻喉系統疾病、癲癇、腦血管疾病、貧血、消化系統疾病、及內分泌系統疾病等、妊娠期、曾罹患高山症病史者或其他嚴重身體不適，不宜進入高原飛行。<br><br>
2.&nbsp;執行任務前應有充足、良好之睡眠品質。<br><br>
3.&nbsp;減少身體耗氧：出入高原地區的前兩天內避免劇烈的活動，進入高原地區前應避免過度疲勞。動作要緩，不要跑步，不拿重物；少洗澡、洗頭；不要跳舞或做激烈的運動。<br><br>
4.&nbsp;避免著涼及感染：高原氣候寒冷、日夜溫差大，易患呼吸道疾病而誘發高原症。衣物要隨身攜帶保暖，尤其對於手部、腳部及面部的保護更要注意。<br><br>
5.&nbsp;保持良好的心理狀態：高原適應性機制與神經系統調節有關，精神過度緊張和焦慮均不利於人體對高原環境的適應。<br><br>
6.&nbsp;動靜平衡：指在高原地區適度的鍛鍊身體和休息，活動身體可鍛鍊身體對缺氧的耐受力，而適度休息則可減少身體的耗氧量，可加快對高原的適應。<br><br>
7.&nbsp;營養平衡：以高糖、高蛋白食物、高碳水化合物為佳，避免吃產氣食物(如豆類或碳酸飲料)，最好多食蔬菜及富含維他命C的水果，咀嚼飯菜時要多嚼一倍的次數，以減少胃部血液的供應。不要吸菸、不要喝酒及服用鎮靜劑。如果出現頭暈、噁心、輕度呼吸性鹼中毒症狀，可適當補充酸性食物如魚、蛋、穀類、核桃等。晚餐不宜過飽，以免增加腸道負擔引發心肺壓迫。<br><br>
8.&nbsp;補充水分：要多補充水份。在高海拔地方80℃就沸騰了喝稍溫的就好。要少量多次，至少每天要喝上4-5公升的水分，以保持尿液清澈為原則，若個體感到口渴現象，即表示其或許已存有輕度脫水表徵，應立即補充水分。<br><br>
9.&nbsp;避免日光輻射：高原紫外線強度較平原高出2.5倍，應備有防止強光、強UV線照射之物品如防曬鏡等，以防止皮膚灼傷和視力損傷。<br><br>
10.&nbsp;高山症症狀:抵達高原後若有頭痛、頭暈、厭食、失眠、嘔心、周邊水腫及全身倦怠等症狀，甚至有嚴重的高山症症狀如意識的改變、步態不穩、休息時呼吸困難、一定要立即到醫院診治。<br><br>
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
