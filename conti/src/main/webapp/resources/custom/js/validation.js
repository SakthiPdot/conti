

//type='text' maxlength="8"
//onKeyPress="return CheckIsAlphaNumeric(event)"
//
//  onKeyPress="return CheckIsNumeric(event)
//  onKeyPress="return CheckIsNumericAnddot(event,this.value) 
//  onKeyPress="return CheckIsNumericAndHyphen(event,this.value) 
//
//  onKeyPress="return CheckIsCharacter(event)
//  onKeyPress="return CheckIsCharacterWithspace(event,this.value) 
//
//  onKeyPress="return CheckIsAlphaNumeric(event)
//  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value) 

$(document).ready(function() {
	

	 $(".disabled").css("tabindex", "-1");
	
	$(document).bind('keydown', function(e) {
		
		
		
		
	if(e.ctrlKey && (e.which == 83)) {
		    e.preventDefault();
		    return false;
		  }
	
	if(e.ctrlKey && (e.which == 119)) {
		 var check=confirm("Press a button!");
		 if(check){
		    e.preventDefault();	
		    return false;
		 }
	  }
	});
	
	

	// Disable cut copy paste	
	$('body').bind('cut copy paste drop', function(e) {
		e.preventDefault();
	});

	// Disable mouse click
	$('body').on("contextmenu", function() {
		return false;
	})

});
  function isNumberKey(evt)
  {
     var charCode = (evt.which) ? evt.which : event.keyCode
     if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

     return true;
  }
  
  
  //ONLY ACCEPTS NUMERIC VALUE AND CHARSET LESS THAN 31
  function CheckIsNumeric(objEvt) {
      var charCode = (objEvt.which) ? objEvt.which : objEvt.keyCode
      if (charCode > 31 && (charCode < 48 || charCode > 57)) {       
         
    	  return false;
      }
      else {   
    	
    		  return true;  
      }
  }
  
  
  //ONLY ACCEPTS NUMERIC VALUE AND CHARSET LESS THAN 31 AND DOT
  function CheckIsNumericAnddot(objEvt,str) {
      var charCode = (objEvt.which) ? objEvt.which : objEvt.keyCode
      if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {       
          return false;
      }
      else {   
    	  
     	  if (str && charCode == 46) {
      		 if(str.includes(".")){
      			 return false;	
      		 }else{
      			 return true; 
      		 }
      	  } else if(charCode == 46){ 
      			  return false; 
      	  }else {        
      	          return true;
            }
      }
  }

  //ONLY ACCEPTS NUMERIC VALUE AND CHARSET LESS THAN 31 AND -
  function CheckIsNumericAndHyphen(objEvt) {
      var charCode = (objEvt.which) ? objEvt.which : event.keyCode
      if (charCode != 45 && charCode > 31 && (charCode < 48 || charCode > 57)) {       
          return false;
      }
      else {       
          return true;
      }
  }
  

  //ONLY ACCEPTS CHARACTER VALUE AND CHARSET LESS THAN 31 AND DOT
  function CheckIsCharacterWithspace(objEvt,str) {
	  
      var charCode = (objEvt.which) ? objEvt.which : event.keyCode
      if ((charCode < 33) || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)|| (charCode=46)) {      

    	  if (str && charCode == 32) {
    		 if(str.endsWith(" ")){
    			 return false;	
    		 }else{
    			 return true; 
    		 }
    	  } else if(charCode == 32){ 
    			  return false; 
    	  }else {        
    	          return true;
          }
       }else{
              return false;
      	}
  }
  

  //CHECKS BOTH ALPHABET AND NUMERIC
  function CheckIsAlphaNumericWithspace(objEvt,str) {
      var charCode = (objEvt.which) ? objEvt.which : objEvt.keyCode
  	if  ((charCode > 47 && charCode < 58) || 
  			(charCode < 33) || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)){  // a-z
  		
  		
  		if (str && charCode == 32) {
    		 if(str.endsWith(" ")){
    			 return false;	
    		 }else{
    			 return true; 
    		 }
    	  } else if(charCode == 32){ 
    			  return false; 
    	  }else {        
    	          return true;
          }
  		
  		
  	}else{
          return false;
  	}	

  }
  

  //ONLY ACCEPTS CHARACTER VALUE AND CHARSET LESS THAN 31 AND DOT
  function CheckIsCharacter(objEvt) {

      var charCode = (objEvt.which) ? objEvt.which : objEvt.keyCode
      if ((charCode < 32) || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)) {      
      
    	          return true;
         
       }else{
              return false;
      	}
  }
  //CHECKS BOTH ALPHABET AND NUMERIC
  function CheckIsAlphaNumeric(objEvt) {
      var charCode = (objEvt.which) ? objEvt.which : objEvt.keyCode
  	if  ((charCode > 47 && charCode < 58) || 
  			(charCode < 32) || (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)){  // a-z
  			 return true; 
  	}else{
          return false;
  	}	

  }
 