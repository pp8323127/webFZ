/*
	�ܧ��椤�^�廡��
*/
function chgLanguage(){
	if(document.getElementById("chgL").value == "ENGLISH"){//�ܦ��^��
		document.getElementById("chgL").value=  "������";
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
		document.getElementById('n1').innerHTML='�i���Z�M�ϡj';	
			document.getElementById('n11').innerHTML='���ɬd��';	
			document.getElementById('n12').innerHTML='�����Z��/�ڪ���Z��T';	
			
			document.getElementById('n13').innerHTML='�d�ߥi���Z��';	
		if(document.getElementById('n13a') != null){
			document.getElementById('n13a').innerHTML='�D������Ȭd��';	
		}

		if(document.getElementById('n14') != null){
			document.getElementById('n14').innerHTML='�ڪ���Z��T';	
		}
			document.getElementById('n15').innerHTML='��ӽг�';	
			document.getElementById('n16').innerHTML='�г�O��';	
		if(document.getElementById('n17') != null){			
			document.getElementById('n17').innerHTML='�U����Z��T';	
		}
			document.getElementById('n18').innerHTML='���Z���ɸպ� ';	
			

		document.getElementById('n2').innerHTML='�i�ӤH��ơj';	
			document.getElementById('n21').innerHTML='�խ��ӤH���';	
			document.getElementById('n22').innerHTML='�ܧ�t�αK�X';	
			document.getElementById('n23').innerHTML='���] CIA �K�X';	
			document.getElementById('n24').innerHTML='�ۭq�̷R��Z';	
			document.getElementById('n25').innerHTML='�ߦn��Z�d��';	
			document.getElementById('n26').innerHTML='�ۭq�n�ͦW��';	
			//document.getElementById('n27').innerHTML='�~����J�d��';	
			document.getElementById('n28').innerHTML='��w�}��Z��';	
			document.getElementById('n29').innerHTML='�w�B���[';	
			document.getElementById('n291').innerHTML='���g�q��';	
			document.getElementById('n292').innerHTML='���[�M��';	
			document.getElementById('n293').innerHTML='����O��';	
			if(document.getElementById('n22a') != null){
				document.getElementById('n22a').innerHTML='�ܧ����a�I';	
			}
			document.getElementById('n29b').innerHTML='�[�Z�O����';	

			if(document.getElementById('n294') != null){			
				document.getElementById('n294').innerHTML='�K�|�~����';	
			}

			if(document.getElementById('n40') != null){
				document.getElementById('n40').innerHTML='�ݩR�~�\�O����';	
			}
			if(document.getElementById('n41') != null){
				document.getElementById('n41').innerHTML='�L�����ɬq���O����';	
			}
			if(document.getElementById('n42') != null){
				document.getElementById('n42').innerHTML=' �ݩR�O�ɩ���';	
			}



		document.getElementById('n3').innerHTML='�i��L�\��j';	
			document.getElementById('n31').innerHTML='�d�߲խ��q��';	
			document.getElementById('n32').innerHTML='�N���H�c';	

			document.getElementById('n91').innerHTML='�s��MCL';	
			//document.getElementById('n92').innerHTML='���Ȳ��ʳq��';	
			document.getElementById('n93').innerHTML='���챵���d��';	
			//document.getElementById('n94').innerHTML='CIA ���զ^��';	
			document.getElementById('n95').innerHTML='�u�W�ϥΪ�';	
			//document.getElementById('n96').innerHTML='�ϥλ���';	
			//document.getElementById('n97').innerHTML='�ӽг��g����';	

			document.getElementById('n0').innerHTML='�n�X';	
			
			//document.getElementById('oldversion').value='�ϥ��ª��\��';	
			
		if(document.getElementById('n21a') != null){
			document.getElementById('n21a').innerHTML="�խ��a�ݸ��";	
		}
	}
}


function chgLanguage2(){
	if(document.getElementById("chgL2").value == "ENGLISH"){//�ܦ��^��
		document.getElementById("chgL2").value=  "������";


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
			

		document.getElementById('n2').innerHTML='�i�ӤH��ơj';	
			document.getElementById('n21').innerHTML='�խ��ӤH���';	
			document.getElementById('n22').innerHTML='�ܧ�t�αK�X';	
			document.getElementById('n23').innerHTML='���] CIA �K�X';	
			document.getElementById('n28').innerHTML='��w�}��Z��';	
			document.getElementById('n292').innerHTML='���[�M��';	
			document.getElementById('n293').innerHTML='����O��';	
			if(document.getElementById('n294') != null){
			
			document.getElementById('n294').innerHTML='Duty-Free Account';	
			}

			if(document.getElementById('n40') != null){
				document.getElementById('n40').innerHTML='�ݩR�~�\�O����';	
			}
			if(document.getElementById('n41') != null){
				document.getElementById('n41').innerHTML='�L�����ɬq���O����';	
			}
			if(document.getElementById('n42') != null){
				document.getElementById('n42').innerHTML=' �ݩR�O�ɩ���';	
			}



		document.getElementById('n3').innerHTML='�i��L�\��j';	
			document.getElementById('n31').innerHTML='�d�߲խ��q��';	
			document.getElementById('n32').innerHTML='�N���H�c';	

			document.getElementById('n91').innerHTML='�s��MCL';	
			//document.getElementById('n92').innerHTML='���Ȳ��ʳq��';	
			document.getElementById('n93').innerHTML='���챵���d��';	
			//document.getElementById('n94').innerHTML='CIA ���զ^��';	
			document.getElementById('n95').innerHTML='�u�W�ϥΪ�';	
			//document.getElementById('n96').innerHTML='�ϥλ���';	
			//document.getElementById('n97').innerHTML='�ӽг��g����';	

			document.getElementById('n0').innerHTML='�n�X';	
			
			//document.getElementById('oldversion').value='�ϥ��ª��\��';	
			

	}
}