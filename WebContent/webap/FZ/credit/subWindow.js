// JavaScript Document
function subwin(w,wname){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù�����
	wx = 600,wy=200;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
}

function subwinXY(w,wname,wx,wy){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù������A�ۭq�}�Ҥj�p
//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
}

// JavaScript Document
function open_win(w,wname,wx,wy){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù�����
	window.open(w,wname,"left="+wx+",top="+wy+",scrollbars=yes,resizable=yes, menubar=no, toolbar=no");
}