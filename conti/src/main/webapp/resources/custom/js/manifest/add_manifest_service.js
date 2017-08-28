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
			getUserBranchDetails:getUserBranchDetails,
			searchLRShipment:searchLRShipment,
			filterManifest:filterManifest,
			fetchAllShipment:fetchAllShipment,
			fetchLastManifestNo:fetchLastManifestNo,
			saveManifest:saveManifest,
			paginateFirstOrLast:paginateFirstOrLast,
			findrecord_count:findrecord_count,
			sortBy:sortBy
		
	}
	
	return factory;

	//=============================sort by name====================================
	function sortBy(name,status){	
		console.log(name,status);
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"sortByManifest/"+name,
			data:status,
			headers:getCsrfHeader()
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("status change failed");
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	//=============================find record count====================================
	   function findrecord_count() {
	        var deferred = $q.defer();
	        $http.get('manifestRecordCount/')
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
	   
	//=============================get user Branch details====================================
	function getUserBranchDetails(){
		var deferred=$q.defer();
		$http.get('getUserBranchDetails')
			.then(function(response){
				deferred.resolve(response.data);
			},function(errResponse){
				deferred.reject(errResponse);
			}
			);	
		return deferred.promise;
	}
	//=============================paginate first or last====================================
    function paginateFirstOrLast(page) {
	var deferred = $q.defer();
	
	$http({
		method : 'POST',
		url : 'paginationManifest',
		data : page,
		headers : getCsrfHeader()
	})
	.then (
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
	//=============================save manifest====================================
	function saveManifest(manifest){
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:'manifestSave',
			data:manifest,
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
	//=============================search LR Shipment====================================
	function searchLRShipment(searchString){
	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'searchLRShipment',
    		data : searchString,
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
	//=============================filter manifest====================================
	function filterManifest(x){
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"filterShipment/",
			data:x,
			headers:getCsrfHeader()
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("fetch filter failed");
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}

	//=============================FETCH ALL LOCATION====================================
	function fetchAllShipment(){
		var deferred=$q.defer();
		$http.get('fetchAllShipmentManifest')
			.then(function(response){
				deferred.resolve(response.data);
			},function(errResponse){
				deferred.reject(errResponse);
			}
			);	
		return deferred.promise;
	}
	
	//=============================find last manifest no====================================
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