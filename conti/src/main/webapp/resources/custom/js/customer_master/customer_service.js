/**
 * @Project_Name conti
 * @Package_Name custom js customer_service.js
 * @File_name customer_service.js
 * @author Suresh
 * @Updated_user Suresh
 * @Created_date_time July 14, 2017 12:59:17 PM
 * @Updated_date_time July 14, 2017 12:59:17 PM
 */

contiApp.factory('CustomerService', ['$http', '$q', function ($http, $q){
	//var REST_SERVICE_URI = 'http://localhost:8080/Conti/customers/';
	
	var factory = {
			fetchAllCustomers : fetchAllCustomers,
			
			createCustomer : createCustomer,
			updateCustomer : updateCustomer,
			deleteCustomer : deleteCustomer,
			makeActive : makeActive,
			makeinActive : makeinActive,
			registerSearch : registerSearch,
			pagination_byPage : pagination_byPage,
			findrecord_count : findrecord_count
			/*print : print*/
	};
	
	return factory;
	
	
	//-------------------------- Fetch All Customers begin ---------------------//	
	function fetchAllCustomers() {
		var deferred = $q.defer();
		$http.get('customers/')
			.then(
					function (response) {
						deferred.resolve(response.data);
						console.log(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching Customers");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Customers end ---------------------//	
	
	//-------------------------- Fetch Customer category begin ---------------------//
//	function fetchEmpCat() {
//		var deferred = $q.defer();
//		$http.get(REST_SERVICE_URI+'category/')
//			.then(
//					function (response) {
//						deferred.resolve(response.data);
//					},
//					function (errResponse) {
//						console.log("Error while fetching employees");
//						deferred.reject(errResponse);
//					}
//				);
//		return deferred.promise;
//	}
	//-------------------------- Fetch Employee category end ---------------------//	
	
    function createCustomer(customer) {
        var deferred = $q.defer();
        var headers = getCsrfHeader();
        
    	$http({
    		method : 'POST',
    		url : 'create_customer',
    		data : customer,
    		headers : headers
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
    		
       /* $http.post(REST_SERVICE_URI, employee)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while creating User');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;*/
    }
 
    //------------------------------- Delete Customer begin -----------------------------//
    function deleteCustomer(id) {
    	var deferred = $q.defer();
    	$http({
    		method : 'DELETE',
    		url : 'delete_customer/'+id,
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
    //------------------------------- Delete Customer end -----------------------------//
    
    //------------------------------- Delete Customer begin -----------------------------//
    function updateCustomer(customer) {
    	var deferred = $q.defer();
    	console.log("Update customer service call");
    	$http({
    		method : 'POST',
    		url : 'update_customer',
    		data:customer,
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
    //------------------------------- Delete Customer end -----------------------------//
    
    
    //------------------------------- make active Customer begin -----------------------------//
    function makeActive(id) {
    	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'make_active_customer',
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
    //------------------------------- make active Customer end -----------------------------//

    //------------------------------- make inactive Customer begin -----------------------------//
    function makeinActive(id) {
    	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'make_inactive_customer',
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
    //------------------------------- make inactive Customer end -----------------------------//

    
  //--------------------------- Register search begin -----------------------------//
    function registerSearch(searchkey) {
    	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'register_search_customer',
    		data : searchkey,
    		headers : getCsrfHeader()
    	})
    	.then (
    		function (response) {
    			console.log(response.data);
    			deferred.resolve(response.data);
    		},
    		function (errResponse) {
    			deferred.reject(errResponse);
    		}
    	);
    	return deferred.promise;
    }
    //--------------------------- Register search end -----------------------------// 
    
    
    
 // --------------------------- Pagination begin ------------------------------//
    function pagination_byPage(page) {
    	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'pagination_customer',
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
      
  //----------------------  Recourd count users begin ----------------------------- //
    function findrecord_count() {
    	
        var deferred = $q.defer();
        $http.get('customer_record_count/')
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users record count');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    //----------------------  Record Count users end ----------------------------- //
	
}]);