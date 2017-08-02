/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name c_price_setting_setting.js
 * @author Monu.c
 * @Created_date_time Jul 20, 2017 4:20:17 PM
 * @Updated_date_time Jul 20, 2017 4:20:17 PM
 */
angular.module('contiApp').factory('priceSettingService',['$http','$q',function($http,$q){
	
	var factory={
			savePS:savePS,
			updatePS:updatePS,
			fetchPSbyId:fetchPSbyId,
			deletePriceSetting:deletePriceSetting,
			fetch_priceforShipment : fetch_priceforShipment
	};
		
	return factory;
	
	
	//=============================DELETE PRICE SETTING====================================
	function deletePriceSetting(id){
		var deferred=$q.defer();
		$http({
			method:'DELETE',
			url:'priceSettingDelete/'+id,
			headers:getCsrfHeader()			
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("delete failed");
					deferred.reject(errResponse);
				}
				);
		return deferred.promise;		
	}
	
	//======================================fetch price setting (ID)======================================
	function fetchPSbyId(id){
		var deferred=$q.defer();
		$http.get('PriceSettingWithID/'+id)
			.then(function(response){
				deferred.resolve(response.data);
			},function(errResponse){
				deferred.reject(errResponse);
			});	
		return deferred.promise;
	}
	
	
	//======================================save price setting======================================
	function savePS(priceSetting){
		  var deferred = $q.defer();
		  $http({
				method:'POST',
				url:'priceSettingSave',
				data:priceSetting,
				headers:getCsrfHeader()
			}).then(
	            function (response) {
	                deferred.resolve(response.data);
	            },
	            function(errResponse){
	                deferred.reject(errResponse);
	            }
	        );
	        return deferred.promise;
	}
	
	//======================================update price setting======================================
	function updatePS(priceSetting,id){
		var deferred=$q.defer();
		
		$http({
			method:'PUT',
			url:'priceSettingUpdate/'+id,
			data:priceSetting,
			headers:getCsrfHeader()
		})
		.then(
				function(response){
					deferred.resolve(response.data);
				},
				function(errResponse){
					deferred.reject(errResponse);
				}
				);
		return deferred.promise;
	}
	
	
	//----------------------------------- fetch price by from / to branch and product and service
	function fetch_priceforShipment(product_info) {
		console.log(product_info);
		 var deferred = $q.defer();
		  $http({
				method:'POST',
				url:'fetch_priceforShipment',
				data:product_info,
				headers:getCsrfHeader()
			}).then(
	            function (response) {
	                deferred.resolve(response.data);
	            },
	            function(errResponse){
	                deferred.reject(errResponse);
	            }
	        );
	        return deferred.promise;
	}
}]);