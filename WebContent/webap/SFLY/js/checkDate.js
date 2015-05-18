/***********************************************
*驗證選擇的日期是否正確（ex: 2/30,6/31為不正確的日期）
*使用時所帶參數依順序為：表單名稱、年份select name，月select name、日select name
*使用方法：
*1.<script src="../../js/checkDate.js" language="javascript"></script>
*  		      ^^^^^^^^^^^^^^^^^^^^^^^^為js檔路徑
*2.<form  name="form1" action="xxx" onSubmit="return checkDate('form1','yy','mm','dd')">
**********************************************/
function checkDate(formName,year,month,day){	
	var yy = eval("document."+formName+"."+year+".value");
	var mm = eval("document."+formName+"."+month+".value");
	var dd = eval("document."+formName+"."+day+".value");

	//潤年
	if((yy%2000)==4){	
		if( (mm=="02" && dd=="30" )||(mm=="02" && dd=="31" )){
			Warning();
			return false;
		}		
	}
	else{		//非潤年
		if( (mm=="02" && dd=="29" )||(mm=="02" && dd=="30" ) ||(mm=="02" && dd=="31" )){
			Warning();
			return false;
		}	
	}
	
	//判斷為30天的月份
	if(mm =="04" || mm=="06" || mm=="09" || mm=="11"){	
		if(dd =="31"){
			Warning();
			return false;
		}
	
	}
	
	return true;

}

function Warning(){
	alert("您選擇了無效的日期\n請重新選擇！！");
}	
