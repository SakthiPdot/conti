/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name locatin_control.js
 * @author Monu.c
 * @Created_date_time Jun 30, 2017 4:20:17 PM
 * @Updated_date_time Jun 30, 2017 4:20:17 PM
 * 
 */
angular.module('contiApp').controller('locationController'
		,['$scope','LocationService','AddressService',function($scope,LocationService,AddressService){
			
			var self=this;			
			self.Locations=[];
			self.addresses=[];
			self.Locations=[];
			self.submit=submit;
			self.Location={
				    "location_id": null,
				    "updated_by": null,
				    "created_by": null,
				    "location_name": null,
				    "location_code": null,
				    "abbreviation": null,
				    "obsolete": null,
				    "active": null,
				    "created_datetime": null,
				    "updated_datetime": null,
				    "pincode": null,
				    "address": {
				        "id": null,
				        "location": null,
				        "state": null,
				        "country": null,
				        "city":null,
				        "cityCode": null,
				        "stateCode": null,
				        "countryCode": null,
				        "active": null,
				        "obsolete": null
				    }
				};
			
			//===================================update Addresses====================================
			$scope.updateAddressDetail=function updateAddressDetail(){				
				self.Location.address=self.location.selectedAddress;
				console.log(self.Location.address);
			}
			
			
			//======================================submit======================================
			function submit(){
				if(self.Location.location_id==null){
					console.log('saving user',self.Location);
					LocationService.saveLocation(self.Location);					
				}else{
					console.log('Updating user',self.Location);
					LocationService.saveLocation(self.Location,self.Location.locaiton_id);
				}
			}
			
			//===================================fetch Address====================================
			fetchAddressDetail();
			
			function fetchAddressDetail(){
				
				AddressService.fetchAddress()
				.then(function(response){
					self.addresses=response;
					console.log(response);
					console.log(self.addresses);
				},
				function(errRes){
					console.log("error Fetchng address");
				});
				
			}
			
			//===================================fetch Address====================================
			fetchAllLocation();
			
			function fetchAllLocation(){
				LocationService.fetchAllLocation()
				.then(function(response){
					self.Locations=response;
					console.log(response);
					console.log(self.Locations);
				},
				function(errResponse){
					console.log("errror fetching all location");					
				});
			}
			
		
			
}]);