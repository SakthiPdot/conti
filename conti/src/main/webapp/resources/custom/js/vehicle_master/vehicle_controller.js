
contiApp.controller('VehicleController', ['$scope', '$timeout', 'VehicleService', 'BranchService', 'ConfirmDialogService', function($scope, $timeout, VehicleService, BranchService, ConfirmDialogService){
	
	   $("#screen_vehicle").addClass("active-menu");	
	   	
	   $scope.nameWrong = false;
	   
		var self = this;
		self.vehicles = [];
		self.Filtervehicles = [];
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
		
		self.registerSearch = registerSearch;
		self.shownoofRecord = shownoofRecord;
		
		self.print = print;
		self.selected_vehicle = [];
		
		self.confirm_title = 'Save';
		self.confirm_type = 'TYPE_SUCCESS';
		self.confirm_msg = self.confirm_title + ' ' + self.vehicle.vehicle_regno + ' vehicle?';
		self.confirm_btnclass = 'btn-sucsess';
		
		
		$scope.shownoofrec = 10;
		
		fetchAllVehicles();
		fetchAllBranches();
		
		
	//============== Check Vehicle RegNo Function Begin ==============//
		
		self.checkVehicleRegno = function checkVehicleRegno(regno) {
			
			
			
			if(self.vehicle.vehicle_id != null && self.vehicle.vehicle_regno == self.UpdateNotCheckVehicleRegno) {
			
				$scope.nameWrong = false ;
				
			} else {
				
				VehicleService.checkVehicleRegno(regno)
					.then(function (response) {
						
						if(response=="204") {
							$scope.nameWrong = true;
							
							self.vehicle.vehicle_regno = null;
						} else {
							$scope.nameWrong = false;
							
						}
						}, function(errResponse) {
							$scope.nameWrong = false;
							self.vehicle.vehicle_regno = null;
							console.log("error checking name");
						
					});
			}
			
		}
		
	//============== Check Vehicle RegNo Function End 
		
	//=================== Reset Function Begin =================//	
		function reset () {
			self.vehicle = {};
			$('#branch_name_value').val('');
			$('#vehicle_type_value').val('');
			self.heading = "Master";
		}
	//=================== Reset Function End ==================//
	
	//=================== Close Function Begin ==================//
		
		function close(open){
			self.confirm_title = open;
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title + ' without saving data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
							function (res) {
								fetchAllVehicles();
								self.save = "saveclose";
								reset();
								newOrClose();
							}
				     );
		}
	//=================== Close Function End ====================//
		
	//=================== Clear Function Begin ======================//
	
			function clear(clearopen) {
				self.confirm_title = clearopen;
				self.confirm_type = BootstrapDialog.TYPE_WARNING;
				self.confirm_msg = self.confirm_title + ' the data?';
				self.confirm_btnclass  =  'btn-warning';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type,self.confirm_msg, self.confirm_btnclass)
					.then(
								function (res) {
									self.save = "saveclose";
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
								pagination();
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
			                        self.message = vehicle.vehicle_regno+" vehicle reg no created..!";
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
				
				} else if ($("#vehicle_type_value").val() == "" || $("#vehicle_type_value").val() == null) {
							$("#vehicle_type_value").focus();
						
				} else {
					
					if( self.vehicle.vehicle_id == null) {
						
				
						
						self.confirm_title = 'Save';
						self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
						self.confirm_msg = self.confirm_title + ' ' + self.vehicle.vehicle_regno + ' vehicle reg no?';
						self.confirm_btnclass = 'btn-success';
						
						ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
							.then(
									function (res) {
										
										self.vehicle.branchModel = JSON.parse($("#branch_id").val());
										
										self.vehicle.vehicle_type = $("#vehicle_type_value").val();
										console.log(self.vehicle);
										createVehicle(self.vehicle);										
										reset();
										window.setTimeout( function(){
											newOrClose();
										},5000);
										
									}
							     );
						
					} else {
						
						self.confirm_title = 'Update';
						self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
						self.confirm_msg = self.confirm_title + ' ' + self.vehicle.vehicle_regno+ ' vehicle reg no?';
						self.confirm_btnclass = 'btn-success';
		    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
		    				.then(
		    						function (res) {
		    							self.vehicle.branchModel = JSON.parse($("#branch_id").val());
		    							self.vehicle.vehicle_type = $("#vehicle_type_value").val();
		    							editVehicle(self.vehicle);
		    						/*	reset();*/
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
							self.message = vehicle.vehicle_regno + " vehicle reg no updated..!";
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
				$scope.nameWrong = false;
				self.UpdateNotCheckVehicleRegNo = self.vehicle.vehicle_regno;
				self.heading = self.vehicle.vehicle_regno;
				$('#branch_id').val(JSON.stringify(self.vehicle.branchModel));
				$('#branch_name_value').val(self.vehicle.branchModel.branch_name);
				$('#vehicle_type_value').val(self.vehicle.vehicle_type);
				drawerOpen('.drawer');
			}
			
	//=============== Update Vehicle Function End ==============================//
			
	//=============== Delete Vehicle Function Begin ==========================//
			
			function deleteVehicle() {
				
				self.confirm_title = 'Delete';
				self.confirm_type = BootstrapDialog.TYPE_DANGER;
				self.confirm_msg = self.confirm_title+ ' ' + self.vehicle.vehicle_regno + ' vehicle reg no?';
				self.confirm_btnclass = 'btn-danger';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							VehicleService.deleteVehicle(self.vehicle.vehicle_id)
							.then(
									function (vehicle) {
										self.message = vehicle.vehicle_regno+ " vehicle reg no Deleted..!";
										successAnimate('.success');
										newOrClose();
										var index=self.vehicle.indexOf(vehicle);
										self.vehicles.splice(index,1);
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
			
		    function empSelectall() {
				self.selected_employee=[];
				
				for(var i = 0; i < $scope.pageSize; i++) {
					self.Filteremployees[i].select = $scope.selectall;
					if($scope.selectall){
						self.selected_employee.push(self.Filteremployees[i]);
					}
				}	
		    }
		    
			
			function vehicSelectall(){
				self.selected_vehicle=[];
				
				for(var i = 0; i < $scope.pageSize; i++) {
					self.Filtervehicles[i].select = $scope.selectall;
					if($scope.selectall){
						self.selected_vehicle.push(self.Filtervehicles[i]);
					}
				}
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
			
	//=============== Show no of Record Begin =============//
			function shownoofRecord() {
				$scope.pageSize = $scope.shownoofrec;
				
				self.Filtervehicles = self.vehicles.slice($scope.currentPage*$scope.pageSize);
				
				if(self.Filtervehicles.length < $scope.pageSize) {
					$scope.nextDisabled = true;
					$scope.previousDisabled = true;
				}
			}
			
	//============== Show no of Record End ================//
			
	//============= Register Search Begin =================//
			
			function registerSearch(searchkey) {
				if(searchkey.length == 0 ) {
					self.Filtervehicles = self.vehicles;
				} else if (searchkey.length > 3) {
					VehicleService.registerSearch(searchkey)
						.then(
								function(filterVehicle) {
									self.Filtervehicles = filterVehicle;
								},
								function (errResponse) {
									console.log('Error while fetching services');
								}
						      );
				} else {
					
					self.Filtervehicles = _.filter(self.vehicles, function(item){
						return searchUtil(item,searchkey);
					});
				}
					
				}
			
			function searchUtil(item,toSearch)
			{
				var success = false;
				
				if( ( item.vehicle_regno.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.vehicle_code.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 )
						|| (item.branchModel.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
						|| (item.vehicle_modelno.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
						|| (item.vehicle_type.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)) {
					success = true;
				 	
				} else {
					success = false;
				}
				return success;
			}
			
	//=============== Register Search End ================//
			
	//============== Record Count Begin ====================//
	
			function findrecord_count() {
				VehicleService.findrecord_count()
					.then(
								function (record_count) {
								
									$scope.totalnoof_records = record_count;
								},
								function (errResponse) {
									console.log('Error while fetching record count');
								}
					      );
			}
			
	//============== Record Count End ======================//
			
			
	//============== Pagination Function Begin ===========//
	
			function pagination() {
				$scope.pageSize = $scope.shownoofrec;
				console.log($scope.pageSize);
				$scope.currentPage = 0;
				$scope.totalPages = 0;
				self.Filtervehicles = self.vehicles;
				
				$scope.nextDisabled = false;
				$scope.previousDisabled = true;
				
				if(self.Filtervehicles.length <= 10 ) {
					$scope.nextDisabled = true;
				}
				
				if(self.Filtervehicles.length < 100) {
					$scope.totalnoof_records = self.Filtervehicles.length;
					console.log($scope.totalnoof_records);
				} else {
					findrecord_count();
				}
			}
			
			
			$scope.paginate = function(nextPrevMultiplier) {
				
				$scope.currentPage += (nextPrevMultiplier * 1);
				console.log($scope.currentPage);
				self.Filtervehicles = self.vehicles.slice($scope.currentPage*$scope.pageSize);
				
				
				
				if(self.Filtervehicles.length == 0) {
					VehicleService.pagination_byPage($scope.currentPage)
					.then(
							function (filterVervice) {
								
								if(filterService.length == 0 ) {
									$scope.nextDisabled = true;
								} else if (filterVehicle.length < 10 ) {
									self.Filtervehicles = filterVehicle;
								} else {
									self.Filtervehicles = filterVehicle;
								}
							},
							function (errResponse) {
								console.log('Error while pagination');
							}
					      );
				}
				
				if(self.Filtervehicles.length < $scope.pageSize) {
					$scope.nextDisabled = true;
				}
				
				console.log(nextPrevMultiplier);
				if($scope.currentPage == 0 ) {
					$scope.previousDisabled = true;
				}
				if(nextPrevMultiplier == -1) {
					$scope.nextDisabled = false;
				} else {
					$scope.previousDisabled =false;
				}
			}
			
			
			
			
			
			
			
			
			
$scope.firstlastPaginate = function (page) {
				
				
				if(page == 1) {
					$scope.currentPage = 0;
					$scope.previousDisabled = true;
					$scope.nextDisabled = false;
					self.Filtervehicles = self.vehicles.slice($scope.currentPage*$scope.pageSize);
					fetchAllVehicles();
				} else {
					$scope.currentPage = ( (Math.ceil(self.Filtervehicles.length/$scope.pageSize)) - 1 );
					console.log($scope.currentPage);
					$scope.previousDisabled = false;
					$scope.nextDisabled = true;
					
					self.Filtervehicles = self.vehicles.slice($scope.currentPage*$scope.pageSize);
					
					if(self.Filtervehicles.length == 0) {
						VehicleService.pagination_byPage(page)
						.then(
								function (filterVehicle) {
									self.Filtervehicles = filterVehicle;
								},
								function (errResponse) {
									console.log("Error while fetching services");
								}
						      );
					}
				}
				
				
			
			}
			
			
			
    //============== Pagination Function End =============//
			
}]);