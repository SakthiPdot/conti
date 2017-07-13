/**
 * @Project_Name conti
 * @Package_Name custom js branch_service.js
 * @File_name branch_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jul 7, 2017 12:38:17 PM
 * @Updated_date_time Jul 7, 2017 12:38:17 PM
 */

contiApp.factory('BranchService', ['$http', '$q', function ($http, $q){
	var REST_SERVICE_URI = 'http://localhost:8080/Conti/branches/';
	
	var factory = {
			fetchAllBranches : fetchAllBranches,
			createBranch:createBranch,
		//	updatedBranch:updatedBranch,
			deleteBranch:deleteBranch
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
	
	//-----------Fetch Create branch--------------
	
	function createBranch(branch)
	{
		var deferred=$q.defer();
		var headers=getCsrfHesder();
		$http({
			method:'POST',
			url:'create_branch',
			data:branch,
			headers:headers
		})
		.then(function(response)
				{
					deferred.resolve(response.date);
				},
				function (errResponse)
				{
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
		//-----------Fetch Create branch End--------------
		
		//-----------------Delete Branch begin Start----------------
		
		function deleteBranch(id)
		{
			var deferred=$q.defer();
			$http({
				method:'DELETE',
				url:delete_employee/+id,
				headers:getCrsfHeader()
			}).then(
				function (response)
				{
					deferred.resolve(response.data);
				},
				function(errResponse)
				{
					deferred.reject(errResponse);
				}
			);
			return deferred.promise;
		}
    
		//-----------------Delete Branch begin End----------------
		
		//------------------Update Branch begin start --------------
		function updateBranch(branch,id)
		{
			var deferred=$q.defer();
			$http({
				method:'PUT',
				url:'update_branch/'+id,
				header:getCsrfHeader()
			})
			.then(
					function(response)
					{
						deferred.resolve(response.data);
					},
					function (errResponse)
					{
						deferred.reject(errResponse);
					}
				);
				return deferred.promise;
		}
		//------------------Update Branch begin End--------------
		
}]);