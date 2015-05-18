var HINTS_CFG = {
	'top'        : 5, // a vertical offset of a hint from mouse pointer
	'left'       : 5, // a horizontal offset of a hint from mouse pointer
	'show_delay' : 500, // a delay between object mouseover and hint appearing
	'hide_delay' : 2000, // a delay between hint appearing and hint hiding
	'wise'       : true,
	'follow'     : true,
	'z-index'    : 0 // a z-index for all hint layers
},

HINTS_ITEMS = {
	'vSkj':wrap("View Crew's Schedule"), 
	'vCrew':wrap("View Crew's Information"), 
	'vList':wrap("View Flight Crew List"),
	'eCrew':wrap("Email to Crew")
	
};

var myHint = new THints (HINTS_CFG, HINTS_ITEMS);

function wrap (s_) {
	return "<table cellpadding='0' cellspacing='0' border='0' style='background-color:#CCFFFF;border:1pt solid #000000;' ><tr><td nowrap>"+s_+"</td></tr></table>"
}

