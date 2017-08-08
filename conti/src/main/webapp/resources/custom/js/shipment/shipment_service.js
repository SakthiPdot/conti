/**
 * @Project_Name conti
 * @Package_Name custom js shipment_service.js
 * @File_name shipment_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 27, 2017 03:13:17 PM
 * @Updated_date_time Jun 27, 2017 03:13:17 PM
 */
contiApp.factory('ShipmentService', ['$http', '$q', function ($http, $q){
	
	var factory = {
			createShipment : createShipment
	};
	
	return factory;

    
	//---------------------------------- Create shipment begin
	
	 function createShipment(shipment) {
	        var deferred = $q.defer();
	        
	    	$http({
	    		method : 'POST',
	    		url : 'create_shipment',
	    		data : shipment,
	    		headers : getCsrfHeader()
	    	})
	    	.then(
	    			function (response) {    				
	    				deferred.resolve(response.data);
	    			},
	    			function (errResponse) {
	    				deferred.reject(errResponse);
	    			}
	    		);
	    		return deferred.promise;
	     
	    }
	 
		//---------------------------------- Create shipment end
}]);