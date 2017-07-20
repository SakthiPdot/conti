


contiApp.factory('ServiceService',['$http','$q', function ($http,$q){
		var REST_SERVICE_URI = 'http://localhost:8080/Conti/services/';
		
		var factory = {
				
				fetchAllServices : fetchAllServices,
				createService : createService,
				updateService : updateService,
				deleteService : deleteService,
				makeActive : makeActive,
				makeinActive : makeinActive,
				registerSearch : registerSearch,
				pagination_byPage : pagination_byPage
				
				
		};
		
		return factory;
		
		//======== Get All Services Begin ========//
		
			function fetchAllServices() {
				var deferred = $q.defer();
				$http.get('services/')
					.then(
							function (response) {
								console.log(response)
								deferred.resolve(response.data);
							},
							
							function (errResponse) {
								console.log("Error while fetching services");
								deferred.reject(errResponse);
							}
					     );
				return deferred.promise;
			}
		
		//======== Get All Services End ===========//
			
		//========= Create/Save Service Begin =========//
			function createService(service) {
				var deferred = $q.defer();
				var headers = getCsrfHeader();				
			
				
				$http({
					method : 'POST',
					url : 'create_service',
					data : service,
					headers : headers
				})
				
				.then(
						function (response) {
							deferred.resolve(response.data);
						},
						function (errResponse) {
							deferred.reject(errResponse);
						}
				     );
				
				return deferred.promise;
			}
		//========= Create/Save Service End ===========//
			
		 //======== Update Service Begin =============//
			
			function updateService (service, id) {
				var deferred = $q.defer();
				$http({
					method : 'PUT',
					url : 'update_service/' +id,
					headers : getCsrfHeader()
				})
				.then(
				  	 function (response) {
				  		 deferred.resolve(response.data);
				  	 },
				  	 function (errResponse) {
				  		 deferred.reject(errResponse);
				  	 }
				   );
				return deferred.promise;
			}
		//========= Update Service End ================//
			
		//========== Delete Service Begin ==============//
			
				function deleteService(id) {
					var deferred = $q.defer();
					$http({
						method : 'DELETE',
						url : 'delete_service/'+id,
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
		//========== Delete Service End  ===============//
				
		//======= Active Service Begin ===============//
				
				function makeActive(id) {
					var deferred = $q.defer();
					
					$http({
						method : 'POST',
						url : 'make_serviceactive',
						data : id,
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
				
		//======= Active Service End ================//
				
		//========= InActive Service Begin ==========//
				
				function makeinActive(id) {
					var deferred = $q.defer();
					
					$http({
						method : 'POST',
						url : 'make_serviceinactive',
						data : id,
						headers : getCsrfHeader()
					})
					.then(
						  function (response) {
							  deferred.resolve(response.data);
						  },
						  function (errResponse) {
							  deferred.reject(errResponse);
						  }
					     );
					return deferred.promise;
				}
				
		//========= InActive Service End ============//
				
		//============= Register Search Begin =========//
		
				function registerSearch(searchkey) {
					var deferred = $q.defer();
					
					$http({
						
						method : 'POST',
						url : 'service_registersearch',
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
				
		//============= Register Search End ==========//
				
		//============== Pagination Function Begin ======//
		
				function pagination_byPage(page) {
					var deferred = $q.defer();
					
					$http({
						method : 'POST',
						url : 'service_pagination',
						data : page,
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
				
		//============== Pagination Function Begin =======//
			
}]);