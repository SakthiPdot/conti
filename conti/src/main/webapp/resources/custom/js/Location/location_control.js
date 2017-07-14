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
		,['$scope','LocationService','AddressService','ConfirmDialogService',
			function($scope,LocationService,AddressService,ConfirmDialogService){
			
			var self=this;			
			self.Locations=[];
			self.addresses=[];
			self.submit=submit;
			self.deleteLocation=deleteLocation;
			self.selectedRow=null;
			self.heading="Master";
			self.save="saveclose";
			self.cancel=close;
			self.close=close;
			self.resetForm=resetForm;
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
			
			function close(title){
				ConfirmDialogService.confirmBox(title,
						BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
				.then(function(response){
					 drawerClose('.drawer') ;
					 reset();
				});
			}
			//===================================reset====================================
			function resetForm(){
				 ConfirmDialogService.confirmBox("Clear",
		 				BootstrapDialog.TYPE_WARNING, "Clear Details  ..?", 'btn-warning')
		 		.then(function(response){
				reset();
		 		});
			}			
			//===================================update Addresses====================================
			$scope.updateAddressDetail=function updateAddressDetail(){				
				self.Location.address=self.Location.selectedAddress;
				console.log(self.Location.address);
			}
			//===================================onchange of angucomplete====================================
			$scope.city_name=function (selected){
				  console.log(selected);					
				  self.Location.address=selected.originalObject;
				  $("#selectedCity_value").val(selected.originalObject.city);	
			}
			
			//===================================update Drawer====================================
			$scope.updateLocation=function updateLocation(location,index){
				
				
				console.log(location.address, "=========="+index);				
				$("#selectedCity_value").val(location.address.city);				
				self.selectedRow=location;				
				self.Location=location;	
				self.Location.selectedAddress=location.address;	
				
				
				(self.Location.location_name).length> 15?
					self.heading="- "+(self.Location.location_name).substr(0,14)+"..."
					:self.heading="- "+self.Location.location_name ;
				
				self.openDrawer();
			}
			
			$scope.$broadcast('angucomplete-alt:clearInput');
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
				 if ($('#city_id').val() == '' || $('#city_id').val() == null) {					 
					  $('#selectedCity_value').focus();
				  }else if($('#stateValue').val() == '' || $('#stateValue').val() == null){
					  $('#selectedCity_value').focus();
				  } else{
				  
					  console.log($(this).data("id") +"id");
						delete self.Location.selectedAddress;
						var locationName=self.Location.location_name;
						if(self.Location.location_id==null){
							console.log('saving user',self.Location);
							
							
							ConfirmDialogService.confirmBox("Save",
				    				BootstrapDialog.TYPE_SUCCESS, "Save Location "+self.Location.location_name+"  ..?", 'btn-success')
				    		.then(function(response){
							
				    			
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
				    		});
						}else{
							console.log('Updating user',self.Location);
							 ConfirmDialogService.confirmBox("Update",
					    				BootstrapDialog.TYPE_SUCCESS, "Update Location "+self.Location.location_name+"  ..?", 'btn-success')
					    		.then(function(response){
							
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
					    			
					    			
					    		});	
						}
				  }
				
			}
			
			//===========================CHECK SAVEANDCLOSE or SAVEANDNEW============
			function newOrClose(){
				console.log(self.save);				
				if(self.save== "saveclose" ){
					 drawerClose('.drawer') ;
				}
				reset();
				fetchAllLocation();
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
			
				ConfirmDialogService.confirmBox("Delete",
						BootstrapDialog.TYPE_DANGER, "Delete Location "+self.Location.location_name+"  ..?", 'btn-danger')
				.then(function(response){
					
					
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
				$scope.locationForm.$setPristine();
				self.heading="Master";
				self.save="saveclose";
				self.Location={};				
				$("#selectedCity_value").val(null);
			}
			

	     
			
}]);