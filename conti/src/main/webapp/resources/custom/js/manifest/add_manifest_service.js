/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name add_manifest_service.js
 * @author Monu.c
 * @Created_date_time Jun 30, 2017 7:20:17 PM
 * @Updated_date_time Jun 30, 2017 7:20:17 PM
 * 
 */

angular.module('contiApp').factory('addManifestService',['$http','$q',function($http,$q){
	
	var factory={
			fetchAllShipment:fetchAllShipment,
			fetchLastManifestNo:fetchLastManifestNo			
	}
	
	return factory;
	
	//=============================FETCH ALL LOCATION====================================
	function fetchAllShipment(){
		var deferred=$q.defer();
		$http.get('fetchAllShipment')
			.then(function(response){
				deferred.resolve(response.data);
			},function(errResponse){
				deferred.reject(errResponse);
			}
			);	
		return deferred.promise;
	}
	
	//=============================find record count====================================
	   function fetchLastManifestNo() {
	    	console.log("inside last manifest fetch");
	        var deferred = $q.defer();
	        $http.get('fetchLastManifestNo/')
	            .then(
	            function (response) {
	                deferred.resolve(response.data);
	            },
	            function(errResponse){
	                console.error('Error while fetching last manifest no');
	                deferred.reject(errResponse);
	            }
	        );
	        return deferred.promise;
	    }
	   
	
}]);