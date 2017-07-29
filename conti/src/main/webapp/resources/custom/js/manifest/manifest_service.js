/**
 * @Project_Name conti
 * @Package_Name custom js Manifest
 * @File_name manifest_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time July 24, 2017 3:31:53 PM
 */

contiApp.factory('ManifestService',['$http','$q',function($http,$q)
{
	var factory={
			fetchAllManifest:fetchAllManifest
			//manifestFilter:manifestFilter
	};
	
	return factory;
	//-------------------------- Fetch All Manifest begin ---------------------//	
	function fetchAllManifest() {
		var deferred = $q.defer();
		$http.get('manifest/')
			.then(
					function (response) {
						deferred.resolve(response.data);
						console.log(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching Manifetst");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Manifest end ---------------------//
	
	//-------------------------- Filter All Manifest based filter condition begin ---------------------//	
//	function fetchAllManifest() {
//		var deferred = $q.defer();
//		$http.get('manifest_filter/')
//			.then(
//					function (response) {
//						deferred.resolve(response.data);
//						console.log(response.data);
//					},
//					function (errResponse) {
//						console.log("Error while fetching Manifetst");
//						deferred.reject(errResponse);
//					}
//				);
//		return deferred.promise;
//	}
	//--------------------------  Filter All Manifest based filter condition end ---------------------//
	
	
}]);