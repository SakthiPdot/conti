/**
 * @Project_Name conti
 * @Package_Name custom js employee_service.js
 * @File_name employee_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */
contiApp.factory('ConfirmDialogService', ['$http', '$q', function ($http, $q){
	
	//------------------------- Confirm box begin -----------------------------------//
    
	var factory = {
			confirmBox : confirmBox,
			confirmBoxIndMsg :confirmBoxIndMsg
			
	};
	return factory;
    function confirmBox(title, type, msg, btnclass){
    	var deferred = $q.defer();
    	BootstrapDialog.confirm({
	  		
				title: title+' Confirmation',
				message: 'Do you want to '+msg,
				type: type, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
				closable: false, 
				draggable: false, 
				btnCancelLabel: 'No!', // <-- Default value is 'Cancel',
				btnOKLabel: 'Yes!', // <-- Default value is 'OK',
				btnOKClass: btnclass, // <-- If you didn't specify it, dialog type will be used,
				
				callback: function(x) {
					if(x) {
						deferred.resolve(x);
					}
					else {
						deferred.reject(x);
					}
					
				}
    	
		});
    	
    	return deferred.promise;
  }
    

    function confirmBoxIndMsg(title, type, msg, btnclass){
    	var deferred = $q.defer();
    	BootstrapDialog.confirm({
	  		
				title: title+' Confirmation',
				message: msg,
				type: type, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
				closable: false, 
				draggable: false,  
				// <-- Default value is 'Cancel',
				btnOKLabel: 'Ok', // <-- Default value is 'OK',
				btnOKClass: btnclass, // <-- If you didn't specify it, dialog type will be used,
				
				callback: function(x) {
					if(x) {
						deferred.resolve(x);
					}
					else {
						deferred.reject(x);
					}
					
				}
    	
		});
    	
    	return deferred.promise;
  }
    
//------------------------- Confirm box end -----------------------------------//
    
}]);