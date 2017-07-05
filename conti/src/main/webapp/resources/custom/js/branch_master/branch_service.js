/**
 * @Project_Name conti
 * @Package_Name custom js branch_service.js
 * @File_name branch_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jul 7, 2017 12:38:17 PM
 * @Updated_date_time Jul 7, 2017 12:.38:17 PM
 */

contiApp.factory('BranchService', ['$http', '$q', function ($http, $q){
	var REST_SERVICE_URI = 'http://localhost:8080/Conti/branches/';
	
	var factory = {
			fetchAllBranches : fetchAllBranches
			};
	
	return factory;
	//-------------------------- Fetch All Branches begin ---------------------//	
	function fetchAllBranches() {
		var deferred = $q.defer();
		$http.get(REST_SERVICE_URI)
			.then(
					function (response) {
						deferred.resolve(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching employees");
						deferred.regject(erResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Branches end ---------------------//	
	
    
    
}]);