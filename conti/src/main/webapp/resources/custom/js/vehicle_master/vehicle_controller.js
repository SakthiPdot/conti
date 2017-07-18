
contiApp.controller('VehicleController', ['$scope', '$timeout', 'VehicleService', 'BranchService', 'ConfirmDialogService', function($scope, $timeout, VehicleService, BranchService, ConfirmDialogService){
	
		
		var self = this;
		self.vehicles = [];
		self.vehicle = {};
		self.heading = "Master";
		self.message = null;
		self.submit = submit;
		self.save = "saveclose";
		self.reset = reset;
		self.deleteVehicle = deleteVehicle;
		self.updateVehicle = updateVehicle;
		self.close = close;
		self.clear = clear ;
		
		
		self.vehicSelect = vehicSelect;
		self.vehicSelectall = vehicSelectall;		
		self.makeActive = makeActive;
		self.makeinActive = makeinActive;
		self.print = print;
		self.selected_vehicle = [];
		
		self.confirm_title = 'Save';
		self.confirm_type = 'TYPE_SUCCESS';
		self.confirm_msg = self.confirm_title + ' ' + self.vehicle.vehicle_regno + ' vehicle?';
		self.confirm_btnclass = 'btn-sucsess';
		
		
		fetchAllVehicles();
		fetchAllBranches();
		
		
	//=================== Reset Function Begin =================//	
		function reset () {
			self.vehicle = {};
			$('#branch_name_value').val('');
			self.heading = "Master";
		}
	//=================== Reset Function End ==================//
	
	//=================== Close Function Begin ==================//
		
		function close(){
			self.confirm_title = 'Close';
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title + ' without saving data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
							function (res) {
								reset();
								newOrClose();
							}
				     );
		}
	//=================== Close Function End ====================//
		
	//=================== Clear Function Begin ======================//
	
			function clear() {
				self.confirm_title = 'Clear';
				self.confirm_type = BootstrapDialog.TYPE_WARNING;
				self.confirm_msg = self.confirm_title + ' the data?';
				self.confirm_btnclass  =  'btn-warning';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type,self.confirm_msg, self.confirm_btnclass)
					.then(
								function (res) {
									reset();
								}
						 );
			}
	//=================== Clear Function End ========================//
			
	//================== Fetch All Employees Begin ====================//
			
			function fetchAllVehicles(){
				VehicleService.fetchAllVehicles()
					.then(
							function (vehicle) {
								self.vehicles = vehicle;
								console.log(self.vehicles);
							},
							function (errResponse) {
								console.log('Error while fetching vehicles');
							}
					      );
			}
	//================== Fetch All Employees End =======================//
			
	//================= Fetch All Branch Begin =======================//
			function fetchAllBranches() {
				BranchService.fetchAllBranches()
					.then(
							function (branches) {
								self.branches = branches;
								console.log(branches);						
							}, 
							function (errResponse) {
								console.log('Error while fetching branches');
							}
						);
			}
				
	//================= Fetch All Branch End ========================//
				
			$scope.save = function(event){
				self.save=event.target.id;
			}
			
			
			
			function newOrClose() {
				console.log(self.save);
				if(self.save == "saveclose"){
					drawerClose('.drawer');
				}
				reset();
			}
			
		//================= Create/Save Vehicle Function Begin ==============//	
			 function createVehicle(vehicle){
			    	VehicleService.createVehicle(vehicle)
			            .then(
			            		function () {
			                        fetchAllVehicles();
			                        self.message = vehicle.vehicle_regno+" vehicle created..!";
			            			successAnimate('.success');            			
			            		},
			           
			            function (errResponse) {
			                console.error('Error while creating vehicle' + vehicle.vehicle_regno);
			            }
			        );
			    } 
			
	//================= Create/Save Vehicle Function End ==============//	
			 
			function submit() {
				
				if( $("#branch_id").val() == "" || $("#branch_id").val() == null){
						$("#branch_name_value").focus();
				} else {
					
					if( self.vehicle.vehicle_id == null) {
						
						self.confirm_title = 'Save';
						self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
						self.confirm_msg = self.confirm_title + ' ' + self.vehicle.vehicle_regno + ' vehicle?';
						self.confirm_btnclass = 'btn-success';
						
						ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
							.then(
									function (res) {
										self.vehicle.branch_id = JSON.parse($("#branch_id").val());
										console.log(self.vehicle);
										createVehicle(self.vehicle);										
										reset();
										window.setTimeout( function(){
											newOrClose();
										},5000);
										
									}
							     );
						
					} else {
						
						self.confirm_title = 'update';
						self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
						self.confirm_msg = self.confirm_title + ' ' + self.vehicle.vehicle_regno+ ' vehicle?';
						self.confirm_btnclass = 'btn-warning';
		    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
		    				.then(
		    						function (res) {
		    							self.vehicle.branch_id = $("#branch_id").val();
		    							editVehicle(self.vehicle);
		    							reset();
		    							window.setTimeout(function(){
		    								newOrClose();
		    							},5000);
		    						}
		    				      );
						
					}
				}
				
			}
			
	//=============== Update Existing Vehicle Function Begin ==================//
			
			function editVehicle(vehicle) {
				VehicleService.createVehicle(vehicle)
				.then(
						function () {
							fetchAllVehicles();
							self.message = vehicle.vehicle_regno + " vehicle updated..!";
							successAnimate('.success');
						},
						
						function(errResponse) {
							console.error('Error while creating vehicle' + vehicle.vehicle_regno);
							
						}
					 );
			}
	//================ Update Existing Vehicle Function End ===================//
			
	//=============== Update Vehicle Function Begin ============================//
			
			function updateVehicle(vehicle) {
				self.vehicle = vehicle;				
				self.heading = self.vehicle.vehicle_regno;
				drawerOpen('.drawer');
			}
			
	//=============== Update Vehicle Function End ==============================//
			
	//=============== Delete Vehicle Function Begin ==========================//
			
			function deleteVehicle() {
				
				self.confirm_title = 'Delete';
				self.confirm_type = BootstrapDialog.TYPE_DANGER;
				self.confirm_msg = self.confirm_title+ ' ' + self.vehicle.vehicle_regno + ' service?';
				self.confirm_btnclass = 'btn-danger';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							VehicleService.deleteVehicle(self.vehicle.vehicle_id)
							.then(
									function (vehicle) {
										self.message = vehicle.vehicle_regno+ " vehicle Deleted..!";
										successAnimate('.success');
										newOrClose();
										self.vehicles.splice(vehicle,1);
										console.log(vehicle);
										console.log(self.vehicles);
									},
									function (errResponse) {
										console.error('Error while Delete vehicle' + errResponse);
									}
								  );
						}
					 )
			}
			
	//=============== Delete Vehicle Function End ============================//
			
			
			function vehicSelect(vehicle) {
				var index = self.selected_vehicle.indexOf(vehicle);
				(vehicle.select)? self.selected_vehicle.push(vehicle) : self.selected_vehicle.splice(index, 1);
				
			}
			
			function vehicSelectall(){
				angular.forEach(self.vehicles,function(vehicle){
					vehicle.select = $scope.selectall;
				});
				self.selected_vehicle = $scope.selectall?self.vehicles:[];
			}
			
	//============== Make Active Begin =====================//
			
			function makeActive() {
				
				if(self.selected_vehicle.length == 0){
					self.message = " Please select atleast one record..!";
					successAnimate('.failure');
				} else {
					var activate_flag = 0;
					angular.forEach(self.selected_vehicle, function(vehicle){
						if(vehicle.active == 'Y'){
							activate_flag = 1;
						}
					});
					
					if(activate_flag == 1) {
						self.message = " Selected record(s) already in active status..!";
						successAnimate('.failure');
					} else {
						
						self.confirm_title = 'Active';
						self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
						self.confirm_msg = self.confirm_title+ ' selected record(s)?';
						self.confirm_btnclass = 'btn-success';
						ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
							.then(
								 
									function(res){
										var active_id = [];
										for(var i=0; i<self.selected_vehicle.length;i++) {
											active_id[i] = self.selected_vehicle[i].vehicle_id;
										}
										VehicleService.makeActive(active_id)
											.then(
													function(response) {
														fetchAllVehicles();
														self.selected_vehicle = [];
														self.message = " Selected record(s) has in active status..!";
														successAnimate('.success');
														
													}, function (errResponse) {
														console.log(errResponse);
													}
											     );
									}
							      );
					}
				}
			}
			
	//============== Make Active End ======================//
			
	//============== Make InActive Begin ====================//
	
			function makeinActive() {
				if(self.selected_vehicle.length == 0) {
					self.message = "Please select atleast one record..!";
					successAnimate('.failure');
				} else {
					var inactivate_flag = 0 ;
					angular.forEach(self.selected_vehicle, function(vehicle){
						if(vehicle.active == 'N') {
							inactivate_flag = 1;
						}
					});
					
					if(inactivate_flag == 1) {
						self.message = "Selected record(s) already in active status..!";
						successAnimate('.failure')
					} else {
						
						self.confirm_title = 'In-Active';
						self.confirm_type = BootstrapDialog.TYPE_DANGER;
						self.confirm_msg = self.confirm_title+ ' selected record(s)?';
						self.confirm_btnclass = 'btn-danger';
						ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
							.then(
									function(res) {
										var inactive_id = [];
										for(var i=0; i<self.selected_vehicle.length; i++) {
											inactive_id[i] = self.selected_vehicle[i].vehicle_id;
										}
									
									VehicleService.makeinActive(inactive_id)
										.then(
												function(response) {
													fetchAllVehicles();
													self.selected_vehicle = [];
													self.message = " Selected record(s) has in inactive status..!";
													successAnimate('.success');
												}, function(errResponse) {
													console.log(errResponse);
												}
										     );
									}
							     );
					}
				}
			}	
			
	//============== Make InActive End =======================//
			
	//================== Print Begin ======================//
	
			function print(){
				if(self.selected_vehicle.length == 0) {
					self.message = "Please select atleast one record..!";
					success.Animate('.failure');
				} else {
					$http.get('http://localhost:8080/Conti/listprint');
				}
			}
			
	//================= Print End =============================//
			
}]);