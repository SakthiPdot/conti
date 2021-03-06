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
			createShipment : createShipment,
			fetchMAXLRno : fetchMAXLRno,
			fetchAllShipmentforView : fetchAllShipmentforView,
			filterShipment : filterShipment,
			searchShipment : searchShipment,
			shipment_delete : shipment_delete,
			makeCancel: makeCancel,
			findrecord_count : findrecord_count,
			pagination_byPage : pagination_byPage,
			sortBy: sortBy
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
	    				console.log(response);	
	    				deferred.resolve(response.data);
	    			},
	    			function (errResponse) {
	    				deferred.reject(errResponse);
	    			}
	    		);
	    		return deferred.promise;
	     
	    }
	 
		//---------------------------------- Create shipment end
	 
	//---------------------------------- FETCH MAXLRNO begin
	 
	 function fetchMAXLRno(branch_id) {
		 
		 var deferred = $q.defer();
			$http.get('fetchMAXlrno/'+branch_id)
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
	 
	  
	//---------------------------------- FETCH MAXLRNO END
	 
	//---------------------------------- FETCH ALL SHIPMENT BEGIN
	 function fetchAllShipmentforView() {
		 var deferred = $q.defer();
		 $http.get('fetchshipmentforview/')
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
		//---------------------------------- FETCH ALL SHIPMENT END
	 
		//---------------------------------- VIEW SHIPMENT FILTER begin
		
	 function filterShipment(viewShipment) {
	        var deferred = $q.defer();
	        
	    	$http({
	    		method : 'POST',
	    		url : 'filter_shipment',
	    		data : viewShipment,
	    		headers : getCsrfHeader()
	    	})
	    	.then(
	    			function (response) {  
	    				console.log(response);	
	    				deferred.resolve(response.data);
	    			},
	    			function (errResponse) {
	    				deferred.reject(errResponse);
	    			}
	    		);
	    		return deferred.promise;
	     
	    }
	 
		//---------------------------------- VIEW SHIPMENT FILTER END 
	 
	 //------------------------------------- SEARCH BY LR FOR VIEW SHIPEMNT BEGIN
	 
	 function searchShipment(lrno) {
		 var deferred = $q.defer();
		 
		 $http({
			 method : 'POST',
			 url : 'shipment_searchbylr',
			 data : lrno,
			 headers : getCsrfHeader()
		 })
		 .then (
				 function (response) {
					 deferred.resolve(response.data);
				 },
				 function (errResponse) {
					 deferred.reject(errResponse);
				 }
			);
		 
		 	return deferred.promise;
	 }
	 
	 //------------------------------------- SEARCH BY LR FOR VIEW SHIPEMNT END

	 //------------------------------------- SHIPEMNT DELETE BEGIN
	 
	 function shipment_delete(id) {
		 var deferred = $q.defer();
		 $http({
			 method : 'DELETE',
			 url : 'delete_shipment/'+id,
			 headers : getCsrfHeader()			 
		 })
		 .then (
				 function (response) {
					 deferred.resolve(response.data);
				 },
				 function (errResponse) {
					 deferred.reject(errResponse);
				 }
				);
		 return deferred.promise;
	 }
	 
	 //------------------------------------- SHIPEMNT DELETE END
	 
	//------------------------------- make active Employee begin -----------------------------//
	    function makeCancel(id) {
	    	var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'make_cancel',
	    		data : id,
	    		headers : getCsrfHeader()
	    	})
	    	.then (
	    		function (response) {
	    			deferred.resolve(response.data);
	    		},
	    		function (errResponse) {
	    			deferred.reject(errResponse);
	    		}
	    	);
	    	return deferred.promise;
	    }
	    //------------------------------- make active Employee end -----------------------------//
	    
	    //----------------------  Recount count users begin ----------------------------- //
	    function findrecord_count() {
	    	
	        var deferred = $q.defer();
	        $http.get('shipment_record_count/')
	            .then(
	            function (response) {
	                deferred.resolve(response.data);
	            },
	            function(errResponse){
	                deferred.reject(errResponse);
	            }
	        );
	        return deferred.promise;
	    }
	    //----------------------  Record Count users end ----------------------------- //
	    
	    // --------------------------- Pagination begin ------------------------------//
	    function pagination_byPage(page) {
	    	var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'shipment_pagination',
	    		data : page,
	    		headers : getCsrfHeader()
	    	})
	    	.then (
	    		function (response) {
	    			deferred.resolve(response.data);
	    		},
	    		function (errResponse) {
	    			deferred.reject(errResponse);
	    		}
	    	);
	    	return deferred.promise;
	    }
	    // --------------------------- Pagination end ------------------------------//    

		//=============================sort by name====================================
		function sortBy(name,status){	
			var deferred=$q.defer();
			$http({
				method:'POST',
				url:"sortShipment/"+name,
				data:status,
				headers:getCsrfHeader()
			}).then(
					function(response){
						deferred.resolve(response.data);
					},function(errResponse){
						deferred.reject(errResponse);
					}
			);
			return deferred.promise;
		}
}]);

