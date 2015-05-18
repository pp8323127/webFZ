/**
 * 勾選後，會將全部的check 核取或取消
 * 需帶變數：
 * @param forname:表單名稱
 * @param checkAllName:勾選全部的 checkbox name
 * 
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