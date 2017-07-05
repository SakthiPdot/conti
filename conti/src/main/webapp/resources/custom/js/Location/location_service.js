/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name locatin_service.js
 * @author Monu.c
 * @Created_date_time Jun 30, 2017 7:20:17 PM
 * @Updated_date_time Jun 30, 2017 7:20:17 PM
 * 
 */
angular.module('contiApp').factory('LocationService',['$http','$q',function($http,$q){

	var factory={
			saveLocation:saveLocation,
			fetchLocation:fetchLocation,
			deleteLocation:deleteLocation,
			updateLocation:updateLocation,
			fetchAllLocation:fetchAllLocation
		}
	
	return factory;

	//=============================SAVE LOCATION====================================
	function saveLocation(location){
		console.log("Inside save location");
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:'locationSave',
			data:location,
			headers:getCsrfHeader()
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("save failed");
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}	
	
	
	//=============================FETCH ALL LOCATION====================================
	function fetchAllLocation(){
		console.log("Inside fetch all location");
		var deferred=$q.defer();
		$http.get('fetchAllLocation')
			.then(function(response){
				deferred.resolve(response.data);
			},function(errResponse){
				deferred.reject(errResponse);
			}
			);	
		return deferred.promise;
	}
	
	function fetchLocation(){
		console.log("Inside fetch location");
	}    
	function deleteLocation(){
		console.log("Inside delete location");
	}

	function updateLocation(){
		console.log("Inside update location");
	}
	
}]);

