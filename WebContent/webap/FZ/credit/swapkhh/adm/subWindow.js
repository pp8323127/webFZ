// JavaScript Document
function subwin(w,wname){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù�����
	wx = 800,wy=600;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top=10,width="+wx+",height="+wy+",location=yes,scrollbars=yes,alwaysRaised=yes,toolbar=yes");
}
function subwinXY(w,wname,wx,wy){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù������A�ۭq�}�Ҥj�p
//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
}