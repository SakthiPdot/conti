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
			
			$("#screen_location").addClass("active-menu");
			
			$scope.shownoofrec = 10;
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
			self.nameWrong=false;
			self.checkLocationName=checkLocationName;
			self.registerSearch=registerSearch;
			
			//check box select
			self.selectAllLocation=false;
			self.selectLocation=selectLocation;
			self.selectAll=selectAll;
			self.selectedLocation=[];
			 
		
			//active inactive 
			self.makeActive=makeActive;
			self.makeInActive=makeInActive;
			

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
			
		
			//===================================SEARCH REGISTER====================================
			function registerSearch(searchString){
				if(searchString.length==0){
					self.FilteredLocations=self.Locations;
				}else if(searchString.length>3){
					LocationService.searchLocation(searchString)
					.then(
							function(response){
								self.FilteredLocations=response	;
							},function(errRespone){
								console.log("error while fetching Location in search"+errResponse);
							});
				}else{
					self.FilteredLocations=_.filter(self.Locations,function(item){
						return searchProduct(item,searchString);
					});
				}
			}
			function searchProduct(item,toSearch){
				
				var success=false;
				
				try{
					if(							
							item.location_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.location_code.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.abbreviation.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.address.city.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.address.state.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.address.country.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							String(item.pincode).indexOf(toSearch) > -1	 		
					){
						success = true;
					} else {
						success = false;
					}
				}catch(e){
					success = false;
				}
				
				return success;	
			}
			//===================================select Product====================================
			function selectLocation(x){
				console.log(x);
				if(x.select){
					self.selectedLocation.push(x);
				}else{
					self.selectAllLocation=x.select;
					var index=self.selectedLocation.indexOf(x);
					console.log(x);
					self.selectedLocation.splice(index,1);
				}
				console.log(self.selectedLocation);
				
			}
			
			//===================================select all====================================
			function selectAll(){
				
				self.selectedLocation=[];
				
				var size;
				
				if($scope.pageSize>self.FilteredLocations.length){
					size=self.filteredPriceSetting.length;
				}else{
					size=$scope.pageSize;
				}
				
				
					for(var i=0;i<size;i++){
						self.FilteredLocations[i].select=self.selectAllLocation;
						if(self.selectAllLocation){
							self.selectedLocation.push(self.FilteredLocations[i]);
						}
					}
			
				
				
				console.log(self.selectedLocation);
				
			/*	angular.forEach(self.Locations,function(x){
					x.select=self.selectAllLocation;
				});				
				
				if(self.selectAllLocation){
					self.selectedLocation=self.Locations;
				}else{
					self.selectAllLocation=[];
				}*/
			}
			
			function selectOneRecord(){
		   		self.message ="Please select atleast one record..!";
				successAnimate('.failure');
			}
			
			function showStatus(status){
				self.message ="Selected record(s) already in "+status+" status..!";
				successAnimate('.failure');
			}
				
			function showStatusAfterSave(status){
				fetchAllLocation();
				self.message ="Selected record(s) has been made  "+status+"..!";
				successAnimate('.success');
				 self.selectedLocation=[];
				 self.selectAllLocation=false;
			}
			
			//===================================close====================================
			function makeActive(){
				
				var hitController=true;
				var active_id=[];
				
				if(self.selectedLocation.length==0){
					selectOneRecord();
				    hitController=false;
				}else{
					var loop=true;	
					for(var i=0;i<self.selectedLocation.length;i++){
						if(loop){
							if(self.selectedLocation[i].active=="Y"){
								loop=false;
							    hitController=false;
								showStatus("Active");
							}

		    				active_id[i] = self.selectedLocation[i].location_id; 
						}
					}
					
					
					if(hitController){					
						console.log(active_id);
						ConfirmDialogService.confirmBox("Active",
			    				BootstrapDialog.TYPE_SUCCESS, "Make Records Active  ..?", 'btn-success')
			    		.then(function(response){
			    			LocationService.changeActive(active_id,"Active")
							.then(
									function(response){
										showStatusAfterSave("Active");
									},function(errRespone){
										console.log("error making product active"+errResponse);
									});
			    			
			    		});
					}
				}
			}
			
			//===================================close====================================
			function  makeInActive(){

				var hitController=true;
				var In_active_id=[];
				
				
				if(self.selectedLocation.length==0){
					selectOneRecord();
				    hitController=false;
				}else{
					var loop=true;	
					for(var i=0;i<self.selectedLocation.length;i++){
						if(loop){
							if(self.selectedLocation[i].active=="N"){
								loop=false;
							    hitController=false;
								showStatus("InActive");
							}

							In_active_id[i] = self.selectedLocation[i].location_id; 
						}
					}
					
					if(hitController){
						console.log(In_active_id);
						ConfirmDialogService.confirmBox("InActive",
			    				BootstrapDialog.TYPE_DANGER, "Make Records InActive  ..?", 'btn-danger')
			    		.then(function(response){
			    			
			    			LocationService.changeActive(In_active_id,"InActive")
							.then(
									function(response){
										showStatusAfterSave("InActive");
									},function(errResponse){
										console.log("error making location InActive",errResponse);
									});
			    		});
			    		}
				}
				
				
				
			}
			
			
			//===================================close====================================
			function close(title){
				ConfirmDialogService.confirmBox(title,
						BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
				.then(function(response){
					 drawerClose('.drawer') ;
					 fetchAllLocation();
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
							var index=self.Locations.indexOf(self.selectedRow);
							self.Locations.splice(index,1);
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
					 pagination();
					self.Locations=response;
					self.FilteredLocations=response;
					console.log(self.Locations);
				},
				function(errResponse){
					console.log("error fetching all location");					
				});
			}
			  //===================================next and previous page====================================  
		    $scope.paginate=function(nextPrevMultiplier){
		    	
		    	self.selectAllLocation=false;
		    	$scope.currentPage += (nextPrevMultiplier * 1);
		    	console.log(self.Locations.length);
		    	self.FilteredLocations = self.Locations.slice($scope.currentPage*$scope.pageSize);
		    	console.log(self.FilteredLocations.length);
		    	
		    	
		    	
		    	if(self.FilteredLocations.length == 0) {
		           	LocationService.paginateFirstOrLast($scope.currentPage)		           	
					.then(function (response) {
						console.log(response);
						
						if ( response.length == 0 ) {
							$scope.nextDisabled = true;
						} else if ( response.length < 10 ) {
							self.FilteredLocations = response;
							$scope.nextDisabled = true;
						} else {
							self.FilteredLocations = response;
						}
						
					}, 
					function (errResponse) {
						console.log('Error while pagination');
					}
				);
		    	}
		    	
		    	
		       	if(self.FilteredLocations.length < $scope.pageSize) {
		    		$scope.nextDisabled = true;
		    	}
		    	
		    	if($scope.currentPage == 0) {
		    		$scope.previouseDisabled = true;
		    	}
		    	if(nextPrevMultiplier == -1) {    		
		    		$scope.nextDisabled = false;
		    	} else {
		    		$scope.previouseDisabled = false;
		    	}
		    }
			//===================================first last login page====================================
			$scope.firstlastPaginate = function (page) {
				
				self.selectAllLocation=false;
				LocationService.paginateFirstOrLast(page)
				.then(
						function(response){
							self.FilteredLocations=response;
							console.log(response);
						},function(errRespone){
							console.log("error while fetching Location in search"+errResponse);
						});
				
				
				if( page == 1 ) {
		    		$scope.currentPage = 0;
		    		$scope.previouseDisabled = true;
		    		$scope.nextDisabled = false;
		    	} else {
		    		$scope.previouseDisabled = false;
		    		$scope.nextDisabled = true;
		    		
		    	}
			}
				
			//=============================RESET LOCATION====================================
			function reset(){
				$scope.locationForm.$setPristine();
				self.nameWrong=false;
				self.heading="Master";
				self.save="saveclose";
				self.Location={};				
				$("#selectedCity_value").val(null);
			}
			

		//=============================CHECK  LOCATION====================================
			function checkLocationName(name){
				LocationService.checkLocationName(name)
				.then(function(response){

					console.log(response);
					if(response=='204'){
						self.nameWrong=true;
						self.Location.location_name=null;
					}else{
						self.nameWrong=false;
					}
					
				},function(errResponse){
					self.Location.location_name=null;
					self.nameWrong=false;
					console.log("error checking name");
				})
			}
			
			//===================================change no of page to view in register====================================
		    self.shownoofRecord=function shownoofRecord() {    
		    	$scope.pageSize = $scope.shownoofrec;
		    }
		    
		    
			//===================================pagination====================================
		    function pagination() {
		    	$scope.pageSize = $scope.shownoofrec;
				$scope.currentPage = 0;
				$scope.totalPages = 0;	
				$scope.previouseDisabled = true;	
				$scope.nextDisabled = false;	
		    }
			
}]);