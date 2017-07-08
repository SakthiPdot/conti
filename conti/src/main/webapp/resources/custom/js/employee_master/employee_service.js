/**
 * @Project_Name conti
 * @Package_Name custom js employee_service.js
 * @File_name employee_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */
contiApp.factory('EmployeeService', ['$http', '$q', function ($http, $q){
	var REST_SERVICE_URI = 'http://localhost:8080/Conti/employees/';
	
	var factory = {
			fetchAllEmployees : fetchAllEmployees,
			fetchEmpCat :fetchEmpCat,
			createEmployee : createEmployee
	};
	
	return factory;
	//-------------------------- Fetch All Employees begin ---------------------//	
	function fetchAllEmployees() {
		var deferred = $q.defer();
		$http.get(REST_SERVICE_URI)
			.then(
					function (response) {
						deferred.resolve(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching employees");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Employees end ---------------------//	
	
	//-------------------------- Fetch Employee category begin ---------------------//
	function fetchEmpCat() {
		var deferred = $q.defer();
		$http.get(REST_SERVICE_URI+'category/')
			.then(
					function (response) {
						deferred.resolve(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching employees");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch Employee category end ---------------------//	
	
    function createEmployee(employee) {
        var deferred = $q.defer();
        var headers = getCsrfHeader();
        
    	$http({
    		method : 'POST',
    		url : 'create_employee',
    		data : employee,
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
 
    
    
}]);