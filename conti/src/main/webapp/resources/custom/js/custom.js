

	 			console.log("EEEEEEEEEEEEEEEEEE");
 $( function() 
			{

			   $(".datepicker").datepicker({ 
			        format: 'dd-mm-yyyy',
			        orientation: 'auto top',
			        autoclose: true,
			        clearBtn:true,
			        todayHighlight:true,
			        forceParse:true,
			    });
			 
			   
		 	   $(".datepicker").datepicker({minDate: -10, maxDate: '+1M +10D'});
		 	  
			});
 
// begin---------------------//



function drawerOpen(drawerName){
	
	
	window.setTimeout(function(){	
		animationOpenClick('.overlay', 'fadeIn');	
	},750);
	
	window.setTimeout(function(){	
		$('.overlay').removeClass('hideme');
	},1400);
	
	window.setTimeout(function(){	
		$(drawerName).removeClass('hideme');
		$('body').addClass('scrollHidden');
	},1500);

	window.setTimeout(function(){	
		animationOpenClick(drawerName, 'bounceInRight');
	},1500);
	
}

function drawerClose(drawerName){
	animationOpenClick(drawerName, 'bounceOutRight');
	//$('.overlay').addClass('hideme');

	window.setTimeout(function(){							
	$(drawerName).addClass('hideme');
	
	},1000);
	
	window.setTimeout(function(){	
		animationOpenClick('.overlay', 'fadeOut');	
	},1200);
	
	window.setTimeout(function(){	
		$('.overlay').addClass('hideme');
		$('body').removeClass('scrollHidden');
	},1500);
}
//---------------------------- Animate function
// begins----------------------------------//
function animationOpenClick(element, animation){
	element = $(element);				
	element.addClass('animated ' + animation);        
	// wait for animation to finish before removing classes
	window.setTimeout( function(){
		element.removeClass('animated ' + animation);
	}, 1000);         

}
// ---------------------------- Animate function
// end----------------------------------//


/*$('.drawerClose').click(function(){
	
	animationOpenClick('.drawer', 'bounceOutRight');
	//$('.overlay').addClass('hideme');

	window.setTimeout(function(){							
	$('.drawer').addClass('hideme');
	
	},1000);
	
	window.setTimeout(function(){	
		animationOpenClick('.overlay', 'fadeOut');	
	},1200);
	
	window.setTimeout(function(){	
		$('.overlay').addClass('hideme');
		$('body').removeClass('scrollHidden');
	},1500);
	
});*/
// ------------------------------ Drawer Open event
// end---------------------//




 