/**
 * �Ŀ��A�|�N������check �֨��Ψ���
 * �ݱa�ܼơG
 * @param forname:���W��
 * @param checkAllName:���Ŀ諸column
 * 
 *  ��function�|��Ҧ���coulunn���Ŀ�A�]��checkAllName�̭��n���ܼƬO���Ŀ諸�خ�
 * */

/*
�ϥήɾ��A�b�Ŀ�������Ŀ�ؤ��A�[�JonClick event:  
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
