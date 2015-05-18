<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
}
//String sGetUsr = request.getParameter("usr");
String fltd = request.getParameter("fltdate");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("sector");
String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");
String nameurl = "http://tpecsap03.china-airlines.com/outstn/chnnamecii.aspx?empno="+sGetUsr+"&fontsize=14";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Check Menu</title>
<script language="JavaScript" type="text/JavaScript">
/*function Popup(){
	if(document.form1.sect.value.substr(3,3) == "KMG")
		if(document.form1.sGetUsr.value.substr(0,1) == "3")
			window.open('eHighElevation.htm', '', 'fullscreen=yes', false);
		else
			window.open('cHighElevation.htm', '', 'fullscreen=yes', false);
	//alert(document.form1.sGetUsr.value);
	return true;
}
function dochk()
{	
	var count = 0;	
        for (i=0; i < document.form1.length; i++) 
           {		
             if (document.form1.elements[i].checked) count++;	
           }
  //  	alert("xxxxxxxx=" + document.form1.sGetUsr.value.substr(0,1));	
  //	alert("yyyyyyyy=" + document.form1.sGetUsr.value.substr(0,3)); 
  // 	return false;
   if (document.form1.sGetUsr.value.substr(0,1) == "3" || document.form1.sGetUsr.value.substr(0,3) == "486")  
     { 
	 if(count <= 9 ) 	
         {	 
           if  (count == 9) 	   
              {		
                if (!document.form1.elements[6].checked)		  
                   {			
                      return true;		 
                   }		
                else if      (document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) != "KMG" 
                          && !document.form1.elements[9].checked))		   
                   {			
                      return true;		   
                   }		
                else if (document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) = "KMG"
                         && document.form1.elements[9].checked) && (document.form1.fleet.value != "744" 
                         && document.form1.fleet.value != "74F" && !document.form1.elements[5].checked))	                  
		   {				
                      return true;			
                   }		  
             }	
 	  else if (count == 8 )	  
	     {	       
               if ((document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" 
                    && !document.form1.elements[5].checked) && (document.form1.sect.value.substr(3,3) != "KMG" 
                    && !document.form1.elements[9].checked))		  
                  {
      	              return true;		   
                  }		       
               else if (!document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) != "KMG" 
                          && !document.form1.elements[9].checked))		   
                  {				
                      return true;		         
                  }		
               else		   
                  {		     
                      if  (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[9].checked)			                 
			{
                           window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno=" + document.form1.sGetUsr.value + "&fleet=ALL");			  
                          alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");		
                         }			                  
                          alert("Please confirm all items for duty !");			                          
                          return false;	          
                  }	
             }	         
          else if (count == 7 && document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" 
                  && !document.form1.elements[5].checked  &&  document.form1.sect.value.substr(3,3) != "KMG" 
                  && !document.form1.elements[9].checked  && !document.form1.elements[6].checked)					         
		 {	 			
                      return true;			
                 }		     
          else		        
                 {
                   if  (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[7].checked)				               
		      {					
                         window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno=" + document.form1.sGetUsr.value +"&fleet=ALL");					                 
                         alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");				
                       }			                        
                        alert("Please confirm all items for duty !");		                        
                        return false;		                
                 }	
         }	
       }    
   else     //   國籍機師
       {
 	if (count <= 8 )
        {	 
           if  (count == 8) 	   
              {		
                if (!document.form1.elements[6].checked)		  
                   {			
                      return true;		 
                   }		
                else if      (document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) != "KMG" 
                          && !document.form1.elements[9].checked))		   
                   {			
                      return true;		   
                   }		
                else if (document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) = "KMG"
                         && document.form1.elements[9].checked) && (document.form1.fleet.value != "744" 
                         && document.form1.fleet.value != "74F" && !document.form1.elements[5].checked))          
                    {				                     
			return true;			
                    }	  
              }	  //   if  (count == 8) 
 	  else if (count == 7 )	  
	     {	       
               if ((document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" 
                    && !document.form1.elements[5].checked) && (document.form1.sect.value.substr(3,3) != "KMG" 
                    && !document.form1.elements[9].checked))		  
                  {
      	              return true;		   
                  }		       
               else if (!document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) != "KMG" 
                          && !document.form1.elements[9].checked))		   
                  {				
                      return true;		         
                  }		
               else		   
                  {		     
                      if  (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[9].checked)         
			 {
                           window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno=" + document.form1.sGetUsr.value + "&fleet=ALL");	  
                           alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");		
                         }			                  
                          alert("Please confirm all items for duty !");			                          
			  return false;	          
                  }	
              }	   //  else if (count == 7 )	      
          else if (count == 6 && document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" 
                  && !document.form1.elements[5].checked  &&  document.form1.sect.value.substr(3,3) != "KMG" 
                  && !document.form1.elements[9].checked  && !document.form1.elements[6].checked)      
		 {	 			
                      return true;			
                 }		     
          else		        
                 {
                   if  (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[9].checked)		       
		       {					
                         window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno=" + document.form1.sGetUsr.value + "&fleet=ALL");        
                         alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");				
                       }			                        
                        alert("Please confirm all items for duty !");		                        
                        return false;		                
                 }
        }	// if(count <= 8 ) 
    else	
     {	
	//  alert("ddddddd = " + count);	      
       	return true;
     }

  }
	
}       // function dochk

*/
//SR3102
function Popup(){
	if(document.form1.sect.value.substr(3,3) == "LJG")
			window.open('check_plateau.jsp', '', 'fullscreen=yes', false);
	return true;
}

function dochk()
{	
	var count = 0;	
        for (i=0; i < document.form1.length; i++){		
             if (document.form1.elements[i].checked) count++;	
        }
  //  	alert("xxxxxxxx=" + document.form1.sGetUsr.value.substr(0,1));	
  //	alert("yyyyyyyy=" + document.form1.sGetUsr.value.substr(0,3)); 
  // 	return false;
	if (document.form1.sGetUsr.value.substr(0,1) == "3" || document.form1.sGetUsr.value.substr(0,3) == "486"){ 
		if(count <= 9 ){	
			if (count == 9){				
				//return false;
                if (!document.form1.elements[6].checked){
					return true;		 
                }
				else if(document.form1.elements[6].checked 
						&& (document.form1.sect.value.substr(3,3) != "LJG" && !document.form1.elements[9].checked)
						&& ((document.form1.fleet.value == "744" || document.form1.fleet.value == "74F") && document.form1.elements[5].checked)){			
					return true;		   
                }
				else if (document.form1.elements[6].checked 
						&& (document.form1.sect.value.substr(3,3) == "LJG" && document.form1.elements[9].checked) 
						&& (document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" && !document.form1.elements[5].checked)){				
					return true;			
                }
				else{
					alert("Please confirm all items for duty !");			                          
                    return false;
				}
				//alert("finished");				
			}
			else if (count == 8 ){	       
				   if ((document.form1.fleet.value != "744" && document.form1.fleet.value != "74F"  && !document.form1.elements[5].checked)
						&& (document.form1.sect.value.substr(3,3) != "LJG" && !document.form1.elements[9].checked)) {
						return true;		   
					}
					else if (!document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) != "LJG" && !document.form1.elements[9].checked)){				
						return true;		         
                  	}
					else if(!document.form1.elements[6].checked && (document.form1.fleet.value != "744" && document.form1.fleet.value != "74F"  && !document.form1.elements[5].checked)){
						return true;
					}
					else{		     
						/*
						if (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[9].checked){
                           window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno="+document.form1.sGetUsr.value+"&fleet=ALL");			  							
						   alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");		
                         }
						 */			                  
                          alert("Please confirm all items for duty !");			                          
                          return false;	          
                  	}	
            }
			else if (count == 7 && document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" 
                  && !document.form1.elements[5].checked  &&  document.form1.sect.value.substr(3,3) != "LJG" 
                  && !document.form1.elements[9].checked  && !document.form1.elements[6].checked){	 			
                      return true;			
            }
			else{
                  	/*
					if (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[7].checked){					
                         window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno=" + document.form1.sGetUsr.value +"&fleet=ALL");					                 			
						 alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");				
                     }	
				   */		                        
                        alert("Please confirm all items for duty !");		                        
                        return false;		                
            }	
        }else{	
			//alert("ddddddd = " + count);	      
			return true;
		}	
     }
	 else{//   國籍機師
		if (count <= 8 ){	 
            if  (count == 8){		
                if (!document.form1.elements[6].checked){
					return true;		 
                }
				else if(document.form1.elements[6].checked 
						&& (document.form1.sect.value.substr(3,3) != "LJG" && !document.form1.elements[9].checked)
						&& ((document.form1.fleet.value == "744" || document.form1.fleet.value == "74F") && document.form1.elements[5].checked)){			
					return true;		   
                }
				else if (document.form1.elements[6].checked 
						&& (document.form1.sect.value.substr(3,3) == "LJG" && document.form1.elements[9].checked) 
						&& (document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" && !document.form1.elements[5].checked)){				
					return true;			
                }
				else{
					alert("Please confirm all items for duty !");			                          
                    return false;
				}//if  (count == 8)				
			}
			else if (count == 7 ){	       
					if ((document.form1.fleet.value != "744" && document.form1.fleet.value != "74F"  && !document.form1.elements[5].checked)
						&& (document.form1.sect.value.substr(3,3) != "LJG" && !document.form1.elements[9].checked)) {
						return true;		   
					}
					else if (!document.form1.elements[6].checked && (document.form1.sect.value.substr(3,3) != "LJG" && !document.form1.elements[9].checked)){				
						return true;		         
                  	}
					else if(!document.form1.elements[6].checked && (document.form1.fleet.value != "744" && document.form1.fleet.value != "74F"  && !document.form1.elements[5].checked)){
						return true;
					}
					else{		     
						/*
						if (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[9].checked){
                           window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno="+document.form1.sGetUsr.value+"&fleet=ALL");			  							
						   alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");		
                         }
						 */			                  
                          alert("Please confirm all items for duty !");			                          
                          return false;	          
                  	}		
			}//  else if (count == 7 )	      
			else if (count == 6 && document.form1.fleet.value != "744" && document.form1.fleet.value != "74F" 
                  && !document.form1.elements[5].checked  &&  document.form1.sect.value.substr(3,3) != "LJG" 
                  && !document.form1.elements[9].checked  && !document.form1.elements[6].checked){	 			
						  return true;			
			}		     
			else{
				/*
				if  (document.form1.sect.value.substr(3,3) == "KMG" && !document.form1.elements[9].checked){					
					window.open("http://tsaweb02/df/CRCHlandArpMail.aspx?empno=" + document.form1.sGetUsr.value + "&fleet=ALL");        
					alert("已MAIL通知組派相關人員無法執行高原機場任務訊息 !");				
				}
				*/			                        
				alert("Please confirm all items for duty !");		                        
				return false;		                
			}
		}	// if(count <= 8 ) 
		else{	
			//alert("ddddddd = " + count);	      
			return true;
		}
	}	//end 國籍
}// function dochk


</script>
<style type="text/css">

.style2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 24px;
	font-weight: bold;
	color: #333333;
}
.style3 {font-family: Arial, Helvetica, sans-serif;
	font-size: 20px;
	font-weight: bold;
	color: #333333;
}
.style5 {
	color: #FF0000;
	font-size: 16px;
	font-weight: bold;
}

</style>
</head>

<body onLoad="Popup()">
<form name="form1" method="post" action="updcheck_menu.jsp" onSubmit="return dochk()">
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <table width="70%"  border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	    <td>
		<span class="style2">PIC/most senior crew on site must ensure your crew possess all the legal documents</span>
		<br><span class="style3">
		<span class="style5">Required for duty. Please tick in the box below to confirm : </span>
		<br>
	    </td>
	</tr>
   </table>
   <br>	
  <table width="70%"  border="0" align="center" cellpadding="0" cellspacing="0">
	
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> A valid Passport/ VISA</td></tr>
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"<%if (!sGetUsr.substring(0,1).equals("3") && !sGetUsr.substring(0,3).equals("486")) out.println("disabled");%>></td><td>&nbsp; </td><td><span class="style3"> A current Crew Member Certificate of ROC</td></tr>
        <!--<br><input type="checkbox" name="checkbox" value="Y">VALID AIRMAN CERTIFICATE (ATP/CPL) OF ROC-->
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> Valid Type Rating Certificate of ROC</td></tr>
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> Valid Airman Medical Certificate</td></tr>
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> CAL Employee Identification Card</td></tr>
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y" <%if (fleet != null && !fleet.equals("744") && !fleet.equals("74F")) out.println("disabled");%>></td><td>&nbsp; </td><td><span class="style3"> FAA SPPA – for 744N-Registered A/C (Special Purpose Pilot Authorization)</td></tr>
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> 台胞證MTPT(Mainland Travel Permits for Taiwan Residents) or China VISA, if required.</td></tr>  
	<tr valign="top"><td> </td><td>&nbsp; </td><td><span class="style3"> * 請檢查台胞證簡體姓名是否與目前簡體組員名單姓名一致 : <iframe name="myIframe" id="myIframe" src="<%=nameurl%>" width="65" height="24" frameborder="0" scrolling="no" marginheight="0"  marginwidth="0"></iframe>，若有不符請告知值班櫃檯更正。</tr>  
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> A functional working flashlight</td></tr> 
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y"></td><td>&nbsp; </td><td><span class="style3"> A spare set of glasses (if required by the medical certificate)</td></tr>
	<!--<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y" <%if (!sect.substring(3).equals("KMG")) out.println("disabled");%>></td><td>&nbsp; </td><td><span class="style3"> I confirm that my health condition is <span style="color:red;"><b>suitable </b></span> to conduct flight duty to a high elevation airport.</span></td></tr>-->
	<tr valign="top"><td><input type="checkbox" name="checkbox" value="Y" <%if (!sect.substring(3).equals("LJG")) out.println("disabled");%>></td><td>&nbsp; </td><td><span class="style3"> I confirm that I have  read the above information and my health condition is <span style="color:red;"><b>suitable </b></span> to conduct flight duty to Plateau Airport</span></td></tr>
  </table>
	
   <br>	
   <br>	
   <div align="center">
      	<input type="submit" 	style= "width:100px;height:40px;font-size:24px;" name="Submit" 	value="Save">&nbsp;&nbsp;&nbsp;&nbsp;
    	<input type="reset" 	style= "width:100px;height:40px;font-size:24px;" name="Submit" 	value="Reset">
    	<input name="fltd" 	type="hidden" 	value="<%=fltd%>">
	<input name="fltno" 	type="hidden" 	value="<%=fltno%>">
	<input name="sect" 	type="hidden" 	value="<%=sect%>">
	<input name="fleet" 	type="hidden" 	value="<%=fleet%>">
	<input name="rank" 	type="hidden" 	value="<%=rank%>">
	<input name="sGetUsr" 	type="hidden" 	value="<%=sGetUsr%>">
   </div>
</form>
</body>
</html>
