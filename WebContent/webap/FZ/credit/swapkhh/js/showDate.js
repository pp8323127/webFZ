//��ܥثe�ɶ�

/*show YEAR,MONTH,DAY
*
*�Ӷ��ǻݱa�ѼơG���W�١B�~���W�١B����W�١B����W��
**/
function showYMD(formName,year,month,day){	
	 nowdate = new Date();
	var y,m,d;
	y = nowdate.getFullYear() ;
	m = nowdate.getMonth()+1;
	d =nowdate.getDate();

	if (m < 10) {
		eval("document."+formName+"."+month+".value = '0'+m");
	}
	else{
		eval("document."+formName+"."+month+".value = m");
	} 
	
	if(d<10){
		eval("document."+formName+"."+day+".value ='0'+ d");
	}
	else{
		eval("document."+formName+"."+day+".value = d");
	}
	
	eval("document."+formName+"."+year+".value = y");

 }
 
/*show YEAR,MONTH
*
*�Ӷ��ǻݱa�ѼơG���W�١B�~���W�١B����W��
**/
 
function showYM(formName,year,month){	
	 nowdate = new Date();
	 var y,m
	y = nowdate.getFullYear() ;
	m = nowdate.getMonth()+1;

	if (m < 10) {
		eval("document."+formName+"."+month+".value = '0'+m");
	}
	else{
		eval("document."+formName+"."+month+".value = m");
	} 
	
	eval("document."+formName+"."+year+".value = y");

 }
 
 function showYMDHM(formName,year,month,day,hh,mins){	
	 nowdate = new Date();
	var y,m,d;
	y = nowdate.getFullYear() ;
	m = nowdate.getMonth()+1;
	d =nowdate.getDate();
	h = nowdate.getHours();
	mi = nowdate.getMinutes();

	if (m < 10) {
		eval("document."+formName+"."+month+".value = '0'+m");
	}
	else{
		eval("document."+formName+"."+month+".value = m");
	} 
	
	if(d<10){
		eval("document."+formName+"."+day+".value ='0'+ d");
	}
	else{
		eval("document."+formName+"."+day+".value = d");
	}
	if(h <10){
		eval("document."+formName+"."+hh+".value ='0'+ h");
	}
	else{
		eval("document."+formName+"."+hh+".value = h");
	}
	if(mi <10){
		eval("document."+formName+"."+mins+".value ='0'+ mi");
	}
	else{
		eval("document."+formName+"."+mins+".value = mi");
	}
	
	eval("document."+formName+"."+year+".value = y");

 }
 
 /*show YEAR
*
*�Ӷ��ǻݱa�ѼơG���W�١B�~�����W��
**/
 function showYear(formName,year){	
	 nowdate = new Date();
	var y;
	y = nowdate.getFullYear() ;

	eval("document."+formName+"."+year+".value = y");

 }
