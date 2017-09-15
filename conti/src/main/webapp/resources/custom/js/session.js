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
	    	console.log("inside successanimate");
	    	window.setTimeout( function(){
	    		/*$('body').addClass('scrollHidden');*/
	    		$(element).removeClass('hideme');
	    		
	    		animationOpenClick(element,'bounceInDown');
	    	}, 200);
			
			window.setTimeout( function(){
				animationOpenClick(element,'bounceOutUp');
				
	    	}, 4000); 
			window.setTimeout( function(){
				$(element).addClass('hideme');	
/*//				$('body').removeClass('scrollHidden');
*/	    	}, 5000);
	    } 
	//------------------------- Success animate end ---------------------------------- //	
	    
		//------------------------- Success animate begin ---------------------------------- //    
	    function viewShipment_Animate(element, action){
	    	
	    	if ( action ==  'OPEN') {
	    		
	    		$('body').addClass('scrollHidden');
		    	
		    	window.setTimeout( function(){
		    		$('.overlay').removeClass('hideme');
		    		animationOpenClick('.overlay','fadeIn');
		    		$(element).removeClass('hideme');
		    		animationOpenClick(element,'fadeInDown');
		    	}, 200);
		    	
	    	} else {
	    		$('body').removeClass('scrollHidden');
		    	
		    	window.setTimeout( function(){
		    		animationOpenClick('.overlay','fadeOut');
		    		
		    		animationOpenClick(element,'fadeOutUp');
		    		
		    	}, 200);
		    	
		    	window.setTimeout(function(){
		    		$('.overlay').addClass('hideme');
		    		$(element).addClass('hideme');
		    	}, 1000);
	    	}
	    	
		
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

	 		 $.ajax({
	 		        url : 'logout',
	 		        type : 'POST',
	 		        data: token,
	 		        beforeSend:function(xhr){
	 		             xhr.setRequestHeader(header, token);
	 		        },
	 		        success : function(data) { 
	 		        	window.location ="/login?logout";    
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
				console.log(valid);
		 		  valid = true;			
		 		}); 
			
			$("tr").on("dblclick", function() {
		 		  valid = true;			
		 		});
	 	
	 	  $("a").bind("click", function() {
	 		  valid = true;			
	 		}); 
	 	  
	 	 $(document).on("submit", "form", function(event){
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
	 		 
//-------------------- SHIPMENT BILL OPEN BEGIN
	 		function bill_open(shipment_id){
	 			valid = true;
	 			/*window.open("shipment_bill?lrno="+lrno, '_blank');*/
	 			window.open("LR_print/"+shipment_id, '_blank');
	 			/*window.location.href = "shipment_bill?lrno="+lrno;*/
	 		}
//-------------------- SHIPMENT BILL OPEN END	 	
	 		function afterSave(receipt_no){
				valid = true;
				/*location.href='view_receipt';*/
				window.open("Receipt_print/"+receipt_no, '_blank');
			}
	 		
	 		
	 		function afterManifestSave(id){
				valid = true;
				window.open("ManifestPdfPrint/"+id);
				//location.href="ManifestPdfPrint/"+id;
			}