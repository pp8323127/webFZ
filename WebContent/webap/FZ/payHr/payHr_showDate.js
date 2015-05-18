function showPrevYM(formName, year, month){
    today=new Date();
	
	var y, m;
    y = today.getFullYear();
	m = today.getMonth();

    eval("document."+formName+"."+year+".value = y");

	if (m == 0){
	    m = 12;
	    y--;
	}		

	if (m < 10) {
       eval("document."+formName+"."+month+".value = '0'+m");
    }else{
       eval("document."+formName+"."+month+".value = m");
    }
   
}


function showCurrYM(formName, year, month){
    today=new Date();
	
	var y, m;
    y = today.getFullYear();
	m = today.getMonth()+1;

    eval("document."+formName+"."+year+".value = y");

	if (m < 10) {
       eval("document."+formName+"."+month+".value = '0'+m");
    }else{
       eval("document."+formName+"."+month+".value = m");
    }
   
		
}

function showCurrYMD(formName, year, month, day, iDays){
    today=new Date();
	
	var y, m, d;
    y = today.getFullYear();
	m = today.getMonth()+1;
	d =  today.getDate();

	if (m < 10) {
       eval("document."+formName+"."+month+".value = '0'+m");
    }else{
       eval("document."+formName+"."+month+".value = m");
    }
	
	if (d < 10) {
       eval("document."+formName+"."+day+".value ='0'+ d");
    }else{
       eval("document."+formName+"."+day+".value = d");
    }
   
    eval("document."+formName+"."+year+".value = y");		
}

function showNextYMD(formName, year, month, day, iDays){
    today=new Date();
	
	var y, m, d;
    y = today.getFullYear();
    m = today.getMonth()+2;
	d = 1;

	if (m > 12){
	    m -= 12;
	    y++;
	}	

	if (m < 10) {
       eval("document."+formName+"."+month+".value = '0'+m");
    }else{
       eval("document."+formName+"."+month+".value = m");
    }
	
	if (d < 10) {
       eval("document."+formName+"."+day+".value ='0'+ d");
    }else{
       eval("document."+formName+"."+day+".value = d");
    }
   
    eval("document."+formName+"."+year+".value = y");		
}

function showNextNextYMD(formName, year, month, day, iDays){
    today=new Date();
	
	var y, m, d;
    y = today.getFullYear();
    m = today.getMonth()+3;
	d = 10;
	
	if (m > 12){
	    m -= 12;
	    y++;
	}	

	if (m < 10) {
       eval("document."+formName+"."+month+".value = '0'+m");
    }else{
       eval("document."+formName+"."+month+".value = m");
    }
	
	if (d < 10) {
       eval("document."+formName+"."+day+".value ='0'+ d");
    }else{
       eval("document."+formName+"."+day+".value = d");
    }
 
    eval("document."+formName+"."+year+".value = y");		
}


