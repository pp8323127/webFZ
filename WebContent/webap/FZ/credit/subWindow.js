// JavaScript Document
function subwin(w,wname){	//設定開始視窗的長寬，開啟位置在螢幕中央
	wx = 600,wy=200;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
}

function subwinXY(w,wname,wx,wy){	//設定開始視窗的長寬，開啟位置在螢幕中央，自訂開啟大小
//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
}

// JavaScript Document
function open_win(w,wname,wx,wy){	//設定開始視窗的長寬，開啟位置在螢幕中央
	window.open(w,wname,"left="+wx+",top="+wy+",scrollbars=yes,resizable=yes, menubar=no, toolbar=no");
}
