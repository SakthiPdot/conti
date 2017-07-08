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
			self.submit=submit;
			self.deleteLocation=deleteLocation;
			self.selectedRow=null;
			self.heading="Master";
			self.save="saveclose";
			self.fetched=true;
			self.openDrawer=openDrawer;
			
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
				self.Location.address=self.Location.selectedAddress;
				console.log(self.Location.address);
			}
			
			//===================================update Drawer====================================
			$scope.updateLocation=function updateLocation(location,index){
				
				console.log(location.address, "=========="+index);
				
				self.selectedRow=location;				
				self.Location=location;	
				self.Location.selectedAddress=location.address;	
				self.heading="- "+self.Location.location_name;
				self.openDrawer();
			}
			
			//===================================open Drawer====================================
			function openDrawer(){
				
				if(self.fetched==true){
					fetchAddressDetail();
					self.fetched=false;
				}
				
				drawerOpen('.drawer');
			}
			//===================================fetch Address====================================
			function fetchAddressDetail(){
				
				AddressService.fetchAddress()
				.then(function(response){
					self.addresses=response;
					console.log(self.addresses);
				},
				function(errRes){
					console.log("error Fetchng address");
				});
			}
			
			//======================================submit======================================
			function submit(){
				console.log($(this).data("id") +"id");
				delete self.Location.selectedAddress;
				var locationName=self.Location.location_name;
				if(self.Location.location_id==null){
					console.log('saving user',self.Location);
					LocationService.saveLocation(self.Location)
					.then(
							function(response){
								self.message =locationName+ "  Location Created..!";
								successAnimate('.success');								
								newOrClose();							
							},function(errResponse){
								self.message = "Error While Creating Location ("+locationName+") ..!";
								successAnimate('.failure');
							});					
				}else{
					console.log('Updating user',self.Location);
					LocationService.updateLocation(self.Location,self.Location.location_id)	
					.then(
							function(response){
								self.message =locationName+ "  Location Updated..!";
								successAnimate('.success');								
								newOrClose();	
							},function(errResponse){
								self.message = "Error While Updating Location ("+locationName+") ..!";
								successAnimate('.failure');
							});	
				}
			}
			
			//===========================CHECK SAVEANDCLOSE or SAVEANDNEW============
			function newOrClose(){
				console.log(self.save);				
				if(self.save== "saveclose" ){
					 drawerClose('.drawer') ;
				}
				reset();
			}
			
			$scope.reset = function(){
				reset();
			}
			
			
			//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW============
			$scope.save = function(event){
				self.save=event.target.id;
			}
			
			
			//===================================delete location====================================
			function deleteLocation(){
				var locationName=self.Location.location_name;
				
				LocationService.deleteLocation(self.Location.location_id)
				.then(
						function(response){
							self.message =locationName+ " Location Deleted..!";
							successAnimate('.success');								
							newOrClose();
							console.log(self.Locations[self.selectedRow]+"123");
							console.log(self.selectedRow+"123");
							//delete self.Locations[self.selectedRow];
							self.Locations.splice(self.selectedRow,1);

							console.log(self.Locations);
						},function(errResponse){
							self.message = "Error While Deleting Location ("+locationName+") ..!";
							successAnimate('.failure');
						});			
			}
			
	
			//===================================fetch Address====================================

			fetchAllLocation();
			
			function fetchAllLocation(){
				LocationService.fetchAllLocation()
				.then(function(response){
					self.Locations=response;
					console.log(self.Locations);
				},
				function(errResponse){
					console.log("error fetching all location");					
				});
			}
			
			//=============================RESET LOCATION====================================
			function reset(){
				self.Location={};
				$scope.locationForm.$setPristine();
				self.heading="Master";
				self.save="saveclose";
			}
			
}]);