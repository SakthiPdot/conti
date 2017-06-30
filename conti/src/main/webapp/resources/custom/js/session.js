/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name session.js
 * @author Sankar
 * @Updated_user Monu.C
 * @Created_date_time Jun 21, 2017 8:05:17 PM
 * @Updated_date_time Jun 21, 2017 8:05:17 PM 
 */


//------------------------- CSRF begin ---------------------------------- //	
	 function getCsrfHeader() {
		 
		 var csrfToken = $("input[name='_csrf']").val();
	
		 var headers = {}; 
		 headers["X-CSRF-TOKEN"] = csrfToken;
		 headers["_csrf"] = csrfToken;
		 
		 return headers;
	 }; 	
	 //------------------------- CSRF end ---------------------------------- //

	//------------------------- animate dynamic element begin ---------------------------------- //
	    function animationOpenClick(element, animation){
	    	element = $(element);				
	    	element.addClass('animated ' + animation);        
	    	// wait for animation to finish before removing classes
	    	window.setTimeout( function(){
	    		element.removeClass('animated ' + animation);
	    	}, 5000);         
	    }
	//------------------------- animate dynamic element end ---------------------------------- //
	    
	//------------------------- Success animate begin ---------------------------------- //    
	    function successAnimate(element){
	    	
	    	window.setTimeout( function(){
	    		/*$('body').addClass('scrollHidden');*/
	    		$(element).removeClass('hideme');
	    		
	    		animationOpenClick(element,'bounceInDown');
	    	}, 1000);
			
			window.setTimeout( function(){
				animationOpenClick(element,'bounceOutUp');
				
	    	}, 3000); 
			window.setTimeout( function(){
				$(element).addClass('hideme');	
/*//				$('body').removeClass('scrollHidden');
*/	    	}, 4000);
	    } 
	//------------------------- Success animate end ---------------------------------- //	
	    
	//------------------------- Success animate for forgot begin ---------------------------------- //    
	    function successforgot_AnimateOpen(element){
	    	
	    	window.setTimeout( function(){
	    		$('.overlay').removeClass('hideme');
	    		
	    		animationOpenClick('.overlay','fadeIn');
	    	}, 1000);
	    	
	    	window.setTimeout( function(){
	    		$(element).removeClass('hideme');
	    		
	    		animationOpenClick(element,'bounceInDown');
	    	}, 2000);
			
			
	    }
	    function successforgot_AnimateClose(element){
	    	window.setTimeout( function(){
				animationOpenClick(element,'bounceOutUp');
				
	    	}, 1000); 
			window.setTimeout( function(){
				$(element).addClass('hideme');	
	    	}, 2500);
			
			window.setTimeout( function(){
				animationOpenClick('.overlay','fadeOut');
				
	    	}, 2000);
			
			window.setTimeout( function(){
				$('.overlay').addClass('hideme');	
	    	}, 3000);
	    }
	//------------------------- Success animate end ---------------------------------- //	
	 
// ------------------------ track Session ------------------------------------------------ // 
 		
		var valid = false;
		
		function force_logout () {
	 		
	 		 var token = $("meta[name='_csrf']").attr("content");
	 		 var header = $("meta[name='_csrf_header']").attr("content");
	 		 alert("call force_logout");
	 		 $.ajax({
	 		        url : 'logout',
	 		        type : 'POST',
	 		        data: token,
	 		        beforeSend:function(xhr){
	 		             xhr.setRequestHeader(header, token);
	 		        },
	 		        success : function(data) { 
	 		        	window.location ="http://localhost:8080/Conti/login?logout";    
	 		        }, 
	 		        error : function(data) {
	 		            console.log(data);
	 		        }
	 		    });
	 	} 

//		 window.onload = function (e) {
//			
//			  console.log(e);
//		  }
		 
			window.onbeforeunload = function(e) {	
				console.log(e);
				
	 	        if( !valid ){
	 	        	force_logout();
	 	        }
	 	       } 
			 
			$("button").on("click", function() {
		 		  valid = true;			
		 		}); 
			
			$("tr").on("dblclick", function() {
		 		  valid = true;			
		 		});
	 	
	 	  $("a").bind("click", function() {
	 		  valid = true;			
	 		}); 
	 	  
	 		  $(document.body).on("keydown", this,
	 		     function (event) {
	 			  
	 		        if (event.keyCode == 116) { valid = true; } 
	 		        if( event.keyCode == 82 && event.ctrlKey) { valid = true; } 
	 		        if( event.keyCode == 82 && event.ctrlKey && event.shiftKey ) { valid = true; }
	 		});
			
	 		 function setValidtrue(){
	 			 valid = true;
}