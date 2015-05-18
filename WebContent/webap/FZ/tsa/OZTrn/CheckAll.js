/**
 * 勾選後，會將全部的check 核取或取消
 * 需帶變數：
 * @param forname:表單名稱
 * @param checkAllName:不勾選的column
 * 
 *  此function會把所有的coulunn都勾選，因此checkAllName裡面要放的變數是不勾選的框框
 * */

/*
使用時機，在勾選全部的勾選框內，加入onClick event:  
ex:
<input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')">

*/

function CheckAll(formName,checkAllName)
{
for (var i=0;i< eval("document."+formName+".elements.length");i++)
 {
   var e = eval("document."+formName+".elements[i]");
    if (e.name != checkAllName)
          e.checked = !e.checked;
 }
}
