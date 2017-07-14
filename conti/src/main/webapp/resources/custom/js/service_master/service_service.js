


contiApp.factory('ServiceService',['$http','$q', function ($http,$q){
		var REST_SERVICE_URI = 'http://localhost:8080/Conti/services/';
		
		var factory = {
				
				fetchAllServices : fetchAllServices,
				createService : createService,
				updateService : updateService,
				deleteService : deleteService,
				makeActive : makeActive,
				makeinActive : makeinActive
				
				
		};
		
		return factory;
		
		//======== Get All Services Begin ========//
		
			function fetchAllServices() {
				var deferred = $q.defer();
				$http.get(REST_SERVICE_URI)
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
			
}]);