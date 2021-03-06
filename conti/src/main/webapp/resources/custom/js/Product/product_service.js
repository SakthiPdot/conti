/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name ProductDaoImpl.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:23:19 PM
 */


angular.module('contiApp').factory('ProductService',['$http','$q',function($http,$q){
	
	var factory={
			saveProduct:saveProduct,
			fetchAllProduct:fetchAllProduct,
			deleteProduct:deleteProduct,
			updateProduct:updateProduct,
			changeActive:changeActive,
			searchProduct:searchProduct,
			paginateFirstOrLast:paginateFirstOrLast,
			checkProductName:checkProductName,
			findrecord_count:findrecord_count,
			sortBy:sortBy
	};
	
	return factory;
	//=============================find record count====================================
	   function findrecord_count() {
	    	
	        var deferred = $q.defer();
	        $http.get('ProductRecordCount/')
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
	function checkProductName(name){
		var deferred = $q.defer();
		
		$http({
			method : 'POST',
			url : 'checkProductName',
			data : name,
			headers : getCsrfHeader()
		})
		.then (
			function (response) {
				console.log(response);
				deferred.resolve(response.status);
			},
			function (errResponse) {

				console.log(errResponse);
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
		url : 'paginationProduct',
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
	
	//=============================search product====================================
    function searchProduct(searchkey) {
    	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'searchProuct4String',
    		data : searchkey,
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
    
	

	//=============================sort by name====================================
	function sortBy(name,status){	
		console.log(name,status);
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"sortBy/"+name,
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
	//=============================change Active====================================
	function changeActive(id,status){	
		console.log(id,status);
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"productStaus/"+status,
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
	//=============================SAVE PRODUCT====================================
	function saveProduct(Product){		
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:'productSave',
			data:Product,
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
	
	//=============================FETCH ALL PRODUCT====================================
	function fetchAllProduct(){
		var d=$q.defer();		
		$http.get('fetchAllProduct')
		.then(function(response){
			d.resolve(response.data);
		},function(errResponse){
			d.reject(errResponse);
		});
		return d.promise;
	}
	//=============================FETCH ALL PRODUCT====================================
	function deleteProduct(id){	
		var deferred=$q.defer();
		$http({
			method:'DELETE',
			url:'productDelete/'+id,
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


	//=============================UPDATE Product====================================
	function updateProduct(product,id){
		var deferred=$q.defer();
		
		$http({
			method:'PUT',
			url:'updateProduct/'+id,
			data:product,
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
		
}]);

