/***********************************************
*���ҿ�ܪ�����O�_���T�]ex: 2/30,6/31�������T������^
*�ϥήɩұa�Ѽƨ̶��Ǭ��G���W�١B�~��select name�A��select name�B��select name
*�ϥΤ�k�G
*1.<script src="../../js/checkDate.js" language="javascript"></script>
*  		      ^^^^^^^^^^^^^^^^^^^^^^^^��js�ɸ��|
*2.<form  name="form1" action="xxx" onSubmit="return checkDate('form1','yy','mm','dd')">
**********************************************/
function checkDate(formName,year,month,day){	
	var yy = eval("document."+formName+"."+year+".value");
	var mm = eval("document."+formName+"."+month+".value");
	var dd = eval("document."+formName+"."+day+".value");

	//��~
	if((yy%2000)==4){	
		if( (mm=="02" && dd=="30" )||(mm=="02" && dd=="31" )){
			Warning();
			return false;
		}		
	}
	else{		//�D��~
		if( (mm=="02" && dd=="29" )||(mm=="02" && dd=="30" ) ||(mm=="02" && dd=="31" )){
			Warning();
			return false;
		}	
	}
	
	//�P�_��30�Ѫ����
	if(mm =="04" || mm=="06" || mm=="09" || mm=="11"){	
		if(dd =="31"){
			Warning();
			return false;
		}
	
	}
	
	return true;

}

function Warning(){
	alert("�z��ܤF�L�Ī����\n�Э��s��ܡI�I");
}	
