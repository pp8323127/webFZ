/*
	變更選單中英文說明
*/
function chgLanguage(){
	if(document.getElementById("chgL").value == "ENGLISH"){//變成英文
		document.getElementById("chgL").value=  "中文選單";
		document.getElementById('n1').innerHTML='<strong>TRANSFER</strong>';	
		document.getElementById('n11').innerHTML='Flying Time Query';	
		document.getElementById('n12').innerHTML='Put Schedule & Record';	
		document.getElementById('n13').innerHTML='Put Schedule Query';	
		if(document.getElementById('n13a') != null){
			document.getElementById('n13a').innerHTML='Non Fly Duty Query';	
		}
		if(document.getElementById('n14') != null){
				document.getElementById('n14').innerHTML='Put Schedule Record';	
		}
		document.getElementById('n15').innerHTML='Make Application';	
		document.getElementById('n16').innerHTML='Check Application';	
		if(document.getElementById('n17') != null){
			document.getElementById('n17').innerHTML='Download File';	
		}
		document.getElementById('n18').innerHTML='Calculated FlyHours ';	


		document.getElementById('n2').innerHTML='<strong>PERSONAL</strong>';	
			document.getElementById('n21').innerHTML='Crew Information';	
			document.getElementById('n22').innerHTML='Change Password';	
			document.getElementById('n23').innerHTML='Reset CIA Password';	
			document.getElementById('n24').innerHTML='Favorite Flight';	
			document.getElementById('n25').innerHTML='Favorite Flight Query';	
			document.getElementById('n26').innerHTML='Friend List';	
			//document.getElementById('n27').innerHTML='AL Offsheet';	
			document.getElementById('n28').innerHTML='Set Schedule Status';	
			document.getElementById('n29').innerHTML='Fixed FlyPay';	
			document.getElementById('n291').innerHTML='Award List';	
			document.getElementById('n292').innerHTML='Flypay List';	
			document.getElementById('n293').innerHTML='Crew Log List';	
			if(document.getElementById('n22a') != null){
			
			document.getElementById('n22a').innerHTML='Change Checkin';	
			}
			document.getElementById('n29b').innerHTML='Overtime Pay';	
			
			if(document.getElementById('n294') != null){
			
			document.getElementById('n294').innerHTML='Duty-Free Account';	
			}

			if(document.getElementById('n40') != null){		
				document.getElementById('n40').innerHTML='SB Meal Allowance';	
			}

			if(document.getElementById('n41') != null){			
				document.getElementById('n41').innerHTML='Traffic Allowance';	
			}

			if(document.getElementById('n42') != null)
			{			
				document.getElementById('n42').innerHTML='Standby List';	
			}



		document.getElementById('n3').innerHTML='<strong>OTHERS</strong>';	
			document.getElementById('n31').innerHTML='Query Other Crews';	
			document.getElementById('n32').innerHTML='Contact EF';	

			document.getElementById('n91').innerHTML='Edit MCL';	
			//document.getElementById('n92').innerHTML='Duty change';	
			document.getElementById('n93').innerHTML='Crew Car Query';	
			//document.getElementById('n94').innerHTML='CIA Report Back';	
			document.getElementById('n95').innerHTML='Online User List';	
			//document.getElementById('n96').innerHTML="User's Guide";	
			//document.getElementById('n97').innerHTML='Application Guide';	



			document.getElementById('n0').innerHTML='Logout';	

			//document.getElementById('oldversion').value='Old Version';	

		if(document.getElementById('n21a') != null){
			document.getElementById('n21a').innerHTML="Crew's Kindred Info";	
		}

	}else{
		document.getElementById("chgL").value="ENGLISH";
		document.getElementById('n1').innerHTML='【換班專區】';	
			document.getElementById('n11').innerHTML='飛時查詢';	
			document.getElementById('n12').innerHTML='欲換班表/我的丟班資訊';	
			
			document.getElementById('n13').innerHTML='查詢可換班表';	
		if(document.getElementById('n13a') != null){
			document.getElementById('n13a').innerHTML='非飛行任務查詢';	
		}

		if(document.getElementById('n14') != null){
			document.getElementById('n14').innerHTML='我的丟班資訊';	
		}
			document.getElementById('n15').innerHTML='填申請單';	
			document.getElementById('n16').innerHTML='請單記錄';	
		if(document.getElementById('n17') != null){			
			document.getElementById('n17').innerHTML='下載選班資訊';	
		}
			document.getElementById('n18').innerHTML='換班飛時試算 ';	
			

		document.getElementById('n2').innerHTML='【個人資料】';	
			document.getElementById('n21').innerHTML='組員個人資料';	
			document.getElementById('n22').innerHTML='變更系統密碼';	
			document.getElementById('n23').innerHTML='重設 CIA 密碼';	
			document.getElementById('n24').innerHTML='自訂最愛航班';	
			document.getElementById('n25').innerHTML='喜好航班查詢';	
			document.getElementById('n26').innerHTML='自訂好友名單';	
			//document.getElementById('n27').innerHTML='年假輸入查詢';	
			document.getElementById('n28').innerHTML='鎖定開放班表';	
			document.getElementById('n29').innerHTML='定額飛加';	
			document.getElementById('n291').innerHTML='獎懲通報';	
			document.getElementById('n292').innerHTML='飛加清單';	
			document.getElementById('n293').innerHTML='飛航記錄';	
			if(document.getElementById('n22a') != null){
				document.getElementById('n22a').innerHTML='變更報到地點';	
			}
			document.getElementById('n29b').innerHTML='加班費明細';	

			if(document.getElementById('n294') != null){			
				document.getElementById('n294').innerHTML='免稅品扣補';	
			}

			if(document.getElementById('n40') != null){
				document.getElementById('n40').innerHTML='待命誤餐費明細';	
			}
			if(document.getElementById('n41') != null){
				document.getElementById('n41').innerHTML='無公車時段車費明細';	
			}
			if(document.getElementById('n42') != null){
				document.getElementById('n42').innerHTML=' 待命逾時明細';	
			}



		document.getElementById('n3').innerHTML='【其他功能】';	
			document.getElementById('n31').innerHTML='查詢組員電話';	
			document.getElementById('n32').innerHTML='意見信箱';	

			document.getElementById('n91').innerHTML='編輯MCL';	
			//document.getElementById('n92').innerHTML='任務異動通知';	
			document.getElementById('n93').innerHTML='報到接車查詢';	
			//document.getElementById('n94').innerHTML='CIA 測試回報';	
			document.getElementById('n95').innerHTML='線上使用者';	
			//document.getElementById('n96').innerHTML='使用說明';	
			//document.getElementById('n97').innerHTML='申請單填寫說明';	

			document.getElementById('n0').innerHTML='登出';	
			
			//document.getElementById('oldversion').value='使用舊版功能';	
			
		if(document.getElementById('n21a') != null){
			document.getElementById('n21a').innerHTML="組員家屬資料";	
		}
	}
}


function chgLanguage2(){
	if(document.getElementById("chgL2").value == "ENGLISH"){//變成英文
		document.getElementById("chgL2").value=  "中文選單";


		document.getElementById('n2').innerHTML='<strong>PERSONAL</strong>';	
			document.getElementById('n21').innerHTML='Crew Information';	
			document.getElementById('n22').innerHTML='Change Password';	
			document.getElementById('n23').innerHTML='Reset CIA Password';	
			document.getElementById('n28').innerHTML='Set Schedule Status';	
			document.getElementById('n292').innerHTML='Flypay List';	
			document.getElementById('n293').innerHTML='Crew Log List';	
			if(document.getElementById('n40') != null){		
				document.getElementById('n40').innerHTML='SB Meal Allowance';	
			}
			if(document.getElementById('n41') != null){			
				document.getElementById('n41').innerHTML='Traffic Allowance';	
			}
			if(document.getElementById('n42') != null)
			{			
				document.getElementById('n42').innerHTML='Standby List';	
			}



		document.getElementById('n3').innerHTML='<strong>OTHERS</strong>';	
			document.getElementById('n31').innerHTML='Query Other Crews';	
			document.getElementById('n32').innerHTML='Contact EF';	

			document.getElementById('n91').innerHTML='Edit MCL';	
			//document.getElementById('n92').innerHTML='Duty change';	
			document.getElementById('n93').innerHTML='Crew Car Query';	
			//document.getElementById('n94').innerHTML='CIA Report Back';	
			document.getElementById('n95').innerHTML='Online User List';	
			//document.getElementById('n96').innerHTML="User's Guide";	
			//document.getElementById('n97').innerHTML='Application Guide';	



			document.getElementById('n0').innerHTML='Logout';	

//			document.getElementById('oldversion').value='Old Version';	


	}else{
		document.getElementById("chgL2").value="ENGLISH";
			

		document.getElementById('n2').innerHTML='【個人資料】';	
			document.getElementById('n21').innerHTML='組員個人資料';	
			document.getElementById('n22').innerHTML='變更系統密碼';	
			document.getElementById('n23').innerHTML='重設 CIA 密碼';	
			document.getElementById('n28').innerHTML='鎖定開放班表';	
			document.getElementById('n292').innerHTML='飛加清單';	
			document.getElementById('n293').innerHTML='飛航記錄';	
			if(document.getElementById('n294') != null){
			
			document.getElementById('n294').innerHTML='Duty-Free Account';	
			}

			if(document.getElementById('n40') != null){
				document.getElementById('n40').innerHTML='待命誤餐費明細';	
			}
			if(document.getElementById('n41') != null){
				document.getElementById('n41').innerHTML='無公車時段車費明細';	
			}
			if(document.getElementById('n42') != null){
				document.getElementById('n42').innerHTML=' 待命逾時明細';	
			}



		document.getElementById('n3').innerHTML='【其他功能】';	
			document.getElementById('n31').innerHTML='查詢組員電話';	
			document.getElementById('n32').innerHTML='意見信箱';	

			document.getElementById('n91').innerHTML='編輯MCL';	
			//document.getElementById('n92').innerHTML='任務異動通知';	
			document.getElementById('n93').innerHTML='報到接車查詢';	
			//document.getElementById('n94').innerHTML='CIA 測試回報';	
			document.getElementById('n95').innerHTML='線上使用者';	
			//document.getElementById('n96').innerHTML='使用說明';	
			//document.getElementById('n97').innerHTML='申請單填寫說明';	

			document.getElementById('n0').innerHTML='登出';	
			
			//document.getElementById('oldversion').value='使用舊版功能';	
			

	}
}