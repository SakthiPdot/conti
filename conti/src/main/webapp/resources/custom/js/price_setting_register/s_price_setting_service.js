/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name s_price_setting_service.js
 * @author Monu.c
 * @Created_date_time Jul 28, 2017 9:20:17 PM
 * @Updated_date_time Jul 28, 2017 9:20:17 PM
 */
angular.module('contiApp').factory('priceSettingRegisterService',['$http','$q',function($http,$q){
		
	var factory={
			fetchAllPriceSetting:fetchAllPriceSetting,
			changeActive:changeActive,
			searchPriceSetting:searchPriceSetting,
			paginateFirstOrLast:paginateFirstOrLast,
			findrecord_count:findrecord_count,
			sortBy:sortBy
	};
		
	return factory;	
	
	
	//=============================sort by name====================================
	function sortBy(name,status){	
		console.log(name,status);
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"sortByPS/"+name,
			data:status,
			headers:getCsrfHeader()
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("fetch by sorting failed");
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	
	//=============================find record count====================================
	   function findrecord_count() {
	    	
	        var deferred = $q.defer();
	        $http.get('priceSettingRecordCount/')
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
	   
	//=============================paginate first or last====================================
    function paginateFirstOrLast(page) {
	var deferred = $q.defer();
	
	$http({
		method : 'POST',
		url : 'paginationPriceSetting',
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
	//=============================FETCH ALL LOCATION====================================
	function fetchAllPriceSetting(){
		var deferred=$q.defer();
		$http.get('fetchAllPriceSetting')
			.then(function(response){
				deferred.resolve(response.data);
			},function(errResponse){
				deferred.reject(errResponse);
			});	
		return deferred.promise;
	}
	
	//=============================change Active====================================
	function changeActive(id,status){	
		console.log(id,status);
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"PriceSettingStaus/"+status,
			data:id,
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
	//=============================change Active====================================
	function searchPriceSetting(searchString){
  	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'searchPriceSetting4String',
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
	
}]);