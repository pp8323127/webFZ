// JavaScript Document
//關閉視窗
/**
*  傳入參數 w :母視窗的檔名
*/
function close_self(w){	//新增完畢後，將母視窗重新整理，並關閉本視窗
	window.opener.location.href=w;
	self.close();
}