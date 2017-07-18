
contiApp.factory('VehicleService',['$http', '$q', function ($http,$q){
		
			
			var factory = {
				
				fetchAllVehicles : fetchAllVehicles,
				createVehicle : createVehicle,
				updateVehicle : updateVehicle,
				deleteVehicle : deleteVehicle,
				makeActive : makeActive,
				makeinActive : makeinActive
		  };
		
		return factory;
		
		//============= Fetch All Vehicles Begin ===============//
				function fetchAllVehicles() {
					var deferred = $q.defer();
					$http.get('vehicles/')
						.then(
								function (response) {
									console.log(response)
									deferred.resolve(response.data);
								},
								
								function (errResponse) {
									console.log('Error while fetching vehicles');
									deferred.reject(errResponse);
								}
							  );
					return deferred.promise;
				}
		//============ Fetch All Vehicles End ==================//
				
		//=========== Create/Save Vehicle Begin ================//
				
				function createVehicle(vehicle) {
					var deferred = $q.defer();
					var headers = getCsrfHeader();
					
					$http({
						method : 'POST',
						url : 'create_vehicle',
						data : vehicle,
						headers : headers
					})
					
					.then(
							function (response) {
								deferred.resolve(response.data)
							},
							function (errResponse) {
								deferred.reject(errResponse);
									
							}
							
					      );
					return deferred.promise;
				}
		//=========== Create/Save Vehicle End ==================//
				
		//========== Update Vehicle Function Begin ===========//
				
				function updateVehicle (vehicle, id) {
					var deferred = $q.defer();
					
					$http({
						method : 'PUT',
						url : 'update_vehicle/' +id,
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
		//========== UPdate Vehicle Function End =============//
				
				
			//========== Delete Vehicle Begin ==============//
				
					function deleteVehicle(id) {
						var deferred = $q.defer();
						$http({
							method : 'DELETE',
							url : 'delete_vehicle/'+id,
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
			//========== Delete Vehicle End  ===============//
					
					
				
			//============= Active Vehicle Begin ===========//
			
					function makeActive(id) {
			
						var deferred = $q.defer();
						
						$http({
							method : 'POST',
							url : 'makevehicleactive',
							data : id,
							headers : getCsrfHeader()
						})
						.then(
								function (response) {
									deferred.resolve(response.data);
								},
								function(errResponse) {
									deferred.reject(errResponse);
								}
						     );
						return deferred.promise;
					}
					
			//============= Active Vehicle End ============//
			
					
			//========= InActive Vehicle Begin =============//
			
					function makeinActive(id) {
						
						console.log(id);
						var deferred = $q.defer();
						
						$http({
							method : 'POST',
							url : 'make_vehicleinactive',
							data : id,
							headers : getCsrfHeader()
						})
						.then(
								function (response) {
									deferred.resolve(response.data);
								},
								function(errResponse) {
									deferred.reject(errResponse);
								}
						     );
						return deferred.promise;
					}
					
			//========== InActive Vehicle End ===============//
}]);