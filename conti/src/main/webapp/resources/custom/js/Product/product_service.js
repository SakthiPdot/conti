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
			updateProduct:updateProduct
	};
	
	return factory;
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

